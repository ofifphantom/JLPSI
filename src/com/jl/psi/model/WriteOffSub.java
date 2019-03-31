package com.jl.psi.model;

import java.util.Date;

/**
 * 核销单子项
 * @author guole
 *
 */
public class WriteOffSub {
	/**
	 * 主键
	 */
	private Integer	id;
	/**
	 * 核销单id
	 */
	private Integer writeoffId;
	/**
	 * 采购订单/销售订单 id
	 */
	private Integer procureSalesId;
	/**
	 * 已结算金额
	 */
	private Double clearMoney;
	/**
	 * 未结算金额
	 */
	private Double stayMoney;
	/**
	 * 本次核销金额
	 */
	private Double theMoney;
	/**
	 * 是否核销
	 */
	private Integer isWriteoff;
	/**
	 *1 销售订单   2采购订单
	 */
 	private Integer isProcureSales;
 	/**
 	 * 备注
 	 */
	private String remark;
	/**
	 * 单据编号
	 */
	private String  identifier;
	/**
	 * 订单日期
	 */
	private Date orderTime;
	/**
	 * 开单金额
	 */
	private Double orderMoney;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getWriteoffId() {
		return writeoffId;
	}
	public void setWriteoffId(Integer writeoffId) {
		this.writeoffId = writeoffId;
	}
	public Integer getProcureSalesId() {
		return procureSalesId;
	}
	public void setProcureSalesId(Integer procureSalesId) {
		this.procureSalesId = procureSalesId;
	}
	public Double getClearMoney() {
		return clearMoney;
	}
	public void setClearMoney(Double clearMoney) {
		this.clearMoney = clearMoney;
	}
	public Double getStayMoney() {
		return stayMoney;
	}
	public void setStayMoney(Double stayMoney) {
		this.stayMoney = stayMoney;
	}
	public Double getTheMoney() {
		return theMoney;
	}
	public void setTheMoney(Double theMoney) {
		this.theMoney = theMoney;
	}
	public Integer getIsWriteoff() {
		return isWriteoff;
	}
	public void setIsWriteoff(Integer isWriteoff) {
		this.isWriteoff = isWriteoff;
	}
	public Integer getIsProcureSales() {
		return isProcureSales;
	}
	public void setIsProcureSales(Integer isProcureSales) {
		this.isProcureSales = isProcureSales;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	public Date getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	public Double getOrderMoney() {
		return orderMoney;
	}
	public void setOrderMoney(Double orderMoney) {
		this.orderMoney = orderMoney;
	}
	
	
}
