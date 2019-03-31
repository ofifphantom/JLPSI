package com.jl.psi.model;

import java.util.Date;

/**
 * 消息信息
 * @author guole
 *
 */
public class Message {
	
	 private Integer	id;
 
	 
	 /**
	  * 消息类型id
	  */
	 private Integer	menuId;
	 /**
	  * 业务类型
	  */
	 private Integer	serviceType; 
	 
	 /**
	  * 业务id
	  */
	 private Integer	serviceId;
	 /**
	  * 消息生成时间
	  */
	 private Date		messageTime;
	 

	 
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
 
 
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	public Integer getServiceType() {
		return serviceType;
	}
	public void setServiceType(Integer serviceType) {
		this.serviceType = serviceType;
	}
	public Integer getServiceId() {
		return serviceId;
	}
	public void setServiceId(Integer serviceId) {
		this.serviceId = serviceId;
	}
	public Date getMessageTime() {
		return messageTime;
	}
	public void setMessageTime(Date messageTime) {
		this.messageTime = messageTime;
	}
 
	 
	 
	 
}
