package com.jl.psi.model;
/**
 * 
 * @author 景雅倩
 * @date  2018年6月04日  上午10:21:50
 * @Description  销售计划单商品Model
 */
public class SalesPlanOrderCommodity {
	/**
	 * 主键
	 */
    private Integer id;
    /**
	 * 销售计划单id
	 */
    private Integer salesPlanOrderId;
    /**
	 * 商品规格id
	 */
    private Integer commoditySpecificationId;
    /**
	 * 业务数量
	 */
    private Integer number;
    /**
	 * 业务单价
	 */
    private Double unitPrice;
    /**
	 * 金额
	 */
    private Double money;
    /**
	 * 备注
	 */
    private String remark;
 // 根据结果需要，在model里另添格外的字段
    /**
     * 商品规格信息
     */
    CommoditySpecification commoditySpecification;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

   
    public Integer getSalesPlanOrderId() {
		return salesPlanOrderId;
	}

	public void setSalesPlanOrderId(Integer salesPlanOrderId) {
		this.salesPlanOrderId = salesPlanOrderId;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

	public CommoditySpecification getCommoditySpecification() {
		return commoditySpecification;
	}

	public void setCommoditySpecification(CommoditySpecification commoditySpecification) {
		this.commoditySpecification = commoditySpecification;
	}
    
}