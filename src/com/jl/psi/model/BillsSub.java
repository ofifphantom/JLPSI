package com.jl.psi.model;

import java.util.Date;

/**
 * 单据子项信息
 * @author guole
 *
 */
public class BillsSub {
	// 主键
	private Integer id;  
	//单据id
	private Integer billsId;
	
	//采购订单/销售订单 id
	private Integer  procureSalesId;
	//已结算金额
	private Double clearingMoney;
	//待结算金额
	private Double stayMoney;
	//本次结算金额
	private  Double theMoeny;
	//实付金额
	private Double  actualMoney;
	//折扣金额
	private Double rebateMoney;
	//是否付款
	private  Integer isPayment;
	//折扣
	private  Integer rebate;
	// 备注
	 private String remark;
	//单据编号
	private String  identifier;
	//订单日期
	private Date orderTime;
	//开单金额
	private Double orderMoney;
	private Double payMoney;
	
	public Double getPayMoney() {
		return payMoney;
	}
	public void setPayMoney(Double payMoney) {
		this.payMoney = payMoney;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getBillsId() {
		return billsId;
	}
	public void setBillsId(Integer billsId) {
		this.billsId = billsId;
	}
	public Integer getProcureSalesId() {
		return procureSalesId;
	}
	public void setProcureSalesId(Integer procureSalesId) {
		this.procureSalesId = procureSalesId;
	}
	public Double getClearingMoney() {
		return clearingMoney;
	}
	public void setClearingMoney(Double clearingMoney) {
		this.clearingMoney = clearingMoney;
	}
	public Double getStayMoney() {
		return stayMoney;
	}
	public void setStayMoney(Double stayMoney) {
		this.stayMoney = stayMoney;
	}
	public Double getTheMoeny() {
		return theMoeny;
	}
	public void setTheMoeny(Double theMoeny) {
		this.theMoeny = theMoeny;
	}
	public Double getActualMoney() {
		return actualMoney;
	}
	public void setActualMoney(Double actualMoney) {
		this.actualMoney = actualMoney;
	}
	public Double getRebateMoney() {
		return rebateMoney;
	}
	public void setRebateMoney(Double rebateMoney) {
		this.rebateMoney = rebateMoney;
	}
	public Integer getIsPayment() {
		return isPayment;
	}
	public void setIsPayment(Integer isPayment) {
		this.isPayment = isPayment;
	}
	public Integer getRebate() {
		return rebate;
	}
	public void setRebate(Integer rebate) {
		this.rebate = rebate;
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	 
	public Double getOrderMoney() {
		return orderMoney;
	}
	public void setOrderMoney(Double orderMoney) {
		this.orderMoney = orderMoney;
	}
	public Date getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
	

}
