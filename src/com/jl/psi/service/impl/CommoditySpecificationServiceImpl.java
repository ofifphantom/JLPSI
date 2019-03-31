package com.jl.psi.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.CommoditySpecificationMapper;
import com.jl.psi.mapper.ProcureCommodityMapper;
import com.jl.psi.mapper.ProcureTableMapper;
import com.jl.psi.model.ApiCommodityMsg;
import com.jl.psi.model.Commodity;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.Unit;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.ProcureTableService;
import com.jl.psi.utils.DataTables;

/**
 * 
 * @author 柳亚婷
 * @Description: 商品规格service实现类
 * @date: 2018年5月9日 下午4:27:12
 */
@Service
public class CommoditySpecificationServiceImpl implements CommoditySpecificationService {

	@Autowired
	private CommoditySpecificationMapper commoditySpecificationMapper;
	@Autowired
	private ProcureCommodityMapper procureCommodityMapper;
	@Autowired
	private ProcureTableMapper procureTableMapper;
	
	
	@Override
	public List<CommoditySpecification> getAppCommoditySpecificcationId(Integer missId) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.getAppCommoditySpecificcationId(missId);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(CommoditySpecification t) throws Exception {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.insert(t);
	}

	@Override
	public int insertSelective(CommoditySpecification t) throws Exception {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.insertSelective(t);
	}

	@Override
	public CommoditySpecification selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(CommoditySpecification t) throws Exception {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(CommoditySpecification t) throws Exception {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.updateByPrimaryKey(t);
	}
	
	
	@Override
	public DataTables getCommodityMsg(DataTables dataTables,Integer messageOrDelivery, Integer classificationId, String name, String operatorName,Integer supctoId,String startTime,String endTime,Integer searchState) {
		String[] columns = { "id", "identifier", "c.name", "shoutName","specifications","classificationId","mnemonicCode","brand","c.state","c.operatorIdentifier","id"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
	
		params.put("messageOrDelivery", messageOrDelivery);
		params.put("classificationId", classificationId);
		params.put("cname", name);
		params.put("operatorName", operatorName);
		params.put("supctoId", supctoId);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("state", searchState);
		
		List<Object> commoditySpecifications=commoditySpecificationMapper.selectForSearch(params);
		for(int i=0;i<commoditySpecifications.size();i++) {
			CommoditySpecification commoditySpecification=(CommoditySpecification) commoditySpecifications.get(i);
			for(Unit un:commoditySpecification.getUnits()){
				if(un.getBasicUnit()==1||un.getMiniPurchasing()==1){
					un.setPurchasePrice(procureTableMapper.getOriginalUnitPrice(commoditySpecification.getId()));
				}
			}
		}
		
		dataTables.setiTotalDisplayRecords(commoditySpecificationMapper
				.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(commoditySpecificationMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(commoditySpecifications);// 返回的结果集
		return dataTables;
	}

	@Override
	public boolean insertBatch(List<CommoditySpecification> list) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.insertBatch(list);
	}

	@Override
	public boolean deleteByCommodityId(Integer commodityId) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.deleteByCommodityId(commodityId);
	}

	@Override
	public List<CommoditySpecification> selectGoodsSpecificationNamePreventRepeat(CommoditySpecification cs,Integer addOrUpdate) {
		Map<String,Object> map=new HashMap<>();
		map.put("commodityId", cs.getCommodityId());
		map.put("specificationName", cs.getSpecificationName());
		map.put("addOrUpdate", addOrUpdate);
		if(addOrUpdate==2){
			map.put("id", cs.getId());
		}
		return commoditySpecificationMapper.selectGoodsSpecificationNamePreventRepeat(map);
	}

	@Override
	public CommoditySpecification lookCommoditySpecificationDetail(Integer id) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.lookCommoditySpecificationDetail(id);
	}

	@Override
	public List<CommoditySpecification> selectBatchByPrimaryKey(List<Integer> list) {
		
		return commoditySpecificationMapper.selectBatchByPrimaryKey(list);
	}

	@Override
	public Integer deleteBatchByPrimaryKey(List<Integer> list) {
		
		return commoditySpecificationMapper.deleteBatchByPrimaryKey(list);
	}

	@Override
	public String selectMaxSpecificationIdentifierByCommodityId(Integer commodityId) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.selectMaxSpecificationIdentifierByCommodityId(commodityId);
	}

	@Override
	public boolean updateStateByIds(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.updateStateByIds(map);
	}

	@Override
	public List<CommoditySpecification> getAllCommodityByStateAndIsDelete() {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.getAllCommodityByStateAndIsDelete();
	}

