package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jl.psi.mapper.WarehouseMapper;
import com.jl.psi.mapper.WarehouseVindicateMapper;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.Warehouse;
import com.jl.psi.service.WarehouseService;
import com.jl.psi.utils.DataTables;

/**
 * 
 * @author 景雅倩
 * @date  2018年4月9日  下午4:29:02
 * @Description 仓库管理Service实现类
 *
 */
@Service
public class WarehouseServiceImpl implements WarehouseService {
	
	@Override
	public List<Warehouse> selectWarehouseById(Integer id) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectWarehouseById(id);
	}

	@Autowired
	WarehouseMapper warehouseMapper;
	@Autowired
	WarehouseVindicateMapper wvm;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return warehouseMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Warehouse t) throws Exception {
		// TODO Auto-generated method stub
		return warehouseMapper.insert(t);
	}

	@Override
	public int insertSelective(Warehouse t) throws Exception {
		// TODO Auto-generated method stub
		return warehouseMapper.insertSelective(t);
	}

	@Override
	public Warehouse selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Warehouse t) throws Exception {
		// TODO Auto-generated method stub
		return warehouseMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Warehouse t) throws Exception {
		// TODO Auto-generated method stub
		return warehouseMapper.updateByPrimaryKey(t);
	}

	@Override
	public List<Warehouse> selectAllMsg() {
		// TODO Auto-generated method stub
		return warehouseMapper.selectAllMsg();
	}
	
	
	
	@Override
	public DataTables dataTables(DataTables dataTables, String identifier,
			String name, String operatorIdentifier,String position, String operatorTime) {
		// TODO Auto-generated method stub
		String[] columns = {"id", "identifier", "name","position", "operator_identifier","operator_time","id"};
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
		params.put("position", position);
		String[] arr=null;
		if (operatorTime!=""&&operatorTime!=null) {
			  arr=operatorTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("endTime", arr[1]);
		}
		dataTables.setiTotalDisplayRecords(warehouseMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(warehouseMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(warehouseMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}

	@Override
	public DataTables getWarehouseMsg(DataTables dataTables,String brand,String commodityName,Integer warehouseId,Integer classficationId) {
		// TODO Auto-generated method stub
		String[] columns = { "specificationIdentifier", "commodity.name",
				"commodity.brand", "commodity.classification.name",
				"specificationName","units.name",
				"inventories.inventory",
				"inventories.warehouse.name",
				"qualityPeriod"};
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
		params.put("brand", brand);
		params.put("commodityName", commodityName);
		params.put("warehouseId", warehouseId);
		params.put("classficationId", classficationId);
		List<Object> selectForSearch=new ArrayList<>();
		selectForSearch =wvm.selectForSearch(params);
		//System.out.println(">>>>>>>>>>>>>>"+selectForSearch.size());
//		String commodityName="";
//		for (int i = 0; i < selectForSearch.size(); i++) {
//			Commodity commodity=((CommoditySpecification)selectForSearch.get(i)).getCommodity();
////			commodityName="";
//			
//			Set<Object> set=new HashSet<>();
//			
//			if (set.contains(commodity.getName())) {
//				set.add(commodity.getName());
//				commodityName+=commodity.getName();
//				System.out.println("存在");
//			}else {
//				set.add(commodity.getName());
//			}
////			for (int j = 0; j < commoditySpecifications.size(); j++) {
////				if (j<commoditySpecifications.size()-1) {
////					commodityName+=commoditySpecifications.get(j).getCommodity().getName();
////				}else {
////					commodityName+=commoditySpecifications.get(j).getCommodity().getName();
////				}
////			}
//			
//		}
//		((CommoditySpecification)selectForSearch).getCommodity().setName(commodityName);
//		// 不能用limit来进行分页，因为结果集有重复，只能在service中手动进行分页
//		List<Object> resultTableList = new ArrayList<>();
//		if (selectForSearch.size()-Integer.parseInt(dataTables.getiDisplayStart())>Integer
//				.parseInt(dataTables.getPageDisplayLength())) {
//			for (int i = Integer.parseInt(dataTables.getiDisplayStart()); i < Integer.parseInt(
//					dataTables.getiDisplayStart()) + Integer.parseInt(dataTables.getPageDisplayLength()); i++) {
//				resultTableList.add(selectForSearch.get(i));
//			}
//		}else {
//			for (int i = Integer.parseInt(dataTables.getiDisplayStart()); i < selectForSearch.size(); i++) {
//				resultTableList.add(selectForSearch.get(i));
//			}
//		}
		
		dataTables.setiTotalDisplayRecords(wvm.iTotalDisplayRecords(params));
		dataTables.setiTotalRecords(wvm.iTotalRecords(params));
		dataTables.setData(selectForSearch);
		
		return dataTables;
	}
	

	@Override
	public List<Warehouse> selectWarehouseIdentifierByWarehouseId(
			ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectWarehouseIdentifierByWarehouseId(list);
	}

	@Override
	public List<Warehouse> getWarehouseByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return warehouseMapper.getWarehouseByIds(list);
	}

	@Override
	public boolean deleteWarehouseByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return warehouseMapper.deleteWarehouseByIds(list);
	}

	@Override
	public List<Warehouse> selectMsgOrderBySearchMsg(
			String identifier,
			String name, String operatorIdentifier) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		
		params.put("identifier", identifier);
		params.put("name", name);
		params.put("operatorIdentifier", operatorIdentifier);
		
		return warehouseMapper.selectMsgOrderBySearchMsg(params);
	}

	@Override
	public ArrayList<CommoditySpecification> getAll(String brand,String commodityName,Integer warehouseId,Integer classficationId) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("brand", brand);
		params.put("commodityName", commodityName);
		params.put("warehouseId", warehouseId);
		params.put("classficationId", classficationId);
		return wvm.getWarehouseMsg(params);
	}


	@Override
	public Warehouse selectById(Integer id) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectById(id);
	}


	@Override
	public List<Warehouse> selectWarehouseIdentifierFromAllotOrderByWarehouseId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectWarehouseIdentifierFromAllotOrderByWarehouseId(list);
	}

	@Override
	public List<Warehouse> selectWarehouseIdentifierFromBreakageOrderByWarehouseId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectWarehouseIdentifierFromBreakageOrderByWarehouseId(list);
	}

	@Override
	public List<Warehouse> selectWarehouseIdentifierFromPackageOrTeardownOrderByWarehouseId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectWarehouseIdentifierFromPackageOrTeardownOrderByWarehouseId(list);
	}

	@Override
	public List<Warehouse> selectWarehouseIdentifierFromTakeStockOrderByWarehouseId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectWarehouseIdentifierFromTakeStockOrderByWarehouseId(list);
	}

	@Override
	public List<Warehouse> selectWarehouseIdentifierFromPersonByWarehouseId(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return warehouseMapper.selectWarehouseIdentifierFromPersonByWarehouseId(list);
	}

	@Override
	public List<Warehouse> checkIsRepeat(Warehouse warehouse) {
		// TODO Auto-generated method stub
		return warehouseMapper.checkIsRepeat(warehouse);
	}


}
