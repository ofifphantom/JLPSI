package com.jl.psi.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jl.psi.model.BillsSub;

public interface BillsSubService extends BaseService<BillsSub>{
//	/**
//	 * 根据客户 id查询订单列表
//	 * @param map
//	 * @return
//	 */
//	public List<BillsSub> selectBySaleId(Integer supctoId,Integer billsType);
//	/**
//	 * 根据供应商 id查询订单列表
//	 * @param map
//	 * @return
//	 */
//	public List<BillsSub> selectByProcureId(Integer supctoId,Integer billsType);
	/**
	 * 根据供应商id程序待添加收款单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectByOne( Integer supctoId);

	/**
	 * 根据供应商id程序待添加付款单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectByTwo(Integer supctoId);
	/**
	 * 根据供应商id程序待添加预收款单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectByThree( Integer supctoId);
	/**
	 * 根据供应商id程序待添加预付款单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectByFour( Integer supctoId);
  	/**
	 * 根据单据主项id查询订单列表
	 * @param map
	 * @return
	 */
	public List<BillsSub> selectSalesByBillsId(Integer billsId);
	
  	/**
	 * 根据单据主项id查询订单列表
	 * @param map
	 * @return
	 */
	public List<BillsSub> selectProcureByBillsId(Integer billsId);
	/**
   	 * 批量添加
   	 * @param list
   	 * @return
   	 */
   	public boolean insertBatch(List<BillsSub> list);
   	/**
	 * 查询核销金额
	 * @param map
	 * @return
	 */
	public List<BillsSub> reportActualMoneyMsg(Map<String, Object> params);
	/**
	 * 预收款单查询待添加 销售退货单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectReturnSales( Integer supctoId);
	
	/**
	 * 预收款单查询 销售退货单详情
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectReturnSalesByBillsId( Integer billsId);
	/**
	 * 应付款单查询 采购退货单
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectReturnProcure( Integer billsId);
	/**
	 * 应付款单查询 采购退货单详情
	 * @param supctoId
	 * @return
	 */
	public List<BillsSub> selectReturnProcureByBillsId( Integer billsId);
}
