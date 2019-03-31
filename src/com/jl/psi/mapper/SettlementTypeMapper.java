package com.jl.psi.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jl.psi.model.SettlementType;
import com.jl.psi.model.Supcto;

public interface SettlementTypeMapper extends BaseMapper<SettlementType> {
    int deleteByPrimaryKey(Integer id);

    int insert(SettlementType record);

    int insertSelective(SettlementType record);

    SettlementType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SettlementType record);

    int updateByPrimaryKey(SettlementType record);
	/**
	 * 获取所有的结算方式
	 * @return
	 */
	public List<SettlementType> getAllSettlementType();
	
	/**
	 *判断关联   根据结算方式id列表从supcto获取编号
	 * @param list
	 * @return
	 */
	public List<SettlementType> selectSettlementTypeIdentifierFromSupctoBySettlementTypeId(ArrayList<Integer> list);
	/**
	 *判断关联   根据结算方式id列表从procure_table获取编号
	 * @param list
	 * @return
	 */
	public List<SettlementType> selectSettlementTypeIdentifierFromProcureTableBySettlementTypeId(ArrayList<Integer> list);
	
	/**
	 * 根据id列表获取信息
	 * @param map id列表
	 * @return List<SettlementType>
	 */
	public List<SettlementType> getSettlementTypeByIds(ArrayList<Integer> list);
	
	/**
	 * 根据id列表删除信息
	 * @param list id列表
	 * @return true/false 删除成功或失败
	 */
	public boolean deleteSettlementTypeByIds(ArrayList<Integer> list);
	
	/**
	 * 根据参数查询所有信息
	 * @return
	 */
	public List<SettlementType> selectMsgOrderBySearchMsg(Map<String,Object> map);
	/**
	 * 增加或编辑前判断是否重复
	 * 根据结算方式名称或结算名称&id查询所有信息
	 * @return
	 */
	public List<SettlementType> checkIsRepeat(SettlementType settlementType);
}