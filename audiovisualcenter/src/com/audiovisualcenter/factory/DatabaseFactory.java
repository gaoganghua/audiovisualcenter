package com.audiovisualcenter.factory;

import javax.servlet.ServletContext;

import org.springframework.context.ApplicationContext;

import com.audiovisualcenter.service.BorrowBasketService;
import com.audiovisualcenter.service.BorrowEquipService;
import com.audiovisualcenter.service.BorrowService;
import com.audiovisualcenter.service.ClientService;
import com.audiovisualcenter.service.ClsService;
import com.audiovisualcenter.service.CollegeService;
import com.audiovisualcenter.service.CommonService;
import com.audiovisualcenter.service.EquipCategoryService;
import com.audiovisualcenter.service.EquipService;
import com.audiovisualcenter.service.GroupModuleService;
import com.audiovisualcenter.service.GroupService;
import com.audiovisualcenter.service.ModuleService;
import com.audiovisualcenter.service.UserService;

public class DatabaseFactory {
	private static ApplicationContext context = null;
	
	public static ApplicationContext getContext(ServletContext sc){
		context = (ApplicationContext)sc.getAttribute("springContext");
		return context;
	}
	public static CommonService getCommonService(ServletContext sc){
		return (CommonService) getContext(sc).getBean("commonService");
	}
	public static BorrowService getBorrowService(ServletContext sc){
		return (BorrowService) getContext(sc).getBean("borrowService");
	}
	public static BorrowBasketService getBorrowBasketService(ServletContext sc){
		return (BorrowBasketService) getContext(sc).getBean("borrowBasketService");
	}
	public static BorrowEquipService getBorrowEquipService(ServletContext sc){
		return (BorrowEquipService) getContext(sc).getBean("borrowEquipService");
	}
//	public static ClientClsService getClientClsService(ServletContext sc){
//		return (ClientClsService) getContext(sc).getBean("clientClsService");
//	}
	public static ClientService getClientService(ServletContext sc){
		return (ClientService) getContext(sc).getBean("clientService");
	}
	public static ClsService getClsService(ServletContext sc){
		return (ClsService) getContext(sc).getBean("clsService");
	}
	public static CollegeService getCollegeService(ServletContext sc){
		return (CollegeService) getContext(sc).getBean("collegeService");
	}
	public static EquipCategoryService getEquipCategoryService(ServletContext sc){
		return (EquipCategoryService) getContext(sc).getBean("equipCategoryService");
	}
	public static EquipService getEquipService(ServletContext sc){
		return (EquipService) getContext(sc).getBean("equipService");
	}
	public static GroupModuleService getGroupModuleService(ServletContext sc){
		return (GroupModuleService) getContext(sc).getBean("groupModuleService");
	}
	public static GroupService getGroupService(ServletContext sc){
		return (GroupService) getContext(sc).getBean("groupService");
	}
	public static ModuleService getModuleService(ServletContext sc){
		return (ModuleService) getContext(sc).getBean("moduleService");
	}
	public static UserService getUserService(ServletContext sc){
		return (UserService) getContext(sc).getBean("userService");
	}
}
