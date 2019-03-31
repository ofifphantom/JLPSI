package com.jl.psi.model;

import java.util.Date;

/**
 * 活动信息
 * @author guole
 *
 */
public class Activity {
	private Integer id;
	/**
	 * 活动id
	 */
	private Integer activityId;
	/**
	 * 采购计划单生成时间
	 */
	private Date  generatedTime ;
	/**
	 * 活动类型(1预售商品，2库存，3 非0库存)'
	 */
	private Integer  activityType;
	/**
	 * 生成采购计划单(0未生成，1已生成)
	 */
	private Integer isGenerated;
	
	
	public Integer getIsGenerated() {
		return isGenerated;
	}
	public void setIsGenerated(Integer isGenerated) {
		this.isGenerated = isGenerated;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getActivityId() {
		return activityId;
	}
	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}
	public Date getGeneratedTime() {
		return generatedTime;
	}
	public void setGeneratedTime(Date generatedTime) {
		this.generatedTime = generatedTime;
	}
	public Integer getActivityType() {
		return activityType;
	}
	public void setActivityType(Integer activityType) {
		this.activityType = activityType;
	}
 
	
	
}
