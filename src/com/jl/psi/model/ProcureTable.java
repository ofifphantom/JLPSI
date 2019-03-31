package com.jl.psi.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 采购计划单/采购订单表
 * @author 柳亚婷
 * @date  2018年4月18日  上午10:58:39
 * @Description 
 *
 */
public class ProcureTable {
	/**
	 * 主键
	 */
    private Integer id;
    /**
	 * 单据编号
	 */
    private String identifier;
    /**
	 * 单据生成日期
	 */
    private Date generateDate;
    /**
	 * 单据生成日期--String类型
	 */
    private String generateDateString;
    /**
	 * 供应商id
	 */
    private String supctoId;
    /**
	 * 有效期至
	 */
    private Date effectivePeriodEnd;
    /**
	 * 有效期至--String类型
	 */
    private String effectivePeriodEndString;
    /**
	 * 到货时间
	 */
    private Date goodsArrivalTime;
    /**
	 * 到货时间--String类型
	 */
    private String goodsArrivalTimeString;
    /**
	 * 到货地点
	 */
    private String goodsArrivalPlace;
    /**
	 * 运输方式
	 */
    private Integer transportationMode;
    /**
	 * 送货人
	 */
    private String deliveryman;
    /**
	 * 传真
	 */
    private String fax;
    /**
	 * 联系电话
	 */
    private String phone;
    /**
	 * 订货人
	 */
    private String orderer;
    /**
	 * 预付金额
	 */
    private Double prepaidAmount;
    /**
	 * 部门id
	 */
    private Integer departmentId;
    /**
	 * 制单人
	 */
    private String originator;
    /**
	 * 审核人
	 */
    private String reviewer;
    
    /**
	 * 终止审核人编号
	 */
    private String terminator;
    /**
	 * 摘要
	 */
    private String summary;
    /**
	 * 分支机构
	 */
    private String branch;
    /**
	 * 状态(1:未审核，2:已送审 3：已通过，4：已驳回，5：待付款，6：已付款，7：已撤销，8：终止审核中，9终止审核通过，10：终止审核驳回，11：部分完成，12：已完成)
	 */
    private Integer state;
    /**
	 * 打印次数
	 */
    private Integer printNum;
    /**
	 * 采购计划单 单据类型(1:负库存商品采购计划单,2:预售商品采购计划单)
	 */
    private Integer planType;
    /**
     * 付款方式id
     */
    private Integer payType;
    /**
     * 合同号
     */
    private String contractNumber;
    /**
	 * 计划单/订单(1:计划单  2:订单  3:入库单)
	 */
    private Integer planOrOrder;
    /**
     * 之前是否是计划单(0:不是，1：是)
     */
    private Integer beforeIsPlan;
    /**
     * 支付凭证1
     */
    private String paymentEvidence1;
    /**
     * 支付凭证2
     */
    private String paymentEvidence2;
    /**
     * 支付凭证3
     */
    private String paymentEvidence3;
    /**
     * 支付凭证4
     */
    private String paymentEvidence4;
    /**
     * 支付凭证5
     */
    private String paymentEvidence5;
    /**
     * 支付凭证6
     */
    private String paymentEvidence6;
    /**
     * 是否已删除(0：未删，1：已删)
     */
    private Integer isDelete;
    /**
     * 销售订单id(供生成销售订单/销售计划单之外的单据使用）
     */
    private Integer parentId;
    /**
     * 部分入库单的后缀号
     */
    private Integer postfix;
    /**
     * 单据类型(采购开单使用)
     */
    private Integer orderType;
    /**
     * 部门
     */
    private Department department;
    /**
     * 财务审核人编号(供其他收货单审批使用)
     */
    private String financialReviewer;
    /**
     * 是否是其他收货单引用来的(供其他收货单引用生成入库单使用)
     */
    private Integer isOtherReceipts;
    
