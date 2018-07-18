package com.audiovisualcenter.servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class InitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/*@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		initSpringConfig(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		initSpringConfig(req, resp);
	}*/
	/*private void initSpringConfig(HttpServletRequest req, HttpServletResponse resp){
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(req.getServletContext());
		req.getServletContext().setAttribute("springContext", context);
	}*/
	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(sc);
		sc.setAttribute("springContext", context);
	}
}
