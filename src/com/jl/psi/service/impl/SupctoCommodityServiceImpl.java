package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.SupctoCommodityMapper;
import com.jl.psi.mapper.SupctoMapper;
import com.jl.psi.model.Supcto;
import com.jl.psi.model.SupctoCommodity;
import com.jl.psi.service.SupctoCommodityService;
import com.jl.psi.service.SupctoService;
import com.jl.psi.utils.DataTables;

/**
 * 客戶/供应商ServiceImpl
 * @author THINK
 *
 */

@Service
public class SupctoCommodityServiceImpl implements SupctoCommodityService {

	@Autowired
	private SupctoCommodityMapper supctoCommodityMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return supctoCommodityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(SupctoCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return supctoCommodityMapper.insert(t);
	}

	@Override
	public int insertSelective(SupctoCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return supctoCommodityMapper.insertSelective(t);
	}

	@Override
	public SupctoCommodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return supctoCommodityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(SupctoCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return supctoCommodityMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(SupctoCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return supctoCommodityMapper.updateByPrimaryKey(t);
	}

	@Override
	public boolean deleteSupctoCommodityBySupctoId(int SupctoId){
		return supctoCommodityMapper.deleteSupctoCommodityBySupctoId(SupctoId);
	}
	@Override
	public boolean deleteSupctoCommodityBySupctoIds(List<Integer> ids){
		return supctoCommodityMapper.deleteSupctoCommodityBySupctoIds(ids);
	}
	
	@Override
	public List<SupctoCommodity> selectSupctoCommodityBySupctoId(Integer supctoId,Integer flag){
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("supctoId", supctoId);
		map.put("flag", flag);
		return supctoCommodityMapper.selectSupctoCommodityBySupctoId(map);
	}

	@Override
	public List<SupctoCommodity> selectByCommodityIds(String[] commodityIds) {
		List<Integer> list=new ArrayList<>();
		for(String keys:commodityIds){
			list.add(Integer.parseInt(keys));
		}
		return supctoCommodityMapper.selectByCommodityIds(list);
	}

	@Override
	public Double selectPriceByCommoditySpIdAndSupId(SupctoCommodity supctoCommodity) {
		// TODO Auto-generated method stub
		return supctoCommodityMapper.selectPriceByCommoditySpIdAndSupId(supctoCommodity);
	}

	@Override
	public boolean updateSupctoIdBySupctoId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return supctoCommodityMapper.updateSupctoIdBySupctoId(map);
	}
	

	
	

}
