package com.audiovisualcenter.factory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletContext;

public class ParameterFactory {
	public static String init(ServletContext sc,String key){
		Properties p = new Properties();
		String path = "/WEB-INF/conf/properties/parameter.properties";
		InputStream is = sc.getResourceAsStream(path);
		try {
			p.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return p.getProperty(key);
	}
	//得到每页显示的条数
	public static int getPageSize(ServletContext sc){
		String value = init(sc, "pageSize");
		return Integer.parseInt(value);
		
	}
}
