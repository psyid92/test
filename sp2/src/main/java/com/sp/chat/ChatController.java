package com.sp.chat;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.member.SessionInfo;

@Controller("chat.chatController")
public class ChatController {
	
	@RequestMapping("/chat/main")
	public String chat(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
				
		if (info == null) {
			return "redirect:/member/login";
		}
		return ".chat.main";
	}
}
