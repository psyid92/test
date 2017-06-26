package com.sp.blog.guest;

import java.util.HashMap;
import java.util.Iterator;
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

@Controller("blog.guest.guestController")
public class GuestController {
	@Autowired
	private GuestService service;
	@Autowired
	private BlogService blogService;
	@Autowired
	private MyUtilGeneral util;
	
	@RequestMapping(value="/blog/{blogSeq}/guest")
	public String guest(
			@PathVariable long blogSeq,
			Model model) throws Exception {

		model.addAttribute("blogSeq",blogSeq);
		return "blog/guest/guest";
	}
	
	@RequestMapping(value="/blog/{blogSeq}/guestList")
	@ResponseBody
	public Map<String, Object> list(
			@PathVariable long blogSeq,
		    @RequestParam(value="pageNo", defaultValue="1") int current_page,
		    HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		BlogInfo blogInfo=blogService.readBlogInfoHome(blogSeq);
		
		int owner=0;
		if(info!=null && info.getUserId().equals(blogInfo.getUserId()))
			owner=1;
		
		String tableName="b_"+blogSeq;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", tableName);
		
		int rows=5;
		int dataCount=service.dataCount(map);
		int total_page=util.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Guest> list=service.listGuest(map);
		Iterator<Guest> it=list.iterator();
		while(it.hasNext()) {
			Guest dto=it.next();
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// 인수 2개짜리
		String paging = util.paging(current_page, total_page);
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		if(info==null)
			model.put("isLogin", "false");
		else
			model.put("isLogin", "true");
	
		model.put("blogSeq", blogSeq);
		model.put("total_page", total_page);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		model.put("paging", paging);
		// 게시물 리스트
		model.put("list", list);
		
		model.put("owner", owner);
		
		return model;
	}
	
	@RequestMapping(value="/blog/{blogSeq}/guestCreated", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			@PathVariable long blogSeq,
			Guest dto,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			// 로그인 상태가 아닌것을 json으로 전송
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		String tableName="b_"+blogSeq;
		dto.setTableName(tableName);
		dto.setBlogSeq(blogSeq);
		// 글을 쓴사람
		dto.setUserId(info.getUserId());
		
		service.insertGuest(dto);
		
		return list(blogSeq, 1, session);
	}
	
	@RequestMapping(value="/blog/{blogSeq}/guestDelete",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> guestDelete(
			@PathVariable long blogSeq,
			@RequestParam(value="num") int num,
			@RequestParam(value="pageNo") int pageNo,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
	   	    // 로그인 상태가 아닌것을 json으로 전송
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		String tableName="b_"+blogSeq;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("num", num);
		
		service.deleteGuest(map);
		
		return list(blogSeq, 1, session);
	}
}
