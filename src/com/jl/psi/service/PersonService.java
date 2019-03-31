package com.jl.psi.service;

import java.util.ArrayList;
import java.util.List;

import com.jl.psi.model.Department;
import com.jl.psi.model.Person;
import com.jl.psi.model.SettlementType;
import com.jl.psi.model.Supcto;
import com.jl.psi.utils.DataTables;

public interface PersonService extends BaseService<Person> {
	/**
	 * 根据部门id获取所有的业务员
	 * @return
	 */
	public List<Person> getAllPersonByDepartmentIdAndBusiness(int departmentId);
	/**
	 * 信息dataTables
	 * @param request
	 * @return
	 */
	public DataTables dataTables(DataTables dataTables,String identifier, String name, String operatorIdentifier,String departmentId,String place, String operatorTime) ;
	
	/**
	 *14判断关联 根据员工id列表从客户/供应商获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromSupctoByPersonId(ArrayList<Integer> list);
	
	/**
	 * 根据id列表获取信息
	 * @param map id列表
	 * @return List<Person>
	 */
	public List<Person> getPersonByIds(ArrayList<Integer> list);
	
	/**
	 * 根据id列表删除信息
	 * @param list id列表
	 * @return true/false 删除成功或失败
	 */
	public boolean deletePersonByIds(ArrayList<Integer> list);
	
	/**
	 * 根据参数查询所有信息
	 * @return
	 */
	public List<Person> selectMsgOrderBySearchMsg(String identifier,
			String name, String operatorIdentifier);
	
	/**
	 * 根据登录名查询管理员
	 * @param loginName
	 * @return
	 */
	public Person findUserByLoginName(String loginName);
	
	/**
	 * 根据登录名和主键获取管理员信息
	 * @param User 用户model
	 * @return
	 */
	public Person selectByPrimaryKeyAndLoginName(Person u);
	
	/**
	 * 根据主键联合查询user表和permission权限表
	 * @param id user主键
	 * @return
	 */
	public Person selectAdminMsgById(String id);
	
	/**
	 *-1判断关联 根据员工id列表从盘点单获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromTakeStockOrderByPersonId(ArrayList<Integer> list);
	/**
	 *0判断关联 根据员工id列表从组装/拆卸单获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromPackageOrTeardownOrderByPersonId(ArrayList<Integer> list);
	/**
	 *1判断关联 根据员工id列表从调拨单获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromAllotOrderByPersonId(ArrayList<Integer> list);
	/**
	 *2判断关联 根据员工id列表从报损单获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromBreakageOrderByPersonId(ArrayList<Integer> list);
	/**
	 *9判断关联 根据员工id列表从销售订单获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromSalesOrderByPersonId(ArrayList<Integer> list);
	/**
	 *11判断关联 根据员工id列表从销售计划单获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromSalesPlanOrderByPersonId(ArrayList<Integer> list);
	/**
	 *3判断关联 根据员工id列表从分类表获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromClassificationByPersonId(ArrayList<Integer> list);
	/**
	 *4判断关联 根据员工id列表从商品规格表获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromCommoditySpecificationByPersonId(ArrayList<Integer> list);
	/**
	 *5判断关联 根据员工id列表从部门表获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromDepartmentByPersonId(ArrayList<Integer> list);
	/**
	 *6判断关联 根据员工id列表从日志表获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromLogByPersonId(ArrayList<Integer> list);
	/**
	 *7判断关联 根据员工id列表从权限表获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromPermissionByPersonId(ArrayList<Integer> list);
	/**
	 *12判断关联 根据员工id列表从结算方式表获取编号
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromSettlementTypeByPersonId(ArrayList<Integer> list);
	/**
	 *13判断关联 根据员工id列表从运输方式表获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromShippingModeByPersonId(ArrayList<Integer> list);
	/**
	 *15判断关联 根据员工id列表从仓库表获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromWarehouseByPersonId(ArrayList<Integer> list);
	/**
	 *8判断关联 根据员工id列表从采购订单获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromProcureTableByPersonId(ArrayList<Integer> list);
	/**
	 *10判断关联 根据员工id列表从销售订单审批表获取编号 
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromSalesOrderReviewerByPersonId(ArrayList<Integer> list);
	/**
	 *判断关联   根据员工id列表联合bills表获取编号
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromBillsByPersonId(ArrayList<Integer> list);
	/**
	 *判断关联   根据员工id列表联合writeoff表获取编号
	 * @param list
	 * @return
	 */
	public List<Person> selectPersonIdentifierFromWriteOffByPersonId(ArrayList<Integer> list);
}
