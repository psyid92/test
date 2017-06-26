package com.sp.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	// 클라이언트 요청이 컨트롤러에 도착하기 전
	// false를 리턴하면 컨트롤러를 실행하지 않고 요청 종료
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean result = false;
		
		try {
			HttpSession session = request.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			String cp = request.getContextPath();
			String uri = request.getRequestURI();
			
			if (info == null) {
				if (isAjaxRequest(request)) {
					response.sendError(403);
					return false;
				} 
				if (uri.indexOf(cp) == 0)
					uri = uri.substring(cp.length());
				
				// 세션에 요청 주소를 저장
				session.setAttribute("preLoginURI", uri);
				
				response.sendRedirect(cp + "/member/login");
			} else {
				result = true;
			}
			
		} catch (Exception e) {
			logger.info("pre => " + e.toString());
		}
		
		return result;
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
		String h = req.getHeader("AJAX");
		
		return h != null && h.equals("true");
	}
	
	// 컨트롤러 요청 처리 후 (예외가 발생해도 실행)
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

	// 컨트롤러 요청 처리 후 (예외가 발생하면 실행하지 않음)
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
	
	
	
}
