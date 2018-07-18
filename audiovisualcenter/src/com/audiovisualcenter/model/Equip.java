package com.audiovisualcenter.model;

/**
 * Equip entity. @author MyEclipse Persistence Tools
 */

public class Equip implements java.io.Serializable {

	// Fields

	private Long id;
	private String name;
	private String no;
	private Integer total;
	private Integer surplus;
	private Boolean status;
	private Integer typeId;
	private Integer con;
	private Long parentId;

	private String typeName;
	
	
	// Constructors

	/** default constructor */
	public Equip() {
	}

	/** full constructor */
	public Equip(String name, String no, Integer total, Integer surplus, Boolean status, Integer typeId, Integer con) {
		this.name = name;
		this.no = no;
		this.total = total;
		this.surplus = surplus;
		this.status = status;
		this.typeId = typeId;
		this.con = con;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNo() {
		return this.no;
	}

	public void setNo(String no) {
		this.no = no;
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

	public Integer getTypeId() {
		return this.typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getCon() {
		return this.con;
	}

	public void setCon(Integer con) {
		this.con = con;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Integer getSurplus() {
		return surplus;
	}

	public void setSurplus(Integer surplus) {
		this.surplus = surplus;
	}
	
}