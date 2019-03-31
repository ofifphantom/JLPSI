package com.jl.psi.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.WriteOffMapper;
import com.jl.psi.model.Bills;
import com.jl.psi.model.WriteOff;
import com.jl.psi.service.WriteOffService;
import com.jl.psi.utils.DataTables;
@Service
public class WriteOffServiceImpl implements WriteOffService {
	@Autowired
	private WriteOffMapper writeOffMapper;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(WriteOff t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(WriteOff t) throws Exception {
		 
		return writeOffMapper.insertSelective(t);
	}

	@Override
	public WriteOff selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return writeOffMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(WriteOff t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(WriteOff t) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public DataTables dataTables(DataTables dataTables,Integer type,String writeoffCode,Integer companyOne,Integer companyTwo,String dateSearch) {
		// TODO Auto-generated method stub
		String[] columns = { "create_date"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		String[] arr=null;

		if (dateSearch!=""&&dateSearch!=null) {
			arr=dateSearch.split(" ~ ");//分割起止时间
			params.put("beginTime", arr[0]);
			params.put("closeTime", arr[1]);
		}
		params.put("type",type);
		params.put("writeoffCode",writeoffCode);
		params.put("companyOne",companyOne);
		params.put("companyTwo",companyTwo);
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		
	 
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
  		dataTables.setiTotalDisplayRecords(writeOffMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(writeOffMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(writeOffMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}

	@Override
	public String selectMaxCode() {
	 
		return writeOffMapper.selectMaxCode();
	}

}
