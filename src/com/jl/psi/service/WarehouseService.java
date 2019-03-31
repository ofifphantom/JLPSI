package com.jl.psi.service;

import java.util.ArrayList;
import java.util.List;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.Warehouse;
import com.jl.psi.utils.DataTables;

/**
 * 
 * @author 景雅倩
 * @date  2018年4月9日  下午4:28:47
 * @Description 仓库管理Service
 *
 */
public interface WarehouseService extends BaseService<Warehouse> {
	
	/**
	 * 查询所有信息
	 * @return
	 */
	public List<Warehouse> selectAllMsg();

	/**
	 * 信息dataTables
	 * @param request
	 * @return
	 */
	public DataTables dataTables(DataTables dataTables,String identifier, String name, String operatorIdentifier,String position, String operatorTime) ;
	
	/**
	 *判断关联   根据结算方式id列表获取编号
	 * @param list
	 * @return
	 */
	public List<Warehouse> selectWarehouseIdentifierByWarehouseId(ArrayList<Integer> list);
	/**
	 *判断关联   根据仓库id列表从调拨单获取编号
	 * @param list
	 * @return
	 */
	public List<Warehouse> selectWarehouseIdentifierFromAllotOrderByWarehouseId(ArrayList<Integer> list);
	/**
	 *判断关联   根据仓库id列表从报损单获取编号
	 * @param list
	 * @return
	 */
	public List<Warehouse> selectWarehouseIdentifierFromBreakageOrderByWarehouseId(ArrayList<Integer> list);
	/**
	 *判断关联   根据仓库id列表从拆卸/组装单获取编号
	 * @param list
	 * @return
	 */
	public List<Warehouse> selectWarehouseIdentifierFromPackageOrTeardownOrderByWarehouseId(ArrayList<Integer> list);
	/**
	 *判断关联   根据仓库id列表从盘点单获取编号
	 * @param list
	 * @return
	 */
	public List<Warehouse> selectWarehouseIdentifierFromTakeStockOrderByWarehouseId(ArrayList<Integer> list);
	/**
	 *判断关联   根据仓库id列表从员工表获取编号
	 * @param list
	 * @return
	 */
	public List<Warehouse> selectWarehouseIdentifierFromPersonByWarehouseId(ArrayList<Integer> list);
	/**
	 * 根据id列表获取信息
	 * @param map id列表
	 * @return List<Warehouse>
	 */
	public List<Warehouse> getWarehouseByIds(ArrayList<Integer> list);
	
	/**
	 * 根据id列表删除信息
	 * @param list id列表
	 * @return true/false 删除成功或失败
	 */
	public boolean deleteWarehouseByIds(ArrayList<Integer> list);
	
	/**
	 * 根据参数查询所有信息
	 * @return
	 */
	public List<Warehouse> selectMsgOrderBySearchMsg(String identifier,
			String name, String operatorIdentifier);
	/**
	 * 
	 * @param id 仓库id
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public List<Warehouse> selectWarehouseById(Integer id);
	/**
	 * 
	 * 查询仓库商品dataTable
	 * @return
	 * @throws Exception
	 */
	public DataTables getWarehouseMsg(DataTables dataTables,String brand,String commodityName,Integer warehouseId,Integer classficationId);
	/**
	 * 
	 * 打印仓库商品的查询
	 * @param brand 品牌，commodityName 商品名称， warehouseId 仓库id，classficationId 类别id
	 * @return
	 * @throws Exception
	 */
	public ArrayList<CommoditySpecification> getAll(String brand,String commodityName,Integer warehouseId,Integer classficationId);
	/**
	 * 
	 * @param id 仓库id
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public Warehouse selectById(Integer id);
	/**
	 * 增加或编辑前判断是否重复
	 * @return
	 */
	public List<Warehouse> checkIsRepeat(Warehouse warehouse);
}
