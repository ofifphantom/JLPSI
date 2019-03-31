package com.jl.psi.service;

import java.util.List;

import com.jl.psi.model.ProcureCommodity;

public interface ProcureCommodityService extends BaseService<ProcureCommodity> {


	/**
	 * 根据procureTableId删除 信息 
	 * @param primaryKeys
	 * @return
	 */
	public boolean deleteBatchByProcureTableId(String[] primaryKeys);
	
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
