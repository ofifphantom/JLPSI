package com.jl.psi.service;

import java.util.List;

import com.jl.psi.model.PackageOrTeardownOrderCommodity;

public interface PackageOrTeardownOrderCommodityService extends BaseService<PackageOrTeardownOrderCommodity>{

	/**
	 * 批量保存全部信息
	 * @param list
	 * @return
	 */
	public boolean insertBatch(List<PackageOrTeardownOrderCommodity> list);
	
	/**
	 * 根据拆卸单/组装单id删除 信息
	 * @param packageOrTeardownOrderId
	 * @return
	 */
	public boolean deleteByPOOId(Integer packageOrTeardownOrderId);
}
