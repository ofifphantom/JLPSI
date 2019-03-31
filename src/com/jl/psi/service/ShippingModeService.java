package com.jl.psi.service;

import java.util.List;
import com.jl.psi.model.ShippingMode;
import com.jl.psi.utils.DataTables;

public interface ShippingModeService extends BaseService<ShippingMode>{
	
	/**
	 * 获取运输方式表的信息，显示在界面上
	 * 
	 */
	public DataTables getShippingModeMsg(DataTables dataTables,String name,String operatorName, String operatorTime);
	
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
	public List<ShippingMode> selectBatchByPrimaryKey(String[] primaryKeys);
	
	/**
	 * 根据主键批量删除 信息 
	 * @param c
	 * @return
	 */
	public Integer deleteBatchByPrimaryKey(String[] primaryKeys);
	
	/**
	 * 导出信息的查询
	 * @param c
	 * @return
	 */
	public List<ShippingMode> exportShippingMode(String name,String operatorName);
	
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
