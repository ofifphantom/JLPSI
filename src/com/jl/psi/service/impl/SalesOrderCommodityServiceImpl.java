package com.jl.psi.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.SalesOrderCommodityMapper;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.service.SalesOrderCommodityService;

/**
 * @author 景雅倩
 * @date  2018年5月23日  上午10:47:52
 * @Description  销售订单商品ServiceImpl
 */

@Service
public class SalesOrderCommodityServiceImpl implements SalesOrderCommodityService {

	@Autowired
	SalesOrderCommodityMapper salesOrderCommodityMapper;
	
	
	@Override
	public List<SalesOrderCommodity> reportSalesCommodityDatil(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.reportSalesCommodityDatil(map);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(SalesOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.insert(t);
	}

	@Override
	public int insertSelective(SalesOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.insertSelective(t);
	}

	@Override
	public SalesOrderCommodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(SalesOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(SalesOrderCommodity t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.updateByPrimaryKey(t);
	}

	@Override
	public boolean insertBeatch(List<SalesOrderCommodity> list) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.insertBeatch(list);
	}

	@Override
	public List<SalesOrderCommodity> selectMsgBySalesOrderId(Integer salesOrderId) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.selectMsgBySalesOrderId(salesOrderId);
	}

	@Override
	public boolean deleteMsgBySalesOrderId(Integer salesOrderId) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.deleteMsgBySalesOrderId(salesOrderId);
	}

	@Override
	public List<SalesOrderCommodity> selectWarehouseIdBySalesOrderId(Integer salesOrderId) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.selectWarehouseIdBySalesOrderId(salesOrderId);
	}

	@Override
	public boolean deleteBatchMsgBySalesOrderId(List<SalesOrder> list) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.deleteBatchMsgBySalesOrderId(list);
	}

	@Override
	public List<SalesOrderCommodity> getSalesOrderCommodityBySalesOrderId(int salesOrderId) {
		// TODO Auto-generated method stub
		return salesOrderCommodityMapper.getSalesOrderCommodityBySalesOrderId(salesOrderId);
	}

	


}
