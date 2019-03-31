package com.jl.psi.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.DepartmentMapper;
import com.jl.psi.mapper.SettlementTypeMapper;
import com.jl.psi.model.Department;
import com.jl.psi.model.SettlementType;
import com.jl.psi.model.Supcto;
import com.jl.psi.service.DepartmentService;
import com.jl.psi.service.SettlementTypeService;
import com.jl.psi.utils.DataTables;

@Service
public class SettlementTypeServiceImpl implements SettlementTypeService {
	@Autowired
	private SettlementTypeMapper settlementTypeMapper;
	
	

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return settlementTypeMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(SettlementType t) throws Exception {
		// TODO Auto-generated method stub
		return settlementTypeMapper.insert(t);
	}

	@Override
	public int insertSelective(SettlementType t) throws Exception {
		// TODO Auto-generated method stub
		return settlementTypeMapper.insertSelective(t);
	}

	@Override
	public SettlementType selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return settlementTypeMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(SettlementType t) throws Exception {
		// TODO Auto-generated method stub
		return settlementTypeMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(SettlementType t) throws Exception {
		// TODO Auto-generated method stub
		return settlementTypeMapper.updateByPrimaryKey(t);
	}

	@Override
	public List<SettlementType> getAllSettlementType() {
		// TODO Auto-generated method stub
		return settlementTypeMapper.getAllSettlementType();
	}

	@Override
	public DataTables dataTables(DataTables dataTables, String identifier,
			String name, String operatorIdentifier, String operatorTime) {
		// TODO Auto-generated method stub
		String[] columns = {"id", "identifier", "name", "operator_identifier","operator_time","id"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
	
		params.put("identifier", identifier);
		params.put("name", name);
		params.put("operatorIdentifier", operatorIdentifier);
		String[] arr=null;
		if (operatorTime!=""&&operatorTime!=null) {
			  arr=operatorTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("endTime", arr[1]);
		}
		dataTables.setiTotalDisplayRecords(settlementTypeMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(settlementTypeMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(settlementTypeMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}

	

	@Override
	public List<SettlementType> getSettlementTypeByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return settlementTypeMapper.getSettlementTypeByIds(list);
	}

	@Override
	public boolean deleteSettlementTypeByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return settlementTypeMapper.deleteSettlementTypeByIds(list);
	}

	@Override
	public List<SettlementType> selectMsgOrderBySearchMsg(
			String identifier,
			String name, String operatorIdentifier) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		
		params.put("identifier", identifier);
		params.put("name", name);
		params.put("operatorIdentifier", operatorIdentifier);
		
		return settlementTypeMapper.selectMsgOrderBySearchMsg(params);
	}

	@Override
	public List<SettlementType> selectSettlementTypeIdentifierFromSupctoBySettlementTypeId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return settlementTypeMapper.selectSettlementTypeIdentifierFromSupctoBySettlementTypeId(list);
	}

	@Override
	public List<SettlementType> selectSettlementTypeIdentifierFromProcureTableBySettlementTypeId(
			ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return settlementTypeMapper.selectSettlementTypeIdentifierFromProcureTableBySettlementTypeId(list);
	}

	@Override
	public List<SettlementType> checkIsRepeat(SettlementType settlementType) {
		// TODO Auto-generated method stub
		return settlementTypeMapper.checkIsRepeat(settlementType);
	}

	

}
