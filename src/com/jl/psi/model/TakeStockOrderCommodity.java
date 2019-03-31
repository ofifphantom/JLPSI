package com.jl.psi.model;
/**
 * 盘点单商品model
 * @author 景雅倩
 * @date 2018年6月11日 下午6:51:26
 */
public class TakeStockOrderCommodity {
    private Integer id;
    /**
     * 盘点单id
     */
    private Integer takeStockOrderId;
    /**
     * 商品规格id
     */
    private Integer commoditySpecificationId;
    /**
     * 账面数量
     */
    private Integer inventoryNum;
    /**
     * 实盘数量
     */
    private Integer realNum;
    /**
     * 盈亏数量
     */
    private Integer profitOrLossNum;
    /**
     * 业务单价(移动平均价)
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

    public Integer getTakeStockOrderId() {
        return takeStockOrderId;
    }

    public void setTakeStockOrderId(Integer takeStockOrderId) {
        this.takeStockOrderId = takeStockOrderId;
    }

    public Integer getCommoditySpecificationId() {
        return commoditySpecificationId;
    }

    public void setCommoditySpecificationId(Integer commoditySpecificationId) {
        this.commoditySpecificationId = commoditySpecificationId;
    }

    public Integer getInventoryNum() {
        return inventoryNum;
    }

    public void setInventoryNum(Integer inventoryNum) {
        this.inventoryNum = inventoryNum;
    }

    public Integer getRealNum() {
        return realNum;
    }

    public void setRealNum(Integer realNum) {
        this.realNum = realNum;
    }

    public Integer getProfitOrLossNum() {
        return profitOrLossNum;
    }

    public void setProfitOrLossNum(Integer profitOrLossNum) {
        this.profitOrLossNum = profitOrLossNum;
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