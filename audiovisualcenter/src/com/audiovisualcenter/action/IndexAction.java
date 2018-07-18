package com.audiovisualcenter.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.transaction.SystemException;

import org.apache.struts2.ServletActionContext;
import org.springframework.transaction.TransactionDefinition;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.factory.ParameterFactory;
import com.audiovisualcenter.model.Borrow;
import com.audiovisualcenter.model.BorrowEquip;
import com.audiovisualcenter.model.Equip;
import com.audiovisualcenter.model.EquipCategory;
import com.audiovisualcenter.model.User;
import com.audiovisualcenter.service.CommonService;
import com.audiovisualcenter.service.EquipService;
import com.audiovisualcenter.service.UserService;
import com.audiovisualcenter.util.JsonUtil;
import com.audiovisualcenter.util.StringUtil;
import com.common.util.QueryTypeEnum;
import com.common.util.SearchObject;
import com.common.util.SearchRelation;
import com.common.util.SearchUtil;
import com.mysql.fabric.xmlrpc.base.Array;
import com.opensymphony.xwork2.ActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class IndexAction extends CommonAction {
	private String equipId;//器材选择查看的的id
//	private String equipNoId;//器材的id
	private String equipTotal;//选择器材的数量
	private String selectTotal;//选择的数量
//	private Equip e;
	  
	public String getEquipId() {
		return equipId;
	}
	public void setEquipId(String equipId) {
		this.equipId = equipId;
	}
	public String getEquipTotal() {
		return equipTotal;
	}
	public void setEquipTotal(String equipTotal) {
		this.equipTotal = equipTotal;
	}
	public String getSelectTotal() {
		return selectTotal;
	}
	public void setSelectTotal(String selectTotal) {
		this.selectTotal = selectTotal;
	}
	
	//查询器材
	public String index(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		EquipService equipService = DatabaseFactory.getEquipService(servletContext);
		
		try{
			commonService.getTransactionManager().begin();
			int pageIndex = (getStart()/getLength())+1;
			int firstResult = (pageIndex-1)*getLength();
			
			List<SearchObject> params = new ArrayList<SearchObject>();
	//		params.add(SearchUtil.add(false, "status", true));
			params.add(SearchUtil.add(false, "parentId", 0L, "="));
			
			List<SearchObject> searchLists = null;
			List<SearchRelation> relations = new ArrayList<SearchRelation>();
	//		
			if(getQuery()!=null && !("").equals(getQuery())){//查询条件
				searchLists = new ArrayList<SearchObject>();
				searchLists.add(SearchUtil.add(true, "name", getQuery(), true));
				
				params.add(SearchUtil.add(true, "name", getQuery(), true));
			}
			relations.add(SearchUtil.addRelation("EquipCategory", "id", "ec", true, searchLists, "Equip", "typeId"));
			Map<String, String> orderColumns = null;
			if(getOrderColumn()!=null && !("").equals(getOrderColumn())){//排序条件
				orderColumns = new HashMap<String, String>();
				if(("typeName").equals(getOrderColumn())){
					orderColumns.put("ec.name", getOrderColumnDir());
				}else{
					orderColumns.put("e."+getOrderColumn(), getOrderColumnDir());
				}
			}
	//		List<Object> records = (List<Object>) equipService.findReportRecord(params, QueryTypeEnum.TOTAL_RECORD, null);
	//		Long totalRecord = (Long) records.get(0);
	//		int total = totalRecord.intValue();
			List<Object[]> totalLists = equipService.findObjectsListByParamsWithOrderAndPage(params, relations, orderColumns, -1, -1);
			int total = totalLists.size();
			
			List<Object[]> objLists = equipService.findObjectsListByParamsWithOrderAndPage(params, relations, orderColumns, firstResult, getLength());
			List<Equip> equips = new ArrayList<Equip>();
	//		System.out.println(objLists.size());
			for (Object[] objs : objLists) {
				Equip equip = (Equip) objs[0];
				EquipCategory equipCategory = (EquipCategory) objs[1];
				equip.setTypeName(equipCategory.getName());
				equips.add(equip);
			}
			setJsondata(JsonUtil.dataTables(getDraw(), total, equips));
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//器材选择界面
	public String selectEquip(){
		ServletContext servletContext = ServletActionContext.getServletContext();
//		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		EquipService equipService = DatabaseFactory.getEquipService(servletContext);
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "parentId", Long.parseLong(equipId), "="));
		params.add(SearchUtil.add(false, "status", true));
		List<Equip> childEquips = equipService.findListByParams(params);
		if(childEquips!=null && childEquips.size()>0){
			setDataList(childEquips);
		}
		Equip e = equipService.get(Long.parseLong(equipId));
		
		ServletActionContext.getRequest().setAttribute("equip", e);
		return "select";
	}
	//添加到合借框
	public String addBasket() throws Exception {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		Map<String, Object> sessionMap = ActionContext.getContext().getSession();
		List<BorrowEquip> borrowList = (List<BorrowEquip>)sessionMap.get("Basket");
		try{
			commonService.getTransactionManager().begin();
			
			long equipId = 0;
			int equipTotal = 1;
			String msg = "";//错误信息
			boolean flag = true;
			if(getEquipId()!=null && !("").equals(getEquipId())){
				equipId = Long.parseLong(getEquipId());
			}
			if(getEquipTotal()!=null && !("").equals(getEquipTotal())){
				equipTotal = Integer.parseInt(getEquipTotal());
			}
			
			BorrowEquip bEquip = new BorrowEquip();
			bEquip.setEquipId(equipId);
			bEquip.setTotal(equipTotal);
			
			if (borrowList == null){
				borrowList = new ArrayList<BorrowEquip>();
				borrowList.add(bEquip);
			} else {
				if (borrowList.isEmpty()) {
					borrowList.add(bEquip);
				} else {
					for(BorrowEquip be:borrowList){
						if(be.getEquipId()==bEquip.getEquipId())
							flag=false;
					}
					if (flag) {
						borrowList.add(bEquip);
					} else {
						msg = "合借框内已存在该器材，如有变动，请到合借框内修改";
					}
				}
			}
			
			if(StringUtil.isEmpty(msg)){
				setJsondata(JsonUtil.ajax(true, String.valueOf(borrowList.size())));
				sessionMap.put("Basket", borrowList);
			}else{
				setJsondata(JsonUtil.ajax(false, msg));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			//发生错误删除合借框中的器材
			for(int i=0;i<borrowList.size();i++){
				if(borrowList.get(i).getEquipId()==Integer.parseInt(getEquipId())){
					System.out.println(borrowList.get(i));
					borrowList.remove(i);
				}
			}
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		
		return "success";
	}
	//查询合借框的种类
	public String queryBasket(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		Map<String, Object> sessionMap = ActionContext.getContext().getSession();
		List<BorrowEquip> borrowList = (List<BorrowEquip>)sessionMap.get("Basket");
		try{
			commonService.getTransactionManager().begin();
			int basketequip = 0;
			if(borrowList!=null && borrowList.size()>0){
				basketequip = borrowList.size();
			}
			setJsondata(JsonUtil.ajax(true, String.valueOf(basketequip)));
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return SUCCESS;
	}
	//查看器材的剩余量并比较
	public String queryEquipSurplus(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
//		EquipService equipService = DatabaseFactory.getEquipService(servletContext);
		try{
			commonService.getTransactionManager().begin();
			String msg = null;
			Equip e = (Equip) commonService.findObjectById(Equip.class, Long.parseLong(getEquipId()));
			if(e!=null){
				if(Integer.parseInt(getSelectTotal())>e.getSurplus()){
					msg = "剩余量不足";
					setJsondataObject(JsonUtil.ajaxObject(false, msg));
				}else{
					setJsondataObject(JsonUtil.ajaxObject(true, null));
				}
			}else{
				msg = "未找到该器材";
				setJsondataObject(JsonUtil.ajaxObject(false, msg));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		
		return SUCCESS;
	}
//	Map<String, String[]> maps = ServletActionContext.getRequest().getParameterMap();
//	for(Entry<String, String[]> entry:maps.entrySet()){
//		System.out.println(entry.getKey() + ":");
//		for(String s:entry.getValue()){
////			System.out.println(s);
//			JSONObject json = JSONObject.fromObject(s);
//			System.out.println(json);
//		}
//	}
}