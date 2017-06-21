package com.sp.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("main.mainController")
public class MainController {
	
	@RequestMapping("/main")
	public String goMain(){
		return "main/usermain";
	}
	

}
