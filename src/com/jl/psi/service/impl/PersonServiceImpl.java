package com.jl.psi.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.DepartmentMapper;
import com.jl.psi.mapper.PersonMapper;
import com.jl.psi.model.Department;
import com.jl.psi.model.Person;
import com.jl.psi.service.DepartmentService;
import com.jl.psi.service.PersonService;
import com.jl.psi.service.SettlementTypeService;
import com.jl.psi.utils.DataTables;

@Service
public class PersonServiceImpl implements PersonService {
	@Autowired
	private PersonMapper personMapper;
	
	

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return personMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Person t) throws Exception {
		// TODO Auto-generated method stub
		return personMapper.insert(t);
	}

	@Override
	public int insertSelective(Person t) throws Exception {
		// TODO Auto-generated method stub
		return personMapper.insertSelective(t);
	}

	@Override
	public Person selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return personMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Person t) throws Exception {
		// TODO Auto-generated method stub
		return personMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Person t) throws Exception {
		// TODO Auto-generated method stub
		return personMapper.updateByPrimaryKey(t);
	}

	@Override
	public List<Person> getAllPersonByDepartmentIdAndBusiness(int departmentId) {
		// TODO Auto-generated method stub
		return personMapper.getAllPersonByDepartmentIdAndBusiness(departmentId);
	}

	@Override
	public DataTables dataTables(DataTables dataTables, String identifier,
			String name, String operatorIdentifier,String departmentId,String place, String operatorTime) {
		// TODO Auto-generated method stub
		String[] columns = {"id", "identifier", "name","departmentId", "entryTime","duties","business","quite","operatorIdentifier","id"};
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
		params.put("departmentId",departmentId);
		params.put("place",place);
		String[] arr=null;
		if (operatorTime!=""&&operatorTime!=null) {
			  arr=operatorTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("endTime", arr[1]);
		}
		dataTables.setiTotalDisplayRecords(personMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(personMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(personMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}
	

	@Override
	public List<Person> getPersonByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.getPersonByIds(list);
	}

	@Override
	public boolean deletePersonByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.deletePersonByIds(list);
	}

	@Override
	public List<Person> selectMsgOrderBySearchMsg(
			String identifier,
			String name, String operatorIdentifier) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		
		params.put("identifier", identifier);
		params.put("name", name);
		params.put("operatorIdentifier", operatorIdentifier);
		
		return personMapper.selectMsgOrderBySearchMsg(params);
	}

	@Override
	public Person findUserByLoginName(String loginName) {
		Map<String,Object> map=new HashMap<String,Object>(); 
		map.put("loginName", loginName);
		return personMapper.selectAdminByLoginName(map);
	}

	@Override
	public Person selectByPrimaryKeyAndLoginName(Person u) {
		// TODO Auto-generated method stub
		return personMapper.selectByPrimaryKeyAndLoginName(u);
	}

	@Override
	public Person selectAdminMsgById(String id) {
		// TODO Auto-generated method stub
		return personMapper.selectAdminMsgById(Integer.parseInt(id));
	}

	@Override
	public List<Person> selectPersonIdentifierFromSupctoByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromSupctoByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromTakeStockOrderByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromTakeStockOrderByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromPackageOrTeardownOrderByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromPackageOrTeardownOrderByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromAllotOrderByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromAllotOrderByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromBreakageOrderByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromBreakageOrderByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromSalesOrderByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromSalesOrderByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromSalesPlanOrderByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromSalesPlanOrderByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromClassificationByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromClassificationByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromCommoditySpecificationByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromCommoditySpecificationByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromDepartmentByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromDepartmentByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromLogByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromLogByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromPermissionByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromPermissionByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromSettlementTypeByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromSettlementTypeByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromShippingModeByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromShippingModeByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromWarehouseByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromWarehouseByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromProcureTableByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromProcureTableByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromSalesOrderReviewerByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromSalesOrderReviewerByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromBillsByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromBillsByPersonId(list);
	}

	@Override
	public List<Person> selectPersonIdentifierFromWriteOffByPersonId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return personMapper.selectPersonIdentifierFromWriteOffByPersonId(list);
	}


	

}
