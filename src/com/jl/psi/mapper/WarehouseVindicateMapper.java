package com.jl.psi.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.Warehouse;

public interface WarehouseVindicateMapper extends BaseMapper<Warehouse>{
	/**
	 * 
	 * 打印仓库商品的查询
	 * @param brand 品牌，commodityName 商品名称， warehouseId 仓库id，classficationId 类别id
	 * @return
	 * @throws Exception
	 */
	public ArrayList<CommoditySpecification> getWarehouseMsg(Map<String, Object> params);
	/**
	 * 指定仓库商品信息
	 * @param warehouseId 仓库id
	 * @return 页面路径
	 */
	public ArrayList<CommoditySpecification> getWarehouseCommodity(Integer warehouseId);
	/**
	 * 通过审核的仓库商品信息
	 * @param warehouseId 仓库id
	 * @return 页面路径
	 */
	public ArrayList<CommoditySpecification> PassWarehouseCommodityById(Integer warehouseId);
	/**
	 * 指定调拨单商品信息
	 * @param warehouseId 仓库id
	 * @return 页面路径
	 */
	public ArrayList<CommoditySpecification> getAlloteById(Integer allocationId);
}
