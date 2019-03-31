package com.jl.psi.service;

import java.util.List;

import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderReviewer;
/**
 * @author 景雅倩
 * @date  2018年5月23日  上午10:47:52
 * @Description  销售订单审批Service
 */
public interface SalesOrderReviewerService extends BaseService<SalesOrderReviewer> {
	
	/**
	 * 根据销售订单id和审批类型获取信息
	 * @param salesOrderReviewer
	 * @return
	 */
	public SalesOrderReviewer selectBySalesOrderIdAndReviewerType(SalesOrderReviewer salesOrderReviewer);
	
	/**
	 * 根据销售订购id列表删除信息 
	 * @param list
	 * @return
	 */
	public boolean deleteFromSalesOrderIds(List<SalesOrder> list);
}
