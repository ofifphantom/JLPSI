package com.jl.psi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.SalesPlanOrderCommodityMapper;
import com.jl.psi.model.SalesPlanOrderCommodity;
import com.jl.psi.service.SalesPlanOrderCommodityService;
/**
 * 
 * @author 景雅倩
 * @date  2018年6月04日  上午10:21:50
 * @Description  销售计划单商品ServiceImpl
 */
@Service
public class SalesPlanOrderCommodityServiceImpl implements SalesPlanOrderCommodityService {

	@Autowired
	SalesPlanOrderCommodityMapper salesPlanOrderCommodityMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesPlanOrderCommodityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(SalesPlanOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return salesPlanOrderCommodityMapper.insert(t);
	}

	@Override
	public int insertSelective(SalesPlanOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return salesPlanOrderCommodityMapper.insertSelective(t);
	}

	@Override
	public SalesPlanOrderCommodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesPlanOrderCommodityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(SalesPlanOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return salesPlanOrderCommodityMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(SalesPlanOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return salesPlanOrderCommodityMapper.updateByPrimaryKey(t);
	}

	@Override
	public List<SalesPlanOrderCommodity> selectMsgBySalesPlanOrderId(Integer salesPlanOrderId) {
		// TODO Auto-generated method stub
		return salesPlanOrderCommodityMapper.selectMsgBySalesPlanOrderId(salesPlanOrderId);
	}

	@Override
	public boolean insertBeatch(List<SalesPlanOrderCommodity> list) {
		// TODO Auto-generated method stub
		return salesPlanOrderCommodityMapper.insertBeatch(list);
	}

}
