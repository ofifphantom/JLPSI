package com.jl.psi.service;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.PackageOrTeardownOrder;
import com.jl.psi.utils.DataTables;

public interface PackageOrTeardownOrderService extends BaseService<PackageOrTeardownOrder>{
	
	/**
	 * 获取组装单/拆卸单信息显示在页面上
	 * @param dataTables
	 * @param orderType 单据类型（1：组装单  2：拆卸单）
	 * @return
	 */
	public DataTables getPackageOrTeardownOrderMsg(DataTables dataTables,Integer orderType,Integer page,Integer searchWarehouse,String dateSearch,String searchOriginator,String searchType);

	/**
	 * 根据单据类型获取库里目前最大的编号
	 * @return
	 */
	public String selectMaxIdentifier(Integer orderType);
	
	/**
	 * 获取组装单/拆卸单的详情
	 * @param id
	 * @return
	 */
	public PackageOrTeardownOrder getPackageOrTeardownOrderMsgById(Integer id);
	/**
	 * 组装单/拆卸单报表
	 * @return
	 */
	public List<PackageOrTeardownOrder> reportPackageOrTeardownOrderMsg(Map<String, Object> params);
}
