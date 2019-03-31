package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.ClassificationMapper;
import com.jl.psi.model.Classification;
import com.jl.psi.service.ClassificationService;
import com.jl.psi.utils.DataTables;

/**
 * 
 * @author 柳亚婷
 * @date  2018年4月2日  下午3:29:59
 * @Description  分类信息实现类
 *
 */
@Service
public class ClassificationServiceImpl implements ClassificationService {

	@Autowired
	ClassificationMapper classificationMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return classificationMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Classification t) throws Exception {
		// TODO Auto-generated method stub
		return classificationMapper.insert(t);
	}

	@Override
	public int insertSelective(Classification t) throws Exception {
		// TODO Auto-generated method stub
		return classificationMapper.insertSelective(t);
	}

	@Override
	public Classification selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return classificationMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Classification t) throws Exception {
		// TODO Auto-generated method stub
		return classificationMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Classification t) throws Exception {
		// TODO Auto-generated method stub
		return classificationMapper.updateByPrimaryKey(t);
	}

	@Override
	public DataTables getClassificationMsg(DataTables dataTables, String identifier, String name, String operatorName,
			Integer type,Integer oneOrTwo,Integer oneClassification,String queryTime) {
		String[] columns = { "id", "identifier", "name","cp.id", "key_word","operator_identifier","operate_time"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式

		
		params.put("identifier", identifier);
		params.put("cname", name);
		params.put("operatorName", operatorName);
		params.put("type", type);
		params.put("oneOrTwo", oneOrTwo);
		params.put("oneClassification", oneClassification);
		String[] arr=null;
		if (queryTime!=""&&queryTime!=null) {
			  arr=queryTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("endTime", arr[1]);
		}
		
		dataTables.setiTotalDisplayRecords(classificationMapper
				.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(classificationMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(classificationMapper.selectForSearch(params));// 返回的结果集
		return dataTables;
	}

	@Override
	public Classification selectClassifityNamePreventRepeatAdd(Classification c) {
		// TODO Auto-generated method stub
		return classificationMapper.selectClassifityNamePreventRepeatAdd(c);
	}

	@Override
	public Classification selectClassifityNamePreventRepeatEdit(Classification c) {
		// TODO Auto-generated method stub
		return classificationMapper.selectClassifityNamePreventRepeatEdit(c);
	}

	@Override
	public List<Classification> selectTwoByOneId(Integer parentId) {
		// TODO Auto-generated method stub
		return classificationMapper.selectTwoByOneId(parentId);
	}

	@Override
	public List<Classification> selectBatchByPrimaryKey(String[] primaryKeys) {
		Map<String,Object> map=new HashMap<>();
		List<Integer> ids=new ArrayList<>();
		for(String keys:primaryKeys){
			ids.add(Integer.parseInt(keys));
		}
		map.put("list", ids);
		return classificationMapper.selectBatchByPrimaryKey(map);
	}

	@Override
	public Integer deleteBatchByPrimaryKey(String[] primaryKeys) {
		Map<String,Object> map=new HashMap<>();
		List<Integer> ids=new ArrayList<>();
		for(String keys:primaryKeys){
			ids.add(Integer.parseInt(keys));
		}
		map.put("list", ids);
		return classificationMapper.deleteBatchByPrimaryKey(map);
	}

	@Override
	public List<Classification> selectAllOneClassifityByType(Integer type) {
		// TODO Auto-generated method stub
		return classificationMapper.selectAllOneClassifityByType(type);
	}

	@Override
	public List<Classification> selectMsgToExport(String identifier, String name, String operatorName, Integer type,
			Integer oneOrTwo) {
		Map<String,Object> map=new HashMap<>();
		map.put("identifier", identifier);
		map.put("cname", name);
		map.put("operatorName", operatorName);
		map.put("type", type);
		map.put("oneOrTwo", oneOrTwo);
		return classificationMapper.selectMsgToExport(map);
	}

	@Override
	public String selectMaxOneClaIdentifier(Integer type) {
		return classificationMapper.selectMaxOneClaIdentifier(type);
	}

	@Override
	public String selectMaxTwoClaIdentifier(Integer parentId) {
		return classificationMapper.selectMaxTwoClaIdentifier(parentId);
	}

	@Override
	public List<Classification> selectAllTwoClassifityByParentId(Integer parentId) {
		// TODO Auto-generated method stub
		return classificationMapper.selectAllTwoClassifityByParentId(parentId);
	}

	@Override
	public List<Classification> selectClassificationIsExistFromSupcto(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return classificationMapper.selectClassificationIsExistFromSupcto(map);
	}

	@Override
	public List<Classification> selectClassificationIsExistFromCommodity(List<Integer> list) {
		// TODO Auto-generated method stub
		return classificationMapper.selectClassificationIsExistFromCommodity(list);
	}

}
