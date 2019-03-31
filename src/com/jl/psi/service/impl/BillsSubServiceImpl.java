package com.jl.psi.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.BillsSubMapper;
import com.jl.psi.model.BillsSub;
import com.jl.psi.service.BillsSubService;
 @Service
public class BillsSubServiceImpl implements BillsSubService{
 
	@Autowired
	private BillsSubMapper billsSubMapper;
	
//		@Override
//		public List<BillsSub> selectBySaleId(Integer supctoId,Integer billsType) {
//			return billsSubMapper.selectBySaleId(supctoId, billsType);
// 		}
//		@Override
//		public List<BillsSub> selectByProcureId(Integer supctoId,Integer billsType) {
//			return billsSubMapper.selectByProcureId(supctoId, billsType);
// 		}
	
	    @Override
	    public List<BillsSub> selectByOne(Integer supctoId) {
	    	// TODO Auto-generated method stub
	    	return billsSubMapper.selectByOne(supctoId);
	    }
	    @Override
	    public List<BillsSub> selectByTwo(Integer supctoId) {
	    	// TODO Auto-generated method stub
	    	return billsSubMapper.selectByTwo(supctoId);
	    }
	    @Override
	    public List<BillsSub> selectByThree(Integer supctoId) {
	    	// TODO Auto-generated method stub
	    	return billsSubMapper.selectByThree(supctoId);
	    }
	    @Override
	    public List<BillsSub> selectByFour(Integer supctoId) {
	    	// TODO Auto-generated method stub
	    	return billsSubMapper.selectByFour(supctoId);
	    }
		 @Override
			public List<BillsSub> selectSalesByBillsId(Integer billsId) {
				// TODO Auto-generated method stub
				return billsSubMapper.selectSalesByBillsId(billsId);
			}
		 @Override
		public List<BillsSub> selectProcureByBillsId(Integer billsId) {
			// TODO Auto-generated method stub
			return billsSubMapper.selectProcureByBillsId(billsId);
		}
		 @Override
		public boolean insertBatch(List<BillsSub> list) {
			 return billsSubMapper.insertBatch(list);
 		}
	
	
		@Override
		public int deleteByPrimaryKey(Integer id) {
			// TODO Auto-generated method stub
			return 0;
		}
	
		@Override
		public int insert(BillsSub t) throws Exception {
			// TODO Auto-generated method stub
			return 0;
		}
	
		@Override
		public int insertSelective(BillsSub t) throws Exception {
			// TODO Auto-generated method stub
			return 0;
		}
	
		@Override
		public BillsSub selectByPrimaryKey(Integer id) {
			// TODO Auto-generated method stub
			return null;
		}
	
		@Override
		public int updateByPrimaryKeySelective(BillsSub t) throws Exception {
			// TODO Auto-generated method stub
			return 0;
		}
	
		@Override
		public int updateByPrimaryKey(BillsSub t) throws Exception {
			// TODO Auto-generated method stub
			return 0;
		}
		@Override
		public List<BillsSub> reportActualMoneyMsg(Map<String, Object> params) {
			// TODO Auto-generated method stub
			return billsSubMapper.reportActualMoneyMsg(params);
		}
	  @Override
	public List<BillsSub> selectReturnSales(Integer supctoId) {
		// TODO Auto-generated method stub
		return billsSubMapper.selectReturnSales(supctoId);
	}
	
	  @Override
 	public List<BillsSub> selectReturnSalesByBillsId(Integer billsId) {
	// TODO Auto-generated method stub
	 return billsSubMapper.selectReturnSalesByBillsId(billsId);
	 }
	  @Override
	public List<BillsSub> selectReturnProcure(Integer billsId) {
		// TODO Auto-generated method stub
		return billsSubMapper.selectReturnProcure(billsId);
	}
	  @Override
	public List<BillsSub> selectReturnProcureByBillsId(Integer billsId) {
		// TODO Auto-generated method stub
		return billsSubMapper.selectReturnProcureByBillsId(billsId);
	}
}
