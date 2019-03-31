package com.jl.psi.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jl.psi.model.BreakageOrder;
/**
 * 报损单Mapper
 * @author 景雅倩
 * @date 2018年6月14日 下午4:55:22
 */
public interface BreakageOrderMapper extends BaseMapper<BreakageOrder>{
	/**
	 * 根据主键id查询详情
	 */
	public BreakageOrder selectBreakageOrderDetailById(Integer id);
	
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
	 * 根据主键id列表获取报损单列表
	 * @param list
	 * @return
	 */
	public List<BreakageOrder> getBreakageOrderByIds(ArrayList<Integer> list);
	/**
	 * 报损单报表
	 * @return
	 */
	public List<BreakageOrder> reporBreakOrdertMsg(Map<String, Object> params);
}