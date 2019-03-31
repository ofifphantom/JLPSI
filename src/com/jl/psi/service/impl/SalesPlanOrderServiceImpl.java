package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.SalesPlanOrderMapper;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.model.SalesPlanOrder;
import com.jl.psi.model.SalesPlanOrderCommodity;
import com.jl.psi.service.SalesPlanOrderService;
import com.jl.psi.utils.DataTables;
/**
 * 
 * @author 景雅倩
 * @date  2018年6月04日  上午10:21:50
 * @Description  销售计划单ServiceImpl
 */
@Service
public class SalesPlanOrderServiceImpl implements SalesPlanOrderService {

	@Override
	public List<SalesPlanOrder> reportSalesPlanOrderDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.reportSalesPlanOrderDetail(map);
	}

	@Autowired
	SalesPlanOrderMapper salesPlanOrderMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(SalesPlanOrder t) throws Exception {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.insert(t);
	}

	@Override
	public int insertSelective(SalesPlanOrder t) throws Exception {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.insertSelective(t);
	}

	@Override
	public SalesPlanOrder selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(SalesPlanOrder t) throws Exception {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(SalesPlanOrder t) throws Exception {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.updateByPrimaryKey(t);
	}

	@Override
	public DataTables getSalesPlanOrderMsg(DataTables dataTables, String identifier, String commodityName,
			String originator,String createTime,Integer state) {
		String[] columns = { "identifier", "supctoId", "commoditysName", "commoditysBrandName", "originator", "createTime", "id" };
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		params.put("iDisplayStart", Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength", Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(), columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
	
		params.put("identifier", identifier);
		params.put("commodityName", commodityName);
		params.put("originator", originator);
		params.put("state", state);
		String[] arr=null;
		if (createTime!=""&&createTime!=null) {
			  arr=createTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("endTime", arr[1]);
		}
		List<Object> salesPlanOrderList = new ArrayList<>();
		salesPlanOrderList = salesPlanOrderMapper.selectForSearch(params);
		// 循环列表，把一个订单表下的所卖的商品的名称以及品牌整合在一起传到前台进行显示。
		for (int i = 0; i < salesPlanOrderList.size(); i++) {
			List<SalesPlanOrderCommodity> salesPlanOrderCommodityList = ((SalesPlanOrder) salesPlanOrderList.get(i))
					.getSalesPlanOrderCommodities();
			String commoditysName = ""; // 整合货品名称
			String commoditysBrandName ="";// 整合货品品牌

			for (int h = 0; h < salesPlanOrderCommodityList.size(); h++) {

				if (h < salesPlanOrderCommodityList.size() - 1) {
					// 整合每个订单下的商品名称
					commoditysName += salesPlanOrderCommodityList.get(h).getCommoditySpecification().getCommodity()
							.getName() + "("
							+ salesPlanOrderCommodityList.get(h).getCommoditySpecification().getSpecificationName() + ")"
							+ "<br>";
					// 整合每个订单下的商品品牌
					commoditysBrandName += salesPlanOrderCommodityList.get(h).getCommoditySpecification().getCommodity()
							.getBrand() + "<br>";

				} else {
					commoditysName += salesPlanOrderCommodityList.get(h).getCommoditySpecification().getCommodity()
							.getName() + "("
							+ salesPlanOrderCommodityList.get(h).getCommoditySpecification().getSpecificationName() + ")";
					commoditysBrandName += salesPlanOrderCommodityList.get(h).getCommoditySpecification().getCommodity()
							.getBrand() + "<br>";
				}

			}
			((SalesPlanOrder) salesPlanOrderList.get(i)).setCommoditysName(commoditysName);
			((SalesPlanOrder) salesPlanOrderList.get(i)).setCommoditysBrandName(commoditysBrandName);

		}
		// 不能用limit来进行分页，因为结果集有重复，只能在service中手动进行分页
		List<Object> resultTableList = new ArrayList<>();
		if ((salesPlanOrderList.size() - Integer.parseInt(dataTables.getiDisplayStart())) >= Integer
				.parseInt(dataTables.getPageDisplayLength())) {

			for (int i = Integer.parseInt(dataTables.getiDisplayStart()); i < Integer.parseInt(
					dataTables.getiDisplayStart()) + Integer.parseInt(dataTables.getPageDisplayLength()); i++) {
				resultTableList.add(salesPlanOrderList.get(i));
			}
		} else {

			for (int i = Integer.parseInt(dataTables.getiDisplayStart()); i < salesPlanOrderList.size(); i++) {
				resultTableList.add(salesPlanOrderList.get(i));
			}
		}

		dataTables.setiTotalDisplayRecords(salesPlanOrderMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(salesPlanOrderMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(resultTableList);// 返回的结果集
		return dataTables;
	}

	@Override
	public String selectMaxIdentifier() {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.selectMaxIdentifier();
	}
	
	@Override
	public Integer selectExpirationCount() {
 		return salesPlanOrderMapper.selectExpirationCount();
	}

	@Override
	public List<SalesPlanOrder> selectSalesPlanOrderToFailure(){
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.selectSalesPlanOrderToFailure();
	}

	@Override
	public boolean updateByMisOrderIdSelective(SalesPlanOrder salesPlanOrder) {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.updateByMisOrderIdSelective(salesPlanOrder);
	}

	@Override
	public SalesPlanOrder getSalesPlanOrderDetail(Integer id) {
		// TODO Auto-generated method stub
		return salesPlanOrderMapper.getSalesPlanOrderDetail(id);
	}

}
