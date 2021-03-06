package com.jl.psi.mapper;

import java.util.List;
import com.jl.psi.model.SalesPlanOrderCommodity;
/**
 * 
 * @author 景雅倩
 * @date  2018年6月04日  上午10:21:50
 * @Description  销售计划单商品Mapper
 */
public interface SalesPlanOrderCommodityMapper extends BaseMapper<SalesPlanOrderCommodity> {
	
	/**
	 * 根据销售计划单id查询销售计划商品信息
	 * @param salesPlanOrderId
	 * @return
	 */
	public List<SalesPlanOrderCommodity> selectMsgBySalesPlanOrderId(Integer salesPlanOrderId);
	
	/**
	 * 批量添加 
	 * @param list
	 * @return
	 */
	public boolean insertBeatch(List<SalesPlanOrderCommodity> list);
	
	public List<SalesPlanOrderCommodity> selectCsBuActivityId(Integer activityId);
   
}