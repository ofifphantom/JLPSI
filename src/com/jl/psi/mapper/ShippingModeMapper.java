package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;
import com.jl.psi.model.ShippingMode;

public interface ShippingModeMapper extends BaseMapper<ShippingMode>{
	
	/**
	 * 获取所有的运输方式信息
	 * @return
	 */
	public List<ShippingMode> getAllShippingMode();
	
	/**
	 * 根据主键批量查询信息
	 * @param c
	 * @return
	 */
	public List<ShippingMode> selectBatchByPrimaryKey(Map<String,Object> map);
	
	/**
	 * 根据主键批量删除 信息 
	 * @param c
	 * @return
	 */
	public Integer deleteBatchByPrimaryKey(Map<String,Object> map);
	
	/**
	 * 导出信息的查询
	 * @param c
	 * @return
	 */
	public List<ShippingMode> exportShippingMode(Map<String,Object> map);
	
	/**
	 * 新增前判断名称是否存在 
	 * @param shippingMode
	 * @return
	 */
	public List<ShippingMode> selectShippingModeNamePreventRepeatAdd(ShippingMode shippingMode);
	
	/**
	 * 编辑前判断名称是否存在 
	 * @param shippingMode
	 * @return
	 */
	public List<ShippingMode> selectShippingModeNamePreventRepeatedit(ShippingMode shippingMode);
	
	/**
	 * 判断调拨单中该运输方式是否存在
	 * @param list
	 * @return
	 */
	public List<ShippingMode> selectShippingModeIsExistFromAO(List<Integer> list);
	
	/**
	 * 判断采购单中该运输方式是否存在
	 * @param list
	 * @return
	 */
	public List<ShippingMode> selectShippingModeIsExistFromPT(List<Integer> list);
	
	/**
	 * 判断销售单中该运输方式是否存在
	 * @param list
	 * @return
	 */
	public List<ShippingMode> selectShippingModeIsExistFromSO(List<Integer> list);
    
}