package com.jl.psi.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jl.psi.model.ProcureTable;
import com.jl.psi.utils.DataTables;

public interface ProcureTableService extends BaseService<ProcureTable> {

	/**
	 * 获取采购表的信息，显示在界面上
	 * 
	 */
	public DataTables getProcureTableMsg(DataTables dataTables, String identifier, String supctoName,
			String commodityName,String generateDate,String originator, Integer planOrOrder, Integer page,String queryTime,String state,String isPlan);

	/**
	 * 根据id列表更改状态
	 * 
	 * @param map
	 *            id列表、修改的状态
	 * @return true/false 更改成功或失败
	 */
	public boolean updateStateByIds(Map<String, Object> map);
	/**
	 * 根据父id列表更改入库单状态
	 * 
	 * @param map
	 *            父id列表、修改的状态
	 * @return true/false 更改成功或失败
	 */
	public boolean updateStateByParentIds(Map<String, Object> map);

	/**
	 * 根据id列表获取信息
	 * 
	 * @param map
	 *            id列表
	 * @return List<ProcureTable>
	 */
	public List<ProcureTable> getProcureTableByIds(ArrayList<Integer> list);

	/**
	 * 查看详情
	 * 
	 * @param id
	 * @return
	 */
	public ProcureTable selectMsgToDetail(Integer id);

	/**
	 * 获取原始单价(即最新一次的采购单价)
	 * 
	 * @param commodityId
	 *            商品id
	 * @return
	 */
	public Double getOriginalUnitPrice(Integer commodityId);
	
	/**
	 * 根据主键批量查询信息
	 * @param map
	 * @return
	 */
	public List<ProcureTable> selectBatchByPrimaryKey(String[] primaryKeys);
	
	/**
	 * 根据主键批量删除 信息
	 * @param map
	 * @return
	 */
	public boolean deleteBatchByPrimaryKey(String[] primaryKeys);
	
	/**
	 * 查找最大的编号
	 * @return
	 */
	public String selectMaxIdentifier();
	
	/**
	 * 查找最大的编号 单据类型为入库单/开单/退货单
	 * @return
	 */
	public String selectMaxIdentifierToOpeningAndReturn();
	
	/**
	 * 查找最大的编号  单据类型为采购计划单/采购订单
	 * @return
	 */
	public String selectMaxIdentifierToPlanAndOrder();
	
	/**
	 * 查找单据类型为其他收货单的最大的编号 
	 * @return
	 */
	public String selectMaxIdentifierToOtherReceipts();
	
	/**
	 * 查找是否有相应的单据
	 * @param procureTable
	 * @return
	 */
	public List<ProcureTable> selectIsHasGodownEntry(ProcureTable procureTable);
	
	/**
	 * 根据parentId 以及planOrOrder 删除 信息
	 * @param procureTable
	 * @return
	 */
	public boolean deleteByParentIdAndPlanOrOrder(ProcureTable procureTable);
	/**
	 * 查询计划采购订单到期数量
	 * @return
	 */
	public Integer selectExpirationCount();
	
	/**
	 * 获取供退货单引用的销售订单信息
	 * @return
	 */
	public List<ProcureTable> getPurchaseTableByState();
	/**
	 * 采购订单汇总表
	 * @return
	 */
	public List<ProcureTable> reportProcureOrderGether(Map<String, Object> params);
	/**
	 * 采购订单明细表
	 * @return
	 */
	public List<ProcureTable> reportProcureOrderDetail(Map<String, Object> params);
	/**
	 * 采购计划单汇总表
	 * @return
	 */
	public List<ProcureTable> reportProcurePlanOrderGether(Map<String, Object> params);
	/**
	 * 采购计划单明细表
	 * @return
	 */
	public List<ProcureTable> reportProcurePlanOrderDetail(Map<String, Object> params);
	/**
	 * 采购开单明细表/汇总表
	 * @return
	 */
	public List<ProcureTable> reportProcureFinishOrderDetailOrGether(Map<String, Object> params);
	/**
	 * 入库单明细表/汇总表
	 * @return
	 */
	public List<ProcureTable> reportImportOrderDetailOrGether(Map<String, Object> params);
   	/**
   	 * 设置被核销
   	 * @return
   	 */
   	public Integer updateByVerification(Integer id);
   	/**
	 * 采购开单付款情况一览表
	 * @return
	 */
	public List<ProcureTable> reportProcureFinishOrderPayMoneyDetail(Map<String, Object> params);
	/**
	 * <!--应付账款汇总表 基础部分  -->
	 * @return
	 */
	public List<ProcureTable> reportPayMoneyGetherOne(Map<String, Object> params);
	/**
	 * <!-- 采购退货的 金额 -->
	 * @return
	 */
	public List<ProcureTable> reportPayMoneyGetherTwo(Map<String, Object> params);
	/**
	 * <!--初期应付款  -->
	 * @return
	 */
	public List<ProcureTable> reportPayMoneyGetherThree(Map<String, Object> params);
	/**
	 * <!--账面库存汇总表 1 -->
	 * @return
	 */
	public List<ProcureTable> reportAccountsGetherOne(Map<String, Object> params);
	/**
	 * <!--账面库存汇总表  2-->
	 * @return
	 */
	public List<ProcureTable> reportAccountsGetherTwo(Map<String, Object> params);
	/**
	 * 获取入库数量
	 * @return
	 */
	public Integer getArrivalNum(Integer commodityId);
	/**
	 * 其他收货单明细表
	 * @return
	 */
	public List<ProcureTable> reportOtherReceiveOrder(Map<String, Object> params);
	/**
	 * 查询采购退货出库明细，供出库单报表使用
	 * @param params
	 * @return
	 */
	public List<ProcureTable> getSaleReturnDetailToReport(Map<String, Object> params);
	/**
	 * 查询采购退货出库汇总，供出库单报表使用
	 * @param params
	 * @return
	 */
	public List<ProcureTable> getSaleReturnAllMsgToReport(Map<String, Object> params);
	/**
	 * 部分入库申请采购开单 修改部分入库单的状态
	 * @param procureTable
	 * @return
	 */
	//public boolean warehouseHalfApplyBilling(Integer parentId);
	
	public int delete(Integer id);
	/**
	 * 采购退货单明细表
	 * @return
	 */
	public List<ProcureTable> reportProcureReturnOrderDetail(Map<String, Object> params);
}

