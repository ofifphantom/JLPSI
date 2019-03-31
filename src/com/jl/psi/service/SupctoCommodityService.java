package com.jl.psi.service;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jl.psi.model.Supcto;
import com.jl.psi.model.SupctoCommodity;
import com.jl.psi.utils.DataTables;

/**
 * 客戶/供应商Service
 * @author THINK
 *
 */
public interface SupctoCommodityService extends BaseService<SupctoCommodity>{
	
	
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
	public List<SupctoCommodity> selectSupctoCommodityBySupctoId(Integer supctoId,Integer flag);
	
	/**
	 * 根据商品id查询信息
	 * @param commodityId
	 * @return
	 */
	public List<SupctoCommodity> selectByCommodityIds(String[] commodityIds);
	
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
