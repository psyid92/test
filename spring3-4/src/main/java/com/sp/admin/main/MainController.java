package com.sp.admin.main;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("admin.mainController")
public class MainController {
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String method(HttpSession session, Model model) {
	
		model.addAttribute("mainMenu", "0");
		return ".adminLayout";
	}
}
