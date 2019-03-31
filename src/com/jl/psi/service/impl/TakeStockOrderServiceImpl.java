package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.TakeStockOrderMapper;
import com.jl.psi.model.TakeStockOrder;
import com.jl.psi.service.TakeStockOrderService;
import com.jl.psi.utils.DataTables;
/**
 * 盘点单serviceImpl
 * @author 景雅倩
 * @date 2018年6月11日 下午6:52:59
 */
@Service
public class TakeStockOrderServiceImpl implements TakeStockOrderService {

	@Autowired
	private TakeStockOrderMapper takeStockOrderMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<TakeStockOrder> reportTakeStockOrderMsg(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.reportTakeStockOrderMsg(params);
	}

	@Override
	public int insert(TakeStockOrder t) throws Exception {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.insert(t);
	}

	@Override
	public int insertSelective(TakeStockOrder t) throws Exception {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.insertSelective(t);
	}

	@Override
	public TakeStockOrder selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(TakeStockOrder t) throws Exception {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(TakeStockOrder t) throws Exception {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.updateByPrimaryKey(t);
	}

	@Override
	public DataTables getDataTables(DataTables dataTables, Integer page, Integer warehouseId, String takeStockDate, String originator,String searchType) {
		// TODO Auto-generated method stub
		String[] columns = {"identifier", "takeStockDate", "warehouseId", "summary", "originator", "state", "id"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		String[] arr=null;

		if (takeStockDate!=""&&takeStockDate!=null) {
			arr=takeStockDate.split(" ~ ");//分割起止时间
			params.put("beginTime", arr[0]);
			params.put("closeTime", arr[1]);
		}
		params.put("stateType",searchType);
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
	
		params.put("page", page);//从前台页面获取   用来判断是哪个页面  
		params.put("warehouseId", warehouseId);
		params.put("takeStockDate", takeStockDate);
		params.put("originator", originator);
		
		dataTables.setiTotalDisplayRecords(takeStockOrderMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(takeStockOrderMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(takeStockOrderMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}

	@Override
	public String selectMaxIdentifier() {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.selectMaxIdentifier();
	}

	@Override
	public Boolean updateStateByIds(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.updateStateByIds(map);
	}

	@Override
	public List<TakeStockOrder> getTakeStockOrderByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.getTakeStockOrderByIds(list);
	}

	@Override
	public TakeStockOrder selectTakeStockOrderDetailById(Integer id) {
		// TODO Auto-generated method stub
		return takeStockOrderMapper.selectTakeStockOrderDetailById(id);
	}

}
