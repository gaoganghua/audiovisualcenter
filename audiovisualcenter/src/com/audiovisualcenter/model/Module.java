package com.audiovisualcenter.model;

import java.util.List;

/**
 * Module entity. @author MyEclipse Persistence Tools
 */

public class Module implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private Integer parentId;
	private String url;
	private Boolean status;
	private String iconClass;
	private Short seq;
	private Short level;
	
	//二级菜单
	private List<Module> children;

	// Constructors

	/** default constructor */
	public Module() {
	}

	/** full constructor */
	public Module(String name, Integer parentId, String url, Boolean status, String iconClass, Short seq, Short level) {
		this.name = name;
		this.parentId = parentId;
		this.url = url;
		this.status = status;
		this.iconClass = iconClass;
		this.seq = seq;
		this.level = level;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Boolean getStatus() {
		return this.status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public String getIconClass() {
		return this.iconClass;
	}

	public void setIconClass(String iconClass) {
		this.iconClass = iconClass;
	}

	public Short getSeq() {
		return this.seq;
	}

	public void setSeq(Short seq) {
		this.seq = seq;
	}

	public Short getLevel() {
		return this.level;
	}

	public void setLevel(Short level) {
		this.level = level;
	}

	public List<Module> getChildren() {
		return children;
	}

	public void setChildren(List<Module> children) {
		this.children = children;
	}

}