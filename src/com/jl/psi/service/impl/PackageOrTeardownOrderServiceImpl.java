package com.jl.psi.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.PackageOrTeardownOrderMapper;
import com.jl.psi.model.PackageOrTeardownOrder;
import com.jl.psi.service.PackageOrTeardownOrderService;
import com.jl.psi.utils.DataTables;

@Service
public class PackageOrTeardownOrderServiceImpl implements PackageOrTeardownOrderService {
	
	@Autowired
	PackageOrTeardownOrderMapper packageOrTeardownOrderMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(PackageOrTeardownOrder t) throws Exception {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.insert(t);
	}

	@Override
	public List<PackageOrTeardownOrder> reportPackageOrTeardownOrderMsg(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.reportPackageOrTeardownOrderMsg(params);
	}

	@Override
	public int insertSelective(PackageOrTeardownOrder t) throws Exception {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.insertSelective(t);
	}

	@Override
	public PackageOrTeardownOrder selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(PackageOrTeardownOrder t) throws Exception {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(PackageOrTeardownOrder t) throws Exception {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.updateByPrimaryKey(t);
	}

	@Override
	public String selectMaxIdentifier(Integer orderType) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.selectMaxIdentifier(orderType);
	}

	@Override
	public DataTables getPackageOrTeardownOrderMsg(DataTables dataTables, Integer orderType,Integer page,Integer searchWarehouse,String dateSearch,String searchOriginator,String searchType) {
		String[] columns = { "id", "identifier", "name","cp.id", "key_word","operator_identifier","operate_time"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		String[] arr=null;

		if (dateSearch!=""&&dateSearch!=null) {
			arr=dateSearch.split(" ~ ");//分割起止时间
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

		params.put("orderType", orderType);
		params.put("page", page);
		params.put("searchWarehouse", searchWarehouse);
		params.put("dateSearch", dateSearch);
		params.put("searchOriginator", searchOriginator);
		
		dataTables.setiTotalDisplayRecords(packageOrTeardownOrderMapper
				.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(packageOrTeardownOrderMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(packageOrTeardownOrderMapper.selectForSearch(params));// 返回的结果集
		return dataTables;
	}

	@Override
	public PackageOrTeardownOrder getPackageOrTeardownOrderMsgById(Integer id) {
		// TODO Auto-generated method stub
		return packageOrTeardownOrderMapper.getPackageOrTeardownOrderMsgById(id);
	}
	

	

}
