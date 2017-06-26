package com.sp.admin.member;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("admin.member.memberController")
public class MemberController {
	@RequestMapping(value="/admin/member/list")
	public String list(Model model) throws Exception {
		model.addAttribute("mainMenu", "1");
		model.addAttribute("subMenu", "1");
		return ".admin4.menu1.member.list";
	}
}
