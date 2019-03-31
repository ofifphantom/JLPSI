package com.jl.psi.controller;

import java.math.BigDecimal;
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
import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.FormHeadAndFooter;
import com.jl.psi.model.Inventory;
import com.jl.psi.model.Log;
import com.jl.psi.model.PackageOrTeardownOrder;
import com.jl.psi.model.PackageOrTeardownOrderCommodity;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.InventoryService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.PackageOrTeardownOrderCommodityService;
import com.jl.psi.service.PackageOrTeardownOrderService;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 组装/拆卸controller
 * 
 * @author 柳亚婷
 * @Description: TODO
 * @date: 2018年6月12日 上午11:24:24
 */
@Controller
@RequestMapping("/warehouse/packageOrTeardownOrder/")
public class PackageOrTeardownOrderController extends BaseController {
	// 当前类操作的类型(往log日志表中存储)
	private int operateType = Constants.TYPE_LOG_WAREHOUSE;

	// 声明Log类
	Log log;

	@Autowired
	PackageOrTeardownOrderService packageOrTeardownOrderService;
	@Autowired
	PackageOrTeardownOrderCommodityService packageOrTeardownOrderCommodityService;
	@Autowired
	InventoryService inventoryService;
	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	@Autowired
	LogService logService;

	/**
	 * 进入组装/拆卸页面
	 * 
	 * @param request
	 * @param page
	 *            (1:组装页面，2：组装单审批页面,3:仓库查看组装单页面)
	 * @return
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request, int page) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "";
		switch (page) {
		// 组装单页面
		case 1:
			pageName = "junlin/jsp/warehouse/base/assemblySheet/assemblySheet";
			break;
		// 组装单审批页面
		case 2:
			pageName = "junlin/jsp/warehouse/base/assemblySheet/assemblySheetAudit";
			break;
		// 仓库查看组装单页面
		case 3:
			pageName = "junlin/jsp/warehouse/base/assemblySheet/warehouseViewAssemblySheet";
			break;
		// 拆卸单页面
		case 4:
			pageName = "junlin/jsp/warehouse/base/disassemblyList/disassemblyList";
			break;
		// 拆卸单审批页面
		case 5:
			pageName = "junlin/jsp/warehouse/base/disassemblyList/disassemblyListAudit";
			break;
		// 仓库查看拆卸单页面
		case 6:
			pageName = "junlin/jsp/warehouse/base/disassemblyList/warehouseViewDisassemblyList";
			break;
		default:
			break;
		}

		return pageName;

	}

	/**
	 * 获取组装单/拆卸单信息显示在页面上
	 * 
	 * @param request
	 * @param orderType
	 *            单据类型（1：组装单 2：拆卸单）
	 * @param page
	 *            页面(1：销售发起组装单/拆卸单页面，2：审核组装单/拆卸单页面，3：仓库查看组装单/拆卸单页面)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getDataTablesMsg")
	public DataTables getDataTablesMsg(HttpServletRequest request, Integer orderType, Integer page,
			Integer searchWarehouse, String dateSearch, String searchOriginator,String searchType) {
		DataTables dataTables = DataTables.createDataTables(request);

		return packageOrTeardownOrderService.getPackageOrTeardownOrderMsg(dataTables, orderType, page, searchWarehouse,
				dateSearch, searchOriginator,searchType);
	}

	/**
	 * 生成组装单/拆卸单
	 * 
	 * @param request
	 * @param orderType
	 *            单据类型（1：组装单 2：拆卸单）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "createOrder")
	public JSONObject createOrder(HttpServletRequest request, Integer orderType, boolean isHasWarehouse)
			throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取前台传来的json串
		// 获取ajax传递过来的参数
		String pt = request.getParameter("PackageOrTeardownOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(pt);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("packageOrTeardownOrderCommodities", PackageOrTeardownOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		PackageOrTeardownOrder packageOrTeardownOrder = (PackageOrTeardownOrder) net.sf.json.JSONObject
				.toBean(jsonobject, PackageOrTeardownOrder.class, map);
		// 获取制单人编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		packageOrTeardownOrder.setOriginator(userIdentifier);
		// 生成制单日期
		Date date = new Date();
		packageOrTeardownOrder.setPackageOrTeardownDate(date);
		// 获取目前库里最大的编号
		String maxIdentifier = packageOrTeardownOrderService.selectMaxIdentifier(orderType);
		// 保存是组装单还是拆卸单
		packageOrTeardownOrder.setOrderType(orderType);
		// 默认单据状态为1(未送审)
		packageOrTeardownOrder.setState(1);
		packageOrTeardownOrder.setIsDelete(0);

		/* 如果是组装单 */
		if (orderType == 1) {
			// 自动获取单据编号
			String identifier = SundryCodeUtil.createInvoicesIdentifier("CO", maxIdentifier);
			packageOrTeardownOrder.setIdentifier(identifier);
			// 保存单据信息
			if (packageOrTeardownOrderService.insertSelective(packageOrTeardownOrder) > 0) {
				// 保存成功，保存单据商品信息
				for (PackageOrTeardownOrderCommodity commodity : packageOrTeardownOrder
						.getPackageOrTeardownOrderCommodities()) {
					commodity.setPackageOrTeardownOrderId(packageOrTeardownOrder.getId());
				}
				packageOrTeardownOrderCommodityService
						.insertBatch(packageOrTeardownOrder.getPackageOrTeardownOrderCommodities());
				// 之前组成的商品没由库存新，此时需要新加库存信息
				if (!isHasWarehouse) {
					Inventory inventory = new Inventory();
					inventory.setInventory(0);
					inventory.setOccupiedInventory(0);
					inventory.setWarehouseId(packageOrTeardownOrder.getWarehouseId());
					inventory.setSpecificationId(packageOrTeardownOrder.getCommoditySpecificationId());
					inventoryService.insertSelective(inventory);
				}

				// 锁定组成商品库存
				// 获取商品所属的仓库id以及商品信息
				List<Inventory> inventories = new ArrayList<>();
				Inventory inventory;
				for (PackageOrTeardownOrderCommodity pooc : packageOrTeardownOrder
						.getPackageOrTeardownOrderCommodities()) {
					if (pooc.getSpecWarehouseId() != null && pooc.getSpecWarehouseId() > 0) {
						inventory = new Inventory();
						inventory.setSpecificationId(pooc.getCommoditySpecificationId());
						inventory.setWarehouseId(pooc.getSpecWarehouseId());
						inventory.setOccupiedInventory(pooc.getNumber());
						inventories.add(inventory);
					}
				}
				// 修改各个仓库的占用数量
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateOccupiedInventory(inv);
					}

				}