	@Override
	public List<CommoditySpecification> getAllCommodityByStateAndIsDeleteBySupctoId(Integer supctoId) {
		Map<String,Integer> map=new HashMap<>();
		map.put("supctoId", supctoId);
		return commoditySpecificationMapper.getAllCommodityByStateAndIsDeleteBySupctoId(map);
	}

	@Override
	public List<CommoditySpecification> getAllSpecificationIdentifier(Integer commodityId) {

		return commoditySpecificationMapper.getAllSpecificationIdentifier(commodityId);
	}

	@Override
	public List<CommoditySpecification> getHasInventoryCommodityByStateAndIsDeleteBySupctoId() {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.getHasInventoryCommodityByStateAndIsDeleteBySupctoId();
	}

	@Override
	public Double selectTaxesByPrimaryKey(int id) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.selectTaxesByPrimaryKey(id);
	}

	@Override
	public List<CommoditySpecification> getHasInventoryCommodityByStateAndIsDeleteAndWarehouseId(int warehouseId) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.getHasInventoryCommodityByStateAndIsDeleteAndWarehouseId(warehouseId);
	}

	@Override
	public Double getMovingAveragePriceByCommoditySpecificationId(int commoditySpecificationId) {
		// TODO Auto-generated method stub
		//获取已开单的采购订单
		List<ProcureCommodity> procureCommoditys = procureCommodityMapper.getProcureCommodityByCommoditySpecificationId(commoditySpecificationId);
		
		//计算移动平均价
		double totalPrice = 0;
		int totalNum = 0;
		
		if(procureCommoditys.size()>0) {//有采购记录
			//计算移动平均价
			for (int i = 0; i < procureCommoditys.size(); i++) {
				if(procureCommoditys.get(i).getArrivalQuantity()!=null){
					totalPrice += procureCommoditys.get(i).getBusinessUnitPrice()*procureCommoditys.get(i).getArrivalQuantity();//业务单价*到货数量
					totalNum += procureCommoditys.get(i).getArrivalQuantity();//到货数量
				}
				
			}
			if(totalPrice!=0){
				double movingAveragePrice = totalPrice/totalNum;
				BigDecimal b = new BigDecimal(movingAveragePrice);  
				movingAveragePrice = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
				return movingAveragePrice;
			}
			else{
				return null;
			}
			
		}else {//没有采购记录
			return null;
		}
		
		
		
	}

	@Override
	public List<CommoditySpecification> selectLowStocksCommodity() {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.selectLowStocksCommodity();
	}

	
	
	//判断商品是否被占用
	@Override
	public List<CommoditySpecification> selectCommodityIsExistFromAOC(List<Integer> list) {
		
		return commoditySpecificationMapper.selectCommodityIsExistFromAOC(list);
	}

	@Override
	public List<CommoditySpecification> selectCommodityIsExistFromBOC(List<Integer> list) {
		
		return commoditySpecificationMapper.selectCommodityIsExistFromBOC(list);
	}

	@Override
	public List<CommoditySpecification> selectCommodityIsExistFromPOOC(List<Integer> list) {
		
		return commoditySpecificationMapper.selectCommodityIsExistFromPOOC(list);
	}

	@Override
	public List<CommoditySpecification> selectCommodityIsExistFromPC(List<Integer> list) {
		
		return commoditySpecificationMapper.selectCommodityIsExistFromPC(list);
	}

	@Override
	public List<CommoditySpecification> selectCommodityIsExistFromSOC(List<Integer> list) {
		
		return commoditySpecificationMapper.selectCommodityIsExistFromSOC(list);
	}

	@Override
	public List<CommoditySpecification> selectCommodityIsExistFromSPOC(List<Integer> list) {
		
		return commoditySpecificationMapper.selectCommodityIsExistFromSPOC(list);
	}

	@Override
	public List<CommoditySpecification> selectCommodityIsExistFromTSOC(List<Integer> list) {
		
		return commoditySpecificationMapper.selectCommodityIsExistFromTSOC(list);
	}

	@Override
	public List<CommoditySpecification> selectBatchMsgByCSID(List<Integer> list) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.selectBatchMsgByCSID(list);
	}

	@Override
	public List<ApiCommodityMsg> selectCommodityMsgToMisGoodsApi() {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.selectCommodityMsgToMisGoodsApi();
	}

	@Override
	public boolean clearTempDate(List<Integer> list) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.clearTempDate(list);
	}

	@Override
	public boolean updateStateToDeleteByIds(List<Integer> list) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.updateStateToDeleteByIds(list);
	}

	@Override
	public List<CommoditySpecification> reportAccountsGether(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return commoditySpecificationMapper.reportAccountsGether(map);
	}
	
	
	
	
}
