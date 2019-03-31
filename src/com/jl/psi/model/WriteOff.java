package com.jl.psi.model;

import java.util.Date;
import java.util.List;

/**
 * 核销单信息
 * @author guole
 *
 */
public class WriteOff {
	/**
	 * 主键
	 */
	private Integer id;
	/**
	 * 单号
	 */
	private String writeoffCode;
	/**
	 * 核销方式 1 预收冲应收，2 预付冲应付，3 应付转应付，4 应收转应收， 5 应收冲应付、 6 应付冲应收，7预收转预收，8 预付转预付
            
	 */
	private Integer type;
	/**
	 * 来往单位(客户、供应商)
	 */
	private Integer companyOne;
	/**
	 * 来往单位(客户、供应商)
	 */
	private Integer companyTwo;
	/**
	 * 总金额
	 */
	private Double money;
	/**
	 * 生成时间
	 */
	private Date createDate;
	/**
	 * 制单人
	 */
	private String originator;
	/**
	 * 业务员
	 */
	private Integer personId;
	/**
	 * 摘要
	 */
	private String summary;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 凭证号
	 */
	private String voucherNo;
	
	/**
	 * 分部
	 */
	private String branch;
	/**
	 * 客户/供应商名称
	 */
	private String companyOneName;
	
	/**
	 * 客户/供应商名称
	 */
	private String companyTwoName;
	/**
	 * 制单人名称
	 */
	private String originatorName;
	
 
	private String personName;
	private String departmentName;
	 private List<WriteOffSub> writeOffSubs;
	 /**
	  * 预收，预付余额
	  */
	 private Double advanceMoney;
	 
	 
	public Double getAdvanceMoney() {
		return advanceMoney;
	}
	public void setAdvanceMoney(Double advanceMoney) {
		this.advanceMoney = advanceMoney;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getWriteoffCode() {
		return writeoffCode;
	}
	public void setWriteoffCode(String writeoffCode) {
		this.writeoffCode = writeoffCode;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getCompanyOne() {
		return companyOne;
	}
	public void setCompanyOne(Integer companyOne) {
		this.companyOne = companyOne;
	}
	public Integer getCompanyTwo() {
		return companyTwo;
	}
	public void setCompanyTwo(Integer companyTwo) {
		this.companyTwo = companyTwo;
	}
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getOriginator() {
		return originator;
	}
	public void setOriginator(String originator) {
		this.originator = originator;
	}
	public Integer getPersonId() {
		return personId;
	}
	public void setPersonId(Integer personId) {
		this.personId = personId;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getVoucherNo() {
		return voucherNo;
	}
	public void setVoucherNo(String voucherNo) {
		this.voucherNo = voucherNo;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
 
	public String getOriginatorName() {
		return originatorName;
	}
	public void setOriginatorName(String originatorName) {
		this.originatorName = originatorName;
	}
 
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public List<WriteOffSub> getWriteOffSubs() {
		return writeOffSubs;
	}
	public void setWriteOffSubs(List<WriteOffSub> writeOffSubs) {
		this.writeOffSubs = writeOffSubs;
	}
	public String getCompanyOneName() {
		return companyOneName;
	}
	public void setCompanyOneName(String companyOneName) {
		this.companyOneName = companyOneName;
	}
	public String getCompanyTwoName() {
		return companyTwoName;
	}
	public void setCompanyTwoName(String companyTwoName) {
		this.companyTwoName = companyTwoName;
	}
	
	
	
	
}