 // 根据结果需要，在model里另添格外的字段
	
 	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}
	
	/**
 	 * 操作人信息
 	 */
 	Person person;
 	/**
 	 * 供货商信息
 	 */
 	Supcto supcto;
 	/**
 	 * 采购商品信息
 	 */
 	List<ProcureCommodity> procureCommoditys;
 	/**
 	 * 运输方式
 	 */
 	ShippingMode shippingMode;
 	/**
 	 * 结算方式
 	 */
 	SettlementType settlementType;
 	/**
 	 * 采购订单编号(供不是采购订单的单据显示)
 	 */
 	String procureTableIdentifier;
 	/**
 	 * 每个采购表下采购商品的保存的货品名称统计
 	 */
 	String commoditysName;
 	/**
 	 * 每个采购表下采购商品的保存的货品对应的业务单价统计
 	 */
 	String businessUnitPrices;
 	/**
 	 * 每个采购表下采购商品的业务数量/订单数量统计
 	 */
 	String orderNums;
 	/**
 	 * 每个采购表下采购商品的 价税合计统计
 	 */
 	String totalTaxPrices;
 	/**
 	 * 制单人名称
 	 */
 	String originatorName;
 	/**
 	 * 审核人名称
 	 */
 	String reviewerName;
 	/**
 	 * 终止审核人名称
 	 */
 	String terminatorName;
 	/**
 	 * 财务审核人名称(供其他收货单审批使用)
 	 */
 	String financialReviewerName;
 	/**
 	 * 部门名称
 	 */
 	String departmentName;
 	/**
 	 * 是否被核销
 	 */
 	private Integer isVerification;
 	/**
 	 * 仓库
 	 */
 	Warehouse warehouse;
 	/**
 	 * 单位名称
 	 */
 	String unitName;
 	/**
 	 * 上期结存单价
 	 */
 	Double unitPrice;
 	/**
 	 * 剩余数量
 	 */
 	Integer inventoryNum;
 	/**
 	 * 入库数量
 	 */
 	Integer arrivalNum;
 	/**
 	 * 退货数量
 	 */
 	Integer returnNum;
 	/**
 	 * 退货数量
 	 */
 	Double returnMoney;
 	
 	public Integer getReturnNum() {
		return returnNum;
	}

	public void setReturnNum(Integer returnNum) {
		this.returnNum = returnNum;
	}

	public Double getReturnMoney() {
		return returnMoney;
	}

	public void setReturnMoney(Double returnMoney) {
		this.returnMoney = returnMoney;
	}

	public Integer getArrivalNum() {
		return arrivalNum;
	}

	public void setArrivalNum(Integer arrivalNum) {
		this.arrivalNum = arrivalNum;
	}

	/**
 	 * 活动id
 	 */
 	private Integer activityId;
 	/**
 	 * 是否是APP订单（1：否  2：是）
 	 */
 	private Integer isAppOrder;
 	/**
 	 * 上期结存金额
 	 */
 	private Bills bills;
 	/**
 	 * 库存表
 	 */
 	private Inventory inventory;
 	
 	public Inventory getInventory() {
		return inventory;
	}

	public void setInventory(Inventory inventory) {
		this.inventory = inventory;
	}

	public Bills getBills() {
		return bills;
	}

	public void setBills(Bills bills) {
		this.bills = bills;
	}

	Double totalPrice;
 	
    public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Integer getInventoryNum() {
		return inventoryNum;
	}

	public void setInventoryNum(Integer inventoryNum) {
		this.inventoryNum = inventoryNum;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier == null ? null : identifier.trim();
    }

    public Date getGenerateDate() {
        return generateDate;
    }

    public void setGenerateDate(Date generateDate) {
        this.generateDate = generateDate;
    }

    public String getSupctoId() {
        return supctoId;
    }

    public void setSupctoId(String supctoId) {
        this.supctoId = supctoId == null ? null : supctoId.trim();
    }

    public Date getEffectivePeriodEnd() {
        return effectivePeriodEnd;
    }

    public void setEffectivePeriodEnd(Date effectivePeriodEnd) {
        this.effectivePeriodEnd = effectivePeriodEnd;
    }

    public Date getGoodsArrivalTime() {
        return goodsArrivalTime;
    }

    public void setGoodsArrivalTime(Date goodsArrivalTime) {
        this.goodsArrivalTime = goodsArrivalTime;
    }

    public String getGoodsArrivalPlace() {
        return goodsArrivalPlace;
    }

    public void setGoodsArrivalPlace(String goodsArrivalPlace) {
        this.goodsArrivalPlace = goodsArrivalPlace == null ? null : goodsArrivalPlace.trim();
    }

    public Integer getTransportationMode() {
        return transportationMode;
    }

    public void setTransportationMode(Integer transportationMode) {
        this.transportationMode = transportationMode;
    }

    public String getDeliveryman() {
        return deliveryman;
    }

    public void setDeliveryman(String deliveryman) {
        this.deliveryman = deliveryman == null ? null : deliveryman.trim();
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax == null ? null : fax.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getOrderer() {
        return orderer;
    }

    public void setOrderer(String orderer) {
        this.orderer = orderer == null ? null : orderer.trim();
    }

    public Double getPrepaidAmount() {
        return prepaidAmount;
    }

    public void setPrepaidAmount(Double prepaidAmount) {
        this.prepaidAmount = prepaidAmount;
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public String getOriginator() {
        return originator;
    }

    public void setOriginator(String originator) {
        this.originator = originator ;
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer;
    }
    
    

    public String getTerminator() {
		return terminator;
	}

	public void setTerminator(String terminator) {
		this.terminator = terminator;
	}

	public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch == null ? null : branch.trim();
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getPrintNum() {
        return printNum;
    }

    public void setPrintNum(Integer printNum) {
        this.printNum = printNum;
    }

    public Integer getPlanType() {
        return planType;
    }

    public void setPlanType(Integer planType) {
        this.planType = planType;
    }

    public Integer getPlanOrOrder() {
        return planOrOrder;
    }

    public void setPlanOrOrder(Integer planOrOrder) {
        this.planOrOrder = planOrOrder;
    }

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public List<ProcureCommodity> getProcureCommoditys() {
		return procureCommoditys;
	}

	public void setProcureCommoditys(List<ProcureCommodity> procureCommoditys) {
		this.procureCommoditys = procureCommoditys;
	}

	public Supcto getSupcto() {
		return supcto;
	}

	public void setSupcto(Supcto supcto) {
		this.supcto = supcto;
	}

	public String getCommoditysName() {
		return commoditysName;
	}

	public void setCommoditysName(String commoditysName) {
		this.commoditysName = commoditysName;
	}

	public String getBusinessUnitPrices() {
		return businessUnitPrices;
	}

	public void setBusinessUnitPrices(String businessUnitPrices) {
		this.businessUnitPrices = businessUnitPrices;
	}

	public String getOrderNums() {
		return orderNums;
	}

	public void setOrderNums(String orderNums) {
		this.orderNums = orderNums;
	}

	public Integer getPayType() {
		return payType;
	}

	public void setPayType(Integer payType) {
		this.payType = payType;
	}

	public String getTotalTaxPrices() {
		return totalTaxPrices;
	}

	public void setTotalTaxPrices(String totalTaxPrices) {
		this.totalTaxPrices = totalTaxPrices;
	}

	public String getContractNumber() {
		return contractNumber;
	}

	public void setContractNumber(String contractNumber) {
		this.contractNumber = contractNumber;
	}

	public String getOriginatorName() {
		return originatorName;
	}

	public void setOriginatorName(String originatorName) {
		this.originatorName = originatorName;
	}

	public String getReviewerName() {
		return reviewerName;
	}

	public void setReviewerName(String reviewerName) {
		this.reviewerName = reviewerName;
	}

	public String getTerminatorName() {
		return terminatorName;
	}

	public void setTerminatorName(String terminatorName) {
		this.terminatorName = terminatorName;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public ShippingMode getShippingMode() {
		return shippingMode;
	}

	public void setShippingMode(ShippingMode shippingMode) {
		this.shippingMode = shippingMode;
	}

	public SettlementType getSettlementType() {
		return settlementType;
	}

	public void setSettlementType(SettlementType settlementType) {
		this.settlementType = settlementType;
	}

	public Integer getBeforeIsPlan() {
		return beforeIsPlan;
	}

	public void setBeforeIsPlan(Integer beforeIsPlan) {
		this.beforeIsPlan = beforeIsPlan;
	}

	public String getPaymentEvidence1() {
		return paymentEvidence1;
	}

	public void setPaymentEvidence1(String paymentEvidence1) {
		this.paymentEvidence1 = paymentEvidence1;
	}

	public String getPaymentEvidence2() {
		return paymentEvidence2;
	}

	public void setPaymentEvidence2(String paymentEvidence2) {
		this.paymentEvidence2 = paymentEvidence2;
	}

	public String getPaymentEvidence3() {
		return paymentEvidence3;
	}

	public void setPaymentEvidence3(String paymentEvidence3) {
		this.paymentEvidence3 = paymentEvidence3;
	}

	public String getPaymentEvidence4() {
		return paymentEvidence4;
	}

	public void setPaymentEvidence4(String paymentEvidence4) {
		this.paymentEvidence4 = paymentEvidence4;
	}

	public String getPaymentEvidence5() {
		return paymentEvidence5;
	}

	public void setPaymentEvidence5(String paymentEvidence5) {
		this.paymentEvidence5 = paymentEvidence5;
	}

	public String getPaymentEvidence6() {
		return paymentEvidence6;
	}

	public void setPaymentEvidence6(String paymentEvidence6) {
		this.paymentEvidence6 = paymentEvidence6;
	}

	public String getGenerateDateString() {
		return generateDateString;
	}

	/*public void setGenerateDateString(String generateDateString) {
		this.generateDateString = generateDateString;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			this.generateDate=sdf.parse(generateDateString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.generateDate=null;
		}
	}*/

	public String getEffectivePeriodEndString() {
		return effectivePeriodEndString;
	}

	public void setEffectivePeriodEndString(String effectivePeriodEndString) {
		this.effectivePeriodEndString = effectivePeriodEndString;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.effectivePeriodEnd=sdf.parse(effectivePeriodEndString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.effectivePeriodEnd=null;
		}
	}

	public String getGoodsArrivalTimeString() {
		return goodsArrivalTimeString;
	}

	public void setGoodsArrivalTimeString(String goodsArrivalTimeString) {
		this.goodsArrivalTimeString = goodsArrivalTimeString;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.goodsArrivalTime=sdf.parse(goodsArrivalTimeString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.goodsArrivalTime=null;
		}
		
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Integer getPostfix() {
		return postfix;
	}

	public void setPostfix(Integer postfix) {
		this.postfix = postfix;
	}

	public Integer getOrderType() {
		return orderType;
	}
	

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public Integer getIsAppOrder() {
		return isAppOrder;
	}

	public void setIsAppOrder(Integer isAppOrder) {
		this.isAppOrder = isAppOrder;
	}

	public void setOrderType(Integer orderType) {
		this.orderType = orderType;
	}

	public Integer getIsVerification() {
		return isVerification;
	}

	public void setIsVerification(Integer isVerification) {
		this.isVerification = isVerification;
	}

	public String getProcureTableIdentifier() {
		return procureTableIdentifier;
	}

	public void setProcureTableIdentifier(String procureTableIdentifier) {
		this.procureTableIdentifier = procureTableIdentifier;
	}

	public String getFinancialReviewer() {
		return financialReviewer;
	}

	public void setFinancialReviewer(String financialReviewer) {
		this.financialReviewer = financialReviewer;
	}

	public String getFinancialReviewerName() {
		return financialReviewerName;
	}

	public void setFinancialReviewerName(String financialReviewerName) {
		this.financialReviewerName = financialReviewerName;
	}

	public Integer getIsOtherReceipts() {
		return isOtherReceipts;
	}

	public void setIsOtherReceipts(Integer isOtherReceipts) {
		this.isOtherReceipts = isOtherReceipts;
	}
	
	
    
}