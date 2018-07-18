package com.audiovisualcenter.action;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
import com.opensymphony.xwork2.ModelDriven;

public class LoginAction extends CommonAction implements ModelDriven<User>{
	private User user = new User();
	
	/*@Override
	public String execute() throws Exception {
		return "success";
	}*/
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	//检测用户名和密码
	public String check(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		UserService userService = DatabaseFactory.getUserService(servletContext);
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "loginName", user.getLoginName()));
//		params.add(SearchUtil.add(false, "loginPassword", user.getLoginPassword()));
		
		String msg = null;
		List<User> users = userService.findListByParams(params);
		if(users!=null && users.size()>0){
			User u = users.get(0);
			String password = StringUtil.encrypt(user.getLoginPassword());
//			System.out.println(password);
			if(u.getLoginPassword().equals(password)){
				setJsondata(JsonUtil.ajax(true, null));
			}else{
				msg="账号或密码错误";
				setJsondata(JsonUtil.ajax(false, msg));
			}
		}else{
			msg="账号或密码错误";
			setJsondata(JsonUtil.ajax(false, msg));
		}
//		String msg = null;
//		Properties p = new Properties();
//		String path = "/WEB-INF/conf/properties/parameter.properties";
//		try {
//			InputStream is = ServletActionContext.getServletContext().getResourceAsStream(path);
//			p.load(is);
//			String username = p.getProperty("username");
//			String password = p.getProperty("password");
//			if(username.equals(user.getLoginName()) && password.equals(user.getLoginPassword())){
//				setJsondata(JsonUtil.ajax(true, null));
//			}else{
//				msg="账号或密码错误";
//				setJsondata(JsonUtil.ajax(false, msg));
//			}
//		} catch (IOException e) {
//			msg="系统发生错误";
//			setJsondata(JsonUtil.ajax(false, msg));
//			e.printStackTrace();
//		}
		
		return "success";
	}
	//登陆
	public String loginIn(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		UserService userService = DatabaseFactory.getUserService(servletContext);
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "loginName", user.getLoginName()));
//		params.add(SearchUtil.add(false, "loginPassword", user.getLoginPassword()));
		
		String msg = null;
		List<User> users = userService.findListByParams(params);
		if(users!=null && users.size()>0){
			User u = users.get(0);
			String password = StringUtil.encrypt(user.getLoginPassword());
			if(u.getLoginPassword().equals(password)){
				getSession().put(LOGIN_USER, u);
				return "success";
			}
		}
		return "login";
	}
	//注册
	public String register(){
		try{
			/*UserService us = DatabaseFactory.getUserService(ServletActionContext.getServletContext());
			
			List<SearchObject> searchLists = new ArrayList<SearchObject>();
			searchLists.add(SearchUtil.add(false, "phone", user.getPhone(), "="));
			searchLists.add(SearchUtil.add(true, "email", user.getEmail(), "="));
			List<SearchObject> seaLists = new ArrayList<SearchObject>();
			seaLists.add(SearchUtil.add(false, searchLists));
			List<User> users = us.findUserListByParams(seaLists);
			String msg = null;
			if(users!=null && users.size()>0){
				msg = "此账号已被注册";
				setJsondata(JsonUtil.ajax(false, msg));
			}else{
				user.setStatus(1);
				user.setUserType(1);
//				us.save(user);
				if(user.getAddressProvice()!=null &&!("").equals(user.getAddressProvice())&&user.getAddressCity()!=null&&!("").equals(user.getAddressCity())){
					user.setAddress(user.getAddressProvice()+"-"+user.getAddressCity());
				}
				if(file!=null){
					String userphoto = FileUtil.uploadFile(file, fileFileName, fileContentType, "userphoto", -1, ServletActionContext.getServletContext());
					user.setPhoto(userphoto);
				}
				us.save(user);
				setJsondata(JsonUtil.ajax(true, msg));
			}*/
		}catch (Exception e) {
			setMessage("系统出现故障");
		}
		return "register";
	}
	//更改密码
	public String modifyLoginPassword(){
		User loginUser = (User) getSession().get(LOGIN_USER);
		
		if(getUser().getLoginPassword()!=null && !("").equals(getUser().getLoginPassword())){
			ServletContext servletContext = ServletActionContext.getServletContext();
			UserService userService = DatabaseFactory.getUserService(servletContext);
			
			List<SearchObject> params = new ArrayList<SearchObject>();
			params.add(SearchUtil.add(false, "loginName", loginUser.getLoginName()));
			
			String msg = null;
			List<User> users = userService.findListByParams(params);
			if(users!=null && users.size()>0){
				User u = users.get(0);
				String password = StringUtil.encrypt(user.getLoginPassword());
//				System.out.println(password);
				u.setLoginPassword(password);
				userService.update(u);
			}
			setJsondata(JsonUtil.ajax(true, "修改成功"));
		}else{
			setJsondata(JsonUtil.ajax(false, "请求超时"));
		}
		return "success";
	}
	//退出
	public String loginOut(){
		try{
			getSession().remove(LOGIN_USER);
		}catch (Exception e) {
			setMessage("系统出现故障");
		}
		return "success";
	}
	//获取验证码
	public String safecode(){
		/*String[] ss = StringUtil.getSafeCode();
		List<String> safecode = Arrays.asList(ss);
		ServletActionContext.getRequest().setAttribute("safecode", ss[1]);
		setJsondata(JsonUtil.ajax(true, null, safecode));*/
		
		return "safecode";
	}
	@Override
	public User getModel() {
		return this.user;
	}
}