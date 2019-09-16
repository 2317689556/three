package com.buba.boot1806a.pojo;

public class Node {
	private Integer id;
	private Integer pid;
	private String name;
	private Boolean iconOpen;
	private Boolean isParent;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Boolean getIconOpen() {
		return iconOpen;
	}
	public void setIconOpen(Boolean iconOpen) {
		this.iconOpen = iconOpen;
	}
	public Boolean getIsParent() {
		return isParent;
	}
	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}
	
	
	
	public Node() {
		super();
	}
	
	public Node(Integer id, Integer pid, String name, Boolean iconOpen, Boolean isParent) {
		super();
		this.id = id;
		this.pid = pid;
		this.name = name;
		this.iconOpen = iconOpen;
		this.isParent = isParent;
	}
	@Override
	public String toString() {
		return "Node [id=" + id + ", pid=" + pid + ", name=" + name + ", iconOpen=" + iconOpen + ", isParent="
				+ isParent + "]";
	}
	
}
