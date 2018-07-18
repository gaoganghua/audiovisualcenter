package com.audiovisualcenter.servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/*
 * 登录操作的过滤器
 */
public class LoginFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		String uri = req.getRequestURI();
		String endStr = ".jsp";
		if(uri.endsWith(endStr)){
			if(uri.endsWith("login.jsp")){
				chain.doFilter(req, resp);
			}else{
				HttpSession session = req.getSession();
				if(session.getAttribute("login_user")!=null){
					chain.doFilter(req, resp);
				}else{
					resp.sendRedirect("http://localhost:8080/audiovisualcenter/pages/login.jsp");
				}
			}
		}else{
			chain.doFilter(req, resp);
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
