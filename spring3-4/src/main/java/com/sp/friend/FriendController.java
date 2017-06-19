package com.sp.friend;

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

import com.sp.member.SessionInfo;

@Controller("friend.friendController")
public class FriendController {
	@Autowired
	private FriendService service;
	
	// -------------------------------------------------------
	@RequestMapping(value="/friend/friend")
	public String friend(
			Model model,
			HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("subMenu", "4");
		return ".four.menu5.friend.friend";
	}
	
	// -------------------------------------------------------
	@RequestMapping(value="/friend/list")
	public String list(
			Model model,
			HttpSession session) {
		// 친구 목록
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "menu5/friend/loginFail";
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		// 등록된 친구 리스트
		map.put("userId", info.getUserId());
		map.put("state", "1");
		List<Friend> friendList = service.friendList(map);
			
		// 요청받은 친구리스트
		map.put("userId", info.getUserId());
		map.put("state", "0");
		List<Friend> friendAskedList = service.friendAskedList(map);
		
		model.addAttribute("friendList", friendList);
		model.addAttribute("friendAskedList", friendAskedList);
		return "menu5/friend/list";
	}

	// -------------------------------------------------------
	@RequestMapping(value="/friend/add", method=RequestMethod.GET)
	public String addForm(
			Model model,
			HttpSession session) throws Exception {
		// 친구 추가 폼
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "menu5/friend/loginFail";
		}
		
		// 요청한친구리스트
		List<Friend> friendAskList = service.friendAskList(info.getUserId());
		
