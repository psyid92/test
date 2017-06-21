package com.sp.menu;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("menu.menuController")
public class MenuController {
	
	@RequestMapping("/menu")
	public String goMenu(){
		return "menu/bodybody";
	}

}
