package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.BreakageOrderMapper;
import com.jl.psi.model.BreakageOrder;
import com.jl.psi.service.BreakageOrderService;
import com.jl.psi.utils.DataTables;

/**
 * 报损单ServiceImpl
 * @author 景雅倩
 * @date 2018年6月14日 下午4:56:48
 */

@Service
public class BreakageOrderServiceImpl implements BreakageOrderService {
	@Autowired
	private BreakageOrderMapper breakageOrderMapper;
	
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return breakageOrderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(BreakageOrder t) throws Exception {
		// TODO Auto-generated method stub
		return breakageOrderMapper.insert(t);
	}

	@Override
	public int insertSelective(BreakageOrder t) throws Exception {
		// TODO Auto-generated method stub
		return breakageOrderMapper.insertSelective(t);
	}

	@Override
	public BreakageOrder selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return breakageOrderMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(BreakageOrder t) throws Exception {
		// TODO Auto-generated method stub
		return breakageOrderMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(BreakageOrder t) throws Exception {
		// TODO Auto-generated method stub
		return breakageOrderMapper.updateByPrimaryKey(t);
	}

	@Override
	public DataTables getDataTables(DataTables dataTables, Integer page, Integer warehouseId, String breakageDate,
			String originator,String searchType) {
		// TODO Auto-generated method stub
		String[] columns = {"identifier", "breakageDate", "warehouseId", "summary", "originator", "state", "id"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		String[] arr=null;

		if (breakageDate!=""&&breakageDate!=null) {
			arr=breakageDate.split(" ~ ");//分割起止时间
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
		params.put("breakageDate", breakageDate);
		params.put("originator", originator);
		
		dataTables.setiTotalDisplayRecords(breakageOrderMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(breakageOrderMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(breakageOrderMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}

	@Override
	public BreakageOrder selectBreakageOrderDetailById(Integer id) {
		// TODO Auto-generated method stub
		return breakageOrderMapper.selectBreakageOrderDetailById(id);
	}

	@Override
	public String  selectMaxIdentifier() {
		// TODO Auto-generated method stub
		return breakageOrderMapper.selectMaxIdentifier();
	}

	@Override
	public List<BreakageOrder> reporBreakOrdertMsg(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return breakageOrderMapper.reporBreakOrdertMsg(params);
	}

	@Override
	public Boolean updateStateByIds(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return breakageOrderMapper.updateStateByIds(map);
	}

	@Override
	public List<BreakageOrder> getBreakageOrderByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return breakageOrderMapper.getBreakageOrderByIds(list);
	}

}
