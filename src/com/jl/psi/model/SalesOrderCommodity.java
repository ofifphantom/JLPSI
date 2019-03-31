package com.jl.psi.model;

import java.util.Date;

/**
 * 
 * @author 景雅倩
 * @date  2018年5月23日  上午10:47:52
 * @Description  销售订单商品Model
 */
public class SalesOrderCommodity {
	/**
	 * 主键
	 */
    private Integer id;
    
    /**
	 * 销售订单id
	 */
    private Integer salesOrderId;
    
    /**
	 * 商品规格id
	 */
    private Integer commoditySpecificationId;
    
    /**
	 * 发货数量
	 */
    private Integer deliverGoodsNum;
    /**
   	 * 金额
   	 */
    private Double deliverGoodsMoney;
    
    /**
	 * 返货数量
	 */
    private Integer returnGoodsNum;

    /**
	 * 签收数量
	 */
    private Integer receivingGoodsNum;
    /**
   	 * 签收金额
   	 */
    private Double receivingGoodsMoney;
    /**
	 * 折损数量
	 */
    private Integer damageNum;

    /**
	 * 折损金额
	 */
    private Double damageMoney;

    /**
	 * 折扣
	 */
    private Double discount;

    /**
	 * 单价
	 */
    private Double unitPrice;

    /**
	 * 税率
	 */
    private Double taxes;
    /**
   	 * 税额
   	 */
    private Double taxesMoney;

    /**
	 * 批号
	 */
    private String batchNumber;

    /**
	 * 备注
	 */
    private String remark;

    /**
	 * 是否申请特价(1：否,2：是)
	 */
    private Integer isSpecialOffer;
    /**
     * 商品所属仓库id
     */
    private Integer warehouseId;
    
    /**
     * app总退货金额
     */
    private Double appAmountMoney;
    
 // 根据结果需要，在model里另添格外的字段
    /**
     * 商品规格信息
     */
    CommoditySpecification commoditySpecification;
    /**
     * 仓库信息
     */
    Warehouse warehouse;
    /**
	 * 合计数量
	 */
    private Integer totalNum;
    /**
	 * 合计金额
	 */
    
    private Double totalMoney;
    private Date createTT;
    
    public Date getCreateTT() {
		return createTT;
	}

	public void setCreateTT(Date createTT) {
		this.createTT = createTT;
	}

	public Integer getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}

	public Double getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(Double totalMoney) {
		this.totalMoney = totalMoney;
	}

	/**
     * 申请特价之前的价格
     */
    private Double oldUnitPrice;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSalesOrderId() {
        return salesOrderId;
    }

    public void setSalesOrderId(Integer salesOrderId) {
        this.salesOrderId = salesOrderId;
    }

    public Integer getCommoditySpecificationId() {
        return commoditySpecificationId;
    }

    public void setCommoditySpecificationId(Integer commoditySpecificationId) {
        this.commoditySpecificationId = commoditySpecificationId;
    }

    public Integer getDeliverGoodsNum() {
        return deliverGoodsNum;
    }

    public void setDeliverGoodsNum(Integer deliverGoodsNum) {
        this.deliverGoodsNum = deliverGoodsNum;
    }

    public Integer getReturnGoodsNum() {
        return returnGoodsNum;
    }

    public void setReturnGoodsNum(Integer returnGoodsNum) {
        this.returnGoodsNum = returnGoodsNum;
    }

    public Integer getReceivingGoodsNum() {
        return receivingGoodsNum;
    }

    public void setReceivingGoodsNum(Integer receivingGoodsNum) {
        this.receivingGoodsNum = receivingGoodsNum;
    }

    public Integer getDamageNum() {
        return damageNum;
    }

    public void setDamageNum(Integer damageNum) {
        this.damageNum = damageNum;
    }

    public Double getDamageMoney() {
        return damageMoney;
    }

    public void setDamageMoney(Double damageMoney) {
        this.damageMoney = damageMoney;
    }

    public Double getDiscount() {
        return discount;
    }

    public void setDiscount(Double discount) {
        this.discount = discount;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Double getTaxes() {
        return taxes;
    }

    public void setTaxes(Double taxes) {
        this.taxes = taxes;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber == null ? null : batchNumber.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Integer getIsSpecialOffer() {
        return isSpecialOffer;
    }

    public void setIsSpecialOffer(Integer isSpecialOffer) {
        this.isSpecialOffer = isSpecialOffer;
    }

	public CommoditySpecification getCommoditySpecification() {
		return commoditySpecification;
	}

	public void setCommoditySpecification(CommoditySpecification commoditySpecification) {
		this.commoditySpecification = commoditySpecification;
	}

	public Double getDeliverGoodsMoney() {
		return deliverGoodsMoney;
	}

	public void setDeliverGoodsMoney(Double deliverGoodsMoney) {
		this.deliverGoodsMoney = deliverGoodsMoney;
	}

	public Double getReceivingGoodsMoney() {
		return receivingGoodsMoney;
	}

	public void setReceivingGoodsMoney(Double receivingGoodsMoney) {
		this.receivingGoodsMoney = receivingGoodsMoney;
	}

	public Double getTaxesMoney() {
		return taxesMoney;
	}

	public void setTaxesMoney(Double taxesMoney) {
		this.taxesMoney = taxesMoney;
	}

	public Integer getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(Integer warehouseId) {
		this.warehouseId = warehouseId;
	}

	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}

	public Double getOldUnitPrice() {
		return oldUnitPrice;
	}

	public void setOldUnitPrice(Double oldUnitPrice) {
		this.oldUnitPrice = oldUnitPrice;
	}

	public Double getAppAmountMoney() {
		return appAmountMoney;
	}

	public void setAppAmountMoney(Double appAmountMoney) {
		this.appAmountMoney = appAmountMoney;
	}

	
	
}