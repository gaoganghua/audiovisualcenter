package com.audiovisualcenter.action;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.model.Borrow;
import com.audiovisualcenter.model.BorrowEquip;
import com.audiovisualcenter.model.Client;
import com.audiovisualcenter.model.Equip;
import com.audiovisualcenter.model.WaitReturn;
import com.audiovisualcenter.service.BorrowService;
import com.audiovisualcenter.service.ClientService;
import com.audiovisualcenter.service.CommonService;
import com.audiovisualcenter.util.JsonUtil;
import com.common.util.SearchObject;
import com.common.util.SearchRelation;
import com.common.util.SearchUtil;
import com.opensymphony.xwork2.ModelDriven;

public class WaitReturnAction extends CommonAction implements ModelDriven<Borrow>{
	private Borrow borrow = new Borrow();//
	
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
	//查询等待归还的记录
	public String waitreturnInfo() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		BorrowService borrowService = DatabaseFactory.getBorrowService(servletContext);
		ClientService clientService = DatabaseFactory.getClientService(servletContext);
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "borrowIntroduce", false));
		//关联表查询条件
		List<SearchObject> searchList = new ArrayList<SearchObject>();
		//创建关联条件
		List<SearchRelation> relations = new ArrayList<SearchRelation>();
		relations.add(SearchUtil.addRelation("Client", "id", "c", true, searchList, "Borrow", "clientId"));
		
		//添加排序
		Map<String, String> orderColumns = null;
		if(getOrderColumn()!=null && !("").equals(getOrderColumn())){
			orderColumns = new HashMap<String, String>();
			if("clientName".equals(getOrderColumn()) || ("clientPhone").equals(getOrderColumn())){
				String column = getOrderColumn().substring(getOrderColumn().indexOf("client")+5).toLowerCase();
				orderColumns.put("c."+column, getOrderColumnDir());
			}else{
				orderColumns.put("b." + getOrderColumn(), getOrderColumnDir());
			}
		}
		List<Object[]> lists =  borrowService.findObjectsListByParamsWithOrderAndPage(params, relations, orderColumns, -1, -1);  
		
		List<Borrow> borrowEquips = new ArrayList<Borrow>();
		for (Object[] objs : lists) {
			Borrow br = (Borrow) objs[0];
			Client c = (Client) objs[1];
			br.setClientName(c.getName());
			br.setClientPhone(c.getPhone());
			borrowEquips.add(br);
		}
