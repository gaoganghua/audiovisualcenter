package com.audiovisualcenter.action;

import java.lang.reflect.Field;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.model.Borrow;
import com.audiovisualcenter.model.BorrowEquip;
import com.audiovisualcenter.model.Client;
import com.audiovisualcenter.model.Equip;
import com.audiovisualcenter.service.BorrowService;
import com.audiovisualcenter.service.ClientService;
import com.audiovisualcenter.service.CommonService;
import com.audiovisualcenter.service.EquipService;
import com.audiovisualcenter.util.JsonUtil;
import com.common.util.QueryTypeEnum;
import com.common.util.SearchObject;
import com.common.util.SearchRelation;
import com.common.util.SearchUtil;
import com.opensymphony.xwork2.ModelDriven;

public class HistoryAction extends CommonAction implements ModelDriven<Borrow>{
	private Borrow borrow = new Borrow();
	
	public Borrow getBorrow() {
		return borrow;
	}
	public void setBorrow(Borrow borrow) {
		this.borrow = borrow;
	}
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return "success";
	}
	//查看借用器材
	public String historyView(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		BorrowService borrowService = DatabaseFactory.getBorrowService(servletContext);
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "id",getBorrow().getId()));
		//创建关联表查询条件
		List<SearchRelation> relations = new ArrayList<SearchRelation>();
		relations.add(SearchUtil.addRelation("BorrowEquip", "borrowId", "be", true, null, "Borrow", "id"));
		relations.add(SearchUtil.addRelation("Equip", "id", "e", true, null, "BorrowEquip", "equipId"));
		
		List<Object[]> objLists = borrowService.findObjectsListByParams(params, relations);
		List<BorrowEquip> borrowEquips = new ArrayList<BorrowEquip>();
		for(Object[] objs:objLists){
			Borrow b = (Borrow) objs[0];
			BorrowEquip be = (BorrowEquip) objs[1];
			Equip e = (Equip) objs[2];
			be.setEquipName(e.getName());
			be.setEquipNo(e.getNo());
			borrowEquips.add(be);
		}
		setJsondata(JsonUtil.ajax(true, null, borrowEquips));
		return "equips";
//		setDataList(borrowEquips);
//		return "success";
	}
	//查询历史记录
	public String history() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		BorrowService borrowService = DatabaseFactory.getBorrowService(servletContext);
		ClientService clientService = DatabaseFactory.getClientService(servletContext);
		
		int pageIndex = (getStart()/getLength())+1;
		int firstResult = (pageIndex-1)*getLength();
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "borrowIntroduce", true));
		//关联表查询条件
		List<SearchObject> searchList = new ArrayList<SearchObject>();
		//创建关联条件
		List<SearchRelation> relations = new ArrayList<SearchRelation>();
		relations.add(SearchUtil.addRelation("Client", "id", "c", true, searchList, "Borrow", "clientId"));
		
		//添加查询条件
		if(getQuery()!=null && !("").equals(getQuery())){//查询条件
			params.add(SearchUtil.add(true, "managerName", getQuery(), true));
			searchList.add(SearchUtil.add(true, "name",getQuery(), true));
			searchList.add(SearchUtil.add(true, "phone",getQuery(), true));
		}
		//添加排序
		Map<String, String> orderColumns = null;
		if(getOrderColumn()!=null && !("").equals(getOrderColumn())){
			orderColumns = new HashMap<String, String>();
			if("clientName".equals(getOrderColumn()) || ("clientPhone").equals(getOrderColumn())){
				String column = getOrderColumn().substring(getOrderColumn().indexOf("client")+6).toLowerCase();
				orderColumns.put("c."+column, getOrderColumnDir());
			}else{
				orderColumns.put("b."+getOrderColumn(), getOrderColumnDir());
			}
		}
		List<Object[]> records =  borrowService.findObjectsListByParams(params, relations);
//		Long totalRecord = (Long) records.get(0);
		int total = records.size();
		
		List<Object[]> lists = borrowService.findObjectsListByParamsWithOrderAndPage(params, relations,orderColumns, firstResult, getLength());
		List<Borrow> borrowEquips = new ArrayList<Borrow>();
		for (Object[] objs : lists) {
			Borrow br = (Borrow) objs[0];
			Client c = (Client) objs[1];
//			Client client = clientService.get(borrow.getClientId());
			br.setClientName(c.getName());
			br.setClientPhone(c.getPhone());
			borrowEquips.add(br);
		}
		setJsondata(JsonUtil.dataTables(getDraw(), total, borrowEquips));
		
		return "success";
	}
	//删除历史记录
	public String historyRemove(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		try{
			commonService.getTransactionManager().begin();
			if(getBorrow().getId()!=null){
				Borrow b = (Borrow) commonService.findObjectById(Borrow.class, getBorrow().getId());
	//			commonService.delete(b);
				System.out.println(b.getId());
				String hql = "from BorrowEquip be where be.borrowId=?";
				List<Object> borrowEquips = commonService.findListByHql2(hql, new Object[]{getBorrow().getId()});
				if(borrowEquips!=null && borrowEquips.size()>0){
					for(Object obj:borrowEquips){
						BorrowEquip be = (BorrowEquip)obj;
						System.out.println(be.getId());
	//					commonService.delete(obj);
					}
				}
				setJsondata(JsonUtil.ajax(true, null, b));
			}else{
				setJsondata(JsonUtil.ajax(false, "没有选择对象"));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//添加备注
	public String historyMsg(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		try{
			commonService.getTransactionManager().begin();
			String msg = null;
			if(getBorrow().getId()!=null){
				Borrow borrow = (Borrow)commonService.findObjectById(Borrow.class, getBorrow().getId());
				msg = borrow.getBorrowMsg();
				setJsondata(JsonUtil.ajax(true, msg));
			}else{
				setJsondata(JsonUtil.ajax(false, "没有得到相关信息"));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	@Override
	public Borrow getModel() {
		return this.borrow;
	}
}
