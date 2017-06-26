package com.sp.blog.post;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.sp.blog.BlogTheme;
import com.sp.member.SessionInfo;

@Controller("post.manageController")
public class ManageController {
	@Autowired
	private BlogService blogService;
	@Autowired
	private CategoryService categoryService;

	@RequestMapping(value="/blog/{blogSeq}/manage")
	public String blogManage(
			@PathVariable long blogSeq,
			Model model,
			HttpServletRequest req,
			HttpSession session
			) throws Exception {
		// 블로그 관리
		
		String cp=req.getContextPath();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		if(blogInfo==null) {
			return "redirect:/nblog";
		}		
		
		model.addAttribute("blogInfo", blogInfo);
		model.addAttribute("blogUrl", cp+"/blog/"+blogSeq);

		return ".blogPost.manage.manage.main";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/updateBlog", method=RequestMethod.GET)
	public String updateBlog(
			@PathVariable long blogSeq,
			Model model,
			HttpSession session
			) throws Exception {
		// AJAX(TEXT)-내 블로그 수정 폼
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			model.addAttribute("state", "loginFail");
			return "blog/manage/error";
		}

		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		if(blogInfo==null) {
			model.addAttribute("state", "blogFail");
			return "blog/manage/error";
		}
		
		List<BlogTheme> listGroup=blogService.listBlogThemeGroup();
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", blogInfo);
		model.addAttribute("listGroup", listGroup);
		return "blog/manage/blogUpdate";
	}	
	
	@RequestMapping(value="/blog/{blogSeq}/updateBlog", method = RequestMethod.POST)
	public String blogUpdateSubmit( 
			@PathVariable long blogSeq,
			BlogInfo dto,
			HttpSession session) throws Exception {
		// 내 블로그 수정 완료
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();
		
		blogService.updateBlog(dto, pathname);

		return "redirect:/blog/"+blogSeq+"/manage";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/deleteImageBlog", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteImageBlog( 
			@PathVariable long blogSeq,
			@RequestParam String filename,
			@RequestParam String userId,
			HttpSession session) throws Exception {
		// AJAX(JSON)-내 블로그 사진 삭제
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state="false";
		if (info == null) {
			state="loginFail";
		} else if(! info.getUserId().equals(userId)) {
			state="noBlog";
		} else {
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();
			blogService.deleteImage(blogSeq, pathname, filename);
			state="true";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/deleteBlog")
	public String blogDelete(
			@PathVariable long blogSeq,
			HttpSession session) throws Exception {
		// 내 블로그 삭제
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.blogSeq");
		map.put("field_value", blogSeq);
		BlogInfo dto=blogService.readBlogInfo(map);
		if(dto==null || ! dto.getUserId().equals(info.getUserId())) {
			return "redirect:/nblog";
		}		
		if(dto==null|| ! dto.getUserId().equals(info.getUserId())) {
			return "redirect:/nblog";
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();
		
		blogService.deleteBlog(blogSeq, pathname);

		return "redirect:/nblog";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/manageBoard")
	public String blogMenageBoard(
			@PathVariable long blogSeq,
			Model model,
			HttpSession session
			) throws Exception {
		// AJAX(TEXT)-내 블로그 게시판 관리
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if (info == null) {
			model.addAttribute("state", "loginFail");
			return "blog/manage/error";
		}

		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		if(blogInfo==null) {
			model.addAttribute("state", "blogFail");
			return "blog/manage/error";
		}
		
		List<BlogTheme> listTheme=blogService.listBlogThemeAll();
		
		model.addAttribute("blogSeq", blogSeq);
		model.addAttribute("blogInfo", blogInfo);
		model.addAttribute("listTheme", listTheme);
		
		return "blog/manage/manageBoard";
	}	

	@RequestMapping(value="/blog/{blogSeq}/categoryAllList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> categoryAllList(
			@PathVariable long blogSeq,
			@RequestParam(value="bid", defaultValue="") String blogId,
			HttpSession session) throws Exception {
		// AJAX(JSON)-내 블로그 카테고리 가져오기

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		int owner=1;
		if(info==null|| ! info.getUserId().equals(blogId))
			owner=0;
		System.out.println(owner);
		String tableName="b_"+blogSeq;
		Map<String, Object> map=new HashMap<>();
		map.put("tableName", tableName);
		map.put("owner", owner);
		
		List<Category> listCategory=categoryService.listCategoryAll(map);

		Map<String, Object> model = new HashMap<>();
		model.put("listCategory", listCategory);
		model.put("count", listCategory.size()-1);
		return model;
	}

	@RequestMapping(value="/blog/{blogSeq}/categoryAdd", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> categoryAdd(
			@PathVariable long blogSeq,
			Category dto,
			HttpSession session) throws Exception {
		// AJAX(JSON)-카테고리 저장하기
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state="true";
		if (info == null) {
			state="loginFail";
		} else {
			Map<String, Object> map=new HashMap<>();
			map.put("field", "b.userId");
			map.put("field_value", info.getUserId());
			BlogInfo blogInfo=blogService.readBlogInfo(map);
			if(blogInfo==null) {
				state="addFail";
			} else {
				String tableName="b_"+blogSeq;
				dto.setTableName(tableName);
				int result=categoryService.insertCategory(dto);
				
				if(result==0)
					state="false";
			}
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/categoryRead", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> categoryRead(
			@PathVariable long blogSeq,
			@RequestParam(value="categoryNum") int categoryNum,
			HttpSession session)throws Exception {
		// AJAX(JSON)-카테고리 가져오기
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String tableName="b_"+blogSeq;
		Map<String, Object> map=new HashMap<>();
		map.put("tableName", tableName);
		map.put("categoryNum", categoryNum);
		
		Map<String, Object> model = new HashMap<>();
		
		String state="true";
		if (info == null) {
			state="loginFail";
		} else {
			Category category=categoryService.readCategory(map);
			if(category!=null)
				model.put("category", category);
			else
				state="false";
		}
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/categoryUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> categoryUpdate(
			@PathVariable long blogSeq,
			Category dto,
			HttpSession session)throws Exception {
		// AJAX(JSON)-카테고리 수정 완료
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String tableName="b_"+blogSeq;
		String state="true";
		if(info==null) {
			state="loginFail";
		} else {
			dto.setTableName(tableName);
			int result=categoryService.updateCategory(dto);
			if(result==0)
				state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/blog/{blogSeq}/categoryDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> categoryDelete(
			@PathVariable long blogSeq,
			@RequestParam(value="categoryNum") int categoryNum,
			HttpSession session)throws Exception {
		// AJAX(JSON)-카테고리 삭제
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String tableName="b_"+blogSeq;
		String state="true";
		if(info==null) {
			state="loginFail";
		} else {
			Map<String, Object> map=new HashMap<>();
			map.put("tableName", tableName);
			map.put("categoryNum", categoryNum);
			int result=categoryService.deleteCategory(map);
			if(result==0)
				state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
}
