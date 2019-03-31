package com.jl.psi.model;

public class Inventory {
	/**
	 * 主键
	 */
	private Integer id;
	/**
	 * 商品规格id
	 */
	private Integer specificationId;
	/**
	 * 仓库id
	 */
	private Integer warehouseId;
	/**
	 * 库存
	 */
	private Integer inventory;
	/**
	 * 预售库存
	 */
	private Integer presellInventory;
	/**
	 * 已占用库存
	 */
	private Integer occupiedInventory;
	/**
	 * 库存上限
	 */
	private Integer maxInventory;
	/**
	 * 库存下限
	 */
	private Integer miniInventory;
	/**
	 * 成本单价
	 */
	private Double costPrice; 
	/**
	 * 商品数量
	 */
	private Integer commodityNum;
	
	/**
	 * 是否生成了采购计划单(0:未生成，1：生成了)
	 */
	private Integer isCreateProcurePlan;
	
	// 根据结果需要，在model里另添格外的字段
	
	/**
	 * 仓库信息
	 */
	Warehouse warehouse;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSpecificationId() {
		return specificationId;
	}

	public void setSpecificationId(Integer specificationId) {
		this.specificationId = specificationId;
	}

	public Integer getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(Integer warehouseId) {
		this.warehouseId = warehouseId;
	}

	public Integer getInventory() {
		return inventory;
	}

	public void setInventory(Integer inventory) {
		this.inventory = inventory;
	}

	public Integer getPresellInventory() {
		return presellInventory;
	}

	public void setPresellInventory(Integer presellInventory) {
		this.presellInventory = presellInventory;
	}

	public Integer getOccupiedInventory() {
		return occupiedInventory;
	}

	public void setOccupiedInventory(Integer occupiedInventory) {
		this.occupiedInventory = occupiedInventory;
	}

	public Integer getMaxInventory() {
		return maxInventory;
	}

	public void setMaxInventory(Integer maxInventory) {
		this.maxInventory = maxInventory;
	}

	public Integer getMiniInventory() {
		return miniInventory;
	}

	public void setMiniInventory(Integer miniInventory) {
		this.miniInventory = miniInventory;
	}

	public Double getCostPrice() {
		return costPrice;
	}

	public void setCostPrice(Double costPrice) {
		this.costPrice = costPrice;
	}

	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}

	public Integer getCommodityNum() {
		return commodityNum;
	}

	public void setCommodityNum(Integer commodityNum) {
		this.commodityNum = commodityNum;
	}

	public Integer getIsCreateProcurePlan() {
		return isCreateProcurePlan;
	}

	public void setIsCreateProcurePlan(Integer isCreateProcurePlan) {
		this.isCreateProcurePlan = isCreateProcurePlan;
	}
	
}