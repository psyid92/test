package com.sp.main;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("mainController")
public class MainController {
	 
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String method() {
		return ".mainLayout";
	}
	
	@RequestMapping(value="/main/info", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> info() throws Exception {
		
		Calendar cal = Calendar.getInstance();
		
		int hour = cal.get(Calendar.HOUR);
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		
		Map<String, Object> model = new HashMap<>();
		model.put("hour", hour);
		model.put("minute", minute);
		model.put("second", second);
		
		return model;
	}
}
