package com.sp.chat;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.member.SessionInfo;

@Controller("chat.chatController")
public class ChatController {
	@RequestMapping(value="/chat/main")
	public String main(
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("subMenu", "5");
		
		return ".four.menu2.chat.chat";
	}
}
