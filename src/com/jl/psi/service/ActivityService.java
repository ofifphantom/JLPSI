package com.jl.psi.service;

import java.util.Date;
import java.util.List;

import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.SalesPlanOrder;

/**
 * 进销存活动业务处理
 * @author guole
 *
 */
public interface ActivityService {

		/**
		 * 生成活动
		 * @param activityId
		 * @param activityType
		 * @param generatedTime
		 */
	  public  void createActivity(Integer activityId, Integer activityType, Date generatedTime,SalesPlanOrder planOrder);
	  
		/**
		 *根据采购订单 生成销售订单
		 */
	  public  void createSalesOrder(ProcureTable	procureTable)throws Exception;
		/**
		 * 生成销售订单
		 */
	  public  void createSalesOrder(SalesPlanOrder planOrder,Integer activityId)throws Exception;
	 
		/**
		 * 根据活动生成采购订单
		 */
	  public  void createProcureTable();
	  
	  /**
	   * 定时生成采购计划单
	   */
	  public void taskCreateProcureTable()throws Exception;
	  
	  
}
