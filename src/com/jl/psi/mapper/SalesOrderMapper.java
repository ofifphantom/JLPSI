package com.jl.psi.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
/**
 * 
 * @author 景雅倩
 * @date  2018年5月23日  上午10:47:52
 * @Description  销售订单Mapper
 */
public interface SalesOrderMapper extends BaseMapper<SalesOrder> {
	
	/**
	 * 根据主键id查询详情
	 * @param id
	 * @return
	 */
	public SalesOrder selectOrderDetailById(Integer id);
	
	/**
	 * 获取最大的编号
	 * @return
	 */
	public String selectMaxIdentifier();
	/**
	 * 查找单据类型为其他发货单的最大的编号 
	 * @return
	 */
	public String selectMaxIdentifierToOtherDeliveOrder();

	/**
	 * 根据主键id列表获取销售订单列表
	 * @param list
	 * @return
	 */
	public List<SalesOrder> getSalesOrderByIds(ArrayList<Integer> list);
	
	/**
   	 * 根据id列表更改状态
   	 * @param map id列表、修改的状态
   	 * @return true/false 更改成功或失败
   	 */
   	public boolean updateStateByIds(Map<String, Object> map);

   	/**
   	 * 根据app订单Id更改状态
   	 * @param map id列表、修改的状态
   	 * @return true/false 更改成功或失败
   	 */
   	public boolean updateStateByMisId(Integer id);
   	/**
   	 * 根据app订单父Id更改状态
   	 * @param map id列表、修改的状态
   	 * @return true/false 更改成功或失败
   	 */
   	public boolean updateStateByParentId(Integer parentId);
   	/**
   	 * 批量添加
   	 * @param list
   	 * @return
   	 */
   	public boolean insertBatch(List<SalesOrder> list);
   	
   	/**
	 * 根据仓库id以及销售订单id批量查询商品
	 * @param list
	 * @return
	 */
	public List<SalesOrder> selectBatchCommodityByWareIdAndOrderId(List<SalesOrderCommodity> list);
	
	/**
	 * 根据仓库id以及销售订单id查询商品
	 * @param list
	 * @return
	 */
	public SalesOrder selectCommodityByWareIdAndOrderId(SalesOrderCommodity salesOrderCommodity);

	/**
	 * 批量删除
	 * @param list
	 * @return
	 */
	public boolean deleteBatchByPrimaryKey(List<SalesOrder> list);
	
	/**
	 * 根据销售订单id获取其所属的父id以及订单id
	 * @param list
	 * @return
	 */
	public List<SalesOrder> selectParentIdByPrimaryKey(List<Integer> list);
	
	/**
   	 * 根据id列表更改状态以及是否显示
   	 * @param map id列表、修改的状态
   	 * @return true/false 更改成功或失败
   	 */
   	public boolean updateStateAndIsShowByIds(Map<String, Object> map);
   	
	
	/**
   	 * 根据parentId列表和orderType获取销售订单列表
   	 * @param map id列表、修改的状态
   	 * @return true/false 更改成功或失败
   	 */
   	public List<SalesOrder> getSalesOrderByOrderTypeAndParentId(Map<String, Object> map);
   	
   	/**
	 * 根据parentId列表和orderType更改状态
	 * @param 
	 * @return true/false 更改成功或失败
	 */
	public boolean updateStateByOrderTypeAndParentId(SalesOrder salesOrder);
	
	/**
	 * 根据父id以及订单类型查询信息
	 * @param map
	 * @return
	 */
	public SalesOrder selectMsgByParentIdAndOrderType(Map<String, Object> map);
	
	/**
	 * 根据编号以及是否显示查询id
	 * @param map
	 * @return
	 */
	public List<SalesOrder> selectIdByIdentifierAndState(List<String> identifier);
		
	/**
	 * 根据编号以及是否显示查询id
	 * @param map
	 * @return
	 */
	public List<SalesOrder> selectIdByIdentifierAndIsNoShow(List<String> identifier);
 
	
	/**
   	 * 获取所有可以进行退货的销售订单（即：orderType=1  &  state = 12）
   	 * @return 
   	 */
   	public List<SalesOrder> getAllSalesOrderCanReturn();
   	
   	/**
   	 * 获取app过来的销售订单中需要退货的订单
   	 * @return
   	 */
   	public List<SalesOrder> selectAppRturnGoodsSalesOrderMsg();
   	
	/**
   	 * 出库单汇总表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportExportSalesOrder(Map<String, Object> map);
   	
   	/**
   	 * 出库单明细表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportExportSalesOrderDetail(Map<String, Object> map);

   	/**
   	 * 销售订单明细表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportOrderDetail(Map<String, Object> map);
   	/**
   	 * 销售开单汇总表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportSalesOrderOpenGether(Map<String, Object> map);
   	/**
   	 * 销售开单明细表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportSalesOrderOpenDetail(Map<String, Object> map);
   	/**
   	 * 货品销售日报表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportSalesDayDetais(Map<String, Object> map);
   	/**
   	 * 销售毛利汇总表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportProfitGether(Map<String, Object> map);

   	/**
   	 * 销售毛利明细表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportProfitDetail(Map<String, Object> map);
   	/**
   	 * 设置被核销
   	 * @return
   	 */
   	public Integer updateByVerification(@Param("id") Integer id);
   	/**
   	 * 销售开单收款情况一览表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportSalesOpenReceiveMoney(Map<String, Object> map);
   	/**
   	 * 应收账款汇总表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportGetMoneyGetherOne(Map<String, Object> map);
   	/**
   	 * 应收账款汇总表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportGetMoneyGetherTwo(Map<String, Object> map);
   	/**
   	 * 应收账款汇总表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportGetMoneyGetherThree(Map<String, Object> map);
   	/**
	 * <!--账面库存汇总表 1 -->
	 * @return
	 */
	public List<SalesOrder> reportAccountsGetherOne(Map<String, Object> params);
	/**
	 * 根据mis订单id修改销售订单的收货人相关信息
	 * @param 
	 * @return true/false 更改成功或失败
	 */
	public boolean updateByMisOrderIdSelective(SalesOrder salesOrder);
	/**
	 * 根据父id查询订单的返货数量与折损数量
	 * @return
	 */
	public SalesOrder getReturnNum(Integer parentId);
	/**
	 * 根据父id查询订单的折损数量
	 * @return
	 */
	public SalesOrder getDamageNum(Integer parentId);
	/**
   	 * 其他发货单明细表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportOtherDeliverOrder(Map<String, Object> map);
   	/**
   	 * <!--销售退货商品信息（入库单部分）  -->
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportReturnGoodsMsg(Map<String, Object> map);
   	
   	/**
   	 * 销售退货明细表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<SalesOrder> reportSalesOrderReturnDetail(Map<String, Object> map);
   
}