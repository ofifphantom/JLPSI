package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.Unit;

public interface UnitMapper extends BaseMapper<Unit>{
	
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
	 * @param csId 商品规格id   name  单位名称
	 * @return
	 */
	public int selectMsgByunitId(Map<String, Object> params);
}