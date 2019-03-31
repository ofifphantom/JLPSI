package com.jl.psi.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jl.psi.model.TakeStockOrder;
/**
 * 盘点单mapper
 * @author 景雅倩
 * @date 2018年6月11日 下午6:50:37
 */
public interface TakeStockOrderMapper extends BaseMapper<TakeStockOrder> {
	/**
	 * 获取最大的编号
	 * @return
	 */
	public String selectMaxIdentifier();
	
	/**
	 * 根据id列表更改状态
	 * @param map
	 * @return
	 */
	public Boolean updateStateByIds(Map<String, Object> map);
	
	/**
	 * 根据主键id列表获取盘点单列表
	 * @param list
	 * @return
	 */
	public List<TakeStockOrder> getTakeStockOrderByIds(ArrayList<Integer> list);
	
	/**
	 * 根据主键id查询详情
	 */
	public TakeStockOrder selectTakeStockOrderDetailById(Integer id);
	/**
	 * 盘点单报表信息
	 * @param 
	 * @return
	 */
	public List<TakeStockOrder>  reportTakeStockOrderMsg(Map<String, Object> params);
}