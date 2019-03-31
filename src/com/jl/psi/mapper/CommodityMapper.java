package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.Commodity;
import com.jl.psi.model.Inventory;

public interface CommodityMapper extends BaseMapper<Commodity>{
	
	/**
	 * 新增前判断该商品名是否存在
	 * @param c
	 * @return
	 */
	public Commodity selectGoodsNamePreventRepeatAdd(Commodity c);
	
	/**
	 * 根据主键批量删除 信息
	 * @param list
	 * @return
	 */
	public Integer deleteBatchByPrimaryKey(List<Integer> list); 
	
	/**
	 * 根据主键批量查询信息
	 * @param list
	 * @return
	 */
	public List<Commodity> selectBatchByPrimaryKey(List<Integer> list); 
	
	/**
	 * 根据名字模糊查询信息
	 * @return
	 */
	public List<Commodity> selectByName(Map<String,Object> map);
	
	/**
	 * 根据商品名称获取商品信息
	 * @param name
	 * @return
	 */
    public Commodity selectCommodityMsgByName(String name);
	/**
	 * 获取所有商品信息，并结合客户所涉及的商品信息进行结果筛选
	 *
	 * @param
	 * @return
	 */
	public List<Commodity> getAllCommodity();
    /**
     * 获取最大的商品编号 以供截取后四位
     * @return
     */
    public String selectMaxIdentifier();
    /**
	 * 根据商品编号获取商品仓库信息
	 * @param identifier 商品规格编号
	 * @return
	 */
    public Inventory  getCommodityWarehouse(String identifier);
    /**
     * 导出商品信息
     * @return
     */
    public List<Commodity> exportCommodityMsg(Map<String,Object> map);

    
    
}