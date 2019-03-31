package com.jl.psi.service;

import java.util.List;

import com.jl.psi.model.Unit;

public interface UnitService extends BaseService<Unit> {
	
	/**
	 * 批量保存全部信息
	 * @param unitList 
	 * @return
	 */
	public int insertBatch(List<Unit> unitList);
	
	/**
	 * 根据商品规格Id列表 删除 信息 
	 * @param commodityId
	 * @return
	 */
	public int deleteByCommoditySpecificationIds(List<Integer> list);
	/**
	 * 根据id查询单位信息
	 * @param csId 商品规格id  name  单位名称
	 * @return
	 */
	public int selectMsgByunitId(Integer csId,String  name);
}
