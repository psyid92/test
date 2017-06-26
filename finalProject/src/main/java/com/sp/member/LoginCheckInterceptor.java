package com.sp.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{
	private final Logger logger = LoggerFactory.getLogger(getClass());

	//클라이언트 요청 처리 후
	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

	//클라이언트 요청이 도착하기 전
	//false를 리턴하면 컨트롤러를 실행하지 않고 요청 종료
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean result = false;
		
		try {
			HttpSession session = request.getSession();
//			SessionInfo info = (SessionInfo) session.getAttribute("member");
			String cp = request.getContextPath();
			String uri = request.getRequestURI();
			
/*			if(info==null){
				if(uri.indexOf(cp)==0){
					uri = uri.substring(cp.length());
					
					//새션에 요청 주소를 저장
					session.setAttribute("preLoginURI", uri);
					response.sendRedirect(cp + "/member/login");
				} else {
					result = true;
				}
			}*/
		} catch (Exception e) {
			logger.info("pre => " + e.toString());
		}
		
		return result;
	}

	//컨트롤러 요청 처리 후 )예외가 발생해도 실행
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
}