		model.addAttribute("friendAskList", friendAskList);
		return "menu5/friend/add";
	}

	@RequestMapping(value="/friend/add", method=RequestMethod.POST)
	public String addSubmit(
			Friend friend,
			Model model,
			HttpSession session) throws Exception {
		// 친구요청저장
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if (info == null) {
			return "menu5/friend/loginFail";
		}
		
		friend.setUserId(info.getUserId());
		service.insertFriend(friend);
		
		// 요청한 친구 리스트
		List<Friend> friendAskList = service.friendAskList(info.getUserId());
		
		model.addAttribute("friendAskList", friendAskList);
		return "menu5/friend/askList";
	}
	
	@RequestMapping(value="/friend/searchList", method=RequestMethod.POST)
	public String searchList(
			@RequestParam(value="searchKey",defaultValue="userId") String searchKey,
			@RequestParam(value="searchValue",defaultValue="") String searchValue,
			Model model,
			HttpSession session
			) throws Exception {
		// 친구추가 - 친구검색(추가할경우)
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if (info == null) {
			return "menu5/friend/loginFail";
		}

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		// 검색 리스트
		List<Friend> friendSearchList = service.friendSearchList(map);
		
		model.addAttribute("friendSearchList", friendSearchList);
		return "menu5/friend/searchList";
	}
	
	@RequestMapping(value="/friend/askDelete", method=RequestMethod.POST)
	public String askDelete(
			   @RequestParam int num,
			   Model model,
			   HttpSession session
			   ) throws Exception {
		// 요청한 친구 삭제
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if (info == null) {
			return "menu5/friend/loginFail";
		}
		
		service.deleteFriend(num);
			
		// 요청한 친구 리스트
		List<Friend> friendAskList = service.friendAskList(info.getUserId());
			
		model.addAttribute("friendAskList", friendAskList);
		return "menu5/friend/askList";
	}
	
	// -------------------------------------------------------
	@RequestMapping(value="/friend/block")
	public String friendBlock(
			Model model,
			HttpSession session) {
		// 차단 관리
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "menu5/friend/loginFail";
		}
		
		// 차단한 친구 리스트
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		map.put("state", "3");
		List<Friend> friendBlockList = service.friendList(map);

		// 요청한 친구중 거절한 친구 리스트
		map.put("userId", info.getUserId());
		map.put("state", "2");
		List<Friend> friendDenialList = service.friendAskedList(map);
		
		model.addAttribute("friendBlockList", friendBlockList);
		model.addAttribute("friendDenialList", friendDenialList);
		return "menu5/friend/block";
	}
	
	@RequestMapping(value="/friend/friendBlock", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> friendBlock(
			              Friend friend,
			              HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		
		if(friend.getMode().equals("blockDelete")) {
			// 친구관리-차단친구삭제
			int result=0;
			if(friend.getNumList() != null)
			    result=service.deleteFriendList(friend.getNumList());
			
			String state="false";
			if(result>=1)
				state="true";
			
			model.put("state", state);
			
		} else if(friend.getMode().equals("blockAccept")) {
			// 친구관리-차단친구수락
			int result=0;
			if(friend.getNumList() != null) {
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("state", "1");
				map.put("numList", friend.getNumList());
				
				result=service.updateFriendList(map);
			}
			
			String state="false";
			if(result>=1)
				state="true";
			
			model.put("state", state);
			
		} else if(friend.getMode().equals("denialAccept")) {
			// 친구관리-요청거절친구수락
			int result=0;
			if(friend.getNumList() != null) {
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("state", "1");
				map.put("numList", friend.getNumList());
				
				result=service.updateFriendList(map);
				
			    // 친구 추가
			    for(String s:friend.getUserIdList()) {
			    	Friend dto=new Friend();
			    	dto.setUserId(info.getUserId());
			    	dto.setState("1");
			    	dto.setFriendUserId(s);
			    	service.insertFriend(dto);
			    }
			}
			
			String state="false";
			if(result>=1)
				state="true";
			
			model.put("state", state);
		}
		
		return model;
	}
	
	// -------------------------------------------------------
	@RequestMapping(value="/friend/friendManage", method=RequestMethod.POST)
	public String friendAdmin(
			         Friend friend,
			         Model model,
			         HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if (info == null) {
			return "menu5/friend/loginFail";
		}
		
		if(friend.getMode().equals("delete")) {
			// 친구목록-삭제
			if(friend.getNumList() != null)
			    service.deleteFriendList(friend.getNumList());
			
			// 등록된 친구 리스트
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userId", info.getUserId());
			map.put("state", "1");
			List<Friend> friendList = service.friendList(map);
			
			model.addAttribute("friendList", friendList);
			return "menu5/friend/friendList";
			
		} else if(friend.getMode().equals("block")) {
			// 친구목록-차단
			if(friend.getNumList() != null) {
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("state", "3");
				map.put("numList", friend.getNumList());
			    service.updateFriendList(map);
			}
			
			// 등록된 친구 리스트
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userId", info.getUserId());
			map.put("state", "1");
			List<Friend> friendList = service.friendList(map);
			
			model.addAttribute("friendList", friendList);
			return "menu5/friend/friendList";
			
		} else if(friend.getMode().equals("asked")) {
			// 친구목록-수락
			if(friend.getNumList() != null) {
				// 요청했던 친구들을 수락으로 변경
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("state", "1");
				map.put("numList", friend.getNumList());
				
				service.updateFriendList(map);
				
			    // 친구 추가
			    for(String s:friend.getUserIdList()) {
			    	Friend dto=new Friend();
			    	dto.setUserId(info.getUserId());
			    	dto.setState("1");
			    	dto.setFriendUserId(s);
			    	service.insertFriend(dto);
			    }
			}
			
			// 등록된 친구 리스트
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userId", info.getUserId());
			map.put("state", "1");
			List<Friend> friendList = service.friendList(map);
			
			model.addAttribute("friendList", friendList);
			return "menu5/friend/friendList";
			
		} else if(friend.getMode().equals("denial")) {
			// 친구목록-거절
			if(friend.getNumList() != null) {
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("state", "2");
				map.put("numList", friend.getNumList());
			    service.updateFriendList(map);
			}
			
			// 요청받은 친구 리스트
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userId", info.getUserId());
			map.put("state", "0");
			List<Friend> friendAskedList = service.friendAskedList(map);

			model.addAttribute("friendAskedList", friendAskedList);
			
			return "menu5/friend/friendAskedList";
			
		}
		
		return "menu5/friend/friendList";
	}
}
