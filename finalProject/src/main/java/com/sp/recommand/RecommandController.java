package com.sp.recommand;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("recommand.recommandController")
public class RecommandController {

	@RequestMapping("/recommand")
	public String goRecommand(){
		return "recommand/recommand";
	}
	
}
