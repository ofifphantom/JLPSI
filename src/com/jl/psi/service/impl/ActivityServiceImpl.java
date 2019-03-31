package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.ActivityMapper;
import com.jl.psi.mapper.CommodityMapper;
import com.jl.psi.mapper.CommoditySpecificationMapper;
import com.jl.psi.mapper.InventoryMapper;
import com.jl.psi.mapper.ProcureCommodityMapper;
import com.jl.psi.mapper.ProcureTableMapper;
import com.jl.psi.mapper.SalesOrderCommodityMapper;
import com.jl.psi.mapper.SalesOrderMapper;
import com.jl.psi.mapper.SalesPlanOrderCommodityMapper;
import com.jl.psi.mapper.SalesPlanOrderMapper;
import com.jl.psi.model.Activity;
import com.jl.psi.model.Commodity;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.model.SalesPlanOrder;
import com.jl.psi.model.SalesPlanOrderCommodity;
import com.jl.psi.service.ActivityService;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;
@Service
public class ActivityServiceImpl implements ActivityService {

	@Autowired
	private ActivityMapper activityMapper;
	@Autowired
	private SalesPlanOrderMapper planOrderMapper;
	@Autowired
	private SalesPlanOrderCommodityMapper planOrderCommodityMapper;
	@Autowired
	private  SalesOrderMapper salesOrderMapper;
	@Autowired
	private  SalesOrderCommodityMapper salesOrderCommodityMapper;
	
