package com.jl.psi.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.FormHeadAndFooter;
import com.jl.psi.model.Inventory;
import com.jl.psi.model.Log;
import com.jl.psi.model.Person;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.model.SalesOrderReviewer;
import com.jl.psi.model.SalesPlanOrder;
import com.jl.psi.model.SalesPlanOrderCommodity;
import com.jl.psi.model.SettlementType;
import com.jl.psi.model.Supcto;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.InventoryService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.MessageService;
import com.jl.psi.service.PersonService;
import com.jl.psi.service.SalesOrderCommodityService;
import com.jl.psi.service.SalesOrderReviewerService;
import com.jl.psi.service.SalesOrderService;
import com.jl.psi.service.SalesPlanOrderCommodityService;
import com.jl.psi.service.SalesPlanOrderService;
import com.jl.psi.service.SettlementTypeService;
import com.jl.psi.service.SupctoService;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 
 * @author 景雅倩
 * @date 2018年5月23日 下午1:41:35
 * @Description 销售订单Controller
 *
 */
@Controller
@RequestMapping("/sales/salesOrder/")
public class SalesOrderController extends BaseController {

	// 当前类操作的类型(往log日志表中存储)
	private int operateType = Constants.TYPE_LOG_SALES;

	// 声明Log类
	Log log;

	@Autowired
	SalesOrderService salesOrderService;
	@Autowired
	SalesOrderCommodityService salesOrderCommodityService;
	@Autowired
	SalesOrderReviewerService salesOrderReviewerService;
	@Autowired
	LogService logService;
	@Autowired
	InventoryService inventoryService;
	@Autowired
	MessageService messageService;
	
