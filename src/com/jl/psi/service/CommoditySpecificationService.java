package com.jl.psi.service;

import java.util.List;
import java.util.Map;

import com.jl.psi.model.ApiCommodityMsg;
import com.jl.psi.model.Commodity;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.utils.DataTables;

/**
 * 
 * @author 柳亚婷
 * @Description: 商品规格Service
 * @date: 2018年5月9日 下午4:26:34
 */
public interface CommoditySpecificationService extends BaseService<CommoditySpecification> {
	
	/**
	 * 获取商品表的信息，显示在界面上
	 * @return 
	 */
	public DataTables getCommodityMsg(DataTables dataTables,Integer messageOrDelivery,Integer classificationId, String name, String operatorName,Integer supctoId,String startTime,String endTime,Integer searchState);

	/**
	 * 批量添加商品规格
	 * @param inventoryList
	 * @return
	 */
	public boolean insertBatch(List<CommoditySpecification> list);
	
	/**
	 * 根据商品id 删除 信息
	 * @param commodityId
	 * @return
	 */
	public boolean deleteByCommodityId(Integer commodityId);
	
	/**
	 * 判断商品的规格名是否重复
	 * @param map
	 * @return
	 */
	public List<CommoditySpecification> selectGoodsSpecificationNamePreventRepeat(CommoditySpecification cs,Integer addOrUpdate); 
	
	/**
	 * 查询商品规格的详情
	 * @param id
	 * @return
	 */
	public CommoditySpecification lookCommoditySpecificationDetail(Integer id);
	
	/**
	 * 根据主键批量查询信息
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectBatchByPrimaryKey(List<Integer> list); 
	
	/**
	 * 根据主键批量删除 信息
	 * @param list
	 * @return
	 */
	public Integer deleteBatchByPrimaryKey(List<Integer> list); 
	
	/**
	 * 根据商品id获取最大的规格编号
	 * @param commodityId
	 * @return
	 */
	public String selectMaxSpecificationIdentifierByCommodityId(Integer commodityId);
	
	/**
   	 * 根据id列表更改商品状态
   	 * @param map id列表、修改的状态
   	 * @return true/false 更改成功或失败
   	 */
   	public boolean updateStateByIds(Map<String, Object> map);
   	
	/**
	 * 获取所有审核通过且未停用的商品信息
	 * @return
	 */
	public List<CommoditySpecification> getAllCommodityByStateAndIsDelete();
	
	/**
	 * 根据供应商ID获取所有审核通过且未停用的商品信息
	 * @return
	 */
	public List<CommoditySpecification> getAllCommodityByStateAndIsDeleteBySupctoId(Integer supctoId);
	/**
	 * 根据商品id获取商品规格编号
	 * @param commodityId 商品id
	 * @return
	 */
	public List<CommoditySpecification>  getAllSpecificationIdentifier(Integer commodityId);
	
	/**
	 * 获取所有审核通过且未停用的有库存商品信息
	 * @return
	 */
	public List<CommoditySpecification> getHasInventoryCommodityByStateAndIsDeleteBySupctoId();
	
	/**
	 * 根据主键查询商品税率
	 * @param id
	 * @return
	 */
	public Double selectTaxesByPrimaryKey(int id); 
	
	/**
	 * 根据仓库id获取所有审核通过且未停用的有库存记录的商品信息
	 * @return
	 */
	public List<CommoditySpecification> getHasInventoryCommodityByStateAndIsDeleteAndWarehouseId(int warehouseId);
	
	/**
	 * 根据商品规格ID获取商品的移动平均价
	 */
	public Double getMovingAveragePriceByCommoditySpecificationId(int commoditySpecificationId);
	
	/**
	 * 查询库存不足的商品 用于自动生成采购计划单
	 * @return
	 */
	public List<CommoditySpecification> selectLowStocksCommodity();
	
	/**
	 * 批量根据商品规格id获取商品信息
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectBatchMsgByCSID(List<Integer> list);
	/**
	 * 根据id列表更改状态为已删除    批量删除商品信息
	 * @param list
	 * @return
	 */
	public boolean updateStateToDeleteByIds(List<Integer> list);
	
	
	
	//判断商品是否被占用
	
	/**
	 * 判断调拨单中该商品是否存在
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectCommodityIsExistFromAOC(List<Integer> list);
	/**
	 *  判断报损单中该商品是否存在 
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectCommodityIsExistFromBOC(List<Integer> list);
	/**
	 * 判断组装/拆卸单中该商品是否存在
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectCommodityIsExistFromPOOC(List<Integer> list);
	/**
	 * 判断采购单中该商品是否存在
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectCommodityIsExistFromPC(List<Integer> list);
	/**
	 * 判断销售订单中该商品是否存在
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectCommodityIsExistFromSOC(List<Integer> list);
	/**
	 * 判断销售计划单中该商品是否存在
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectCommodityIsExistFromSPOC(List<Integer> list);
	/**
	 * 判断盘点单中该商品是否存在
	 * @param list
	 * @return
	 */
	public List<CommoditySpecification> selectCommodityIsExistFromTSOC(List<Integer> list);
	
	/**
	 * API
	 * 供MIS后台商品添加的查询购销存商品 
	 * @return
	 */
	public List<ApiCommodityMsg> selectCommodityMsgToMisGoodsApi();
	/**
	 * 根据商品id获取商品规格编号
	 * @param missId app订单id
	 * @return
	 */
	public List<CommoditySpecification>  getAppCommoditySpecificcationId(Integer missId);

	/**
	 * 清空临时数据
	 */
	public boolean clearTempDate(List<Integer> list);
	/**
	 * 账面库存表
	 * @param missId app订单id
	 * @return
	 */
	public List<CommoditySpecification>  reportAccountsGether(Map<String, Object> map);
}
