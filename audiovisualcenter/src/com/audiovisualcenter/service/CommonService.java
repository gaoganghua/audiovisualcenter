package com.audiovisualcenter.service;

import java.util.List;

import javax.transaction.TransactionManager;

import org.springframework.orm.hibernate4.HibernateTransactionManager;

import com.audiovisualcenter.dao.BaseDao;
import com.audiovisualcenter.util.SpringTransactionManagerUtil;

public class CommonService{
	private BaseDao<Object> dao;
	private SpringTransactionManagerUtil transactionManager;//事务管理

	public BaseDao<Object> getDao() {
		return dao;
	}
	public void setDao(BaseDao<Object> dao) {
		this.dao = dao;
	}
	//获得事务对象
	public SpringTransactionManagerUtil getTransactionManager() {
		return transactionManager;
	}
	public void setTransactionManager(SpringTransactionManagerUtil transactionManager) {
		this.transactionManager = transactionManager;
	}
	//增加
	public void add(Object o){
		this.dao.save(o);
	}
	//删除
	public void delete(Object o){
		this.dao.delete(o);
	}
	//更新
	public void update(Object o){
		this.dao.update(o);
	}
	//根据id进行查询
	public Object findObjectById(Class cls, long id){
		return this.dao.get(cls, id);
	}
	public Object findObjectById(Class cls, int id){
		return this.dao.get(cls, id);
	}
	//(报表查询)
	public Object executeSqlWithReport(String hql, List<Object> values){
		return this.dao.executeQueryWithHql(hql, values, -1, -1).get(0);
	}
	//(集合查询)
	//执行sql语句
	public List<Object> findListBySql(String sql, List<Object> values){
		return this.dao.executeQueryWithSql(sql, values, -1, -1);
	}
	//执行sql语句
	public List<Object> findListBySqlWithPage(String sql, List<Object> values, int firstResult, int maxResult){
		return this.dao.executeQueryWithSql(sql, values, firstResult, maxResult);
	}
	//执行hql语句
	public List<Object> findListByHql(String sql, List<Object> values){
		return this.dao.executeQueryWithHql(sql, values, -1, -1);
	}
	//执行hql语句2
	public List<Object> findListByHql2(String sql, Object[] values){
		return this.dao.executeQueryWithHql(sql, values, -1, -1);
	}
	//执行hql语句并分页
	public List<Object> findListByHqlWithPage(String sql, List<Object> values, int firstResult, int maxResult){
		return this.dao.executeQueryWithHql(sql, values, firstResult, maxResult);
	}
//	//执行hql语句并分页排序
//	public List<Object> findListByHqlWithPage(String sql, List<Object> values, int firstResult, int maxResult, ){
//		return this.dao.executeQueryWithHql(sql, values, firstResult, maxResult);
//	}
	//更新语句
//	public boolean updateSql(String sql, Object[] values){
//		return this.baseDao.updateSql(sql, values);
//	}
	//(分页查询)
	//执行sql语句并分页
//	public List<Object[]> findObjectsListByHqlWithPage(String sql, List<Object> values, int firstResult, int maxResult){
//		return this.dao.executeQueryWithHql(sql, values, firstResult, maxResult);
//	}
	
}
