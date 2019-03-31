package com.jl.psi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.PackageOrTeardownOrderCommodityMapper;
import com.jl.psi.model.PackageOrTeardownOrderCommodity;
import com.jl.psi.service.PackageOrTeardownOrderCommodityService;

@Service
public class PackageOrTeardownOrderCommodityServiceImpl implements PackageOrTeardownOrderCommodityService {
	
	@Autowired
	PackageOrTeardownOrderCommodityMapper packageOrTeardownOrderCommodityMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderCommodityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(PackageOrTeardownOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderCommodityMapper.insert(t);
	}

	@Override
	public int insertSelective(PackageOrTeardownOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderCommodityMapper.insertSelective(t);
	}

	@Override
	public PackageOrTeardownOrderCommodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderCommodityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(PackageOrTeardownOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderCommodityMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(PackageOrTeardownOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderCommodityMapper.updateByPrimaryKey(t);
	}

	@Override
	public boolean insertBatch(List<PackageOrTeardownOrderCommodity> list) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderCommodityMapper.insertBatch(list);
	}

	@Override
	public boolean deleteByPOOId(Integer packageOrTeardownOrderId) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderCommodityMapper.deleteByPOOId(packageOrTeardownOrderId);
	}

}
