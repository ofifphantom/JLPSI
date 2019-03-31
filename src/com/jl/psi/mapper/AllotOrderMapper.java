package com.jl.psi.mapper;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.AllotOrder;
import com.jl.psi.model.AllotOrderCommodity;
import com.jl.psi.model.CommoditySpecification;

public interface AllotOrderMapper  extends BaseMapper<AllotOrder>{
    int deleteByPrimaryKey(Integer id);

    int insert(AllotOrder record);

    int insertSelective(AllotOrder record);

    AllotOrder selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AllotOrder record);

    int updateByPrimaryKey(AllotOrder record);
    
    
	public AllotOrder getAllocationOrderMsgById(Integer allocationId);
	/**
	 * 获取最大的编号
	 * @return
	 */
	public String selectMaxIdentifier();
	/**
	 * 批量添加 
	 * @param list
	 * @return
	 */
	public boolean insertBeatch(List<AllotOrderCommodity> list);
	/**
	 * 更改调拨单库存信息
	 * @param importWarehouseId  调入仓库id
	 * @return
	 */
	public int updateInventory(Map<String, Object> params);
	/**
	 * 调拨单明细报表
	 * @return
	 */
	public List<AllotOrder> reportMsg(Map<String, Object> params);
	/**
	 * 更改销售商品表中仓库所属id
	 * @return
	 */
	public int updateSaleOrderCommodityWarehouseId(Map<String, Object> params);
}