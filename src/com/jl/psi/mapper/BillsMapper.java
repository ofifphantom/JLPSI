package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.Bills;

public interface BillsMapper extends BaseMapper<Bills>{
	public String selectMaxCode(Integer billsType);
	/**
	 * 应收款单汇总表 
	 * @param params
	 * @return
	 */
	public List<Bills> reportPayOrderSales(Map<String, Object> params);
	/**
	 * 应付款单汇总表 
	 * @param params
	 * @return
	 */
	public List<Bills> reportPayOrderProcure(Map<String, Object> params);
	
}
