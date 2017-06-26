package com.sp.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("demo.demoController")
public class DemoController {
	@Autowired
	private DemoService service;
	
	@RequestMapping(value="/demo/write", method=RequestMethod.GET)
	public String writeForm() throws Exception {
		return "demo/write";
	}
	
	@RequestMapping(value="/demo/write", method=RequestMethod.POST)
	public String writeSubmit(Demo dto, Model model) throws Exception {
		String msg = "추가성공";
		try {
			service.insertDemo(dto);
		} catch (Exception e) {
			msg = "추가 실패";
		}
		
		model.addAttribute("result", msg);
		
		return "demo/result";
	}
}
