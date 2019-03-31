package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.SupctoCommodity;

public interface SupctoCommodityMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SupctoCommodity record);

    int insertSelective(SupctoCommodity record);

    SupctoCommodity selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SupctoCommodity record);

    int updateByPrimaryKey(SupctoCommodity record);
	/**
	 * 根据SupctoId删除信息
	 * @param SupctoId
	 * @return true/false 删除成功或失败
	 */
	public boolean deleteSupctoCommodityBySupctoId(int SupctoId);
	
	/**
	 * 根据SupctoIds删除信息
	 * @param ids
	 * @return true/false 删除成功或失败
	 */
	public boolean deleteSupctoCommodityBySupctoIds(List<Integer> ids);
	
	/**
	 * 根据客户id查询信息
	 * @param supctoId
	 * @return
	 */
	public List<SupctoCommodity> selectSupctoCommodityBySupctoId(Map<String, Object> map);
	
	/**
	 * 根据商品id查询信息
	 * @param commodityId
	 * @return
	 */
	public List<SupctoCommodity> selectByCommodityIds(List<Integer> list);
	
	/**
	 * 根据商品规格ID以及客户Id查询价格
	 * @param supctoCommodity
	 * @return
	 */
	public Double selectPriceByCommoditySpIdAndSupId(SupctoCommodity supctoCommodity);
	/**
	 * 根据客户id更新客户id
	 * @param supctoId
	 * @return
	 */
	public boolean updateSupctoIdBySupctoId(Map<String, Object> map);
   
}