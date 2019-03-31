package com.jl.psi.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.WriteOffSubMapper;
import com.jl.psi.model.WriteOff;
import com.jl.psi.model.WriteOffSub;
import com.jl.psi.service.WriteOffSubService;
@Service
public class WriteOffSubServiceImpl implements WriteOffSubService {

	@Autowired
	private WriteOffSubMapper	writeOffSubMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<WriteOffSub> reportSalesOpenReceiveMoney(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return writeOffSubMapper.reportSalesOpenReceiveMoney(map);
	}

	@Override
	public int insert(WriteOff t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(WriteOff t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public WriteOff selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateByPrimaryKeySelective(WriteOff t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(WriteOff t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<WriteOffSub> selectBySaleId(Integer supctoId, Integer type) {
		 
		return writeOffSubMapper.selectBySaleId(supctoId, type);
	}

	@Override
	public List<WriteOffSub> selectByProcureId(Integer supctoId, Integer type) {
 		return writeOffSubMapper.selectByProcureId(supctoId, type);
	}

	@Override
	public List<WriteOffSub> selectSalesById(Integer writeoffId) {
		// TODO Auto-generated method stub
		return writeOffSubMapper.selectSalesById(writeoffId);
	}
	@Override
	public List<WriteOffSub> selectProcureById(Integer writeoffId) {
		// TODO Auto-generated method stub
		return writeOffSubMapper.selectProcureById(writeoffId);
	}
	@Override
	public Integer insertBatch(List<WriteOffSub> list) {
		// TODO Auto-generated method stub
		return writeOffSubMapper.insertBatch(list);
	}
 
	@Override
	public List<WriteOffSub> selectAdvancePayable(Integer supctoId) {
		// TODO Auto-generated method stub
		return writeOffSubMapper.selectAdvancePayable(supctoId);
	}
	@Override
	public List<WriteOffSub> selectAdvanceReceivable(Integer supctoId) {
		// TODO Auto-generated method stub
		return writeOffSubMapper.selectAdvanceReceivable(supctoId);
	}
	

}
