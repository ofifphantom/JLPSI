package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.ShippingModeMapper;
import com.jl.psi.model.Classification;
import com.jl.psi.model.ShippingMode;
import com.jl.psi.service.ShippingModeService;
import com.jl.psi.utils.DataTables;

@Service
public class ShippingModeServiceImpl implements ShippingModeService {
	
	@Autowired
	ShippingModeMapper shippingModeMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return shippingModeMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ShippingMode t) throws Exception {
		// TODO Auto-generated method stub
		return shippingModeMapper.insert(t);
	}

	@Override
	public int insertSelective(ShippingMode t) throws Exception {
		// TODO Auto-generated method stub
		return shippingModeMapper.insertSelective(t);
	}

	@Override
	public ShippingMode selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return shippingModeMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(ShippingMode t) throws Exception {
		// TODO Auto-generated method stub
		return shippingModeMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(ShippingMode t) throws Exception {
		// TODO Auto-generated method stub
		return shippingModeMapper.updateByPrimaryKey(t);
	}

	@Override
	public DataTables getShippingModeMsg(DataTables dataTables, String name, String operatorName, String operatorTime) {
		String[] columns = { "id","name","operator_identifier","operate_time"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
		
		params.put("sname", name);
		params.put("operatorName", operatorName);
		String[] arr=null;
		if (operatorTime!=""&&operatorTime!=null) {
			  arr=operatorTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("endTime", arr[1]);
		}
		dataTables.setiTotalDisplayRecords(shippingModeMapper
				.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(shippingModeMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(shippingModeMapper.selectForSearch(params));// 返回的结果集
		return dataTables;
	}

	@Override
	public List<ShippingMode> getAllShippingMode() {
		// TODO Auto-generated method stub
		return shippingModeMapper.getAllShippingMode();
	}
	
	@Override
	public List<ShippingMode> selectBatchByPrimaryKey(String[] primaryKeys) {
		Map<String,Object> map=new HashMap<>();
		List<Integer> ids=new ArrayList<>();
		for(String keys:primaryKeys){
			ids.add(Integer.parseInt(keys));
		}
		map.put("list", ids);
		return shippingModeMapper.selectBatchByPrimaryKey(map);
	}

	@Override
	public Integer deleteBatchByPrimaryKey(String[] primaryKeys) {
		Map<String,Object> map=new HashMap<>();
		List<Integer> ids=new ArrayList<>();
		for(String keys:primaryKeys){
			ids.add(Integer.parseInt(keys));
		}
		map.put("list", ids);
		return shippingModeMapper.deleteBatchByPrimaryKey(map);
	}

	@Override
	public List<ShippingMode> exportShippingMode(String name, String operatorName) {
		Map<String,Object> map=new HashMap<>();
		map.put("sname", name);
		map.put("operatorName", operatorName);
		
		return shippingModeMapper.exportShippingMode(map);
	}

	@Override
	public List<ShippingMode> selectShippingModeNamePreventRepeatAdd(ShippingMode shippingMode) {
		// TODO Auto-generated method stub
		return shippingModeMapper.selectShippingModeNamePreventRepeatAdd(shippingMode);
	}

	@Override
	public List<ShippingMode> selectShippingModeNamePreventRepeatedit(ShippingMode shippingMode) {
		// TODO Auto-generated method stub
		return shippingModeMapper.selectShippingModeNamePreventRepeatedit(shippingMode);
	}

	@Override
	public List<ShippingMode> selectShippingModeIsExistFromAO(List<Integer> list) {
		// TODO Auto-generated method stub
		return shippingModeMapper.selectShippingModeIsExistFromAO(list);
	}

	@Override
	public List<ShippingMode> selectShippingModeIsExistFromPT(List<Integer> list) {
		// TODO Auto-generated method stub
		return shippingModeMapper.selectShippingModeIsExistFromPT(list);
	}

	@Override
	public List<ShippingMode> selectShippingModeIsExistFromSO(List<Integer> list) {
		// TODO Auto-generated method stub
		return shippingModeMapper.selectShippingModeIsExistFromSO(list);
	}

}
