package com.jl.psi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.SalesOrderReviewerMapper;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderReviewer;
import com.jl.psi.service.SalesOrderReviewerService;
/**
 * @author 景雅倩
 * @date  2018年5月23日  上午10:47:52
 * @Description  销售订单审批ServiceImpl
 */

@Service
public class SalesOrderReviewerServiceImpl implements SalesOrderReviewerService {

	
	@Autowired
	SalesOrderReviewerMapper salesOrderReviewerMapper;
	
	
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesOrderReviewerMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(SalesOrderReviewer t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderReviewerMapper.insert(t);
	}

	@Override
	public int insertSelective(SalesOrderReviewer t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderReviewerMapper.insertSelective(t);
	}

	@Override
	public SalesOrderReviewer selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesOrderReviewerMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(SalesOrderReviewer t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderReviewerMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(SalesOrderReviewer t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderReviewerMapper.updateByPrimaryKey(t);
	}

	@Override
	public SalesOrderReviewer selectBySalesOrderIdAndReviewerType(SalesOrderReviewer salesOrderReviewer) {
		// TODO Auto-generated method stub
		return salesOrderReviewerMapper.selectBySalesOrderIdAndReviewerType(salesOrderReviewer);
	}

	@Override
	public boolean deleteFromSalesOrderIds(List<SalesOrder> list) {
		// TODO Auto-generated method stub
		return salesOrderReviewerMapper.deleteFromSalesOrderIds(list);
	}

}
