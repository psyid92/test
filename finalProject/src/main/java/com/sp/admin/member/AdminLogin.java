package com.sp.admin.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("adminLoginController")
public class AdminLogin {
	
	@RequestMapping("/admin/login")
	public String adminLoginForm(){
		return ".admin.admin.login";
	}
	
}
