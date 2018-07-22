package com.audiovisualcenter.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Transaction;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.model.Borrow;
import com.audiovisualcenter.model.BorrowEquip;
import com.audiovisualcenter.model.Client;
import com.audiovisualcenter.model.Cls;
import com.audiovisualcenter.model.Equip;
import com.audiovisualcenter.model.EquipCategory;
import com.audiovisualcenter.service.CommonService;
import com.audiovisualcenter.service.EquipService;
import com.audiovisualcenter.util.FormatUtil;
import com.audiovisualcenter.util.JsonUtil;
import com.common.util.SearchObject;
import com.common.util.SearchUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class BasketAction extends CommonAction implements ModelDriven<Client>{
	private String equipId;//器材的id
	private String equipTotal;//器材的数量
	private String equipNewId;//新器材的id
	
	private Client c = new Client();
	private String identity;//身份
//	private String clsNo;//班级编号
	private String cls;//专业号
	private String purpose;//意图
	private List<String> managersName;//管理员名称
	
	
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	public String getCls() {
		return cls;
	}
	public void setCls(String cls) {
		this.cls = cls;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public List<String> getManagersName() {
		return managersName;
	}
	public void setManagersName(List<String> managersName) {
		this.managersName = managersName;
	}
	public Client getC() {
		return c;
	}
	public void setC(Client c) {
		this.c = c;
	}
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
	public String getEquipNewId() {
		return equipNewId;
	}
	public void setEquipNewId(String equipNewId) {
		this.equipNewId = equipNewId;
	}
	//查看合借框
	public String basket() {
		Map<String, Object> basketMap = ActionContext.getContext().getSession();
	
		List<BorrowEquip> basketList = new ArrayList<BorrowEquip>();
		basketList = (List<BorrowEquip>)basketMap.get("Basket");
		
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		try{
			commonService.getTransactionManager().begin();
			if(basketList!=null && basketList.size()>0){
				for (BorrowEquip borrowEquip : basketList) {
					Equip equip = new Equip();
					equip = (Equip) commonService.findObjectById(Equip.class, borrowEquip.getEquipId());
	//				System.out.println(equip.getId());
					EquipCategory ec = (EquipCategory) commonService.findObjectById(EquipCategory.class,equip.getTypeId());
					borrowEquip.setEquipName(equip.getName());
					borrowEquip.setEquipCategory(ec.getName());
	//				System.out.println(equip.getCon());
					borrowEquip.setCondition(equip.getCon()==null?false:true);
					borrowEquip.setEquipNo(equip.getNo());
				}
			}
			setDataList(basketList);
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		
		return "success";
	}
	//删除合借框中的器材
	public String deleteBasketEquip() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		Map<String, Object> basketMap = ActionContext.getContext().getSession();
		
		try{
			commonService.getTransactionManager().begin();
			List<BorrowEquip> basketList = new ArrayList<BorrowEquip>();
			basketList = (List<BorrowEquip>)basketMap.get("Basket");
			
			String msg = "";
			boolean flag = false;
			Iterator<BorrowEquip> iterator = basketList.iterator();
			while(iterator.hasNext()) {
				BorrowEquip borrowEquip = iterator.next();
				if(borrowEquip.getEquipId() == Integer.parseInt(getEquipId())){
					iterator.remove();
					flag  = true;
					break;
				}
			}
			if(flag){
				setJsondata(JsonUtil.ajax(true, null));
			}else{
				msg = "未找到该器材";
				setJsondata(JsonUtil.ajax(false, msg));
			}
			
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//器材选择
	public String editBasketEquip(){
		Map<String, Object> basketMap = ActionContext.getContext().getSession();
		List<BorrowEquip> basketList = (List<BorrowEquip>)basketMap.get("Basket");
		
		ServletContext servletContext = ServletActionContext.getServletContext();
//		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		EquipService equipService = DatabaseFactory.getEquipService(servletContext);
		
		BorrowEquip be = null;
		for(BorrowEquip borrowEquip:basketList){
			if(borrowEquip.getEquipId() == Long.parseLong(getEquipId())){
				be = borrowEquip;
				break;
			}
		}
		
		Equip e = equipService.get(Long.parseLong(getEquipId()));
		if(e.getParentId()!=0){
			Equip parentEquip = equipService.get(e.getParentId());
			List<SearchObject> params = new ArrayList<SearchObject>();
			params.add(SearchUtil.add(false, "parentId", e.getParentId(), "="));
			params.add(SearchUtil.add(false, "status", true));
			List<Equip> childEquips = equipService.findListByParams(params);
//			System.out.println(childEquips.size());
			if(childEquips!=null && childEquips.size()>0){
				setDataList(childEquips);
			}
			ServletActionContext.getRequest().setAttribute("parentEquip", parentEquip);
		}else{
			be.setEquipName(e.getName());
			be.setEquipNo(e.getNo());
		}
		ServletActionContext.getRequest().setAttribute("borrowEquip", be);
		
		return "select";
	}
	//更新合借框中的器材
	public String updateBasketEquip() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		Map<String, Object> basketMap = ActionContext.getContext().getSession();
		List<BorrowEquip> basketList = (List<BorrowEquip>)basketMap.get("Basket");

		try{
			commonService.getTransactionManager().begin();
			BorrowEquip be = null;
			boolean flag = true;
			String msg = null;
			if(getEquipNewId()!=null && !("").equals(getEquipNewId())){
				for(BorrowEquip borrowEquip : basketList) {
					if(borrowEquip.getEquipId()==Long.parseLong(getEquipNewId())){
						Equip e = (Equip) commonService.findObjectById(Equip.class, borrowEquip.getEquipId());
						msg = e.getName()+"已存在";
						flag = false;
						break;
					}
				}
			}
			if(flag){
				for(BorrowEquip borrowEquip : basketList) {
					if (borrowEquip.getEquipId() == Long.parseLong(getEquipId())) {
						if(getEquipNewId()!=null && !("").equals(getEquipNewId())){
							borrowEquip.setEquipId(Long.parseLong(equipNewId));
						}else if(getEquipTotal()!=null && !("").equals(getEquipTotal())){
							borrowEquip.setTotal(Integer.parseInt(getEquipTotal()));
						}
						be = borrowEquip;
						break;
					}
				}
				Equip equip = (Equip) commonService.findObjectById(Equip.class, be.getEquipId());
				EquipCategory ec = (EquipCategory) commonService.findObjectById(EquipCategory.class,equip.getTypeId());
				be.setEquipNo(equip.getNo());
				be.setEquipName(equip.getName());
				be.setEquipCategory(ec.getName());
				be.setCondition(equip.getCon()==null?false:true);
				
				setJsondata(JsonUtil.ajax(true, null, Integer.parseInt(getIndex()),be));
			}else{
				setJsondata(JsonUtil.ajax(false, msg, null));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		
		return "success";
	}
	//清空合借框
	public String emptyBasket(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		Map<String, Object> basketMap = ActionContext.getContext().getSession();
		List<BorrowEquip> basketList = (List<BorrowEquip>)basketMap.get("Basket");
		try{
			commonService.getTransactionManager().begin();
			List<Object> all = null;
			String hql1 = "from Cls c where c.clsNo=? and c.collegeId=?";
			all = commonService.findListByHql2(hql1, new Object[]{c.getClsNo(), Integer.parseInt(getCls())});
			Cls cls = null;
			if(all==null || all.size()==0){//存储班级
				cls = new Cls();
				cls.setClsNo(c.getClsNo());
				cls.setCollegeId(Integer.parseInt(getCls()));
				commonService.add(cls);
			}else{
				cls = (Cls) all.get(0);
			}
			
			String hql0 = "from Client c where c.no=?";
			all = commonService.findListByHql2(hql0, new Object[]{c.getNo()});
			c.setFlag("1".equals(getIdentity())?true:false);
			c.setClsId(cls.getId());
			if(all==null  || all.size()==0){//存储用户
				commonService.add(c);
			}else{
				Client oldc = (Client) all.get(0);
				c.setId(oldc.getId());
				commonService.update(c);
			}
			
			StringBuffer managerName = new StringBuffer();
			for(String name:managersName){
				managerName.append(name+",");
			}
			managerName.deleteCharAt(managerName.length()-1);
			Borrow b = new Borrow();
			b.setClientId(c.getId());
			b.setBorrowTime(new Date());
			b.setBorrowPurpose(getPurpose());
			b.setManagerName(managerName.toString());
			b.setBorrowIntroduce(false);
			commonService.add(b);
//			int n = 1/0;//500错误提示
			
			//存储合借框中器材
			for(BorrowEquip borrowEquip:basketList){
				borrowEquip.setBorrowId(b.getId());
				borrowEquip.setCondition(true);
				commonService.add(borrowEquip);
				//器材减少
				Equip e = (Equip) commonService.findObjectById(Equip.class, borrowEquip.getEquipId());
				Equip parentEquip = (Equip) commonService.findObjectById(Equip.class, e.getParentId());
				if(parentEquip!=null){//含有父器材
					parentEquip.setSurplus(parentEquip.getSurplus()-borrowEquip.getTotal());
					e.setStatus(false);
					commonService.update(e);
					commonService.update(parentEquip);
				}else{//没有父器材
					e.setSurplus(e.getSurplus()-borrowEquip.getTotal());
					commonService.update(e);
					
				}
			}
			ServletActionContext.getContext().getSession().remove("Basket");
			setJsondata(JsonUtil.ajax(true, null));
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	@Override
	public Client getModel() {
		return this.c;
	}
}
