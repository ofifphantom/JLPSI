package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jl.psi.mapper.SupctoMapper;
import com.jl.psi.model.Supcto;
import com.jl.psi.service.SupctoService;
import com.jl.psi.utils.DataTables;

/**
 * 客戶/供应商ServiceImpl
 * @author THINK
 *
 */

@Service
public class SupctoServiceImpl implements SupctoService {

	@Autowired
	private SupctoMapper supctoMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return supctoMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Supcto t) throws Exception {
		// TODO Auto-generated method stub
		return supctoMapper.insert(t);
	}

	@Override
	public int insertSelective(Supcto t) throws Exception {
		// TODO Auto-generated method stub
		return supctoMapper.insertSelective(t);
	}

	@Override
	public Supcto selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return supctoMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Supcto t) throws Exception {
		// TODO Auto-generated method stub
		return supctoMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Supcto t) throws Exception {
		// TODO Auto-generated method stub
		return supctoMapper.updateByPrimaryKey(t);
	}
	
	

	@Override
	public DataTables getDataTables(DataTables dataTables, Integer flag,
			Integer customerOrSupplier,
			String classificationId, String name, String fromType,String state,
			String provinceCode, String cityCode, String areaCode,String operatorIdentifier,String operatorTime) {
		// TODO Auto-generated method stub
				String[] columns = {"id", "identifier", "name", "state"};
				Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
				params.put("iDisplayStart",
						Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
				params.put("pageDisplayLength",
						Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
				params.put(dataTables.getsSortDir_0(),
						columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
			
				params.put("flag", flag);//从前台页面获取   用来判断是哪个页面  1：管理页面   2:审核页面
				params.put("customerOrSupplier", customerOrSupplier);//从前台页面获取   用来判断是哪个页面  1：客户   2:供应商
				params.put("classificationId", classificationId);
				params.put("name", name);
				params.put("fromType", fromType);
				params.put("state", state);
				params.put("provinceCode", provinceCode);
				params.put("cityCode", cityCode);
				params.put("areaCode", areaCode);
				params.put("operatorIdentifier", operatorIdentifier);
				
				String[] arr=null;
				if (operatorTime!=""&&operatorTime!=null) {
					  arr=operatorTime.split(" ~ ");//分割起止时间
					  params.put("beginTime", arr[0]);
					  params.put("endTime", arr[1]);
				}
				
				dataTables.setiTotalDisplayRecords(supctoMapper.iTotalDisplayRecords(params));// 搜索结果总行数
				dataTables.setiTotalRecords(supctoMapper.iTotalRecords(params));// 所有记录总行数
				dataTables.setData(supctoMapper.selectForSearch(params));// 返回的结果集
				
				return dataTables;
	}

	@Override
	public boolean updateStateByIds(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return supctoMapper.updateStateByIds(map);
	}

	@Override
	public List<Supcto> getSupctoByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.getSupctoByIds(list);
	}

	@Override
	public List<Supcto> selectAllMsgByCustomerOrSupplier(Integer customerOrSupplier) {
		// TODO Auto-generated method stub
		return supctoMapper.selectAllMsgByCustomerOrSupplier(customerOrSupplier);
	}

	@Override
	public List<Supcto> selectAllCustomerByCustomerOrSupplier(Integer customerOrSupplier) {
		return supctoMapper.selectAllCustomerByCustomerOrSupplier(customerOrSupplier);

	}

	@Override
	public boolean deleteSupctoByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.deleteSupctoByIds(list);
	}

	@Override
	public List<Supcto> selectSupctoIdentifierByIdAndCommodity(
			ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.selectSupctoIdentifierByIdAndCommodity(list);
	}

	@Override
	public List<Supcto> selectMsgOrderBySearchMsg(Integer flag,
			Integer customerOrSupplier, String classificationId, String name,
			String fromType, String state, String provinceCode,
			String cityCode, String areaCode, String operatorIdentifier) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		
		params.put("flag", flag);
		params.put("customerOrSupplier", customerOrSupplier);
		params.put("classificationId", classificationId);
		params.put("name", name);
		params.put("fromType", fromType);
		params.put("state", state);
		params.put("provinceCode", provinceCode);
		params.put("cityCode", cityCode);
		params.put("areaCode", areaCode);
		params.put("operatorIdentifier", operatorIdentifier);
		return supctoMapper.selectMsgOrderBySearchMsg(params);
	}


	@Override
	public List<Supcto> getSupctoByTransportMode(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.getSupctoByTransportMode(list);
	}

	@Override
	public List<Supcto> selectSupctoIdentifierFromProcureTableByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.selectSupctoIdentifierFromProcureTableByIds(list);
	}

	@Override
	public List<Supcto> selectSupctoIdentifierFromSalesOrderByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.selectSupctoIdentifierFromSalesOrderByIds(list);
	}

	@Override
	public List<Supcto> selectSupctoIdentifierFromSalesPlanOrderByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.selectSupctoIdentifierFromSalesPlanOrderByIds(list);
	}
	
	

	@Override
	public int updateAdvanceMoney(Integer id, Double advanceMoney) {
 		return supctoMapper.updateAdvanceMoney(id, advanceMoney);
	}

	@Override
	public List<Supcto> selectSupctoIdentifierFromBillsByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.selectSupctoIdentifierFromBillsByIds(list);
	}

	@Override
	public List<Supcto> selectSupctoIdentifierFromWriteOffByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return supctoMapper.selectSupctoIdentifierFromWriteOffByIds(list);
	}

	@Override
	public boolean updateNewDataById(int id) {
		// TODO Auto-generated method stub
		return supctoMapper.updateNewDataById(id);
	}

	@Override
	public List<Supcto> checkIsRepeat(Supcto supcto){
		// TODO Auto-generated method stub
		return supctoMapper.checkIsRepeat(supcto);
	}
	
	
	

}
