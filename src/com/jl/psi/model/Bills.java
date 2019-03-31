package com.jl.psi.model;

import java.util.Date;
import java.util.List;
/**
 * 单据信息
 * @author guole
 *
 */
public class Bills {
	  //主键
	private Integer id;  
	//单号
	private String billsCode;
	//客户/供应商id
	 private Integer customerSupplierId;
	//1.收款单，2付款单，3，预收款单，4，预付款单
	 private Integer billsType;
	 //生成日期
	 private Date billsDate;
	 //银行
	 private String  bank;
	 //银行账户
	 private String  bankAccount;
	 //结算方式
	 private Integer  payment;
	//制单人编号
	 private  String originator;
	 //业务员id
	 private Integer  personId;
	 //摘要
	 private String  summary;
	// 备注
	 private String remark;
	 //合计金额
	 private Double money; 
	 //票号
	 private String ticketNo;
	 //预收金额/预付金额
	 private Double balance;
	 //订单类型 1销售开单 2销售退货
	 private Integer orderType;
	 
	 
	public Integer getOrderType() {
		return orderType;
	}
	public void setOrderType(Integer orderType) {
		this.orderType = orderType;
	}
	public Double getBalance() {
		return balance;
	}
	public void setBalance(Double balance) {
		this.balance = balance;
	}
	/**
		 * 分支机构
		 */
	private String branch;
	/**
	 * 收款账户
	 */
	private String account;
	  
	
	/**
	 * 客户/供应商名称
	 */
	private String customerSupplierName;
	/**
	 * 制单人名称
	 */
	private String originatorName;
	
	/**
	 * 结算方式名称
	 */
	private String paymentName;
	private String personName;
	private String departmentName;
	 private List<BillsSub> billsSubs;
	private Supcto supcto;
	/**
	 * 开单金额
	 */
	private Double  receiveMoney;
	/**
	 * 退货金额
	 */
	private Double  returnMoney;
	
	public Double getReceiveMoney() {
		return receiveMoney;
	}
	public void setReceiveMoney(Double receiveMoney) {
		this.receiveMoney = receiveMoney;
	}
	public Double getReturnMoney() {
		return returnMoney;
	}
	public void setReturnMoney(Double returnMoney) {
		this.returnMoney = returnMoney;
	}
	public Supcto getSupcto() {
		return supcto;
	}
	public void setSupcto(Supcto supcto) {
		this.supcto = supcto;
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
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getBillsCode() {
		return billsCode;
	}
	public void setBillsCode(String billsCode) {
		this.billsCode = billsCode;
	}
	public Integer getCustomerSupplierId() {
		return customerSupplierId;
	}
	public void setCustomerSupplierId(Integer customerSupplierId) {
		this.customerSupplierId = customerSupplierId;
	}
	public Integer getBillsType() {
		return billsType;
	}
	public void setBillsType(Integer billsType) {
		this.billsType = billsType;
	}
	public Date getBillsDate() {
		return billsDate;
	}
	public void setBillsDate(Date billsDate) {
		this.billsDate = billsDate;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public Integer getPayment() {
		return payment;
	}
	public void setPayment(Integer payment) {
		this.payment = payment;
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
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public String getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(String ticketNo) {
		this.ticketNo = ticketNo;
	}
	public List<BillsSub> getBillsSubs() {
		return billsSubs;
	}
	public void setBillsSubs(List<BillsSub> billsSubs) {
		this.billsSubs = billsSubs;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getCustomerSupplierName() {
		return customerSupplierName;
	}
	public void setCustomerSupplierName(String customerSupplierName) {
		this.customerSupplierName = customerSupplierName;
	}
	public String getOriginatorName() {
		return originatorName;
	}
	public void setOriginatorName(String originatorName) {
		this.originatorName = originatorName;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPaymentName() {
		return paymentName;
	}
	public void setPaymentName(String paymentName) {
		this.paymentName = paymentName;
	}
 
 
	 
	 
}
