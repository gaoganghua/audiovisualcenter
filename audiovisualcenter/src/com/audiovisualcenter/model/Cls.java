package com.audiovisualcenter.model;

/**
 * Cls entity. @author MyEclipse Persistence Tools
 */

public class Cls implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer clsNo;
	private Integer collegeId;

	// Constructors

	/** default constructor */
	public Cls() {
	}

	/** full constructor */
	public Cls(Integer clsNo, Integer collegeId) {
		this.clsNo = clsNo;
		this.collegeId = collegeId;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getClsNo() {
		return this.clsNo;
	}

	public void setClsNo(Integer clsNo) {
		this.clsNo = clsNo;
	}

	public Integer getCollegeId() {
		return this.collegeId;
	}

	public void setCollegeId(Integer collegeId) {
		this.collegeId = collegeId;
	}

}