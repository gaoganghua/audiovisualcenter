package com.audiovisualcenter.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.model.Module;
import com.audiovisualcenter.service.CommonService;

public class ModuleAction extends CommonAction {
	private Integer parent_idModule;
	private String statusModule;
	private Integer levelModule;
	private Integer pageId;//页面的id
	
	public Integer getParent_idModule() {
		return parent_idModule;
	}
	public void setParent_idModule(Integer parent_idModule) {
		this.parent_idModule = parent_idModule;
	}
	public String getStatusModule() {
		return statusModule;
	}
	public void setStatusModule(String statusModule) {
		this.statusModule = statusModule;
	}
	public Integer getLevelModule() {
		return levelModule;
	}
	public void setLevelModule(Integer levelModule) {
		this.levelModule = levelModule;
	}
	public Integer getPageId() {
		return pageId;
	}
	public void setPageId(Integer pageId) {
		this.pageId = pageId;
	}
	public String module() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		//sql方法
		/*String sqlString = "select * from module where parent_id=?";
		List<Object> listId = new ArrayList<Object>(); 
		List<Object> listslp0 = new ArrayList<Object>();
		listslp0 = commonService.findListBySql("select * from module where status=1 and level=1 and parent_id=0", null);
		for (Object object : listslp0) {
			Module module = (Module) object;
			listId.add(module.getId());
			List<Object> children = commonService.findListBySql(sqlString, listId);
			System.out.print(children);
		}*/
		
		//hql方法
		String hqlString = "from Module m where m.parentId=?";
		
		List<Object> listslp0 = new ArrayList<Object>();
		listslp0 = commonService.findListByHql("from Module m where m.status = 1 and m.level = 1 and m.parentId=0", null);
		List<Module> moduleList = new ArrayList<Module>();
		
		for (Object sObject : listslp0) {
			Module module = (Module)sObject;
			
			List<Object> idList = new ArrayList<Object>();
			idList.add(module.getId());
			
			List<Object> childrenlList = commonService.findListByHql(hqlString, idList);
			
			List<Module> mslList = new ArrayList<Module>();
			for(Object o:childrenlList){
				mslList.add((Module)o);
			}
			module.setChildren(mslList);
			
			moduleList.add(module);
		}
		setDataList(moduleList);
		
		return "success";
	}
}