				// 往log里存储数据
				// 往log表中插入操作数据
				insertLog(operateType, packageOrTeardownOrder.getIdentifier(), Constants.OPERATE_INSERT, new Date(),
						userIdentifier);

				rmsg.put("success", true);
				rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
				return rmsg;
			}

		}
		/* 如果是拆卸单 */
		else {
			// 自动获取单据编号
			String identifier = SundryCodeUtil.createInvoicesIdentifier("DC", maxIdentifier);
			packageOrTeardownOrder.setIdentifier(identifier);

			// 保存单据信息
			if (packageOrTeardownOrderService.insertSelective(packageOrTeardownOrder) > 0) {
				// 保存成功，保存单据商品信息
				for (PackageOrTeardownOrderCommodity commodity : packageOrTeardownOrder
						.getPackageOrTeardownOrderCommodities()) {
					commodity.setPackageOrTeardownOrderId(packageOrTeardownOrder.getId());
					// 之前组成的商品没有库存信息，此时需要新加库存信息
					System.out.println("commodity.isHasWarehouse():"+commodity.getPoocIsHasWarehouse());
					if(commodity.getPoocIsHasWarehouse().equals("false")){
						Inventory inventory = new Inventory();
						inventory.setInventory(0);
						inventory.setOccupiedInventory(0);
						inventory.setWarehouseId(commodity.getSpecWarehouseId());
						inventory.setSpecificationId(commodity.getCommoditySpecificationId());
						inventoryService.insertSelective(inventory);
					}
				}
				packageOrTeardownOrderCommodityService
						.insertBatch(packageOrTeardownOrder.getPackageOrTeardownOrderCommodities());

				// 锁定组成的商品的库存
				// 获取商品所属的仓库id以及商品信息
				Inventory inventory = new Inventory();
				inventory.setSpecificationId(packageOrTeardownOrder.getCommoditySpecificationId());
				inventory.setWarehouseId(packageOrTeardownOrder.getWarehouseId());
				inventory.setOccupiedInventory(packageOrTeardownOrder.getPackageOrTeardownNum());
				// 修改仓库的占用数量
				if (inventory != null && inventory.getSpecificationId() > 0) {
					inventoryService.updateOccupiedInventory(inventory);
				}

				// 往log表中插入操作数据
				insertLog(operateType, packageOrTeardownOrder.getIdentifier(), Constants.OPERATE_INSERT, new Date(),
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
	 * 修改单据信息
	 * 
	 * @param request
	 * @param orderType
	 *            单据类型（1：组装单 2：拆卸单）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateOrder")
	public JSONObject updateOrder(HttpServletRequest request, Integer orderType) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取前台传来的json串
		// 获取ajax传递过来的参数
		String pt = request.getParameter("PackageOrTeardownOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(pt);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("packageOrTeardownOrderCommodities", PackageOrTeardownOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		PackageOrTeardownOrder packageOrTeardownOrder = (PackageOrTeardownOrder) net.sf.json.JSONObject
				.toBean(jsonobject, PackageOrTeardownOrder.class, map);
		// 获取制单人编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		packageOrTeardownOrder.setOriginator(userIdentifier);

		/* 如果是组装单 */
		if (orderType == 1) {
			// 先恢复之前商品的占用数量
			PackageOrTeardownOrder order = packageOrTeardownOrderService
					.getPackageOrTeardownOrderMsgById(packageOrTeardownOrder.getId());
			// 保存单据信息
			if (packageOrTeardownOrderService.updateByPrimaryKeySelective(packageOrTeardownOrder) > 0) {
				List<Inventory> inventories;
				Inventory inventory;
	
				inventories = new ArrayList<>();
				for (PackageOrTeardownOrderCommodity pooc : order.getPackageOrTeardownOrderCommodities()) {
					if (pooc.getSpecWarehouseId() != null && pooc.getSpecWarehouseId() > 0) {
						inventory = new Inventory();
						inventory.setSpecificationId(pooc.getCommoditySpecificationId());
						inventory.setOccupiedInventory(pooc.getNumber());
						inventories.add(inventory);
					}
				}
				// 修改各个仓库的占用数量
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inv);
					}
				}

				// 先删除之前保存好的单据商品信息
				packageOrTeardownOrderCommodityService.deleteByPOOId(packageOrTeardownOrder.getId());

				// 重新保存单据商品信息
				packageOrTeardownOrderCommodityService
						.insertBatch(packageOrTeardownOrder.getPackageOrTeardownOrderCommodities());

				// 锁定组成商品库存
				// 获取商品所属的仓库id以及商品信息
				inventories = new ArrayList<>();
				for (PackageOrTeardownOrderCommodity pooc : packageOrTeardownOrder
						.getPackageOrTeardownOrderCommodities()) {
					if (pooc.getSpecWarehouseId() != null && pooc.getSpecWarehouseId() > 0) {
						inventory = new Inventory();
						inventory.setSpecificationId(pooc.getCommoditySpecificationId());
						inventory.setWarehouseId(pooc.getSpecWarehouseId());
						inventory.setOccupiedInventory(pooc.getNumber());
						inventories.add(inventory);
					}
				}
				// 修改各个仓库的占用数量
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateOccupiedInventory(inv);
					}
				}

				// 往log里存储数据
				// 往log表中插入操作数据
				insertLog(operateType, packageOrTeardownOrder.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
						userIdentifier);

				rmsg.put("success", true);
				rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
				return rmsg;
			}

		}
		/* 如果是拆卸单 */
		else {
			// 先恢复之前商品的占用数量
			PackageOrTeardownOrder order = packageOrTeardownOrderService
					.getPackageOrTeardownOrderMsgById(packageOrTeardownOrder.getId());
			// 保存单据信息
			if (packageOrTeardownOrderService.updateByPrimaryKeySelective(packageOrTeardownOrder) > 0) {
				// 解除组成的商品的库存锁定
				Inventory inventory = new Inventory();
				inventory.setSpecificationId(order.getCommoditySpecificationId());
				inventory.setOccupiedInventory(order.getPackageOrTeardownNum());
				inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inventory);
				// 删除之前的商品信息
				packageOrTeardownOrderCommodityService.deleteByPOOId(packageOrTeardownOrder.getId());

				// 重新保存商品信息
				packageOrTeardownOrderCommodityService
						.insertBatch(packageOrTeardownOrder.getPackageOrTeardownOrderCommodities());

				// 锁定组成的商品的库存
				// 获取商品所属的仓库id以及商品信息
				inventory = new Inventory();
				inventory.setSpecificationId(packageOrTeardownOrder.getCommoditySpecificationId());
				inventory.setWarehouseId(packageOrTeardownOrder.getWarehouseId());
				inventory.setOccupiedInventory(packageOrTeardownOrder.getPackageOrTeardownNum());
				// 修改仓库的占用数量
				if (inventory != null && inventory.getSpecificationId() > 0) {
					inventoryService.updateOccupiedInventory(inventory);
				}

				// 往log表中插入操作数据
				insertLog(operateType, packageOrTeardownOrder.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
						userIdentifier);

				rmsg.put("success", true);
				rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
				return rmsg;
			}
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 判断商品的库存是否满足
	 * 
	 * @param request
	 * @param ids 商品规格id数组
	 * @param commodityNums 商品所输入数量数组
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "decideCommodtyInventory", method = RequestMethod.GET)
	public JSONObject decideCommodtyInventory(HttpServletRequest request, String[] ids, String[] commodityNums,Integer orderType)
			throws Exception {
		JSONObject rmsg = new JSONObject();

		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}
		// 获取商品的库存信息
		List<Inventory> inventories = inventoryService.selectBatchInventoryMsgBySpecificationId(list);
		List<CommoditySpecification> commoditySpecifications = commoditySpecificationService.selectBatchMsgByCSID(list);
		List<Integer> isExitsCommoditySpec = new ArrayList<>();
		for (int i = 0; i < inventories.size(); i++) {
			// 库存不足
			if (inventories.get(i).getInventory() - inventories.get(i).getOccupiedInventory() <= 0) {
				isExitsCommoditySpec.add(inventories.get(i).getSpecificationId());
			}
			// 有库存 判断库存是否满足页面中填写的数量
			else {
				for (int h = 0; h < ids.length; h++) {
					if (inventories.get(i).getSpecificationId() == Integer.parseInt(ids[h])) {
						if (inventories.get(i).getInventory() - inventories.get(i).getOccupiedInventory() < Integer
								.parseInt(commodityNums[h])) {
							isExitsCommoditySpec.add(inventories.get(i).getSpecificationId());
						}
					}
				}
			}
		}
		List<String> isExitsCommoditySpecName = new ArrayList<>();
		// 有库存不足的商品
		for (int i = 0; i < isExitsCommoditySpec.size(); i++) {
			for (CommoditySpecification cs : commoditySpecifications) {
				if (cs.getId() == isExitsCommoditySpec.get(i)) {
					// 获取商品名称
					isExitsCommoditySpecName.add(cs.getCommodity().getName() + "(" + cs.getSpecificationName() + ")");
					break;
				}
			}
		}
		String notDeleteCommodity = "{";
		if (isExitsCommoditySpecName != null && isExitsCommoditySpecName.size() > 0) {
			for (int i = 0; i < isExitsCommoditySpecName.size(); i++) {
				if (i < isExitsCommoditySpecName.size() - 1) {
					notDeleteCommodity += isExitsCommoditySpecName.get(i) + ",";

				} else {

					notDeleteCommodity += isExitsCommoditySpecName.get(i);

				}
			}
			notDeleteCommodity += "}";
			//组装单--是个列表
			if(orderType==1){
				rmsg.put("msg", notDeleteCommodity + "以上显示的商品库存不满足，请重新填写!");
			}
			//拆卸单--是单个信息
			else{
				rmsg.put("msg", isExitsCommoditySpecName.get(0) + "该商品库存不满足，请重新填写!");
			}
			
			rmsg.put("success", false);
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}


	/**
	 * 根据id获取组装单/拆卸单详情
	 * 
	 * @param request
	 * @param id
	 *            单据id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getPackageOrTeardownOrderDetailById", method = RequestMethod.GET)
	public PackageOrTeardownOrder getPackageOrTeardownOrderDetailById(HttpServletRequest request, Integer id) {
		return packageOrTeardownOrderService.getPackageOrTeardownOrderMsgById(id);
	}

	/**
	 * 删除订单
	 * 
	 * @param request
	 * @param orderId
	 *            订单id
	 * @param orderIdentifier
	 *            订单编号
	 * @param orderType
	 *            单据类型（1：组装单 2：拆卸单）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "deleteOrderById")
	public JSONObject deleteOrderById(HttpServletRequest request, Integer orderId, String orderIdentifier,
			Integer orderType) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 删除前先保存信息
		PackageOrTeardownOrder order = packageOrTeardownOrderService.getPackageOrTeardownOrderMsgById(orderId);
		// 删除订单
		PackageOrTeardownOrder packageOrTeardownOrder = new PackageOrTeardownOrder();
		packageOrTeardownOrder.setId(orderId);
		if (packageOrTeardownOrderService.deleteByPrimaryKey(orderId) > 0) {
			//packageOrTeardownOrderCommodityService.deleteByPOOId(orderId);
			// 组装单
			if (orderType == 1) {
				// 解除组成商品的库存锁定
				List<Inventory> inventories = new ArrayList<>();
				Inventory inventory;
				for (PackageOrTeardownOrderCommodity pooc : order.getPackageOrTeardownOrderCommodities()) {
					if (pooc.getSpecWarehouseId() != null && pooc.getSpecWarehouseId() > 0) {
						inventory = new Inventory();
						inventory.setSpecificationId(pooc.getCommoditySpecificationId());
						inventory.setOccupiedInventory(pooc.getNumber());
						inventories.add(inventory);
					}
				}
				// 修改各个仓库的占用数量
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inv);
					}
				}
			}
			// 拆卸单
			else {
				// 解除组成的商品的库存锁定
				Inventory inventory = new Inventory();
				inventory.setSpecificationId(order.getCommoditySpecificationId());
				inventory.setOccupiedInventory(order.getPackageOrTeardownNum());
				inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inventory);
			}
			// 往log表中插入操作数据
			insertLog(operateType, orderIdentifier, Constants.OPERATE_DELETE, new Date(),
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
	 * 修改订单的状态 即 送审、审批通过、审批驳回
	 * 
	 * @param request
	 * @param orderId
	 *            单据id
	 * @param state
	 *            （2：审批中，3：审批通过，4：审批驳回）
	 * @param orderType
	 *            单据类型（1：组装单 2：拆卸单）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateOrderState")
	public JSONObject updateOrderState(HttpServletRequest request, Integer orderId, String orderIdentifier,
			Integer state, Integer orderType) throws Exception {
		JSONObject rmsg = new JSONObject();
		PackageOrTeardownOrder packageOrTeardownOrder;
		// 点击送审按钮
		if (state == 2) {
			packageOrTeardownOrder = new PackageOrTeardownOrder();
			packageOrTeardownOrder.setId(orderId);
			packageOrTeardownOrder.setState(state);
			// 修改状态为审批中
			packageOrTeardownOrderService.updateByPrimaryKeySelective(packageOrTeardownOrder);

			// 往log表中插入操作数据
			insertLog(operateType, orderIdentifier, Constants.OPERATE_UPDATE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			return rmsg;
		}
		// 点击审批通过的按钮
		else if (state == 3) {
			// 修改单据状态为审批通过
			packageOrTeardownOrder = new PackageOrTeardownOrder();
			packageOrTeardownOrder.setId(orderId);
			packageOrTeardownOrder.setState(state);
			packageOrTeardownOrder.setReviewer(GetSessionUtil.GetSessionUserIdentifier(request));
			// 修改状态为审批中,并记录审批人
			packageOrTeardownOrderService.updateByPrimaryKeySelective(packageOrTeardownOrder);

			PackageOrTeardownOrder order = packageOrTeardownOrderService.getPackageOrTeardownOrderMsgById(orderId);
			// 组装单
			if (orderType == 1) {
				// 减组成商品的库存，并修改占用数量
				List<Inventory> inventories = new ArrayList<>();
				Inventory inventory;
				for (PackageOrTeardownOrderCommodity pooc : order.getPackageOrTeardownOrderCommodities()) {
					if (pooc.getSpecWarehouseId() != null && pooc.getSpecWarehouseId() > 0) {
						inventory = new Inventory();
						inventory.setSpecificationId(pooc.getCommoditySpecificationId());
						inventory.setWarehouseId(pooc.getSpecWarehouseId());
						inventory.setOccupiedInventory(pooc.getNumber());
						inventory.setInventory(pooc.getNumber());
						inventories.add(inventory);
					}
				}
				// 修改各个仓库的占用数量 并减库存
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateInventoryDown(inv);
					}
				}
				// 加组成的商品的库存
				inventory = new Inventory();
				inventory.setInventory(order.getPackageOrTeardownNum());
				inventory.setSpecificationId(order.getCommoditySpecificationId());
				inventory.setWarehouseId(order.getWarehouseId());
				inventoryService.updateAddGoodsInventory(inventory);

			}
			// 拆卸单
			else {
				Inventory inventory;
				// 减组成的商品的库存，并修改占用数量
				inventory = new Inventory();
				inventory.setInventory(order.getPackageOrTeardownNum());
				inventory.setSpecificationId(order.getCommoditySpecificationId());
				inventory.setWarehouseId(order.getWarehouseId());
				inventory.setOccupiedInventory(order.getPackageOrTeardownNum());
				inventoryService.updateInventoryDown(inventory);

				// 加组成商品的库存
				List<Inventory> inventories = new ArrayList<>();
				for (PackageOrTeardownOrderCommodity pooc : order.getPackageOrTeardownOrderCommodities()) {
					if (pooc.getSpecWarehouseId() != null && pooc.getSpecWarehouseId() > 0) {
						inventory = new Inventory();
						inventory.setSpecificationId(pooc.getCommoditySpecificationId());
						inventory.setWarehouseId(pooc.getSpecWarehouseId());
						inventory.setInventory(pooc.getNumber());
						inventories.add(inventory);
					}
				}
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateAddGoodsInventory(inv);
					}
				}
			}

			// 往log日志中插入数据
			insertLog(operateType, orderIdentifier, Constants.OPERATE_UPDATE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			return rmsg;

		}
		// 点击审批驳回的按钮
		else if (state == 4) {
			packageOrTeardownOrder = new PackageOrTeardownOrder();
			packageOrTeardownOrder.setId(orderId);
			packageOrTeardownOrder.setState(state);
			packageOrTeardownOrder.setReviewer(GetSessionUtil.GetSessionUserIdentifier(request));
			// 修改状态为审批驳回
			packageOrTeardownOrderService.updateByPrimaryKeySelective(packageOrTeardownOrder);

			// 往log表中插入操作数据
			insertLog(operateType, orderIdentifier, Constants.OPERATE_UPDATE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));

			rmsg.put("success", true);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			return rmsg;
		}
		return rmsg;
	}
	
	
	/**
	 * 打印组装单/拆卸单
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "printPackageOrTeardownOrder", method = RequestMethod.GET)
	public JSONObject printPackageOrTeardownOrder(HttpServletRequest request, Integer id,Integer orderType) {
		PackageOrTeardownOrder packageOrTeardownOrder = packageOrTeardownOrderService
				.getPackageOrTeardownOrderMsgById(id);

		return createPackageOrTeardownOrderJSON(packageOrTeardownOrder,orderType);
	}

	/**
	 * 更新单据打印次数
	 */
	@ResponseBody
	@RequestMapping(value = "updatePackageOrTeardownOrderPrintNum")
	public JSONObject updatePackageOrTeardownOrderPrintNum(HttpServletRequest request, int id) throws Exception {

		JSONObject rmsg = new JSONObject();
		PackageOrTeardownOrder packageOrTeardownOrder = packageOrTeardownOrderService.selectByPrimaryKey(id);
		String identifier = packageOrTeardownOrder.getIdentifier();
		int printNum = packageOrTeardownOrder.getPrintNum();
		printNum += 1;
		packageOrTeardownOrder = new PackageOrTeardownOrder();
		packageOrTeardownOrder.setId(id);
		packageOrTeardownOrder.setPrintNum(printNum);
		if (packageOrTeardownOrderService.updateByPrimaryKeySelective(packageOrTeardownOrder) > 0) {
			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			//insertLog(Constants.TYPE_LOG_PRINT, identifier, Constants.OPERATE_UPDATE, new Date(), userIdentifier);
			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	// 私有方法

	/**
	 * 生成组装单单据打印页面所需的信息 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createPackageOrTeardownOrderJSON(PackageOrTeardownOrder packageOrTeardownOrder,Integer orderType) {
		JSONObject JSON = new JSONObject();
		if(orderType==1){
			JSON.put("title", "组装单");
		}
		else{
			JSON.put("title", "拆卸单");
		}
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JSON.put("date", dateFormat.format(packageOrTeardownOrder.getPackageOrTeardownDate()));
		JSON.put("oddNumbers", packageOrTeardownOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("仓库");
		head.setFieldValue(packageOrTeardownOrder.getWarehouseName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("货品编码");
		head.setFieldValue(packageOrTeardownOrder.getCommoditySpecIdentifier());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("货品名称");
		head.setFieldValue(packageOrTeardownOrder.getCommodityName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("规格");
		head.setFieldValue(packageOrTeardownOrder.getCommoditySpecName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("单位");
		head.setFieldValue(packageOrTeardownOrder.getBaseUnit());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("单价");
		head.setFieldValue(packageOrTeardownOrder.getUnitPrice() + "");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("组装数量");
		head.setFieldValue(packageOrTeardownOrder.getPackageOrTeardownNum() + "");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("金额");
		head.setFieldValue(packageOrTeardownOrder.getTotalMoney() + "");
		heads.add(head);
		JSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "规格编码", "货品名称", "规格", "单位","仓库", "单价", "数量", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (PackageOrTeardownOrderCommodity pooc : packageOrTeardownOrder.getPackageOrTeardownOrderCommodities()) {
			String[] tbody = { pooc.getPoocCommoditySpecIdentifier(), pooc.getPoocCommName(), pooc.getPoocSpecName(),
					pooc.getPoocBaseUnit() + "",pooc.getSpecWarehouseName(), pooc.getUnitPrice() + "", pooc.getNumber() + "",
					pooc.getMoney() + "" };
			// System.out.println("DeliverGoodsMoney:" +
			// soc.getDeliverGoodsMoney());
			totalMoney += pooc.getMoney();
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

		JSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (packageOrTeardownOrder.getOriginatorName() != null) {
			footer.setFieldValue(
					packageOrTeardownOrder.getOriginator() + "(" + packageOrTeardownOrder.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(packageOrTeardownOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (packageOrTeardownOrder.getReviewer() != null) {
			if (packageOrTeardownOrder.getReviewerName() != null) {
				footer.setFieldValue(
						packageOrTeardownOrder.getReviewer() + "(" + packageOrTeardownOrder.getReviewerName() + ")");
			} else {
				footer.setFieldValue(packageOrTeardownOrder.getReviewer());
			}
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(packageOrTeardownOrder.getSummary());
		footers.add(footer);
		JSON.put("footer", footers);
		/* footer end */

		return JSON;
	}
	/**
	 * 生成组装单单据详情页面所需的信息 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getPackageOrTeardownOrderDetailByIdToJson")
	private JSONObject createDetailPackageOrTeardownOrderJSON(Integer orderType,Integer id) {
		PackageOrTeardownOrder packageOrTeardownOrder=packageOrTeardownOrderService.getPackageOrTeardownOrderMsgById(id);
		JSONObject JSON = new JSONObject();
		if(orderType==1){
			JSON.put("title", "组装单");
		}
		else{
			JSON.put("title", "拆卸单");
		}
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JSON.put("date", dateFormat.format(packageOrTeardownOrder.getPackageOrTeardownDate()));
		JSON.put("oddNumbers", packageOrTeardownOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("仓库");
		head.setFieldValue(packageOrTeardownOrder.getWarehouseName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("货品编码");
		head.setFieldValue(packageOrTeardownOrder.getCommoditySpecIdentifier());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("货品名称");
		head.setFieldValue(packageOrTeardownOrder.getCommodityName());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("规格");
		head.setFieldValue(packageOrTeardownOrder.getCommoditySpecName());
		heads.add(head);
		for (int i=0,j=1;i<packageOrTeardownOrder.getPackageOrTeardownOrderCommodities().size();i++,j++) {
			head = new FormHeadAndFooter();
			head.setFieldName("数量/单位"+j);
			head.setFieldValue(packageOrTeardownOrder.getPackageOrTeardownOrderCommodities().get(i).getNumber()+" "+packageOrTeardownOrder.getPackageOrTeardownOrderCommodities().get(i).getPoocBaseUnit());
			heads.add(head);
		}
		head = new FormHeadAndFooter();
		head.setFieldName("单位");
		head.setFieldValue(packageOrTeardownOrder.getBaseUnit());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("单价");
		head.setFieldValue(packageOrTeardownOrder.getUnitPrice() + "");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("组装数量");
		head.setFieldValue(packageOrTeardownOrder.getPackageOrTeardownNum() + "");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("金额");
		head.setFieldValue(packageOrTeardownOrder.getTotalMoney() + "");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("批号");
		head.setFieldValue("");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("到期日");
		head.setFieldValue("");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("生产日期");
		head.setFieldValue("");
		heads.add(head);
		JSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "规格编码", "货品名称", "规格", "品牌","条形码","单位","仓库", "单价", "数量", "金额","产品批号","生产日期","有效期至" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		int  totalNum=0;
		Double totalMoney = 0.0;
		for (PackageOrTeardownOrderCommodity pooc : packageOrTeardownOrder.getPackageOrTeardownOrderCommodities()) {
			String[] tbody = { pooc.getPoocCommoditySpecIdentifier(), pooc.getPoocCommName(), pooc.getPoocSpecName(),pooc.getCommoditySpecification().getCommodity().getBrand(),pooc.getCommoditySpecification().getBarCode(),
					pooc.getPoocBaseUnit() + "",pooc.getSpecWarehouseName(), pooc.getUnitPrice() + "", pooc.getNumber() + "",
					pooc.getMoney() + "","","","" };
			// System.out.println("DeliverGoodsMoney:" +
			// soc.getDeliverGoodsMoney());
			totalNum+=pooc.getNumber();
			totalMoney += pooc.getMoney();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		BigDecimal b = new BigDecimal(totalMoney);
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "8");
		totalCountJSON.put("colTotal",totalNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "9");
		totalCountJSON.put("colTotal",b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		
		
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		JSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		if (packageOrTeardownOrder.getDepartmentName()!=null) {
			footer.setFieldValue(packageOrTeardownOrder.getDepartmentName());
		}else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (packageOrTeardownOrder.getOriginatorName() != null) {
			footer.setFieldValue(
					packageOrTeardownOrder.getOriginator() + "(" + packageOrTeardownOrder.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(packageOrTeardownOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (packageOrTeardownOrder.getReviewer() != null) {
			if (packageOrTeardownOrder.getReviewerName() != null) {
				footer.setFieldValue(
						packageOrTeardownOrder.getReviewer() + "(" + packageOrTeardownOrder.getReviewerName() + ")");
			} else {
				footer.setFieldValue(packageOrTeardownOrder.getReviewer());
			}
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(packageOrTeardownOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue("总部");
		footers.add(footer);
		JSON.put("footer", footers);
		/* footer end */

		return JSON;
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
