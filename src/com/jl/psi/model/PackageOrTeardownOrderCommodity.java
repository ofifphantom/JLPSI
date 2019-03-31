package com.jl.psi.model;

/**
 * 组装/拆卸单商品
 * @author 柳亚婷
 * @Description: TODO
 * @date: 2018年6月19日 上午9:34:58
 */
public class PackageOrTeardownOrderCommodity {
	
	/**
	 * 主键id
	 */
    private Integer id;
    /**
     * 组装/拆卸单id
     */
    private Integer packageOrTeardownOrderId;
    /**
     * 商品规格id
     */
    private Integer commoditySpecificationId;
    /**
     * 数量
     */
    private Integer number;
    /**
     * 单价	
     */
    private Double unitPrice;
    /**
     * 金额
     */
    private Double money;

 // 根据结果需要，在model里另添格外的字段
    /**
     * 商品所在的仓库id
     */
    private Integer specWarehouseId;
    /**
     * 商品所在的仓库名称
     */
    private String specWarehouseName;
    /**
     * 商品名称
     */
    private String poocCommName;
    /**
     * 商品规格名称
     */
    private String poocSpecName;
    /**
     * 商品规格编号
     */
    private String poocCommoditySpecIdentifier;
    /**
     * 商品基本单位
     */
    private String poocBaseUnit;
    /**
     * 是否有仓库信息
     */
    private String poocIsHasWarehouse;
    /**
     * 商品规格信息
     */
    CommoditySpecification commoditySpecification;
    
    public CommoditySpecification getCommoditySpecification() {
		return commoditySpecification;
	}

	public void setCommoditySpecification(CommoditySpecification commoditySpecification) {
		this.commoditySpecification = commoditySpecification;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPackageOrTeardownOrderId() {
        return packageOrTeardownOrderId;
    }

    public void setPackageOrTeardownOrderId(Integer packageOrTeardownOrderId) {
        this.packageOrTeardownOrderId = packageOrTeardownOrderId;
    }

    public Integer getCommoditySpecificationId() {
        return commoditySpecificationId;
    }

    public void setCommoditySpecificationId(Integer commoditySpecificationId) {
        this.commoditySpecificationId = commoditySpecificationId;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

	public Integer getSpecWarehouseId() {
		return specWarehouseId;
	}

	public void setSpecWarehouseId(Integer specWarehouseId) {
		this.specWarehouseId = specWarehouseId;
	}

	public String getPoocCommName() {
		return poocCommName;
	}

	public void setPoocCommName(String poocCommName) {
		this.poocCommName = poocCommName;
	}

	public String getPoocSpecName() {
		return poocSpecName;
	}

	public void setPoocSpecName(String poocSpecName) {
		this.poocSpecName = poocSpecName;
	}

	public String getPoocCommoditySpecIdentifier() {
		return poocCommoditySpecIdentifier;
	}

	public void setPoocCommoditySpecIdentifier(String poocCommoditySpecIdentifier) {
		this.poocCommoditySpecIdentifier = poocCommoditySpecIdentifier;
	}

	public String getPoocBaseUnit() {
		return poocBaseUnit;
	}

	public void setPoocBaseUnit(String poocBaseUnit) {
		this.poocBaseUnit = poocBaseUnit;
	}
	
	public String getPoocIsHasWarehouse() {
		return poocIsHasWarehouse;
	}

	public void setPoocIsHasWarehouse(String poocIsHasWarehouse) {
		this.poocIsHasWarehouse = poocIsHasWarehouse;
	}

	public String getSpecWarehouseName() {
		return specWarehouseName;
	}

	public void setSpecWarehouseName(String specWarehouseName) {
		this.specWarehouseName = specWarehouseName;
	}
    
}