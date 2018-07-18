package com.audiovisualcenter.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.audiovisualcenter.factory.DatabaseFactory;
import com.audiovisualcenter.model.BorrowEquip;
import com.audiovisualcenter.model.Equip;
import com.audiovisualcenter.service.CommonService;
import com.thoughtworks.xstream.security.ForbiddenClassException;

public class ReturnEquipAction extends CommonService {
	private String equipName;
	private String equipNumber;
	private String equipTotal;
	private String equipStatus;
	
	public String getEquipName() {
		return equipName;
	}
	public void setEquipName(String equipName) {
		this.equipName = equipName;
	}
	public String getEquipNumber() {
		return equipNumber;
	}
	public void setEquipNumber(String equipNumber) {
		this.equipNumber = equipNumber;
	}
	public String getEquipTotal() {
		return equipTotal;
	}
	public void setEquipTotal(String equipTotal) {
		this.equipTotal = equipTotal;
	}
	public String getEquipStatus() {
		return equipStatus;
	}
	public void setEquipStatus(String equipStatus) {
		this.equipStatus = equipStatus;
	}
	
	public String returnEquip() {
		ServletContext servletContext = ServletActionContext.getServletContext();
		CommonService commonService = DatabaseFactory.getCommonService(servletContext);
		
		Long idInteger = 6L;
		String hqlString1 = "from BorrowEquip be where be.borrowId=?";
		
		//查出有borrow_id为idInteger的数据
		List<Object> testList = new ArrayList<Object>();
		testList.add(idInteger);
		List<Object> list = new ArrayList<Object>();
		list = (List<Object>) commonService.findListByHql(hqlString1, testList);
		
		//遍历相关数据list，把数据赋给borrowEquip对象，将数据存入equipsList
		List<Object> equipsList = new ArrayList<Object>(); //完整数据集合
		BorrowEquip borrowEquip = null;
		List<BorrowEquip> borrowEquips = new ArrayList<BorrowEquip>();
		for (int i=0; i<list.size(); i++) {
			borrowEquip = (BorrowEquip)list.get(i);
			//根据equipIdList查询器材Equip信息
			String hqlString2 = "from Equip e where e.id=?";
			Equip equip = null;
			equip = (Equip) commonService.findObjectById(Equip.class, borrowEquip.getEquipId());
			//set信息
			borrowEquip.setEquipName(equip.getName());
			borrowEquip.setEquipNo(equip.getNo());
			borrowEquip.setTotal(borrowEquip.getTotal());
			borrowEquip.setCondition(borrowEquip.getCondition());
			
			borrowEquips.add(borrowEquip);
		}
		
		//测试
		/*for (Object object:borrowEquips) {
			JSONArray jsonArray = new JSONArray();
			jsonArray.add(object);
			System.out.println(jsonArray);
		}*/
		
		return "success";
	}
}
