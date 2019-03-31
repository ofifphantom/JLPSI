package com.jl.psi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.BreakageOrderCommodityMapper;
import com.jl.psi.model.BreakageOrderCommodity;
import com.jl.psi.service.BreakageOrderCommodityService;
/**
 * 报损单商品ServiceImpl
 * @author 景雅倩
 * @date 2018年6月14日 下午4:56:48
 */

@Service
public class BreakageOrderCommodityServiceImpl implements BreakageOrderCommodityService {

	@Autowired
	private BreakageOrderCommodityMapper breakageOrderCommodityMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(BreakageOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.insert(t);
	}

	@Override
	public int insertSelective(BreakageOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.insertSelective(t);
	}

	@Override
	public BreakageOrderCommodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(BreakageOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(BreakageOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.updateByPrimaryKey(t);
	}

	@Override
	public boolean insertBeatch(List<BreakageOrderCommodity> list) {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.insertBeatch(list);
	}

	@Override
	public boolean deleteMsgByBreakageOrderId(Integer breakageOrderId) {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.deleteMsgByBreakageOrderId(breakageOrderId);
	}

	@Override
	public List<BreakageOrderCommodity> selectByBreakageOrderId(Integer breakageOrderId) {
		// TODO Auto-generated method stub
		return breakageOrderCommodityMapper.selectByBreakageOrderId(breakageOrderId);
	}

}
