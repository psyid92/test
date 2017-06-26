package com.sp.bbs;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("bbs.boardController")
public class BoardController {
	@Autowired
	private BoardService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;

	@RequestMapping(value="/bbs/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model,
			HttpServletRequest req
			) throws Exception {
		
   	    String cp = req.getContextPath();
   	    
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);

        // 글 리스트
        List<Board> list = service.listBoard(map);

        // 리스트의 번호
        int listNum, n = 0;
        Iterator<Board> it=list.iterator();
        while(it.hasNext()) {
            Board data = it.next();
            listNum = dataCount - (start + n - 1);
            data.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/bbs/list";
        String articleUrl = cp+"/bbs/article?page=" + current_page;
        if(searchValue.length()!=0) {
        	query = "searchKey=" +searchKey + 
        	         "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/bbs/list?" + query;
        	articleUrl = cp+"/bbs/article?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("subMenu", "2");
        
        model.addAttribute("list", list);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);		
		
		return ".four.menu2.bbs.list";
	}
	
	@RequestMapping(value="/bbs/created", method=RequestMethod.GET)
	public String createdForm(
			Model model,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("subMenu", "2");
		
		model.addAttribute("mode", "created");
		
		return ".four.menu2.bbs.created";
	}
	
	@RequestMapping(value="/bbs/created", method=RequestMethod.POST)
	public String createdSubmit(
			Board dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"bbs";
		
		dto.setUserId(info.getUserId());

		service.insertBoard(dto, pathname);
		
		return "redirect:/bbs/list";
	}
	
