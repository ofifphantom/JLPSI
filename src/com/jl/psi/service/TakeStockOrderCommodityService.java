package com.jl.psi.service;

import java.util.List;

import com.jl.psi.model.TakeStockOrderCommodity;
/**
 * 盘点单商品service
 * @author 景雅倩
 * @date 2018年6月11日 下午6:56:37
 */
public interface TakeStockOrderCommodityService extends BaseService<TakeStockOrderCommodity>{
	/**
	 * 批量添加 
	 * @param list
	 * @return
	 */
	public boolean insertBeatch(List<TakeStockOrderCommodity> list);
	
	/**
	 * 根据盘点单id删除盘点商品信息
	 * @param takeStockOrderId
	 * @return
	 */
	public boolean deleteMsgByTakeStockOrderId(Integer takeStockOrderId);
	
	/**
	 * 根据盘点单id获取盘点商品列表
	 * @param takeStockOrderId
	 * @return
	 */
	public List<TakeStockOrderCommodity> selectByTakeStockOrderId(Integer takeStockOrderId);

}
