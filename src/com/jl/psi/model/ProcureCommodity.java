package com.jl.psi.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * 采购计划单/采购订单 商品信息
 * @author 柳亚婷
 * @date  2018年4月18日  上午10:58:43
 * @Description 
 *
 */
public class ProcureCommodity {
	/**
	 * 主键
	 */
    private Integer id;
    /**
	 * 商品id
	 */
    private Integer commodityId;
    /**
	 * 采购计划单/订单id
	 */
    private Integer procureTableId;
    /**
	 * 税率
	 */
    private Double taxRate;
    /**
	 * 税额
	 */
    private Double amountOfTax;
    /**
	 * 价税合计
	 */
    private Double totalTaxPrice;
    /**
	 * 业务数量/订单数量
	 */
    private Integer orderNum;
    /**
	 * 批号
	 */
    private String lotNumber;
    /**
	 * 到货数量
	 */
    private Integer arrivalQuantity;
    /**
	 * 中止数量
	 */
    private Integer suspendQuantity;
    /**
	 * 中止金额
	 */
    private Double suspendPrice;
    /**
	 * 折扣
	 */
    private Integer discount;
    /**
	 * 是否是赠品(0:不是，1：是)
	 */
    private Integer isLargess;
    /**
     * 原始单价
     */
    private Double originalUnitPrice;
    /**
	 * 业务单价
	 */
    private Double businessUnitPrice;
    /**
	 * 备注
	 */
    private String remarks;
    /**
	 * 含税价
	 */
    private Double containsTaxPrice;
    /**
	 * 货款
	 */
    private Double paymentForGoods;
    /**
	 * 金额
	 */
    private Double totalPrice;
    
 // 根据结果需要，在model里另添格外的字段
    /**
     * 商品规格信息
     */
    CommoditySpecification commoditySpecification;
    /**
 	 * 商品规格所在的仓库
 	 */
    
 	private Integer specWarehouseId;
 	/**
	 * 到货金额
	 */
    private Double arrivalMoney;
    /**
	 * 剩余金额
	 */
    private Double surplusMoney;
    /**
	 * 剩余数量
	 */
    private Integer surplusNum;
    
    public Double getArrivalMoney() {
		return arrivalMoney;
	}

	public void setArrivalMoney(Double arrivalMoney) {
		this.arrivalMoney = arrivalMoney;
	}

	public Double getSurplusMoney() {
		return surplusMoney;
	}

	public void setSurplusMoney(Double surplusMoney) {
		this.surplusMoney = surplusMoney;
	}

	public Integer getSurplusNum() {
		return surplusNum;
	}

	public void setSurplusNum(Integer surplusNum) {
		this.surplusNum = surplusNum;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(Integer commodityId) {
        this.commodityId = commodityId;
    }

    public Integer getProcureTableId() {
        return procureTableId;
    }

    public void setProcureTableId(Integer procureTableId) {
        this.procureTableId = procureTableId;
    }

    public Double getTaxRate() {
        return taxRate;
    }

    public void setTaxRate(Double taxRate) {
        this.taxRate = taxRate;
    }

    public Double getAmountOfTax() {
        return amountOfTax;
    }

    public void setAmountOfTax(Double amountOfTax) {
        this.amountOfTax = amountOfTax;
    }

    public Double getTotalTaxPrice() {
        return totalTaxPrice;
    }

    public void setTotalTaxPrice(Double totalTaxPrice) {
        this.totalTaxPrice = totalTaxPrice;
    }

    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public String getLotNumber() {
        return lotNumber;
    }

    public void setLotNumber(String lotNumber) {
        this.lotNumber = lotNumber == null ? null : lotNumber.trim();
    }

    public Integer getArrivalQuantity() {
        return arrivalQuantity;
    }

    public void setArrivalQuantity(Integer arrivalQuantity) {
        this.arrivalQuantity = arrivalQuantity;
    }

    public Integer getSuspendQuantity() {
        return suspendQuantity;
    }

    public void setSuspendQuantity(Integer suspendQuantity) {
        this.suspendQuantity = suspendQuantity;
    }

    public Double getSuspendPrice() {
        return suspendPrice;
    }

    public void setSuspendPrice(Double suspendPrice) {
        this.suspendPrice = suspendPrice;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public Integer getIsLargess() {
        return isLargess;
    }

    public void setIsLargess(Integer isLargess) {
        this.isLargess = isLargess;
    }

    public Double getBusinessUnitPrice() {
        return businessUnitPrice;
    }

    public void setBusinessUnitPrice(Double businessUnitPrice) {
        this.businessUnitPrice = businessUnitPrice;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public Double getContainsTaxPrice() {
        return containsTaxPrice;
    }

    public void setContainsTaxPrice(Double containsTaxPrice) {
        this.containsTaxPrice = containsTaxPrice;
    }

    public Double getPaymentForGoods() {
        return paymentForGoods;
    }

    public void setPaymentForGoods(Double paymentForGoods) {
        this.paymentForGoods = paymentForGoods;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

	public Double getOriginalUnitPrice() {
		return originalUnitPrice;
	}

	public void setOriginalUnitPrice(Double originalUnitPrice) {
		this.originalUnitPrice = originalUnitPrice;
	}

	public CommoditySpecification getCommoditySpecification() {
		return commoditySpecification;
	}

	public void setCommoditySpecification(CommoditySpecification commoditySpecification) {
		this.commoditySpecification = commoditySpecification;
	}

	public Integer getSpecWarehouseId() {
		return specWarehouseId;
	}

	public void setSpecWarehouseId(Integer specWarehouseId) {
		this.specWarehouseId = specWarehouseId;
	}

    
}