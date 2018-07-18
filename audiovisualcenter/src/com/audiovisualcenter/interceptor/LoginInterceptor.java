package com.audiovisualcenter.interceptor;


import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class LoginInterceptor implements Interceptor{
	private static final long serialVersionUID = 1L;
	private  final static String LOGIN = "login";

	@Override
	public String intercept(ActionInvocation action) throws Exception {
//		System.out.println(action.getAction());
		if(action.getAction().getClass() == com.audiovisualcenter.action.LoginAction.class){
			return action.invoke();
		}
		Map<String, Object> session = action.getInvocationContext().getSession();
		if(session.get("login_user")!=null)
			return action.invoke();
		else
			return LOGIN;
//		return action.invoke();
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init() {
		// TODO Auto-generated method stub
		
	}

}
