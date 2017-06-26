package com.sp.member;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("member.memberController")
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
	
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
	public String memberSignin(HttpServletRequest req, Model model) throws Exception{
		Member1 dto = new Member1();
		dto.setM1_email(req.getParameter("m1_email"));
		dto.setM1_pwd(req.getParameter("m1_pwd"));
		
		int result = dao.insertMember(dto); 
		
		return ".mainLayout";
	}
}
