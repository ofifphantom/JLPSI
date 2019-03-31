package com.jl.psi.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.crypto.hash.Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.UnitMapper;
import com.jl.psi.model.Unit;
import com.jl.psi.service.UnitService;
import com.sun.org.apache.bcel.internal.generic.NEW;

@Service
public class UnitServiceImpl implements UnitService {
	
	@Autowired
	UnitMapper unitMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return unitMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Unit t) throws Exception {
		// TODO Auto-generated method stub
		return unitMapper.insert(t);
	}

	@Override
	public int insertSelective(Unit t) throws Exception {
		// TODO Auto-generated method stub
		return unitMapper.insertSelective(t);
	}

	@Override
	public Unit selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return unitMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Unit t) throws Exception {
		// TODO Auto-generated method stub
		return unitMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Unit t) throws Exception {
		// TODO Auto-generated method stub
		return unitMapper.updateByPrimaryKey(t);
	}

	@Override
	public int insertBatch(List<Unit> unitList) {
		// TODO Auto-generated method stub
		return unitMapper.insertBatch(unitList);
	}

	@Override
	public int deleteByCommoditySpecificationIds(List<Integer> list) {
		// TODO Auto-generated method stub
		return unitMapper.deleteByCommoditySpecificationIds(list);
	}

	@Override
	public int selectMsgByunitId(Integer csId,String name) {
		Map<String, Object>  params=new HashMap<>();
		params.put("csId", csId);
		params.put("name", name);
		// TODO Auto-generated method stub
		return unitMapper.selectMsgByunitId(params);
	}
	
	

}
