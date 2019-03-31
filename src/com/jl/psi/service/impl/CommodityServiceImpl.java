package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.CommodityMapper;
import com.jl.psi.model.Commodity;
import com.jl.psi.service.CommodityService;
import com.jl.psi.utils.DataTables;

/**
 * 
 * @author 柳亚婷
 * @date  2018年4月9日  下午4:30:29
 * @Description 商品信息Service实现类
 *
 */
@Service
public class CommodityServiceImpl implements CommodityService {

	@Autowired
	CommodityMapper commodityMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return commodityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Commodity t) throws Exception {
		// TODO Auto-generated method stub
		return commodityMapper.insert(t);
	}

	@Override
	public int insertSelective(Commodity t) throws Exception {
		// TODO Auto-generated method stub
		return commodityMapper.insertSelective(t);
	}

	@Override
	public Commodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return commodityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Commodity t) throws Exception {
		// TODO Auto-generated method stub
		return commodityMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Commodity t) throws Exception {
		// TODO Auto-generated method stub
		return commodityMapper.updateByPrimaryKey(t);
	}

	@Override
	public Commodity selectGoodsNamePreventRepeatAdd(Commodity c) {
		// TODO Auto-generated method stub
		return commodityMapper.selectGoodsNamePreventRepeatAdd(c);
	}

	@Override
	public Integer deleteBatchByPrimaryKey(List<Integer> list) {
		
		return commodityMapper.deleteBatchByPrimaryKey(list);
	}

	@Override
	public List<Commodity> selectBatchByPrimaryKey(List<Integer> list) {
	
		return commodityMapper.selectBatchByPrimaryKey(list);
	}

	@Override
	public List<Commodity> selectByName(String name) {
		Map<String,Object> map=new HashMap<>();
		map.put("name", name);
		return commodityMapper.selectByName(map);
	}

	@Override
	public Commodity selectCommodityMsgByName(String name) {
		// TODO Auto-generated method stub
		return commodityMapper.selectCommodityMsgByName(name);
	}



	@Override
	public String selectMaxIdentifier() {
		// TODO Auto-generated method stub
		return commodityMapper.selectMaxIdentifier();
	}

	@Override
	public List<Commodity> exportCommodityMsg(Integer classificationId,
			String name, String operatorName, Integer supctoId) {
		Map<String, Object> map=new HashMap<>();
		map.put("classificationId", classificationId);
		map.put("cname", name);
		map.put("operatorName", operatorName);
		map.put("supctoId", supctoId);
		
		return commodityMapper.exportCommodityMsg(map);
	}
	@Override
	public List<Commodity> getAllCommodity() {

		return commodityMapper.getAllCommodity();
	}

	
	
}
