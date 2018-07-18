package com.audiovisualcenter.daoimpl;

import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTemplate;

import com.audiovisualcenter.dao.BaseDao;

//基础类
public class BaseDaoImpl<T> implements BaseDao<T> {
	private SessionFactory sessionFactory;
	private HibernateTemplate hibernateTemplate;
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	//增加
	public void save(T o){
		getHibernateTemplate().save(o);
	}
	//删除
	public void delete(T o){
		getHibernateTemplate().delete(o);
	}
	//修改
	public void update(T o){
		getHibernateTemplate().update(o);
//		getHibernateTemplate().upda
	}
	//查询单个对象
	public T get(Class<T> classType, long id){
		return getHibernateTemplate().get(classType, id);
	}
	//查询单个对象
	public T get(Class<T> classType, int id){
		return (T) getHibernateTemplate().get(classType, id);
	}
	//(占位符查询)
	//根据条件查询集合对象
	@SuppressWarnings("unchecked")
	public List<Object> queryList(String sql,Object[] values){
		List<Object> all  = null;
		all = (List<Object>) getHibernateTemplate().find(sql, values);
		return all;
	}
	//(命名查询)
	//根据条件进行报表查询或查询单个对象
	public Object queryReportQueryByParams(String sql, String[] paramNames, Object[] values){
		Object queryResult = getHibernateTemplate().findByNamedParam(sql, paramNames, values);
		return queryResult;
	}
	//根据条件查询对象集合
	@SuppressWarnings("unchecked")
	public List<T> queryList(String sql, String[] paramNames, Object[] values){
		List<T> all  = null;
		all = (List<T>) getHibernateTemplate().findByNamedParam(sql, paramNames, values);
		return all;
	}
	//根据条件查询集合分页并排序
	@SuppressWarnings("unchecked")
	public List<T> queryListByParamsWithOrderAndPage(String sql, String[] paramNames, Object[] values, int firstResult, int maxResult){
		List<T> all  = null;
		if(firstResult<0 || maxResult<0){
			all = (List<T>) getHibernateTemplate().findByNamedParam(sql, paramNames, values);
		}else{
			Session session = getSessionFactory().openSession();
			Query query = session.createQuery(sql);
			if(values!=null && values.length>0){
				fillQueryParams(query, paramNames, values);
			}
			all = query.setFirstResult(firstResult).setMaxResults(maxResult).list();
			session.close();
		}
		return all;
	}
	//根据关联表条件查询集合
	@SuppressWarnings("unchecked")
	public List<Object[]> queryObjectsListByParams(String sql, String[] paramNames, Object[] values){
		return (List<Object[]>)getHibernateTemplate().findByNamedParam(sql, paramNames, values);
	}
	//根据关联条件查询排序并分页
	@SuppressWarnings("unchecked")
	public List<Object[]> queryObjectsListWithOrderAndPage
			(String sql, String[] paramNames, Object[] values, int firstResult, int maxResult){
		List<Object[]> all  = null;
		if(firstResult<0 || maxResult<0){
			all = (List<Object[]>) getHibernateTemplate().findByNamedParam(sql, paramNames, values);
		}else{
			Session session = getSessionFactory().openSession();
			Query query = session.createQuery(sql);
			if(values!=null && values.length>0){
				fillQueryParams(query, paramNames, values);
			}
			all = query.setFirstResult(firstResult).setMaxResults(maxResult).list();
			session.close();
		}
		return all;
	}
	//执行hql语句
	@Override
	@SuppressWarnings("unchecked")
	public List<Object> executeQueryWithHql(String hql, List<Object> values, int firstResult, int maxResult) {
		List<Object> all = null;
		Session session = getSessionFactory().openSession();
		Query query = session.createQuery(hql);
		if(values!=null && values.size()>0){
			fillQueryParams2(query, values);
		}
		if(firstResult!=-1 && maxResult!=-1){
			query.setFirstResult(firstResult).setMaxResults(maxResult);
		}
		all = query.list();
		session.close();
		return all;
	}
	//执行hql语句
	@Override
	@SuppressWarnings("unchecked")
	public List<Object> executeQueryWithHql(String hql, Object[] values, int firstResult, int maxResult) {
		List<Object> all = null;
		Session session = getSessionFactory().openSession();
		Query query = session.createQuery(hql);
		if(values!=null && values.length>0){
			fillQueryParams2(query, values);
		}
		if(firstResult!=-1 && maxResult!=-1){
			query.setFirstResult(firstResult).setMaxResults(maxResult);
		}
		all = query.list();
		session.close();
		return all;
	}
	//执行sql语句
	@Override
	@SuppressWarnings("unchecked")
	public List<Object> executeQueryWithSql(String sql, List<Object> values, int firstResult, int maxResult) {
		List<Object> all = null;
		Session session = getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery(sql);
		if(values!=null && values.size()>0){
			fillQueryParams2(query, values);
		}
		if(firstResult!=-1 && maxResult!=-1){
			query.setFirstResult(firstResult).setMaxResults(maxResult);
		}
		all = query.list();
		session.close();
		return all;
	}
	//填充属性值
	@SuppressWarnings("unchecked")
	private void fillQueryParams(Query query, String[] paramNames, Object[] values){
		for(int i=0;i<paramNames.length;i++){
			if(values[i].getClass().isArray() || values[i] instanceof List || values[i] instanceof Set){
				List<Object> vals = (List<Object>)values[i];
				query.setParameterList(paramNames[i], vals);
			}else{
				query.setParameter(paramNames[i], values[i]);
			}
		}
	}
	//填充属性值2
	private void fillQueryParams2(Query query, List<Object> values) {
		for(int i=0;i<values.size();i++){
			query.setParameter(i, values.get(i));
		}
	}
	//填充属性值22
	private void fillQueryParams2(Query query, Object[] values) {
		for(int i=0;i<values.length;i++){
			query.setParameter(i, values[i]);
		}
	}
	//填充属性值22
	private void fillQueryParams2(SQLQuery query, List<Object> values) {
		for(int i=0;i<values.size();i++){
			query.setParameter(i, values.get(i));
		}
	}
	//得到事务对象
	@Override
	public Transaction getTransaction() {
		return getSessionFactory().getCurrentSession().getTransaction();
	}
}
