package com.audiovisualcenter.interceptor;

import java.util.Map;
import java.util.Map.Entry;

import org.apache.struts2.dispatcher.Parameter;
import org.springframework.web.util.HtmlUtils;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class XssInterceptor extends AbstractInterceptor {
	
	private static final long serialVersionUID = -4431623951052007706L;

	@Override
	public String intercept(ActionInvocation arg0) throws Exception {
		ActionContext actionContext = arg0.getInvocationContext();
		Map<String, Parameter> map = actionContext.getParameters();
		for (Entry<String, Parameter> entry : map.entrySet()) {
			String value = HtmlUtils.htmlEscape(entry.getValue().getMultipleValues()[0]);
			entry.getValue().getMultipleValues()[0] = value;
		}
		return arg0.invoke();
	}

}
