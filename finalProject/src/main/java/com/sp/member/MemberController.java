package com.sp.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("member.memberController")
public class MemberController {
	
	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public String loginForm(){
		return "member/login";
	}
	
	@RequestMapping(value="/member/logout")
	public String logout(HttpServletRequest req){
		req.setAttribute("login", null);
		return ".mainLayout";
	}
	
	@RequestMapping(value="/member/login", method=RequestMethod.POST)
	public String loginSubmit(HttpServletRequest req){
		req.setAttribute("login", "login");
		return ".mainLayout";
	}
	
	@RequestMapping(value="/member/member", method=RequestMethod.GET)
	public String memberForm(){
		return "member/member";
	}
	
	@RequestMapping(value="/member/member", method=RequestMethod.POST)
	public String memberSignin(){
		return "mainLayout";
	}
}
