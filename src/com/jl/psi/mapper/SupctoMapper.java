package com.jl.psi.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jl.psi.model.Supcto;

public interface SupctoMapper extends BaseMapper<Supcto>{
    
    /**
   	 * 根据id列表更改状态
   	 * @param map id列表、修改的状态
   	 * @return true/false 更改成功或失败
   	 */
   	public boolean updateStateByIds(Map<String, Object> map);
   	
   	/**
   	 * 根据id列表获取信息
   	 * @param map id列表
   	 * @return List<Supcto>
   	 */
   	public List<Supcto> getSupctoByIds(ArrayList<Integer> list);
   	
   	/**
	 * 根据id列表删除信息
	 * @param list id列表
	 * @return true/false 删除成功或失败
	 */
	public boolean deleteSupctoByIds(ArrayList<Integer> list);
   	
   	/**
   	 * 根据customer_or_supplier 获取对应的所有信息
   	 * @param customerOrSupplier
   	 * @return
   	 */
   	public List<Supcto> selectAllMsgByCustomerOrSupplier(Integer customerOrSupplier);
	/**
	 * 根据customer_or_supplier 获取对应的所有客户信息
	 * @param customerOrSupplier
	 * @return
	 */
	public List<Supcto> selectAllCustomerByCustomerOrSupplier(Integer customerOrSupplier);
	/**
	 *判断关联   根据id联合商品表获取编号
	 * @param list
	 * @return
	 */
	public List<Supcto> selectSupctoIdentifierByIdAndCommodity(ArrayList<Integer> list);
	
	/**
	 *判断关联   根据id联合采购订单表获取编号
	 * @param list
	 * @return
	 */
	public List<Supcto> selectSupctoIdentifierFromProcureTableByIds(ArrayList<Integer> list);
	
	/**
	 *判断关联   根据id联合销售订单表获取编号
	 * @param list
	 * @return
	 */
	public List<Supcto> selectSupctoIdentifierFromSalesOrderByIds(ArrayList<Integer> list);
	
	/**
	 *判断关联   根据id联合销售计划单表获取编号
	 * @param list
	 * @return
	 */
	public List<Supcto> selectSupctoIdentifierFromSalesPlanOrderByIds(ArrayList<Integer> list);
	
	/**
	 *判断关联   根据id联合bills表获取编号
	 * @param list
	 * @return
	 */
	public List<Supcto> selectSupctoIdentifierFromBillsByIds(ArrayList<Integer> list);
	
	/**
	 *判断关联   根据id联合writeoff表获取编号
	 * @param list
	 * @return
	 */
	public List<Supcto> selectSupctoIdentifierFromWriteOffByIds(ArrayList<Integer> list);
	
	/**
	 * 根据参数查询所有信息
	 * @return
	 */
	public List<Supcto> selectMsgOrderBySearchMsg(Map<String,Object> map);
	

	
	/**
	 * 根据运输方式id列表获取客户/供应商信息
	 * @param list
	 * @return
	 */
	public List<Supcto> getSupctoByTransportMode(ArrayList<Integer> list);
	
	/**
	 * 修改/供应商/客户  预收/预付余额
	 * @param id
	 * @param advanceMoney
	 * @return
	 */
	public int updateAdvanceMoney(@Param("id") Integer id,@Param("advanceMoney") Double advanceMoney);
	
	/**
	 * 根据id更新新数据
	 */
	public boolean updateNewDataById(int id);

	/**
	 * 编辑和新增前判断是否存在
	 * @param supcto
	 * @return
	 */
	public List<Supcto> checkIsRepeat(Supcto supcto);
	
}