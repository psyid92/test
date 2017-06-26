package com.sp.note;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("note.noteController")
public class NoteController {
	@Autowired
	private NoteService service;
	@Autowired
	private MyUtil myUtil;
	
	// 쪽지 메인화면
	@RequestMapping(value="/note/note")
	public String note(
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("subMenu", "5");
		
		return ".four.menu5.note.note";
	}

	// 받은 쪽지 리스트 / 보낸 쪽지 리스트 - 초기 폼 
	@RequestMapping(value="/note/list")
	public String list(
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "menu5/note/loginFail";
		}
		
		if(searchKey.length()==0) {
			searchKey="sendUserName";
			if(mode.equals("send"))
				searchKey="receiveUserName";
		}

		model.addAttribute("mode", mode);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		return "menu5/note/list";
	}
	
	// 받은 쪽지 리스트 / 보낸 쪽지 리스트
	@RequestMapping(value="/note/listNote")
	@ResponseBody
	public Map<String, Object> listNote(
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1")int current_page,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpSession session
			) throws Exception {
		// 보낸 쪽지 리스트
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}

		int rows=10;
		int total_page=0;
		int dataCount=0;
		
		// 전체 게시물의 수
       Map<String, Object> map = new HashMap<String, Object>();
       map.put("searchKey", searchKey);
       map.put("searchValue", searchValue);
       map.put("userId", info.getUserId());
       
       if(mode.equals("listReceive")) {
    	   dataCount=service.dataCountReceive(map);
       } else {
    	   dataCount=service.dataCountSend(map);
       }
		
		// 전체페이지수
		total_page=myUtil.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		// 리스트
		int start=rows*(current_page-1)+1;
		int end=rows*current_page;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Note> list=null;
        if(mode.equals("listReceive")) {
        	list=service.listReceive(map);
        } else {
	    	list=service.listSend(map);
        }
        for(Note dto:list) {
        	if(dto.getIdentifyDay()==null)
        		dto.setIdentifyDay("");
        }
        
		String paging=myUtil.paging(current_page, total_page);
		
		// 작업 결과를 JSON으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		
		model.put("mode", mode);
		model.put("list", list);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		model.put("paging", paging);
		model.put("searchKey", searchKey);
		model.put("searchValue", searchValue);
		
		return model;
	}

	// 쪽지 보내기 폼
	@RequestMapping(value="/note/send", method=RequestMethod.GET)
	public String send(
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "menu5/note/loginFail";
		}
		
		return "menu5/note/send";
	}
	
	// 쪽지 보내기
	@RequestMapping(value="/note/send", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sendSubmit(
			Note dto,
			HttpSession session) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		String state="false";
		try {
			for(String userId : dto.getUserIds()) {
				dto.setSendUserId(info.getUserId());
				dto.setReceiveUserId(userId);
			
				service.insertNode(dto);
			}
			state="true";
		}catch(Exception e) {
		}
		
		// 작업 결과를 JSON으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("state", state);
		return model;
	}
	
	// 친구 리스트
	@RequestMapping(value="/note/listFriend")
	public String listFriend(
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if (info == null) {
			return "menu5/friend/loginFail";
		}
		
		List<Note> list=service.listFriend(info.getUserId());
		
		model.addAttribute("listFriend", list);
		return "menu5/note/listFriend";
	}

	// 리스트에서 선택된 쪽지 지우기
	@RequestMapping(value="/note/noteDeleteChk", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> noteDeleteChk(
			Note note,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1")int current_page,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpSession session) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		if(mode.equals("listReceive")) {
			map.put("field1", "receiveDelete");
			map.put("field2", "sendDelete");
		} else {
			map.put("field1", "sendDelete");
			map.put("field2", "receiveDelete");
		}
		map.put("numList", note.getNums());
		
		service.deleteNote(map);
		
		return listNote(mode, current_page, searchKey, searchValue, session);
	}
	
	// 받은 쪽지 / 보낸 쪽지 - 글보기 
	@RequestMapping(value="/note/article", method=RequestMethod.POST)
	public String article(
			@RequestParam(value="num") int num,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1") String pageNo,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "menu5/note/loginFail";
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
	    map.put("searchKey", searchKey);
	    map.put("searchValue", searchValue);
	    map.put("userId", info.getUserId());
	    map.put("num", num);
		
		Note dto=null;
		Note replyDto=null;
		Note preDto=null;
		Note nextDto=null;
		if(mode.equals("listSend")) { // 보낸 쪽지 보기
			dto=service.readSend(num);
			replyDto=service.readReplyReceive(num);
			preDto=service.preReadSend(map);
			nextDto=service.nextReadSend(map);
		} else {// 받은 쪽지 보기(listReceive)
			// 확인 상태로 변경
			service.updateIdentifyDay(num);
			dto=service.readReceive(num);
			replyDto=service.readReplyReceive(num);
			preDto=service.preReadReceive(map);
			nextDto=service.nextReadReceive(map);
		}

		if(dto==null) {
			int current_page = Integer.parseInt(pageNo);
			return list(mode, current_page, searchKey, searchValue, model, session);
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		model.addAttribute("dto", dto);
		model.addAttribute("replyDto", replyDto);
		model.addAttribute("preDto", preDto);
		model.addAttribute("nextDto", nextDto);
		
		model.addAttribute("mode", mode);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		return "menu5/note/article";
	}

	// 쪽지 보기에서 답변을 확인 한 경우 읽은 상태로 만들기
	@RequestMapping(value="/note/updateIdentify", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateIdentify(
			int num,
			HttpSession session) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		service.updateIdentifyDay(num);
		
		// 작업 결과를 JSON으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("state", "true");
		return model;
	}
	
	// 글보기에서 - 받은 쪽지 / 보낸 쪽지 - 글삭제
	@RequestMapping(value="/note/delete", method=RequestMethod.POST)
	public String delete(
			Note dto,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1") String pageNo,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return "menu5/note/loginFail";
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		if(mode.equals("listReceive")) {
			map.put("field1", "receiveDelete");
			map.put("field2", "sendDelete");
		} else {
			map.put("field1", "sendDelete");
			map.put("field2", "receiveDelete");
		}
		
		map.put("numList", dto.getNums());
		
		service.deleteNote(map);
		
		int current_page = Integer.parseInt(pageNo);
		return list(mode, current_page, searchKey, searchValue, model, session);
	}
}
