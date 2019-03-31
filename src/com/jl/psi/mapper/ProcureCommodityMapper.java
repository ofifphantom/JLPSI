package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.ProcureCommodity;

public interface ProcureCommodityMapper extends BaseMapper<ProcureCommodity>{
    	
	/**
	 * 根据procureTableId 批量删除 信息 
	 * @param procureTableId
	 * @return
	 */
	public boolean deleteBatchByProcureTableId(Map<String,Object> map);
	
	/**
	 * 根据procureTableId删除 信息
	 * @param procureTableId
	 * @return
	 */
	public boolean deleteByProcureTableId(Integer procureTableId);
	
	/**
	 * 批量保存全部信息 
	 * @param list
	 * @return
	 */
	public boolean insertBatch(List<ProcureCommodity> list);
	
	/**
	 * 根据商品规格id获取采购商品信息
	 */
	public List<ProcureCommodity> getProcureCommodityByCommoditySpecificationId(int CommoditySpecificationId);
}