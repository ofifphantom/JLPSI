package com.jl.psi.model;

public class SupctoCommodity {
    private Integer id;

    private Integer commodityId;

    private Integer supctoId;

    private Double price;
    
    private CommoditySpecification commoditySpecification;
    
    private Commodity commodity;
    
    private Unit unit;
    
    

    public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	public Commodity getCommodity() {
		return commodity;
	}

	public void setCommodity(Commodity commodity) {
		this.commodity = commodity;
	}

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

    public Integer getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(Integer commodityId) {
        this.commodityId = commodityId;
    }

    public Integer getSupctoId() {
        return supctoId;
    }

    public void setSupctoId(Integer supctoId) {
        this.supctoId = supctoId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}