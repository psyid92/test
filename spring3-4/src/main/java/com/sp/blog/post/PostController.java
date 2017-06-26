package com.sp.blog.post;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.blog.BlogInfo;
import com.sp.blog.BlogService;
import com.sp.common.FileManager;
import com.sp.common.MyUtilGeneral;
import com.sp.member.SessionInfo;

@Controller("post.postController")
public class PostController {
	@Autowired
	private BlogService blogService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private MyUtilGeneral util;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/blog/{blogSeq}")
	public String main(
			@PathVariable long blogSeq,
			@RequestParam(value="num", defaultValue="0") int num,
			@RequestParam(value="categoryNum", defaultValue="0") int categoryNum,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="rows", defaultValue="5") int rows,
			@RequestParam(value="menu", defaultValue="0") int menu,
			@RequestParam(value="listClosed", defaultValue="0") int listClosed,
			Model model,
			HttpServletRequest req,
			HttpServletResponse resp,
			HttpSession session
			) throws Exception {
		
		// 개인 블로그 메인
		String cp=req.getContextPath();
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		BlogInfo blogInfo=blogService.readBlogInfoHome(blogSeq);
		if(blogInfo==null) {
			return "redirect:/nblog";
		}
		
		int owner=1;
		if(info==null|| ! info.getUserId().equals(blogInfo.getUserId()))
			owner=0;
		
		Map<String, Object> map=new HashMap<>();
		String tableName="b_"+blogSeq;
		map.put("tableName", tableName);
		map.put("categoryNum", categoryNum);
		map.put("owner", owner);
		
		// ---------------------------------------------------------
		// 선택한 카테고리
		Category category=categoryService.readCategory(map);
		
		// 비공개 게시판인 경우
		if(category!=null && category.getClosed()==1 && owner==0) {
			model.addAttribute("menu", menu);
			model.addAttribute("blogInfo", blogInfo);
			model.addAttribute("blogUrl", cp+"/blog/"+blogSeq);
			model.addAttribute("categoryNum", categoryNum);
			model.addAttribute("rows", rows);
			model.addAttribute("listClosed", listClosed);
			model.addAttribute("owner", owner);
			model.addAttribute("dataCount", 0);
			return ".blogPostLayout";
		}
		
		String classify="전체보기";
		if(category!=null)
			classify=category.getClassify();
		
		// ---------------------------------------------------------
		// 리스트
		int total_page = 0;
		int dataCount = 0;
        dataCount = boardService.dataCount(map);
        if(dataCount != 0)
            total_page = util.pageCount(rows,  dataCount) ;
        if(total_page < current_page) 
            current_page = total_page;
		
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);
        List<Board> list=boardService.listBoard(map);
        
		// ---------------------------------------------------------
        // 게시글 보기
        if(list.size()>0 && num==0) {
        	num=list.get(0).getNum();
        }
		map.put("num", num);
		
        // 블로그 방문자 수 및 포스트 조회수 증가
		try {
			boolean bBlog=false, bBoard=false;
			
			Cookie []cks=req.getCookies();
			for(Cookie c:cks) {
				if(c.getName().startsWith("num")) {
					int n=Integer.parseInt(c.getValue());
					if(num==n) {
						bBoard=true;
					}
				} else if(c.getName().startsWith("blogSeq")) {
					bBlog=true;
				}
			}
			
			if(! bBlog) {
				// 블로그 방문자 수 증가
				blogService.updateBlogVisitorCount(blogSeq);
				
				Cookie ck=new Cookie("blogSeq", Long.toString(blogSeq));
				ck.setMaxAge(-1);
				resp.addCookie(ck);
			}

			if(! bBoard) {
				// 포스트 조회수 증가
				boardService.updateHitCount(map);
				
				Cookie ck=new Cookie("num"+num, Integer.toString(num));
				ck.setMaxAge(-1);
				resp.addCookie(ck);
			}
			
		} catch (Exception e) {
		}
		
		// 게시글
		Board dto = boardService.readBoard(map);
        // 이전글/다음글
		Board preReadDto = boardService.preReadBoard(map);
		Board nextReadDto = boardService.nextReadBoard(map);
		
		// 파일
		List<Board> listFile=boardService.listFile(map);

		// 댓글 갯수
		int replyCount=boardService.replyDataCount(map);
		
		// ---------------------------------------------------------		
        String query = "categoryNum="+categoryNum+"&rows="+rows+"&menu="+menu;
        String listUrl = cp+"/blog/"+blogSeq+"?"+query;
		
        String paging = util.paging(current_page, total_page, listUrl);
		// ---------------------------------------------------------        
		model.addAttribute("menu", menu);
		model.addAttribute("blogInfo", blogInfo);
		model.addAttribute("blogUrl", cp+"/blog/"+blogSeq);
		model.addAttribute("classify", classify);
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("rows", rows);
		model.addAttribute("listClosed", listClosed);
		model.addAttribute("owner", owner);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("query", query);
		
		return ".blogPostLayout";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postInsert", method=RequestMethod.GET)
	public String postInsertForm(
			@PathVariable long blogSeq,
			Model model,
			HttpSession session) throws Exception {
		// AJAX(TEXT)-포스트 글쓰기 폼
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if (info == null) {
			model.addAttribute("state", "loginFail");
			return "blog/post/error";
		}

		Map<String, Object> map1=new HashMap<>();
		map1.put("field", "b.userId");
		map1.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map1);
		if(blogInfo==null) {
			model.addAttribute("state", "blogFail");
			return "blog/post/error";
		}
		
		String tableName="b_"+blogSeq;
		Map<String, Object> map2=new HashMap<>();
		map2.put("tableName", tableName);
		List<Category> listCategory=categoryService.listCategoryAll(map2);
		
		model.addAttribute("mode", "created");
		model.addAttribute("blogSeq", blogSeq);
		model.addAttribute("listCategory",listCategory);
		
		return "blog/post/postCreated";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/profile")
	public String profile(
			@PathVariable long blogSeq,
			Model model) throws Exception {
		// AJAX(TEXT) - 프로필
		BlogInfo blogInfo=blogService.readBlogInfoProfile(blogSeq);

		model.addAttribute("blogInfo", blogInfo);
		return "blog/post/profile";
	}

	@RequestMapping(value="/blog/{blogSeq}/prologue")
	public String prologue(
			@PathVariable long blogSeq,
			Model model) throws Exception {
		// AJAX(TEXT) - 프롤로그
		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.blogSeq");
		map.put("field_value", blogSeq);
		
		BlogInfo blogInfo=blogService.readBlogInfo(map);

		model.addAttribute("blogInfo", blogInfo);
		return "blog/post/prologue";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postInsert", method=RequestMethod.POST)
	public String postInsertSubmit(
			@PathVariable long blogSeq,
			Board dto,
			HttpSession session) throws Exception {
		// 포스트 글 저장
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		if(blogInfo==null) {
			return "redirect:/blog/"+blogSeq;
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();
		
		String tableName="b_"+blogSeq;
		dto.setTableName(tableName);
		boardService.insertBoard(dto, pathname);
		
		return "redirect:/blog/"+blogSeq;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postUpdate", method=RequestMethod.GET)
	public String postUpdateForm(
			@PathVariable long blogSeq,
			@RequestParam(value="num") int num,
			@RequestParam(value="categoryNum") int categoryNum,
			@RequestParam(value="page") String page,
			@RequestParam(value="menu") int menu,
			Model model,
			HttpSession session) throws Exception {
		// AJAX(TEXT)-포스트 수정 폼
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			model.addAttribute("state", "loginFail");
			return "blog/post/error";
		}

		Map<String, Object> map1=new HashMap<>();
		map1.put("field", "b.userId");
		map1.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map1);
		if(blogInfo==null) {
			model.addAttribute("state", "blogFail");
			return "blog/post/error";
		}
		
		String tableName="b_"+blogSeq;
		Map<String, Object> map2=new HashMap<>();
		map2.put("tableName", tableName);
		List<Category> listCategory=categoryService.listCategoryAll(map2);
		
		map2.put("num", num);
		Board dto = boardService.readBoard(map2);
		if(dto==null) {
			model.addAttribute("state", "postFail");
			return "blog/post/error";
		}
		
		List<Board> listFile=boardService.listFile(map2);
		
		model.addAttribute("blogSeq", blogSeq);
		model.addAttribute("listCategory",listCategory);
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("page", page);		
		model.addAttribute("menu", menu);
		
		return "blog/post/postCreated";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postUpdate", method=RequestMethod.POST)
	public String postUpdateSubmit(
			@PathVariable long blogSeq,
			Board dto,
			@RequestParam(value="category") int categoryNum,
			@RequestParam(value="page") String page,
			@RequestParam(value="menu") int menu,
			HttpSession session) throws Exception {
		// 포스트 글 수정
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		if(blogInfo==null) {
			return "redirect:/blog/"+blogSeq+"&categoryNum="+categoryNum;
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();
		
		String tableName="b_"+blogSeq;
		dto.setTableName(tableName);
		boardService.updateBoard(dto, pathname);
		
		return "redirect:/blog/"+blogSeq+"?num="+dto.getNum()+"&categoryNum="+categoryNum+"&menu="+menu+"&page="+page;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postDelete")
	public String postDelete(
			@PathVariable long blogSeq,
			@RequestParam(value="num") int num,
			@RequestParam(value="categoryNum") int categoryNum,
			@RequestParam(value="page") String page,
			@RequestParam(value="menu") int menu,
			HttpSession session) throws Exception {
		// 포스트 글 삭제
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}
		
		Map<String, Object> map1=new HashMap<>();
		map1.put("field", "b.userId");
		map1.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map1);
		if(blogInfo==null) {
			return "redirect:/blog/"+blogSeq+"&categoryNum="+categoryNum;
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();
		
		String tableName="b_"+blogSeq;
		Map<String, Object> map2=new HashMap<>();
		map2.put("tableName", tableName);
		map2.put("field", "num");
		map2.put("num", num);
		
		boardService.deleteBoard(map2, pathname);
		
		return "redirect:/blog/"+blogSeq+"?categoryNum="+categoryNum+"&menu="+menu+"&page="+page;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postDeleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@PathVariable long blogSeq,
			@RequestParam int fileNum,
			HttpSession session) throws Exception {
		// AJAX(JSON) - 포스트 수정에서 파일 삭제
		
		Map<String, Object> model = new HashMap<>(); 
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			model.put("state", "loginFail");
		} else {
		
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();
			
			String tableName="b_"+blogSeq;
			Map<String, Object> map=new HashMap<>();
			map.put("tableName", tableName);
			map.put("fileNum", fileNum);
			
			Board dto=boardService.readFile(map);
			if(dto!=null) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			}
			
			map.put("field", "fileNum");
			map.put("num", fileNum);
			boardService.deleteFile(map);
			
	   	    // 작업 결과를 json으로 전송
			model.put("state", "true");
		}
		
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/download")
	public void download(
			@PathVariable long blogSeq,
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		 // 파일 다운로드
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();
		
		boolean b=false;
		if(info!=null) {
			String tableName="b_"+blogSeq;
			Map<String, Object> map=new HashMap<>();
			map.put("tableName", tableName);
			map.put("fileNum", fileNum);
			
			Board dto = boardService.readFile(map);
			if(dto!=null) {
				String saveFilename = dto.getSaveFilename();
				String originalFilename = dto.getOriginalFilename();
				
				b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
			}
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	// 댓글 처리 ----------------------------------------------
	@RequestMapping(value="/blog/{blogSeq}/postListReply")
	public String listReply(
			@PathVariable long blogSeq,
			@RequestParam(value="num") int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		// AJAX(TEXT) - 댓글 리스트 
		
		int numPerPage=5;
		int total_page=0;
		int replyCount=0;
		
		String tableName="b_"+blogSeq;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("num", num);
		
		replyCount=boardService.replyDataCount(map);
		total_page=util.pageCount(numPerPage, replyCount);
		if(current_page>total_page)
			current_page=total_page;
		
		// 리스트에 출력할 데이터
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		List<Reply> listReply=boardService.listReply(map);
		
		// 엔터를 <br>
		Iterator<Reply> it=listReply.iterator();
		int listNum, n=0;
		while(it.hasNext()) {
			Reply dto=it.next();
			listNum=replyCount-(start+n-1);
			dto.setListNum(listNum);
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			n++;
		}
		
		// 페이징처리(인수2개 짜리 js로 처리)
		String paging=util.paging(current_page, total_page);
		
		// jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("blogSeq", blogSeq);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "blog/post/postListReply";
	}

	@RequestMapping(value="/blog/{blogSeq}/postListReplyAnswer")
	public String listReplyAnswer(
			@PathVariable long blogSeq,
			@RequestParam(value="answer") int answer,
			Model model) throws Exception {
		// AJAX(TEXT) - 댓글별 답글 리스트

   	    String tableName="b_"+blogSeq;
   	    Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("answer", answer);
		
		List<Reply> listReplyAnswer=boardService.listReplyAnswer(map);
		
		// 엔터를 <br>
		Iterator<Reply> it=listReplyAnswer.iterator();
		while(it.hasNext()) {
			Reply dto=it.next();
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// jsp로 넘길 데이터
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		return "blog/post/postListReplyAnswer";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postReplyCount",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> postReplyCount(
			@PathVariable long blogSeq,
			@RequestParam(value="num") int num) throws Exception {
		// AJAX(JSON) - 댓글별 개수

		String state="true";
		int count=0;

		String tableName="b_"+blogSeq;
        Map<String, Object> map=new HashMap<String, Object>();
 		map.put("tableName", tableName);
   		map.put("num", num);
  	    
   	    count=boardService.replyDataCount(map);
   	    
   	    Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("count", count);
		
		return model;
	}

	@RequestMapping(value="/blog/{blogSeq}/postReplyCountAnswer",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCountAnswer(
			@PathVariable long blogSeq,
			@RequestParam(value="answer") int answer) throws Exception {
		// AJAX(JSON) - 댓글별 답글 개수

		String state="true";
		int count=0;

		String tableName="b_"+blogSeq;
        Map<String, Object> map=new HashMap<String, Object>();
 		map.put("tableName", tableName);
   		map.put("answer", answer);
  	    
   	    count=boardService.replyCountAnswer(map);
   	    
   	    Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("count", count);
		
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postCreatedReply",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdReply(
			@PathVariable long blogSeq,
			Reply dto,
			HttpSession session) throws Exception {
		// AJAX(JSON) - 댓글 및 리플별 답글 추가
	
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		if(info==null) { // 로그인이 되지 않는 경우
			state="loginFail";
   	   } else {
   		   	String tableName="b_"+blogSeq;
   		   	dto.setTableName(tableName);
   		   	dto.setUserId(info.getUserId());
   		   	int result=boardService.insertReply(dto);
   		   	if(result==0)
   		   		state="false";
   	   }
		
   	   Map<String, Object> model = new HashMap<>(); 
   	   model.put("state", state);
   	   return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postDeleteReply",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@PathVariable long blogSeq,
			@RequestParam int replyNum,
			@RequestParam String mode,
			HttpSession session) throws Exception {
		// AJAX(JSON) - 댓글 및 댓글별답글 삭제
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		if(info==null) { // 로그인이 되지 않는 경우
			state="loginFail";
		} else {
			String tableName="b_"+blogSeq;
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", tableName);
			map.put("mode", mode);
			map.put("replyNum", replyNum);
	
			// 좋아요/싫어요 는 ON DELETE CASCADE 로 자동 삭제
			// 댓글삭제
			int result=boardService.deleteReply(map);
	
			if(result==0)
				state="false";
		}
   	    
		// 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postReplyLike",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyLike(
			@PathVariable long blogSeq,
			Reply dto,
			HttpSession session) throws Exception {
		// AJAX(JSON) - 좋아요/싫어요 추가
	
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		if(info==null) { // 로그인이 되지 않는 경우
			state="loginFail";
		} else {
			String tableName="b_"+blogSeq;
			dto.setTableName(tableName);
			dto.setUserId(info.getUserId());
			int result=boardService.insertReplyLike(dto);
			if(result==0)
				state="false";
		}
   	    
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/postCountLike",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countLike(
			@PathVariable long blogSeq,
			@RequestParam int replyNum) throws Exception {
		// AJAX(JSON) - 좋아요/싫어요 개수
		
		String state="true";
		int likeCount=0, disLikeCount=0;
		
		String tableName="b_"+blogSeq;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("replyNum", replyNum);

		Map<String, Object> result=boardService.replyCountLike(map);
		if(result!=null) {
			// resultType이 map인 경우 int는 BigDecimal로 넘어옴
			likeCount=((BigDecimal)result.get("LIKECOUNT")).intValue();
			disLikeCount=((BigDecimal)result.get("DISLIKECOUNT")).intValue();
		}
		
   	    Map<String, Object> model = new HashMap<>();
   	    model.put("state", state);
   	    model.put("likeCount", likeCount);
   	    model.put("disLikeCount", disLikeCount);
		
   	    return model;
	}
}