	@RequestMapping(value="/bbs/download")
	public void download(
			@RequestParam int num,
			HttpServletRequest req,
			HttpServletResponse resp,
			HttpSession session
			) throws Exception{
		String cp=req.getContextPath();
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			resp.sendRedirect(cp+"/member/login");
			return;
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"bbs";
		Board dto=service.readBoard(num);
		boolean flag=false;
		
		if(dto!=null) {
			flag=fileManager.doFileDownload(
					     dto.getSaveFilename(), 
					     dto.getOriginalFilename(), pathname, resp);
		}
		
		if(! flag) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out=resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");
		}
	}
	
	@RequestMapping(value="/bbs/article")
	public String article(
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		searchValue = URLDecoder.decode(searchValue, "utf-8");

		// 조회수 증가
		service.updateHitCount(num);

		// 해당 레코드 가져 오기
		Board dto = service.readBoard(num);
		if(dto==null)
			return "redirect:/bbs/list?page="+page;
		
		// 스마트에디터를 사용하므로 엔터를 <br>로 변경하지 않음
        // dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
        
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("num", num);

		Board preReadDto = service.preReadBoard(map);
		Board nextReadDto = service.nextReadBoard(map);
        
		// 게시물 공감 개수
		int countLikeBoard=service.countLikeBoard(num);
		
		String query = "page="+page;
		if(searchValue.length()!=0) {
			query += "&searchKey=" + searchKey + 
		                    "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		model.addAttribute("subMenu", "2");
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("countLikeBoard", countLikeBoard);

		model.addAttribute("page", page);
		model.addAttribute("query", query);

        return ".four.menu2.bbs.article";
	}
	
	// 게시물 공감 추가
	@RequestMapping(value="/bbs/insertLikeBoard", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertLikeBoard(
			Board dto, HttpSession session) throws Exception {
	
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		String state="true";
		
		if(info==null) {
			state="loginFail";
		} else {
			dto.setUserId(info.getUserId());
			int result=service.insertLikeBoard(dto);
			if(result==0)
				state="false";
   	    }
   	    
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// 게시물 공감 개수
	@RequestMapping(value="/bbs/countLikeBoard", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countLikeBoard(
			@RequestParam(value="num") int num) throws Exception {
		
		String state="true";
		int countLikeBoard=service.countLikeBoard(num);
		
   	    Map<String, Object> model = new HashMap<>();
   	    model.put("state", state);
   	    model.put("countLikeBoard", countLikeBoard);
		
   	    // 작업 결과를 json으로 전송
   	    return model;
	}	
	
	@RequestMapping(value="/bbs/update", 
			method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			Model model,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		Board dto = service.readBoard(num);
		if(dto==null) {
			return "redirect:/bbs/list?page="+page;
		}
			
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/bbs/list?page="+page;
		}
		
		model.addAttribute("subMenu", "2");
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".four.menu2.bbs.created";
	}

	@RequestMapping(value="/bbs/update", 
			method=RequestMethod.POST)
	public String updateSubmit(
			Board dto, 
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "bbs";		
	
		// 수정 하기
		service.updateBoard(dto, pathname);		
		
		return "redirect:/bbs/list?page="+page;
	}
	
	@RequestMapping(value="/bbs/deleteFile", 
			method=RequestMethod.GET)
	public String deleteFile(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		Board dto = service.readBoard(num);
		if(dto==null) {
			return "redirect:/bbs/list?page="+page;
		}
			
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/bbs/list?page="+page;
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "bbs";		
		if(dto.getSaveFilename() != null && dto.getSaveFilename().length()!=0) {
			  fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			  
			  dto.setSaveFilename("");
			  dto.setOriginalFilename("");
			  service.updateBoard(dto, pathname);
       }
		
		return "redirect:/bbs/update?num="+num+"&page="+page;
	}
	
	@RequestMapping(value="/bbs/delete")
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		// 해당 레코드 가져 오기
		Board dto = service.readBoard(num);
		if(dto==null) {
			return "redirect:/bbs/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId()) && ! info.getUserId().equals("admin")) {
			return "redirect:/bbs/list?page="+page;
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "bbs";		
 	
		service.deleteBoard(num, dto.getSaveFilename(), pathname);
		
		return "redirect:/bbs/list?page="+page;
	}
	
	// 댓글 처리...................................
	// 댓글 리스트
	@RequestMapping(value="/bbs/listReply")
	public String listReply(
			@RequestParam(value="num") int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("num", num);
		
		dataCount=service.replyDataCount(map);
		total_page=myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		// 리스트에 출력할 데이터
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		map.put("start", start);
		map.put("end", end);
		List<Reply> listReply=service.listReply(map);
		
		// 엔터를 <br>
		Iterator<Reply> it=listReply.iterator();
		int listNum, n=0;
		while(it.hasNext()) {
			Reply dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			n++;
		}
		
		// 페이징처리(인수2개 짜리 js로 처리)
		String paging=myUtil.paging(current_page, total_page);
		
		// jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "menu2/bbs/listReply";
	}

	// 댓글별 답글 리스트
	@RequestMapping(value="/bbs/listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int answer,
			Model model
			) throws Exception {
		
		List<Reply> listReplyAnswer=service.listReplyAnswer(answer);
		
		// 엔터를 <br>
		Iterator<Reply> it=listReplyAnswer.iterator();
		while(it.hasNext()) {
			Reply dto=it.next();
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// jsp로 넘길 데이터
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		return "menu2/bbs/listReplyAnswer";
	}
	
	// 댓글별 답글 개수
	@RequestMapping(value="/bbs/replyCountAnswer",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCountAnswer(
			@RequestParam int answer
			) throws Exception {
		
		int count=0;
		
		count=service.replyCountAnswer(answer);
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("count", count);
		return model;
	}
	
	// 댓글 및 리플별 답글 추가
	@RequestMapping(value="/bbs/createdReply",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdReply(
			Reply dto,
			HttpSession session) throws Exception {
	
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		if(info==null) { // 로그인이 되지 않는 경우
			state="loginFail";
		} else {
			dto.setUserId(info.getUserId());
			int result=service.insertReply(dto);
			if(result==0)
				state="false";
		}
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// 댓글 및 댓글별답글 삭제
	@RequestMapping(value="/bbs/deleteReply",
			method=RequestMethod.POST)
	@ResponseBody	
	public Map<String, Object> deleteReply(
			@RequestParam int replyNum,
			@RequestParam String mode,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		if(info==null) { // 로그인이 되지 않는 경우
			state="loginFail";
		} else {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("mode", mode);
			map.put("replyNum", replyNum);
			map.put("userId", info.getUserId());

			// 좋아요/싫어요 는 ON DELETE CASCADE 로 자동 삭제

            // 댓글삭제
			int result=service.deleteReply(map);

			if(result==0)
				state="false";
		}
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// 좋아요/싫어요 추가
	@RequestMapping(value="/bbs/replyLike",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyLike(
			  Reply dto,
			  HttpSession session) throws Exception {
	
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		if(info==null) { // 로그인이 되지 않는 경우
			state="loginFail";
		} else {
			dto.setUserId(info.getUserId());
			int result=service.insertReplyLike(dto);
			if(result==0)
				state="false";
		}
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// 좋아요/싫어요 개수
	@RequestMapping(value="/bbs/countLike",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countLike(
			@RequestParam int replyNum) throws Exception {
		
		int likeCount=0, disLikeCount=0;
		Map<String, Object> map=service.replyCountLike(replyNum);
		if(map!=null) {
			// resultType이 map인 경우 int는 BigDecimal로 넘어옴
			likeCount=((BigDecimal)map.get("LIKECOUNT")).intValue();
			disLikeCount=((BigDecimal)map.get("DISLIKECOUNT")).intValue();
		}
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("likeCount", likeCount);
		model.put("disLikeCount", disLikeCount);
		return model;
	}
}
