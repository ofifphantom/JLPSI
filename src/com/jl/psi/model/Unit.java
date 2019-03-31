package com.jl.psi.model;

public class Unit {
	/**
	 * 主键
	 */
	private Integer id;
	/**
	 * 单位名称
	 */
	private String name;
	/**
	 * 商品规格id
	 */
	private Integer specificationId;
	/**
	 * 比率-分母
	 */
	private Integer ratioDenominator;
	/**
	 * 比率-分子
	 */
	private Integer ratioMolecular;
	/**
	 * 采购价格
	 */
	private Double purchasePrice;
	/**
	 * 一般销售价格
	 */
	private Double commonlyPrice;
	/**
	 * 临时一般销售价格
	 */
	private Double tempCommonlyPrice;
	/**
	 * 最低销售价格
	 */
	private Double miniPrice;
	/**
	 * 条形码
	 */
	private String barCode;
	/**
	 * 销售单位
	 */
	private String salesUnit;
	/**
	 * 是否为基本单位，1基本单位，0非基本单位
	 */
	private Integer basicUnit;
	/**
	 * 仓库单位
	 */
	private String warehouseUnit;
	/**
	 * 采购单位
	 */
	private String purchasingUnit;
	/**
	 * 是否为批货单位0 不是 1 是
	 */
	private Integer miniPurchasing;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSpecificationId() {
		return specificationId;
	}

	public void setSpecificationId(Integer specificationId) {
		this.specificationId = specificationId;
	}

	public Integer getRatioDenominator() {
		return ratioDenominator;
	}

	public void setRatioDenominator(Integer ratioDenominator) {
		this.ratioDenominator = ratioDenominator;
	}

	public Integer getRatioMolecular() {
		return ratioMolecular;
	}

	public void setRatioMolecular(Integer ratioMolecular) {
		this.ratioMolecular = ratioMolecular;
	}

	public Double getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(Double purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public Double getCommonlyPrice() {
		return commonlyPrice;
	}

	public void setCommonlyPrice(Double commonlyPrice) {
		this.commonlyPrice = commonlyPrice;
	}

	public Double getMiniPrice() {
		return miniPrice;
	}

	public void setMiniPrice(Double miniPrice) {
		this.miniPrice = miniPrice;
	}

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode == null ? null : barCode.trim();
	}

	public Integer getBasicUnit() {
		return basicUnit;
	}

	public void setBasicUnit(Integer basicUnit) {
		this.basicUnit = basicUnit;
	}

	public String getSalesUnit() {
		return salesUnit;
	}

	public void setSalesUnit(String salesUnit) {
		this.salesUnit = salesUnit;
	}

	public String getWarehouseUnit() {
		return warehouseUnit;
	}

	public void setWarehouseUnit(String warehouseUnit) {
		this.warehouseUnit = warehouseUnit;
	}

	public String getPurchasingUnit() {
		return purchasingUnit;
	}

	public void setPurchasingUnit(String purchasingUnit) {
		this.purchasingUnit = purchasingUnit;
	}

	public Integer getMiniPurchasing() {
		return miniPurchasing;
	}

	public void setMiniPurchasing(Integer miniPurchasing) {
		this.miniPurchasing = miniPurchasing;
	}

	public Double getTempCommonlyPrice() {
		return tempCommonlyPrice;
	}

	public void setTempCommonlyPrice(Double tempCommonlyPrice) {
		this.tempCommonlyPrice = tempCommonlyPrice;
	}

}