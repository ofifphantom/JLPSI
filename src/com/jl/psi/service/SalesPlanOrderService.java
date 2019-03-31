package com.jl.psi.service;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesPlanOrder;
import com.jl.psi.utils.DataTables;
/**
 * 
 * @author 景雅倩
 * @date  2018年6月04日  上午10:21:50
 * @Description  销售计划单Service
 */
public interface SalesPlanOrderService extends BaseService<SalesPlanOrder> {

	/**
	 * 获取销售计划表的信息，显示在界面上
	 * 
	 */
	public DataTables getSalesPlanOrderMsg(DataTables dataTables, String identifier,
			String commodityName, String originator,String createTime,Integer state);
	/**
	 * 获取最大的编号
	 * @return
	 */
	public String selectMaxIdentifier();
	/**
	 * 查询销售计划订单到期数量
	 * @return
	 */
	public Integer selectExpirationCount();
	
	/**
	 * 销售计划失败处理
	 * @return
	 */
	public List<SalesPlanOrder> selectSalesPlanOrderToFailure();
	/**
   	 * 销售计划单明细表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesPlanOrder> reportSalesPlanOrderDetail(Map<String, Object> map);
   	/**
	 * 根据mis订单id修改销售订单的收货人相关信息
	 * @param 
	 * @return true/false 更改成功或失败
	 */
	public boolean updateByMisOrderIdSelective(SalesPlanOrder salesPlanOrder);
	
	/**
	 * 查找销售计划单详情
	 * @param id
	 * @return
	 */
	public SalesPlanOrder getSalesPlanOrderDetail(Integer id);
	
}
