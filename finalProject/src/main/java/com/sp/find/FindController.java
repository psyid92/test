package com.sp.find;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("find.findController")
public class FindController {
	
	@RequestMapping("/find")
	public String goFind(){
		return "find/find";
	}

	
}
