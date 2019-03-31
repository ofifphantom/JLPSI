package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jl.psi.model.BillsSub;
  
public interface BillsSubMapper extends BaseMapper<BillsSub>{
//	/**
//	 * 根据客户id查询订单列表
//	 * @param map
//	 * @return
//	 */
//	public List<BillsSub> selectBySaleId(@Param("supctoId") Integer supctoId,@Param("billsType") Integer billsType);
//	
//	/**
//	 * 根据供应商id查询订单列表
//	 * @param map
//	 * @return
//	 */
//	public List<BillsSub> selectByProcureId(@Param("supctoId") Integer supctoId,@Param("billsType") Integer billsType);
	
	/**
	 * 根据供应商id程序待添加收款单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectByOne(@Param("supctoId") Integer supctoId);

	/**
	 * 根据供应商id程序待添加付款单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectByTwo(@Param("supctoId") Integer supctoId);
	/**
	 * 根据供应商id程序待添加预收款单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectByThree(@Param("supctoId") Integer supctoId);
	/**
	 * 根据供应商id程序待添加预付款单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectByFour(@Param("supctoId") Integer supctoId);
	/**
   	 * 批量添加
   	 * @param list
   	 * @return
   	 */
   	public boolean insertBatch(List<BillsSub> list);
   	
   	/**
	 * 根据单据主项id查询订单列表
	 * @param map
	 * @return
	 */
	public List<BillsSub> selectSalesByBillsId(@Param("billsId") Integer billsId);
	
   	/**
	 * 根据单据主项id查询订单列表
	 * @param map
	 * @return
	 */
	public List<BillsSub> selectProcureByBillsId(@Param("billsId") Integer billsId);

	/**
	 * 查询核销金额
	 * @param map
	 * @return
	 */
	public List<BillsSub> reportActualMoneyMsg(Map<String, Object> params);
	/**
	 * 应收款单查询待添加 销售退货单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectReturnSales(@Param("supctoId") Integer supctoId);
	/**
	 * 应收款单查询 销售退货单详情
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectReturnSalesByBillsId(@Param("billsId") Integer billsId);
	/**
	 * 应付款单查询 采购退货单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectReturnProcure(@Param("supctoId") Integer billsId);
	/**
	 * 应付款单查询 采购退货单详情
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectReturnProcureByBillsId(@Param("billsId") Integer billsId);
	
}
