package com.audiovisualcenter.model;

/**
 * GroupModule entity. @author MyEclipse Persistence Tools
 */

public class GroupModule implements java.io.Serializable {

	// Fields

	private Long id;
	private Integer groupId;
	private Integer moduleId;

	// Constructors

	/** default constructor */
	public GroupModule() {
	}

	/** full constructor */
	public GroupModule(Integer groupId, Integer moduleId) {
		this.groupId = groupId;
		this.moduleId = moduleId;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getGroupId() {
		return this.groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public Integer getModuleId() {
		return this.moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}

}