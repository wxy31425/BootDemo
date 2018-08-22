package com.boot.demo.entity.base;

import java.io.Serializable;

/**
 * ztree树
 */
public class ZtreeView implements Serializable{
	private static final long serialVersionUID = 6237809780035784312L;
	private Long id;
	private Integer pId;
	private String name;
	private boolean open;
	private boolean checked = false;
	public ZtreeView() {
	}

	public ZtreeView(Long id, Integer pId, String name, boolean open) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
		this.open = open;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

}
