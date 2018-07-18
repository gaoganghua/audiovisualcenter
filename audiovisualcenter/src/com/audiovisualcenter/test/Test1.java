package com.audiovisualcenter.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.audiovisualcenter.action.CommonAction;
import com.audiovisualcenter.action.IndexAction;
import com.audiovisualcenter.model.Borrow;
import com.audiovisualcenter.service.BorrowService;
import com.audiovisualcenter.util.ClassUtil;
import com.common.util.SearchObject;
import com.common.util.SearchRelation;
import com.common.util.SearchUtil;
import com.opensymphony.xwork2.ActionSupport;

public class Test1 {
	ClassPathXmlApplicationContext context = null;
	@Before
	public void before(){
//		String[] beans = {"conf/spring/common.xml", "conf/spring/dao.xml","conf/spring/service.xml","conf/spring/action.xml"};
//		context = new ClassPathXmlApplicationContext(beans);
	}
	@Test
	public void test2(){
		String name="name";
		System.out.println(ClassUtil.containsField(Borrow.class, name));
//		System.out.println(context.getBean("indexAction"));
//		TestAction action =  (TestAction) context.getBean("indexAction");
//		action.test();
	}
	public void test1(){
		BorrowService borrowService = (BorrowService) context.getBean("borrowService");
		
		List<SearchObject> params = new ArrayList<SearchObject>();
		params.add(SearchUtil.add(false, "borrowIntroduce", true));
		//关联表查询条件
		List<SearchObject> searchList = new ArrayList<SearchObject>();
		//创建关联条件
		List<SearchRelation> relations = new ArrayList<SearchRelation>();
		//添加查询条件
		List<SearchObject> sparams= new ArrayList<SearchObject>();
		params.add(SearchUtil.add(true, "managerName", "兰奇", true));
//		params.add(SearchUtil.add(false,sparams));
		searchList.add(SearchUtil.add(true, "name","ggh", true));
//		searchList.add(SearchUtil.add(true, "phone","1575433", true));
		
		
		relations.add(SearchUtil.addRelation("Client", "id", "c", true, searchList, "Borrow", "clientId"));
		//添加排序
		Map<String, String> orderColumns = null;
//		if(getOrderColumn()!=null && !("").equals(getOrderColumn())){
//			orderColumns = new HashMap<String, String>();
//			orderColumns.put(getOrderColumn(), getOrderColumnDir());
//		}
		List<Object[]> objs =  borrowService.findObjectsListByParams(params, relations);
		System.out.println(objs.size());
//		Long totalRecord = (Long) records.get(0);
		
	}
}
