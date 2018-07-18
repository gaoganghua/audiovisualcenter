package com.audiovisualcenter.model;

import java.util.Date;

public class WaitReturn implements java.io.Serializable {
	private String clientName;
	private String clientPhone;
	private String managerName;
	private Date date;
	private String remark;
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clentName) {
		this.clientName = clentName;
	}
	public String getClientPhone() {
		return clientPhone;
	}
	public void setClientPhone(String clientPhone) {
		this.clientPhone = clientPhone;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
