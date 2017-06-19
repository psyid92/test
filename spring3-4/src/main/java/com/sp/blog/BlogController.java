package com.sp.blog;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtilGeneral;
import com.sp.member.SessionInfo;

@Controller("blog.blogController")
public class BlogController {
	@Autowired
	private BlogService blogService;
	
	@Autowired
	private MyUtilGeneral util;

	@RequestMapping(value="/nblog")
	public String main(
			@RequestParam(value="theme", defaultValue="0") int themeNum,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="search", defaultValue="") String search,
			@RequestParam(value="idx", defaultValue="0") int menu,
			Model model,
			HttpServletRequest req) throws Exception {
		// 블로그 메인, 블로그 리스트
		
		String cp = req.getContextPath();

		int rows = 10;
		int total_page = 0;
		int dataCount = 0;

		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			search = URLDecoder.decode(search, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("search", search);
		map.put("user", "general"); // "general": 일반 사용자, "admin":관리자
		map.put("themeNum", themeNum);

		dataCount = blogService.dataCountBlog(map);
		if (dataCount != 0)
			total_page = util.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<BlogInfo> listBlog=blogService.listBlog(map);
		
		String query = "";
		if (themeNum != 0) {
			query = "theme=" + themeNum + "&";
		}
		query += "idx=" + menu;
		if(search.length()!=0)
			query+="&search="+URLEncoder.encode(search, "UTF-8");

		String listUrl = cp + "/nblog?" + query;

		String paging=util.paging(current_page, total_page, listUrl);

		model.addAttribute("menu", menu);
		model.addAttribute("listBlog", listBlog);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return ".blog.main.blogList";
	}

	@RequestMapping(value="/nblog/created", method = RequestMethod.GET)
	public String blogCreatedForm(
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		// 블로그 만들기 폼
		
		if (info == null) {
			return "redirect:/member/login";
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		if(blogInfo!=null) {
			model.addAttribute("message", "블로그는 계정당 하나만 만들수 있습니다.");
			return ".blog.manage.message";
		}
		
		List<BlogTheme> listGroup=blogService.listBlogThemeGroup();

		BlogInfo dto = new BlogInfo();
		dto.setIsUserName(1);
		dto.setGender("남자");
		dto.setClosed(0);
		dto.setIsCity(1);
		dto.setIsGender(1);
		dto.setIsHobby(1);

		model.addAttribute("mode", "created");
		model.addAttribute("dto", dto);
		model.addAttribute("listGroup", listGroup);
		
		return ".blog.manage.blogCreated";
	}

	@RequestMapping(value="/nblog/themeList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> themeList(@RequestParam int groupNum) throws Exception {
		// AJAX(JSON)-블로그 생성 및 수정할 때 그룹별 주제(중분류)
		
		List<BlogTheme> listTheme = blogService.listBlogTheme(groupNum);

		Map<String, Object> model = new HashMap<>();
		model.put("listTheme", listTheme);

		return model;
	}

	@RequestMapping(value="/nblog/me")
	public String blogMe(
			HttpSession session) throws Exception {
		// 내블로그
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		
		// 블로그가 없으면 생성
		if(blogInfo==null)
			return "redirect:/nblog/created";
		
		// 내 블로그로 이동
		return "redirect:/blog/"+blogInfo.getBlogSeq();
	}
	
	@RequestMapping(value="/nblog/created", method = RequestMethod.POST)
	public String blogCreatedSubmit(
			BlogInfo dto,
			Model model,
			HttpSession session) throws Exception {
		// 내 블로그 등록 완료
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+
				File.separator+info.getUserId();

		dto.setUserId(info.getUserId());
		int result=blogService.insertBlog(dto, pathname);
		if(result==0) {
			model.addAttribute("message", "블로그를 생성하지 못했습니다. 다시 시도 하시기 바랍니다.");
			return ".blog.manage.message";
		}

		return "redirect:/blog/"+dto.getBlogSeq();
	}
}
