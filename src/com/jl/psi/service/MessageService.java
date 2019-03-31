package com.jl.psi.service;

import java.util.List;

import com.jl.psi.utils.DataTables;

public interface MessageService   {
	 
	 
	 /**
	  * 分页
	  * @param dataTables
	  * @return
	  */
	public DataTables dataTables(DataTables dataTables,String userId);
	/**
	 * 消息提醒
	 * @param serivice 业务对象id ，菜单名称
	 * @param menuName
	 */
	public void addMessage(Integer serviceId,String menuName) throws Exception;
	/**
	 * 消息提醒批量
	 * @param serviceList  业务对象集合 id，菜单名称
	 * @param menuName
	 */
	 public void addMessageBath(List<Integer > serviceIds,String menuName) throws Exception;
		/**
		 * 批量清空消息提醒
		 * @param serviceIds  业务id集合
		 * @param serviceType 业务类型(1 客户维护，2 供应商维护，3商品维护，4采购订单，5销售订单 )
		 * @throws Exception
		 */
		 public void clearMessageBath(List<Integer > serviceIds,Integer serviceType) throws Exception;
		/**
		 *  清空消息提醒
		 * @param serviceId 业务id
		 * @throws Exception 业务类型(1 客户维护，2 供应商维护，3商品维护，4采购订单，5销售订单 )
		 */
		 public void clearMessage(Integer serviceId,Integer serviceType) throws Exception;
}
