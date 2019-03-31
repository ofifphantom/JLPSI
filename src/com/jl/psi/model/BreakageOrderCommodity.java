package com.jl.psi.model;
/**
 * 报损单商品model
 * @author 景雅倩
 * @date 2018年6月14日 下午4:50:16
 */
public class BreakageOrderCommodity {
    private Integer id;
	/**
	 * 报损单id
	 */
    private Integer breakageOrderId;
	/**
	 * 商品规格id	
	 */
    private Integer commoditySpecificationId;
	/**
	 * 报损数量
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
    
    //以下是根据需要添加的字段
    CommoditySpecification commoditySpecification;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBreakageOrderId() {
        return breakageOrderId;
    }

    public void setBreakageOrderId(Integer breakageOrderId) {
        this.breakageOrderId = breakageOrderId;
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

	public CommoditySpecification getCommoditySpecification() {
		return commoditySpecification;
	}

	public void setCommoditySpecification(CommoditySpecification commoditySpecification) {
		this.commoditySpecification = commoditySpecification;
	}
    
}