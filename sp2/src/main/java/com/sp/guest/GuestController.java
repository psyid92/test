package com.sp.guest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("guest.guestController")
public class GuestController {
	@Autowired
	private GuestService service;

	@Autowired
	private MyUtil myUtil;

	@RequestMapping("/guest/guest")
	public String guest() throws Exception {
		return ".guest.guest";
	}

	@RequestMapping(value = "/guest/insert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertGuest(Guest dto, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		if (info == null) {
			state = "loginFail";
		} else {
			dto.setUserId(info.getUserId());
			service.insertGuest(dto);
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping("/guest/list")
	@ResponseBody
	public Map<String, Object> listGuest(@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		if (info == null) 
			state = "loginFail";
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		Map<String, Object> map = new HashMap<>();

		dataCount = service.dataCount();
		if (dataCount != 0)
			total_page = myUtil.pageCount(rows, dataCount);

		if (current_page > total_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<Guest> list = service.listGuest(map);

		String paging = myUtil.paging(current_page, total_page);


		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("list", list);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		model.put("total_page", total_page);
		model.put("paging", paging);
		return model;
	}
	
	@RequestMapping(value="/guest/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteGuest(
			@RequestParam int num, HttpSession session
			) throws Exception {
		String state = "true";
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			state = "loginFail";
		} else {
			Map<String, Object> map = new HashMap<>();
			map.put("userId", info.getUserId());
			map.put("num", num);
			service.deleteGuest(map);
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
}
