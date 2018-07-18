package com.audiovisualcenter.model;

public class JqGrid {
	private String id;
	private Object[] cell;
//	public int getId() {
//		return id;
//	}
//	public void setId(int id) {
//		this.id = id;
//	}
	
	public Object[] getCell() {
		return cell;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setCell(Object[] cell) {
		this.cell = cell;
	}
	
}
