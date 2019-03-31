package com.jl.psi.model;

public class AllotOrderCommodity {
    private Integer id;

    private Integer allotOrderId;

    private Integer commoditySpecificationId;

    private Integer number;

    private Double exportUnitPrice;

    private Double importUnitPrice;

    private Double importMoney;
    
    private AllotOrder allotOrder;
    
    private CommoditySpecification commoditySpecification;
    
    public CommoditySpecification getCommoditySpecification() {
		return commoditySpecification;
	}

	public void setCommoditySpecification(CommoditySpecification commoditySpecification) {
		this.commoditySpecification = commoditySpecification;
	}

	public AllotOrder getAllotOrder() {
		return allotOrder;
	}

	public void setAllotOrder(AllotOrder allotOrder) {
		this.allotOrder = allotOrder;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getAllotOrderId() {
        return allotOrderId;
    }

    public void setAllotOrderId(Integer allotOrderId) {
        this.allotOrderId = allotOrderId;
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

    public Double getExportUnitPrice() {
        return exportUnitPrice;
    }

    public void setExportUnitPrice(Double exportUnitPrice) {
        this.exportUnitPrice = exportUnitPrice;
    }

    public Double getImportUnitPrice() {
        return importUnitPrice;
    }

    public void setImportUnitPrice(Double importUnitPrice) {
        this.importUnitPrice = importUnitPrice;
    }

    public Double getImportMoney() {
        return importMoney;
    }

    public void setImportMoney(Double importMoney) {
        this.importMoney = importMoney;
    }
}