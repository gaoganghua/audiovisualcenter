package com.audiovisualcenter.service;

//import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

import com.audiovisualcenter.dao.BaseDao;
import com.common.util.ParamUtil;
import com.common.util.QueryTypeEnum;
import com.common.util.SearchObject;
import com.common.util.SearchRelation;
import com.common.util.SqlUtil;

public class BaseService<T> {
	private BaseDao<T> dao;
	
	public BaseDao<T> getDao() {
		return dao;
	}
	public void setDao(BaseDao<T> dao) {
		this.dao = dao;
	}
	//添加
	public void save(T o){
		this.dao.save(o);
	}
	//减少
	public void remove(T o){
		this.dao.delete(o);
	}
	//更改
	public void update(T o){
		this.dao.update(o);
	}
	//查询
	public T get(long id) {
		Class<T> cls = getType();
		return (T)this.dao.get(cls, id);
//		Field f = null;
//		try{
//			f = cls.getDeclaredField("id");
//		}catch (Exception e) {
//		}
//		if(f.getType() == java.lang.Integer.class){
//			return (T)this.dao.get(cls, (int)id);
//		}else{
//			return (T)this.dao.get(cls, (long)id);
//		}
	}
	public T get(int id) {
		Class<T> cls = getType();
		return (T)this.dao.get(cls, id);
	}
	//得到传入的类型
	@SuppressWarnings("unchecked")
	public Class<T> getType(){
		Type t=getClass().getGenericSuperclass();
		Type[] p=((ParameterizedType)t).getActualTypeArguments();
		return (Class<T>)p[0];
	}
	//根据条件查询
	public List<T> findListByParams(List<SearchObject> params){
		String[] paramNames = ParamUtil.getParamNames2(getType().getName(),params);
		Object[] values = ParamUtil.getParamValues2(params);
		String sql = SqlUtil.createHqlWithNamedParamByParams2(getType().getName(), params);
		return dao.queryList(sql, paramNames, values);
	}
	//根据条件查询并排序
	public List<T> findListByParamsWithOrder(List<SearchObject> params, Map<String, String> orderColumns){
		String[] paramNames = ParamUtil.getParamNames2(getType().getSimpleName(),params);
		Object[] values = ParamUtil.getParamValues2(params);
		String sql = SqlUtil.createHqlWithNamedParamByParams2(getType().getSimpleName(), params);
		sql = SqlUtil.appendOrderToSql(sql, orderColumns);
		return dao.queryListByParamsWithOrderAndPage(sql, paramNames, values, -1, -1);
	}
	//根据条件排序查询并分页
	public List<T> findListByParamsWithPage(List<SearchObject> params, int firstResult, int maxResult){
		String[] paramNames = ParamUtil.getParamNames2(getType().getSimpleName(),params);
		Object[] values = ParamUtil.getParamValues2(params);
		String sql = SqlUtil.createHqlWithNamedParamByParams2(getType().getSimpleName(), params);
		return dao.queryListByParamsWithOrderAndPage(sql, paramNames, values, firstResult, maxResult);
	}
	//根据条件排序查询排序分页
	public List<T> findListByParamsWithPageAndOrder(List<SearchObject> params,Map<String, String> orderColumns, int firstResult, int maxResult){
		String[] paramNames = ParamUtil.getParamNames2(getType().getSimpleName(),params);
		Object[] values = ParamUtil.getParamValues2(params);
		String sql = SqlUtil.createHqlWithNamedParamByParams2(getType().getSimpleName(), params);
		sql = SqlUtil.appendOrderToSql(sql, orderColumns);
		System.out.println(sql);
		return dao.queryListByParamsWithOrderAndPage(sql, paramNames, values, firstResult, maxResult);
	}
	//根据关联条件查询
	public List<Object[]> findObjectsListByParams(List<SearchObject> params, List<SearchRelation> searchRelation){
		String sql = SqlUtil.createRelationHqlWithNamedParamByParams(getType().getSimpleName(), params,searchRelation);
		String[] paramNames = ParamUtil.getParamNamesByRelation(getType().getSimpleName(),params,searchRelation);
		Object[] values = ParamUtil.getParamValuesByRelation(params,searchRelation);
		
//		System.out.println(sql);
		return dao.queryObjectsListByParams(sql, paramNames, values);
	}
	//根据关联条件查询并分页
//	public List<Object[]> findObjectsListByParamsWithOrder(List<SearchObject> params, List<SearchRelation> searchRelation){
//		String sql = SqlUtil.createRelationHqlWithNamedParamByParams(getType().getSimpleName(), params,searchRelation);
//		String[] paramNames = ParamUtil.getParamNamesByRelation(getType().getSimpleName(),params,searchRelation);
//		Object[] values = ParamUtil.getParamValuesByRelation(params,searchRelation);
//		
////		System.out.println(sql);
//		return dao.queryObjectsListByParams(sql, paramNames, values);
//	}
	//关联表分页排序查询
	public List<Object[]> findObjectsListByParamsWithOrderAndPage(List<SearchObject> params,List<SearchRelation> searchRelations,
		Map<String, String> orderColumns, int firstResult, int maxResult){
		String sql = SqlUtil.createRelationHqlWithNamedParamByParams(getType().getSimpleName(), params,searchRelations);
		String[] paramNames = ParamUtil.getParamNamesByRelation(getType().getSimpleName(),params,searchRelations);
		Object[] values = ParamUtil.getParamValuesByRelation(params,searchRelations);
		sql = SqlUtil.appendOrderToSql(sql, orderColumns);
		
//		System.out.println(sql);
		return this.dao.queryObjectsListWithOrderAndPage(sql, paramNames, values, firstResult, maxResult);
	}
	//根据关联条件查询并排序分页
//	public List<Object[]> findObjectsListByParamsWithOrderAndPage(List<SearchObject> params,List<SearchRelation> searchRelations, Map<String, String> orderColumns, int firstResult, int maxResult){
//		String[] paramNames = ParamUtil.getParamNames2(getType().getSimpleName(),params);
//		Object[] values = ParamUtil.getParamValues2(params);
//		String sql = SqlUtil.createRelationHqlWithNamedParamByParams(getType().getSimpleName(), params, searchRelations);
//		sql = sql.substring(0,sql.lastIndexOf("and"));
////		String sql = SqlUtil.createHqlWithNamedParamByParams2(getType().getSimpleName(), params);
//		sql = SqlUtil.appendOrderToSql(getType().getSimpleName(), sql, orderColumns);
//		System.out.println(sql);
//		return dao.queryObjectsListWithOrderAndPage(sql, paramNames, values, firstResult, maxResult);
//	}
	//报表查询
	public Object findReportRecord(List<SearchObject> params, QueryTypeEnum queryType, String[] columnNames){
		String[] paramNames = ParamUtil.getParamNames2(getType().getSimpleName(),params);
		Object[] values = ParamUtil.getParamValues2(params);
		String sql = SqlUtil.createHqlReportQuery(getType().getSimpleName(), params, queryType, columnNames);
		Object total = dao.queryReportQueryByParams(sql, paramNames, values);
		
		return total;
	}
	//创建关联表的总记录查询
//	public Object findTotalRecord(List<SearchObject> params,List<SearchRelation> searchRelations, QueryTypeEnum queryType){
//		String[] paramNames = ParamUtil.getParamNames2(getType().getSimpleName(),params);
//		Object[] values = ParamUtil.getParamValues2(params);
//		String sql = SqlUtil.createHqlReportQuery(getType().getSimpleName(), params, queryType, null);
//		List<Object> lists = (List<Object>)dao.queryReportQueryByParams(sql, paramNames, values);
//		
//		return Long.parseLong(String.valueOf(lists.get(0)));
//	}
	/*public List<Object[]> getListByParams(List<SearchObject> params,List<SearchRelation> searchRelations){
		String sql = SqlUtil.createRelationHqlWithNamedParamByParams(tableName, params,searchRelations);
		System.out.println(sql);
		String[] paramNames = ParamUtil.getParamNamesByRelation(tableName,params,searchRelations);
		Object[] values = ParamUtil.getParamValuesByRelation(params,searchRelations);
		for(String s:paramNames){
			System.out.println(s);
		}
		for(Object o:values){
			System.out.println(o);
		}
		return this.dao.queryObjectsListByParams(sql, paramNames, values);
	}*/
}
