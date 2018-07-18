package com.audiovisualcenter.util;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

public class JsonUtil {
	public static String getJsonByList(Object object){
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class,
				new JsonValueProcessor() {
					private final String format = "yyyy-MM-dd HH:mm:ss";

					public Object processArrayValue(Object object,JsonConfig jsonConfig) {
						return null;
					}

					public Object processObjectValue(String string,Object object, JsonConfig jsonConfig) {
						if (null == object) {
							return "";
						} else {
							if (object instanceof java.util.Date) {
								SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
								String dateStr = simpleDateFormat.format(object);
								return dateStr;
							}
						}
						return object.toString();
					}
				});
		if (object instanceof String)
			return object.toString();
		if ((object instanceof Object[]) || (object instanceof List)) {
			JSONArray jsonObject = JSONArray.fromObject(object, jsonConfig);
			return jsonObject.toString(2);
		} else {
			JSONObject jsonObject = JSONObject.fromObject(object, jsonConfig);
			return jsonObject.toString(2);
		}
	}
	//将金集合转换为json数据
	public static String ajax(Boolean success, String msg, Object datas){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("msg", msg);
		map.put("data", datas);
		return getJsonByList(map);
	}
	//将对象转换为json数据
	public static String ajax(Boolean success, String msg, Integer index,Object datas){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("msg", msg);
		map.put("index", index);
		map.put("data", datas);
		return getJsonByList(map);
	}
	//传输json信息
	public static String ajax(Boolean success, String msg){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("msg", msg);
//		map.put("data", datas);
		return getJsonByList(map);
	}
	//创建dataTables列表
	public static String dataTables(int draw, int total, List datas){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("draw", draw);
		map.put("recordsTotal", total);
		map.put("recordsFiltered", total);
		map.put("data", datas);
		return getJsonByList(map);
	}
	//创建jqgrid表格
	public static String jqGrids(int totalPage, int currentPage, int totals, List datas){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalpages", totalPage);
		map.put("currentpage", currentPage);
		map.put("totalrecords", totals);
		map.put("data", datas);
		return getJsonByList(map);
	}
	//传输json信息对象
	public static Object ajaxObject(Boolean success, String msg){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("msg", msg);
		return map;
	}
}
