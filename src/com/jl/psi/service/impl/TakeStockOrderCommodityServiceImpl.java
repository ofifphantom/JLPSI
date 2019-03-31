package com.jl.psi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.TakeStockOrderCommodityMapper;
import com.jl.psi.model.TakeStockOrderCommodity;
import com.jl.psi.service.TakeStockOrderCommodityService;
/**
 * 盘点单商品serviceImpl
 * @author 景雅倩
 * @date 2018年6月11日 下午6:57:31
 */
@Service
public class TakeStockOrderCommodityServiceImpl implements TakeStockOrderCommodityService {

	@Autowired 
	private TakeStockOrderCommodityMapper takeStockOrderCommodityMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(TakeStockOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.insert(t);
	}

	@Override
	public int insertSelective(TakeStockOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.insertSelective(t);
	}

	@Override
	public TakeStockOrderCommodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(TakeStockOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(TakeStockOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.updateByPrimaryKey(t);
	}

	@Override
	public boolean insertBeatch(List<TakeStockOrderCommodity> list) {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.insertBeatch(list);
	}

	@Override
	public boolean deleteMsgByTakeStockOrderId(Integer takeStockOrderId) {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.deleteMsgByTakeStockOrderId(takeStockOrderId);
	}

	@Override
	public List<TakeStockOrderCommodity> selectByTakeStockOrderId(Integer takeStockOrderId) {
		// TODO Auto-generated method stub
		return takeStockOrderCommodityMapper.selectByTakeStockOrderId(takeStockOrderId);
	}

}
