package com.sp.blog.photo;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.sp.common.MyUtilGeneral;
import com.sp.member.SessionInfo;

@Controller("blog.photo.photoController")
public class PhotoController {
	@Autowired
	private BlogService blogService;
	@Autowired
	private PhotoService photoService;
	@Autowired
	private MyUtilGeneral util;
	
	@RequestMapping(value="/blog/{blogSeq}/photo", method=RequestMethod.POST)
	public String photo(
			@PathVariable long blogSeq,
			@RequestParam(value="owner", defaultValue="0") int owner,
			@RequestParam(value="bid", defaultValue="") String bid,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model
			) throws Exception {
		// 포토 메인 - 리스트
		
		int rows = 8;
		int total_page;
		int dataCount;
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tableName", "b_"+blogSeq);
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);

		dataCount = photoService.dataCount(map);
		total_page = util.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;

		map.put("start", start);
		map.put("end", end);

		List<Photo> list = photoService.listPhoto(map);
		
		model.addAttribute("blogSeq",blogSeq);
		model.addAttribute("owner",owner);
		model.addAttribute("bid",bid);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("paging", util.pagingMethod(current_page, total_page, "listPagePhoto"));
		
		return "blog/photo/photo";
	}

	@RequestMapping(value="/blog/{blogSeq}/photoCreated", method=RequestMethod.GET)
	public String photoCreatedForm(
			@PathVariable long blogSeq,
			@RequestParam(value="owner") int owner,
			@RequestParam(value="bid") String bid,
			Model model,
			HttpSession session
			) throws Exception {
		
		// AJAX(TEXT) - 포토 등록 폼 
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info==null) {
			model.addAttribute("state", "loginFail");
			return "blog/photo/error";
		} else if(! info.getUserId().equals(bid)) {
			model.addAttribute("state", "blogFail");
			return "blog/photo/error";
		}
		
		model.addAttribute("blogSeq",blogSeq);
		model.addAttribute("mode","created");
		return "blog/photo/created";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/photoCreated", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> photoCreatedSubmit(
			@PathVariable long blogSeq,
			Photo dto,
			HttpSession session) throws Exception {
		// AJAX(JSON) - 포토 등록 

		Map<String, Object> model = new HashMap<>(); 
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			model.put("state", "loginFail");
			return model;
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		if(blogInfo==null || ! info.getUserId().equals(blogInfo.getUserId())) {
			model.put("state", "blogFail");
			return model;
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();

		dto.setBlogSeq(blogSeq);
		dto.setTableName("b_"+blogSeq);
		photoService.insertPhoto(dto, pathname);
		model.put("state", "true");
		
		return model;
	}

	@RequestMapping(value="/blog/{blogSeq}/photoArticle")
	public String photoArticle(
			@PathVariable long blogSeq,
			@RequestParam(value="num") int num,
			@RequestParam(value="owner") int owner,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model,
			HttpSession session
			) throws Exception {
		// AJAX(TEXT) - 포토 보기

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tableName", "b_"+blogSeq);
        map.put("num", num);
		
        Photo dto=photoService.readPhoto(map);
        if(dto==null) {
        	model.addAttribute("state", "articleFail");
        	return "blog/photo/error";
        }
		
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);
                
        Photo preReadDto=photoService.preReadPhoto(map);
        Photo nextReadDto=photoService.nextReadPhoto(map);
        
		model.addAttribute("blogSeq",blogSeq);
		model.addAttribute("owner",owner);

		model.addAttribute("dto",dto);
		model.addAttribute("preReadDto",preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		
		return "blog/photo/article";
	}

	@RequestMapping(value="/blog/{blogSeq}/photoUpdate", method=RequestMethod.GET)
	public String photoUpdateForm(
			@PathVariable long blogSeq,
			@RequestParam(value="num") int num,
			@RequestParam(value="owner") int owner,
			@RequestParam(value="bid") String bid,
			Model model,
			HttpSession session
			) throws Exception {
		
		// AJAX(TEXT) - 포토 수정 폼 
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			model.addAttribute("state", "loginFail");
			return "blog/photo/error";
		} else if(! info.getUserId().equals(bid)) {
			model.addAttribute("state", "blogFail");
			return "blog/photo/error";
		}
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tableName", "b_"+blogSeq);
        map.put("num", num);
		
        Photo dto=photoService.readPhoto(map);
        if(dto==null) {
        	model.addAttribute("state", "articleFail");
        	return "blog/photo/error";
        }
		
		model.addAttribute("blogSeq",blogSeq);
		model.addAttribute("mode","update");
		model.addAttribute("dto",dto);
		return "blog/photo/created";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/photoUpdate", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> photoUpdateSubmit(
			@PathVariable long blogSeq,
			Photo dto,
			HttpSession session) throws Exception {
		// AJAX(JSON) - 포토 수정 

		Map<String, Object> model = new HashMap<>(); 
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			model.put("state", "loginFail");
			return model;
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("field", "b.userId");
		map.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map);
		if(blogInfo==null || ! info.getUserId().equals(blogInfo.getUserId())) {
			model.put("state", "blogFail");
			return model;
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();

		dto.setBlogSeq(blogSeq);
		dto.setTableName("b_"+blogSeq);
		photoService.updatePhoto(dto, pathname);
		model.put("state", "true");
		
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/photoDelete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> photoDelete(
			@PathVariable long blogSeq,
			@RequestParam int num,
			@RequestParam String imageFilename,
			HttpSession session) throws Exception {
		// AJAX(JSON) - 포토 삭제 

		Map<String, Object> model = new HashMap<>(); 
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if (info == null) {
			model.put("state", "loginFail");
			return model;
		}
		
		Map<String, Object> map1=new HashMap<>();
		map1.put("field", "b.userId");
		map1.put("field_value", info.getUserId());
		BlogInfo blogInfo=blogService.readBlogInfo(map1);
		if(blogInfo==null || ! info.getUserId().equals(blogInfo.getUserId())) {
			model.put("state", "blogFail");
			return model;
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"blog"+File.separator+info.getUserId();

		Map<String, Object> map2=new HashMap<>();
		map2.put("tableName", "b_"+blogSeq);
		map2.put("num", num);
		
		photoService.deletePhoto(map2, imageFilename, pathname);
		
		model.put("state", "true");
		
		return model;
	}
}
