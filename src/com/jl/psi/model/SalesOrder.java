package com.jl.psi.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
/**
 * 
 * @author 景雅倩
 * @date  2018年5月23日  上午10:47:52
 * @Description  销售订单Model
 */

public class SalesOrder {

    /**
	 * 主键
	 */
    private Integer id;

    /**
	 * 销售订单id
	 */
    private Integer parentId;

    /**
	 * 编号
	 */
    private String identifier;

    /**
	 * 拆单码
	 */
    private String breakCode;

    /**
	 * 结算方式(1:预付款 ,2:货到付款 ,3:账期)
	 */
    private Integer payment;

    /**
	 * 单据类型(1:销售订单 ,2:销售开单 ,3:出库单 ,4:折损单 ,5:返货单)
	 */
    private Integer orderType;

    /**
	 * (生成)日期
	 */
    private Date createTime;
    
    /**
	 * (生成)日期-String
	 */
    private String createTimeString;

    /**
	 * 有效期至
	 */
    private Date endValidityTime;
    
    /**
	 * 有效期至-String
	 */
    private String endValidityTimeString;

    /**
	 * 发货地点
	 */
    private String deliverGoodsPlace;

    /**
	 * 收货地点
	 */
    private String receiptGoodsPlace;

    /**
	 * 收货人
	 */
    private String consignee;

    /**
	 * 联系电话
	 */
    private String phone;

    /**
	 * 传真
	 */
    private String fax;

    /**
	 * 订货人
	 */
    private String orderer;

    /**
	 * 预收金额
	 */
    private Double advanceScale;

    /**
	 * 制单人编号
	 */
    private String originator;

    /**
	 * 摘要
	 */
    private String summary;

    /**
	 * 分支机构
	 */
    private String branch;

    /**
	 * 状态（1：未送审，2：订单待审核，3：订单审核驳回，4：待收预付款，5：待打印出库单，6：只需销售领导审核的作废待审核，
	 *     7：需仓库审核的作废之销售领导审核待审核，8：仓库作废审核中，9：作废审核驳回，10：已作废，11：备货中，12：已出库，
	 *     13：销售开单待审核，14：销售开单驳回，15：已开单，16：申请修改待审核，17：申请修改审核驳回，18：申请修改审核通过，
	 *     19：折损单待审核，20：折损单审核驳回，21：折损单审核通过，22：销售开单折损单待审核，23：销售开单折损单审核驳回,24：可开单，
	 *     25：需仓库审核的作废审核驳回，26：已开返货单，27：退货单未送审，28：退货单待审核，29：退货单审核驳回，30：退货单审核通过，
	 *     31：已退货入库,32:未发货，33：已发货，34：需收预付款的作废待审核,35：待备货，36：其他发货单待财务审核，37：已删除）
	 */
    private Integer state;

    /**
	 * 是否是样品（1：否，2：是）
	 */
    private Integer isSpecimen;

    /**
	 * 客户id
	 */
    private Integer supctoId;

    /**
	 * 运输方式id
	 */
    private Integer shippingModeId;

    /**
	 * 业务员id
	 */
    private Integer personId;

    /**
	 * 销售计划单id
	 */
    private Integer salesPlanOrderId;
    /**
	 * 打印次数
	 */
    private Integer printNum;
    /**
     * 是否要显示 （1：不显示，2：显示）
     */
    private Integer isShow;
    /**
 	 * 是否被核销
 	 */
 	private Integer isVerification;
    
    /**
 	 * mis系统的订单id
 	 */
  	private	Integer missOrderId;
 	
	private Integer activityId;
  	
  	private Integer isAppOrder;
  	
    /**
     * app订单是否退货(0：否，1：是 申请退货中，2：已生成退货单，3：已退货入库)
     */
    private Integer isReturnGoods;
    /**
     * app订单编号
     */
    private String appOrderIdentifier;
    /**
     * app发货时间
     */
    private Date appSendTime;
    /**
     * 是否已生成备货单（0,：没有，1：有）(针对作废审核时的判断)
     */
    private Integer isCreateStockOrder;
    
    
 // 根据结果需要，在model里另添格外的字段
	
  	/**
  	 * 操作人信息
  	 */
  	Person person;
  	/**
  	 * 客户信息
  	 */
  	Supcto supcto;
  	/**
  	 * 销售商品信息
  	 */
  	List<SalesOrderCommodity> salesOrderCommodities;
  	/**
  	 * 运输方式
  	 */
  	ShippingMode shippingMode;
  	
