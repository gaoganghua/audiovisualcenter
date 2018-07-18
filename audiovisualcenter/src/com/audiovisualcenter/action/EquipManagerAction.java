
package com.audiovisualcenter.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.swing.text.AsyncBoxView.ChildState;

import org.apache.struts2.ServletActionContext;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.model.Equip;
import com.audiovisualcenter.model.EquipCategory;
import com.audiovisualcenter.service.CommonService;
import com.audiovisualcenter.service.EquipService;
import com.audiovisualcenter.util.JsonUtil;
import com.audiovisualcenter.util.StringUtil;
import com.common.util.SearchObject;
import com.common.util.SearchRelation;
import com.common.util.SearchUtil;
import com.opensymphony.xwork2.ModelDriven;

public class EquipManagerAction extends CommonAction implements ModelDriven<Equip>{
	@Override
	public String execute() throws Exception {
		return "success";
	}
	//jqgrid属性
	private Integer rows;
	private Integer page;
	private boolean _search;
	private String sidx;
	private String sord;
	private String nd;
	private String ids;//传过来的ids
	private Equip equip = new Equip();//
	private String equipstatus;//器材的状态
	private List<String> childno;//自选项的编号
	private int flag;//标记变量
	
	private Map<String, Object> map;
	public Map<String, Object> getMap() {
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	public Equip getEquip() {
		return equip;
	}
	public void setEquip(Equip equip) {
		this.equip = equip;
	}
	//
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public boolean is_search() {
		return _search;
	}
	public void set_search(boolean _search) {
		this._search = _search;
	}
	public String getSidx() {
		return sidx;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public String getSord() {
		return sord;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Integer getRows() {
		return rows;
	}
	public String getNd() {
		return nd;
	}
	public void setNd(String nd) {
		this.nd = nd;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getEquipstatus() {
		return equipstatus;
	}
	public void setEquipstatus(String equipstatus) {
		this.equipstatus = equipstatus;
	}
	public List<String> getChildno() {
		return childno;
	}
	public void setChildno(List<String> childno) {
		this.childno = childno;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	//启动器材添加界面
	public String equipAddManager(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		List<Object> lists = commonService.findListByHql2("from EquipCategory ec", null);
		setDataList(lists);
		return "equipadd";
	}
	//启动器材编辑界面
	public String equipEditManager(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		List<Object> lists = commonService.findListByHql2("from EquipCategory ec", null);
		setDataList(lists);
		System.out.println(equip.getId());
		equip = (Equip) commonService.findObjectById(Equip.class, equip.getId());
		List<Object> childs = commonService.findListByHql2("from Equip e where e.parentId=?", new Object[]{equip.getId()});
		if(childs==null || childs.size()==0){//表示没有子编号
			setFlag(0);//
		}else{//表示含有子编号
			ServletActionContext.getRequest().setAttribute("childs", childs);
			setFlag(1);
		}
		return "equipedit";
	}
	//加载信息
	public String equipManager() throws IOException {
//		System.out.println(getRows() + ":" + getPage() + ":" + getSidx() + ":" + getSord());
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		EquipService equipService = DatabaseFactory.getEquipService(servletContext);
		
		int firstResult = (getPage()-1)*getRows();
		int size = getRows();
		
		//总数量
		List<Object> lists = new ArrayList<Object>();
		lists.add(0L);
		Long obj = (Long) commonService.executeSqlWithReport("select count(*) from Equip e where e.parentId=?", lists);
		int totalRecord = obj.intValue();
		int totalPages = (totalRecord%size==0?totalRecord/size:(totalRecord/size)+1);
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "parentId", 0L));
		//关联表查询
		List<SearchRelation> relations = new ArrayList<SearchRelation>();
		List<SearchObject> searchList = new ArrayList<SearchObject>();
		relations.add(SearchUtil.addRelation("EquipCategory", "id", "ec", true, searchList, "Equip", "typeId"));
		
		Map<String, String> orderColumns = null;
		if(getSidx()!=null && !("").equals(getSidx().trim()) && getSord()!=null && !("").equals(getSord().trim())){
			orderColumns = new HashMap<String, String>();
//			System.out.println("typeName".equals(getOrderColumn()));
			if("typeName".equals(getSidx())){
				orderColumns.put("ec.name", getSord());
			}else{
				orderColumns.put("e."+getSidx(), getSord());
			}
		}
		List<Equip> equipList = new ArrayList<Equip>();
		List<Object[]> objLists = equipService.findObjectsListByParamsWithOrderAndPage(params, relations, orderColumns, firstResult, size);
		
		for (Object[] objs:objLists) {
			Equip e = (Equip) objs[0];
			EquipCategory ec = (EquipCategory) objs[1];
			e.setTypeName(ec.getName());
			equipList.add(e);
		}
//		this.test(totalRecord/10, 1, totalRecord, equipList);
		setMap(this.getJsonMap(totalPages, getPage(), totalRecord, equipList));
//		setJsondata(JsonUtil.jqGrids(totalRecord/10, 1, totalRecord, equipList));
		return "success";
	}
	//添加器材
	public String addEquipManager() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
//		System.out.println("fff");
		try{
			commonService.getTransactionManager().begin();
			if(getEquip().getId()==null || getEquip().getId()==0L){
				boolean status = ("1").equals(getEquipstatus())?true:false;
				getEquip().setStatus(status);
				getEquip().setParentId(0L);
				if(getChildno()!=null && getChildno().size()>0){
					getEquip().setTotal(getChildno().size());
					getEquip().setSurplus(getChildno().size());
				}
				commonService.add(equip);
				if(getChildno()!=null && getChildno().size()>0){//存在子选项
					for(String no:getChildno()){
						if(no!=null && !("").equals(no.trim())){
//							System.out.println(no);
							Equip e = new Equip();
							e.setName(no);
							e.setNo(no);
							e.setTotal(1);
							e.setSurplus(1);
							e.setCon(equip.getCon());
							e.setTypeId(getEquip().getTypeId());
							e.setParentId(equip.getId());
							e.setStatus(status);
							commonService.add(e);
						}
					}
				}
				
				setJsondata(JsonUtil.ajax(true, null));
			}else{
				setJsondata(JsonUtil.ajax(false, "没有该器材信息"));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//删除器材
	public String deleteEquipManager() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		try{
			commonService.getTransactionManager().begin();
			if(getIds()!=null && !("").equals(getIds())){
				String[] sids = getIds().split(",");
				for(String s:sids){
					Long id = Long.parseLong(s);
					String hql="from Equip e where e.parentId = ?";
					List<Object> childEquips = commonService.findListByHql2(hql, new Object[]{id});
					if(childEquips!=null && childEquips.size()>0){//存在子编号
						for(Object obj: childEquips){
							commonService.delete(obj);
						}
					}
					Equip equip = (Equip) commonService.findObjectById(Equip.class, id);
					commonService.delete(equip);
				}
				setJsondata(JsonUtil.ajax(true, null));
			}else{
				setJsondata(JsonUtil.ajax(false, "没有选择元素"));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//设置正常状态
	public String setStatus(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		try{
			commonService.getTransactionManager().begin();
			if(getIds()!=null && !("").equals(getIds())){
				String[] sids = getIds().split(",");
				for(String s:sids){
					Long id = Long.parseLong(s);
					Equip equip = (Equip) commonService.findObjectById(Equip.class, id);
					equip.setCon(1);
					commonService.update(equip);
				}
				setJsondata(JsonUtil.ajax(true, null));
			}else{
				setJsondata(JsonUtil.ajax(false, "没有选择元素"));
			}
			commonService.getTransactionManager().commit();
		}catch (Exception e) {
			commonService.getTransactionManager().rollback();
			setJsondata(JsonUtil.ajax(false, SYSTEM_ERROR));
		}
		return "success";
	}
	//修改器材信息
	public String updateEquipManager() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		try{
			commonService.getTransactionManager().begin();
			String msg = null;
			boolean status = ("1").equals(getEquipstatus())?true:false;
			if(getFlag()==0){//没有子编号
				Equip e = (Equip) commonService.findObjectById(Equip.class, getEquip().getId());
				e.setName(equip.getName());
				e.setNo(equip.getNo());
				e.setTotal(equip.getTotal());
				e.setTypeId(equip.getTypeId());
				e.setCon(equip.getCon());
				e.setStatus(status);
				commonService.update(e);
			}else if(getFlag()==1){//存在子编号
				Equip e = (Equip) commonService.findObjectById(Equip.class, getEquip().getId());
				e.setName(equip.getName());
				e.setNo(equip.getNo());
				e.setTypeId(equip.getTypeId());
				e.setCon(equip.getCon());
				e.setStatus(status);
				commonService.update(e);
				
				String hql="from Equip e where e.parentId=?";
				List<Object> childEquips = commonService.findListByHql2(hql, new Object[]{e.getId()});
				for(Object obj :childEquips){//删除不存在的编号
					Equip eObj = (Equip)obj;
					if(!childno.contains(eObj.getNo())){
						commonService.delete(eObj);
					}
				}
				for(String no:getChildno()){
					if(no!=null && !("").equals(no.trim())){
						String hql1="from Equip e where e.no=? and e.parentId=?";
						List<Object> childs = commonService.findListByHql2(hql1, new Object[]{no, e.getId()});
						if(childs==null || childs.size()==0){//不存在该编号
							Equip childEquip = new Equip();
							childEquip.setNo(no);
							childEquip.setName(no);
							childEquip.setParentId(e.getId());
							childEquip.setStatus(status);
							childEquip.setTotal(1);
							childEquip.setSurplus(1);
							childEquip.setTypeId(e.getTypeId());
							childEquip.setCon(e.getCon());
							commonService.add(childEquip);
						}else if(childs.size()==1){//存在该编号,更新子编号数据与母设备同步
							Equip childEquip = (Equip) childs.get(0);
							childEquip.setCon(e.getCon());
							childEquip.setStatus(status);
							commonService.update(childEquip);
						}else{
							msg="存在多个编号相同的自设备";
						}
					}
				}
			}
			if(StringUtil.isEmpty(msg)){
				setJsondata(JsonUtil.ajax(true, null));
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
	@Override
	public Equip getModel() {
		return this.equip;
	}
	public Map<String, Object> getJsonMap(int totalpages, int currentpage, int totalrecords, List data){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalpages", totalpages);
		map.put("currentpage", currentpage);
		map.put("totalrecords", totalrecords);
		map.put("data", data);
//		map.put("row", 10);
		return map;
	}
	public void test(int totalpages, int currentpage, int totalrecords, List data){
//		setTotalpages(totalpages);
//		setCurrentpage(currentpage);
//		setTotalrecords(totalrecords);
//		setData(data);
//		map = new HashMap<String, Object>();
//		setTotalpages(totalRecord/10);
//		setCurrentpage(1);
//		setData(equipList);
//		setTotalrecords(totalRecord);
//		map = new HashMap<String, Object>();
//		map.put("totalpages", totalpages);
//		map.put("currentpage", currentpage);
//		map.put("totalrecords", totalrecords);
//		map.put("data", data);
//		map.put("row", 10);
//		ServletActionContext.getResponse().getWriter().print(JSONObject.fromObject(map).toString());
	}
	
}
