package com.sp.random;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("random.randomController")
public class RandomController {
	
	@RequestMapping("/random")
	public String goRandom(){
		return "random/randomList";
	}

}
