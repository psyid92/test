package com.sp.forUser;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("forUser.forUserController")
public class ForUserController {

	@RequestMapping("/forUser")
	public String goNotice(){
		return "forUser/notice";
	}
}
