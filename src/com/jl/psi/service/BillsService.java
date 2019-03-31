package com.jl.psi.service;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.Bills;
import com.jl.psi.utils.DataTables;

public interface BillsService extends BaseService<Bills>{
	 /**
	  * 分页
	  * @param dataTables
	  * @return
	  */
	public DataTables dataTables(DataTables dataTables, String billsType,String billsCode,Integer customerSupplierId,String dateSearch);
	/**
	 * 查询最大编号
	 * @return
	 */
	public String  selectMaxCode(Integer billsType);
	/**
	 * 应付款单汇总表
	 * @param params
	 * @return
	 */
	public List<Bills> reportPayOrderProcure(Map<String, Object> params);
	/**
	 * 应付款单汇总表
	 * @param params
	 * @return
	 */
	public List<Bills> reportPayOrderSales(Map<String, Object> params);
}
