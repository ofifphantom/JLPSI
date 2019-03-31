package com.jl.psi.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.DepartmentMapper;
import com.jl.psi.model.Department;
import com.jl.psi.service.DepartmentService;
import com.jl.psi.utils.DataTables;

@Service
public class DepartmentServiceImpl implements DepartmentService {
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Override
	public List<Department> getClassOnedepartment() {
		// TODO Auto-generated method stub
		return departmentMapper.getClassOnedepartment();
	}

	@Override
	public List<Department> getAllDepartment() {
		// TODO Auto-generated method stub
		return departmentMapper.getAllDepartment();
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return departmentMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Department t) throws Exception {
		// TODO Auto-generated method stub
		return departmentMapper.insert(t);
	}

	@Override
	public List<Department> getClassTwodepartment(Integer departmentId) {
		// TODO Auto-generated method stub
		return departmentMapper.getClassTwodepartment(departmentId);
	}

	@Override
	public int insertSelective(Department t) throws Exception {
		// TODO Auto-generated method stub
		return departmentMapper.insertSelective(t);
	}

	@Override
	public Department selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return departmentMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Department t) throws Exception {
		// TODO Auto-generated method stub
		return departmentMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Department t) throws Exception {
		// TODO Auto-generated method stub
		return departmentMapper.updateByPrimaryKey(t);
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
		
		dataTables.setiTotalDisplayRecords(departmentMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(departmentMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(departmentMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}

	@Override
	public List<Department> selectDepartmentIdentifierByDepartmentId(
			ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return departmentMapper.selectDepartmentIdentifierFromSupctoByDepartmentId(list);
	}

	@Override
	public List<Department> getDepartmentByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return departmentMapper.getDepartmentByIds(list);
	}

	@Override
	public boolean deleteDepartmentByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return departmentMapper.deleteDepartmentByIds(list);
	}

	@Override
	public List<Department> selectMsgOrderBySearchMsg(
			String identifier,
			String name, String operatorIdentifier) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		
		params.put("identifier", identifier);
		params.put("name", name);
		params.put("operatorIdentifier", operatorIdentifier);
		
		return departmentMapper.selectMsgOrderBySearchMsg(params);
	}

	@Override
	public List<Department> selectDepartmentIdentifierFromPersonByDepartmentId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return departmentMapper.selectDepartmentIdentifierFromPersonByDepartmentId(list);
	}

	@Override
	public List<Department> selectDepartmentIdentifierFromProcureTableByDepartmentId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return departmentMapper.selectDepartmentIdentifierFromProcureTableByDepartmentId(list);
	}

	@Override
	public List<Department> checkIsRepeat(Department department) {
		// TODO Auto-generated method stub
		return departmentMapper.checkIsRepeat(department);
	}

}
