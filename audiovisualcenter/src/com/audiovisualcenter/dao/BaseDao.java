package com.audiovisualcenter.dao;

import java.util.List;

import org.hibernate.Transaction;

//基础接口
public interface BaseDao<T> {
	//添加
	public void save(T o);
	//删除
	public void delete(T o);
	//更新
	public void update(T o);
	//查询
	public T get(Class<T> classType, long id);
	public T get(Class<T> classType, int id);
	//查询集合
	public List<Object> queryList(String sql,Object[] values);
	//查询单个对象
	public Object queryReportQueryByParams(String sql, String[] paramNames, Object[] values);
	//查询集合(命名查询)
	public List<T> queryList(String sql, String[] paramNames, Object[] values);
	//查询集合并排序分页
	public List<T> queryListByParamsWithOrderAndPage(String sql, String[] paramNames, Object[] values, int firstResult, int maxResult);
	//关联查询集合
	public List<Object[]> queryObjectsListByParams(String sql, String[] paramNames, Object[] values);
	//关联查询集合并排序分页
	public List<Object[]> queryObjectsListWithOrderAndPage(String sql, String[] paramNames, Object[] values, int firstResult, int maxResult);
	//hql查询
	public List<Object> executeQueryWithHql(String sql, List<Object> values, int firstResult, int maxResult);
	//hql查询2
	public List<Object> executeQueryWithHql(String hql, Object[] values, int firstResult, int maxResult);
	//sql语句查询
	public List<Object> executeQueryWithSql(String sql, List<Object> values, int firstResult, int maxResult);
	//得到事物对象
	public Transaction getTransaction();
}
