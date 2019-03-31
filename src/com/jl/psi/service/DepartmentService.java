package com.jl.psi.service;

import java.util.ArrayList;
import java.util.List;

import com.jl.psi.model.Department;
import com.jl.psi.model.SettlementType;
import com.jl.psi.utils.DataTables;

public interface DepartmentService extends BaseService<Department> {
	/**
	 * 获取所有的部门信息
	 * @return
	 */
	public List<Department> getAllDepartment();
	
	
	/**
	 * 信息dataTables
	 * @param request
	 * @return
	 */
	public DataTables dataTables(DataTables dataTables,String identifier, String name, String operatorIdentifier, String operatorTime) ;
	
	/**
	 *判断关联   根据结算方式id列表获取编号
	 * @param list
	 * @return
	 */
	public List<Department> selectDepartmentIdentifierByDepartmentId(ArrayList<Integer> list);
	/**
	 *判断关联    根据结算方式id列表从person查询获取编号
	 * @param list
	 * @return
	 */
	public List<Department> selectDepartmentIdentifierFromPersonByDepartmentId(ArrayList<Integer> list);
	/**
	 *判断关联  根据结算方式id列表从procure_table查询获取编号
	 * @param list
	 * @return
	 */
	public List<Department> selectDepartmentIdentifierFromProcureTableByDepartmentId(ArrayList<Integer> list);
	
	/**
	 * 根据id列表获取信息
	 * @param map id列表
	 * @return List<Department>
	 */
	public List<Department> getDepartmentByIds(ArrayList<Integer> list);
	
	/**
	 * 根据id列表删除信息
	 * @param list id列表
	 * @return true/false 删除成功或失败
	 */
	public boolean deleteDepartmentByIds(ArrayList<Integer> list);
	
	/**
	 * 根据参数查询所有信息
	 * @return
	 */
	public List<Department> selectMsgOrderBySearchMsg(String identifier,
			String name, String operatorIdentifier);
	/**
	 * 部门一级分类
	 * @return
	 */
	public List<Department> getClassOnedepartment();
	/**
	 * 部门对应的person
	 * @return
	 */
	public List<Department> getClassTwodepartment(Integer departmentId);

	/**
	 * 增加或编辑前判断是否重复
	 * 根据部门名称或结算名称&id查询所有信息
	 * @return
	 */
	public List<Department> checkIsRepeat(Department department);

}
