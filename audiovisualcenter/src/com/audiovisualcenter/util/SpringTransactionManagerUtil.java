package com.audiovisualcenter.util;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.SessionFactoryUtils;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;

public class SpringTransactionManagerUtil{
	private HibernateTransactionManager transactionManager;
	private TransactionDefinition transactionDefinition;
	private ThreadLocal<Transaction> transactionLocal = new ThreadLocal<Transaction>();
	private ThreadLocal<Integer> countLocal = new ThreadLocal<Integer>();
	private ThreadLocal<TransactionStatus> transactionStatusLocal = new ThreadLocal<TransactionStatus>();
	
	public HibernateTransactionManager getTransactionManager() {
		return transactionManager;
	}
	public void setTransactionManager(HibernateTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
	public TransactionDefinition getTransactionDefinition() {
		return transactionDefinition;
	}
	public void setTransactionDefinition(TransactionDefinition transactionDefinition) {
		this.transactionDefinition = transactionDefinition;
	}

	public void begin() {
		Integer count = (Integer)countLocal.get();
	    if (count == null) {
	    	countLocal.set(new Integer(0));
	    } else {
	    	countLocal.set(new Integer(count.intValue() + 1));
	    }
	    if (count== null)
	    {
	      TransactionStatus status = this.transactionManager.getTransaction(this.transactionDefinition);
	      transactionStatusLocal.set(status);
//	      System.out.println(status);
	    }
	}

	public void commit() {
	    Integer t = (Integer)countLocal.get();
	    int txC = 0;
	    if (t != null) {
	      txC = t.intValue();
	    }
	    if (txC == 0)
	    {
	      TransactionStatus status = (TransactionStatus)transactionStatusLocal.get();
	      this.transactionManager.commit(status);
	      SessionFactory sf = this.transactionManager.getSessionFactory();
	      try{
//	        Session session = org.springframework.orm.hibernate3.SessionFactoryUtils.getSession(arg0, arg1)
//	        SessionFactoryUtils.releaseSession(session, sf);
	      }
	      catch (IllegalStateException localIllegalStateException) {}
	      countLocal.set(null);
	    }
	    else
	    {
	    	countLocal.set(new Integer(txC - 1));
	    }
	}
	

	public void rollback() {
		Integer t = (Integer)countLocal.get();
	    int txC = 0;
	    if (t != null) {
	      txC = t.intValue();
	    }
	    if (txC == 0)
	    {
	      TransactionStatus status = (TransactionStatus)transactionStatusLocal.get();
//	      System.out.println(status);
	      this.transactionManager.rollback(status);
	      SessionFactory sf = this.transactionManager.getSessionFactory();
	      try
	      {
//	        Session session = SessionFactoryUtils.getSession(sf, false);
//	        SessionFactoryUtils.releaseSession(session, sf);
	      }
	      catch (IllegalStateException localIllegalStateException) {}
	      countLocal.set(null);
	    }
	    else
	    {
	    	countLocal.set(new Integer(txC - 1));
	    }
	}


	
	
}
