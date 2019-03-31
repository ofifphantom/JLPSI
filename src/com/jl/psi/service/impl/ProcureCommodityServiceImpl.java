package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.ProcureCommodityMapper;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.service.ProcureCommodityService;

@Service
public class ProcureCommodityServiceImpl implements ProcureCommodityService {
	
	@Autowired
	ProcureCommodityMapper procureCommodityMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return procureCommodityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ProcureCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return procureCommodityMapper.insert(t);
	}

	@Override
	public int insertSelective(ProcureCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return procureCommodityMapper.insertSelective(t);
	}

	@Override
	public ProcureCommodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return procureCommodityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(ProcureCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return procureCommodityMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(ProcureCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return procureCommodityMapper.updateByPrimaryKey(t);
	}

	@Override
	public boolean deleteBatchByProcureTableId(String[] primaryKeys) {
		Map<String,Object> map=new HashMap<>();
		List<Integer> list=new ArrayList<>();
		for(String id:primaryKeys){
			list.add(Integer.parseInt(id));
		}
		map.put("list", list);
		return procureCommodityMapper.deleteBatchByProcureTableId(map);
	}

	@Override
	public boolean deleteByProcureTableId(Integer procureTableId) {
		// TODO Auto-generated method stub
		return procureCommodityMapper.deleteByProcureTableId(procureTableId);
	}

	@Override
	public boolean insertBatch(List<ProcureCommodity> list) {
		// TODO Auto-generated method stub
		return procureCommodityMapper.insertBatch(list);
	}

	@Override
	public List<ProcureCommodity> getProcureCommodityByCommoditySpecificationId(int CommoditySpecificationId) {
		// TODO Auto-generated method stub
		return procureCommodityMapper.getProcureCommodityByCommoditySpecificationId(CommoditySpecificationId);
	}

}
