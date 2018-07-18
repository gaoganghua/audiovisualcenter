package com.audiovisualcenter.action;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.model.User;
import com.audiovisualcenter.service.UserService;
import com.audiovisualcenter.util.JsonUtil;
import com.audiovisualcenter.util.StringUtil;
import com.common.util.SearchObject;
import com.common.util.SearchUtil;

public class LoadDataAction extends CommonAction<Object>{
	private static final long serialVersionUID = 1L;
	private String month;//月份
	private String provice;//省份
	private String password;//密码

	
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getProvice() {
		return provice;
	}
	public void setProvice(String provice) {
		this.provice = provice;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return super.execute();
	}
	//加载时间
	public String loadDay(){
//		System.out.println(getMonth());
		Properties p = new Properties();
		String path = "/WEB-INF/conf/properties/time.properties";
		InputStream is = ServletActionContext.getServletContext().getResourceAsStream(path);
		try {
			p.load(is);
			String days = p.getProperty(getMonth());
//			setJsondata(JsonUtil.ajax(true,null, Integer.parseInt(days)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "loadday";
	}
	//加载城市
	public String loadCity(){
		Properties p = new Properties();
		String path = "/WEB-INF/conf/properties/city.properties";
		InputStream is = ServletActionContext.getServletContext().getResourceAsStream(path);
		try {
			p.load(is);
			List<String> citys = new ArrayList<String>();
			String[] values = p.getProperty(getProvice()).split(",");
			for(String value:values){
				citys.add(value);
			}
//			setJsondata(JsonUtil.ajax(true, null,citys));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "loadcity";
	}
	//加载省份
	public String loadProvice(){
		Properties p = new Properties();
		String path = "/WEB-INF/conf/properties/city.properties";
		InputStream is = ServletActionContext.getServletContext().getResourceAsStream(path);
		try {
			p.load(is);
			List<String> provices = new ArrayList<String>();
			for(Object key:p.keySet()){
				provices.add(key.toString());
			}
//			setJsondata(JsonUtil.ajax(true, null,provices));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "loadprovice";
	}
	//查询密码
	public String loadPassword(){
		User loginUser = (User) getSession().get(LOGIN_USER);
		
		ServletContext servletContext = ServletActionContext.getServletContext();
		UserService userService = DatabaseFactory.getUserService(servletContext);
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "loginName", loginUser.getLoginName()));
		
		String msg = null;
		List<User> users = userService.findListByParams(params);
		if(users!=null && users.size()>0){
			User u = users.get(0);
			if(u.getLoginPassword().equals(StringUtil.encrypt(getPassword()))){
				setJsondata(JsonUtil.ajax(true, null));
			}else{
				setJsondata(JsonUtil.ajax(false, "密码错误"));
			}
		}else{
			setJsondata(JsonUtil.ajax(false, "没有该用户"));
		}
		return "loadpassword";
	}
}
