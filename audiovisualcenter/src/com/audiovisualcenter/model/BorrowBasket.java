package com.audiovisualcenter.model;

/**
 * BorrowBasket entity. @author MyEclipse Persistence Tools
 */

public class BorrowBasket implements java.io.Serializable {

	// Fields

	private Long id;
	private Long equipId;
	private Integer condition;
	private Integer total;
	private Boolean status;

	// Constructors

	/** default constructor */
	public BorrowBasket() {
	}

	/** full constructor */
	public BorrowBasket(Long equipId, Integer condition, Integer total, Boolean status) {
		this.equipId = equipId;
		this.condition = condition;
		this.total = total;
		this.status = status;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getEquipId() {
		return this.equipId;
	}

	public void setEquipId(Long equipId) {
		this.equipId = equipId;
	}

	public Integer getCondition() {
		return this.condition;
	}

	public void setCondition(Integer condition) {
		this.condition = condition;
	}

	public Integer getTotal() {
		return this.total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Boolean getStatus() {
		return this.status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

}