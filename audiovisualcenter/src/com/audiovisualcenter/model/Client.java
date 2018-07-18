package com.audiovisualcenter.model;

/**
 * Client entity. @author MyEclipse Persistence Tools
 */

public class Client implements java.io.Serializable {

	// Fields

	private Long id;
	private String name;
	private String phone;
	private Integer no;
	private Boolean flag;/*1是学生，0是老师*/
	private Integer clsId;//班级id
	private Integer clsNo;//班级编号
	private Integer collegeId;//专业id
	private Integer collegeParentId;//学院的id
	

	// Constructors

	/** default constructor */
	public Client() {
	}

	/** full constructor */
	public Client(String name, String phone, Integer no, Boolean flag) {
		this.name = name;
		this.phone = phone;
		this.no = no;
		this.flag = flag;
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

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getNo() {
		return this.no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public Boolean getFlag() {
		return this.flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}
	public Integer getClsId() {
		return clsId;
	}
	public void setClsId(Integer clsId) {
		this.clsId = clsId;
	}

	public Integer getClsNo() {
		return clsNo;
	}

	public void setClsNo(Integer clsNo) {
		this.clsNo = clsNo;
	}

	public Integer getCollegeId() {
		return collegeId;
	}

	public void setCollegeId(Integer collegeId) {
		this.collegeId = collegeId;
	}

	public Integer getCollegeParentId() {
		return collegeParentId;
	}

	public void setCollegeParentId(Integer collegeParentId) {
		this.collegeParentId = collegeParentId;
	}

}