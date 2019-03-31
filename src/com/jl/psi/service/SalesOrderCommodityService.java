package com.jl.psi.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
/**
 * @author 景雅倩
 * @date  2018年5月23日  上午10:47:52
 * @Description  销售订单商品Service
 */
public interface SalesOrderCommodityService extends BaseService<SalesOrderCommodity> {

	/**
	 * 批量添加 
	 * @param list
	 * @return
	 */
	public boolean insertBeatch(List<SalesOrderCommodity> list);
	
	/**
	 * 根据销售订单id查询销售商品信息
	 * @param salesOrderId
	 * @return
	 */
	public List<SalesOrderCommodity> selectMsgBySalesOrderId(Integer salesOrderId);
	
	/**
	 * 根据销售订单id删除销售商品信息
	 * @param salesOrderId
	 * @return
	 */
	public boolean deleteMsgBySalesOrderId(Integer salesOrderId);
	
	/**
	 * 根据销售订单id查询旗下商品所属的仓库id
	 * @param salesOrderId
	 * @return
	 */
	public List<SalesOrderCommodity> selectWarehouseIdBySalesOrderId(Integer salesOrderId);
	
	/**
	 * 根据销售订单id批量删除销售商品信息
	 * @param list
	 * @return
	 */
	public boolean deleteBatchMsgBySalesOrderId(List<SalesOrder> list);
	
	/**
	 * 根据销售订单id获取该订单下的所有销售商品信息
	 * @param salesOrderId
	 * @return
	 */
	public List<SalesOrderCommodity> getSalesOrderCommodityBySalesOrderId(int salesOrderId);
	/**
	 * 货品销售日报表-每日数量、价格
	 * @param list
	 * @return
	 */
	public List<SalesOrderCommodity> reportSalesCommodityDatil(Map<String, Object> map);
}
