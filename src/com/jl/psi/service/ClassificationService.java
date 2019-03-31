package com.jl.psi.service;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.Classification;
import com.jl.psi.utils.DataTables;

/**
 * 
 * @author 柳亚婷
 * @date  2018年4月2日  下午3:29:46
 * @Description  分类信息service
 *
 */

public interface ClassificationService extends BaseService<Classification>{
	
	/**
	 * 获取分类表的信息，显示在界面上
	 * 
	 */
	public DataTables getClassificationMsg(DataTables dataTables,String identifier,String name,String operatorName,Integer type,Integer oneOrTwo,Integer oneClassification,String queryTime);

	/**
	 * 新增时防止分类名称重复接口
	 * @param c
	 * @return
	 */
	public Classification selectClassifityNamePreventRepeatAdd(Classification c);
	
	/**
	 * 修改时防止分类名称重复接口 
	 * @param c
	 * @return
	 */
	public Classification selectClassifityNamePreventRepeatEdit(Classification c);
	
	/**
	 * 根据一级分类id查询二级分类 
	 * @param c
	 * @return
	 */
	public List<Classification> selectTwoByOneId(Integer parentId);
	
	/**
	 * 根据主键批量查询信息
	 * @param c
	 * @return
	 */
	public List<Classification> selectBatchByPrimaryKey(String[] primaryKeys);
	
	/**
	 * 根据主键批量删除 信息 
	 * @param c
	 * @return
	 */
	public Integer deleteBatchByPrimaryKey(String[] primaryKeys);
	
	/**
	 * 获取所属类型下的所有一级分类
	 * @param type
	 * @return
	 */
	public List<Classification> selectAllOneClassifityByType(Integer type);
	
	/**
	 * 查询需要导出的信息
	 * @param type
	 * @return
	 */
	public List<Classification> selectMsgToExport(String identifier,String name,String operatorName,Integer type,Integer oneOrTwo);
	
	/**
	 * 查询对应类型下的最大一级分类编号
	 * @param type
	 * @return
	 */
	public String selectMaxOneClaIdentifier(Integer type);
	
	/**
	 * 查询对应父级分类下的最大二级分类编号
	 * @param type
	 * @return
	 */
	public String selectMaxTwoClaIdentifier(Integer parentId);
	/**
	 * 查询对应父级分类下所有的二级分类
	 * @param parentId
	 * @return
	 */
	public List<Classification> selectAllTwoClassifityByParentId(Integer parentId);
	
	/**
	 * 判断客户/供应商一二级分类是否被占用
	 * @param map
	 * @return
	 */
	public List<Classification> selectClassificationIsExistFromSupcto(Map<String,Object> map);
	
	/**
	 * 判断商品一二级分类是否被占用
	 * @param map
	 * @return
	 */
	public List<Classification> selectClassificationIsExistFromCommodity(List<Integer> list);
}
