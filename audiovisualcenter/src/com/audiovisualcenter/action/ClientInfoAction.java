package com.audiovisualcenter.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.model.Borrow;
import com.audiovisualcenter.model.Client;
import com.audiovisualcenter.model.Cls;
import com.audiovisualcenter.model.College;
import com.audiovisualcenter.service.CollegeService;
import com.audiovisualcenter.service.CommonService;
import com.audiovisualcenter.util.JsonUtil;
import com.audiovisualcenter.util.StringUtil;

public class ClientInfoAction extends CommonAction {
	private Integer clientStuId;//学号或者教师编号
	private String clientName;
	private String clientPhone;
	private Integer clientClass;
	private String cllientCollege;
	private String clientPurpose;
	private String managerName;
	private String clientIdentity;
	private Boolean clinetStatus;
	private String collegeId;//学院的id
	
	public Integer getClientStuId() {
		return clientStuId;
	}
	public void setClientStuId(Integer clientStuId) {
		this.clientStuId = clientStuId;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getClientPhone() {
		return clientPhone;
	}
	public void setClientPhone(String clientPhone) {
		this.clientPhone = clientPhone;
	}
	public Integer getClientClass() {
		return clientClass;
	}
	public void setClientClass(Integer clientClass) {
		this.clientClass = clientClass;
	}
	public String getCllientCollege() {
		return cllientCollege;
	}
	public void setCllientCollege(String cllientCollege) {
		this.cllientCollege = cllientCollege;
	}
	public String getClientPurpose() {
		return clientPurpose;
	}
	public void setClientPurpose(String clientPurpose) {
		this.clientPurpose = clientPurpose;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getClientIdentity() {
		return clientIdentity;
	}
	public void setClientIdentity(String clientIdentity) {
		this.clientIdentity = clientIdentity;
	}
	public Boolean getClinetStatus() {
		return clinetStatus;
	}
	public void setClinetStatus(Boolean clinetStatus) {
		this.clinetStatus = clinetStatus;
	}
	public String getCollegeId() {
		return collegeId;
	}
	public void setCollegeId(String collegeId) {
		this.collegeId = collegeId;
	}
	//加载客户信息数据
	public String confirmBorrow(){
		ServletContext servletContext = ServletActionContext.getServletContext();
//		CollegeService collegeService = DatabaseFactory.getCollegeService(servletContext);
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		String hql="from College c where c.parentId=?";
		
//		try{
//			commonService.getTransactionManager().begin();
			List<Object> params = new ArrayList<Object>();
			params.add(0);
			List<Object> collegesList = commonService.findListByHql(hql, params);//查询学院
			setDataList(collegesList);
			
			College c = (College) collegesList.get(0);//学院中的第一个学院
	//		String hql2 = "from College c where c.parentId=?";
			List<Object> params2 = new ArrayList<Object>();
			params2.add(c.getId());
			List<Object> clsList = commonService.findListByHql(hql, params2);//查询专业
			ServletActionContext.getRequest().setAttribute("clsLists", clsList);
			
//			commonService.getTransactionManager().commit();
//		}catch (Exception e) {
//			commonService.getTransactionManager().rollback();
//			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
//		}
		return "success";
	}
	//根据学院加载专业
	public String collegeInfo(){
		ServletContext servletContext = ServletActionContext.getServletContext();
//		CollegeService collegeService = DatabaseFactory.getCollegeService(servletContext);
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		try{
			commonService.getTransactionManager().begin();
			String hql="from College c where c.parentId=?";
			List<Object> params = new ArrayList<Object>();
			params.add(Integer.parseInt(getCollegeId()));
			
			List<Object> clsList = commonService.findListByHql(hql, params);//查询专业
			setJsondata(JsonUtil.ajax(true, null, clsList));
		
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//根据学号和教务编号查询信息
	public String clientInfo() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		try{
			commonService.getTransactionManager().begin();
			String msg = null;
			Client client = null;
			String hql0 = "from Client c where c.no=?";
			List<Object> all = commonService.findListByHql2(hql0, new Object[]{getClientStuId()});
			if(all!=null && all.size()>0){
				client = (Client) all.get(0);
				Cls cls = (Cls) commonService.findObjectById(Cls.class,client.getClsId());
				client.setClsNo(cls.getClsNo());
				College college = (College) commonService.findObjectById(College.class,cls.getCollegeId());
				client.setCollegeId(college.getId());
				College collegeParent = (College) commonService.findObjectById(College.class, college.getParentId());
				client.setCollegeParentId(collegeParent.getId());
			}else{
				msg = "没有该用户信息";
			}
			if(StringUtil.isEmpty(msg)){
				setJsondata(JsonUtil.ajax(true, null, client));
			}else{
				setJsondata(JsonUtil.ajax(false, msg));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		
		return "success";
	}
}
