package com.quiz.bank.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginIntercepter extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("inter cepter 확인");
		
		boolean pass = false;
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginId") !=null) {
			pass = true;
		}else {
			pass = false;
			response.sendRedirect("./");
		}
		
		return pass;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView mav) throws Exception {
		// righter에서 조금만 바꿔서 사용하기
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("loginId");
		String content = id+" 님, 반갑습니다. <button onclick= \"loction.href='logout'\">logout</button>";
		mav.addObject("loginBox", content);

	}
	
	

}
