package com.jl.psi.mapper;

import java.util.List;

import com.jl.psi.model.Inventory;

public interface InventoryMapper extends BaseMapper<Inventory>{
	
	/**
	 * 批量保存全部信息
	 * @param inventoryList 
	 * @return
	 */
	public int insertBatch(List<Inventory> inventoryList);
	
	/**
	 * 根据商品规格Id列表 删除 信息 
	 * @param commodityId
	 * @return
	 */
	public int deleteByCommoditySpecificationIds(List<Integer> list);

	/**
	 * 根据商品编号获取商品仓库信息
	 * @param identifier 商品规格编号
	 * @return
	 */
	public Inventory  getCommodityWarehouse(String identifier);

	
	/**
	 * 根据仓库id以及商品id修改该商品的占用数量
	 * @param inventory
	 * @return
	 */
	public boolean updateOccupiedInventory(Inventory inventory);
	/**
	 * 根据仓库id以及商品id修改该商品的库存数量及占用数量
	 * @param inventory
	 * @return
	 */
	public boolean updateInventoryDown(Inventory inventory);

	/**
	 * 根据商品规格id获取商品仓库id
	 * @param specificationId 商品规格id
	 * @return
	 */
	public int  getWarehouseIdByCommoditySpecificationId(int specificationId);

	
	/**
	 * 根据仓库id以及商品id修改该商品的库存   加库存
	 * @param inventory
	 * @return
	 */
	public boolean updateAddGoodsInventory(Inventory inventory);

	
	/**
	 * 根据商品id修改该商品的占用数量
	 * @param inventory
	 * @return
	 */
	public boolean updateOccupiedInventoryByCommoditySpecificationId(Inventory inventory);
	
	/**
	 * 根据商品id修改该商品的库存数量
	 * @param inventory
	 * @return
	 */
	public boolean updateInventoryByCommoditySpecificationId(Inventory inventory);
	
	/**
	 * 根据规格id更新字段是否生成采购计划单
	 * @param inventory
	 * @return
	 */
	public boolean updateBySpecificationId(Inventory inventory);
	
	/**
	 * 如果库存数大于预警数量 则修改是否生成采购计划单字段为0 
	 * @return
	 */
	public boolean updateIsCreateProcurePlanTo0();
	
	/**
	 * 根据商品id修改该商品的占用数量(解除锁定库存)
	 * @param inventory
	 * @return
	 */
	public boolean updateOccupiedInventoryToReduceByCommoditySpecificationId(Inventory inventory);
	

	/**
	 * 根据商品规格id修改该商品的库存   减库存
	 * @param inventory
	 * @return
	 */
	public boolean updateReduceGoodsInventory(Inventory inventory);
	
	/**
	 * 根据商品规格id批量查询商品库存信息
	 * @param list
	 * @return
	 */
	public List<Inventory> selectBatchInventoryMsgBySpecificationId(List<Integer> list);
	
	/**
	 * 根据商品id修改该商品的库存   加库存
	 * @param inventory
	 * @return
	 */
	public boolean updateAddGoodsInventoryBySpecificationId(Inventory inventory);
}