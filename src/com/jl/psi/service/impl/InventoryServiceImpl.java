package com.jl.psi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.InventoryMapper;
import com.jl.psi.model.Inventory;
import com.jl.psi.service.InventoryService;

@Service
public class InventoryServiceImpl implements InventoryService {
	
	@Override
	public Inventory getCommodityWarehouse(String identifier) {
		// TODO Auto-generated method stub
		return inventoryMapper.getCommodityWarehouse(identifier);
	}

	@Autowired
	InventoryMapper inventoryMapper;

	@Override
	public boolean updateInventoryDown(Inventory inventory) {
		// TODO Auto-generated method stub
		
		return inventoryMapper.updateInventoryDown(inventory);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return inventoryMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Inventory t) throws Exception {
		// TODO Auto-generated method stub
		return inventoryMapper.insert(t);
	}

	@Override
	public int insertSelective(Inventory t) throws Exception {
		// TODO Auto-generated method stub
		return inventoryMapper.insertSelective(t);
	}

	@Override
	public Inventory selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return inventoryMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Inventory t) throws Exception {
		// TODO Auto-generated method stub
		return inventoryMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Inventory t) throws Exception {
		// TODO Auto-generated method stub
		return inventoryMapper.updateByPrimaryKey(t);
	}

	@Override
	public int insertBatch(List<Inventory> inventoryList) {
		// TODO Auto-generated method stub
		return inventoryMapper.insertBatch(inventoryList);
	}

	@Override
	public int deleteByCommoditySpecificationIds(List<Integer> list) {
		// TODO Auto-generated method stub
		return inventoryMapper.deleteByCommoditySpecificationIds(list);
	}

	@Override
	public boolean updateOccupiedInventory(Inventory inventory) {
		// TODO Auto-generated method stub
		return inventoryMapper.updateOccupiedInventory(inventory);
	}

	@Override
	public int getWarehouseIdByCommoditySpecificationId(int specificationId) {
		// TODO Auto-generated method stub
		return inventoryMapper.getWarehouseIdByCommoditySpecificationId(specificationId);
	}

	@Override
	public boolean updateAddGoodsInventory(Inventory inventory) {
		// TODO Auto-generated method stub
		return inventoryMapper.updateAddGoodsInventory(inventory);
	}


	@Override
	public boolean updateOccupiedInventoryByCommoditySpecificationId(Inventory inventory) {
		// TODO Auto-generated method stub
		return inventoryMapper.updateOccupiedInventoryByCommoditySpecificationId(inventory);
	}

	@Override
	public boolean updateInventoryByCommoditySpecificationId(Inventory inventory) {
		// TODO Auto-generated method stub
		return inventoryMapper.updateInventoryByCommoditySpecificationId(inventory);
	}

	@Override
	public boolean updateBySpecificationId(Inventory inventory) {
		// TODO Auto-generated method stub
		return inventoryMapper.updateBySpecificationId(inventory);
	}

	@Override
	public boolean updateIsCreateProcurePlanTo0() {
		// TODO Auto-generated method stub
		return inventoryMapper.updateIsCreateProcurePlanTo0();
	}

	@Override
	public boolean updateOccupiedInventoryToReduceByCommoditySpecificationId(Inventory inventory) {
		// TODO Auto-generated method stub
		return inventoryMapper.updateOccupiedInventoryToReduceByCommoditySpecificationId(inventory);
	}

	@Override
	public boolean updateReduceGoodsInventory(Inventory inventory) {
		// TODO Auto-generated method stub
		return inventoryMapper.updateReduceGoodsInventory(inventory);
	}

	@Override
	public List<Inventory> selectBatchInventoryMsgBySpecificationId(List<Integer> list) {
		// TODO Auto-generated method stub
		return inventoryMapper.selectBatchInventoryMsgBySpecificationId(list);
	}

	@Override
	public boolean updateAddGoodsInventoryBySpecificationId(Inventory inventory) {
		// TODO Auto-generated method stub
		return inventoryMapper.updateAddGoodsInventoryBySpecificationId(inventory);
	}

}
