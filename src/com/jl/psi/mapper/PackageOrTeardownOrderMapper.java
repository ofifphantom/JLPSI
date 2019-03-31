package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.PackageOrTeardownOrder;

public interface PackageOrTeardownOrderMapper extends BaseMapper<PackageOrTeardownOrder>{
    
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