//		System.out.println("aaa");
		setJsondata(JsonUtil.ajax(true, null,borrowEquips));
		
		return "success";
	}
	//查看借用器材
	public String waitreturnView(){
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
		if(objLists!=null && objLists.size()>0){
			for(Object[] objs:objLists){
				Borrow b = (Borrow) objs[0];
				BorrowEquip be = (BorrowEquip) objs[1];
				Equip e = (Equip) objs[2];
				be.setEquipName(e.getName());
				be.setEquipNo(e.getNo());
				borrowEquips.add(be);
			}
			setJsondata(JsonUtil.ajax(true, null, borrowEquips));
		}else{
			setJsondata(JsonUtil.ajax(false, "没有查询到记录"));
		}
		return "success";
	}
	//删除未归还订单
	public String waitreturnCancel(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		try{
			commonService.getTransactionManager().begin();
			if(getBorrow().getId()!=null){
				Borrow b = (Borrow) commonService.findObjectById(Borrow.class, getBorrow().getId());
				commonService.delete(b);
//				System.out.println(b.getId());
				String hql = "from BorrowEquip be where be.borrowId=?";
				List<Object> borrowEquips = commonService.findListByHql2(hql, new Object[]{getBorrow().getId()});
				if(borrowEquips!=null && borrowEquips.size()>0){
					for(Object obj:borrowEquips){
						BorrowEquip be = (BorrowEquip)obj;
//						System.out.println(be.getId());
						BorrowEquip borrowEquip = (BorrowEquip) obj;
						Equip equip = (Equip) commonService.findObjectById(Equip.class, borrowEquip.getEquipId());
						
						if(equip.getParentId()!=0){//存在父器材
							equip.setStatus(true);
							Equip parentEquip = (Equip) commonService.findObjectById(Equip.class, equip.getParentId());
							parentEquip.setSurplus(parentEquip.getSurplus() + borrowEquip.getTotal());
							commonService.update(parentEquip);
						}else{//没有父器材
							equip.setSurplus(equip.getSurplus() + borrowEquip.getTotal());
						}
						commonService.update(equip);
						commonService.delete(obj);
					}
				}
				setJsondata(JsonUtil.ajax(true, null, b));
			}else{
				setJsondata(JsonUtil.ajax(false, "没有选择"));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//确认归还
	public String waitreturnConfirm(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		try{
			commonService.getTransactionManager().begin();
			if(getBorrow().getId()!=null){
				Borrow borrow = (Borrow)commonService.findObjectById(Borrow.class, getBorrow().getId());
				if(borrow!=null){
					borrow.setBorrowIntroduce(true);
					borrow.setReturnTime(new java.util.Date());
					commonService.update(borrow);
					String hql = "from BorrowEquip be where be.borrowId=?";
					List<Object> equips = commonService.findListByHql2(hql, new Object[]{borrow.getId()});
					if(equips!=null && equips.size()>0){
						for(Object obj:equips){
							BorrowEquip borrowEquip = (BorrowEquip) obj;
							Equip equip = (Equip) commonService.findObjectById(Equip.class, borrowEquip.getEquipId());
							
							if(equip.getParentId()!=0){//存在父器材
								equip.setStatus(true);
								Equip parentEquip = (Equip) commonService.findObjectById(Equip.class, equip.getParentId());
								parentEquip.setSurplus(parentEquip.getSurplus() + borrowEquip.getTotal());
								commonService.update(parentEquip);
							}else{//没有父器材
								equip.setSurplus(equip.getSurplus() + borrowEquip.getTotal());
							}
							commonService.update(equip);
						}
					}
					setJsondata(JsonUtil.ajax(true, null));
				}else{
					setJsondata(JsonUtil.ajax(false, "没有查询到相关信息"));
				}
			}else{
				setJsondata(JsonUtil.ajax(false, "没有选择信息"));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//添加备注
	public String waitreturnMsg(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		try{
			commonService.getTransactionManager().begin();
			String msg = null;
			if(getBorrow().getId()!=null){
				Borrow borrow = (Borrow)commonService.findObjectById(Borrow.class, getBorrow().getId());
				if(getBorrow().getBorrowMsg()==null){//查询备注
					msg = borrow.getBorrowMsg();
					setJsondata(JsonUtil.ajax(true, msg));
				}else{//修改备注
					borrow.setBorrowMsg(getBorrow().getBorrowMsg());
					commonService.update(borrow);
					setJsondata(JsonUtil.ajax(true, null));
				}
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
	//查询等待归还的数量
	public String waitreturnTotal(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		String msg = null;
		
		String hql="select count(*) from Borrow b where b.borrowIntroduce=?";
		List<Object> params = new ArrayList<Object>();
		params.add(false);
		Long total = (Long) commonService.executeSqlWithReport(hql, params);
		msg = total.toString();
		
		setJsondata(JsonUtil.ajax(true, msg));
		return "success";
	}
//	public String waitOrders() {
//		ServletContext servletContext = ServletActionContext.getServletContext();
//		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
//		
//		String introduceHqlString = "from Borrow b where b.borrowIntroduce=1";
//		List<Object> introduceList = new ArrayList<Object>();
//		introduceList = commonService.findListByHql(introduceHqlString, null);
//		
//		List<Borrow> borrowList = new ArrayList<Borrow>();
//		Borrow borrow = new Borrow();
//		for (Object object:introduceList) {
//			borrow = (Borrow)object;
//			borrowList.add(borrow);
//		}
//		List<Object> clientIdObjectList = new ArrayList<Object>();
//		clientIdObjectList.add(borrow.getClientId());
//		
//		String hqlClient = "from Client c where c.id=?";
//		List<Object> clientObjectList = new ArrayList<Object>();
//		clientObjectList = commonService.findListByHql(hqlClient, clientIdObjectList);
//		
//		Client client = new Client();
//		for (Object object:clientObjectList) {
//			client = (Client)object;
//		}
//		
//		WaitReturn waitReturn = new WaitReturn();
//		waitReturn.setManagerName(borrow.getManagerName());
//		waitReturn.setDate(borrow.getBorrowTime());
//		waitReturn.setRemark(borrow.getBorrowMsg());
//		waitReturn.setClientName(client.getName());
//		waitReturn.setClientPhone(client.getPhone());
//		
//		List<WaitReturn> waitReturnList = new ArrayList<WaitReturn>();
//		waitReturnList.add(waitReturn);
//		
//		setDataList(waitReturnList);
//		
//		return "success";
//	}
	@Override
	public Borrow getModel() {
		return this.borrow;
	}
}