  	/**
  	 * 每个销售订单下商品的保存的货品名称统计
  	 */
  	String commoditysName;
  	
  	
  	/**
  	 * 制单人名称
  	 */
  	String originatorName;
  	/**
  	 * 业务员名称
  	 */
  	String personName;
  	/**
  	 * 业务员部门名称
  	 */
  	String personDepartmentName;
  	
  	/**
  	 * 业务员部门ID
  	 */
  	String personDepartmentId;
  	/**
  	 * 订单审批人名称
  	 */
  	String reviewerName;
  	/**
  	 * 订单审批人编号
  	 */
  	String reviewerIdentifier;
  	
  	/**
  	 * 订单作废领导审批人名称
  	 */
  	String revokeLeaderName;
  	/**
  	 * 订单作废领导审批人编号
  	 */
  	String revokeLeaderIdentifier;
  	
  	/**
  	 * 订单作废仓库审批人名称
  	 */
  	String revokeWarehouseName;
  	/**
  	 * 订单作废仓库审批人编号
  	 */
  	String revokeWarehouseIdentifier;
  	
  	/**
  	 * 销售开单审批人名称
  	 */
  	String salesOpeningName;
  	/**
  	 * 销售开单审批人编号
  	 */
  	String salesOpeningIdentifier;
  	
  	/**
  	 * 申请修改审批人名称
  	 */
  	String revisionsalesOpeningName;
  	/**
  	 * 申请修改审批人编号
  	 */
  	String revisionsalesOpeningIdentifier;
  	
  	/**
  	 * 折损单审批人名称
  	 */
  	String foldLossName;
  	/**
  	 * 折损单审批人编号
  	 */
  	String foldLossIdentifier;
	
 	/**
 	 * 发出金额
 	 */
 	private	Double receiveMoney;
 	/**
 	 * 发出数量
 	 */
 	private	Integer receiveNum;
 	/**
 	 * 发出单价
 	 */
 	private	Double unitPrice;
 	/**
  	 * 关联的父销售订单的编号
  	 */
 	private	String parentIdentifier;
  	
  	/**
 	 * 返货数量
 	 */
  	private Integer returnGoodsNum;
  	/**
 	 * 折损数量
 	 */
  	private Integer damageGoodsNum;
  	
  	/**
  	 * 订单发货时间 ---取发货单的生成时间
  	 */
  	private Date ordersDeliveryTime;
  	/**
     * 商品所属仓库名称
     */
    private String warehouseName;
    /**
     * 商品库存信息
     */
  	private Inventory inventory;
  	
  	/**
 	 * 退货金额
 	 */
 	private	Double returnMoney;
  	
  	public Double getReturnMoney() {
		return returnMoney;
	}

	public void setReturnMoney(Double returnMoney) {
		this.returnMoney = returnMoney;
	}

	public Inventory getInventory() {
		return inventory;
	}

	public void setInventory(Inventory inventory) {
		this.inventory = inventory;
	}

	public Integer getReturnGoodsNum() {
		return returnGoodsNum;
	}

	public void setReturnGoodsNum(Integer returnGoodsNum) {
		this.returnGoodsNum = returnGoodsNum;
	}

	public Integer getDamageGoodsNum() {
		return damageGoodsNum;
	}

