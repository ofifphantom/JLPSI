package com.jl.psi.service;

import java.util.List;

import com.jl.psi.model.BreakageOrderCommodity;
/**
 * 报损单商品Service
 * @author 景雅倩
 * @date 2018年6月14日 下午4:55:22
 */
public interface BreakageOrderCommodityService extends BaseService<BreakageOrderCommodity>{
	/**
	 * 批量添加 
	 * @param list
	 * @return
	 */
	public boolean insertBeatch(List<BreakageOrderCommodity> list);
	/**
	 * 根据报损单id删除报损商品信息
	 * @param breakageOrderId
	 * @return
	 */
	public boolean deleteMsgByBreakageOrderId(Integer breakageOrderId);
	/**
	 * 根据报损单id获取报损商品列表
	 * @param breakageOrderId
	 * @return
	 */
	public List<BreakageOrderCommodity> selectByBreakageOrderId(Integer breakageOrderId);
}