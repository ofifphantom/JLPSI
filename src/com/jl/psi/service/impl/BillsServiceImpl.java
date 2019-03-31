package com.jl.psi.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.BillsMapper;
import com.jl.psi.model.Bills;
import com.jl.psi.service.BillsService;
import com.jl.psi.utils.DataTables;

@Service
public class BillsServiceImpl implements BillsService{
	@Autowired
	private BillsMapper billsMapper;
	
	@Override
	public String selectMaxCode(Integer billsType) {
		 
		return billsMapper.selectMaxCode(billsType);
	}
	@Override
	public DataTables dataTables(DataTables dataTables, String billsType,String billsCode,Integer customerSupplierId,String dateSearch) {
		// TODO Auto-generated method stub
		String[] columns = { "bills_date"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		String[] arr=null;

		if (dateSearch!=""&&dateSearch!=null) {
			arr=dateSearch.split(" ~ ");//分割起止时间
			params.put("beginTime", arr[0]);
			params.put("closeTime", arr[1]);
		}
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
		params.put("billsType",billsType);
		params.put("billsCode",billsCode);
		params.put("customerSupplierId",customerSupplierId);
 		dataTables.setiTotalDisplayRecords(billsMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(billsMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(billsMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(Bills t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(Bills t) throws Exception {
 		return billsMapper.insertSelective(t);
	}

	@Override
	public Bills selectByPrimaryKey(Integer id) {
		 
		  return billsMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Bills t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(Bills t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	 
	@Override
	public List<Bills> reportPayOrderProcure(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return billsMapper.reportPayOrderProcure(params);
	}
	@Override
	public List<Bills> reportPayOrderSales(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return billsMapper.reportPayOrderSales(params);
	}
 
}
