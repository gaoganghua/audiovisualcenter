package com.audiovisualcenter.util;

import java.io.File;
import java.lang.reflect.Field;
import java.util.List;

import javax.servlet.ServletContext;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class ClassUtil {
	public static boolean containsField(Class cls, String fieldName){
		Field[] fields = cls.getDeclaredFields();
		boolean flag = false;
		for(Field field:fields){
			if(field.getName() == fieldName){
				flag = true;
				break;
			}
		}
		return flag;
	}
	public static boolean containsFieldOfTable(ServletContext sc, Class cls, String fieldName){
		SAXReader reader = new SAXReader(); 
		String filePath = "/WEB-INF/conf/hbm/" +cls.getSimpleName()+".hbm.xml"; 
		filePath = sc.getRealPath(filePath);
        //读取文件 转换成Document  
		Document document = null;
        try {
			document = reader.read(new File(filePath));
		} catch (DocumentException e) {
			e.printStackTrace();
		}
        boolean flag = false;
        Element root = document.getRootElement();
        Element classElement = root.element("class");
        List<Element> propertys = classElement.elements();
        for(Element ele:propertys){
        	if(ele.attributeValue("name").equals(fieldName)){
        		flag = true;
        		break;
        	}
        }
        return flag;
	}
}
