package com.jl.psi.model;

import java.util.Date;
import java.util.List;

/**
 * 组装/拆卸单
 * @author 柳亚婷
 * @Description: TODO
 * @date: 2018年6月19日 上午9:35:13
 */
public class PackageOrTeardownOrder {
	
	/**
	 * 主键id
	 */
    private Integer id;
    /**
     * 单据类型（1：组装单  2：拆卸单）
     */
    private Integer orderType;
    /**
     * 日期
     */
    private Date packageOrTeardownDate;
    /**
     * 单号
     */
    private String identifier;
    /**
     * 仓库id
     */
    private Integer warehouseId;
    /**
     * 商品规格id
     */
    private Integer commoditySpecificationId;
    /**
     * 组装/拆卸数量
     */
    private Integer packageOrTeardownNum;
    /**
     * 单价
     */
    private Double unitPrice;
    /**
     * 金额
     */
    private Double totalMoney;
    /**
     * 业务员id
     */
    private Integer personId;
    /**
     * 制单人编号
     */
    private String originator;
    /**
     * 审批人编号
     */
    private String reviewer;
    /**
     * 摘要
     */
    private String summary;
    /**
     * 状态(1:未送审，2：审批中，3：审批通过，4：审批驳回)
     */
    private Integer state;
    /**
     * 打印次数
     */
    private Integer printNum;
    
 // 根据结果需要，在model里另添格外的字段
    
    /**
     * 组装/拆卸的商品信息
     */
    private List<PackageOrTeardownOrderCommodity> packageOrTeardownOrderCommodities;
    /**
     * 商品规格名称
     */
    private String commoditySpecName;
    /**
     * 商品名称
     */
    private String commodityName;
    /**
     * 商品规格编号
     */
    private String commoditySpecIdentifier;
    /**
     * 商品基本单位
     */
    private String baseUnit;
    /**
     * 仓库名称
     */
    private String warehouseName;
    /**
     * 制单人名称
     */
    private String originatorName;
    /**
     * 审批人名称
     */
    private String reviewerName;
    /**
     * 部门名称
     */
    private String departmentName;
    /**
     * 是否已删除(0：未删，1：已删)
     */
	private Integer isDelete;  
	/**
     * 库存信息
     */
	private Inventory inventory;
	
    public Inventory getInventory() {
		return inventory;
	}

	public void setInventory(Inventory inventory) {
		this.inventory = inventory;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public Integer getPrintNum() {
		return printNum;
	}

	public void setPrintNum(Integer printNum) {
		this.printNum = printNum;
	}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderType() {
        return orderType;
    }

    public void setOrderType(Integer orderType) {
        this.orderType = orderType;
    }

    public Date getPackageOrTeardownDate() {
        return packageOrTeardownDate;
    }

    public void setPackageOrTeardownDate(Date packageOrTeardownDate) {
        this.packageOrTeardownDate = packageOrTeardownDate;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier == null ? null : identifier.trim();
    }

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }

    public Integer getCommoditySpecificationId() {
        return commoditySpecificationId;
    }

    public void setCommoditySpecificationId(Integer commoditySpecificationId) {
        this.commoditySpecificationId = commoditySpecificationId;
    }

    public Integer getPackageOrTeardownNum() {
        return packageOrTeardownNum;
    }

    public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Double getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(Double totalMoney) {
		this.totalMoney = totalMoney;
	}

	public void setPackageOrTeardownNum(Integer packageOrTeardownNum) {
        this.packageOrTeardownNum = packageOrTeardownNum;
    }

    public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    public String getOriginator() {
        return originator;
    }

    public void setOriginator(String originator) {
        this.originator = originator == null ? null : originator.trim();
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer == null ? null : reviewer.trim();
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

	public List<PackageOrTeardownOrderCommodity> getPackageOrTeardownOrderCommodities() {
		return packageOrTeardownOrderCommodities;
	}

	public void setPackageOrTeardownOrderCommodities(
			List<PackageOrTeardownOrderCommodity> packageOrTeardownOrderCommodities) {
		this.packageOrTeardownOrderCommodities = packageOrTeardownOrderCommodities;
	}

	public String getCommoditySpecName() {
		return commoditySpecName;
	}

	public void setCommoditySpecName(String commoditySpecName) {
		this.commoditySpecName = commoditySpecName;
	}

	public String getCommodityName() {
		return commodityName;
	}

	public void setCommodityName(String commodityName) {
		this.commodityName = commodityName;
	}

	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
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

	public String getCommoditySpecIdentifier() {
		return commoditySpecIdentifier;
	}

	public void setCommoditySpecIdentifier(String commoditySpecIdentifier) {
		this.commoditySpecIdentifier = commoditySpecIdentifier;
	}

	public String getBaseUnit() {
		return baseUnit;
	}

	public void setBaseUnit(String baseUnit) {
		this.baseUnit = baseUnit;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
    
    
}