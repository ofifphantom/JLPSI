package com.jl.psi.service;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jl.psi.model.AllotOrder;
import com.jl.psi.model.AllotOrderCommodity;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.TakeStockOrder;
import com.jl.psi.model.TakeStockOrderCommodity;
import com.jl.psi.utils.DataTables;


public interface AllocteOrderService extends BaseService<AllotOrder>{

	
	
	int delete(Integer id);
	/**
	 * 指定仓库商品信息
	 * @param warehouseId 仓库id
	 * @return 页面路径
	 */
	public ArrayList<CommoditySpecification> getWarehouseCommodity(Integer warehouseId);
	/**
	 * 调拨单DataTables
	 * @param warehouseId 仓库id  makerPersion 制单人  date  日期
	 * @return 页面路径
	 */
	public  DataTables getAllocationOrderMsg(DataTables dataTables, Integer warehouseId, String  alloteDate,String originator,Integer type);
	/**
	 * 根据id查询调拨单信息
	 * @param allocationId 调拨单id  
	 * @return 页面路径
	 */
	public AllotOrder getAllocationOrderMsgById(Integer allocationId);
	/**
	 * 获取最大的编号
	 * @return
	 */
	public String selectMaxIdentifier();
	/**
	 * 批量添加 
	 * @param list
	 * @return
	 */
	public boolean insertBeatch(List<AllotOrderCommodity> list);
	/**
	 * 修改调拨单库存信息 
	 * @param importWarehouseId  调入仓库的ID
	 * @return
	 */
	public int updateInventory(Integer importWarehouseId,Integer specificationId);
	/**
	 * 调拨单明细报表
	 * @return
	 */
	public List<AllotOrder> reportMsg(Map<String, Object> params);
	/**
	 * 更改销售商品表中仓库所属id
	 * @return
	 * @param importId  调入仓库id  csId 商品规格id  exportId 调出仓库id
	 */
	public int updateSaleOrderCommodityWarehouseId(Integer importId,Integer csId,Integer exportId);
}