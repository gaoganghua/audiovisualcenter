package com.audiovisualcenter.model;

/**
 * BorrowEquip entity. @author MyEclipse Persistence Tools
 */

public class BorrowEquip implements java.io.Serializable {

	// Fields

	private Long id;
	private Long borrowId;
	private Long equipId;
	private String equipNo;
	private String equipName;
	private String equipCategory;
	private Boolean condition;
	private Integer total;

	// Constructors

	/** default constructor */
	public BorrowEquip() {
	}

	/** full constructor */
	public BorrowEquip(Long borrowId, Long equipId, Boolean condition, Integer total) {
		this.borrowId = borrowId;
		this.equipId = equipId;
		this.condition = condition;
		this.total = total;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getBorrowId() {
		return this.borrowId;
	}

	public void setBorrowId(Long borrowId) {
		this.borrowId = borrowId;
	}

	public Long getEquipId() {
		return this.equipId;
	}

	public void setEquipId(Long equipId) {
		this.equipId = equipId;
	}

	public Boolean getCondition() {
		return this.condition;
	}

	public void setCondition(Boolean condition) {
		this.condition = condition;
	}

	public Integer getTotal() {
		return this.total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public String getEquipName() {
		return equipName;
	}

	public void setEquipName(String equipName) {
		this.equipName = equipName;
	}

	public String getEquipCategory() {
		return equipCategory;
	}

	public void setEquipCategory(String equipCategory) {
		this.equipCategory = equipCategory;
	}

	public String getEquipNo() {
		return equipNo;
	}

	public void setEquipNo(String equipNo) {
		this.equipNo = equipNo;
	}
	

}