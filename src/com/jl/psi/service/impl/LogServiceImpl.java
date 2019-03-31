package com.jl.psi.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.LogMapper;
import com.jl.psi.model.Log;
import com.jl.psi.service.LogService;
import com.jl.psi.utils.DataTables;
/**
 * 日志ServiceImpl
 * @author 景雅倩
 * @date  2017-11-3  下午3:44:28
 * @Description TODO
 */
@Service
public class LogServiceImpl implements LogService{

	@Autowired
	private LogMapper logMapper;
	

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return logMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Log t) throws Exception {
		// TODO Auto-generated method stub
		return logMapper.insert(t);
	}

	@Override
	public int insertSelective(Log t) throws Exception {
		// TODO Auto-generated method stub
		return logMapper.insertSelective(t);
	}

	@Override
	public Log selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return logMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Log t) throws Exception {
		// TODO Auto-generated method stub
		return logMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Log t) throws Exception {
		// TODO Auto-generated method stub
		return logMapper.updateByPrimaryKey(t);
	}

	@Override
	public DataTables getLogMsg(DataTables dataTables, String operatorIdentifier, String operatorType,String operatorTime,Integer operatorDepartment) {
		String[] columns = { "id", "operate_type", "operate_object", "operator_identifier","operate_time"};
		
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
		
		//保存搜索词
		if(operatorType==null||"".equals(operatorType)){
			params.put("operatorType",null);
		}
		else{
			params.put("operatorType", Integer.parseInt(operatorType));	
		}
		String[] arr=null;
		if (operatorTime!=""&&operatorTime!=null) {
			  arr=operatorTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("closeTime", arr[1]);
		}
		
		params.put("operatorIdentifier", operatorIdentifier);
		params.put("operatorDepartment", operatorDepartment);
		//params.put("operatorTime", operatorTime);
		dataTables.setiTotalDisplayRecords(logMapper
				.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(logMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(logMapper.selectForSearch(params));// 返回的结果集
		return dataTables;
	}
   
}