package com.audiovisualcenter.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Borrow entity. @author MyEclipse Persistence Tools
 */

public class Borrow implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private Long id;
	private Long clientId;
	private String managerName;//经手人
	private Date borrowTime;//借用时间
	private Date returnTime;//归还时间
	private Boolean borrowIntroduce;//归还情况
	private String borrowMsg;//借用信息
	private String borrowPurpose;//借出用途

	//add
	private String clientName;
	private String clientPhone;
	// Constructors

	/** default constructor */
	public Borrow() {
	}

	/** full constructor */
	public Borrow(Long clientId, String managerName, Date borrowTime,Date returnTime, Boolean borrowIntroduce, String borrowMsg) {
		this.clientId = clientId;
		this.managerName = managerName;
		this.borrowTime = borrowTime;
		this.returnTime = returnTime;
		this.borrowIntroduce = borrowIntroduce;
		this.borrowMsg = borrowMsg;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getClientId() {
		return this.clientId;
	}

	public void setClientId(Long clientId) {
		this.clientId = clientId;
	}
	
	public String getManagerName() {
		return this.managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public Date getBorrowTime() {
		return this.borrowTime;
	}

	public void setBorrowTime(Date borrowTime) {
		this.borrowTime = borrowTime;
	}

	public Boolean getBorrowIntroduce() {
		return this.borrowIntroduce;
	}

	public void setBorrowIntroduce(Boolean borrowIntroduce) {
		this.borrowIntroduce = borrowIntroduce;
	}

	public String getBorrowMsg() {
		return this.borrowMsg;
	}

	public void setBorrowMsg(String borrowMsg) {
		this.borrowMsg = borrowMsg;
	}

	public String getBorrowPurpose() {
		return borrowPurpose;
	}

	public void setBorrowPurpose(String borrowPurpose) {
		this.borrowPurpose = borrowPurpose;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getClientPhone() {
		return clientPhone;
	}

	public void setClientPhone(String clientPhone) {
		this.clientPhone = clientPhone;
	}

	public Date getReturnTime() {
		return returnTime;
	}

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}

}