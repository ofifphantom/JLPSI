package com.jl.psi.model;

/**
 * 供api使用的商品信息model
 * 
 * @author 柳亚婷
 * @Description: TODO
 * @date: 2018年6月22日 上午10:01:18
 */
public class ApiCommodityMsg {
	/**
	 * 商品规格id
	 */
	private Integer commoditySpecId;
	/**
	 * 商品规格编号
	 */
	private String specificationIdentifier;
	/**
	 * 商品规格名称
	 */
	private String specificationName;
	/**
	 * 商品id
	 */
	private Integer commodityId;
	/**
	 * 商品编号
	 */
	private String commodityIdentifier;
	/**
	 * 商品名称
	 */
	private String commodityName;
	/**
	 * 品牌
	 */
	private String brand;
	/**
	 * 商品价格
	 */
	private double commodityPrice;

	public Integer getCommoditySpecId() {
		return commoditySpecId;
	}

	public void setCommoditySpecId(Integer commoditySpecId) {
		this.commoditySpecId = commoditySpecId;
	}

	public String getSpecificationIdentifier() {
		return specificationIdentifier;
	}

	public void setSpecificationIdentifier(String specificationIdentifier) {
		this.specificationIdentifier = specificationIdentifier;
	}

	public String getSpecificationName() {
		return specificationName;
	}

	public void setSpecificationName(String specificationName) {
		this.specificationName = specificationName;
	}

	public Integer getCommodityId() {
		return commodityId;
	}

	public void setCommodityId(Integer commodityId) {
		this.commodityId = commodityId;
	}

	public String getCommodityIdentifier() {
		return commodityIdentifier;
	}

	public void setCommodityIdentifier(String commodityIdentifier) {
		this.commodityIdentifier = commodityIdentifier;
	}

	public String getCommodityName() {
		return commodityName;
	}

	public void setCommodityName(String commodityName) {
		this.commodityName = commodityName;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public double getCommodityPrice() {
		return commodityPrice;
	}

	public void setCommodityPrice(double commodityPrice) {
		this.commodityPrice = commodityPrice;
	}

}
