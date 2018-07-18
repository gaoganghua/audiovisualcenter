package com.audiovisualcenter.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class CommonAction<T> extends ActionSupport implements SessionAware{
	private static final long serialVersionUID = 1L;
	public String LOGIN_USER="login_user";
	public String SYSTEM_ERROR="500";
	public String Data = "data";
	public String JSON = "json";
	private int total;  //总记录数
	private int pageIndex;  //页码数
	private List<T> dataList;
	private String message;
	private String jsondata;
	private Object jsondataObject;//json数据对象
	private String result;
	private Map<String, Object> session;
	
	//dataTable属性
	private Integer draw;
	private Integer start;
	private Integer length;
	private String orderColumn;//排序列名
	private String orderColumnDir;//排序规则
	private String query;//查询
	private String[] searchColumns;//能够查询的字段
	
	
	//dataTable的应用属性
	private String index;//编辑行的下标
	
	public String getLOGIN_USER() {
		return LOGIN_USER;
	}
	public void setLOGIN_USER(String lOGIN_USER) {
		LOGIN_USER = lOGIN_USER;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
//	public int getPageSize() {
//		return pageSize;
//	}
//	public void setPageSize(int pageSize) {
//		this.pageSize = pageSize;
//	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public List<T> getDataList() {
		return dataList;
	}
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	public String getJsondata() {
		return jsondata;
	}
	public void setJsondata(String jsondata) {
		this.jsondata = jsondata;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	public Map<String, Object> getSession() {
		return session;
	}
	
	public Integer getDraw() {
		return draw;
	}
	public void setDraw(Integer draw) {
		this.draw = draw;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getLength() {
		return length;
	}
	public void setLength(Integer length) {
		this.length = length;
	}
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public String getOrderColumn() {
		return orderColumn;
	}
	public void setOrderColumn(String orderColumn) {
		this.orderColumn = orderColumn;
	}
	public String getOrderColumnDir() {
		return orderColumnDir;
	}
	public void setOrderColumnDir(String orderColumnDir) {
		this.orderColumnDir = orderColumnDir;
	}
	public String[] getSearchColumns() {
		return searchColumns;
	}
	public void setSearchColumns(String[] searchColumns) {
		this.searchColumns = searchColumns;
	}
	public String getIndex() {
		return index;
	}
	public void setIndex(String index) {
		this.index = index;
	}
	public Object getJsondataObject() {
		return jsondataObject;
	}
	public void setJsondataObject(Object jsondataObject) {
		this.jsondataObject = jsondataObject;
	}
	
}
