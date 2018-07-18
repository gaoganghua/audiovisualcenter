package com.audiovisualcenter.model;

import java.sql.Timestamp;

/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User implements java.io.Serializable {

	// Fields

	private Long id;
	private String loginName;
	private String loginPassword;
	private Timestamp createDate;
	private Boolean status;
	private Integer groupId;

	// Constructors

	/** default constructor */
	public User() {
	}

	/** full constructor */
	public User(String loginName, String loginPassword, Timestamp createDate, Boolean status, Integer groupId) {
		this.loginName = loginName;
		this.loginPassword = loginPassword;
		this.createDate = createDate;
		this.status = status;
		this.groupId = groupId;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLoginName() {
		return this.loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginPassword() {
		return this.loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}

	public Timestamp getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public Boolean getStatus() {
		return this.status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public Integer getGroupId() {
		return this.groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

}