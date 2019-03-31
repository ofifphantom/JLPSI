package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.mapper.SalesOrderMapper;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.model.Unit;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.SalesOrderService;
import com.jl.psi.utils.DataTables;

/**
 * @author 景雅倩
 * @date 2018年5月23日 上午10:47:52
 * @Description 销售订单ServiceImpl
 */

@Service
public class SalesOrderServiceImpl implements SalesOrderService {

	@Override
	public List<SalesOrder> reportSalesOrderOpenGether(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportSalesOrderOpenGether(map);
	}

	@Override
	public boolean updateStateByParentId(Integer parentId) {
		// TODO Auto-generated method stub
		return salesOrderMapper.updateStateByParentId(parentId);
	}

	@Override
	public boolean updateStateByMisId(Integer id) {
		// TODO Auto-generated method stub
		return salesOrderMapper.updateStateByMisId(id);
	}

	@Override
	public List<SalesOrder> reportAccountsGetherOne(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportAccountsGetherOne(params);
	}

	@Override
	public List<SalesOrder> reportGetMoneyGetherOne(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportGetMoneyGetherOne(map);
	}

	@Override
	public List<SalesOrder> reportGetMoneyGetherTwo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportGetMoneyGetherTwo(map);
	}

	@Override
	public List<SalesOrder> reportGetMoneyGetherThree(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportGetMoneyGetherThree(map);
	}

	@Override
	public List<SalesOrder> reportSalesOpenReceiveMoney(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportSalesOpenReceiveMoney(map);
	}

	@Override
	public List<SalesOrder> reportProfitDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<SalesOrder> list=salesOrderMapper.reportProfitDetail(map);
		Double avg;
		for (SalesOrder salesOrder : list) {
			
			for (SalesOrderCommodity salesOrderCommodity : salesOrder.getSalesOrderCommodities()) {
				//int csId=allotOrderCommodity.getCommoditySpecificationId();
				for (Unit unit : salesOrderCommodity.getCommoditySpecification().getUnits()) {
						System.out.println("csid"+salesOrderCommodity.getCommoditySpecification().getId());
						avg=commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(salesOrderCommodity.getCommoditySpecification().getId());
						System.out.println("avg"+avg);
						if (avg!=null) {
							System.out.println("不为空");
							unit.setMiniPrice(avg);
						}else {
							System.out.println("为空"+unit.getMiniPrice()+">>>>>>>csid"+salesOrderCommodity.getCommoditySpecificationId());
						}
					
					
			}
			}
			}
		return list;
	}

	@Override
	public List<SalesOrder> reportProfitGether(Map<String, Object> map){
		// TODO Auto-generated method stub
		List<SalesOrder> list=	salesOrderMapper.reportProfitGether(map);
		Double avg;
		for (SalesOrder salesOrder : list) {
			
			for (SalesOrderCommodity salesOrderCommodity : salesOrder.getSalesOrderCommodities()) {
				//int csId=allotOrderCommodity.getCommoditySpecificationId();
				for (Unit unit : salesOrderCommodity.getCommoditySpecification().getUnits()) {
						System.out.println("csid"+salesOrderCommodity.getCommoditySpecification().getId());
						avg=commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(salesOrderCommodity.getCommoditySpecification().getId());
						System.out.println("avg"+avg);
						if (avg!=null) {
							System.out.println("不为空");
							unit.setMiniPrice(avg);
						}else {
							System.out.println("为空"+unit.getMiniPrice()+">>>>>>>csid"+salesOrderCommodity.getCommoditySpecificationId());
						}
					
					
			}
			}
			}
		return list;
	}

	@Autowired
	SalesOrderMapper salesOrderMapper;
	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	@Override
	public List<SalesOrder> reportSalesOrderOpenDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportSalesOrderOpenDetail(map);
	}

	@Override
	public List<SalesOrder> reportExportSalesOrder(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportExportSalesOrder(map);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesOrderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(SalesOrder t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderMapper.insert(t);
	}

	@Override
	public int insertSelective(SalesOrder t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderMapper.insertSelective(t);
	}

	@Override
	public List<SalesOrder> reportSalesDayDetais(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportSalesDayDetais(map);
	}

	@Override
	public List<SalesOrder> reportOrderDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.reportOrderDetail(map);
	}

	@Override
	public SalesOrder selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesOrderMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(SalesOrder t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(SalesOrder t) throws Exception {
		// TODO Auto-generated method stub
		return salesOrderMapper.updateByPrimaryKey(t);
	}

	@Override
	public DataTables getSalesOrderMsg(DataTables dataTables, String identifier, String supctoName,String commodityName, Integer isSpecimen, Integer page,
			String  date,Integer type,String name,String phone,String orderer,Integer isAppOrder,String createTime,int state,
			String provinceCode, String cityCode, String areaCode,Integer classificationId) {


		String[] columns = { "identifier", "supctoId", "commoditysName", "payment", "createTime", "endValidityTime",
				"originator", "isSpecimen", "state", "id" };
		
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		
		params.put("iDisplayStart", Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength", Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(), columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式

		params.put("identifier", identifier);
		params.put("supctoName", supctoName);
		params.put("commodityName", commodityName);
		params.put("isSpecimen", isSpecimen);
		params.put("page", page);
		params.put("date", date);
		params.put("type", type);
		params.put("name", name);
		params.put("phone", phone);
		params.put("orderer", orderer);
		params.put("isAppOrder", isAppOrder);
		params.put("provinceCode", provinceCode);
		params.put("cityCode", cityCode);
		params.put("areaCode", areaCode);
		params.put("classificationId", classificationId);
		
		String[] arr=null;
		if (createTime!=""&&createTime!=null) {
			  arr=createTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("endTime", arr[1]);
		}
		
		params.put("state", state);
		List<Object> salesOrderList = new ArrayList<>();
		salesOrderList = salesOrderMapper.selectForSearch(params);
		// 循环列表，把一个订单表下的所卖的商品的名称以及数量整合在一起传到前台进行显示。
		for (int i = 0; i < salesOrderList.size(); i++) {
			List<SalesOrderCommodity> salesOrderCommodityList = ((SalesOrder) salesOrderList.get(i))
					.getSalesOrderCommodities();
			String commoditysName = ""; // 整合货品名称

			for (int h = 0; h < salesOrderCommodityList.size(); h++) {

				if (h < salesOrderCommodityList.size() - 1) {
					// 整合每个订单下的商品名称
					commoditysName += salesOrderCommodityList.get(h).getCommoditySpecification().getCommodity()
							.getName() + "("
							+ salesOrderCommodityList.get(h).getCommoditySpecification().getSpecificationName() + ")"
							+ "<br>";

				} else {
					commoditysName += salesOrderCommodityList.get(h).getCommoditySpecification().getCommodity()
							.getName() + "("
							+ salesOrderCommodityList.get(h).getCommoditySpecification().getSpecificationName() + ")";

				}

			}
			((SalesOrder) salesOrderList.get(i)).setCommoditysName(commoditysName);

		}
		// 不能用limit来进行分页，因为结果集有重复，只能在service中手动进行分页
		List<Object> resultTableList = new ArrayList<>();
		if ((salesOrderList.size() - Integer.parseInt(dataTables.getiDisplayStart())) >= Integer
				.parseInt(dataTables.getPageDisplayLength())) {

			for (int i = Integer.parseInt(dataTables.getiDisplayStart()); i < Integer.parseInt(
					dataTables.getiDisplayStart()) + Integer.parseInt(dataTables.getPageDisplayLength()); i++) {
				resultTableList.add(salesOrderList.get(i));
			}
		} else {

			for (int i = Integer.parseInt(dataTables.getiDisplayStart()); i < salesOrderList.size(); i++) {
				resultTableList.add(salesOrderList.get(i));
			}
		}

		dataTables.setiTotalDisplayRecords(salesOrderMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(salesOrderMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(resultTableList);// 返回的结果集
		return dataTables;
	}

	@Override
	public SalesOrder selectOrderDetailById(Integer id) {
		// TODO Auto-generated method stub
		SalesOrder salesOrder=salesOrderMapper.selectOrderDetailById(id);
		if(salesOrder!=null){
			SalesOrder order=new SalesOrder();
			//销售订单
			if(salesOrder.getParentId()==0){
				//查找出库单的创建时间
				Map<String,Object> map=new HashMap<>();
				map.put("parentId", salesOrder.getId());
				map.put("orderType", 3);
				order=salesOrderMapper.selectMsgByParentIdAndOrderType(map);
			}
			else{
				//查找出库单的创建时间
				Map<String,Object> map=new HashMap<>();
				map.put("parentId", salesOrder.getParentId());
				map.put("orderType", 3);
				order=salesOrderMapper.selectMsgByParentIdAndOrderType(map);
			}
			if(order!=null){
				salesOrder.setOrdersDeliveryTime(order.getCreateTime());
			}
		}
		return salesOrder;
	}

	@Override
	public String selectMaxIdentifier() {
		// TODO Auto-generated method stub
		return salesOrderMapper.selectMaxIdentifier();
	}

	@Override
	public List<SalesOrder> getSalesOrderByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return salesOrderMapper.getSalesOrderByIds(list);
	}

	@Override
	public boolean updateStateByIds(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.updateStateByIds(map);
	}

	@Override
	public boolean insertBatch(List<SalesOrder> list) {
		// TODO Auto-generated method stub
		return salesOrderMapper.insertBatch(list);
	}

	@Override
	public List<SalesOrder> selectBatchCommodityByWareIdAndOrderId(List<SalesOrderCommodity> list) {
		// TODO Auto-generated method stub
		return salesOrderMapper.selectBatchCommodityByWareIdAndOrderId(list);
	}

	@Override
	public boolean deleteBatchByPrimaryKey(List<SalesOrder> list) {
		// TODO Auto-generated method stub
		return salesOrderMapper.deleteBatchByPrimaryKey(list);
	}

	@Override
	public SalesOrder selectCommodityByWareIdAndOrderId(SalesOrderCommodity salesOrderCommodity) {
		// TODO Auto-generated method stub
		return salesOrderMapper.selectCommodityByWareIdAndOrderId(salesOrderCommodity);
	}

	@Override
	public List<SalesOrder> selectParentIdByPrimaryKey(List<Integer> list) {
		// TODO Auto-generated method stub
		return salesOrderMapper.selectParentIdByPrimaryKey(list);
	}

	@Override
	public List<SalesOrder> getSalesOrderByOrderTypeAndParentId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.getSalesOrderByOrderTypeAndParentId(map);
	}

	@Override
	public boolean updateStateAndIsShowByIds(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.updateStateAndIsShowByIds(map);
	}

	@Override
	public boolean updateStateByOrderTypeAndParentId(SalesOrder salesOrder) {
		// TODO Auto-generated method stub
		return salesOrderMapper.updateStateByOrderTypeAndParentId(salesOrder);
	}

	@Override
	public SalesOrder selectMsgByParentIdAndOrderType(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesOrderMapper.selectMsgByParentIdAndOrderType(map);
	}

	@Override
	public SalesOrder getSalesOpeningDetailById(Integer id) {
		SalesOrder salesOpeningDetail = salesOrderMapper.selectOrderDetailById(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", 4);// 折损单
		map.put("parentId", salesOpeningDetail.getParentId());
		SalesOrder foldLossDetail = salesOrderMapper.selectMsgByParentIdAndOrderType(map);
		map = new HashMap<String, Object>();
		map.put("orderType", 5);// 返货单
		map.put("parentId", salesOpeningDetail.getParentId());
		SalesOrder returnListDetail = salesOrderMapper.selectMsgByParentIdAndOrderType(map);

		for (SalesOrderCommodity socSod : salesOpeningDetail.getSalesOrderCommodities()) {
			//有折损单，把折损金额以及折损数量放入销售开单中
			if (foldLossDetail != null) {
				System.out.println("有折损");
				for (SalesOrderCommodity socFld : foldLossDetail.getSalesOrderCommodities()) {
					if (socSod.getCommoditySpecificationId().equals(socFld.getCommoditySpecificationId()) ) {
						socSod.setDamageMoney(socFld.getDamageMoney());
						socSod.setDamageNum(socFld.getDamageNum());
						socSod.setDeliverGoodsNum(socFld.getDeliverGoodsNum());
					}
				}
			}
			//有返货单，把返货数量放入销售开单中
			if (returnListDetail != null) {
				System.out.println("有返货");
				for (SalesOrderCommodity socRld : returnListDetail.getSalesOrderCommodities()) {
					if (socSod.getCommoditySpecificationId().equals(socRld.getCommoditySpecificationId()) ) {
						socSod.setReturnGoodsNum(socRld.getReturnGoodsNum());
					}
				}
			}

		}
		
		if(salesOpeningDetail!=null){
			SalesOrder order=new SalesOrder();
			//销售订单
			if(salesOpeningDetail.getParentId()==0){
				//查找出库单的创建时间
				map=new HashMap<>();
				map.put("parentId", salesOpeningDetail.getId());
				map.put("orderType", 3);
				order=salesOrderMapper.selectMsgByParentIdAndOrderType(map);
			}
			else{
				//查找出库单的创建时间
				map=new HashMap<>();
				map.put("parentId", salesOpeningDetail.getParentId());
				map.put("orderType", 3);
				order=salesOrderMapper.selectMsgByParentIdAndOrderType(map);
			}
			if(order!=null){
				salesOpeningDetail.setOrdersDeliveryTime(order.getCreateTime());
			}
		}

		return salesOpeningDetail;
	}

	@Override
	public List<SalesOrder> selectIdByIdentifierAndState(List<String> identifier) {
		// TODO Auto-generated method stub
		return salesOrderMapper.selectIdByIdentifierAndState(identifier);
	}

	@Override
	public List<SalesOrder> selectIdByIdentifierAndIsNoShow(List<String> identifier) {
		// TODO Auto-generated method stub
		return salesOrderMapper.selectIdByIdentifierAndIsNoShow(identifier);
	}

	@Override
	public List<SalesOrder> getAllSalesOrderCanReturn() {
		// TODO Auto-generated method stub
		return salesOrderMapper.getAllSalesOrderCanReturn();
	}

	
@Override
public Integer updateByVerification(Integer id) {
	// TODO Auto-generated method stub
	return salesOrderMapper.updateByVerification(id);
}

@Override
public boolean updateByMisOrderIdSelective(SalesOrder salesOrder) {
	// TODO Auto-generated method stub
	return salesOrderMapper.updateByMisOrderIdSelective(salesOrder);
}

@Override
public List<SalesOrder> selectAppRturnGoodsSalesOrderMsg() {
	// TODO Auto-generated method stub
	return salesOrderMapper.selectAppRturnGoodsSalesOrderMsg();
}

@Override
public SalesOrder getReturnNum(Integer parentId) {
	// TODO Auto-generated method stub
	return salesOrderMapper.getReturnNum(parentId);
}

@Override
public SalesOrder getDamageNum(Integer parentId) {
	// TODO Auto-generated method stub
	return salesOrderMapper.getDamageNum(parentId);

}

@Override
public String selectMaxIdentifierToOtherDeliveOrder() {
	// TODO Auto-generated method stub
	return salesOrderMapper.selectMaxIdentifierToOtherDeliveOrder();
}

@Override
public List<SalesOrder> reportOtherDeliverOrder(Map<String, Object> map) {
	// TODO Auto-generated method stub
	return salesOrderMapper.reportOtherDeliverOrder(map);
}

@Override
public List<SalesOrder> reportExportSalesOrderDetail(Map<String, Object> map) {
	// TODO Auto-generated method stub
	return salesOrderMapper.reportExportSalesOrderDetail(map);
}

@Override
public List<SalesOrder> reportReturnGoodsMsg(Map<String, Object> map) {
	// TODO Auto-generated method stub
	return salesOrderMapper.reportReturnGoodsMsg(map);
}

@Override
public List<SalesOrder> reportSalesOrderReturnDetail(Map<String, Object> map) {
	// TODO Auto-generated method stub
	return salesOrderMapper.reportSalesOrderReturnDetail(map);
}


}
