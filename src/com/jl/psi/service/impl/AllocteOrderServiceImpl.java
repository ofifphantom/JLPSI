package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jl.psi.mapper.AllotOrderMapper;
import com.jl.psi.mapper.CommoditySpecificationMapper;
import com.jl.psi.mapper.InventoryMapper;
import com.jl.psi.mapper.WarehouseVindicateMapper;
import com.jl.psi.model.AllotOrder;
import com.jl.psi.model.AllotOrderCommodity;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.TakeStockOrderCommodity;
import com.jl.psi.model.Unit;
import com.jl.psi.service.AllocteOrderService;
import com.jl.psi.service.CommodityService;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.utils.DataTables;


@Service
public class AllocteOrderServiceImpl implements AllocteOrderService {
	
	
	@Autowired
	 AllotOrderMapper alloctionOderMapper;
	@Autowired
	WarehouseVindicateMapper  warehouseVindicateMapper;
	
	public AllotOrderMapper getAlloctionOderMapper() {
		return alloctionOderMapper;
	}

	public void setAlloctionOderMapper(AllotOrderMapper alloctionOderMapper) {
		this.alloctionOderMapper = alloctionOderMapper;
	}

	public WarehouseVindicateMapper getWarehouseVindicateMapper() {
		return warehouseVindicateMapper;
	}

	public void setWarehouseVindicateMapper(WarehouseVindicateMapper warehouseVindicateMapper) {
		this.warehouseVindicateMapper = warehouseVindicateMapper;
	}

	
	
	

	@Override
	public ArrayList<CommoditySpecification> getWarehouseCommodity(Integer warehouseId) {
		// TODO Auto-generated method stub
		
		return warehouseVindicateMapper.PassWarehouseCommodityById(warehouseId);
	}

	@Override
	public int updateInventory(Integer importWarehouseId,Integer specificationId) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("importWarehouseId", importWarehouseId);
		params.put("specificationId", specificationId);
		return alloctionOderMapper.updateInventory(params);
	}

	@Override
	public DataTables getAllocationOrderMsg(DataTables dataTables, Integer warehouseId, String  alloteDate,String originator,Integer type) {
		// TODO Auto-generated method stub
		
		String[] columns = {"id", "identifier"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		String[] arr=null;

		if (alloteDate!=""&&alloteDate!=null) {
			arr=alloteDate.split(" ~ ");//分割起止时间
			params.put("beginTime", arr[0]);
			params.put("closeTime", arr[1]);
		}
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
	
		params.put("warehouseId", warehouseId);
		params.put("originator", originator);
		params.put("alloteDate", alloteDate);
		params.put("type", type);
		//params.put("operatorIdentifier", operatorIdentifier);
		
		dataTables.setiTotalDisplayRecords(alloctionOderMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(alloctionOderMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(alloctionOderMapper.selectForSearch(params));// 返回的结果集
		return dataTables;
	}

	@Override
	public List<AllotOrder> reportMsg(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return alloctionOderMapper.reportMsg(params);
	}

	@Override
	public AllotOrder getAllocationOrderMsgById(Integer allocationId) {
		// TODO Auto-generated method stub
		
		return alloctionOderMapper.getAllocationOrderMsgById(allocationId);
	}

	@Override
	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String selectMaxIdentifier() {
		// TODO Auto-generated method stub
		return alloctionOderMapper.selectMaxIdentifier();
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(AllotOrder t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean insertBeatch(List<AllotOrderCommodity> list) {
		// TODO Auto-generated method stub
		return alloctionOderMapper.insertBeatch(list);
	}

	@Override
	public int insertSelective(AllotOrder t) throws Exception {
		// TODO Auto-generated method stub
		return alloctionOderMapper.insertSelective(t);
	}

	@Override
	public AllotOrder selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return  alloctionOderMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(AllotOrder t) throws Exception {
		// TODO Auto-generated method stub
		return alloctionOderMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(AllotOrder t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateSaleOrderCommodityWarehouseId(Integer importId, Integer csId, Integer exportId) {
		// TODO Auto-generated method stub
		Map<String, Object> params=new HashMap<>();
		params.put("importId", importId);
		params.put("csId", csId);
		params.put("exportId", exportId);
		
		return alloctionOderMapper.updateSaleOrderCommodityWarehouseId(params);
	}

	
	
	

}