	@Autowired
	SalesPlanOrderService salesPlanOrderService;
	@Autowired
	SalesPlanOrderCommodityService salesPlanOrderCommodityService;
	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	
	@Autowired
	PersonService personService;
	@Autowired
	private SettlementTypeService	settlementTypeService;
	@Autowired
	private SupctoService	supctoService;
	/**
	 * 进入页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request, int page) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "";

		switch (page) {
		// 销售订单
		case 1:
			pageName = "junlin/jsp/sales/salesOrder";
			break;

		// 销售订单审核
		case 2:
			pageName = "junlin/jsp/sales/leaderShipAudit/orderAudit";
			break;

		// 销售订单作废审核
		case 3:
			pageName = "junlin/jsp/sales/leaderShipAudit/orderRevokeAudit";
			break;

		// 折损单审核
		case 4:
			pageName = "junlin/jsp/sales/leaderShipAudit/foldLossAudit";
			break;

		// 预付款
		case 6:
			pageName = "junlin/jsp/sales/finance/advanceCharge";
			break;

		// 引用出库单
		case 7:
			pageName = "junlin/jsp/sales/finance/citingTreasuryBill";
			break;

		// 销售开单
		case 8:
			pageName = "junlin/jsp/sales/finance/salesOpening";
			break;

		// 折损单
		case 9:
			pageName = "junlin/jsp/sales/finance/foldLoss";
			break;

		// 销售开单审核
		case 10:
			pageName = "junlin/jsp/sales/finance/audit/salesOpeningAudit";
			break;

		// 申请修改开单审核
		case 11:
			pageName = "junlin/jsp/sales/finance/audit/revisionSalesOpeningAudit";
			break;
		// 填写退货单页面
		case 15:
			pageName = "junlin/jsp/sales/salesReturn";
			break;
		// 退货单审核页面
		case 16:
			pageName = "junlin/jsp/sales/leaderShipAudit/salesReturnAudit";
			break;
		// 仓库销售退货入库
		case 17:
			pageName = "junlin/jsp/warehouse/warehousing/salesReturnIn";
			break;
		// 财务查看退货
		case 18:
			pageName = "junlin/jsp/sales/finance/salesReturnSee";
			break;
		//app发货
		case 19:
			pageName ="junlin/jsp/sales/appOrderOutbound";
			break;
		//备货单
		case 20:
			pageName ="junlin/jsp/warehouse/outOfTheTreasury/pickinglistOrder";
			break;
		//备货单
		case 21:
			pageName ="junlin/jsp/sales/appSalesReturn";
			break;
			
//-------------其他发货单-----------------		
		//其他发货单
		case 22:
			pageName ="junlin/jsp/sales/otherDeliveOrder";
			break;
		//其他发货单领导审批
		case 23:
			pageName ="junlin/jsp/sales/leaderShipAudit/otherDeliveOrderAudit";
			break;
		//其他发货单财务审批
		case 24:
			pageName ="junlin/jsp/sales/finance/audit/otherDeliveOrderAudit";
			break;
		//其他发货单财务审批
		case 25:
			pageName ="junlin/jsp/warehouse/outOfTheTreasury/documentReference/otherDeliveOrderReference";
			break;
		//其他发货单出库单
		case 26:
			pageName ="junlin/jsp/warehouse/outOfTheTreasury/otherOutboundOrder";
			break;
		//其他发货单开单
		case 27:
			pageName ="junlin/jsp/sales/finance/otherOpening";
			break;
		//其他发货单作废领导审批
		case 28:
			pageName ="junlin/jsp/sales/leaderShipAudit/otherDeliveOrderRevokeAudit";
			break;
		//其他发货单作废仓库审批
		case 29:
			pageName ="junlin/jsp/warehouse/outOfTheTreasury/audit/otherDeliveOrderRevokeAudit";
			break;
		default:
			break;
		}

		return pageName;

	}

	/**
	 * 页面table数据的显示
	 * 
	 * @param request
	 * @param identifier
	 *            单据编号
	 * @param supctoName
	 *            客户名称
	 * @param commodityName
	 *            商品名称
	 * @param isSpecimen
	 *            是否是样品（1：否，2：是）若没有请传0
	 * @param page
	 *            (1:销售订单,2:销售订单审核,3:销售订单作废审核,4:折损单审核,5:销售订单引用生成出库单,6:预付款,
	 *            7:引用出库单,8:销售开单,9:折损单,10:销售开单审核,11:申请修改开单审核,12:仓库作废审核,13:出库单确认出库,14:返货单,
	 *            15:填写退货单页面,16:退货单审核页面,17:仓库退货入库页面,18:财务查看退货单页面，19：app订单发货页面，20：app订单退货页面,
	 *            21:其他发货单,22:其他发货单领导审批,23:其他发货单财务审批,24:其他发货单引用,25:其他发货单出库单,26:其他发货单开单,
	 *            27:其他发货单作废领导审批,28:其他发货单作废仓库审批)
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getSalesOrderMsg")
	public DataTables getSalesOrderMsg(HttpServletRequest request, String identifier, String supctoName,
			String commodityName, Integer isSpecimen, Integer page,String  date,Integer type,String name,String phone,String orderer,Integer isAppOrder,
			String createTime,int state,
			String provinceCode, String cityCode, String areaCode,Integer classificationId) {
		DataTables dataTables = DataTables.createDataTables(request);
		return salesOrderService.getSalesOrderMsg(dataTables, identifier, supctoName, commodityName, isSpecimen, page,date,type,name,phone,orderer,isAppOrder,createTime,state, provinceCode, cityCode, areaCode,classificationId);

		

	}

	/**
	 * 根据主键id查询详情
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "selectOrderDetailById")
	public SalesOrder selectOrderDetailById(HttpServletRequest request, Integer id) {
		return salesOrderService.selectOrderDetailById(id);
	}

	/**
	 * 生成备货单
	 * 
	 * @param request
	 * @param id
	 *            销售订单id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/createOutboundOrder")
	public JSONObject createOutboundOrder(HttpServletRequest request, Integer id) throws Exception {
		JSONObject rmsg = new JSONObject();
		SalesOrder s = new SalesOrder();
		s.setState(35); //待备货
		s.setId(id);
		// 修改销售订单的状态为待备货
		if (salesOrderService.updateByPrimaryKeySelective(s) > 0) {
			// 获取添加好的销售订单信息
			SalesOrder salesOrder = salesOrderService.selectByPrimaryKey(id);
			String maxIdentifier = salesOrderService.selectMaxIdentifier();
			salesOrder.setOrderType(3);// 单据类型为备货单(出库单)
			salesOrder.setState(35);// 状态改为待备货
			salesOrder.setParentId(id);
			String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
			salesOrder.setIdentifier(identifier);// 生成编号
			salesOrder.setId(null);
			salesOrder.setCreateTime(new Date());
			salesOrder.setOriginator(GetSessionUtil.GetSessionUserIdentifier(request));
			// 添加出库单
			if (salesOrderService.insertSelective(salesOrder) > 0) {
				// 获取添加好的销售订单对应的销售商品信息
				List<SalesOrderCommodity> salesOrderCommodities = salesOrderCommodityService
						.selectMsgBySalesOrderId(id);
				for (SalesOrderCommodity sc : salesOrderCommodities) {
					sc.setSalesOrderId(salesOrder.getId());
				}
				// 保存成功
				if (salesOrderCommodityService.insertBeatch(salesOrderCommodities)) {
					//首页提醒处理Start
					messageService.addMessage(id, "备货单");
					//首页提醒处理End
					// 往log表中插入操作数据
					insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(),
							GetSessionUtil.GetSessionUserIdentifier(request));
					rmsg.put("success", true);
					rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
					rmsg.put("id", salesOrder.getId());
					Integer salesOrderId = id;
					// 生成出库单单据打印页面所需的信息 返回值为JSON格式
					rmsg.put("outboundOrderJSON", createOutboundOrderJSON(salesOrderService.selectOrderDetailById(salesOrderId),0));
					return rmsg;
				}
				// 保存失败
				else {
					// 删除保存好的出库单
					salesOrderService.deleteByPrimaryKey(salesOrder.getId());
					// 修改销售订单的状态为待打印出库单
					s.setState(5);
					salesOrderService.updateByPrimaryKeySelective(s);
					rmsg.put("success", false);
					rmsg.put("msg", "生成备货单失败！");
					return rmsg;
				}

			}
			// 生成出库单失败
			else {
				// 修改销售订单的状态为待打印出库单
				s.setState(5);
				salesOrderService.updateByPrimaryKeySelective(s);
			}
		}
		rmsg.put("success", false);
		rmsg.put("msg", "生成备货单失败！");
		return rmsg;

	}
	
	/**
	 * 去备货
	 * @param request
	 * @param id
	 * @param identifier
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/goToStockUp")
	public JSONObject goToStockUp(HttpServletRequest request, Integer id,String identifier) throws Exception {
		JSONObject rmsg = new JSONObject();
		SalesOrder s = new SalesOrder();
		s.setState(11); //备货中
		s.setId(id);
		
		SalesOrder pickingListOrder=salesOrderService.selectByPrimaryKey(id);
		// 修改备货单的状态为备货中
		if (salesOrderService.updateByPrimaryKeySelective(s) > 0) {
			//修改销售订单状态为备货中
			s = new SalesOrder();
			s.setId(pickingListOrder.getParentId());
			s.setState(11);
			if(salesOrderService.updateByPrimaryKeySelective(s) > 0){
				//首页提醒处理Start
				messageService.addMessage(pickingListOrder.getParentId(), "出库单");
				//首页提醒处理End
				
				// 往log表中插入操作数据
				insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));

				rmsg.put("success", true);
				rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
				return rmsg;
			}
			// 保存失败
			else {
					
				// 修改销售订单的状态为待备货
				s = new SalesOrder();
				s.setId(id);
				s.setState(35);
				salesOrderService.updateByPrimaryKeySelective(s);
				rmsg.put("success", false);
				rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
				return rmsg;
			}

		}
		// 生成出库单失败
		else {
			rmsg.put("success", false);
			rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
			return rmsg;
		}

		

	}
	
	/**
	 * 打印出库单---出库单页面的打印按钮
	 * @param request
	 * @param id
	 * @param isOutBoundOrPickingList  是备货单还是出库单   0:备货单  1：出库单
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/printOutboundOrder")
	public JSONObject printOutboundOrder(HttpServletRequest request, Integer id,Integer isOutBoundOrPickingList) throws Exception {
		System.out.println("isOutBoundOrPickingList:"+isOutBoundOrPickingList);
		return createOutboundOrderJSON(salesOrderService.selectOrderDetailById(id),isOutBoundOrPickingList);
	}
	

	/**
	 * 新增销售信息 planOrTable (1:计划单页面的添加按钮，2：订单页面的添加按钮)
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addSalesOrder", method = RequestMethod.POST)
	public JSONObject addPurchaseOrder(HttpServletRequest request, Integer planOrTable) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 订单
		if (planOrTable == 2) {
			// 获取ajax传递过来的参数
			String so = request.getParameter("salesOrder");
			// 将json格式的字符串转换成JSONObject 对象
			net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(so);
			Map<String, Class> map = new HashMap<String, Class>();
			map.put("salesOrderCommodities", SalesOrderCommodity.class); // key为teacher私有变量的属性名
			// 把JSON串转换成对象
			SalesOrder salesOrder = (SalesOrder) net.sf.json.JSONObject.toBean(jsonobject, SalesOrder.class, map);
			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			salesOrder.setOriginator(userIdentifier);
			Date date = new Date();
			salesOrder.setCreateTime(date);
			salesOrder.setParentId(0);
			String maxIdentifier = salesOrderService.selectMaxIdentifier();
			
			// 生成编号
			String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
			int result = -1;
		
			salesOrder.setOrderType(1);
			salesOrder.setIdentifier(identifier);
			salesOrder.setBranch("总部");
			salesOrder.setState(1);

			// 往数据库中根据id修改信息
			result = salesOrderService.insertSelective(salesOrder);

			if (result > 0) {
				for (SalesOrderCommodity sc : salesOrder.getSalesOrderCommodities()) {
					sc.setSalesOrderId(salesOrder.getId());
				}
				salesOrderCommodityService.insertBeatch(salesOrder.getSalesOrderCommodities());
				// 获取商品所属的仓库id以及商品信息
				List<Inventory> inventories = new ArrayList<>();
				Inventory inventory;
				for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
					if (soc.getWarehouseId() != null && soc.getWarehouseId() > 0) {
						inventory = new Inventory();
						inventory.setSpecificationId(soc.getCommoditySpecificationId());
						inventory.setWarehouseId(soc.getWarehouseId());
						inventory.setOccupiedInventory(soc.getDeliverGoodsNum());
						inventories.add(inventory);
					}
				}
				// 修改各个仓库的占用数量
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateOccupiedInventory(inv);
					}

				}

				// 往log表中插入操作数据
				insertLog(operateType, salesOrder.getIdentifier(), Constants.OPERATE_INSERT, new Date(),
						userIdentifier);

				rmsg.put("success", true);
				rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
				return rmsg;

			}
		}else {//计划单
			// 获取ajax传递过来的参数
			int salesPlanOrderId = Integer.parseInt(request.getParameter("salesPlanOrderId"));
			SalesPlanOrder salesPlanOrder = salesPlanOrderService.selectByPrimaryKey(salesPlanOrderId);
			SalesOrder salesOrder = new SalesOrder();
			salesOrder.setParentId(0);
			// 生成编号
			String maxIdentifier = salesOrderService.selectMaxIdentifier();
			String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);			
			salesOrder.setIdentifier(identifier);
			salesOrder.setOrderType(1);
			salesOrder.setCreateTime(salesPlanOrder.getCreateTime());
			salesOrder.setEndValidityTime(salesPlanOrder.getEndTime());
			salesOrder.setReceiptGoodsPlace(salesPlanOrder.getAppConsigneeAddress());
			salesOrder.setConsignee(salesPlanOrder.getAppConsigneeName());
			salesOrder.setPhone(salesPlanOrder.getAppConsigneePhone());
			
			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			salesOrder.setOriginator(userIdentifier);
			salesOrder.setSummary(salesPlanOrder.getSummary());
			salesOrder.setBranch(salesPlanOrder.getBranch());
			salesOrder.setState(1);
			salesOrder.setIsSpecimen(1);
			salesOrder.setSupctoId(salesPlanOrder.getSupctoId());
			salesOrder.setPersonId(salesPlanOrder.getPersonId());
			salesOrder.setSalesPlanOrderId(salesPlanOrder.getId());
			salesOrder.setIsShow(2);
			Supcto  supcto=supctoService.selectByPrimaryKey(salesPlanOrder.getSupctoId());
			salesOrder.setPhone(supcto.getPhone());
			salesOrder.setFax(supcto.getFax()==null?"":supcto.getFax());
			salesOrder.setShippingModeId(supcto.getShippingModeId());
			salesOrder.setReceiptGoodsPlace(supcto.getDeliveryAddress());
			salesOrder.setOrderer(supcto.getContactPeople());
			if(salesOrderService.insertSelective(salesOrder)>0) {//销售订单表插入成功   
				//修改销售计划单的状态
				SalesPlanOrder t = new SalesPlanOrder();
				t.setId(salesPlanOrderId);
				t.setState(2);
				salesPlanOrderService.updateByPrimaryKeySelective(t);
				
				
				//处理销售订单商品表
				List<SalesPlanOrderCommodity> salesPlanOrderCommodities = salesPlanOrderCommodityService.selectMsgBySalesPlanOrderId(salesPlanOrderId);
				SalesPlanOrderCommodity salesPlanOrderCommodity;
				SalesOrderCommodity salesOrderCommodity;
				int commoditySpecificationId;
				double money, taxes, taxesMoney;
				for (int i = 0; i < salesPlanOrderCommodities.size(); i++) {
					salesPlanOrderCommodity = salesPlanOrderCommodities.get(i);
					salesOrderCommodity = new SalesOrderCommodity();
					salesOrderCommodity.setSalesOrderId(salesOrder.getId());
					commoditySpecificationId = salesPlanOrderCommodity.getCommoditySpecificationId();
					salesOrderCommodity.setCommoditySpecificationId(commoditySpecificationId);
					money = salesPlanOrderCommodity.getMoney();
					salesOrderCommodity.setDeliverGoodsMoney(money);
					salesOrderCommodity.setDeliverGoodsNum(salesPlanOrderCommodity.getNumber());
					salesOrderCommodity.setUnitPrice(salesPlanOrderCommodity.getUnitPrice());
					salesOrderCommodity.setRemark(salesPlanOrderCommodity.getRemark());
					salesOrderCommodity.setIsSpecialOffer(1);
					salesOrderCommodity.setWarehouseId(inventoryService.getWarehouseIdByCommoditySpecificationId(salesPlanOrderCommodity.getCommoditySpecificationId()));
					taxes = commoditySpecificationService.selectTaxesByPrimaryKey(commoditySpecificationId);
					salesOrderCommodity.setTaxes(taxes);
					taxesMoney = taxes * money;
					salesOrderCommodity.setTaxesMoney(taxesMoney);
					salesOrderCommodityService.insertSelective(salesOrderCommodity);
				}
				
				// 往log表中插入操作数据
				insertLog(operateType, salesOrder.getIdentifier(), Constants.OPERATE_INSERT, new Date(),
						userIdentifier);

				rmsg.put("success", true);
				rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
				return rmsg;
			}
			
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 编辑销售信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/editSalesOrder", method = RequestMethod.POST)
	public JSONObject editSalesOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String so = request.getParameter("salesOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(so);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("salesOrderCommodities", SalesOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		SalesOrder salesOrder = (SalesOrder) net.sf.json.JSONObject.toBean(jsonobject, SalesOrder.class, map);
		
		//获取详情--供下面解除锁定使用
		SalesOrder salesOrderMsg=salesOrderService.selectOrderDetailById(salesOrder.getId());
		// 往数据库中根据id修改信息
		int result = salesOrderService.updateByPrimaryKeySelective(salesOrder);

		if (result > 0) {		
			//解除库存锁定
			Inventory inventory;
			for(SalesOrderCommodity soc:salesOrderMsg.getSalesOrderCommodities()){
				inventory = new Inventory();
				inventory.setSpecificationId(soc.getCommoditySpecificationId());
				inventory.setOccupiedInventory(soc.getDeliverGoodsNum());
				inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inventory);
			}
			//删除之前添加好的销售订单商品
			salesOrderCommodityService.deleteMsgBySalesOrderId(salesOrder.getId());

			//重新保存销售订单商品
			for (SalesOrderCommodity sc : salesOrder.getSalesOrderCommodities()) {
				sc.setSalesOrderId(salesOrder.getId());
			}
			salesOrderCommodityService.insertBeatch(salesOrder.getSalesOrderCommodities());
			
			//重新设置占用库存数
			// 获取商品所属的仓库id以及商品信息
			List<Inventory> inventories = new ArrayList<>();
			for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
				if (soc.getWarehouseId() != null && soc.getWarehouseId() > 0) {
					inventory = new Inventory();
					inventory.setSpecificationId(soc.getCommoditySpecificationId());
					inventory.setWarehouseId(soc.getWarehouseId());
					inventory.setOccupiedInventory(soc.getDeliverGoodsNum());
					inventories.add(inventory);
				}
			}
			// 修改各个仓库的占用数量
			if (inventories.size() > 0) {
				for (Inventory inv : inventories) {
					inventoryService.updateOccupiedInventory(inv);
				}

			}

			// 往log表中插入操作数据
			insertLog(operateType, salesOrder.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;

		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 删除销售信息 id
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/deletePurchaseOrder", method = RequestMethod.POST)
	public JSONObject deletePurchaseOrder(HttpServletRequest request, Integer id) throws Exception {
		JSONObject rmsg = new JSONObject();
		SalesOrder salesOrder = salesOrderService.selectByPrimaryKey(id);
		SalesOrder salesOrderMsg=salesOrderService.selectOrderDetailById(id);
		Inventory inventory;
		SalesOrder updateSalesOrder=new SalesOrder();
		updateSalesOrder.setId(id);
		updateSalesOrder.setState(37);
		if (salesOrderService.updateByPrimaryKeySelective(updateSalesOrder) > 0) {
			//salesOrderCommodityService.deleteMsgBySalesOrderId(id);
			//解除库存锁定
			for(SalesOrderCommodity soc:salesOrderMsg.getSalesOrderCommodities()){
				inventory = new Inventory();
				inventory.setSpecificationId(soc.getCommoditySpecificationId());
				inventory.setOccupiedInventory(soc.getDeliverGoodsNum());
				inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inventory);
			}
			messageService.clearMessage(id, 5);
			// 往log表中插入操作数据
			insertLog(operateType, salesOrder.getIdentifier(), Constants.OPERATE_DELETE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", Constants.DELE_SUCCESS_MSG);
			return rmsg;
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.DELE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 判断是否需要拆单
	 * 
	 * @param request
	 * @param salesOrderId
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/judgeIsSplitOrder", method = RequestMethod.POST)
	public JSONObject judgeIsSplitOrder(HttpServletRequest request, Integer salesOrderId) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 根据销售订单id查询销售商品所属的仓库id以及销售订单id
		List<SalesOrderCommodity> salesOrderIsAndWarehouseIds = salesOrderCommodityService
				.selectWarehouseIdBySalesOrderId(salesOrderId);
		if (salesOrderIsAndWarehouseIds != null && salesOrderIsAndWarehouseIds.size() > 1) {
			rmsg.put("success", false);
			rmsg.put("msg", "订单中的商品分属于不同的仓库，审核前需拆单。");
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}

	/**
	 * 送审
	 * 
	 * @param request
	 * @param salesOrderId
	 *            销售订单id
	 * @param flag 1:销售订单送审  2:其他发货单送审
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/submitSalesOrder", method = RequestMethod.POST)
	public JSONObject submitSalesOrder(HttpServletRequest request, Integer salesOrderId,String identifier,int flag) throws Exception {
		//System.out.println("salesOrderId:" + salesOrderId);
		JSONObject rmsg = new JSONObject();
		SalesOrder salesOrder;
		// 根据销售订单id查询销售商品所属的仓库id以及销售订单id
		List<SalesOrderCommodity> salesOrderIsAndWarehouseIds = salesOrderCommodityService
				.selectWarehouseIdBySalesOrderId(salesOrderId);
		// 如果销售订单里的商品所属的仓库不止一个，则需要分仓 拆单
		if (salesOrderIsAndWarehouseIds != null && salesOrderIsAndWarehouseIds.size() > 1) {
			// 根据上面查到的仓库id以及销售订单id 查询销售订单id
			List<SalesOrder> salesOrders = new ArrayList<>();
			for (SalesOrderCommodity salesOrderCommodity : salesOrderIsAndWarehouseIds) {
				SalesOrder salesOrder2 = salesOrderService.selectCommodityByWareIdAndOrderId(salesOrderCommodity);
				salesOrders.add(salesOrder2);
			}
			int breakCode = 1;
			for (SalesOrder so : salesOrders) {
				//System.out.println("for salesOrderId:" + salesOrderId);
				so.setParentId(salesOrderId);// 设置ParentId为当前需要送审的销售订单id
				so.setBreakCode(breakCode + "");// 添加拆单码
				so.setId(null);
				so.setState(2);
				breakCode++;
			}
			//System.out.println("salesOrders.size:" + salesOrders.size());
			// 批量添加成功
			if (salesOrderService.insertBatch(salesOrders)) {
				for (SalesOrder so : salesOrders) {
					for (SalesOrderCommodity soc : so.getSalesOrderCommodities()) {
						soc.setId(null);
						soc.setSalesOrderId(so.getId());// 设置销售订单id为刚添加好的id
					}
					if (!salesOrderCommodityService.insertBeatch(so.getSalesOrderCommodities())) {
						// 添加失败
						// 删除之前添加好的销售订单商品信息
						salesOrderCommodityService.deleteBatchMsgBySalesOrderId(salesOrders);
						// 删除之前添加好的销售订单信息
						salesOrderService.deleteBatchByPrimaryKey(salesOrders);
						rmsg.put("success", false);
						rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
						return rmsg;
					}
					
					//插入消息列表
					if(flag == 2) {
						messageService.addMessage(so.getId(), "其他发货单领导审核");
					}else {
						messageService.addMessage(so.getId(), "销售订单审核");
					}
					//删除之前添加的消息
					messageService.clearMessage(so.getParentId(), 5);
					
				}
				// 设置拆单前的销售订单id为不可显示
				salesOrder = new SalesOrder();
				salesOrder.setId(salesOrderId);
				salesOrder.setIsShow(1);
				salesOrderService.updateByPrimaryKeySelective(salesOrder);
			
			}
		}
		// 不需要拆单
		else {
			salesOrder = new SalesOrder();
			salesOrder.setId(salesOrderId);
			salesOrder.setState(2);
			salesOrderService.updateByPrimaryKeySelective(salesOrder);
			//插入消息列表
			if(flag == 2) {
				messageService.addMessage(salesOrderId, "其他发货单领导审核");
			}else {
				messageService.addMessage(salesOrderId, "销售订单审核");
			}
			
		}
		// 往log表中插入操作数据
		insertLog(operateType, identifier, Constants.OPERATE_UPDATE, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));
		rmsg.put("success", true);
		rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
		return rmsg;
	}

	/**
	 * 生成出库单单据打印页面所需的信息 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createOutboundOrderJSON(SalesOrder salesOrder,Integer isOutBoundOrPickingList) {
		JSONObject outboundOrderJSON = new JSONObject();
		System.out.println("create isOutBoundOrPickingList:"+isOutBoundOrPickingList);
		if(isOutBoundOrPickingList==0){
			outboundOrderJSON.put("title", "备货单");
		}
		else{
			outboundOrderJSON.put("title", "出库单");
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		if(isOutBoundOrPickingList==0){
			head.setFieldValue("备货单");
		}else{
			head.setFieldValue("出库单");
		}
		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		if(salesOrder.getSupcto()!=null){
			head.setFieldValue(salesOrder.getSupcto().getName());
		}
		else{
			head.setFieldValue("");
		}
		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		if(salesOrder.getShippingMode()!=null){
			head.setFieldValue(salesOrder.getShippingMode().getName());
		}
		else{
			head.setFieldValue("");
		}
		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
		if(salesOrder.getEndValidityTime()!=null){
			head.setFieldValue(dateFormat.format(salesOrder.getEndValidityTime()));
		}
		else{
			head.setFieldValue("");
		}	
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("发货地点");
		if(salesOrder.getDeliverGoodsPlace()!=null){
			head.setFieldValue(salesOrder.getDeliverGoodsPlace());
		}
		else{
			head.setFieldValue("");
		}	
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
		if(salesOrder.getOrderer()!=null){
			head.setFieldValue(salesOrder.getOrderer());
		}
		else{
			head.setFieldValue("");
		}
		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("收货人");
		if(salesOrder.getConsignee()!=null){
			head.setFieldValue(salesOrder.getConsignee());
		}
		else{
			head.setFieldValue("");
		}	
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		if(salesOrder.getPhone()!=null){
			head.setFieldValue(salesOrder.getPhone());
		}
		else {
			head.setFieldValue("");
		}
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("收货地点");
		if(salesOrder.getReceiptGoodsPlace()!=null){
			head.setFieldValue(salesOrder.getReceiptGoodsPlace());
		}
		else{
			head.setFieldValue("");
		}
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "规格编码", "货品名称", "规格", "单位", "单价", "发货数量", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), soc.getUnitPrice() + "",
					soc.getDeliverGoodsNum() + "", soc.getDeliverGoodsMoney() + "" };
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += soc.getDeliverGoodsMoney();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalMoney+"");

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员部门");
		footer.setFieldValue(salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator() + "(" + salesOrder.getPerson().getName() + ")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator());
		}
		footers.add(footer);
		/*footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");

		if (salesOrder.getReviewerName() != null) {
			footer.setFieldValue(salesOrder.getReviewerIdentifier() + "(" + salesOrder.getReviewerName() + ")");
		} else {
			footer.setFieldValue(salesOrder.getReviewerIdentifier());
		}

		footers.add(footer);*/
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}

	/**
	 * 更新单据打印次数
	 */
	@ResponseBody
	@RequestMapping(value = "updateSalesOrderPrintNum")
	public JSONObject updateSalesOrderPrintNum(HttpServletRequest request, int id) throws Exception {

		JSONObject rmsg = new JSONObject();
		SalesOrder salesOrder = salesOrderService.selectByPrimaryKey(id);
		String identifier = salesOrder.getIdentifier();
		int printNum = salesOrder.getPrintNum();
		printNum += 1;
		salesOrder = new SalesOrder();
		salesOrder.setId(id);
		salesOrder.setPrintNum(printNum);
		if (salesOrderService.updateByPrimaryKeySelective(salesOrder) > 0) {
			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			insertLog(Constants.TYPE_LOG_SALES, identifier, Constants.OPERATE_UPDATE, new Date(), userIdentifier);
			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 根据id列表更改状态(一般流程，即：对于id列表中的所有数据，要修改为的状态一致)
	 * 
	 * @param request
	 * @param ids
	 *            id列表
	 * @param state
	 *            要修改为的状态值
	 * @param isCheck
	 *            是否是审核 0:否，1：是（决定是否 向销售订单审批人员表中加入/修改数据）
	 * @param reviewerType
	 *            审批类型（1：订单审核，2：作废销售领导审核，3：作废仓库审核，4：销售开单审核，5：申请修改审核，6：折损单审核）isCheck
	 *            == 0时请传0
	 * @param msg
	 *            操作成功后页面中弹出的消息提醒内容（如："操作成功，已通过"、"操作成功，已驳回"等）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateStateByIds", method = RequestMethod.POST)
	public JSONObject updateStateByIds(HttpServletRequest request, String[] ids, int state, int isCheck,
			int reviewerType, String msg) throws Exception {


		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
				
			}
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", list);
		
		map.put("state", state);
		if(state == -1) {//其他发货单的确认出库操作
			map.put("state", 12);
		}else if(state == -2){//其他发货单的通知财务开单
			map.put("state", 24);
		}else if(state == -3){//其他发货单的作废
			map.put("state", 6);
		}else if(state == -4){//其他发货单的作废
			map.put("state", 7);
		}else if(state == -5){//其他发货单的作废
			map.put("state", 25);
		}else if(state == -6){//其他发货单的作废
			map.put("state", 10);
		}

		JSONObject rmsg = new JSONObject();
		rmsg.put("msg", msg);

		if (salesOrderService.updateStateByIds(map)) {
			
			//销售开单审核，可能是销售开单修改之后编辑，此时需要根据返货数量和折损数量修改签收数量。
			if(reviewerType == 4){
				for(String id:ids){
					SalesOrder salesOrder=salesOrderService.getSalesOpeningDetailById(Integer.parseInt(id));
					if(salesOrder!=null&&salesOrder.getSalesOrderCommodities()!=null&&salesOrder.getSalesOrderCommodities().size()>0){
						for(SalesOrderCommodity commodity:salesOrder.getSalesOrderCommodities()){
							int deliverGoodsNum=0;//发货数量
							int damageNum=0;//折损数量
							int returnGoodsNum=0;//返货数量
							double unitPrice=0.0;//单价
							double taxes=0.0;//税率
							if(commodity.getDeliverGoodsNum()!=null&&commodity.getReceivingGoodsNum()!=null&&commodity.getUnitPrice()!=null&&commodity.getTaxes()!=null){
								deliverGoodsNum=commodity.getDeliverGoodsNum();
								unitPrice=commodity.getUnitPrice();
								taxes=commodity.getTaxes();
								if(commodity.getDamageNum()!=null&&commodity.getDamageNum()>0){
									damageNum=commodity.getDamageNum();
								}
								if(commodity.getReturnGoodsNum()!=null&&commodity.getReturnGoodsNum()>0){
									returnGoodsNum=commodity.getReturnGoodsNum();
								}
								
								//修改销售开单的签收数量和签收金额
								SalesOrderCommodity commodity2=new SalesOrderCommodity();
								commodity2.setId(commodity.getId());
								commodity2.setReceivingGoodsNum(deliverGoodsNum-damageNum-returnGoodsNum);
								double money=commodity2.getReceivingGoodsNum()*unitPrice*(1+taxes);
								// 新方法，如果不需要四舍五入，可以使用RoundingMode.DOWN
						        BigDecimal bg = new BigDecimal(money).setScale(2, RoundingMode.UP);
								commodity2.setReceivingGoodsMoney(bg.doubleValue());
								salesOrderCommodityService.updateByPrimaryKeySelective(commodity2);
								System.out.println("reviewerType:"+commodity2.getReceivingGoodsNum());
							}
						}
					}
				}
				
			}
			
			//1.state == 7:需仓库审核的作废之销售领导审核待审核时，更改相应出库单的状态也为7
			//2.state == 10:订单作废时，修改相应出库单的状态也为作废
			//2.state == 25:需仓库审核的作废审核驳回时，修改相应出库单的状态为11（备货中）
			//3:reviewerType == 4 || reviewerType == 6:销售开单&折损单审核 状态改变需改变相应出库单的状态
			if (state == 6 ||state == 7 || state == 10 || state == 25|| state == 34 || reviewerType == 4 || reviewerType == 6) {
				List<SalesOrder> salesOrderList = salesOrderService.getSalesOrderByIds(list);// 获取所有将要更改状态的销售订单信息
				ArrayList<Integer> parentIds = new ArrayList<Integer>();
				if(reviewerType == 4 || reviewerType == 6) {
					for (int i = 0; i < salesOrderList.size(); i++) {
						parentIds.add(salesOrderList.get(i).getParentId());// 获取所有将要更改状态的销售订单信息的parentId
					}
				}else if(state == 6 ||state == 7 || state == 10 || state == 25|| state == 34){
					for (int i = 0; i < salesOrderList.size(); i++) {
						parentIds.add(salesOrderList.get(i).getId());// 获取所有将要更改状态的销售订单信息的parentId
					}
				}
				

				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("orderType", 3);// 出库单
				map1.put("parentIds", parentIds);

				// 根据orderType==3&&parentId in parentIds 批量获取相应的出库单
				List<SalesOrder> salesOrders = salesOrderService.getSalesOrderByOrderTypeAndParentId(map1);
				ArrayList<Integer> updateIds = new ArrayList<Integer>();
				for (SalesOrder s : salesOrders) {
					updateIds.add(s.getId());
				}
				// 批量更改相应出库单的状态
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("ids", updateIds);
				
				if(state == 25) {
					map2.put("state", 11);
				}else {
					map2.put("state", state);
				}
				salesOrderService.updateStateByIds(map2);
			}
			
			//其他发货单作废  state == -4:需仓库审核的作废之销售领导审核待审核时，更改相应出库单的状态也为7
			if (state == -4||state == -5||state == -6) {
				List<SalesOrder> salesOrderList = salesOrderService.getSalesOrderByIds(list);// 获取所有将要更改状态的销售订单信息
				ArrayList<Integer> parentIds = new ArrayList<Integer>();
			
				for (int i = 0; i < salesOrderList.size(); i++) {
					parentIds.add(salesOrderList.get(i).getId());// 获取所有将要更改状态的销售订单信息的parentId
				}
				

				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("orderType", 9);// 出库单
				map1.put("parentIds", parentIds);

				// 根据orderType==9&&parentId in parentIds 批量获取相应的出库单
				List<SalesOrder> salesOrders = salesOrderService.getSalesOrderByOrderTypeAndParentId(map1);
				ArrayList<Integer> updateIds = new ArrayList<Integer>();
				for (SalesOrder s : salesOrders) {
					updateIds.add(s.getId());
				}
				// 批量更改相应出库单的状态
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("ids", updateIds);
				if(state == -4) {
					map2.put("state", 7);
				}else if(state == -5){
					map2.put("state", 11);
				}else if(state == -6){
					map2.put("state", 10);
				}
				
				salesOrderService.updateStateByIds(map2);
			}
			
			//如果状态为31，说明是销售退货入库，需要增加商品的库存
			if(state == 31) {
				int salesOrderId;
				int commoditySpecificationId;
				int number;
				Inventory inventory ;
				for (int i = 0; i < list.size(); i++) {//遍历id列表
					salesOrderId = list.get(i);
					//获取每个销售退货单下的销售退货商品列表
					List<SalesOrderCommodity> salesOrderCommodities = salesOrderCommodityService.selectMsgBySalesOrderId(salesOrderId);
					for (SalesOrderCommodity sc : salesOrderCommodities) {//遍历退货商品列表 修改该商品的库存
						commoditySpecificationId = sc.getCommoditySpecificationId();//获取需要修改库存的商品规格id
						number = sc.getReturnGoodsNum();//获取商品的退货数量
						//修改库存
						inventory = new Inventory();
						inventory.setSpecificationId(commoditySpecificationId);
						inventory.setInventory(number);
						inventoryService.updateAddGoodsInventoryBySpecificationId(inventory);
					}
				}
			}
			
			if (isCheck == 1) {
				// 销售订单审核表处理
				SalesOrderReviewer salesOrderReviewer = new SalesOrderReviewer();
				int operatorId = GetSessionUtil.GetSessionUserId(request);
				salesOrderReviewer.setReviewerId(operatorId);// 审批人id
				salesOrderReviewer.setReviewerType(reviewerType);// 审批类型
				for (int i = 0; i < list.size(); i++) {
					// 销售订单id
					salesOrderReviewer.setSalesOrderId(list.get(i));
					// 根据销售订单id和审批类型获取信息 有记录：修改 没有记录：插入
					SalesOrderReviewer salesOrderReviewer1 = salesOrderReviewerService
							.selectBySalesOrderIdAndReviewerType(salesOrderReviewer);
					if (salesOrderReviewer1 != null) {
						salesOrderReviewer1.setReviewerId(operatorId);
						salesOrderReviewerService.updateByPrimaryKeySelective(salesOrderReviewer1);
					} else {
						salesOrderReviewerService.insert(salesOrderReviewer);
					}

				}

			}
			
			
			//处理首页提醒start
			String menuName = "";
			List<Integer> serviceIds = list;
			switch (state) {
			case -1://其他发货单的确认出库
				serviceIds = new ArrayList<>();
				serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(0)).getParentId());
				menuName = "其他发货单出库单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case -2:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "其他发货单开单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case -3:
				menuName = "其他发货单作废领导审核";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case -4:
				menuName = "其他发货单作废领导审核";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case -5:
				menuName = "其他发货单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case -6:
				menuName = "其他发货单";
				//messageService.addMessageBath(serviceIds, menuName);
				messageService.clearMessageBath(serviceIds, 5);
				break;
			case 5:
				menuName = "销售订单引用";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 6:
				menuName = "销售订单作废审核";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 7:
				menuName = "销售订单作废审核";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 10:
				menuName = "销售订单";
				//messageService.addMessageBath(serviceIds, menuName);
				messageService.clearMessageBath(serviceIds, 5);
				break;
			case 12:
				serviceIds = new ArrayList<>();
				serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(0)).getParentId());
				menuName = "出库单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 14:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "销售开单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 15:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				
				messageService.clearMessageBath(serviceIds, 5);
				break;
			case 16:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "申请修改开单审核";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 17:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "销售开单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 18:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "销售开单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 24:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "引用出库单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 25:
				menuName = "销售订单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 26:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "出库单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 28:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "销售退货单审核";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 29:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "销售退货单";
				messageService.addMessageBath(serviceIds, menuName);
				break;	
			case 30:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "销售退货入库";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 31:
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(salesOrderService.selectByPrimaryKey(list.get(i)).getParentId());
				}
				menuName = "销售退货单";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			case 36://此情况为：其他发货单领导审批通过时
				serviceIds = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					serviceIds.add(list.get(i));
				}
				menuName = "其他发货单财务审核";
				messageService.addMessageBath(serviceIds, menuName);
				break;
			default:
				break;
			}
			
			//处理首页提醒end
			
			
			
			// 插入日志
			// 保存操作的对象编号
			List<SalesOrder> salesOrders = salesOrderService.getSalesOrderByIds(list);

			// 操作对象
			String operateObject = "";
			for (int i = 0; i < salesOrders.size(); i++) {
				operateObject += salesOrders.get(i).getIdentifier();
				if (i < salesOrders.size() - 1) {
					operateObject += ",";
				}
			}

			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);

			// 操作类型
			int operateType;
			if (isCheck == 1) {
				operateType = Constants.TYPE_LOG_CHECK;
			} else {
				operateType = Constants.TYPE_LOG_SALES;
			}
			// 操作时间
			Date operateTime = new Date();

			insertLog(operateType, operateObject, Constants.OPERATE_UPDATE, operateTime, operatorIdentifier);

			rmsg.put("success", true);

			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败，请确认后重新操作！");
		return rmsg;
	}

	/**
	 * 根据id列表和当前状态更改状态(流程升级，即：对于id列表中的所有数据，要修改为的状态不一致，需要对数据当前状态进行判断)
	 * 注意：1.调用此方法时请确认switch (state)中有没有相应处理 若没有请自行添加
	 * 
	 * @param request
	 * @param ids
	 *            id列表
	 * @param isCheck
	 *            是否是审核 0:否，1：是（决定是否 向销售订单审批人员表中加入/修改数据）
	 * @param reviewerType
	 *            审批类型（1：订单审核，2：作废销售领导审核，3：作废仓库审核，4：销售开单审核，5：申请修改审核，6：折损单审核）isCheck
	 *            == 0时请传0
	 * @param msg
	 *            操作成功后页面中弹出的消息提醒内容（如："操作成功，已通过"、"操作成功，已驳回"等）
	 * @param yesOrNo
	 *            审批通过还是拒绝 不需要用到此参数请传0 1：拒绝 2：通过
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateStateByIdsAndState", method = RequestMethod.POST)
	public JSONObject updateStateByIdsAndState(HttpServletRequest request, String[] ids, int isCheck, int reviewerType,
			String msg, int yesOrNo) throws Exception {
		JSONObject rmsg = new JSONObject();

		SalesOrder salesOrder, updateSalesOrder;
		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				int id = Integer.valueOf(ids[i]);
				list.add(id);
				// 根据id获取销售订单信息
				salesOrder = salesOrderService.selectByPrimaryKey(id);
				//查看该订单下有没有备货单---以供下面只需销售领导审核的作废待审核的驳回时使用
				Map<String,Object> map=new HashMap<>();
				map.put("parentId", id);
				map.put("orderType",3);
				SalesOrder salesOrder2=salesOrderService.selectMsgByParentIdAndOrderType(map);
				int state = salesOrder.getState();
				int afterState = -1;
				updateSalesOrder = new SalesOrder();

				switch (state) {
				case 6:// 只需销售领导审核的作废待审核
					if (yesOrNo == 1) {// 驳回
						//说明已经生成备货单
						if(salesOrder2!=null){
							updateSalesOrder.setIsCreateStockOrder(1);
						}
						afterState = 9;// 只需销售领导审核的作废审核驳回
					} else if (yesOrNo == 2) {// 通过
						afterState = 10;// 已作废
					}
					break;

				case 7:// 需仓库审核的作废审核之销售领导审核
					if (yesOrNo == 1) {// 驳回
						afterState = 25;// 需仓库审核的作废审核驳回
					} else if (yesOrNo == 2) {// 通过
						afterState = 8;// 仓库作废审核中
					}
					break;
				case 34:// 需收预付款的作废待审核
					if (yesOrNo == 1) {// 驳回
						afterState = 4;// 待收预付款
					} else if (yesOrNo == 2) {// 通过
						afterState = 10;// 已作废
					}
					break;
				case 19:// 折损单待审核
					if (yesOrNo == 1) {// 驳回
						afterState = 20;// 折损单审核驳回
					} else if (yesOrNo == 2) {// 通过
						afterState = 21;// 折损单审核通过
					}
					break;

				case 22:// 销售开单折损单待审核
					if (yesOrNo == 1) {// 驳回
						afterState = 23;// 销售开单折损单审核驳回
					} else if (yesOrNo == 2) {// 通过
						afterState = 13;// 销售开单待审核
					}
					break;
				default:
					break;
				}
				updateSalesOrder.setId(id);
				updateSalesOrder.setState(afterState);
				if (salesOrderService.updateByPrimaryKeySelective(updateSalesOrder) <= 0) {
					rmsg.put("success", false);
					rmsg.put("msg", "操作失败，请确认后重新操作！");
					return rmsg;
				} else {// 更新成功
					
					//需仓库审核的作废审核驳回时，更改相应的出库单的状态为11(备货中)
					if(afterState == 25) {
						//获取相应的出库单
						ArrayList<Integer> parentIds = new ArrayList<Integer>();
						parentIds.add(id);
						Map<String, Object> map1 = new HashMap<String, Object>();
						map1.put("orderType", 3);// 出库单
						map1.put("parentIds", parentIds);
						SalesOrder outBoundOrder = salesOrderService.getSalesOrderByOrderTypeAndParentId(map1).get(0);
						//更改状态为11
						SalesOrder s = new SalesOrder();
						s.setId(outBoundOrder.getId());
						s.setState(11);
						salesOrderService.updateByPrimaryKeySelective(s);
					}
					if(updateSalesOrder.getIsCreateStockOrder()!=null&&updateSalesOrder.getIsCreateStockOrder()==1){
						if(salesOrder2!=null){
							//修改备货单的状态为9--只需销售领导审核的作废审核驳回
							SalesOrder s = new SalesOrder();
							s.setId(salesOrder2.getId());
							s.setState(9);
							salesOrderService.updateByPrimaryKeySelective(s);
						}
					}
					
					
					
						// 折损单审核 状态改变需改变相应出库单&销售开单的状态
					if (reviewerType == 6) {
						int parentId = salesOrder.getParentId();// 获取将要更改状态的折损单的parentId
						SalesOrder s = new SalesOrder();
						s.setOrderType(3);// 相应的出库单
						s.setParentId(parentId);
						s.setState(afterState);
						// 更改相应的出库单的状态
						salesOrderService.updateStateByOrderTypeAndParentId(s);
						s.setOrderType(2);// 销售开单
						// 更改相应的销售开单的状态
						salesOrderService.updateStateByOrderTypeAndParentId(s);

					}
					
					//首页提醒处理Start
					String menuName = "";
					int messageId=0;
					switch (afterState) {
					case 4:
						menuName = "预付款";
						messageId = id;
						break;
					case 9:
						menuName = "销售订单";
						messageId = id;
						break;
					case 10:
						menuName = "销售订单";
						messageId = id;
						break;
					case 25:
						menuName = "销售订单";
						messageId = id;
						break;
					case 8:
						menuName = "仓库销售订单作废审核";
						messageId = id;
						break;
					case 20:
						menuName = "引用出库单";
						messageId = salesOrder.getParentId();
						break;
					case 21:
						menuName = "引用出库单";
						messageId = salesOrder.getParentId();
						break;
					case 23:
						menuName = "销售开单";
						messageId = salesOrder.getParentId();
						break;
					case 13:
						menuName = "销售开单审核";
						messageId = salesOrder.getParentId();
						break;
					default:
						break;
					}
					messageService.addMessage(messageId, menuName);
					//首页提醒处理End

				}
			}

			if (isCheck == 1) {
				// 销售订单审核表处理
				SalesOrderReviewer salesOrderReviewer = new SalesOrderReviewer();
				int operatorId = GetSessionUtil.GetSessionUserId(request);
				salesOrderReviewer.setReviewerId(operatorId);// 审批人id
				salesOrderReviewer.setReviewerType(reviewerType);// 审批类型
				for (int i = 0; i < list.size(); i++) {
					// 销售订单id
					salesOrderReviewer.setSalesOrderId(list.get(i));
					// 根据销售订单id和审批类型获取信息 有记录：修改 没有记录：插入
					SalesOrderReviewer salesOrderReviewer1 = salesOrderReviewerService
							.selectBySalesOrderIdAndReviewerType(salesOrderReviewer);
					if (salesOrderReviewer1 != null) {
						salesOrderReviewer1.setReviewerId(operatorId);
						salesOrderReviewerService.updateByPrimaryKeySelective(salesOrderReviewer1);
					} else {
						salesOrderReviewerService.insert(salesOrderReviewer);
					}
				}
			}

			// 插入日志
			// 保存操作的对象编号
			List<SalesOrder> salesOrders = salesOrderService.getSalesOrderByIds(list);
			// 操作对象
			String operateObject = "";
			for (int i = 0; i < salesOrders.size(); i++) {
				operateObject += salesOrders.get(i).getIdentifier();
				if (i < salesOrders.size() - 1) {
					operateObject += ",";
				}
			}
			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			// 操作类型
			int operateType;
			if (isCheck == 1) {
				operateType = Constants.TYPE_LOG_CHECK;
			} else {
				operateType = Constants.TYPE_LOG_SALES;
			}
			// 操作时间
			Date operateTime = new Date();
			insertLog(operateType, operateObject, Constants.OPERATE_UPDATE, operateTime, operatorIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", msg);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "参数错误");
		return rmsg;

	}

	/**
	 * 引用出库单页面--生成销售开单/折损单
	 * 
	 * @param request
	 * @param id
	 *            出库单id
	 * @param parentId
	 *            出库单所属的销售订单id
	 * @param state
	 *            出库单状态
	 * @param commodity
	 *            销售开单/折损单相关订单商品的 商品规格id、签收/折损数量、签收/折损金额
	 * @param salesOpeningOrFoldloss
	 *            销售开单or折损单 1:销售开单 2:折损单
	 * @return
	 * @throws Exception
	 */

	@ResponseBody
	@RequestMapping(value = "createSalesOpeningOrFoldlossOrder")
	public JSONObject createSalesOpeningOrFoldlossOrder(HttpServletRequest request, Integer id, Integer parentId,
			Integer state, String commodity, Integer salesOpeningOrFoldloss) throws Exception {
		JSONObject rmsg = new JSONObject();
		JSONArray json = JSONArray.parseArray(commodity); // 首先把字符串转成 JSONArray
															// 对象

		SalesOrder s = new SalesOrder();
		s.setId(id);
		if (salesOpeningOrFoldloss == 1) {
			s.setState(13);// 销售开单待审核
		} else if (salesOpeningOrFoldloss == 2) {
			s.setState(19);// 折损单待审核
		}

		// 修改出库单的状态为销售开单待审核
		if (salesOrderService.updateByPrimaryKeySelective(s) > 0) {
			// 获取添加好的出库单信息
			SalesOrder salesOrder = salesOrderService.selectByPrimaryKey(id);
			String maxIdentifier = salesOrderService.selectMaxIdentifier();
			if (salesOpeningOrFoldloss == 1) {
				salesOrder.setOrderType(2);// 单据类型为销售开单
				salesOrder.setState(13);// 状态改为销售开单待审核
			} else if (salesOpeningOrFoldloss == 2) {
				salesOrder.setOrderType(4);// 单据类型为折损单
				salesOrder.setState(19);// 状态改为折损单待审核
			}

			String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
			salesOrder.setIdentifier(identifier);// 生成编号
			salesOrder.setId(null);
			salesOrder.setParentId(parentId);// 所属销售订单id
			salesOrder.setCreateTime(new Date());// 生成日期
			salesOrder.setOriginator(GetSessionUtil.GetSessionUserIdentifier(request));// 制单人编号
			// 添加销售开单或折损单
			if (salesOrderService.insertSelective(salesOrder) > 0) {

				// 获取添加好的销售订单对应的销售商品信息
				List<SalesOrderCommodity> salesOrderCommodities = salesOrderCommodityService
						.selectMsgBySalesOrderId(id);
				for (SalesOrderCommodity sc : salesOrderCommodities) {
					sc.setSalesOrderId(salesOrder.getId());
					int commoditySpecificationId = sc.getCommoditySpecificationId();
					if (salesOpeningOrFoldloss == 1) {// 销售开单
						// 遍历前台传过来的json数组 更改相应的商品的签收数量和签收金额
						for (int i = 0; i < json.size(); i++) {
							JSONObject job = json.getJSONObject(i); // 遍历
																	// jsonarray
																	// 数组，把每一个对象转成
																	// json 对象
							if (commoditySpecificationId == job.getInteger("id")) {
								sc.setReceivingGoodsNum(job.getInteger("num"));
								sc.setReceivingGoodsMoney(job.getDouble("money"));
							}
						}
					} else if (salesOpeningOrFoldloss == 2) {// 折损单
						// 遍历前台传过来的json数组 更改相应的商品的折损数量和折损金额
						for (int i = 0; i < json.size(); i++) {
							JSONObject job = json.getJSONObject(i); // 遍历
																	// jsonarray
																	// 数组，把每一个对象转成
																	// json 对象
							if (commoditySpecificationId == job.getInteger("id")) {
								sc.setDamageNum(job.getInteger("num"));
								sc.setDamageMoney(job.getDouble("money"));
							}
						}
					}

				}

				if (salesOrderCommodityService.insertBeatch(salesOrderCommodities)) {// 保存成功
					//首页提醒处理Start
					String menuName = "";
					switch (salesOpeningOrFoldloss) {
					case 1:
						menuName = "销售开单审核";
						break;
					case 2:
						menuName = "折损单审核";
						break;
					default:
						break;
					}
					messageService.addMessage(parentId, menuName);
					//首页提醒处理End

					// 往log表中插入操作数据
					insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(),
							GetSessionUtil.GetSessionUserIdentifier(request));

					rmsg.put("success", true);
					if (salesOpeningOrFoldloss == 1) {
						rmsg.put("msg", "已生成销售开单，请至销售开单页面查看详情！");
					} else if (salesOpeningOrFoldloss == 2) {
						rmsg.put("msg", "已生成折损单，请至折损单页面查看详情！");
					}

					return rmsg;
				} else {// 保存失败
						// 删除保存好的销售开单或折损单
					salesOrderService.deleteByPrimaryKey(salesOrder.getId());
					// 修改出库单的状态为原本状态
					s.setState(state);
					salesOrderService.updateByPrimaryKeySelective(s);
				}

			} else {// 生成销售开单失败
					// 修改出库单的状态为原本状态
				s.setState(state);
				salesOrderService.updateByPrimaryKeySelective(s);
			}

		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败！");
		return rmsg;

	}

	/**
	 * 销售订单审批通过
	 * 
	 * @param request
	 * @param ids
	 * @param flag 1:销售订单审批通过  2:其他发货单财务审批通过
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "orderApprovePass", method = RequestMethod.POST)
	public JSONObject orderApprovePass(HttpServletRequest request, String[] ids,int flag) throws Exception {
		JSONObject rmsg = new JSONObject();

		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}

		List<SalesOrder> salesOrders = salesOrderService.getSalesOrderByIds(list);

		// 如果是经过分单步骤的，需要把原始单据给删除。
		List<String> deleteIdentifier = new ArrayList<>();
		//操作成功的销售订单id列表
		List<Integer> updateSuccessOrderIds = new ArrayList<>();

		SalesOrder salesOrder;
		int updateSuccessNum = 0;
		List<String> operateObjects = new ArrayList<>();
		for (SalesOrder so : salesOrders) {
			// 说明是经过分单的
			if (so.getBreakCode() != null && !"".equals(so.getBreakCode())) {
				boolean falg = true;
				for (String identifier : deleteIdentifier) {
					if (identifier.equals(so.getIdentifier())) {
						falg = false;
						break;
					}
				}
				if (falg) {
					deleteIdentifier.add(so.getIdentifier());
				}

			}

			salesOrder = new SalesOrder();
			salesOrder.setId(so.getId());
			if(flag == 2) {
				so.setState(5);
				salesOrder.setParentId(0);// 修改其父id为0
				salesOrder.setState(5);
			}else{
				if (so.getPayment()!=null && so.getPayment() == 1) {
					so.setState(4);
					salesOrder.setParentId(0);// 修改其父id为0
					salesOrder.setState(4);
					
				} else {
					so.setState(5);
					salesOrder.setParentId(0);
					salesOrder.setState(5);
					
				}
			}
			
			if (salesOrderService.updateByPrimaryKeySelective(salesOrder) > 0) {
				updateSuccessNum++;
				operateObjects.add(so.getIdentifier());
				updateSuccessOrderIds.add(so.getId());
				if(flag == 2) {
					//插入消息列表
					messageService.addMessage(so.getId(), "其他发货单引用");
				}else {
					if(salesOrder.getState()==4){
						//插入消息列表
						messageService.addMessage(so.getId(), "预付款");
					}
					else{
						//插入消息列表
						messageService.addMessage(so.getId(), "销售订单引用");
					}
				}
				
			}
		}
		// 若有需要删除的原单据
		if (deleteIdentifier.size() > 0) {
			// 根据单据编号查询是否是所有分过单的单据都已经经过审核，若没有，则不能删除，若都经过审核，则需要删除。
			List<SalesOrder> shouldDelId = salesOrderService.selectIdByIdentifierAndState(deleteIdentifier);
			List<String> noDeleteOrder = new ArrayList<>();
			// 查出不需要删除的单据编号
			if (shouldDelId != null && shouldDelId.size() > 0) {
				for (int i = 0; i < shouldDelId.size(); i++) {
					if (shouldDelId.get(i).getState() <= 3||shouldDelId.get(i).getState() == 36) {
						boolean falg = true;
						for (String identifier : noDeleteOrder) {
							if (identifier.equals(shouldDelId.get(i).getIdentifier())) {
								falg = false;
								break;
							}
						}
						if (falg) {
							noDeleteOrder.add(shouldDelId.get(i).getIdentifier());
						}

					}
				}
			}
			// 移除
			if (noDeleteOrder.size() > 0) {
				for (int h = 0; h < deleteIdentifier.size(); h++) {
					for (String identifier : noDeleteOrder) {
						if (deleteIdentifier.get(h).equals(identifier)) {
							deleteIdentifier.remove(h);
							h--;
							break;
						}
					}

				}

			}
			if (deleteIdentifier != null && deleteIdentifier.size() > 0) {
				 List<SalesOrder> shouldDelOrder =salesOrderService.selectIdByIdentifierAndIsNoShow(deleteIdentifier);
				// 执行删除
				salesOrderService.deleteBatchByPrimaryKey(shouldDelOrder);
				salesOrderCommodityService.deleteBatchMsgBySalesOrderId(shouldDelOrder);
				salesOrderReviewerService.deleteFromSalesOrderIds(shouldDelOrder);
			}

		}
		if (updateSuccessNum > 0 && salesOrders.size() == updateSuccessNum) {

			// 销售订单审核表处理
			SalesOrderReviewer salesOrderReviewer = new SalesOrderReviewer();
			int operatorId = GetSessionUtil.GetSessionUserId(request);
			salesOrderReviewer.setReviewerId(operatorId);// 审批人id
			salesOrderReviewer.setReviewerType(1);// 订单审批
			for (int i = 0; i < list.size(); i++) {
				// 销售订单id
				salesOrderReviewer.setSalesOrderId(list.get(i));
				// 根据销售订单id和审批类型获取信息 有记录：修改 没有记录：插入
				SalesOrderReviewer salesOrderReviewer1 = salesOrderReviewerService
						.selectBySalesOrderIdAndReviewerType(salesOrderReviewer);
				if (salesOrderReviewer1 != null) {
					salesOrderReviewer1.setReviewerId(operatorId);
					salesOrderReviewerService.updateByPrimaryKeySelective(salesOrderReviewer1);
				} else {
					salesOrderReviewerService.insert(salesOrderReviewer);
				}

			}

			// 插入日志

			// 操作对象
			String operateObject = "";
			for (int i = 0; i < operateObjects.size(); i++) {
				operateObject += salesOrders.get(i).getIdentifier();
				if (i < salesOrders.size() - 1) {
					operateObject += ",";
				}
			}

			insertLog(Constants.TYPE_LOG_CHECK, operateObject, Constants.OPERATE_UPDATE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			return rmsg;
		} else if (updateSuccessNum > 0 && salesOrders.size() > updateSuccessNum) {
			// 插入日志

			// 操作对象
			String operateObject = "";
			for (int i = 0; i < operateObjects.size(); i++) {
				operateObject += salesOrders.get(i).getIdentifier();
				if (i < salesOrders.size() - 1) {
					operateObject += ",";
				}
			}

			// 销售订单审核表处理
			SalesOrderReviewer salesOrderReviewer = new SalesOrderReviewer();
			int operatorId = GetSessionUtil.GetSessionUserId(request);
			salesOrderReviewer.setReviewerId(operatorId);// 审批人id
			salesOrderReviewer.setReviewerType(1);// 订单审批
			for (int i = 0; i < updateSuccessOrderIds.size(); i++) {
				// 销售订单id
				salesOrderReviewer.setSalesOrderId(updateSuccessOrderIds.get(i));
				// 根据销售订单id和审批类型获取信息 有记录：修改 没有记录：插入
				SalesOrderReviewer salesOrderReviewer1 = salesOrderReviewerService
						.selectBySalesOrderIdAndReviewerType(salesOrderReviewer);
				if (salesOrderReviewer1 != null) {
					salesOrderReviewer1.setReviewerId(operatorId);
					salesOrderReviewerService.updateByPrimaryKeySelective(salesOrderReviewer1);
				} else {
					salesOrderReviewerService.insert(salesOrderReviewer);
				}

			}

			insertLog(Constants.TYPE_LOG_CHECK, operateObject, Constants.OPERATE_UPDATE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", "部分操作成功。");
			return rmsg;
		} else {
			rmsg.put("success", false);
			rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
			return rmsg;
		}

	}

	/**
	 * 销售订单审批驳回
	 * 
	 * @param request
	 * @param ids
	 * @param flag 1:销售订单审核驳回  2:其他发货单审核驳回
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "orderApproveReject", method = RequestMethod.GET)
	public JSONObject orderApproveReject(HttpServletRequest request, String[] ids,int flag) throws Exception {
		JSONObject rmsg = new JSONObject();

		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}

		// 审批驳回的订单需找到其所属的父订单，删除拆单后的单据，还是经过拆单前的全部单据。
		List<SalesOrder> salesOrderIdAndParentIds = salesOrderService.selectParentIdByPrimaryKey(list);
		// 循环遍历找到需要删除的经过拆单的销售订单id，保存其对应的parentId并进行去重
		List<SalesOrder> shouldDelIds = new ArrayList<>();
		List<Integer> shouldupdateIds = new ArrayList<>();
		List<String> deleteIdentifier = new ArrayList<>();// 分过单的单据，只要驳回一个，所有的都要进行删除
		SalesOrder salesOrder;
		for (SalesOrder so : salesOrderIdAndParentIds) {
			// 说明是经过分单的单据，需要删除分单之后的数据，修改分单前的数据状态为显示
			if (so.getParentId() != 0) {
				// 需要删除的经过分单之后的订单id
				//salesOrder = new SalesOrder();
				//salesOrder.setId(so.getId());
				// shouldDelIds.add(salesOrder);
				// 保存需要修改的父id 并去重
				boolean falg = true;
				for (Integer pId : shouldupdateIds) {
					if (pId == so.getParentId()) {
						falg = false;
						break;
					}
				}
				if (falg) {
					shouldupdateIds.add(so.getParentId());
				}

				falg = true;
				for (String identifier : deleteIdentifier) {
					if (identifier.equals(so.getIdentifier())) {
						falg = false;
						break;
					}
				}
				if (falg) {
					deleteIdentifier.add(so.getIdentifier());
				}

			}
			// 没有经过分单，直接可以修改状态
			else {
				// 去重
				boolean falg = true;
				for (Integer id : shouldupdateIds) {
					if (id == so.getId()) {
						falg = false;
						break;
					}
				}
				if (falg) {
					shouldupdateIds.add(so.getId());
				}
				// shouldupdateIds.add(so.getId());
			}
		}

		// 修改需要修改的销售订单的状态为3--销售订单驳回 ，以及修改显示状态为2---显示
		if (shouldupdateIds.size() > 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ids", shouldupdateIds);
			map.put("state", 3);
			map.put("isShow", 2);
			salesOrderService.updateStateAndIsShowByIds(map);
			//插入消息列表
			if(flag == 2){
				messageService.addMessageBath(shouldupdateIds, "其他发货单");
			}else {
				messageService.addMessageBath(shouldupdateIds, "销售订单");
			}
			

			// 删除需要删除的数据
			/*
			 * if (shouldDelIds.size() > 0) {
			 * salesOrderService.deleteBatchByPrimaryKey(shouldDelIds);
			 * salesOrderCommodityService.deleteBatchMsgBySalesOrderId(
			 * shouldDelIds); }
			 */

			// 分过单的单据，只要驳回一个，所有的都要进行删除
			if (deleteIdentifier.size() > 0) {
				List<SalesOrder> shouldDelId = salesOrderService.selectIdByIdentifierAndState(deleteIdentifier);
				if (shouldDelId != null && shouldDelId.size() > 0) {
					salesOrderService.deleteBatchByPrimaryKey(shouldDelId);
					salesOrderCommodityService.deleteBatchMsgBySalesOrderId(shouldDelId);
					for(SalesOrder so:shouldDelId){
						//删除过期的信息提醒
						messageService.clearMessage(so.getId(), 5);
					}
				}
			}

			// 销售订单审核表处理
			SalesOrderReviewer salesOrderReviewer = new SalesOrderReviewer();
			int operatorId = GetSessionUtil.GetSessionUserId(request);
			salesOrderReviewer.setReviewerId(operatorId);// 审批人id
			salesOrderReviewer.setReviewerType(1);// 订单审批
			for (int i = 0; i < shouldupdateIds.size(); i++) {
				// 销售订单id
				salesOrderReviewer.setSalesOrderId(shouldupdateIds.get(i));
				// 根据销售订单id和审批类型获取信息 有记录：修改 没有记录：插入
				SalesOrderReviewer salesOrderReviewer1 = salesOrderReviewerService
						.selectBySalesOrderIdAndReviewerType(salesOrderReviewer);
				if (salesOrderReviewer1 != null) {
					salesOrderReviewer1.setReviewerId(operatorId);
					salesOrderReviewerService.updateByPrimaryKeySelective(salesOrderReviewer1);
				} else {
					salesOrderReviewerService.insert(salesOrderReviewer);
				}

			}

			// 插入日志
			// 保存操作的对象编号
			List<SalesOrder> salesOrders = salesOrderService.getSalesOrderByIds((ArrayList<Integer>)shouldupdateIds);
	
			// 操作对象
			String operateObject = "";
			for (int i = 0; i < salesOrders.size(); i++) {
				operateObject += salesOrders.get(i).getIdentifier();
				if (i < salesOrders.size() - 1) {
					operateObject += ",";
				}
			}

			insertLog(Constants.TYPE_LOG_CHECK, operateObject, Constants.OPERATE_UPDATE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			return rmsg;
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * app销售退货操作入库
	 * @param request
	 * @param id
	 * @param misOrderId
	 * @param identifier
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateAPPReturnSalesOrderStateByIds", method = RequestMethod.POST)
	public JSONObject updateAPPReturnSalesOrderStateByIds(HttpServletRequest request, Integer id, Integer misOrderId,String identifier) throws Exception {
		JSONObject rmsg = new JSONObject();
		SalesOrder salesOrder=new SalesOrder();
		salesOrder.setId(id);
		salesOrder.setState(31);
		salesOrder.setIsReturnGoods(3);
		//修改退货单的状态
		if (salesOrderService.updateByPrimaryKeySelective(salesOrder)>0) {
			//如果状态为31，说明是销售退货入库，需要增加商品的库存		
			
			int commoditySpecificationId;
			int number;
			Inventory inventory ;
			
			//获取每个销售退货单下的销售退货商品列表
			List<SalesOrderCommodity> salesOrderCommodities = salesOrderCommodityService.selectMsgBySalesOrderId(id);
			for (SalesOrderCommodity sc : salesOrderCommodities) {//遍历退货商品列表 修改该商品的库存
				commoditySpecificationId = sc.getCommoditySpecificationId();//获取需要修改库存的商品规格id
				number = sc.getReturnGoodsNum();//获取商品的退货数量
				//修改库存
				inventory = new Inventory();
				inventory.setSpecificationId(commoditySpecificationId);
				inventory.setInventory(number);
				inventoryService.updateAddGoodsInventoryBySpecificationId(inventory);
			}	
			
			//修改app销售订单和发货单的相关状态
			salesOrder=new SalesOrder();
			salesOrder.setMissOrderId(misOrderId);
			salesOrder.setIsReturnGoods(3);//已退货入库
			salesOrderService.updateByMisOrderIdSelective(salesOrder);	
			
			//清空消息
			messageService.clearMessage(id, 5);
			
			// 插入日志
			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			insertLog(operateType, identifier, Constants.OPERATE_UPDATE, new Date(), operatorIdentifier);
			rmsg.put("success", true);
			rmsg.put("msg", "操作成功!");
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败，请确认后重新操作！");
		return rmsg;
	}

	/**
	 * 根据父id以及订单类型查询信息 注：orderType == 1时 parentId禁止传0 (因为单据类型为1(销售订单)
	 * parentId==0有多个单据)
	 * 
	 * @param request
	 * @param orderType
	 *            单据类型
	 * @param parentId
	 *            父id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectMsgByParentIdAndOrderType", method = RequestMethod.GET)
	public SalesOrder selectMsgByParentIdAndOrderType(HttpServletRequest request, Integer orderType, Integer parentId)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("parentId", parentId);
		return salesOrderService.selectMsgByParentIdAndOrderType(map);
	}

	/**
	 * 申请修改销售开单成功后------编辑销售开单的提交
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/updateSalesOpening", method = RequestMethod.POST)
	public JSONObject updateSalesOpening(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		String menuName="销售开单审核";
		// 获取ajax传递过来的参数
		String so = request.getParameter("salesOpening");
		// 将json格式的字符串转换成JSONObject 对象
		JSONObject jsonobject = JSONObject.parseObject(so);
		Integer salesOpeningId = jsonobject.getInteger("salesOpeningId");// 销售开单id
		Integer idsalesOpeningState = jsonobject.getInteger("idsalesOpeningState");// 销售开单状态
		Integer foldLossOrderId = jsonobject.getInteger("foldLossOrderId");// 折损单id
		Integer returnListOrderId = jsonobject.getInteger("returnListOrderId");// 返货单id
		Integer foldLossOrderIsUpdate = jsonobject.getInteger("foldLossOrderIsUpdate");// 折损单
																						// 1:没修改
																						// 2：修改
		Integer returnListOrderIsUpdate = jsonobject.getInteger("returnListOrderIsUpdate");// 返货单
																							// 1:没修改
																							// 2：修改
		Integer foldLossOrderState = jsonobject.getInteger("foldLossOrderState");// 折损单状态
		Integer returnListOrderIdState = jsonobject.getInteger("returnListOrderIdState");// 返货单状态

		JSONArray foldLossOrder = jsonobject.getJSONArray("foldLossOrder");// 折损信息
		JSONArray returnListOrder = jsonobject.getJSONArray("returnListOrder");// 返货信息

		SalesOrder updateSalesOrderState = new SalesOrder();
		updateSalesOrderState.setId(salesOpeningId);
		// 获取添加好的销售开单信息
		SalesOrder salesOpening = salesOrderService.selectByPrimaryKey(salesOpeningId);

		Integer updateOrSavefoldLossOrderId = 0;
		Integer foldLossOrderIsUpdateOrSave = 0;// 折损单是修改还是新增 1：新增 2：修改
		// 修改了折损单
		if (foldLossOrderIsUpdate == 2) {
			// 销售开单的状态要改为22 ---- 销售开单折损单待审核
			updateSalesOrderState.setState(22);
			if (salesOrderService.updateByPrimaryKeySelective(updateSalesOrderState) > 0) {
				// 折损单不存在，要生成一张折损单，折损单的状态为22，修改折损单的折损金额以及折损数量
				if (foldLossOrderId == 0) {
					salesOpening.setState(22);
					String maxIdentifier = salesOrderService.selectMaxIdentifier();
					salesOpening.setOrderType(4);// 单据类型为折损单
					String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
					salesOpening.setIdentifier(identifier);// 生成编号
					salesOpening.setId(null);
					salesOpening.setCreateTime(new Date());
					salesOpening.setOriginator(GetSessionUtil.GetSessionUserIdentifier(request));
					// 添加折损单
					if (salesOrderService.insertSelective(salesOpening) > 0) {
						// 获取添加好的销售订单对应的销售商品信息
						List<SalesOrderCommodity> salesOpeningCommodities = salesOrderCommodityService
								.selectMsgBySalesOrderId(salesOpeningId);
						for (SalesOrderCommodity sc : salesOpeningCommodities) {
							sc.setSalesOrderId(salesOpening.getId());
							for (int i = 0; i < foldLossOrder.size(); i++) {
								JSONObject foldLossMsg = foldLossOrder.getJSONObject(i);
								if (foldLossMsg.getInteger("goodsspecId") .equals(sc.getCommoditySpecificationId()) ) {
									sc.setDamageMoney(foldLossMsg.getDouble("foldLossMoney"));
									sc.setDamageNum(foldLossMsg.getInteger("foldLossNum"));
									sc.setReceivingGoodsNum(null);
									sc.setReceivingGoodsMoney(null);
								}
							}

						}
						// 保存成功
						if (salesOrderCommodityService.insertBeatch(salesOpeningCommodities)) {
							updateOrSavefoldLossOrderId = salesOpening.getId();
							foldLossOrderIsUpdateOrSave = 1;
							// 往log表中插入操作数据
							insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(),
									GetSessionUtil.GetSessionUserIdentifier(request));
							insertLog(operateType, salesOpening.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
									GetSessionUtil.GetSessionUserIdentifier(request));

						}
						// 保存失败
						else {
							// 删除保存好的折损单
							salesOrderService.deleteByPrimaryKey(salesOpening.getId());
							// 修改销售订单的状态为原来的状态
							updateSalesOrderState.setState(idsalesOpeningState);
							salesOrderService.updateByPrimaryKeySelective(updateSalesOrderState);
							rmsg.put("success", false);
							rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
							return rmsg;
						}

					}
					// 生成折损单失败
					else {
						// 修改销售订单的状态为原来的状态
						updateSalesOrderState.setState(idsalesOpeningState);
						salesOrderService.updateByPrimaryKeySelective(updateSalesOrderState);
						rmsg.put("success", false);
						rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
						return rmsg;
					}
				}
				// 折损单存在，则直接修改折损单的状态为22，修改折损单的折损金额以及折损数量
				else {
					SalesOrder updateFoldLossOrderState = new SalesOrder();
					updateFoldLossOrderState.setId(foldLossOrderId);
					updateFoldLossOrderState.setState(22);

					// 更新折损单状态失败
					if (salesOrderService.updateByPrimaryKeySelective(updateFoldLossOrderState) <= 0) {
						// 修改销售订单的状态为原来的状态
						updateSalesOrderState.setState(idsalesOpeningState);
						salesOrderService.updateByPrimaryKeySelective(updateSalesOrderState);
						rmsg.put("success", false);
						rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
						return rmsg;
					}
					// 更新成功
					else {

						SalesOrderCommodity commodity;

						for (int i = 0; i < foldLossOrder.size(); i++) {
							commodity = new SalesOrderCommodity();
							JSONObject foldLossMsg = foldLossOrder.getJSONObject(i);
							commodity.setId(foldLossMsg.getInteger("socId"));
							commodity.setDamageMoney(foldLossMsg.getDouble("foldLossMoney"));
							commodity.setDamageNum(foldLossMsg.getInteger("foldLossNum"));
							salesOrderCommodityService.updateByPrimaryKeySelective(commodity);
						}

						updateOrSavefoldLossOrderId = foldLossOrderId;
						foldLossOrderIsUpdateOrSave = 2;
						
						// 往log表中插入操作数据
						insertLog(operateType,
								"(" + salesOrderService.selectByPrimaryKey(foldLossOrderId).getIdentifier()+"," + salesOpening.getIdentifier() + ")",
								Constants.OPERATE_UPDATE, new Date(), GetSessionUtil.GetSessionUserIdentifier(request));

					}
				}
				menuName = "折损单审核";
			}
			// 修改销售开单状态 失败
			else {
				rmsg.put("success", false);
				rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
				return rmsg;
			}

		}
		// 没有修改折损单
		else {
			// 销售开单的状态改为13 ---- 销售开单待审核
			updateSalesOrderState.setState(13);
			
			// 修改销售开单状态 失败
			if (salesOrderService.updateByPrimaryKeySelective(updateSalesOrderState) <= 0) {
				rmsg.put("success", false);
				rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
				return rmsg;
			} // 更新成功
			else {
				// 往log表中插入操作数据
				insertLog(operateType, salesOpening.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));
			}

		}

		// 判断是否修改了返货单 没修改的话不用做任何操作
		// 修改了
		if (returnListOrderIsUpdate == 2) {
			// 返货单不存在，则新增返货单
			if (returnListOrderId == 0) {
				String maxIdentifier = salesOrderService.selectMaxIdentifier();
				salesOpening.setOrderType(5);// 单据类型为返货单
				String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
				salesOpening.setIdentifier(identifier);// 生成编号
				salesOpening.setId(null);
				salesOpening.setCreateTime(new Date());
				salesOpening.setOriginator(GetSessionUtil.GetSessionUserIdentifier(request));
				// 添加返货单
				if (salesOrderService.insertSelective(salesOpening) > 0) {
					// 获取添加好的销售订单对应的销售商品信息
					List<SalesOrderCommodity> salesOpeningCommodities = salesOrderCommodityService
							.selectMsgBySalesOrderId(salesOpeningId);
					for (SalesOrderCommodity sc : salesOpeningCommodities) {
						sc.setSalesOrderId(salesOpening.getId());
						for (int i = 0; i < returnListOrder.size(); i++) {
							JSONObject returnList = returnListOrder.getJSONObject(i);
							if (returnList.getInteger("goodsspecId") .equals(sc.getCommoditySpecificationId()) ) {
								sc.setReturnGoodsNum(returnList.getInteger("returnListNum"));
							}
						}
					}
					// 保存成功
					if (salesOrderCommodityService.insertBeatch(salesOpeningCommodities)) {
						for (SalesOrderCommodity sc : salesOpeningCommodities) {
							sc.setSalesOrderId(salesOpening.getId());
							//修改库存信息  直接加库存
							Inventory inventory = new Inventory();
							inventory.setSpecificationId(sc.getCommoditySpecificationId());
							inventory.setWarehouseId(sc.getWarehouseId());
							inventory.setInventory(sc.getReturnGoodsNum());
							inventoryService.updateAddGoodsInventory(inventory);	
						}
						
						
						// 往log表中插入操作数据
						insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(),
								GetSessionUtil.GetSessionUserIdentifier(request));
					}
					// 保存失败
					else {
						// 折损单有添加或更改，则需改回原来的状态
						if (updateOrSavefoldLossOrderId > 0) {
							// 新增，则直接删除
							if (foldLossOrderIsUpdateOrSave == 1) {
								salesOrderService.deleteByPrimaryKey(updateOrSavefoldLossOrderId);
								salesOrderCommodityService.deleteMsgBySalesOrderId(updateOrSavefoldLossOrderId);
							}
							// 修改 则改回原状态
							else {
								SalesOrder updateFoldLossOrderState = new SalesOrder();
								updateFoldLossOrderState.setId(foldLossOrderId);
								updateFoldLossOrderState.setState(foldLossOrderState);
								salesOrderService.updateByPrimaryKeySelective(updateFoldLossOrderState);
							}
						}
						// 删除之前保存好的返货单id
						salesOrderService.deleteByPrimaryKey(salesOpening.getId());
						// 修改销售订单的状态为原来的状态
						updateSalesOrderState.setState(idsalesOpeningState);
						salesOrderService.updateByPrimaryKeySelective(updateSalesOrderState);
						rmsg.put("success", false);
						rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
						return rmsg;
					}

				}
				// 生成返货单失败
				else {
					// 折损单有添加或更改，则需改回原来的状态
					if (updateOrSavefoldLossOrderId > 0) {
						// 新增，则直接删除
						if (foldLossOrderIsUpdateOrSave == 1) {
							salesOrderService.deleteByPrimaryKey(updateOrSavefoldLossOrderId);
							salesOrderCommodityService.deleteMsgBySalesOrderId(updateOrSavefoldLossOrderId);
						}
						// 修改 则改回原状态
						else {
							SalesOrder updateFoldLossOrderState = new SalesOrder();
							updateFoldLossOrderState.setId(foldLossOrderId);
							updateFoldLossOrderState.setState(foldLossOrderState);
							salesOrderService.updateByPrimaryKeySelective(updateFoldLossOrderState);
						}
					}
					// 修改销售订单的状态为原来的状态
					updateSalesOrderState.setState(idsalesOpeningState);
					salesOrderService.updateByPrimaryKeySelective(updateSalesOrderState);
					rmsg.put("success", false);
					rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
					return rmsg;
				}
			}
			// 返货单存在，则修改返货单的返货数量
			else {
				SalesOrderCommodity returnListOrderCommodity;
				for (int i = 0; i < returnListOrder.size(); i++) {
					returnListOrderCommodity = new SalesOrderCommodity();
					JSONObject returnList = returnListOrder.getJSONObject(i);
					returnListOrderCommodity.setId(returnList.getInteger("socId"));
					returnListOrderCommodity.setReturnGoodsNum(returnList.getInteger("returnListNum"));
					salesOrderCommodityService.updateByPrimaryKeySelective(returnListOrderCommodity);
					
					//修改库存信息  直接加库存
					Inventory inventory = new Inventory();
					inventory.setSpecificationId(returnList.getInteger("goodsspecId"));
					inventory.setWarehouseId(returnList.getInteger("wareHouseId"));
					int oldReturnGoodsNum=0;
					if(returnList.getInteger("oldReturnListNum")!=null&&returnList.getInteger("oldReturnListNum")>=0){
						oldReturnGoodsNum=returnList.getInteger("oldReturnListNum");
					}
					else{
						oldReturnGoodsNum=0;
					}
					
					inventory.setInventory(returnList.getInteger("returnListNum")-oldReturnGoodsNum);
					inventoryService.updateAddGoodsInventory(inventory);	
				}
				// 往log表中插入操作数据
				insertLog(operateType, salesOrderService.selectByPrimaryKey(returnListOrderId).getIdentifier(),
						Constants.OPERATE_UPDATE, new Date(), GetSessionUtil.GetSessionUserIdentifier(request));

			}

		}
		//首页提醒处理Start
		int serviceId = salesOrderService.selectByPrimaryKey(salesOpeningId).getParentId();
		messageService.addMessage(serviceId, menuName);
		//首页提醒处理End
		
		
		rmsg.put("success", true);
		rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
		return rmsg;
	}

	/**
	 * 获取销售开单详情
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "selectSalesOpeningDetailById")
	public SalesOrder selectSalesOpeningDetailById(HttpServletRequest request, Integer id) {

		return salesOrderService.getSalesOpeningDetailById(id);
	}

	/**
	 * 根据仓库id以及商品id修改该商品的库存数量及占用数量
	 * 
	 * @param inventory
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "updateInventoryDown", method = RequestMethod.POST)
	public JSONObject updateInventoryDown(HttpServletRequest request, Integer saleOrderId, Integer parentId)
			throws Exception {
		JSONObject rmsg = new JSONObject();
		Inventory inventory = null;
		SalesOrder salesOrder = salesOrderService.selectOrderDetailById(saleOrderId);
		List<SalesOrderCommodity> list = salesOrder.getSalesOrderCommodities();
		// System.out.println("商品集合数量》》》》" + list.size());

		SalesOrder s = new SalesOrder();
		s.setId(parentId);
		s.setState(12);
		salesOrderService.updateByPrimaryKeySelective(s);
		Boolean flag;
		for (int i = 0; i < list.size(); i++) {
			inventory = new Inventory();
			inventory.setSpecificationId(list.get(i).getCommoditySpecificationId());
			inventory.setWarehouseId(list.get(i).getWarehouseId());
			inventory.setInventory(list.get(i).getDeliverGoodsNum());
			inventory.setOccupiedInventory(list.get(i).getDeliverGoodsNum());
			flag = inventoryService.updateInventoryDown(inventory);
			//System.out.println(flag);
			if (flag) {
				rmsg.put("success", true);
				rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			} else {
				rmsg.put("success", false);
				rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
			}
		}
		return rmsg;
	}

	/**
	 * 生成返货单
	 * @param request
	 * @param returnCommodity
	 * @param soId
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "createReturnOrder", method = RequestMethod.GET)
	public JSONObject createReturnOrder(HttpServletRequest request, String returnCommodity, int soId) throws Exception {
		JSONObject rmsg = new JSONObject();
		JSONArray json = JSONArray.parseArray(returnCommodity);
		SalesOrder s = new SalesOrder();
		s.setId(soId);
		s.setState(12);
		SalesOrder salesOrder = salesOrderService.selectByPrimaryKey(soId);
		String maxIdentifier = salesOrderService.selectMaxIdentifier();
		salesOrder.setOrderType(5);
		String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
		salesOrder.setIdentifier(identifier);
		salesOrder.setId(null);
		salesOrder.setBreakCode(null);//返货单没有拆单码
		salesOrder.setParentId(soId);
		salesOrder.setCreateTime(new Date());
		salesOrder.setOriginator(GetSessionUtil.GetSessionUserIdentifier(request));
		salesOrder.setPrintNum(0);//设置打印次数为0
		Inventory inventory = null;
		
		if (salesOrderService.insertSelective(salesOrder) > 0) {
			List<SalesOrderCommodity> salesOrderCommodities = salesOrderCommodityService.selectMsgBySalesOrderId(soId);
			System.out.println(salesOrderCommodities.size());
			for(int i=0;i<salesOrderCommodities.size();i++) {
				salesOrderCommodities.get(i).setSalesOrderId(salesOrder.getId());
				int commoditySpecificationId = salesOrderCommodities.get(i).getCommoditySpecificationId();
				// 遍历前台传过来的json
				
					if(i<json.size()) {
						JSONObject job = json.getJSONObject(i); // 遍历 jsonarray
						if (commoditySpecificationId == job.getInteger("commoditySpecificationId")) {
							salesOrderCommodities.get(i).setReturnGoodsNum(job.getInteger("num"));
							//System.out.println(sc.getReceivingGoodsNum()+">>>>"+sc.getUnitPrice());
							salesOrderCommodities.get(i).setDeliverGoodsMoney(salesOrderCommodities.get(i).getReturnGoodsNum()*salesOrderCommodities.get(i).getUnitPrice());
						} // 数组，把每一个对象转成
					}else {
						salesOrderCommodities.get(i).setReturnGoodsNum(0);
						salesOrderCommodities.get(i).setDeliverGoodsMoney(0*salesOrderCommodities.get(i).getUnitPrice());
					}
					
				
			}
			
//			for (SalesOrderCommodity sc : salesOrderCommodities) {
//				sc.setSalesOrderId(salesOrder.getId());
//				int commoditySpecificationId = sc.getCommoditySpecificationId();
//				// 遍历前台传过来的json
//				for (int i = 0; i < json.size(); i++) {
//					JSONObject job = json.getJSONObject(i); // 遍历 jsonarray
//					if (commoditySpecificationId == job.getInteger("commoditySpecificationId")) {
//						sc.setReturnGoodsNum(job.getInteger("num"));
//						//System.out.println(sc.getReceivingGoodsNum()+">>>>"+sc.getUnitPrice());
//						sc.setDeliverGoodsMoney(sc.getReturnGoodsNum()*sc.getUnitPrice());
//					} // 数组，把每一个对象转成
//				}
//				
//			}
			if (salesOrderCommodityService.insertBeatch(salesOrderCommodities)) {
				insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));
				//返货单加库存
				for (int i = 0; i < json.size(); i++) {
					JSONObject job = json.getJSONObject(i); // 遍历 jsonarray
					inventory=new Inventory();
					inventory.setInventory(job.getInteger("num"));
					inventory.setWarehouseId(job.getInteger("warehouseId"));
					inventory.setSpecificationId(job.getInteger("commoditySpecificationId"));
				}
				rmsg.put("success", true);
				rmsg.put("msg", "已生成返货单,请到返货单页面查看");
				return rmsg;
			} else {
				salesOrderService.deleteByPrimaryKey(salesOrder.getId());
				salesOrderService.updateByPrimaryKeySelective(s);
			}
			
		}
		rmsg.put("success", false);
		rmsg.put("msg", "生成返货单失败！");
		return rmsg;
	}

	/**
	 * 引用出库单页面--修改折损单
	 * 
	 * @param request
	 * @param id
	 *            折损单id
	 * @param commodity
	 *            折损单相关 订单商品表的id、折损数量、折损金额
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/editFoldlossOrder", method = RequestMethod.GET)
	public JSONObject editFoldlossOrder(HttpServletRequest request, Integer foldlossId, Integer outboundOrderId,
			String identifier, String commodity) throws Exception {
		//System.out.println(foldlossId);
		//System.out.println(outboundOrderId);
		//System.out.println(identifier);

		JSONObject rmsg = new JSONObject();
		JSONArray json = JSONArray.parseArray(commodity); // 首先把字符串转成 JSONArray
															// 对象

		SalesOrderCommodity soc;
		int result2 = -1;
		for (int i = 0; i < json.size(); i++) {
			soc = new SalesOrderCommodity();
			JSONObject job = json.getJSONObject(i); // 遍历 jsonarray 数组，把每一个对象转成
													// json 对象
			soc.setId(job.getInteger("id"));
			soc.setDamageNum(job.getInteger("num"));
			soc.setDamageMoney(job.getDouble("money"));
			result2 = salesOrderCommodityService.updateByPrimaryKeySelective(soc);
			if (result2 <= 0) {// 此次更新没有成功
				rmsg.put("success", false);
				rmsg.put("msg", "操作失败");
				return rmsg;
			}
		}

		SalesOrder so = new SalesOrder();// 折损单对象
		so.setId(foldlossId);
		so.setState(19);// 折损单待审核
		salesOrderService.updateByPrimaryKeySelective(so);// 根据折损单id更改折损单的状态为待审核
		// 更改折损单相关的出库单的状态为折损单待审核
		SalesOrder salesOrder = new SalesOrder();// 出库单对象
		salesOrder.setId(outboundOrderId);
		salesOrder.setState(19);
		salesOrderService.updateByPrimaryKeySelective(salesOrder);
		
		//首页提醒处理Start
		int serviceId = salesOrderService.selectByPrimaryKey(foldlossId).getParentId();
		messageService.addMessage(serviceId, "折损单审核");
		//首页提醒处理End
		
		// 插入日志表
		insertLog(operateType, identifier, Constants.OPERATE_UPDATE, new Date(),
				GetSessionUtil.GetSessionUserIdentifier(request));

		rmsg.put("success", true);
		rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
		return rmsg;

	}
	
	
	
	
	
	
	
	
	/**
	 * 获取所有可以进行退货的销售订单（即：orderType=1  &  state = 12）
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getAllSalesOrderCanReturn")
	public List<SalesOrder> getAllSalesOrderCanReturn(HttpServletRequest request) {

		return salesOrderService.getAllSalesOrderCanReturn();
	}
	
	/**
	 * 获取app过来的销售订单中需要退货的订单
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "selectAppRturnGoodsSalesOrderMsg")
	public List<SalesOrder> selectAppRturnGoodsSalesOrderMsg(HttpServletRequest request) {

		return salesOrderService.selectAppRturnGoodsSalesOrderMsg();
	}
	
	/**
	 * 根据销售订单id获取该订单下的所有销售商品信息
	 * @param request
	 * @param salesOrderId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getSalesOrderCommodityBySalesOrderId")
	public List<SalesOrderCommodity> getSalesOrderCommodityBySalesOrderId(HttpServletRequest request,int salesOrderId) {
		
		return salesOrderCommodityService.getSalesOrderCommodityBySalesOrderId(salesOrderId);

	}
	/**
	 * 新增退货单
	 * @param request
	 * @param returnCommodity  退货商品信息
	 * @param salesOrderId  引用的销售订单的id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "addReturnOrder", method = RequestMethod.GET)
	public JSONObject addReturnOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		
		// 获取ajax传递过来的参数
		String so = request.getParameter("salesOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(so);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("salesOrderCommodities", SalesOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		SalesOrder salesOrder = (SalesOrder) net.sf.json.JSONObject.toBean(jsonobject, SalesOrder.class, map);
		
		String maxIdentifier = salesOrderService.selectMaxIdentifier();
		salesOrder.setOrderType(6);//设置订单类型为退货单
		String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
		salesOrder.setIdentifier(identifier);//生成编号
		salesOrder.setCreateTime(new Date());
		salesOrder.setOriginator(GetSessionUtil.GetSessionUserIdentifier(request));
		salesOrder.setBranch("总部");
		//app订单的退货不需要审核
		if(salesOrder.getIsAppOrder()!=null&&salesOrder.getIsAppOrder()==2){
			salesOrder.setState(30);//设置默认状态为“退货单审核通过”
			salesOrder.setIsReturnGoods(2);//已生成退货单
			
			//根据mis订单id修改订单的字段信息
			SalesOrder salesOrder2=new SalesOrder();
			salesOrder2.setMissOrderId(salesOrder.getMissOrderId());
			salesOrder2.setIsReturnGoods(2);//已生成退货单
			salesOrderService.updateByMisOrderIdSelective(salesOrder2);	
		}
		else{
			salesOrder.setState(27);//设置默认状态为“退货单未送审”
		}
			
		if (salesOrderService.insertSelective(salesOrder) > 0) {
			//添加退货商品信息
			for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
				soc.setSalesOrderId(salesOrder.getId());
			}
			if (salesOrderCommodityService.insertBeatch(salesOrder.getSalesOrderCommodities())) {
				if(salesOrder.getIsAppOrder()!=null&&salesOrder.getIsAppOrder()==2){
					messageService.addMessage(salesOrder.getId(), "销售退货入库");
				}
				//添加log日志
				insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));
				rmsg.put("success", true);
				rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
				return rmsg;
			} else {
				salesOrderService.deleteByPrimaryKey(salesOrder.getId());
				salesOrderCommodityService.deleteMsgBySalesOrderId(salesOrder.getId());
			}
			
		} 
		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 编辑退货单
	 * @param request
	 * @param returnCommodity  退货商品信息
	 * @param salesOrderId  引用的销售订单的id
	 * @param id 修改的退货单的id
	 * @param identifier 修改的退货单的编号
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "editReturnOrder", method = RequestMethod.GET)
	public JSONObject editReturnOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		
		// 获取ajax传递过来的参数
		String so = request.getParameter("salesOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(so);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("salesOrderCommodities", SalesOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		SalesOrder salesOrder = (SalesOrder) net.sf.json.JSONObject.toBean(jsonobject, SalesOrder.class, map);
		
		if (salesOrderService.updateByPrimaryKeySelective(salesOrder) > 0) {
			//删除原退货单下的所有商品
			salesOrderCommodityService.deleteMsgBySalesOrderId(salesOrder.getId());
			//添加退货商品信息
			for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
				soc.setSalesOrderId(salesOrder.getId());
			}
			// 批量插入退货商品
			salesOrderCommodityService.insertBeatch(salesOrder.getSalesOrderCommodities());
			// 往log表中插入操作数据
			insertLog(operateType, salesOrder.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));
			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
			
		} 
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 删除退货单
	 * @param id 退货单id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteReturnOrder", method = RequestMethod.POST)
	public JSONObject deleteReturnOrder(HttpServletRequest request, Integer id) throws Exception {
		JSONObject rmsg = new JSONObject();
		SalesOrder salesOrder = salesOrderService.selectByPrimaryKey(id);
		SalesOrder updateSalesOrder=new SalesOrder();
		updateSalesOrder.setId(id);
		updateSalesOrder.setState(37);
		if (salesOrderService.updateByPrimaryKeySelective(updateSalesOrder) > 0) {
			//salesOrderCommodityService.deleteMsgBySalesOrderId(id);//删除退货商品信息
			//List<SalesOrder> list = new ArrayList<>();
			//list.add(salesOrder);
			//salesOrderReviewerService.deleteFromSalesOrderIds(list);//删除退货审批人信息
			
			// 往log表中插入操作数据
			insertLog(operateType, salesOrder.getIdentifier(), Constants.OPERATE_DELETE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", Constants.DELE_SUCCESS_MSG);
			return rmsg;
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.DELE_FAILURE_MSG);
		return rmsg;
	}
	/**
	 * 打印退货单
	 * @param request
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/printReturnOrder")
	public JSONObject printReturnOrder(HttpServletRequest request, Integer id) throws Exception {
		return createReturnOrderJSON(salesOrderService.selectOrderDetailById(id));
	}
	
	/**
	 * 生成退货单单据打印页面所需的信息 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createReturnOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "销售退货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("销售退货单");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		if(salesOrder.getSupcto()!=null){
			head.setFieldValue(salesOrder.getSupcto().getName());
		}
		else{
			head.setFieldValue("");
		}
		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		if(salesOrder.getShippingMode()!=null){
			head.setFieldValue(salesOrder.getShippingMode().getName());
		}
		else{
			head.setFieldValue("");
		}
		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
		if(salesOrder.getEndValidityTime()!=null){
			head.setFieldValue(dateFormat.format(salesOrder.getEndValidityTime()));
		}
		else{
			head.setFieldValue("");
		}	
		heads.add(head);
	
		head = new FormHeadAndFooter();
		head.setFieldName("收货人");
		if(salesOrder.getConsignee()!=null){
			head.setFieldValue(salesOrder.getConsignee());
		}
		else{
			head.setFieldValue("");
		}	
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		if(salesOrder.getPhone()!=null){
			head.setFieldValue(salesOrder.getPhone());
		}
		else {
			head.setFieldValue("");
		}
		heads.add(head);
		
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "规格编码", "货品名称", "规格", "单位", "单价", "退货数量", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			Double price = soc.getUnitPrice();
			Integer returnNumber = soc.getReturnGoodsNum();
			Double money = price * returnNumber;
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), price + "",
					returnNumber + "", money + "" };
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += money;
			tbodys.add(tbody);
		}
		// tbody end
		// total
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalMoney);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员部门");
		footer.setFieldValue(salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator() + "(" + salesOrder.getPerson().getName() + ")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (salesOrder.getReviewerName() != "" && salesOrder.getReviewerIdentifier() != "") {
			footer.setFieldValue(salesOrder.getReviewerIdentifier() + "(" + salesOrder.getReviewerName() + ")");
		}else if(salesOrder.getReviewerName() != ""){
			footer.setFieldValue(salesOrder.getReviewerName());
		}else if(salesOrder.getReviewerIdentifier() != ""){
			footer.setFieldValue(salesOrder.getReviewerIdentifier());
		}else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	/**
	 * 打印APP退货单
	 * @param request
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/printAPPReturnOrder")
	public JSONObject printAPPReturnOrder(HttpServletRequest request, Integer id) throws Exception {
		return printAPPReturnOrderJSON(salesOrderService.selectOrderDetailById(id));
	}
	
	/**
	 * 生成APP退货单单据打印页面所需的信息 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject printAPPReturnOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "APP销售退货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("销售退货单");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("APP订单编号");
		head.setFieldValue(salesOrder.getAppOrderIdentifier());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
		head.setFieldValue(salesOrder.getOrderer());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		if(salesOrder.getPhone()!=null){
			head.setFieldValue(salesOrder.getPhone());
		}
		else {
			head.setFieldValue("");
		}
		heads.add(head);
		
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "规格编码", "货品名称", "规格", "单位", "单价", "退货数量", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			Double price = soc.getUnitPrice();
			Integer returnNumber = soc.getReturnGoodsNum();
			Double money = soc.getAppAmountMoney();
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), price + "",
					returnNumber + "", money + "" };
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += money;
			tbodys.add(tbody);
		}
		// tbody end
		// total
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalMoney);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator() + "(" + salesOrder.getPerson().getName() + ")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	
	
	/**
	 * 修改app订单的状态
	 * 
	 * @param salesOrder 订单信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping("updateAppOrderState")
	public JSONObject updateAppOrderState(HttpServletRequest request,Integer saleOrderId,Integer misId,Integer parentId,String identifier) {
		JSONObject rmsg=new JSONObject();
		Inventory inventory ;
		if (salesOrderService.updateStateByMisId(saleOrderId)) {
			salesOrderService.updateStateByParentId(parentId);
			List<CommoditySpecification> commoditySpecifications=commoditySpecificationService.getAppCommoditySpecificcationId(misId);
			for (CommoditySpecification commoditySpecification : commoditySpecifications) {
				//修改库存
				inventory = new Inventory();
				inventory.setOccupiedInventory(commoditySpecification.getNum());
				inventory.setWarehouseId(commoditySpecification.getCommodityId());
				inventory.setSpecificationId(commoditySpecification.getId());
				inventory.setInventory(commoditySpecification.getNum());
				//执行减库存操作
				inventoryService.updateInventoryDown(inventory);
			}
			Date date=new Date();
			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			try {
				insertLog(operateType, identifier, Constants.OPERATE_UPDATE, date, operatorIdentifier);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			rmsg.put("success",true);
			rmsg.put("msg", "发货成功");
		}else {
			rmsg.put("success",false);
			rmsg.put("msg", "操作失败");	
		}
		
		return rmsg;
	}
	/**
	 * 根据mis订单id修改销售订单/计划单送货地址
	 * 
	 * @param salesOrder 订单信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping("updateReceiverMsg")
	public Boolean updateReceiverMsg(SalesOrder salesOrder,SalesPlanOrder salesPlanOrder) {
		
		System.out.println(">>>>>>>>>>id"+salesOrder.getId());
		System.out.println(">>>>>>>>>address"+salesOrder.getReceiptGoodsPlace());
		salesPlanOrder.setMissOrderId(salesOrder.getMissOrderId());
		salesPlanOrder.setAppConsigneeName(salesOrder.getConsignee());
		salesPlanOrder.setAppConsigneePhone(salesOrder.getPhone());
		salesPlanOrder.setAppConsigneeAddress(salesOrder.getReceiptGoodsPlace());
		boolean  flg=salesOrderService.updateByMisOrderIdSelective(salesOrder);
		 salesPlanOrderService.updateByMisOrderIdSelective(salesPlanOrder);	
		
		return flg;
	}
	
	/**
	 * 根据父id查询订单的返货数量与折损数量
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getReturnAndDamageNum")
	public SalesOrder getReturnAndDamageNum(Integer parentId) {
		
		SalesOrder s1=salesOrderService.getReturnNum(parentId);
		SalesOrder s2=salesOrderService.getDamageNum(parentId);
		if (s1==null) {
			s1=s2;
		}
		try {
			if (s1!=null) {
				List<SalesOrderCommodity>	soc=s1.getSalesOrderCommodities();
				if (s2.getSalesOrderCommodities()!=null) {
					List<SalesOrderCommodity>	soc2=s2.getSalesOrderCommodities();
					if (soc2!=null) {
						
						for (int i = 0; i < soc.size(); i++) {
							if (soc2.get(i).getDamageNum()!=null) {
								
								soc.get(i).setDamageNum(soc2.get(i).getDamageNum());
							}else {
								soc.get(i).setDamageNum(0);
							}
							
						}
					}
				}	
				}else {
					
					List<SalesOrderCommodity>	soc=s1.getSalesOrderCommodities();
					//System.out.println(s1==null);
					if (s2.getSalesOrderCommodities()!=null) {
						List<SalesOrderCommodity>	soc2=s2.getSalesOrderCommodities();
						if (soc2!=null) {
							for (int i = 0; i < soc2.size(); i++) {
								if (soc2.get(i).getDamageNum()!=null) {
									soc.get(i).setDamageNum(soc2.get(i).getDamageNum());
								}else {
									soc.get(i).setDamageNum(0);
								}
								
							}
						}
					}	
				}
			
		}catch (Exception e) {
			// TODO: handle exception
		}
		
	return	s1;
	}
	
	
	/**
	 * 新增其他发货单 
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addOtherDeliveOrder", method = RequestMethod.POST)
	public JSONObject addOtherDeliveOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		
			// 获取ajax传递过来的参数
			String so = request.getParameter("salesOrder");
			// 将json格式的字符串转换成JSONObject 对象
			net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(so);
			Map<String, Class> map = new HashMap<String, Class>();
			map.put("salesOrderCommodities", SalesOrderCommodity.class); // key为teacher私有变量的属性名
			// 把JSON串转换成对象
			SalesOrder salesOrder = (SalesOrder) net.sf.json.JSONObject.toBean(jsonobject, SalesOrder.class, map);
			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			salesOrder.setOriginator(userIdentifier);
			Date date = new Date();
			salesOrder.setCreateTime(date);
			salesOrder.setParentId(0);
			String maxIdentifier = salesOrderService.selectMaxIdentifierToOtherDeliveOrder();
			
			// 生成编号
			String identifier = SundryCodeUtil.createInvoicesIdentifier("OO", maxIdentifier);
			int result = -1;
			salesOrder.setPayment(3);
			salesOrder.setOrderType(8);
			salesOrder.setIdentifier(identifier);
			salesOrder.setBranch("总部");
			salesOrder.setState(1);

			// 往数据库中根据id修改信息
			result = salesOrderService.insertSelective(salesOrder);

			if (result > 0) {
				for (SalesOrderCommodity sc : salesOrder.getSalesOrderCommodities()) {
					sc.setSalesOrderId(salesOrder.getId());
				}
				salesOrderCommodityService.insertBeatch(salesOrder.getSalesOrderCommodities());
				// 获取商品所属的仓库id以及商品信息
				List<Inventory> inventories = new ArrayList<>();
				Inventory inventory;
				for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
					if (soc.getWarehouseId() != null && soc.getWarehouseId() > 0) {
						inventory = new Inventory();
						inventory.setSpecificationId(soc.getCommoditySpecificationId());
						inventory.setWarehouseId(soc.getWarehouseId());
						inventory.setOccupiedInventory(soc.getDeliverGoodsNum());
						inventories.add(inventory);
					}
				}
				// 修改各个仓库的占用数量
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateOccupiedInventory(inv);
					}

				}

				// 往log表中插入操作数据
				insertLog(operateType, salesOrder.getIdentifier(), Constants.OPERATE_INSERT, new Date(),
						userIdentifier);

				rmsg.put("success", true);
				rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
				return rmsg;

			}
		
		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 生成其他发货单的出库单
	 * 
	 * @param request
	 * @param id
	 *            其他发货单id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/createOtherOutboundOrder")
	public JSONObject createOtherOutboundOrder(HttpServletRequest request, Integer id) throws Exception {
		JSONObject rmsg = new JSONObject();
		SalesOrder s = new SalesOrder();
		s.setState(11); //备货中
		s.setId(id);

		// 修改销售订单的状态为待备货
		if (salesOrderService.updateByPrimaryKeySelective(s) > 0) {
			// 获取添加好的销售订单信息
			SalesOrder salesOrder = salesOrderService.selectByPrimaryKey(id);
			String maxIdentifier = salesOrderService.selectMaxIdentifier();
			salesOrder.setOrderType(9);// 单据类型为其他发货单出库
			salesOrder.setState(11);// 状态改为备货中
			salesOrder.setParentId(id);
			String identifier = SundryCodeUtil.createInvoicesIdentifier("SO", maxIdentifier);
			salesOrder.setIdentifier(identifier);// 生成编号
			salesOrder.setId(null);
			salesOrder.setCreateTime(new Date());
			salesOrder.setOriginator(GetSessionUtil.GetSessionUserIdentifier(request));
			// 添加出库单
			if (salesOrderService.insertSelective(salesOrder) > 0) {
				// 获取添加好的销售订单对应的销售商品信息
				List<SalesOrderCommodity> salesOrderCommodities = salesOrderCommodityService
						.selectMsgBySalesOrderId(id);
				for (SalesOrderCommodity sc : salesOrderCommodities) {
					sc.setSalesOrderId(salesOrder.getId());
				}
				// 保存成功
				if (salesOrderCommodityService.insertBeatch(salesOrderCommodities)) {
					//首页提醒处理Start
					messageService.addMessage(id, "其他发货单出库单");
					//首页提醒处理End
					
					// 往log表中插入操作数据
					insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(),
							GetSessionUtil.GetSessionUserIdentifier(request));

					rmsg.put("success", true);
					rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
					rmsg.put("id", salesOrder.getId());
					// 生成出库单单据打印页面所需的信息 返回值为JSON格式
					rmsg.put("outboundOrderJSON", createOtherOutboundOrderJSON(salesOrderService.selectOrderDetailById(id)));
					return rmsg;
				}
				// 保存失败
				else {
					// 删除保存好的出库单
					salesOrderService.deleteByPrimaryKey(salesOrder.getId());
					// 修改销售订单的状态为待打印出库单
					s.setState(5);
					salesOrderService.updateByPrimaryKeySelective(s);
					rmsg.put("success", false);
					rmsg.put("msg", "生成出库单失败！");
					return rmsg;
				}

			}
			// 生成出库单失败
			else {
				// 修改销售订单的状态为待打印出库单
				s.setState(5);
				salesOrderService.updateByPrimaryKeySelective(s);
			}
		}

		rmsg.put("success", false);
		rmsg.put("msg", "生成出库单失败！");
		return rmsg;

	}
	/**
	 * 其他发货单作废领导审核  
	 * 
	 * @param request
	 * @param ids
	 *            id列表
	 * @param isCheck
	 *            是否是审核 0:否，1：是（决定是否 向销售订单审批人员表中加入/修改数据）
	 * @param reviewerType
	 *            审批类型（1：订单审核，2：作废销售领导审核，3：作废仓库审核，4：销售开单审核，5：申请修改审核，6：折损单审核）isCheck
	 *            == 0时请传0
	 * @param msg
	 *            操作成功后页面中弹出的消息提醒内容（如："操作成功，已通过"、"操作成功，已驳回"等）
	 * @param yesOrNo
	 *            审批通过还是拒绝 不需要用到此参数请传0 1：拒绝 2：通过
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateStateByIdsAndStateForOtherDeliverOrder", method = RequestMethod.POST)
	public JSONObject updateStateByIdsAndStateForOtherDeliverOrder(HttpServletRequest request, String[] ids, int isCheck, int reviewerType,
			String msg, int yesOrNo) throws Exception {
		JSONObject rmsg = new JSONObject();

		SalesOrder salesOrder, updateSalesOrder;
		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				int id = Integer.valueOf(ids[i]);
				list.add(id);
				// 根据id获取销售订单信息
				salesOrder = salesOrderService.selectByPrimaryKey(id);
				int state = salesOrder.getState();
				int afterState = -1;
				updateSalesOrder = new SalesOrder();

				switch (state) {
				case 6:// 只需销售领导审核的作废待审核
					if (yesOrNo == 1) {// 驳回
						afterState = 9;// 只需销售领导审核的作废审核驳回
					} else if (yesOrNo == 2) {// 通过
						afterState = 10;// 已作废
					}
					break;

				case 7:// 需仓库审核的作废审核之销售领导审核
					if (yesOrNo == 1) {// 驳回
						afterState = 25;// 需仓库审核的作废审核驳回
					} else if (yesOrNo == 2) {// 通过
						afterState = 8;// 仓库作废审核中
					}
					break;
				
				default:
					break;
				}
				updateSalesOrder.setId(id);
				updateSalesOrder.setState(afterState);
				if (salesOrderService.updateByPrimaryKeySelective(updateSalesOrder) <= 0) {
					rmsg.put("success", false);
					rmsg.put("msg", "操作失败，请确认后重新操作！");
					return rmsg;
				} else {// 更新成功
					
					//需仓库审核的作废审核驳回时，更改相应的出库单的状态为11(备货中)
					if(afterState == 25) {
						//获取相应的出库单
						ArrayList<Integer> parentIds = new ArrayList<Integer>();
						parentIds.add(id);
						Map<String, Object> map1 = new HashMap<String, Object>();
						map1.put("orderType", 9);// 出库单
						map1.put("parentIds", parentIds);
						SalesOrder outBoundOrder = salesOrderService.getSalesOrderByOrderTypeAndParentId(map1).get(0);
						//更改状态为11
						SalesOrder s = new SalesOrder();
						s.setId(outBoundOrder.getId());
						s.setState(11);
						salesOrderService.updateByPrimaryKeySelective(s);
					}
					
				
					
					//首页提醒处理Start
					String menuName = "";
					int messageId=0;
					switch (afterState) {
					case 9:
						menuName = "其他发货单";
						messageId = id;
						messageService.addMessage(messageId, menuName);
						break;
					case 10:
						menuName = "其他发货单";
						messageId = id;
						messageService.clearMessage(messageId, 5);
						break;
					case 25:
						menuName = "其他发货单";
						messageId = id;
						messageService.addMessage(messageId, menuName);
						break;
					case 8:
						menuName = "其他发货单作废仓库审核";
						messageId = id;
						messageService.addMessage(messageId, menuName);
						break;
					
					default:
						break;
					}
					
					//首页提醒处理End

				}
			}

			if (isCheck == 1) {
				// 销售订单审核表处理
				SalesOrderReviewer salesOrderReviewer = new SalesOrderReviewer();
				int operatorId = GetSessionUtil.GetSessionUserId(request);
				salesOrderReviewer.setReviewerId(operatorId);// 审批人id
				salesOrderReviewer.setReviewerType(reviewerType);// 审批类型
				for (int i = 0; i < list.size(); i++) {
					// 销售订单id
					salesOrderReviewer.setSalesOrderId(list.get(i));
					// 根据销售订单id和审批类型获取信息 有记录：修改 没有记录：插入
					SalesOrderReviewer salesOrderReviewer1 = salesOrderReviewerService
							.selectBySalesOrderIdAndReviewerType(salesOrderReviewer);
					if (salesOrderReviewer1 != null) {
						salesOrderReviewer1.setReviewerId(operatorId);
						salesOrderReviewerService.updateByPrimaryKeySelective(salesOrderReviewer1);
					} else {
						salesOrderReviewerService.insert(salesOrderReviewer);
					}
				}
			}

			// 插入日志
			// 保存操作的对象编号
			List<SalesOrder> salesOrders = salesOrderService.getSalesOrderByIds(list);
			// 操作对象
			String operateObject = "";
			for (int i = 0; i < salesOrders.size(); i++) {
				operateObject += salesOrders.get(i).getIdentifier();
				if (i < salesOrders.size() - 1) {
					operateObject += ",";
				}
			}
			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			// 操作类型
			int operateType;
			if (isCheck == 1) {
				operateType = Constants.TYPE_LOG_CHECK;
			} else {
				operateType = Constants.TYPE_LOG_SALES;
			}
			// 操作时间
			Date operateTime = new Date();
			insertLog(operateType, operateObject, Constants.OPERATE_UPDATE, operateTime, operatorIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", msg);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "参数错误");
		return rmsg;

	}
	
	/**
	 * 生成其他发货单的出库单单据打印页面所需的信息 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createOtherOutboundOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "出库单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("出库单");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		head.setFieldValue("其他");
		heads.add(head);
		
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "规格编码", "货品名称", "规格", "单位", "单价", "发货数量", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), soc.getUnitPrice() + "",
					soc.getDeliverGoodsNum() + "", soc.getDeliverGoodsMoney() + "" };
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += soc.getDeliverGoodsMoney();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalMoney);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员部门");
		footer.setFieldValue(salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator() + "(" + salesOrder.getPerson().getName() + ")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator());
		}
		footers.add(footer);
		/*footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");

		if (salesOrder.getReviewerName() != null) {
			footer.setFieldValue(salesOrder.getReviewerIdentifier() + "(" + salesOrder.getReviewerName() + ")");
		} else {
			footer.setFieldValue(salesOrder.getReviewerIdentifier());
		}

		footers.add(footer);*/
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	/**
	 * 出库单详情
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "outOrderDetail")
	public JSONObject outOrderDetail(Integer id) {
		SalesOrder salesOrder=salesOrderService.selectOrderDetailById(id);
		return createOutOrderDetail(salesOrder);
				
	}
	/**
	 * 返货单详情
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "returnOrderDetail")
	public JSONObject returnOrderDetail(Integer id) {
		SalesOrder salesOrder=salesOrderService.selectOrderDetailById(id);
		return createReturnOrderDetail(salesOrder);
				
	}
	
	/**
	 * 生成出库单详情 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createOutOrderDetail(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "出库单");
 		outboundOrderJSON.put("date", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("客户编号");
		head.setFieldValue(salesOrder.getSupcto()!=null?salesOrder.getSupcto().getIdentifier():"");
		heads.add(head);
		
	
		
		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		head.setFieldValue(salesOrder.getSupcto()!=null?salesOrder.getSupcto().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("结算方式");
		if((salesOrder.getIsAppOrder()==null||salesOrder.getIsAppOrder()==1)&&salesOrder.getPayment()!=null){
			switch (salesOrder.getPayment()) {
			case 1:
				head.setFieldValue("预付款");
				break;
			case 2:
				head.setFieldValue("货到付款");
				break;
			case 3:
				head.setFieldValue("账期");
				break;
			default:
				break;
			}
		}
		else{
			head.setFieldValue("");
		}
 
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
 		head.setFieldValue(new SimpleDateFormat("yyyy-MM-dd").format(salesOrder.getEndValidityTime()));
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("发货时间");
 		head.setFieldValue(salesOrder.getOrdersDeliveryTime()!=null?new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(salesOrder.getOrdersDeliveryTime()):"");
		heads.add(head);
		
		outboundOrderJSON.put("head", heads);
		head = new FormHeadAndFooter();
		head.setFieldName("发货地点");
 		head.setFieldValue(salesOrder.getDeliverGoodsPlace());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
 		head.setFieldValue(salesOrder.getShippingMode().getName());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("收货人");
 		head.setFieldValue(salesOrder.getConsignee());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
 		head.setFieldValue(salesOrder.getPhone());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
 		head.setFieldValue(salesOrder.getFax());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
 		head.setFieldValue(salesOrder.getOrderer());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("预收金额");
 		head.setFieldValue(salesOrder.getAdvanceScale()==null?"0":salesOrder.getAdvanceScale().toString());
		heads.add(head);
		
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位",  "发货数量(袋)",  "发货数量(箱)","单价","折扣%","金额","备注"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		//发货数量
		Integer totalDeliverGoodsNum=0;

		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(soc.getCommoditySpecificationId());
			Integer commodityNum=soc.getDeliverGoodsNum();
			Integer boxNum=commoditySpecification.getUnits().size()>1?commodityNum/commoditySpecification.getUnits().get(1).getRatioMolecular():0;
			
			
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), soc.getDeliverGoodsNum() + "",boxNum+"",
					soc.getUnitPrice() + "",soc.getDiscount()==null?"100":soc.getDiscount()+"",soc.getDeliverGoodsMoney()+"",soc.getRemark()};
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += soc.getDeliverGoodsMoney();
			totalDeliverGoodsNum+=soc.getDeliverGoodsNum()==null?0:soc.getDeliverGoodsNum();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "4");
		totalCountJSON.put("colTotal",totalDeliverGoodsNum);
		totalCountList.add(totalCountJSON);
 
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "8");
		totalCountJSON.put("colTotal",new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("地区");
		footer.setFieldValue("");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
 		footer.setFieldValue(salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator()+"("+salesOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	/**
	 * 生成返货单详情 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createReturnOrderDetail(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "返货单");
 		outboundOrderJSON.put("date",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("客户编号");
		head.setFieldValue(salesOrder.getSupcto()!=null?salesOrder.getSupcto().getIdentifier():"");
		heads.add(head);

		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		head.setFieldValue(salesOrder.getSupcto()!=null?salesOrder.getSupcto().getName():"");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("结算方式");
		if((salesOrder.getIsAppOrder()==null||salesOrder.getIsAppOrder()==1)&&salesOrder.getPayment()!=null){
			switch (salesOrder.getPayment()) {
			case 1:
				head.setFieldValue("预付款");
				break;
			case 2:
				head.setFieldValue("货到付款");
				break;
			case 3:
				head.setFieldValue("账期");
				break;
			default:
				break;
			}
		}
		else{
			head.setFieldValue("");
		}
 
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
 		head.setFieldValue(new SimpleDateFormat("yyyy-MM-dd").format(salesOrder.getEndValidityTime()));
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("发货时间");
 		head.setFieldValue(salesOrder.getOrdersDeliveryTime()!=null?new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(salesOrder.getOrdersDeliveryTime()):"");
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		head = new FormHeadAndFooter();
		head.setFieldName("发货地点");
 		head.setFieldValue(salesOrder.getDeliverGoodsPlace()!=null?salesOrder.getDeliverGoodsPlace():"");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
 		head.setFieldValue(salesOrder.getShippingMode()!=null?salesOrder.getShippingMode().getName():"");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("收货人");
 		head.setFieldValue(salesOrder.getConsignee()!=null?salesOrder.getDeliverGoodsPlace():"");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
 		head.setFieldValue(salesOrder.getPhone()!=null?salesOrder.getPhone():"");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
 		head.setFieldValue(salesOrder.getFax()!=null?salesOrder.getFax():"");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
 		head.setFieldValue(salesOrder.getOrderer()!=null?salesOrder.getOrderer():"");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("预收金额");
 		head.setFieldValue(salesOrder.getAdvanceScale()==null?"0":salesOrder.getAdvanceScale().toString());
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位",  "发货数量","返货数量","单价","折扣%","税率","税额","金额","批号","备注"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		
		//发货数量
		Integer totalDeliverGoodsNum=0;
		//返货数量
		Integer totalReturnGoodsNum=0;
		//税额
		Double taxesMoney=0.0;
		//金额
		Double totalMoney = 0.0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), (soc.getDeliverGoodsNum()!=null?soc.getDeliverGoodsNum():"0") + "",
					(soc.getReturnGoodsNum()!=null?soc.getReturnGoodsNum():"0")+"",
					soc.getUnitPrice() + "",
					soc.getDiscount()==null?"100":soc.getDiscount()+"",
					(soc.getTaxes()!=null?soc.getTaxes():"")+"",(soc.getTaxesMoney()!=null?soc.getTaxesMoney():"")+"",
					(soc.getDeliverGoodsMoney()!=null?soc.getDeliverGoodsMoney():"")+"",soc.getBatchNumber(),soc.getRemark()};
			totalDeliverGoodsNum+=soc.getDeliverGoodsNum()==null?0:soc.getDeliverGoodsNum();
			totalReturnGoodsNum+=soc.getReturnGoodsNum()==null?0:soc.getReturnGoodsNum();
			taxesMoney+=soc.getTaxesMoney()==null?0:soc.getTaxesMoney();
			totalMoney += soc.getDeliverGoodsMoney()==null?0:soc.getDeliverGoodsMoney();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "4");
		totalCountJSON.put("colTotal",totalDeliverGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal",totalReturnGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "9");
		totalCountJSON.put("colTotal",new BigDecimal(taxesMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "10");
		totalCountJSON.put("colTotal",new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("地区");
		footer.setFieldValue("");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
 		footer.setFieldValue(salesOrder.getPersonDepartmentName()!=null?salesOrder.getPersonDepartmentName():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName()!=null?salesOrder.getPersonName():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator()+"("+salesOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary()!=null?salesOrder.getSummary():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch()!=null?salesOrder.getBranch():"");
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	/**
	 * 订单详情
	 * @param id
	 * @param type  1:销售订单，2：销售开单 3：销售退货单 4：折损单 5：其他发货单 6:app退货单详情
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "salesOrderDetail")
	public JSONObject salesOrderDetail(Integer id,Integer type) {
		SalesOrder salesOrder=salesOrderService.selectOrderDetailById(id);
		switch (type) {
		case 1:
			return createSalesOrderJSON(salesOrder);
		case 2:
			salesOrder=salesOrderService.getSalesOpeningDetailById(id);
			return createSalesBillingOrderJSON(salesOrder);
		case 3:
			SalesOrder s=salesOrderService.selectByPrimaryKey(salesOrder.getParentId());
			//销售退货单的订货人为销售订单的订货人
			salesOrder.setOrderer(s.getOrderer());
			return createSalesReturnOrderJSON(salesOrder);
		case 4:
			return createSalesDamageOrderJSON(salesOrder);
		case 5:
			//其他发货单的仓库显示：送审前如果该订单里的商品所属不同的仓库，则不显示仓库，如果为同一仓库，则显示
			//送审前或者送审驳回
			if((salesOrder.getState()==1||salesOrder.getState()==3)&&salesOrder.getSalesOrderCommodities().size()>1){
				int wId=salesOrder.getSalesOrderCommodities().get(0).getWarehouseId();
				boolean flag=true;
				for(int i=1;i<salesOrder.getSalesOrderCommodities().size();i++){
					if(wId!=salesOrder.getSalesOrderCommodities().get(i).getWarehouseId()){
						flag=false;
					}
				}
				//有不相等的
				if(!flag){
					salesOrder.setWarehouseName("");
				}
				else{
					salesOrder.setWarehouseName(salesOrder.getSalesOrderCommodities().get(0).getWarehouse()==null?"":salesOrder.getSalesOrderCommodities().get(0).getWarehouse().getName());
				}
			}
			else{
				salesOrder.setWarehouseName(salesOrder.getSalesOrderCommodities().get(0).getWarehouse()==null?"":salesOrder.getSalesOrderCommodities().get(0).getWarehouse().getName());
			}
			
			return createotherDeliveOrderJSON(salesOrder);
		case 6:
			return createAPPReturnOrderJSON(salesOrderService.selectOrderDetailById(id));
		case 7:
			return createAPPSendOrderJSON(salesOrder);
		default:
			break;
		}
		return null;			
	}
	
	/**
	 * 销售订单详情--拼的json
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createSalesOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "销售订单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("是否是样品单");
		if(salesOrder.getIsSpecimen()==null||salesOrder.getIsSpecimen()==1){
			head.setFieldValue("否");
		}else{
			head.setFieldValue("是");
		}	
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("客户编号");
		head.setFieldValue(salesOrder.getSupcto()==null?"":salesOrder.getSupcto().getIdentifier());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		head.setFieldValue(salesOrder.getSupcto()==null?"APP":salesOrder.getSupcto().getName());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("结算方式");
		if((salesOrder.getIsAppOrder()==null||salesOrder.getIsAppOrder()==1)&&salesOrder.getPayment()!=null){
			switch (salesOrder.getPayment()) {
			case 1:
				head.setFieldValue("预付款");
				break;
			case 2:
				head.setFieldValue("货到付款");
				break;
			case 3:
				head.setFieldValue("账期");
				break;
			default:
				break;
			}
		}
		else{
			head.setFieldValue("");
		}
		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
 		head.setFieldValue(salesOrder.getEndValidityTime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(salesOrder.getEndValidityTime()));
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("发货时间");
		if(salesOrder.getIsAppOrder()!=null&&salesOrder.getIsAppOrder()==2){
			head.setFieldValue(salesOrder.getAppSendTime()==null?"":dateFormat.format(salesOrder.getAppSendTime()));
		}
		else{
			head.setFieldValue(salesOrder.getOrdersDeliveryTime()==null?"":dateFormat.format(salesOrder.getOrdersDeliveryTime()));
		}
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		head = new FormHeadAndFooter();
		head.setFieldName("发货地点");
 		head.setFieldValue(salesOrder.getDeliverGoodsPlace()==null?"":salesOrder.getDeliverGoodsPlace());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
 		head.setFieldValue(salesOrder.getShippingMode()==null?"":salesOrder.getShippingMode().getName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("收货人");
 		head.setFieldValue(salesOrder.getConsignee()==null?"":salesOrder.getConsignee());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
 		head.setFieldValue(salesOrder.getPhone()==null?"":salesOrder.getPhone());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
 		head.setFieldValue(salesOrder.getFax()==null?"":salesOrder.getFax());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
 		head.setFieldValue(salesOrder.getOrderer()==null?"":salesOrder.getOrderer());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("预收金额");
 		head.setFieldValue(salesOrder.getAdvanceScale()==null?"0":salesOrder.getAdvanceScale().toString());
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位",  "发货数量(袋)","发货数量(箱)","单价","折扣%","税率","税额","金额","批号","备注"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		//发货数量
		Integer totalDeliverGoodsNum=0;
		//税额
		Double totalgetTaxesMoney=0.0;
		//不让数字展示出E
		java.text.DecimalFormat df=new java.text.DecimalFormat("##.######");
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(soc.getCommoditySpecificationId());
			Integer commodityNum=soc.getDeliverGoodsNum();
			Integer boxNum=commoditySpecification.getUnits().size()>1?commodityNum/commoditySpecification.getUnits().get(1).getRatioMolecular():0;
			
			double deliverGoodsMoney = soc.getDeliverGoodsMoney();
			String deliverGoodsMoneyString="";
			if(deliverGoodsMoney>=12000000){
				deliverGoodsMoneyString=df.format(deliverGoodsMoney);
			}
			else{
				deliverGoodsMoneyString=new BigDecimal(deliverGoodsMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"";
			}
			System.out.println("soc.getDeliverGoodsMoney():"+soc.getDeliverGoodsMoney());
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), soc.getDeliverGoodsNum() + "",boxNum+"",
					soc.getUnitPrice() + "",soc.getDiscount()==null?"100":soc.getDiscount()+"",soc.getTaxes()==null?"0":soc.getTaxes()+"",soc.getTaxesMoney()==null?"0":new BigDecimal(soc.getTaxesMoney()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"",
					deliverGoodsMoneyString+"",soc.getBatchNumber()==null?"":soc.getBatchNumber(),soc.getRemark()==null?"":soc.getRemark()};
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += soc.getDeliverGoodsMoney()==null?0.0:deliverGoodsMoney;
 
			totalDeliverGoodsNum+=soc.getDeliverGoodsNum()==null?0:soc.getDeliverGoodsNum();
			totalgetTaxesMoney+=soc.getTaxesMoney()==null?0.0:soc.getTaxesMoney();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		BigDecimal b = new BigDecimal(totalgetTaxesMoney);
		String totalMoneyString="";
		if(totalMoney>=12000000){
			totalMoneyString=df.format(totalMoney);
		}
		else{
			totalMoneyString=new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"";
		}
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "4");
		totalCountJSON.put("colTotal",totalDeliverGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "9");
		totalCountJSON.put("colTotal",b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "10");
		totalCountJSON.put("colTotal",totalMoneyString);
		totalCountList.add(totalCountJSON);
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("地区");
		footer.setFieldValue("");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(salesOrder.getPersonDepartmentName()==null?"":salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName()==null?"":salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator()+"("+salesOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator()==null?"":salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (salesOrder.getReviewerName() != null) {
			footer.setFieldValue(salesOrder.getReviewerIdentifier()+"("+salesOrder.getReviewerName()+")");
		} else {
			footer.setFieldValue(salesOrder.getReviewerIdentifier()==null?"":salesOrder.getReviewerIdentifier());
		}
		footers.add(footer); 
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary()==null?"":salesOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch()==null?"总部":salesOrder.getBranch());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	/**
	 * 销售开单详情--拼的json
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createSalesBillingOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "销售开单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("客户编号");
		head.setFieldValue(salesOrder.getSupcto()==null?"":salesOrder.getSupcto().getIdentifier());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		head.setFieldValue(salesOrder.getSupcto()==null?"APP":salesOrder.getSupcto().getName());
		heads.add(head);
		  head = new FormHeadAndFooter();
		head.setFieldName("结算方式");
		if((salesOrder.getIsAppOrder()==null||salesOrder.getIsAppOrder()==1)&&salesOrder.getPayment()!=null){
			switch (salesOrder.getPayment()) {
			case 1:
				head.setFieldValue("预付款");
				break;
			case 2:
				head.setFieldValue("货到付款");
				break;
			case 3:
				head.setFieldValue("账期");
				break;
			default:
				break;
			}
		}
		else{
			head.setFieldValue("");
		}
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
 		head.setFieldValue(salesOrder.getEndValidityTime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(salesOrder.getEndValidityTime()));
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("发货时间");
 		head.setFieldValue(salesOrder.getOrdersDeliveryTime()==null?"":dateFormat.format(salesOrder.getOrdersDeliveryTime()));
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		head = new FormHeadAndFooter();
		head.setFieldName("发货地点");
 		head.setFieldValue(salesOrder.getDeliverGoodsPlace()==null?"":salesOrder.getDeliverGoodsPlace());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
 		head.setFieldValue(salesOrder.getShippingMode()==null?"":salesOrder.getShippingMode().getName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("收货人");
		head.setFieldValue(salesOrder.getConsignee()==null?"":salesOrder.getConsignee());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(salesOrder.getPhone()==null?"":salesOrder.getPhone());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(salesOrder.getFax()==null?"":salesOrder.getFax());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
		head.setFieldValue(salesOrder.getOrderer()==null?"":salesOrder.getOrderer());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("预收金额");
 		head.setFieldValue(salesOrder.getAdvanceScale()==null?"0":salesOrder.getAdvanceScale().toString());
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位",  "发货数量","返货数量","折损数量","签收数量","单价","折扣%","税率","订单总金额(含税)","折损金额","签收金额(含税)","签收税额","批号","备注"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		
		//发货数量
		Integer totalDeliverGoodsNum=0;
		//返货数量
		Integer totalReturnGoodsNum=0;
		//折损数量
		Integer totalDamageNum=0;
		//签收数量
		Integer totalReceivingGoodsNum=0;
		//总金额（金额加上税额）
		Double totalMoney = 0.0;
		//签收税额
		Double totalgetTaxesMoney=0.0;
		//签收金额
		Double totalReceivingMoney=0.0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), soc.getDeliverGoodsNum() + "",
					soc.getReturnGoodsNum()==null?0+"":soc.getReturnGoodsNum()+"",
					soc.getDamageNum()==null?0+"":soc.getDamageNum()+"",
					soc.getReceivingGoodsNum()==null?0+"":soc.getReceivingGoodsNum()+"",
					soc.getUnitPrice() + "",
					soc.getDiscount()==null?"100":soc.getDiscount()+"",
					soc.getTaxes()==null?0.0+"":soc.getTaxes()+"",
					(soc.getDeliverGoodsMoney()==null?0.0:soc.getDeliverGoodsMoney()+(soc.getTaxesMoney()==null?0.0:soc.getTaxesMoney()))+"",
					soc.getDamageMoney()==null?0.0+"":soc.getDamageMoney()+"",
					soc.getReceivingGoodsMoney()==null?0.0+"":soc.getReceivingGoodsMoney()+"",
					((soc.getReceivingGoodsNum()==null?0:soc.getReceivingGoodsNum())*(soc.getTaxes()==null?0.0:soc.getTaxes())*soc.getUnitPrice())+"",
					soc.getBatchNumber()==null?"":soc.getBatchNumber(),soc.getRemark()==null?"":soc.getRemark()};
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			
			totalReturnGoodsNum+=soc.getReturnGoodsNum()==null?0:soc.getReturnGoodsNum();
			totalDamageNum+=soc.getDamageNum()==null?0:soc.getDamageNum();
			totalDeliverGoodsNum+=soc.getDeliverGoodsNum()==null?0:soc.getDeliverGoodsNum();
			totalReceivingGoodsNum+=soc.getReceivingGoodsNum()==null?0:soc.getReceivingGoodsNum();
			
			totalMoney += soc.getDeliverGoodsMoney()==null?0.0:soc.getDeliverGoodsMoney()+(soc.getTaxesMoney()==null?0.0:soc.getTaxesMoney());
			totalgetTaxesMoney+=(soc.getReceivingGoodsNum()==null?0:soc.getReceivingGoodsNum())*(soc.getTaxes()==null?0.0:soc.getTaxes()*soc.getUnitPrice());
			totalReceivingMoney+=soc.getReceivingGoodsMoney()==null?0.0:soc.getReceivingGoodsMoney();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "4");
		totalCountJSON.put("colTotal",totalDeliverGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal",totalReturnGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "6");
		totalCountJSON.put("colTotal",totalDamageNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "7");
		totalCountJSON.put("colTotal",totalReceivingGoodsNum);
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "11");
		totalCountJSON.put("colTotal",new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "13");
		totalCountJSON.put("colTotal",new BigDecimal(totalReceivingMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "14");
		totalCountJSON.put("colTotal",new BigDecimal(totalgetTaxesMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("地区");
		footer.setFieldValue("");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(salesOrder.getPersonDepartmentName()==null?"":salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName()==null?"":salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator()+"("+salesOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator()==null?"":salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		System.out.println("审核人："+salesOrder.getSalesOpeningIdentifier());
		if(salesOrder.getSalesOpeningIdentifier()!=null&&salesOrder.getSalesOpeningIdentifier()!=""){
			if(salesOrder.getSalesOpeningName()!=null&&salesOrder.getSalesOpeningName()!=""){
				footer.setFieldValue(salesOrder.getSalesOpeningIdentifier()+"("+salesOrder.getSalesOpeningName()+")");
			}
			else{
				footer.setFieldValue(salesOrder.getSalesOpeningIdentifier());
			}
		}
		else{
			footer.setFieldValue("");
		}
		footers.add(footer); 
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary()==null?"":salesOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch()==null?"总部":salesOrder.getBranch());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	
	/**
	 * 折损单详情--拼的json
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createSalesDamageOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "折损单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("客户编号");
		head.setFieldValue(salesOrder.getSupcto()==null?"":salesOrder.getSupcto().getIdentifier());
		heads.add(head);
		/*head = new FormHeadAndFooter();
		head.setFieldName("日期");
		head.setFieldValue(dateFormat.format(salesOrder.getCreateTime()));
		heads.add(head);*/
		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		head.setFieldValue(salesOrder.getSupcto()==null?"APP":salesOrder.getSupcto().getName());
		heads.add(head);
		  head = new FormHeadAndFooter();
		head.setFieldName("结算方式");
		if((salesOrder.getIsAppOrder()==null||salesOrder.getIsAppOrder()==1)&&salesOrder.getPayment()!=null){
			switch (salesOrder.getPayment()) {
			case 1:
				head.setFieldValue("预付款");
				break;
			case 2:
				head.setFieldValue("货到付款");
				break;
			case 3:
				head.setFieldValue("账期");
				break;
			default:
				break;
			}
		}
		else{
			head.setFieldValue("");
		}
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
 		head.setFieldValue(salesOrder.getEndValidityTime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(salesOrder.getEndValidityTime()));
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("发货时间");
 		head.setFieldValue(salesOrder.getOrdersDeliveryTime()==null?"":dateFormat.format(salesOrder.getOrdersDeliveryTime()));
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		head = new FormHeadAndFooter();
		head.setFieldName("发货地点");
		head.setFieldValue(salesOrder.getDeliverGoodsPlace()==null?"":salesOrder.getDeliverGoodsPlace());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
 		head.setFieldValue(salesOrder.getShippingMode()==null?"":salesOrder.getShippingMode().getName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("收货人");
		head.setFieldValue(salesOrder.getConsignee()==null?"":salesOrder.getConsignee());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(salesOrder.getPhone()==null?"":salesOrder.getPhone());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(salesOrder.getFax()==null?"":salesOrder.getFax());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
		head.setFieldValue(salesOrder.getOrderer()==null?"":salesOrder.getOrderer());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("预收金额");
 		head.setFieldValue(salesOrder.getAdvanceScale()==null?"0":salesOrder.getAdvanceScale().toString());
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位",  "发货数量","折损数量","单价","折扣%","税率","税额","金额","折损金额","批号","备注"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		
		//发货数量
		Integer totalDeliverGoodsNum=0;	
		//折损数量
		Integer totalDamageNum=0;		
		//总金额
		Double totalMoney = 0.0;
		//税额
		Double totalgetTaxesMoney=0.0;
		//折损金额
		Double totalDamageMoney=0.0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), soc.getDeliverGoodsNum() + "",
					soc.getDamageNum()==null?0+"":soc.getDamageNum()+"",
					soc.getUnitPrice() + "",
					soc.getDiscount()==null?"100":soc.getDiscount()+"",
					soc.getTaxes()==null?0.0+"":soc.getTaxes()+"",soc.getTaxesMoney()==null?0.0+"":soc.getTaxesMoney()+"",
					soc.getDeliverGoodsMoney()+"",
					soc.getDamageMoney()==null?0.0+"":soc.getDamageMoney()+"",
					soc.getBatchNumber()==null?"":soc.getBatchNumber(),soc.getRemark()==null?"":soc.getRemark()};
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			
			totalDamageNum+=soc.getDamageNum()==null?0:soc.getDamageNum();
			totalDeliverGoodsNum+=soc.getDeliverGoodsNum()==null?0:soc.getDeliverGoodsNum();
			
			totalMoney += soc.getDeliverGoodsMoney()==null?0.0:soc.getDeliverGoodsMoney();
			totalgetTaxesMoney+=soc.getTaxesMoney()==null?0.0:soc.getTaxesMoney();
			totalDamageMoney+=soc.getDamageMoney()==null?0.0:soc.getDamageMoney();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "4");
		totalCountJSON.put("colTotal",totalDeliverGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal",totalDamageNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "9");
		totalCountJSON.put("colTotal",new BigDecimal(totalgetTaxesMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "10");
		totalCountJSON.put("colTotal",new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "11");
		totalCountJSON.put("colTotal",new BigDecimal(totalDamageMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(salesOrder.getPersonDepartmentName()==null?"":salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName()==null?"":salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator()+"("+salesOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator()==null?"":salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if(salesOrder.getFoldLossName()!=null&&salesOrder.getFoldLossIdentifier()!=""){
			if(salesOrder.getFoldLossName()!=null&&salesOrder.getFoldLossName()!=""){
				footer.setFieldValue(salesOrder.getFoldLossIdentifier()+"("+salesOrder.getFoldLossName()+")");
			}
			else{
				footer.setFieldValue(salesOrder.getFoldLossIdentifier());
			}
		}
		else{
			footer.setFieldValue("");
		}
		footers.add(footer); 
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary()==null?"":salesOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch()==null?"总部":salesOrder.getBranch());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	/**
	 * 其它发货单详情--拼的json
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createotherDeliveOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "其它发货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("仓库");
		head.setFieldValue(salesOrder.getWarehouseName()==null?"":salesOrder.getWarehouseName());
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品名称", "货品编码", "规格", "品牌","条形码", "单位",  "业务数量","业务单价","金额","产品批号","备注","生产日期","有效期至"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		//业务数量
		Integer totalDeliverGoodsNum=0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			String[] tbody = { 
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getCommodity().getBrand(),
					soc.getCommoditySpecification().getGoodsBarCode(),
					soc.getCommoditySpecification().getBaseUnitName(), soc.getDeliverGoodsNum() + "",
					soc.getUnitPrice() + "",
					soc.getDeliverGoodsMoney()+"",soc.getBatchNumber(),soc.getRemark(),"",""};
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += soc.getDeliverGoodsMoney()==null?0.0:soc.getDeliverGoodsMoney();
 
			totalDeliverGoodsNum+=soc.getDeliverGoodsNum()==null?0:soc.getDeliverGoodsNum();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "6");
		totalCountJSON.put("colTotal",totalDeliverGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "8");
		totalCountJSON.put("colTotal",new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(salesOrder.getPersonDepartmentName()==null?"":salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName()==null?"":salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator()+"("+salesOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator()==null?"":salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (salesOrder.getReviewerName() != null) {
			footer.setFieldValue(salesOrder.getReviewerIdentifier()+"("+salesOrder.getReviewerName()+")");
		} else {
			footer.setFieldValue(salesOrder.getReviewerIdentifier()==null?"":salesOrder.getReviewerIdentifier());
		}
		footers.add(footer); 
		if(salesOrder.getOrderType() == 9) {
			footers.remove(footer);
		}
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary()==null?"":salesOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch()==null?"总部":salesOrder.getBranch());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	/**
	 * 销售退货单详情--拼的json
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createSalesReturnOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "销售退货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("客户编号");
		head.setFieldValue(salesOrder.getSupcto()==null?"":salesOrder.getSupcto().getIdentifier());
		heads.add(head);
		/*head = new FormHeadAndFooter();
		head.setFieldName("日期");
		head.setFieldValue(dateFormat.format(salesOrder.getCreateTime()));
		heads.add(head);*/
		head = new FormHeadAndFooter();
		head.setFieldName("客户");
		head.setFieldValue(salesOrder.getSupcto()==null?"":salesOrder.getSupcto().getName());
		heads.add(head);
		  head = new FormHeadAndFooter();
		head.setFieldName("结算方式");
		//取客户的结算方式
		head.setFieldValue(salesOrder.getSupcto()==null?"":salesOrder.getSupcto().getSettlementTypeName());		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
 		head.setFieldValue(salesOrder.getEndValidityTime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(salesOrder.getEndValidityTime()));
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("发货时间");
 		head.setFieldValue(salesOrder.getOrdersDeliveryTime()==null?"":dateFormat.format(salesOrder.getOrdersDeliveryTime()));
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		head = new FormHeadAndFooter();
		head.setFieldName("发货地点");
		head.setFieldValue(salesOrder.getDeliverGoodsPlace()==null?"":salesOrder.getDeliverGoodsPlace());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
 		head.setFieldValue(salesOrder.getShippingMode()==null?"":salesOrder.getShippingMode().getName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("收货人");
		head.setFieldValue(salesOrder.getConsignee()==null?"":salesOrder.getConsignee());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(salesOrder.getPhone()==null?"":salesOrder.getPhone());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(salesOrder.getFax()==null?"":salesOrder.getFax());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
		head.setFieldValue(salesOrder.getOrderer()==null?"":salesOrder.getOrderer());
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位",  "退货数量","单价","金额","批号"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		//退货数量
		Integer totalReturnGoodsNum=0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			double returnGoodsUnit=soc.getUnitPrice();
			int returnGoodsNum=soc.getReturnGoodsNum();
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), soc.getReturnGoodsNum() + "",
					soc.getUnitPrice() + "",
					returnGoodsUnit*returnGoodsNum+"",""};
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += returnGoodsUnit*returnGoodsNum;
 
			totalReturnGoodsNum+=soc.getReturnGoodsNum()==null?0:soc.getReturnGoodsNum();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "4");
		totalCountJSON.put("colTotal",totalReturnGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "6");
		totalCountJSON.put("colTotal",new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("地区");
		footer.setFieldValue("");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(salesOrder.getPersonDepartmentName()==null?"":salesOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(salesOrder.getPersonName()==null?"":salesOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator()+"("+salesOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator()==null?"":salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (salesOrder.getReviewerName() != null) {
			footer.setFieldValue(salesOrder.getReviewerIdentifier()+"("+salesOrder.getReviewerName()+")");
		} else {
			footer.setFieldValue(salesOrder.getReviewerIdentifier()==null?"":salesOrder.getReviewerIdentifier());
		}
		footers.add(footer); 
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary()==null?"":salesOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch()==null?"总部":salesOrder.getBranch());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */
		return outboundOrderJSON;
	}
	
	/**
	 * 生成APP退货单单据详情页面所需的信息 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createAPPReturnOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "APP销售退货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("销售退货单");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("APP订单编号");
		head.setFieldValue(salesOrder.getAppOrderIdentifier()==null?"":salesOrder.getAppOrderIdentifier());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("订货人");
		head.setFieldValue(salesOrder.getOrderer()==null?"":salesOrder.getOrderer());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		if(salesOrder.getPhone()!=null){
			head.setFieldValue(salesOrder.getPhone()==null?"":salesOrder.getPhone());
		}
		else {
			head.setFieldValue("");
		}
		heads.add(head);
		
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "规格编码", "货品名称", "规格", "单位", "单价", "退货数量", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		Integer totalNum=0;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			Double price = soc.getUnitPrice()==null?0.0:soc.getUnitPrice();
			Integer returnNumber =soc.getReturnGoodsNum()==null?0:soc.getReturnGoodsNum();
			Double money = soc.getAppAmountMoney();
			String[] tbody = { soc.getCommoditySpecification().getSpecificationIdentifier(),
					soc.getCommoditySpecification().getCommodity().getName(),
					soc.getCommoditySpecification().getSpecificationName(),
					soc.getCommoditySpecification().getBaseUnitName(), price + "",
					returnNumber + "", money + "" };
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += money;
			totalNum+=returnNumber;
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal",totalNum);
		totalCountList.add(totalCountJSON);
 
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "7");
		totalCountJSON.put("colTotal",new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (salesOrder.getPerson() != null) {
			footer.setFieldValue(salesOrder.getOriginator() + "(" + salesOrder.getPerson().getName() + ")");
		} else {
			footer.setFieldValue(salesOrder.getOriginator()==null?"":salesOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch()==null?"总部":salesOrder.getBranch());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(salesOrder.getSummary()==null?"":salesOrder.getSummary());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	/**
	 * 生成APP发货单单据详情页面所需的信息 返回值为JSON格式
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createAPPSendOrderJSON(SalesOrder salesOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "APP销售发货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		outboundOrderJSON.put("date", dateFormat.format(salesOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", salesOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("收货人");
		head.setFieldValue(salesOrder.getConsignee());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("收货地点");
		head.setFieldValue(salesOrder.getDeliverGoodsPlace());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(salesOrder.getPhone());
		heads.add(head);
		
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = {"货品名称", "数量", "价格", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		Integer totalNum=0;
		double money = 0;
		BigDecimal b;
		for (SalesOrderCommodity soc : salesOrder.getSalesOrderCommodities()) {
			money = soc.getDeliverGoodsNum()*soc.getUnitPrice();
			b = new BigDecimal(money);
			money = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			
			String[] tbody = {soc.getCommoditySpecification().getCommodity().getName(),
					soc.getDeliverGoodsNum()+"",
					soc.getUnitPrice()+ "",
					money+ "" };
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());
			totalMoney += money;
			b = new BigDecimal(totalMoney);
			totalMoney = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			totalNum += soc.getDeliverGoodsNum();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "1");
		totalCountJSON.put("colTotal",totalNum);
		totalCountList.add(totalCountJSON);
 
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "3");
		totalCountJSON.put("colTotal",new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		outboundOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		footer.setFieldValue("APP");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(salesOrder.getBranch()==null?"总部":salesOrder.getBranch());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	/**
	 * 往Log表中添加日志信息
	 * 
	 * @param operateType
	 *            操作类型
	 * @param identifier
	 *            操作对象的编号
	 * @param operateMethod
	 *            操作的方法(添加/删除/修改)
	 * @param date
	 *            操作日期
	 * @param userIdentifier
	 *            操作人编号
	 * @throws Exception
	 */
	public void insertLog(Integer operateType, String identifier, String operateMethod, Date date,
			String userIdentifier) throws Exception {
		log = new Log();
		log.setOperateType(operateType);
		log.setOperateObject(identifier + "(" + operateMethod + ")");
		log.setOperateTime(date);
		log.setOperatorIdentifier(userIdentifier);
		logService.insert(log);
	}
}