	@Autowired
	private CommoditySpecificationMapper	commoditySpecificationMapper;
	@Autowired
	private CommodityMapper	commodityMapper;
	@Autowired
	private ProcureTableMapper  procureTableMapper;
	@Autowired
	private ProcureCommodityMapper  procureCommodityMapper;
	@Autowired
	private InventoryMapper	inventoryMapper;
	@Override
	public void createActivity(Integer activityId, Integer activityType, Date generatedTime,SalesPlanOrder planOrder) {
	
		
		try {
			Activity activity=null;
			if(activityId!=0) {
				activity=activityMapper.selectByActivityId(activityId);
			}
			  
			if(activity==null) {
				  activity=new Activity();
				  activity.setActivityId(activityId);
				  activity.setIsGenerated(0);
				  activity.setActivityType(activityType);
				  activity.setGeneratedTime(generatedTime);
					//保存活动信息
				  activityMapper.insertSelective(activity);
			}
		
			//预售活动
			if(activityId>0) {
				//保存销售计划订单     
				 createSalesPlanOrder(planOrder, activity.getId());
			//普通活动
			}else {
				List<SalesPlanOrderCommodity> planOrderCommodities=planOrder.getSalesPlanOrderCommodities();
				List<ProcureCommodity> pcs=new ArrayList<ProcureCommodity>();
				for(int i=0;i<planOrderCommodities.size();i++) {
					int csId=planOrderCommodities.get(i).getCommoditySpecificationId();
					CommoditySpecification  cs=commoditySpecificationMapper.selectByPrimaryKey(csId);
					Commodity cd=commodityMapper.selectByPrimaryKey(cs.getCommodityId());
					
					//允许0库存出库
					if(cd.getZeroStock()==1) {
						ProcureCommodity pc=new ProcureCommodity();
						pc.setTotalPrice(planOrderCommodities.get(i).getMoney());
						pc.setOrderNum(planOrderCommodities.get(i).getNumber());
						pc.setBusinessUnitPrice(planOrderCommodities.get(i).getUnitPrice());
						pc.setCommodityId(csId);
						pcs.add(pc);
					}
 				}
				//包含0库存出库
				if(pcs.size()>0) {
					//生成销售计划订单     
					createSalesPlanOrder(planOrder, activity.getId());
//					//生成采购计划单
					ProcureTable pt=new ProcureTable();
					pt.setActivityId(activity.getId());
					pt.setPlanOrOrder(1);
					pt.setIsAppOrder(2);
					Date date = new Date();
					pt.setGenerateDate(date);
					pt.setIsDelete(0);
					String maxIdentifier = procureTableMapper.selectMaxIdentifier();
					String identifier = SundryCodeUtil.createInvoicesIdentifier("PO", maxIdentifier);
					pt.setIdentifier(identifier);
					procureTableMapper.insertSelective(pt);
 					for(int i=0;i<pcs.size();i++) {
			 
						pcs.get(i).setProcureTableId(pt.getId());
						pcs.get(i).setLotNumber("0000");
					}
					//生成采购计划单子项
					procureCommodityMapper.insertBatch(pcs);
				//没有0库存出库
				}else {
					createSalesOrder(planOrder, activity.getId());
					
				}
				
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public void createSalesOrder(ProcureTable procureTable) throws Exception {
		int  activityId=procureTable.getActivityId();
		List<SalesPlanOrder> 	 spos=	planOrderMapper.salesPlanOrderByActivityId(activityId);
		for (SalesPlanOrder salesPlanOrder : spos) {
			//销售计划单设置 已生成
			salesPlanOrder.setState(2);
			planOrderMapper.updateByPrimaryKeySelective(salesPlanOrder);
			//生成销售订单
			SalesOrder salesOrder = new SalesOrder();
			salesOrder.setParentId(0);
			// 生成编号
			String maxIdentifier = salesOrderMapper.selectMaxIdentifier();
			String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
			salesOrder.setIdentifier(identifier);
			salesOrder.setOrderType(1);
			salesOrder.setCreateTime(new Date());
 			salesOrder.setDeliverGoodsPlace(salesPlanOrder.getAppConsigneeAddress());
			salesOrder.setConsignee(salesPlanOrder.getAppConsigneeName());
			salesOrder.setPhone(salesPlanOrder.getAppConsigneePhone());
			salesOrder.setState(32);
			salesOrder.setIsSpecimen(1);
			salesOrder.setSalesPlanOrderId(salesPlanOrder.getId());
			salesOrder.setIsShow(2);
			salesOrder.setActivityId(activityId);
			salesOrder.setMissOrderId(salesPlanOrder.getMissOrderId());
			salesOrder.setIsAppOrder(2);
			salesOrder.setAdvanceScale(0.0);
			salesOrderMapper.insertSelective(salesOrder);
			List<SalesOrderCommodity> socs=new ArrayList<SalesOrderCommodity>();
			List<SalesPlanOrderCommodity> salesPlanOrderCommodities=new ArrayList<SalesPlanOrderCommodity>();
			salesPlanOrderCommodities=planOrderCommodityMapper.selectMsgBySalesPlanOrderId(salesPlanOrder.getId());
			for (int i = 0; i < salesPlanOrderCommodities.size(); i++) {
				SalesPlanOrderCommodity spc = salesPlanOrderCommodities.get(i);
				SalesOrderCommodity soc = new SalesOrderCommodity();
				soc.setSalesOrderId(salesOrder.getId());
				soc.setCommoditySpecificationId(spc.getCommoditySpecificationId());
 			 
				soc.setDeliverGoodsMoney(spc.getMoney());
				soc.setDeliverGoodsNum(spc.getNumber());
				soc.setUnitPrice(spc.getUnitPrice());
				soc.setIsSpecialOffer(1);
				soc.setWarehouseId(inventoryMapper.getWarehouseIdByCommoditySpecificationId(spc.getCommoditySpecificationId()));
				socs.add(soc);
				
			}
			salesOrderCommodityMapper.insertBeatch(socs);
			
 
			
			//生成出库单
			maxIdentifier = salesOrderMapper.selectMaxIdentifier();
			 identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
			SalesOrder outboundOrder = new SalesOrder();
			  outboundOrder.setIdentifier(identifier);// 生成编号
			outboundOrder.setOrderType(7);// 单据类型为出库单(APP出库单)
			outboundOrder.setCreateTime(new Date());
			outboundOrder.setDeliverGoodsPlace(salesOrder.getDeliverGoodsPlace());
			outboundOrder.setDeliverGoodsPlace(salesOrder.getDeliverGoodsPlace());
 			outboundOrder.setConsignee(salesOrder.getConsignee());
			outboundOrder.setPhone(salesOrder.getPhone());
			outboundOrder.setState(32);//状态改为备货中
			outboundOrder.setIsSpecimen(1);
			outboundOrder.setSalesPlanOrderId(salesPlanOrder.getId());
			outboundOrder.setIsShow(2);
			outboundOrder.setActivityId(salesOrder.getActivityId());
			outboundOrder.setMissOrderId(salesOrder.getMissOrderId());
			outboundOrder.setIsAppOrder(2);
			outboundOrder.setAdvanceScale(0.0);
			outboundOrder.setParentId(salesOrder.getId());
 			  
			salesOrderMapper.insertSelective(outboundOrder);
 			  for (SalesOrderCommodity salesOrderCommodity : socs) {
				  salesOrderCommodity.setSalesOrderId(outboundOrder.getId());
			}
			  salesOrderCommodityMapper.insertBeatch(socs);
 		}
	}
	
	@Override
	public void createSalesOrder(SalesPlanOrder planOrder, Integer activityId) throws Exception {
			//生成销售订单
			SalesOrder salesOrder = new SalesOrder();
			salesOrder.setParentId(0);
			// 生成编号
			String maxIdentifier = salesOrderMapper.selectMaxIdentifier();
			String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
			salesOrder.setIdentifier(identifier);
			salesOrder.setOrderType(1);
			salesOrder.setCreateTime(new Date());
 			salesOrder.setDeliverGoodsPlace(planOrder.getAppConsigneeAddress());
			salesOrder.setConsignee(planOrder.getAppConsigneeName());
			salesOrder.setPhone(planOrder.getAppConsigneePhone());
			salesOrder.setState(32);
			salesOrder.setIsSpecimen(1);
			salesOrder.setIsShow(2);
			salesOrder.setActivityId(activityId);
			salesOrder.setMissOrderId(planOrder.getMissOrderId());
			salesOrder.setIsAppOrder(2);
			salesOrder.setAdvanceScale(0.0);
			salesOrderMapper.insertSelective(salesOrder);
			List<SalesOrderCommodity> socs=new ArrayList<SalesOrderCommodity>();
			List<SalesPlanOrderCommodity> salesPlanOrderCommodities=planOrder.getSalesPlanOrderCommodities();
			for (int i = 0; i < salesPlanOrderCommodities.size(); i++) {
				SalesPlanOrderCommodity spc = salesPlanOrderCommodities.get(i);
				SalesOrderCommodity soc = new SalesOrderCommodity();
				soc.setSalesOrderId(salesOrder.getId());
				soc.setCommoditySpecificationId(spc.getCommoditySpecificationId());
 			 
				soc.setDeliverGoodsMoney(spc.getMoney());
				soc.setDeliverGoodsNum(spc.getNumber());
				soc.setUnitPrice(spc.getUnitPrice());
				soc.setIsSpecialOffer(1);
				soc.setWarehouseId(inventoryMapper.getWarehouseIdByCommoditySpecificationId(spc.getCommoditySpecificationId()));
				socs.add(soc);
				
			}
			salesOrderCommodityMapper.insertBeatch(socs);
			
 
			
			//生成出库单
			maxIdentifier = salesOrderMapper.selectMaxIdentifier();
			 identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
			SalesOrder outboundOrder = new SalesOrder();
			  outboundOrder.setIdentifier(identifier);// 生成编号
			outboundOrder.setOrderType(7);// 单据类型为App出库单
			outboundOrder.setCreateTime(new Date());
			outboundOrder.setDeliverGoodsPlace(salesOrder.getDeliverGoodsPlace());
			outboundOrder.setDeliverGoodsPlace(salesOrder.getDeliverGoodsPlace());
 			outboundOrder.setConsignee(salesOrder.getConsignee());
			outboundOrder.setPhone(salesOrder.getPhone());
			outboundOrder.setState(32);//状态改为备货中
			outboundOrder.setIsSpecimen(1);
 			outboundOrder.setIsShow(2);
			outboundOrder.setActivityId(salesOrder.getActivityId());
			outboundOrder.setMissOrderId(salesOrder.getMissOrderId());
			outboundOrder.setIsAppOrder(2);
			outboundOrder.setAdvanceScale(0.0);
			outboundOrder.setParentId(salesOrder.getId());
 			  
			salesOrderMapper.insertSelective(outboundOrder);
 			  for (SalesOrderCommodity salesOrderCommodity : socs) {
				  salesOrderCommodity.setSalesOrderId(outboundOrder.getId());
			}
			  salesOrderCommodityMapper.insertBeatch(socs);
 		
	}

	@Override
	public void createProcureTable() {
		// TODO Auto-generated method stub

	}
	/**
	 * 保存销售计划单
	 * @param planOrder
	 * @param activityId
	 * @return
	 * @throws Exception
	 */
	private SalesPlanOrder createSalesPlanOrder(SalesPlanOrder planOrder,Integer activityId) throws Exception {
		String maxIdentifier = planOrderMapper.selectMaxIdentifier();
		String identifier = SundryCodeUtil.createInvoicesIdentifier("SP", maxIdentifier);
		planOrder.setIdentifier(identifier);
		planOrder.setActivityId(activityId);
		planOrder.setState(1);
		planOrderMapper.insertSelective(planOrder);
		
		Integer salesPlanOrderId=planOrder.getId();
		List<SalesPlanOrderCommodity> planOrderCommodities=planOrder.getSalesPlanOrderCommodities();
		for(int i=0;i<planOrderCommodities.size();i++) {
			planOrderCommodities.get(i).setSalesPlanOrderId(salesPlanOrderId);
		}
		//保存销售计划订单子项
		planOrderCommodityMapper.insertBeatch(planOrderCommodities);
		return planOrder;
	}
	
	@Override
	public void taskCreateProcureTable() throws Exception {
		List<Activity> activitys=	activityMapper.selectAll();
		Long nowTime=new Date().getTime();
		for (Activity activity : activitys) {
			if(activity.getIsGenerated()==0&&nowTime>=activity.getGeneratedTime().getTime()) {
				//设置活动已生成采购计划单
				activityMapper.updateGenerated(activity.getId());
				//当前时间大于生成时间，开始生成采购计划单
				List<SalesPlanOrder> 	 spos=	planOrderMapper.salesPlanOrderByActivityId(activity.getId());
				 
				
				ProcureTable pt=new ProcureTable();
				pt.setActivityId(activity.getId());
				pt.setPlanOrOrder(1);
				pt.setIsAppOrder(2);
				Date date = new Date();
				pt.setGenerateDate(date);
				pt.setIsDelete(0);
				String maxIdentifier = procureTableMapper.selectMaxIdentifier();
				String identifier = SundryCodeUtil.createInvoicesIdentifier("PO", maxIdentifier);
				pt.setIdentifier(identifier);
				procureTableMapper.insertSelective(pt);
				List<ProcureCommodity> pcs=new ArrayList<ProcureCommodity>();
				 List<SalesPlanOrderCommodity> spoc=		planOrderCommodityMapper .selectCsBuActivityId(activity.getId());
				for(int i=0;i<spoc.size();i++) {
					ProcureCommodity pc=new ProcureCommodity();
					pc.setTotalPrice(spoc.get(i).getMoney());
					pc.setOrderNum(spoc.get(i).getNumber());
					pc.setBusinessUnitPrice(spoc.get(i).getMoney()/spoc.get(i).getNumber());
					pc.setCommodityId(spoc.get(i).getCommoditySpecificationId());
					pc.setProcureTableId(pt.getId());
					pc.setLotNumber("0000");
					pcs.add(pc);
					}
				//生成采购计划单子项
				procureCommodityMapper.insertBatch(pcs);
				
			}
		}
		
	}

}
