package com.jl.psi.utils;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.google.gson.annotations.Until;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.Inventory;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.SalesPlanOrder;
import com.jl.psi.model.SalesPlanOrderCommodity;
import com.jl.psi.model.Supcto;
import com.jl.psi.service.ActivityService;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.InventoryService;
import com.jl.psi.service.ProcureCommodityService;
import com.jl.psi.service.ProcureTableService;
import com.jl.psi.service.SalesPlanOrderCommodityService;
import com.jl.psi.service.SalesPlanOrderService;
import com.jl.psi.service.SupctoService;

/**
 * 类名称：TimerTask 类描述：定时器任务
 * 
 * @author 景雅倩
 * @date 2017-12-05 下午3:08:23
 */
@Component
public class TimerTask {

	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	@Autowired
	ProcureCommodityService procureCommodityService;
	@Autowired
	ProcureTableService procureTableService;
	@Autowired
	InventoryService inventoryService;
	@Autowired
	SalesPlanOrderService salesPlanOrderService;
	@Autowired
	SalesPlanOrderCommodityService salesPlanOrderCommodityService;
	@Autowired
	private ActivityService activityService;
	@Autowired
	private SupctoService supctoService;
	/**
	 * 每天0点执行任务  "0 0 0 * * ?"
	 * 
	 * @throws Exception
	 */
	@Scheduled(cron = "0 0 0 * * ?")
	public void myTask() throws Exception {
		
	  //查询自动生成采购计划单
	  createProcurePlanOrder();
	  //销售计划失败处理  (到达送货时间还未生成销售订单的销售计划单 解除锁定库存)
	  updateSalePlanOrder();
	  activityService.taskCreateProcureTable();
	}

	
	
	/** 私有方法
	 * @throws Exception */
	//查询自动生成采购计划单
	private void createProcurePlanOrder() throws Exception {
		// 查询库存低于预警数量的商品信息
		List<CommoditySpecification> lowStocksCommoditys = commoditySpecificationService.selectLowStocksCommodity();
		List<CommoditySpecification> shouldCreateProcurePlanCommodity;
		ProcureTable procureTable;
		List<ProcureCommodity> procureCommodities;
		ProcureCommodity procureCommodity;
		Inventory inventory;
		// 根据供应商的不同，生成相应的采购计划单
		if (lowStocksCommoditys != null && lowStocksCommoditys.size() > 0) {
			// 如果查出的列表的数量大于0
			while (lowStocksCommoditys.size() > 0) {
				shouldCreateProcurePlanCommodity = new ArrayList<>();
				// 保存第一个的供应商id
				int supctoId = lowStocksCommoditys.get(0).getCommodity().getSupctoId();
				for (int i = 0; i < lowStocksCommoditys.size(); i++) {
					// 如果供应商相等，则添加到列表里，同时删除列表里的该商品
					if (lowStocksCommoditys.get(i).getCommodity().getSupctoId() == supctoId) {
						shouldCreateProcurePlanCommodity.add(lowStocksCommoditys.get(i));
						lowStocksCommoditys.remove(i);
						i--;
					} else {
						break;
					}
				}
				
				if(shouldCreateProcurePlanCommodity.size()>0){
					// 生成采购计划单
					procureTable = new ProcureTable();
					// 获取最大的编号
					String maxIdentifier = procureTableService.selectMaxIdentifier();
					//生成编号
					String identifier = SundryCodeUtil.createInvoicesIdentifier("PO", maxIdentifier);
					procureTable.setIdentifier(identifier);
					Supcto supcto=supctoService.selectByPrimaryKey(supctoId);
					//单据创建时间
					Date date=new Date();
					procureTable.setGenerateDate(date);
					procureTable.setIsDelete(0);
					procureTable.setBranch("总部");
					procureTable.setPlanOrOrder(1);
					procureTable.setSupctoId(supctoId+"");
					procureTable.setPayType(supcto==null?null:supcto.getSettlementTypeId());
					procureTable.setPhone(supcto==null?null:supcto.getCommonPhone());
					procureTable.setFax(supcto==null?null:supcto.getFax());
					
					if(procureTableService.insertSelective(procureTable)>0){
						//生成采购订单里的商品
						procureCommodities=new ArrayList<>();
						for(CommoditySpecification cs:shouldCreateProcurePlanCommodity){
							procureCommodity=new ProcureCommodity();
							procureCommodity.setCommodityId(cs.getId());
							procureCommodity.setProcureTableId(procureTable.getId());
							procureCommodity.setTaxRate(cs.getCommodity().getTaxes());
							Double originalUnitPrice=procureTableService.getOriginalUnitPrice(cs.getId());
							//有采购价格
							if(originalUnitPrice!=null&&originalUnitPrice>0){
								procureCommodity.setOriginalUnitPrice(originalUnitPrice);
							}	
							else{
								procureCommodity.setOriginalUnitPrice(0.0);
							}
							procureCommodity.setBusinessUnitPrice(0.0);
							procureCommodity.setTotalPrice(0.0);
							procureCommodity.setOrderNum(0);
							procureCommodity.setTotalTaxPrice(0.0);
							procureCommodities.add(procureCommodity);
							
							//修改库存信息中的字段  是否生成了采购计划单，如果生成了，则不再生成
							inventory=new Inventory();
							inventory.setSpecificationId(cs.getId());
							inventory.setIsCreateProcurePlan(1);
							inventoryService.updateBySpecificationId(inventory);
						}
						procureCommodityService.insertBatch(procureCommodities);
					}
				}
				
				
			}

		}
	}
	
	/**
	 * 销售计划失败处理方法
	 * @throws Exception 
	 */
	private void updateSalePlanOrder() throws Exception {
		List<SalesPlanOrder> salesPlanOrders = salesPlanOrderService.selectSalesPlanOrderToFailure();
		if(salesPlanOrders.size()>0) {//有需要失效的销售计划单
			int id;
			List<SalesPlanOrderCommodity> salesPlanOrderCommodities;
			Inventory inventory;
			SalesPlanOrder salesPlanOrder;
			for (int i = 0; i < salesPlanOrders.size(); i++) {
				id = salesPlanOrders.get(i).getId();//获取销售计划单的id
				salesPlanOrderCommodities=salesPlanOrderCommodityService.selectMsgBySalesPlanOrderId(id);//获取销售计划单的商品
				// 遍历商品 并根据规格id修改商品的占用数量（解除锁定库存）
				for (SalesPlanOrderCommodity spoc : salesPlanOrderCommodities) {
					inventory = new Inventory();
					inventory.setSpecificationId(spoc.getCommoditySpecificationId());
					inventory.setOccupiedInventory(spoc.getNumber());
					inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inventory);
				}
				//修改销售计划单的状态为销售计划失败
				salesPlanOrder = new SalesPlanOrder();
				salesPlanOrder.setState(3);
				salesPlanOrder.setId(id);
				salesPlanOrderService.updateByPrimaryKeySelective(salesPlanOrder);
			}
		}
		
	}

}