	public void setDamageGoodsNum(Integer damageGoodsNum) {
		this.damageGoodsNum = damageGoodsNum;
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

	public Integer getMissOrderId() {
		return missOrderId;
	}

	public void setMissOrderId(Integer missOrderId) {
		this.missOrderId = missOrderId;
	}

	public Double getReceiveMoney() {
		return receiveMoney;
	}

	public void setReceiveMoney(Double receiveMoney) {
		this.receiveMoney = receiveMoney;
	}

	public Integer getReceiveNum() {
		return receiveNum;
	}

	public void setReceiveNum(Integer receiveNum) {
		this.receiveNum = receiveNum;
	}

	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	String  departmentName;
    public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public Integer getIsVerification() {
		return isVerification;
	}

	public void setIsVerification(Integer isVerification) {
		this.isVerification = isVerification;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier == null ? null : identifier.trim();
    }

    public String getBreakCode() {
        return breakCode;
    }

    public void setBreakCode(String breakCode) {
        this.breakCode = breakCode == null ? null : breakCode.trim();
    }

    public Integer getPayment() {
        return payment;
    }

    public void setPayment(Integer payment) {
        this.payment = payment;
    }

    public Integer getOrderType() {
        return orderType;
    }

    public void setOrderType(Integer orderType) {
        this.orderType = orderType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getEndValidityTime() {
        return endValidityTime;
    }

    public void setEndValidityTime(Date endValidityTime) {
        this.endValidityTime = endValidityTime;
    }

    public String getDeliverGoodsPlace() {
        return deliverGoodsPlace;
    }

    public void setDeliverGoodsPlace(String deliverGoodsPlace) {
        this.deliverGoodsPlace = deliverGoodsPlace == null ? null : deliverGoodsPlace.trim();
    }

    public String getReceiptGoodsPlace() {
        return receiptGoodsPlace;
    }

    public void setReceiptGoodsPlace(String receiptGoodsPlace) {
        this.receiptGoodsPlace = receiptGoodsPlace == null ? null : receiptGoodsPlace.trim();
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee == null ? null : consignee.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax == null ? null : fax.trim();
    }

    public String getOrderer() {
        return orderer;
    }

    public void setOrderer(String orderer) {
        this.orderer = orderer == null ? null : orderer.trim();
    }

    public Double getAdvanceScale() {
        return advanceScale;
    }

    public void setAdvanceScale(Double advanceScale) {
        this.advanceScale = advanceScale;
    }

    public String getOriginator() {
        return originator;
    }

    public void setOriginator(String originator) {
        this.originator = originator == null ? null : originator.trim();
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

    public Integer getIsSpecimen() {
        return isSpecimen;
    }

    public void setIsSpecimen(Integer isSpecimen) {
        this.isSpecimen = isSpecimen;
    }

    public Integer getSupctoId() {
        return supctoId;
    }

    public void setSupctoId(Integer supctoId) {
        this.supctoId = supctoId;
    }

    public Integer getShippingModeId() {
        return shippingModeId;
    }

    public void setShippingModeId(Integer shippingModeId) {
        this.shippingModeId = shippingModeId;
    }

    public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    public Integer getSalesPlanOrderId() {
        return salesPlanOrderId;
    }

    public void setSalesPlanOrderId(Integer salesPlanOrderId) {
        this.salesPlanOrderId = salesPlanOrderId;
    }

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public Supcto getSupcto() {
		return supcto;
	}

	public void setSupcto(Supcto supcto) {
		this.supcto = supcto;
	}

	public List<SalesOrderCommodity> getSalesOrderCommodities() {
		return salesOrderCommodities;
	}

	public void setSalesOrderCommodities(List<SalesOrderCommodity> salesOrderCommodities) {
		this.salesOrderCommodities = salesOrderCommodities;
	}

	public ShippingMode getShippingMode() {
		return shippingMode;
	}

	public void setShippingMode(ShippingMode shippingMode) {
		this.shippingMode = shippingMode;
	}

	public String getCommoditysName() {
		return commoditysName;
	}

	public void setCommoditysName(String commoditysName) {
		this.commoditysName = commoditysName;
	}

	

	public String getOriginatorName() {
		return originatorName;
	}

	public void setOriginatorName(String originatorName) {
		this.originatorName = originatorName;
	}

	public Integer getPrintNum() {
		return printNum;
	}

	public void setPrintNum(Integer printNum) {
		this.printNum = printNum;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getPersonDepartmentName() {
		return personDepartmentName;
	}

	public void setPersonDepartmentName(String personDepartmentName) {
		this.personDepartmentName = personDepartmentName;
	}

	public String getReviewerName() {
		return reviewerName;
	}

	public void setReviewerName(String reviewerName) {
		this.reviewerName = reviewerName;
	}

	public String getRevokeLeaderName() {
		return revokeLeaderName;
	}

	public void setRevokeLeaderName(String revokeLeaderName) {
		this.revokeLeaderName = revokeLeaderName;
	}

	public String getRevokeWarehouseName() {
		return revokeWarehouseName;
	}

	public void setRevokeWarehouseName(String revokeWarehouseName) {
		this.revokeWarehouseName = revokeWarehouseName;
	}

	public String getSalesOpeningName() {
		return salesOpeningName;
	}

	public void setSalesOpeningName(String salesOpeningName) {
		this.salesOpeningName = salesOpeningName;
	}

	public String getRevisionsalesOpeningName() {
		return revisionsalesOpeningName;
	}

	public void setRevisionsalesOpeningName(String revisionsalesOpeningName) {
		this.revisionsalesOpeningName = revisionsalesOpeningName;
	}

	public String getFoldLossName() {
		return foldLossName;
	}

	public void setFoldLossName(String foldLossName) {
		this.foldLossName = foldLossName;
	}

	public String getReviewerIdentifier() {
		return reviewerIdentifier;
	}

	public void setReviewerIdentifier(String reviewerIdentifier) {
		this.reviewerIdentifier = reviewerIdentifier;
	}

	public String getRevokeLeaderIdentifier() {
		return revokeLeaderIdentifier;
	}

	public void setRevokeLeaderIdentifier(String revokeLeaderIdentifier) {
		this.revokeLeaderIdentifier = revokeLeaderIdentifier;
	}

	public String getRevokeWarehouseIdentifier() {
		return revokeWarehouseIdentifier;
	}

	public void setRevokeWarehouseIdentifier(String revokeWarehouseIdentifier) {
		this.revokeWarehouseIdentifier = revokeWarehouseIdentifier;
	}

	public String getSalesOpeningIdentifier() {
		return salesOpeningIdentifier;
	}

	public void setSalesOpeningIdentifier(String salesOpeningIdentifier) {
		this.salesOpeningIdentifier = salesOpeningIdentifier;
	}

	public String getRevisionsalesOpeningIdentifier() {
		return revisionsalesOpeningIdentifier;
	}

	public void setRevisionsalesOpeningIdentifier(String revisionsalesOpeningIdentifier) {
		this.revisionsalesOpeningIdentifier = revisionsalesOpeningIdentifier;
	}

	public String getFoldLossIdentifier() {
		return foldLossIdentifier;
	}

	public void setFoldLossIdentifier(String foldLossIdentifier) {
		this.foldLossIdentifier = foldLossIdentifier;
	}
	public String getEndValidityTimeString() {
		return endValidityTimeString;
	}

	public void setEndValidityTimeString(String endValidityTimeString) {
		this.endValidityTimeString = endValidityTimeString;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.endValidityTime=sdf.parse(endValidityTimeString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.endValidityTime=null;
		}
	}

	public String getCreateTimeString() {
		return createTimeString;
	}

	public void setCreateTimeString(String createTimeString) {
		this.createTimeString = createTimeString;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			this.createTime=sdf.parse(createTimeString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.createTime=null;
		}
	}

	public String getPersonDepartmentId() {
		return personDepartmentId;
	}

	public void setPersonDepartmentId(String personDepartmentId) {
		this.personDepartmentId = personDepartmentId;
	}

	public Integer getIsShow() {
		return isShow;
	}

	public void setIsShow(Integer isShow) {
		this.isShow = isShow;
	}

	public String getParentIdentifier() {
		return parentIdentifier;
	}

	public void setParentIdentifier(String parentIdentifier) {
		this.parentIdentifier = parentIdentifier;
	}

	public Integer getIsReturnGoods() {
		return isReturnGoods;
	}

	public void setIsReturnGoods(Integer isReturnGoods) {
		this.isReturnGoods = isReturnGoods;
	}

	public String getAppOrderIdentifier() {
		return appOrderIdentifier;
	}

	public void setAppOrderIdentifier(String appOrderIdentifier) {
		this.appOrderIdentifier = appOrderIdentifier;
	}

	public Date getOrdersDeliveryTime() {
		return ordersDeliveryTime;
	}

	public void setOrdersDeliveryTime(Date ordersDeliveryTime) {
		this.ordersDeliveryTime = ordersDeliveryTime;
	}

	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}

	public Date getAppSendTime() {
		return appSendTime;
	}

	public void setAppSendTime(Date appSendTime) {
		this.appSendTime = appSendTime;
	}

	public Integer getIsCreateStockOrder() {
		return isCreateStockOrder;
	}

	public void setIsCreateStockOrder(Integer isCreateStockOrder) {
		this.isCreateStockOrder = isCreateStockOrder;
	}

	
	
	
    
}