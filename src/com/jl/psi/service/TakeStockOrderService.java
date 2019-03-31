package com.jl.psi.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jl.psi.model.TakeStockOrder;
import com.jl.psi.utils.DataTables;

/**
 * 盘点单service
 * @author 景雅倩
 * @date 2018年6月11日 下午6:51:50
 */
public interface TakeStockOrderService extends BaseService<TakeStockOrder>{
	
	/**
	 * 页面dataTable信息
	 * @param dataTables
	 * @param page 标志是哪个页面
	 * @param warehouseId 仓库
	 * @param takeStockDate 日期
	 * @param originator 制单人
	 * @return
	 */
	public DataTables getDataTables(DataTables dataTables, Integer page, Integer warehouseId, String takeStockDate, String originator,String searchType);

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
