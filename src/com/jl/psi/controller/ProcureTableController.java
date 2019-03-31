package com.jl.psi.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.FormHeadAndFooter;
import com.jl.psi.model.Inventory;
import com.jl.psi.model.Log;
import com.jl.psi.model.PackageOrTeardownOrder;
import com.jl.psi.model.PackageOrTeardownOrderCommodity;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.model.Unit;
import com.jl.psi.model.Warehouse;
import com.jl.psi.service.ActivityService;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.InventoryService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.MessageService;
import com.jl.psi.service.ProcureCommodityService;
import com.jl.psi.service.ProcureTableService;
import com.jl.psi.service.UnitService;
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 
 * @author 柳亚婷
 * @date 2018年4月17日 下午5:41:35
 * @Description 采购计划单/采购订单Controller
 *
 */
@Controller
@RequestMapping("/purchase/procuretable/")
public class ProcureTableController extends BaseController {
	private String folderName = "ProcuretablePaymentEvidencePic";

	// 当前类操作的类型(往log日志表中存储)
	private int operateType = Constants.TYPE_LOG_PROCURE;

	// 声明Log类
	Log log;

	@Autowired
	ProcureTableService procureTableService;
	@Autowired
	ProcureCommodityService procureCommodityService;
	@Autowired
	InventoryService inventoryService;
	@Autowired
	MessageService messageService;
	
	@Autowired
	LogService logService;
	@Autowired
	ActivityService	activityService;
	@Autowired
	CommoditySpecificationService	commoditySpecificationService;
	
	@Autowired
	UnitService  unitService;
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
		// 采购计划单
		case 1:
			pageName = "junlin/jsp/purchase/purchasePlan/purchasePlan";
			break;
		// 采购订单
		case 2:
			pageName = "junlin/jsp/purchase/purchaseOrder/purchaseOrder";
			break;
		// 采购订单审核
		case 3:
			pageName = "junlin/jsp/purchase/purchaseOrder/purchaseOrderReview";
			break;
		// 采购终止审核
		case 4:
			pageName = "junlin/jsp/purchase/purchaseOrder/purchaseOrderTerminationAudit";
			break;
		// 会计收款
		case 5:
			pageName = "junlin/jsp/purchase/purchaseOrder/accountingReceipts";
			break;
		// 单据打印
		case 6:
			pageName = "junlin/jsp/purchase/purchaseOrder/documentPrinting";
			break;
		// 采购订单引用生成入库单
		case 7:
			pageName = "junlin/jsp/warehouse/warehousing/documentReference/purchaseOrderReference";
			break;
		// 采购全部入库单
		case 8:
			pageName = "junlin/jsp/warehouse/warehousing/warehouse";
			break;
		// 采购部分入库单
		case 9:
			pageName = "junlin/jsp/warehouse/warehousing/warehouseHalf";
			break;
		// 入库单引用
		case 10:
			pageName = "junlin/jsp/purchase/purchaseBilling/libraryListReference";
			break;
		// 采购开单
		case 11:
			pageName = "junlin/jsp/purchase/purchaseBilling/purchaseBilling";
			break;
		//采购生成退货单页面
		case 12:
			pageName = "junlin/jsp/purchase/purchaseReturn/purchaseReturn";
			break;
		//采购老大审核退货单页面
		case 13:
			pageName = "junlin/jsp/purchase/purchaseReturn/purchaseReturnAudit";
			break;
		//仓库查看退货单页面
		case 14:
			pageName = "junlin/jsp/warehouse/outOfTheTreasury/purchaseReturnOut";
			break;
		//财务查看退货单页面
		case 15:
			pageName = "junlin/jsp/purchase/purchaseReturn/purchaseReturnSee";
			break;
		//其他收货单页面
		case 16:
			pageName = "junlin/jsp/purchase/otherReceipts/otherReceiptsOrder";
			break;
		//其他收货单领导审批页面
		case 17:
			pageName = "junlin/jsp/purchase/otherReceipts/otherReceiptsOrderReview";
			break;
		//其他收货单财务页面
		case 18:
			pageName = "junlin/jsp/purchase/otherReceipts/otherReceiptsOrderFinanceAudit";
			break;
		//其他收货单引用页面
		case 19:
			pageName = "junlin/jsp/warehouse/warehousing/documentReference/otherReceiptsOrderReference";
			break;	
		//其他收货单引用页面
		case 20:
			pageName = "junlin/jsp/purchase/otherReceipts/otherReceiptsOrderTerminationAudit";
			break;	
		// 其他收货单全部入库单
		case 21:
			pageName = "junlin/jsp/warehouse/warehousing/otherWarehouse";
			break;
		// 其他收货单部分入库单
		case 22:
			pageName = "junlin/jsp/warehouse/warehousing/otherWarehouseHalf";
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
	 *            供应商名称
	 * @param commodityName
	 *            商品名称
	 * @param page
	 *            (1:采购计划单/采购订单页面，2：采购订单审批页面，5：会计收款页面，6：会计打印单据页面,8:采购订单终止审核页面,
	 *            11:采购订单引用生成入库单,12:入库单页面,13:部分入库单页面,14:采购开单页面,15:入库单引用页面,
	 *            16：采购生成退货单页面，17：采购老大审核退货单页面，18：仓库查看退货单页面，19：财务查看退货单页面，
	 *            20:采购生成其他发货单页面，21：其他收货单领导审批页面，22:其他收货单财务审核页面,23:其他收货单引用生成入库单页面,
	 *            24:其他收货单终止审批,25:其他收货单全部入库单,26:其他收货单部分入库单)
	 * @param planOrOrder
	 *            采购计划单or采购订单页面(1:计划单  2:订单 3:入库单 4:采购开单,5:采购退货，6：其他收货单)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getProcureTableMsg")
	public DataTables getProcureTableMsg(HttpServletRequest request, String identifier, String supctoName,
			String commodityName,String generateDate,String originator, Integer page, Integer planOrOrder,String queryTime,String state,String isPlan) {
		DataTables dataTables = DataTables.createDataTables(request);

		return procureTableService.getProcureTableMsg(dataTables, identifier, supctoName, commodityName, generateDate, originator, planOrOrder,
				page,queryTime,state,isPlan);
	}

	/**
	 * 点击编辑时根据主键ID查询信息
	 * 
	 * @param id
	 *            主键
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectById")
	public ProcureTable selectById(HttpServletRequest request, String id) throws Exception {
		ProcureTable procureTable = procureTableService.selectMsgToDetail(Integer.parseInt(id));
		if (procureTable.getProcureCommoditys() != null && procureTable.getProcureCommoditys().size() > 0) {
			for (int i = 0; i < procureTable.getProcureCommoditys().size(); i++) {
				// 查询原始单价
				if (procureTable.getProcureCommoditys().get(i).getOriginalUnitPrice() == null
						|| procureTable.getProcureCommoditys().get(i).getOriginalUnitPrice() <= 0) {
					procureTable.getProcureCommoditys().get(i).setOriginalUnitPrice(procureTableService
							.getOriginalUnitPrice(procureTable.getProcureCommoditys().get(i).getCommodityId()));
					//procureTable.getProcureCommoditys().get(i).setSurplusNum(procureTableService
							//.getArrivalNum(procureTable.getProcureCommoditys().get(i).getCommodityId()));
				}
			}
		}

		return procureTable;
	}

	/**
	 * 采购计划单生成采购订单
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/updatePlanByPrimaryKey", method = RequestMethod.POST)
	public JSONObject updatePlanByPrimaryKey(HttpServletRequest request, ProcureTable procureTable) throws Exception {
		JSONObject rmsg = new JSONObject();

		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		procureTable.setOriginator(userIdentifier);
		procureTable.setDepartmentId(GetSessionUtil.GetSessionUserDepartmentId(request));
		procureTable.setBranch("总部");
		procureTable.setState(1);
		procureTable.setPlanOrOrder(2);
		procureTable.setBeforeIsPlan(1);

		// 往数据库中根据id修改信息
		int result = procureTableService.updateByPrimaryKeySelective(procureTable);

		if (result > 0) {

			// 往log表中插入操作数据
			insertLog(operateType, procureTable.getIdentifier(), Constants.OPERATE_UPDATE, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
			// }
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 新增采购信息 planOrTable (1:计划单页面的添加按钮，2：订单页面的添加按钮,6:其他收货单的新增按钮)
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addPurchaseOrder", method = RequestMethod.POST)
	public JSONObject addPurchaseOrder(HttpServletRequest request, Integer planOrTable) throws Exception {

		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String pt = request.getParameter("procureTable");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(pt);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("procureCommoditys", ProcureCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		ProcureTable procureTable = (ProcureTable) net.sf.json.JSONObject.toBean(jsonobject, ProcureTable.class, map);
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		procureTable.setOriginator(userIdentifier);
		procureTable.setIsDelete(0);
		Date date = new Date();
		procureTable.setGenerateDate(date);
		String maxIdentifier = "";
		String identifier = "";
		//其他收货单
		if(planOrTable==6){
			maxIdentifier = procureTableService.selectMaxIdentifierToOtherReceipts();
			identifier = SundryCodeUtil.createInvoicesIdentifier("OO", maxIdentifier);
		}
		//采购订单/采购计划单
		else{
			maxIdentifier = procureTableService.selectMaxIdentifierToPlanAndOrder();
			identifier = SundryCodeUtil.createInvoicesIdentifier("PO", maxIdentifier);
		}

		if (planOrTable == 2) {
			procureTable.setIdentifier(identifier);
			procureTable.setDepartmentId(GetSessionUtil.GetSessionUserDepartmentId(request));
			procureTable.setBranch("总部");
			procureTable.setState(1);
			procureTable.setPlanOrOrder(2);
		}
		else if(planOrTable == 6){
			procureTable.setIdentifier(identifier);
			procureTable.setDepartmentId(GetSessionUtil.GetSessionUserDepartmentId(request));
			procureTable.setBranch("总部");
			procureTable.setState(1);
			procureTable.setPlanOrOrder(6);
			procureTable.setBeforeIsPlan(0);
		}
		else {
			procureTable.setIdentifier(identifier);
			procureTable.setDepartmentId(GetSessionUtil.GetSessionUserDepartmentId(request));
			procureTable.setBranch("总部");
			procureTable.setPlanOrOrder(1);
		}

		// 往数据库中根据id修改信息
		int result = procureTableService.insertSelective(procureTable);

		if (result > 0) {
			for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
				pc.setProcureTableId(procureTable.getId());
				System.out.println("商品id"+pc.getCommodityId());
				// 计划单的保存
				if (planOrTable == 1) {
					pc.setTotalTaxPrice(pc.getTotalPrice());
				}
			}
			procureCommodityService.insertBatch(procureTable.getProcureCommoditys());

			// 往log表中插入操作数据
			insertLog(operateType, procureTable.getIdentifier(), Constants.OPERATE_INSERT, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
			return rmsg;

		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 根据主键更新采购信息
	 *
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/updateOrderByPrimaryKey", method = RequestMethod.POST)
	public JSONObject updateOrderByPrimaryKey(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String pt = request.getParameter("procureTable");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(pt);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("procureCommoditys", ProcureCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		ProcureTable procureTable = (ProcureTable) net.sf.json.JSONObject.toBean(jsonobject, ProcureTable.class, map);
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);

		//procureTable.setOriginator(userIdentifier);
		//procureTable.setDepartmentId(GetSessionUtil.GetSessionUserDepartmentId(request));
		procureTable.setBranch("总部");
		procureTable.setState(1);
		//其他收货单的编辑事件
		if(procureTable.getPlanOrOrder()!=null&&procureTable.getPlanOrOrder()==6){
			procureTable.setPlanOrOrder(6);
		}
		else{
			procureTable.setPlanOrOrder(2);
		}
		
 
		// 往数据库中根据id修改信息
		int result = procureTableService.updateByPrimaryKeySelective(procureTable);

		if (result > 0) {
			// 先删除采购订单的商品，再重新添加
			procureCommodityService.deleteByProcureTableId(procureTable.getId());
			for(ProcureCommodity procureCommodity:procureTable.getProcureCommoditys()){
				if(procureTable.getSupctoId()==null||procureTable.getSupctoId().equals("")||procureTable.getSupctoId().equals("-1")){
					procureCommodity.setTotalPrice(procureCommodity.getTotalTaxPrice());
				}
			}

			procureCommodityService.insertBatch(procureTable.getProcureCommoditys());

			// 往log表中插入操作数据
			insertLog(operateType, procureTable.getIdentifier(), Constants.OPERATE_UPDATE, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;

		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 采购订单的审核&采购终止审核
	 * 
	 * @param request
	 * @param ids
	 *            id数组
	 * @param state
	 *            状态 value=3、4、9、10(3：采购订单审核已通过，4：采购订单审核已驳回，9终止审核通过，10：终止审核驳回，17：其他收货单领导审核驳回，19：财务审核驳回，22：其他收货单终止驳回)
	 *            value=2，7，8(2:已送审，7：撤销，8：终止，16：其他收货单领导审核中，18：财务审核中，21：其他收货单终止)
	 * @return
	 * @throws Exception
	 */

	@ResponseBody
	@RequestMapping(value = "updateStateByIds", method = RequestMethod.POST)
	public JSONObject updateStateByIds(HttpServletRequest request, String[] ids, int state) throws Exception {

		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", list);

		JSONObject rmsg = new JSONObject();

		// 操作人
		String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);

		switch (state) {
		case 2:
			map.put("state", Constants.STATE_PROCURETABLE_IS_REVIEW);
			rmsg.put("msg", "操作成功，已送审！");
			//插入消息列表
			messageService.addMessageBath(list, "采购订单审核");
			break;
		case 3:
			map.put("state", Constants.STATE_PROCURETABLE_REVIEW_PASS);
			map.put("reviewer", operatorIdentifier);
			rmsg.put("msg", "操作成功，已通过！");
			break;
		case 4:
			map.put("state", Constants.STATE_PROCURETABLE_REVIEW_REFUSED);
			map.put("reviewer", operatorIdentifier);
			rmsg.put("msg", "操作成功，已驳回！");
			//插入消息列表
			messageService.addMessageBath(list, "采购订单");
			break;
		case 7:
			map.put("state", Constants.STATE_PROCURETABLE_CANCLE);
			rmsg.put("msg", "操作成功，已撤销！");
			messageService.clearMessageBath(list, 4);
			break;
		case 8:
			map.put("state", Constants.STATE_PROCURETABLE_END);
			rmsg.put("msg", "操作成功，已送审终止！");
			//插入消息列表
			messageService.addMessageBath(list, "采购终止审核");
			break;
		case 9:
			map.put("state", Constants.STATE_PROCURETABLE_AUDIT_PASS);
			map.put("terminator", operatorIdentifier);
			rmsg.put("msg", "操作成功，已通过！");
			messageService.clearMessageBath(list, 4);
			break;
		case 10:
			map.put("state", Constants.STATE_PROCURETABLE_AUDIT_REFUSED);
			map.put("terminator", operatorIdentifier);
			rmsg.put("msg", "操作成功，已驳回！");
			//插入消息列表
			messageService.addMessageBath(list, "采购订单");
			break;
		case 16:
			//其他收货单送审采购领导审核
			map.put("state", 16);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			//插入消息列表
			messageService.addMessageBath(list, "领导审批其他单据");
			break;
		case 17:
			//其他收货单采购领导审核驳回
			map.put("state", 17);
			map.put("reviewer", operatorIdentifier);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			//插入消息列表
			messageService.addMessageBath(list, "其他收货单");
			break;
		case 18:
			//其他收货单送审财务审核
			map.put("state", 18);
			map.put("reviewer", operatorIdentifier);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			//插入消息列表
			messageService.addMessageBath(list, "财务审批其他单据");
			break;
		case 19:
			//其他收货单财务审核驳回
			map.put("state", 19);
			map.put("financialReviewer", operatorIdentifier);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			//插入消息列表
			messageService.addMessageBath(list, "其他收货单");
			break;
		case 20:
			//其他收货单财务审核通过--仓库 其他收货单引用
			map.put("state", 20);
			map.put("financialReviewer", operatorIdentifier);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			//插入消息列表
			messageService.addMessageBath(list, "其他收货单引用");
			break;
		case 21:
			map.put("state", Constants.STATE_PROCURETABLE_END);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			//插入消息列表
			messageService.addMessageBath(list, "其他单据终止审批");
			break;
		case 22:
			map.put("state", Constants.STATE_PROCURETABLE_AUDIT_REFUSED);
			map.put("terminator", operatorIdentifier);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			//插入消息列表
			messageService.addMessageBath(list, "其他收货单");
			break;
		default:
			break;
		}

		if (procureTableService.updateStateByIds(map)) {
			if (state == Constants.STATE_PROCURETABLE_REVIEW_PASS) {
				// 审核通过需要判断是否需要会计收款
				ProcureTable p, t;
				int payType;
				for (int i = 0; i < list.size(); i++) {
					p = procureTableService.selectByPrimaryKey(list.get(i));
					if (p != null) {
						payType = p.getPayType();
						if (payType == 1) {// 结算方式是预付款
							t = new ProcureTable();
							t.setId(list.get(i));
							t.setState(5);// 状态修改为待收款
							procureTableService.updateByPrimaryKeySelective(t);
							//插入消息列表
							messageService.addMessage(list.get(i), "会计付款");
						}
						else{
							//插入消息列表
							messageService.addMessage(list.get(i), "采购订单引用");
						}
					}
				}
			}
			//终止审核送审时修改相关（状态为11的）入库单的状态也为“终止审核中”
			else if(state == Constants.STATE_PROCURETABLE_END||state == 21) {
				map.put("state", Constants.STATE_PROCURETABLE_END);
				map.put("beforeState", 11);
				procureTableService.updateStateByParentIds(map);
			}
			//终止审核通过时修改相关入库单的状态也为“终止审核通过”
			else if(state == Constants.STATE_PROCURETABLE_AUDIT_PASS) {
				procureTableService.updateStateByParentIds(map);
			}
			//终止审核驳回时修改相关入库单的状态为“部分入库”
			else if(state == Constants.STATE_PROCURETABLE_AUDIT_REFUSED||state==22) {
				map.put("state", 11);
				procureTableService.updateStateByParentIds(map);
			}
			
			// 保存操作的对象编号
			List<ProcureTable> procureTables = procureTableService.getProcureTableByIds(list);
			// 插入日志
			Log log = new Log();
			String operateObject = "";
			// 操作类型
			log.setOperateType(Constants.TYPE_LOG_CHECK);

			// 操作对象
			operateObject = "";
			for (int i = 0; i < procureTables.size(); i++) {
				operateObject += procureTables.get(i).getIdentifier();
				if (i < procureTables.size() - 1) {
					operateObject += ",";
				}
			}
			operateObject += "(" + Constants.OPERATE_UPDATE + ")";
			log.setOperateObject(operateObject);

			// 操作人
			log.setOperatorIdentifier(operatorIdentifier);
			// 操作时间
			Date operateTime = new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);

			rmsg.put("success", true);

			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败，请确认或再次加载该页面后重新操作！");
		return rmsg;
	}

	/**
	 * 根据主键删除采购订单
	 * 
	 * @param build
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/delByPrimaryKey", method = RequestMethod.POST)
	public JSONObject delBatchByPrimaryKey(HttpServletRequest request, Integer id, String identifier) throws Exception {
		JSONObject rmsg = new JSONObject();

		if (procureTableService.deleteByPrimaryKey(id) > 0) {
		//	procureCommodityService.deleteByProcureTableId(id);
			messageService.clearMessage(id, 4);
			// 往log表中插入操作数据
			insertLog(operateType, identifier, Constants.OPERATE_DELETE, new Date(),
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
	 * 上传付款凭证
	 * 
	 * @param file
	 *            图片
	 * @param request
	 *            前台传入得数据
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "addPaymentEvidence", method = RequestMethod.POST)
	public JSONObject addPaymentEvidence(@RequestParam(value = "previewImg", required = false) MultipartFile[] files,
			HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();

		ProcureTable procureTable = new ProcureTable();
		procureTable.setId(Integer.parseInt(request.getParameter("id")));

		if (files != null && files.length > 0) {
			for (int i = 0; i < files.length; i++) {
				MultipartFile file = files[i];
				if (file.getOriginalFilename() != null && !"".equals(file.getOriginalFilename())) {
					switch (i) {
					case 0:
						procureTable.setPaymentEvidence1(CommonMethod.savePic(request, folderName, file));
						break;
					case 1:
						procureTable.setPaymentEvidence2(CommonMethod.savePic(request, folderName, file));
						break;
					case 2:
						procureTable.setPaymentEvidence3(CommonMethod.savePic(request, folderName, file));
						break;
					case 3:
						procureTable.setPaymentEvidence4(CommonMethod.savePic(request, folderName, file));
						break;
					case 4:
						procureTable.setPaymentEvidence5(CommonMethod.savePic(request, folderName, file));
						break;
					case 5:
						procureTable.setPaymentEvidence6(CommonMethod.savePic(request, folderName, file));
						break;
					default:
						break;
					}
				}
			}

			procureTable.setState(Constants.STATE_PROCURETABLE_PAID);
			if (procureTableService.updateByPrimaryKeySelective(procureTable) > 0) {
				//往消息列表里插入数据
				messageService.addMessage(Integer.parseInt(request.getParameter("id")), "采购订单引用");
				
				String identifier = request.getParameter("identifier");
				// 获取当前操作人的编号
				String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
				insertLog(operateType, identifier, Constants.OPERATE_UPDATE, new Date(), userIdentifier);
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
	 * 再次上传支付凭证时，页面中删除已存入数据库的图片
	 * 
	 * @param request
	 * @param url
	 *            付款凭证url
	 * @param id
	 *            操作数据的id
	 * @param identifier
	 *            操作数据的编号
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "deletePaymentEvidence")
	public JSONObject deletePaymentEvidence(HttpServletRequest request, String url, String id, String identifier)
			throws Exception {
		JSONObject rmsg = new JSONObject();
		int idInt = Integer.parseInt(id);
		ProcureTable procureTable = new ProcureTable();
		procureTable.setId(idInt);

		// 保存旧图片路径
		ProcureTable oldPT = procureTableService.selectByPrimaryKey(idInt);
		String pe1 = oldPT.getPaymentEvidence1();
		String pe2 = oldPT.getPaymentEvidence2();
		String pe3 = oldPT.getPaymentEvidence3();
		String pe4 = oldPT.getPaymentEvidence4();
		String pe5 = oldPT.getPaymentEvidence5();
		String pe6 = oldPT.getPaymentEvidence6();
		List<String> urlList = new ArrayList<>();
		urlList.add(pe1);
		urlList.add(pe2);
		urlList.add(pe3);
		urlList.add(pe4);
		urlList.add(pe5);
		urlList.add(pe6);

		// 清空图片字段
		procureTable.setPaymentEvidence1("");
		procureTable.setPaymentEvidence2("");
		procureTable.setPaymentEvidence3("");
		procureTable.setPaymentEvidence4("");
		procureTable.setPaymentEvidence5("");
		procureTable.setPaymentEvidence6("");
		procureTableService.updateByPrimaryKeySelective(procureTable);

		// 获取要删除的图片的数据库URL
		String projectName = request.getContextPath().split("\\/")[1];
		// 获取图片url地址
		String imgUrl = url.split(projectName + "/")[1];

		// 移除将要删除的图片url
		urlList.remove(imgUrl);
		// 重新保存数据
		for (int i = 0; i < urlList.size(); i++) {

			String file = urlList.get(i);
			switch (i) {
			case 0:
				procureTable.setPaymentEvidence1(file);
				break;
			case 1:
				procureTable.setPaymentEvidence2(file);
				break;
			case 2:
				procureTable.setPaymentEvidence3(file);
				break;
			case 3:
				procureTable.setPaymentEvidence4(file);
				break;
			case 4:
				procureTable.setPaymentEvidence5(file);
				break;
			case 5:
				procureTable.setPaymentEvidence6(file);
				break;
			default:
				break;
			}

		}
		// 删除商品展示图表中保存的图片信息
		if (procureTableService.updateByPrimaryKeySelective(procureTable) > 0) {

			List<String> oldPicUrlList = new ArrayList<>();
			oldPicUrlList.add(imgUrl);
			// 删除图片
			CommonMethod.deleteOldPic(request, folderName, oldPicUrlList);

			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			insertLog(operateType, identifier, Constants.OPERATE_UPDATE, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		} else {
			rmsg.put("success", false);
			rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
			return rmsg;
		}

	}

	/**
	 * 更新单据打印次数
	 */
	@ResponseBody
	@RequestMapping(value = "updateProcurePrintNum")
	public JSONObject updateProcurePrintNum(HttpServletRequest request, int id) throws Exception {

		JSONObject rmsg = new JSONObject();
		ProcureTable procureTable = procureTableService.selectByPrimaryKey(id);
		String identifier = procureTable.getIdentifier();
		int printNum = procureTable.getPrintNum();
		printNum += 1;
		procureTable = new ProcureTable();
		procureTable.setId(id);
		procureTable.setPrintNum(printNum);
		if (procureTableService.updateByPrimaryKeySelective(procureTable) > 0) {
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

	/**
	 * 部分入库/全部入库
	 * 
	 * @param request
	 * @param allOrPart
	 *            (1:全部入库，2：部分入库)
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/procureOrderWareHousingAllOrPart", method = RequestMethod.POST)
	public JSONObject procureOrderWareHousingAllOrPart(HttpServletRequest request, Integer allOrPart) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String pt = request.getParameter("procureTable");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(pt);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("procureCommoditys", ProcureCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		ProcureTable procureTable = (ProcureTable) net.sf.json.JSONObject.toBean(jsonobject, ProcureTable.class, map);
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);

		Date date = new Date();

		String maxIdentifier = procureTableService.selectMaxIdentifierToOpeningAndReturn();
		// 生成编号
		String identifier = SundryCodeUtil.createInvoicesIdentifier("PK", maxIdentifier);

		// 根据采购订单id获取详细信息
		ProcureTable pTMsg = procureTableService.selectMsgToDetail(procureTable.getId());
		
		// 全部入库
		if (allOrPart == 1) {
			// 修改原单据的状态，为全部完成
			ProcureTable table = new ProcureTable();
			table.setId(pTMsg.getId());
			table.setState(12);
			if (procureTableService.updateByPrimaryKeySelective(table) > 0) {
				// 修改原单据商品的到货数量，（中止数量，中止金额改为0）
				for (ProcureCommodity procureCommodity : pTMsg.getProcureCommoditys()) {
					for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {

						if (pc.getCommodityId().equals(procureCommodity.getCommodityId())) {
							procureCommodity.setArrivalQuantity(procureCommodity.getOrderNum());
							procureCommodity.setSuspendQuantity(0);
							procureCommodity.setSuspendPrice(0.0);
							Integer specWarehouseId = procureCommodity.getSpecWarehouseId();
							procureCommodity.setSpecWarehouseId(pc.getSpecWarehouseId());
							procureCommodity.setLotNumber(pc.getLotNumber());
							procureCommodityService.updateByPrimaryKeySelective(procureCommodity);
							procureCommodity.setArrivalQuantity(procureCommodity.getOrderNum());
							procureCommodity.setSpecWarehouseId(specWarehouseId);
						}

					}
				}
				// 根据获取到的信息生成一张入库单，入库单里添加到货数量，修改状态为全部完成
				pTMsg.setOriginator(userIdentifier);
				pTMsg.setIsDelete(0);
				pTMsg.setGenerateDate(date);
				pTMsg.setDepartmentId(GetSessionUtil.GetSessionUserDepartmentId(request));
				pTMsg.setBranch("总部");
				pTMsg.setPlanOrOrder(3);
				pTMsg.setBeforeIsPlan(0);
				pTMsg.setParentId(procureTable.getId());
				pTMsg.setIsOtherReceipts(procureTable.getIsOtherReceipts());
				pTMsg.setId(null);
				// 判断销售订单的有没有进行过入库的操作(部分入库)
				// 若为部分入库，则需把部分入库的入库单删除，重新生成入库单，保留部分入库单的单号
				if (pTMsg.getState() == 11) {
					// 根据parendId 和 plan_or_order=3查出是否有入库单
					table = new ProcureTable();
					table.setParentId(procureTable.getId());
					table.setPlanOrOrder(3);
					List<ProcureTable> godownEntrys = procureTableService.selectIsHasGodownEntry(table);
					// 有入库单
					if (godownEntrys != null && godownEntrys.size() > 0) {
						pTMsg.setIdentifier(godownEntrys.get(0).getIdentifier());
						// 删除保存过的全部部分入库单
						// 根据parendId 和 plan_or_order=3删除之前生成过的部分入库单
						procureTableService.deleteByParentIdAndPlanOrOrder(table);
						String[] primaryKeys = new String[godownEntrys.size()];
						for (int i = 0; i < godownEntrys.size(); i++) {
							primaryKeys[i] = godownEntrys.get(i).getId() + "";
						}
						procureCommodityService.deleteBatchByProcureTableId(primaryKeys);
					} else {
						pTMsg.setIdentifier(identifier);
					}

				}
				// 若没有入过库，则直接生成入库单
				else {
					pTMsg.setIdentifier(identifier);
				}
				pTMsg.setState(12);
				if (procureTableService.insertSelective(pTMsg) > 0) {
					Inventory inventory;
					for (ProcureCommodity procureCommodity : pTMsg.getProcureCommoditys()) {
						procureCommodity.setProcureTableId(pTMsg.getId());
						boolean isHaveInventory = true;
						// 修改库存
						inventory = new Inventory();
						inventory.setSpecificationId(procureCommodity.getCommodityId());

						for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {

							if (pc.getCommodityId().equals(procureCommodity.getCommodityId())) {
								inventory.setInventory(pc.getArrivalQuantity());
								inventory.setWarehouseId(pc.getSpecWarehouseId());
							}
						}
						// 如果有库存信息，直接修改库存，如果没有库存信息，则需要添加库存信息
						if (procureCommodity.getSpecWarehouseId() == null) {
							isHaveInventory = false;
							inventory.setCommodityNum(inventory.getInventory());
						}
						// 有库存信息，直接修改库存
						if (isHaveInventory) {
							inventoryService.updateAddGoodsInventory(inventory);
						}
						// 没有库存信息，需新增库存信息
						else {
							inventoryService.insertSelective(inventory);
						}

					}
					procureCommodityService.insertBatch(pTMsg.getProcureCommoditys());

					// 如果库存数大于预警数量 则修改是否生成采购计划单字段为0
					inventoryService.updateIsCreateProcurePlanTo0();
					//插入消息列表
					messageService.addMessage(procureTable.getId(), "入库单引用");
					// 往log表中插入操作数据
					insertLog(operateType, pTMsg.getIdentifier(), Constants.OPERATE_INSERT, new Date(), userIdentifier);
					//如果是app过来的采购订单就生成销售订单和出库单
					if(pTMsg.getIsAppOrder()!=null&&pTMsg.getIsAppOrder()==2) {
						activityService.createSalesOrder(pTMsg);
					}
					
					rmsg.put("success", true);
					rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
					return rmsg;
				}

			}
			
		}
		// 部分入库
		else {
			
			// 修改原单据的状态，为全部完成
			ProcureTable table = new ProcureTable();
			table.setId(pTMsg.getId());
			table.setState(11);
			if (procureTableService.updateByPrimaryKeySelective(table) > 0) {
				// 修改原单据的到货数量，中止数量，中止金额
				for (ProcureCommodity procureCommodity : pTMsg.getProcureCommoditys()) {
					for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
						if (pc.getCommodityId().equals(procureCommodity.getCommodityId())) {
							
							if (procureCommodity.getArrivalQuantity() == null) {
								procureCommodity.setArrivalQuantity(0);
							}
							procureCommodity.setArrivalQuantity(
									procureCommodity.getArrivalQuantity() + pc.getArrivalQuantity());
							procureCommodity.setSuspendQuantity(procureCommodity.getOrderNum()-procureCommodity.getArrivalQuantity());
							/*procureCommodity.setSuspendPrice(
									procureCommodity.getSuspendQuantity() * procureCommodity.getBusinessUnitPrice()*(1+procureCommodity.getTaxRate()));*/
							procureCommodity.setSuspendPrice(procureCommodity.getTotalTaxPrice()-(procureCommodity.getArrivalQuantity()*procureCommodity.getBusinessUnitPrice()*(1+procureCommodity.getTaxRate())));
							Integer specWarehouseId = procureCommodity.getSpecWarehouseId();
							
							procureCommodity.setSpecWarehouseId(pc.getSpecWarehouseId());
							procureCommodity.setLotNumber(pc.getLotNumber());
							procureCommodityService.updateByPrimaryKeySelective(procureCommodity);
							//供下面添加部分入库单使用
							procureCommodity.setArrivalQuantity(pc.getArrivalQuantity());
							procureCommodity.setSuspendQuantity(procureCommodity.getSuspendQuantity());
							procureCommodity.setSuspendPrice(procureCommodity.getSuspendPrice());
							procureCommodity.setSpecWarehouseId(specWarehouseId);
						}
					}
				}
				pTMsg.setOriginator(userIdentifier);
				pTMsg.setIsDelete(0);
				pTMsg.setGenerateDate(date);
				pTMsg.setDepartmentId(GetSessionUtil.GetSessionUserDepartmentId(request));
				pTMsg.setBranch("总部");
				pTMsg.setPlanOrOrder(3);
				pTMsg.setBeforeIsPlan(0);
				pTMsg.setParentId(procureTable.getId());
				pTMsg.setIsOtherReceipts(procureTable.getIsOtherReceipts());
				pTMsg.setId(null);

				// 判断销售订单的有没有进行过入库的操作(部分入库)
				// 若之前已进行过部分入库，则此时要查出之前部分入库的单号及后缀号，再生成一张部分入库的单据
				if (pTMsg.getState() == 11) {
					// 根据parendId 和 plan_or_order=3查出是否有入库单
					table = new ProcureTable();
					table.setParentId(procureTable.getId());
					table.setPlanOrOrder(3);
					List<ProcureTable> godownEntrys = procureTableService.selectIsHasGodownEntry(table);
					if (godownEntrys != null && godownEntrys.size() > 0) {
						pTMsg.setIdentifier(godownEntrys.get(0).getIdentifier());
						pTMsg.setPostfix(godownEntrys.get(godownEntrys.size() - 1).getPostfix() + 1);
					} else {
						pTMsg.setIdentifier(identifier);
						pTMsg.setPostfix(1);
					}

				}
				// 若之前没有进行过入库操作，则此时直接生成部分入库单，记录采购订单id以及生成后缀号
				else {
					// 根据获取到的信息生成一张入库单，入库单里添加到货数量，中止数量，中止金额，修改状态为部分完成
					pTMsg.setIdentifier(identifier);
					pTMsg.setPostfix(1);

				}
				pTMsg.setState(11);
				if (procureTableService.insertSelective(pTMsg) > 0) {
					Inventory inventory;
					for (ProcureCommodity procureCommodity : pTMsg.getProcureCommoditys()) {
						procureCommodity.setProcureTableId(pTMsg.getId());

						// 如果有库存信息，直接修改库存，如果没有库存信息，则需要添加库存信息

						for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
							if (pc.getCommodityId().equals(procureCommodity.getCommodityId())) {
								// 修改库存
								inventory = new Inventory();
								inventory.setSpecificationId(procureCommodity.getCommodityId());
								inventory.setInventory(procureCommodity.getArrivalQuantity());
								inventory.setCommodityNum(procureCommodity.getArrivalQuantity());
								inventory.setWarehouseId(pc.getSpecWarehouseId());
								if (procureCommodity.getSpecWarehouseId() == null) {
									inventory.setCommodityNum(procureCommodity.getArrivalQuantity());
									inventoryService.insertSelective(inventory);
								} else {
									inventoryService.updateAddGoodsInventory(inventory);
								}

							}
						}

					}
					procureCommodityService.insertBatch(pTMsg.getProcureCommoditys());

					// 如果库存数大于预警数量 则修改是否生成采购计划单字段为0
					inventoryService.updateIsCreateProcurePlanTo0();

					// 往log表中插入操作数据
					insertLog(operateType, pTMsg.getIdentifier(), Constants.OPERATE_INSERT, new Date(), userIdentifier);

					rmsg.put("success", true);
					rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
					return rmsg;
				}
			}
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 部分入库送至采购开单
	 * @param request
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/warehouseHalfApplyBilling", method = RequestMethod.POST)
	public JSONObject warehouseHalfApplyBilling(HttpServletRequest request, Integer parentId) throws Exception {
		JSONObject rmsg = new JSONObject();
		ProcureTable procureTable=new ProcureTable();
		procureTable.setParentId(parentId);
		procureTable.setPlanOrOrder(3);
		//根据parentid查找所有部分入库的单据信息，以供添加log日志使用
		List<ProcureTable> procureTables=procureTableService.selectIsHasGodownEntry(procureTable);
		
		//获取其中一张采购部分入库单的详情 供重新生成部分入库单使用
		ProcureTable partWarehouseMsg=procureTableService.selectMsgToDetail(procureTables.get(0).getId());
		//获取采购订单详情
		ProcureTable procureTable2=procureTableService.selectMsgToDetail(parentId);
		
		String updateIdentifierName="";
		String insertIdentifierName="";
		String deleteIdentifierName="";
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		//获取当前操作时间
		Date date=new Date();
		
		//修改采购订单的状态为15(部分入库通知销售开)
		procureTable=new ProcureTable();
		procureTable.setId(parentId);
		procureTable.setState(15);
		procureTableService.updateByPrimaryKeySelective(procureTable);
		//保存部分入库单的部分数据重新生成统一的一张部分入库单，删除之前已经保存好的部分入库单
		partWarehouseMsg.setId(null);
		partWarehouseMsg.setPostfix(-1);
		partWarehouseMsg.setState(15);//修改入库单状态为15(部分入库通知销售开单)
		partWarehouseMsg.setOriginator(userIdentifier);
		partWarehouseMsg.setGenerateDate(date);
		
		if(procureTableService.insertSelective(partWarehouseMsg)>0){
			for(ProcureCommodity pc:procureTable2.getProcureCommoditys()){
				for(ProcureCommodity partWPc:partWarehouseMsg.getProcureCommoditys()){
					if(pc.getCommodityId().equals(partWPc.getCommodityId())){
						partWPc.setId(null);
						partWPc.setProcureTableId(partWarehouseMsg.getId());
						partWPc.setArrivalQuantity(pc.getArrivalQuantity());
						partWPc.setSuspendQuantity(pc.getSuspendQuantity());
						partWPc.setSuspendPrice(pc.getSuspendPrice());
					}
				}
			}
			procureCommodityService.insertBatch(partWarehouseMsg.getProcureCommoditys());
			//插入消息列表
			messageService.addMessage(partWarehouseMsg.getParentId(), "入库单引用");
			
			//删除之前已经保存好的部分入库单
			for(ProcureTable table:procureTables){
				procureTableService.delete(table.getId());
				procureCommodityService.deleteByProcureTableId(table.getId());
			}
			
			//修改添加log
			updateIdentifierName+=procureTable2.getIdentifier();
			insertLog(operateType, updateIdentifierName, Constants.OPERATE_UPDATE, date, userIdentifier);
			
			for(int i=0;i<procureTables.size();i++){
				if(i<procureTables.size()-1){
					deleteIdentifierName+=procureTables.get(i).getIdentifier()+"-"+procureTables.get(i).getPostfix()+",";
				}
				else{
					deleteIdentifierName+=procureTables.get(i).getIdentifier()+"-"+procureTables.get(i).getPostfix();
				}	
			}
			//删除添加log
			insertLog(operateType, deleteIdentifierName, Constants.OPERATE_DELETE, date, userIdentifier);
			//新增添加log
			insertIdentifierName+=partWarehouseMsg.getIdentifier();
			insertLog(operateType, insertIdentifierName, Constants.OPERATE_INSERT, date, userIdentifier);
			
			rmsg.put("success", true);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);			
			return rmsg;
		}
		else{
			rmsg.put("success", false);
			rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);	
			return rmsg;
		}
		
	}

	/**
	 * 生成采购开单
	 * 
	 * @param request
	 * @param id
	 *            入库单id
	 * @param orderType
	 *            采购开单类型
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "createProcureBilling")
	public JSONObject createProcureBilling(HttpServletRequest request, int id, int orderType) throws Exception {

		JSONObject rmsg = new JSONObject();
		// 根据入库单id 查出入库单信息
		ProcureTable procureTable = procureTableService.selectMsgToDetail(id);
		// 生成销售开单，修改销售订单和销售开单状态为13(已开单)以及添加销售开单类型
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		int userDepartmentId = GetSessionUtil.GetSessionUserDepartmentId(request);
		Date date = new Date();
		ProcureTable pt = new ProcureTable();
		pt.setState(13);
		pt.setId(procureTable.getParentId());
		// 修改销售订单的状态
		procureTableService.updateByPrimaryKeySelective(pt);
		pt = new ProcureTable();
		pt.setState(13);
		pt.setId(procureTable.getId());
		// 修改入库单的状态
		procureTableService.updateByPrimaryKeySelective(pt);

		procureTable.setId(null);
		procureTable.setOriginator(userIdentifier);// 制单人
		procureTable.setDepartmentId(userDepartmentId);//部门
		procureTable.setGenerateDate(date);
		String maxIdentifier = procureTableService.selectMaxIdentifierToOpeningAndReturn();
		// 生成编号
		String identifier = SundryCodeUtil.createInvoicesIdentifier("PK", maxIdentifier);
		procureTable.setIdentifier(identifier);
		procureTable.setState(13);
		procureTable.setOrderType(orderType);
		procureTable.setPlanOrOrder(4);// 销售开单
		procureTable.setBeforeIsPlan(0);
	   
		if (procureTableService.insertSelective(procureTable)> 0) {
			for (ProcureCommodity procureCommodity : procureTable.getProcureCommoditys()) {
				procureCommodity.setProcureTableId(procureTable.getId());
			}
			procureCommodityService.insertBatch(procureTable.getProcureCommoditys());
			for (ProcureCommodity procureCommodity : procureTable.getProcureCommoditys()) {
				
				//更新移动平均价
				Double  avgPrice=commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(procureCommodity.getCommodityId());
				if (avgPrice!=null) {
					//System.out.println("移动平均价"+avgPrice);
					//System.out.println("单位名称>"+procureCommodity.getCommoditySpecification().getBaseUnitName());
					int  unitId=unitService.selectMsgByunitId(procureCommodity.getCommodityId(),procureCommodity.getCommoditySpecification().getBaseUnitName());
					//System.out.println("unitId>>>>>"+unitId);
					Unit unit=new Unit();
					unit.setMiniPrice(avgPrice);
					unit.setId(unitId);
					int a=unitService.updateByPrimaryKeySelective(unit);
					
					//System.out.println("SQL执行状态"+a);
				}else {
					System.out.println("移动平均价为空");
				}
			}
			//procureCommodityService.insertBatch(procureTable.getProcureCommoditys());
			
			//清除无用的信息提醒
			messageService.clearMessage(procureTable.getParentId(), 4);
			insertLog(Constants.TYPE_LOG_PROCURE, identifier, Constants.OPERATE_INSERT, new Date(), userIdentifier);
			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	/* 退货流程 */
	
	/**
	 * 获取供退货单引用的销售订单信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getPurchaseTableToReturnedPurchase", method = RequestMethod.GET)
	public List<ProcureTable> getPurchaseTableToReturnedPurchase(HttpServletRequest request) throws Exception {
		return procureTableService.getPurchaseTableByState();
	}

	/**
	 * 生成退货单
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/createReturnedPurchase", method = RequestMethod.POST)
	public JSONObject createReturnedPurchase(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String pt = request.getParameter("procureTable");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(pt);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("procureCommoditys", ProcureCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		ProcureTable procureTable = (ProcureTable) net.sf.json.JSONObject.toBean(jsonobject, ProcureTable.class, map);

		// 生成订单号
		String maxIdentifier = procureTableService.selectMaxIdentifierToOpeningAndReturn();
		String identifier = SundryCodeUtil.createInvoicesIdentifier("PK", maxIdentifier);
		procureTable.setIdentifier(identifier);
		// 生成日期
		Date date = new Date();
		procureTable.setGenerateDate(date);
		// 制单人
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		procureTable.setOriginator(userIdentifier);
		// 分支机构默认总部
		procureTable.setBranch("总部");
		// 保存制单人部门
		procureTable.setDepartmentId(GetSessionUtil.GetSessionUserDepartmentId(request));
		// 单据类型为 5 采购退货单
		procureTable.setPlanOrOrder(5);
		// 是否已删除默认为0 未删
		procureTable.setIsDelete(0);
		//保存单据状态为1 未送审
		procureTable.setState(1);
		procureTable.setBeforeIsPlan(0);

		// 生成退货单
		if (procureTableService.insertSelective(procureTable) > 0) {
			// 保存退货单商品信息
			for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
				pc.setProcureTableId(procureTable.getId());
			}
			procureCommodityService.insertBatch(procureTable.getProcureCommoditys());
			// 锁定库存
			// 获取商品所属的仓库id以及商品信息
			List<Inventory> inventories = new ArrayList<>();
			Inventory inventory;
			for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
				if (pc.getSpecWarehouseId() != null && pc.getSpecWarehouseId() > 0) {
					inventory = new Inventory();
					inventory.setSpecificationId(pc.getCommodityId());
					inventory.setWarehouseId(pc.getSpecWarehouseId());
					inventory.setOccupiedInventory(pc.getArrivalQuantity());
					inventories.add(inventory);
				}
			}
			// 修改各个仓库的占用数量
			if (inventories.size() > 0) {
				for (Inventory inv : inventories) {
					inventoryService.updateOccupiedInventory(inv);
				}

			}
			// 记录log日志
			insertLog(Constants.TYPE_LOG_PROCURE, identifier, Constants.OPERATE_INSERT, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
			return rmsg;
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 编辑采购退货单
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/updateReturnedPurchase", method = RequestMethod.POST)
	public JSONObject updateReturnedPurchase(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String pt = request.getParameter("procureTable");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(pt);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("procureCommoditys", ProcureCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		ProcureTable procureTable = (ProcureTable) net.sf.json.JSONObject.toBean(jsonobject, ProcureTable.class, map);

		// 制单人
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		//procureTable.setOriginator(userIdentifier);

		// 先保存修改前的信息，供下面解除锁定使用
		ProcureTable table = procureTableService.selectMsgToDetail(procureTable.getId());
		// 更新退货单
		if (procureTableService.updateByPrimaryKeySelective(procureTable) > 0) {
			List<Inventory> inventories = new ArrayList<>();
			Inventory inventory = new Inventory();
			// 解除锁定
			for (ProcureCommodity pc : table.getProcureCommoditys()) {
				inventory = new Inventory();
				inventory.setSpecificationId(pc.getCommodityId());
				inventory.setOccupiedInventory(pc.getArrivalQuantity());
				inventories.add(inventory);
			}
			// 修改各个仓库的占用数量
			if (inventories.size() > 0) {
				for (Inventory inv : inventories) {
					inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inv);
				}

			}
			// 删除之前保存好的退货商品信息
			procureCommodityService.deleteByProcureTableId(procureTable.getId());

			// 重新保存退货商品信息
			procureCommodityService.insertBatch(procureTable.getProcureCommoditys());
			// 锁定库存
			// 获取商品所属的仓库id以及商品信息
			inventories = new ArrayList<>();
			for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
				if (pc.getSpecWarehouseId() != null && pc.getSpecWarehouseId() > 0) {
					inventory = new Inventory();
					inventory.setSpecificationId(pc.getCommodityId());
					inventory.setWarehouseId(pc.getSpecWarehouseId());
					inventory.setOccupiedInventory(pc.getArrivalQuantity());
					inventories.add(inventory);
				}
			}
			// 修改各个仓库的占用数量
			if (inventories.size() > 0) {
				for (Inventory inv : inventories) {
					inventoryService.updateOccupiedInventory(inv);
				}

			}
			// 记录log日志
			insertLog(Constants.TYPE_LOG_PROCURE, procureTable.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
					userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 删除采购退货单
	 * @param request
	 * @param id 退货单id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteReturnedPurchase", method = RequestMethod.POST)
	public JSONObject deleteReturnedPurchase(HttpServletRequest request,Integer id) throws Exception {
		JSONObject rmsg = new JSONObject();
		//保存删除前的信息
		ProcureTable table = procureTableService.selectMsgToDetail(id);
		//删除退货单
		if(procureTableService.deleteByPrimaryKey(id)>0){
			//procureCommodityService.deleteByProcureTableId(id);
			//解除锁定
			List<Inventory> inventories = new ArrayList<>();
			Inventory inventory = new Inventory();
			// 解除锁定
			for (ProcureCommodity pc : table.getProcureCommoditys()) {
				inventory = new Inventory();
				inventory.setSpecificationId(pc.getCommodityId());
				inventory.setOccupiedInventory(pc.getArrivalQuantity());
				inventories.add(inventory);
			}
			// 修改各个仓库的占用数量
			if (inventories.size() > 0) {
				for (Inventory inv : inventories) {
					inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inv);
				}

			}
			//添加log日志
			insertLog(Constants.TYPE_LOG_PROCURE, table.getIdentifier(), Constants.OPERATE_DELETE, new Date(),
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
	 * 修改采购退货单状态
	 * @param request
	 * @param id 退货单id
	 * @param state 退货单状态(2:已送审，3：已通过，4：已驳回，14：退货确定出库)
	 * @param identifier 单据编号
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/updateReturnedPurchaseState", method = RequestMethod.POST)
	public JSONObject updateReturnedPurchaseState(HttpServletRequest request,Integer id,Integer state) throws Exception {
		JSONObject rmsg = new JSONObject();
		ProcureTable procureTable=new ProcureTable();
		procureTable.setId(id);
		procureTable.setState(state);
		if(state==3||state==4){
			procureTable.setReviewer(GetSessionUtil.GetSessionUserIdentifier(request));
		}
		ProcureTable table = procureTableService.selectMsgToDetail(id);
		
		//修改状态
		if(procureTableService.updateByPrimaryKeySelective(procureTable)>0){
					
			//退货确定出库操作
			if(state==14){
				//减库存，解除锁定
				List<Inventory> inventories = new ArrayList<>();
				Inventory inventory ;
				for (ProcureCommodity pc : table.getProcureCommoditys()) {
					inventory = new Inventory();
					inventory.setSpecificationId(pc.getCommodityId());
					inventory.setOccupiedInventory(pc.getArrivalQuantity());
					inventory.setWarehouseId(pc.getSpecWarehouseId());
					inventory.setInventory(pc.getArrivalQuantity());
					inventories.add(inventory);
				}
				// 修改各个仓库的占用数量,并减库存
				if (inventories.size() > 0) {
					for (Inventory inv : inventories) {
						inventoryService.updateInventoryDown(inv);
					}
				}
				//清除无用的信息提醒
				messageService.clearMessage(id, 4);
			}
			else if(state==2){
				//插入消息列表
				messageService.addMessage(id, "采购退货单审核");
			}
			else if(state==3){
				//插入消息列表
				messageService.addMessage(id, "采购退货单出库");
			}
			else if(state==4){
				//插入消息列表
				messageService.addMessage(id, "采购退货单");
			}
			
			//往log表中插入日志
			insertLog(Constants.TYPE_LOG_PROCURE, table.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
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
	 * 打印退货单
	 * @param request
	 * @param id 退货单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "printReturnedPurchase", method = RequestMethod.GET)
	public JSONObject printReturnedPurchase(HttpServletRequest request, Integer id) {
		ProcureTable procureTable = procureTableService.selectMsgToDetail(id);

		return createReturnedPurchaseJSON(procureTable);
	}	

	// 私有方法

	/**
	 * 生成退货单单据打印页面所需的信息 返回值为JSON格式
	 * 
	 * @param procureTable
	 * @return
	 */
	private JSONObject createReturnedPurchaseJSON(ProcureTable procureTable) {
		JSONObject JSON = new JSONObject();	
		JSON.put("title", "退货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JSON.put("date", dateFormat.format(procureTable.getGenerateDate()));
		JSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("采购退货");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("供应商");
		if(procureTable.getSupcto()!=null){
			head.setFieldValue(procureTable.getSupcto().getName());
		}
		else{
			head.setFieldValue("");
		}
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		if(procureTable.getShippingMode()!=null){
			head.setFieldValue(procureTable.getShippingMode().getName());
		}
		else{
			head.setFieldValue("");
		}	
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("送货地址");
		head.setFieldValue(procureTable.getGoodsArrivalPlace());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("送货人");
		head.setFieldValue(procureTable.getDeliveryman());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(procureTable.getFax());
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(procureTable.getPhone());
		heads.add(head);
		JSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "规格编码", "货品名称", "规格", "单位","仓库", "单价", "数量", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			String[] tbody = { pc.getCommoditySpecification().getSpecificationIdentifier(),pc.getCommoditySpecification().getCommodity().getName(),pc.getCommoditySpecification().getSpecificationName(),pc.getCommoditySpecification().getBaseUnitName(),
					pc.getCommoditySpecification().getSpecWarehouseName()==null?"暂无":pc.getCommoditySpecification().getSpecWarehouseName(),pc.getBusinessUnitPrice()+"",pc.getArrivalQuantity()+"",pc.getTotalPrice()+""};
			
			totalMoney += pc.getTotalPrice();
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
		if (procureTable.getOriginatorName() != null) {
			footer.setFieldValue(
					procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (procureTable.getReviewer() != null) {
			if (procureTable.getReviewerName() != null) {
				footer.setFieldValue(
						procureTable.getReviewer() + "(" + procureTable.getReviewerName() + ")");
			} else {
				footer.setFieldValue(procureTable.getReviewer());
			}
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary());
		footers.add(footer);
		JSON.put("footer", footers);
		/* footer end */

		return JSON;
	}
	/**
	 * 采购计划单详情
	 * @param request
	 * @param id 采购计划单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "detailPurchasePlanOrder")
	public JSONObject detailPurchasePlanOrder(HttpServletRequest request, Integer id) {
		ProcureTable procureTable = procureTableService.selectMsgToDetail(id);

		return createPurchasePlanOrderJSON(procureTable);
	}
	
	/**
	 * 生成采购计划单订单单据页面详情所需的信息 返回值为JSON格式
	 * 
	 * @param procureTable
	 * @return
	 */
	private JSONObject createPurchasePlanOrderJSON(ProcureTable procureTable) {
		JSONObject JSON = new JSONObject();	
		JSON.put("title", "采购计划单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JSON.put("date", dateFormat.format(procureTable.getGenerateDate()));
		JSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		/* 到货日期与到货时间一至 */
		String goodsArrivalTime="";
		
		head.setFieldName("供应商");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
		SimpleDateFormat effectivePeriodEnd = new SimpleDateFormat("yyyy-MM-dd");
		head.setFieldValue(procureTable.getEffectivePeriodEnd()!=null?effectivePeriodEnd.format(procureTable.getEffectivePeriodEnd()):"");	
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("到货时间");
		SimpleDateFormat goodsArrivalTimeFormate = new SimpleDateFormat("yyyy-MM-dd");
		goodsArrivalTime=procureTable.getGoodsArrivalTime()!=null?goodsArrivalTimeFormate.format(procureTable.getGoodsArrivalTime()):"";
		head.setFieldValue(goodsArrivalTime);
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("到货地点");
		head.setFieldValue(procureTable.getGoodsArrivalPlace()!=null?procureTable.getGoodsArrivalPlace():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		head.setFieldValue(procureTable.getShippingMode()!=null?procureTable.getShippingMode().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货人");
		head.setFieldValue(procureTable.getDeliveryman()!=null?procureTable.getDeliveryman():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(procureTable.getFax()!=null?procureTable.getFax():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("联系方式");
		head.setFieldValue(procureTable.getPhone()!=null?procureTable.getPhone():"");
		heads.add(head);
		
		
		if(procureTable.getIsAppOrder()!=null&&procureTable.getIsAppOrder().equals(2)){//是APP来的订单
			head = new FormHeadAndFooter();
			head.setFieldName("结算方式");
			head.setFieldValue("");
			heads.add(head);
			
			/* 订货人即为单据生成人 */
			head = new FormHeadAndFooter();
			head.setFieldName("订货人");
			head.setFieldValue("APP");
			heads.add(head);
			
			head = new FormHeadAndFooter();
			head.setFieldName("预付金额");
			head.setFieldValue("0");
			heads.add(head);
		}else {//不是APP来的订单
			head = new FormHeadAndFooter();
			head.setFieldName("结算方式");
			head.setFieldValue(procureTable.getSettlementType()!=null?procureTable.getSettlementType().getName():"");
			heads.add(head);
			
			/* 订货人即为单据生成人 */
			head = new FormHeadAndFooter();
			head.setFieldName("订货人");
			head.setFieldValue(procureTable.getOrderer() != null?procureTable.getOrderer():"");
			heads.add(head);
			
			head = new FormHeadAndFooter();
			head.setFieldName("预付金额");
			
			if(procureTable.getSettlementType()!=null&&procureTable.getSettlementType().getName().equals("预付款")) {
				head.setFieldValue(procureTable.getPrepaidAmount() != null?procureTable.getPrepaidAmount()+"":"0");
			}else {
				head.setFieldValue("0");
			}
			heads.add(head);
			
		}
		JSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "品牌","单位", "业务数量", "原始单价", "折扣%", "含税价","业务单价","税率","税额","货款","金额","批号","备注","到货日期"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//业务数量
		Integer totalCount = 0;
		//税额
		Double amountOfTax=0.0;
		//货款
		Double paymentForGoods=0.0;
		//金额
		Double totalPrice = 0.0;
		
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			
			String[] tbody = { 
					pc.getCommoditySpecification().getSpecificationIdentifier(),
					pc.getCommoditySpecification().getCommodity().getName(),
					pc.getCommoditySpecification().getSpecificationName(),
					pc.getCommoditySpecification().getCommodity().getBrand(),
					pc.getCommoditySpecification().getBaseUnitName(),
					pc.getOrderNum()==null?"0":pc.getOrderNum()+"",
					(pc.getOriginalUnitPrice()==null?0.0:pc.getOriginalUnitPrice())+"",
					(pc.getDiscount()==null?0:pc.getDiscount())+"",
					(pc.getContainsTaxPrice()==null?0.0:pc.getContainsTaxPrice())+"",
					(pc.getBusinessUnitPrice()==null?0.0:pc.getBusinessUnitPrice())+"",
					(pc.getTaxRate()==null?0.0:pc.getTaxRate())+"",
					(pc.getAmountOfTax()==null?0.0:pc.getAmountOfTax())+"",
					(pc.getPaymentForGoods()==null?0.0:pc.getPaymentForGoods())+"",
					(pc.getTotalPrice()==null?0.0:pc.getTotalPrice())+"",
					(pc.getLotNumber()==null?"":pc.getLotNumber())+"",
					(pc.getRemarks()==null?"":pc.getRemarks())+"",
					goodsArrivalTime
			};
			totalCount += pc.getOrderNum();
			amountOfTax+=(pc.getAmountOfTax()==null?0.0:pc.getAmountOfTax());
			paymentForGoods+=(pc.getPaymentForGoods()==null?0.0:pc.getPaymentForGoods());
			totalPrice+=(pc.getTotalPrice()==null?0:pc.getTotalPrice());
			
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal", totalCount);
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "11");
		totalCountJSON.put("colTotal", new BigDecimal(amountOfTax).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "12");
		totalCountJSON.put("colTotal", new BigDecimal(paymentForGoods).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "13");
		totalCountJSON.put("colTotal", new BigDecimal(totalPrice).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total",totalCountList);

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
		if (procureTable.getDepartment() != null) {
			footer.setFieldValue(procureTable.getDepartment().getName());
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (procureTable.getOriginatorName() != null) {
			footer.setFieldValue(
					procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator()!=null?procureTable.getOriginator():"");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (procureTable.getReviewer() != null) {
			if (procureTable.getReviewerName() != null) {
				footer.setFieldValue(
						procureTable.getReviewer() + "(" + procureTable.getReviewerName() + ")");
			} else {
				footer.setFieldValue(procureTable.getReviewer());
			}
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary()!=null?procureTable.getSummary():"");
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(procureTable.getBranch()!=null?procureTable.getBranch():"总部");
		footers.add(footer);
		
		JSON.put("footer", footers);
		/* footer end */

		return JSON;
	}
	
	
	
	/**
	 * 采购订单详情
	 * @param request
	 * @param id 采购订单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "detailPurchaseOrder")
	public JSONObject detailPurchaseOrder(HttpServletRequest request, Integer id) {
		ProcureTable procureTable = procureTableService.selectMsgToDetail(id);

		return createPurchaseOrderJSON(procureTable);
	}	
	/**
	 * 生成采购订单单据页面详情所需的信息 返回值为JSON格式
	 * 
	 * @param procureTable
	 * @return
	 */
	private JSONObject createPurchaseOrderJSON(ProcureTable procureTable) {
		JSONObject JSON = new JSONObject();	
		JSON.put("title", "采购订单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JSON.put("date", dateFormat.format(procureTable.getGenerateDate()));
		JSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		/* 到货日期与到货时间一至 */
		String goodsArrivalTime="";
		
		head.setFieldName("供应商");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("有效期至");
		SimpleDateFormat effectivePeriodEnd = new SimpleDateFormat("yyyy-MM-dd");
		head.setFieldValue(procureTable.getEffectivePeriodEnd()!=null?effectivePeriodEnd.format(procureTable.getEffectivePeriodEnd()):"");	
		heads.add(head);
		
		
		head = new FormHeadAndFooter();
		head.setFieldName("合同号");
		head.setFieldValue(procureTable.getContractNumber()!=null?procureTable.getContractNumber():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("到货时间");
		SimpleDateFormat goodsArrivalTimeFormate = new SimpleDateFormat("yyyy-MM-dd");
		goodsArrivalTime=procureTable.getGoodsArrivalTime()!=null?goodsArrivalTimeFormate.format(procureTable.getGoodsArrivalTime()):"";
		head.setFieldValue(goodsArrivalTime);
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("到货地点");
		head.setFieldValue(procureTable.getGoodsArrivalPlace()!=null?procureTable.getGoodsArrivalPlace():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		head.setFieldValue(procureTable.getShippingMode()!=null?procureTable.getShippingMode().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货人");
		head.setFieldValue(procureTable.getDeliveryman()!=null?procureTable.getDeliveryman():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(procureTable.getFax()!=null?procureTable.getFax():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(procureTable.getPhone()!=null?procureTable.getPhone():"");
		heads.add(head);
		
		if(procureTable.getOrderer()==null){
			if(procureTable.getIsAppOrder()!=null&&procureTable.getIsAppOrder()==2){//是APP来的订单
				head = new FormHeadAndFooter();
				head.setFieldName("结算方式");
				head.setFieldValue("");
				heads.add(head);
				
				/* 订货人即为单据生成人 */
				head = new FormHeadAndFooter();
				head.setFieldName("订货人");
				head.setFieldValue("APP");
				heads.add(head);
				
				head = new FormHeadAndFooter();
				head.setFieldName("预付金额");
				head.setFieldValue("0");
				heads.add(head);
				
			
			}else {
				head = new FormHeadAndFooter();
				head.setFieldName("结算方式");
				if(procureTable.getSettlementType()!=null) {
					head.setFieldValue(procureTable.getSettlementType()==null?"":procureTable.getSettlementType().getName());
				}else {
					head.setFieldValue("");
				}
				heads.add(head);
				
				/* 订货人即为单据生成人 */
				head = new FormHeadAndFooter();
				head.setFieldName("订货人");
				if (procureTable.getOriginatorName() != null) {
					head.setFieldValue(procureTable.getOriginatorName());
				} else {
					head.setFieldValue("");
				}
				heads.add(head);
				
				head = new FormHeadAndFooter();
				head.setFieldName("预付金额");
				
				if(procureTable.getSettlementType()!=null&&procureTable.getSettlementType().getName().equals("预付款")) {
					head.setFieldValue(procureTable.getPrepaidAmount()==null?"0.0":procureTable.getPrepaidAmount()+"");
				}else {
					head.setFieldValue("0.0");
				}
				heads.add(head);
			}
		}
		else{
			head = new FormHeadAndFooter();
			head.setFieldName("结算方式");
			if(procureTable.getSettlementType()!=null) {
				head.setFieldValue(procureTable.getSettlementType()==null?"":procureTable.getSettlementType().getName());
			}else {
				head.setFieldValue("");
			}
			heads.add(head);
			
			head = new FormHeadAndFooter();
			head.setFieldName("订货人");
			head.setFieldValue(procureTable.getOrderer()==null?"":procureTable.getOrderer());	
			heads.add(head);
			
			head = new FormHeadAndFooter();
			head.setFieldName("预付金额");
			if(procureTable.getSettlementType()!=null&&procureTable.getSettlementType().getName().equals("预付款")) {
				head.setFieldValue(procureTable.getPrepaidAmount()==null?"0.0":procureTable.getPrepaidAmount()+"");
			}else {
				head.setFieldValue("0.0");
			}
			heads.add(head);
		}
		
		
		JSON.put("head", heads);
		
		
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "品牌","单位", "业务数量(袋)","业务数量(箱)", "原始单价", "折扣%","业务单价","税率","税额","价税合计","批号","备注","到货日期"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		Double amountOfTax=0.0;
		Integer totalCount = 0;
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(pc.getCommodityId());
 			Integer commodityNum=pc.getOrderNum();
			Integer boxNum=commoditySpecification.getUnits().size()>1?commodityNum/commoditySpecification.getUnits().get(1).getRatioMolecular():0;
			
			String[] tbody = { 
					pc.getCommoditySpecification().getSpecificationIdentifier(),
					pc.getCommoditySpecification().getCommodity().getName(),
					pc.getCommoditySpecification().getSpecificationName(),
					pc.getCommoditySpecification().getCommodity().getBrand(),
					pc.getCommoditySpecification().getBaseUnitName(),
					pc.getOrderNum()+"",
					boxNum+"",
					(pc.getOriginalUnitPrice()==null?0.0:pc.getOriginalUnitPrice())+"",
					(pc.getDiscount()==null?0:pc.getDiscount())+"",
					pc.getBusinessUnitPrice()+"",
					(pc.getTaxRate()==null?0.0:pc.getTaxRate())+"",
					(pc.getAmountOfTax()==null?0.0:pc.getAmountOfTax())+"",
					(pc.getTotalTaxPrice()==null?0.0:pc.getTotalTaxPrice())+"",
					(pc.getLotNumber()!=null?pc.getLotNumber():""),
					(pc.getRemarks()!=null?pc.getRemarks():""),
					goodsArrivalTime
			};
			
			totalMoney += (pc.getTotalTaxPrice()==null?0.0:pc.getTotalTaxPrice());
			totalCount += pc.getOrderNum();
			amountOfTax+=(pc.getAmountOfTax()==null?0.0:pc.getAmountOfTax());
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal", totalCount);
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "12");
		totalCountJSON.put("colTotal", new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "11");
		totalCountJSON.put("colTotal", new BigDecimal(amountOfTax).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total",totalCountList);

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
		if (procureTable.getDepartment() != null) {
			footer.setFieldValue(procureTable.getDepartment().getName());
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (procureTable.getOriginatorName() != null) {
			footer.setFieldValue(
					procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator()==null?"":procureTable.getOriginator());
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (procureTable.getReviewer() != null) {
			if (procureTable.getReviewerName() != null) {
				footer.setFieldValue(
						procureTable.getReviewer() + "(" + procureTable.getReviewerName() + ")");
			} else {
				footer.setFieldValue(procureTable.getReviewer());
			}
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary()!=null?procureTable.getSummary():"");
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(procureTable.getBranch()!=null?procureTable.getBranch():"总部");
		footers.add(footer);
		
		JSON.put("footer", footers);
		/* footer end */

		return JSON;
	}
	
	/**
	 * 采购开单详情
	 * @param request
	 * @param id 采购开单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "detailPurchaseBilling")
	public JSONObject detailPurchaseBilling(HttpServletRequest request, Integer id) {
		ProcureTable procureTable = procureTableService.selectMsgToDetail(id);

		return createPurchaseBillingJSON(procureTable);
	}
	
	/**
	 * 生成采购开单单据页面详情所需的信息 返回值为JSON格式
	 * 
	 * @param procureTable
	 * @return
	 */
	private JSONObject createPurchaseBillingJSON(ProcureTable procureTable) {
		JSONObject JSON = new JSONObject();	
		JSON.put("title", "采购开单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JSON.put("date", dateFormat.format(procureTable.getGenerateDate()));
		JSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		/* 到货日期与到货时间一至 */
		String goodsArrivalTime="";
		
		
		head.setFieldName("单据类型");
		head.setFieldValue("采购开单");	
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("供应商");
		if(procureTable.getIsOtherReceipts()!=null&&procureTable.getIsOtherReceipts()==1) {
			head.setFieldValue("其他");
		}else {
			head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getName():"");
		}
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("结算方式");
		head.setFieldValue(procureTable.getSettlementType()!=null?procureTable.getSettlementType().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("结算账户");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getBankAccount():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		head.setFieldValue(procureTable.getShippingMode()!=null?procureTable.getShippingMode().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货地址");
		head.setFieldValue(procureTable.getGoodsArrivalPlace()!=null?procureTable.getGoodsArrivalPlace():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货人");
		head.setFieldValue(procureTable.getDeliveryman()!=null?procureTable.getDeliveryman():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(procureTable.getFax()!=null?procureTable.getFax():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(procureTable.getPhone()!=null?procureTable.getPhone():"");
		heads.add(head);
		JSON.put("head", heads);
		
		
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "品牌","单位", "开单数量", "原始单价", "折扣%","业务单价","税率","税款","价税合计","批号","备注","生产日期","有效期至"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//业务数量
		Integer totalCount = 0;
		//税额/税款
		Double amountOfTax=0.0;
		//价税合计
		Double totalTaxPrice=0.0;
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			Integer partNum=pc.getArrivalQuantity()==null?0:pc.getArrivalQuantity(); //入库数量
			Double businessUnitPrice=pc.getBusinessUnitPrice();//业务单价
			System.out.println("businessUnitPrice:"+businessUnitPrice);
			Double tax=pc.getTaxRate();//税率
			Double partTaxPrice=partNum*businessUnitPrice*tax;//税款
			Double oneTotalTaxPrice=partNum*businessUnitPrice*(1+tax);//价税合计
			//不是从其他收货单引用来的
			if(procureTable.getIsOtherReceipts()==0){
				partTaxPrice=partNum*businessUnitPrice*tax;
				oneTotalTaxPrice=partNum*businessUnitPrice*(1+tax);
			}
			else{
				//是部分入库
				if(pc.getSuspendQuantity()!=null&&pc.getSuspendQuantity()>0){
					partTaxPrice=partNum*businessUnitPrice*tax;
					oneTotalTaxPrice=partNum*businessUnitPrice*(1+tax);
				}
				//全部入库
				else{
					partTaxPrice=pc.getAmountOfTax();
					oneTotalTaxPrice=pc.getTotalTaxPrice();
				}
			}
			DecimalFormat df = new DecimalFormat("#.##");
			String[] tbody = { 
					pc.getCommoditySpecification().getSpecificationIdentifier(),
					pc.getCommoditySpecification().getCommodity().getName(),
					pc.getCommoditySpecification().getSpecificationName(),
					pc.getCommoditySpecification().getCommodity().getBrand(),
					pc.getCommoditySpecification().getBaseUnitName(),
					partNum+"",
					(pc.getOriginalUnitPrice()==null?0.0:pc.getOriginalUnitPrice())+"",
					(pc.getDiscount()==null?0:pc.getDiscount())+"",
					businessUnitPrice+"",
					tax+"",
					df.format(partTaxPrice),
					df.format(oneTotalTaxPrice),
					(pc.getLotNumber()==null?"":pc.getLotNumber())+"",
					(pc.getRemarks()==null?"":pc.getRemarks())+"",
					"",""
			};
			totalCount += partNum;
			amountOfTax+=partTaxPrice;
			totalTaxPrice+=oneTotalTaxPrice;
			
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal", totalCount);
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "10");
		totalCountJSON.put("colTotal", new BigDecimal(amountOfTax).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "11");
		totalCountJSON.put("colTotal", new BigDecimal(totalTaxPrice).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total",totalCountList);

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
		if (procureTable.getDepartment() != null) {
			footer.setFieldValue(procureTable.getDepartment().getName());
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (procureTable.getOriginatorName() != null) {
			footer.setFieldValue(
					procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator()!=null?procureTable.getOriginator():"");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (procureTable.getReviewer() != null) {
			if (procureTable.getReviewerName() != null) {
				footer.setFieldValue(
						procureTable.getReviewer() + "(" + procureTable.getReviewerName() + ")");
			} else {
				footer.setFieldValue(procureTable.getReviewer());
			}
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary()!=null?procureTable.getSummary():"");
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(procureTable.getBranch()!=null?procureTable.getBranch():"总部");
		footers.add(footer);
		
		JSON.put("footer", footers);
		/* footer end */

		return JSON;
	}
	
	
	/**
	 * 其他收货单详情
	 * @param request
	 * @param id 其他收货单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "detailOtherReceiptsOrder")
	public JSONObject detailOtherReceiptsOrder(HttpServletRequest request, Integer id) {
		ProcureTable procureTable = procureTableService.selectMsgToDetail(id);

		return createOtherReceiptsOrderJSON(procureTable);
	}
	
	/**
	 * 生成 其他收货单单据页面详情所需的信息 返回值为JSON格式
	 * 
	 * @param procureTable
	 * @return
	 */
	private JSONObject createOtherReceiptsOrderJSON(ProcureTable procureTable) {
		JSONObject JSON = new JSONObject();	
		JSON.put("title", "其他收货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JSON.put("date", dateFormat.format(procureTable.getGenerateDate()));
		JSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		JSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "品牌","条形码","单位", "业务数量", "业务单价","金额","仓库","批号","生产日期","有效期至","备注"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//业务数量
		Integer totalCount = 0;
		//金额
		Double totalPrice=0.0;
		
		
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			
			String[] tbody = { 
					pc.getCommoditySpecification().getSpecificationIdentifier(),
					pc.getCommoditySpecification().getCommodity().getName(),
					pc.getCommoditySpecification().getSpecificationName(),
					pc.getCommoditySpecification().getCommodity().getBrand(),
					pc.getCommoditySpecification().getGoodsBarCode(),
					pc.getCommoditySpecification().getBaseUnitName(),
					pc.getOrderNum()==null?"0":pc.getOrderNum()+"",
					(pc.getBusinessUnitPrice()==null?0.0:pc.getBusinessUnitPrice())+"",
					(pc.getTotalTaxPrice()==null?0.0:pc.getTotalTaxPrice())+"",//金额显示价税合计
					(pc.getCommoditySpecification().getSpecWarehouseName()==null?"暂无":pc.getCommoditySpecification().getSpecWarehouseName()),
					(pc.getLotNumber()==null?"":pc.getLotNumber())+"",
					"",
					"",
					(pc.getRemarks()==null?"":pc.getRemarks())+""
			};
			totalCount += pc.getOrderNum();
			totalPrice+=(pc.getTotalTaxPrice()==null?0.0:pc.getTotalTaxPrice());
			
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "6");
		totalCountJSON.put("colTotal", totalCount);
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "8");
		totalCountJSON.put("colTotal",  new BigDecimal(totalPrice).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total",totalCountList);

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
		if (procureTable.getOriginatorName() != null) {
			footer.setFieldValue(
					procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator()!=null?procureTable.getOriginator():"");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (procureTable.getReviewer() != null) {
			if (procureTable.getReviewerName() != null) {
				footer.setFieldValue(
						procureTable.getReviewer() + "(" + procureTable.getReviewerName() + ")");
			} else {
				footer.setFieldValue(procureTable.getReviewer());
			}
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary()!=null?procureTable.getSummary():"");
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(procureTable.getBranch()!=null?procureTable.getBranch():"总部");
		footers.add(footer);
		
		JSON.put("footer", footers);
		/* footer end */

		return JSON;
	}
	
	
	/**
	 * 采购退货单详情
	 * @param request
	 * @param id 采购订单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "detailPurchaseReturnOrder")
	public JSONObject detailPurchaseReturnOrder(HttpServletRequest request, Integer id) {
		ProcureTable procureTable = procureTableService.selectMsgToDetail(id);

		return createPurchaseReturnOrderJSON(procureTable);
	}	
	/**
	 * 生成采购退货单单据页面详情所需的信息 返回值为JSON格式
	 * 
	 * @param procureTable
	 * @return
	 */
	private JSONObject createPurchaseReturnOrderJSON(ProcureTable procureTable) {
		JSONObject JSON = new JSONObject();	
		JSON.put("title", "采购退货单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JSON.put("date", dateFormat.format(procureTable.getGenerateDate()));
		JSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		/* 到货日期与到货时间一至 */
		String goodsArrivalTime="";
		
		head.setFieldName("单据类型");
		head.setFieldValue("采购退货");	
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("采购订单编号");
		head.setFieldValue(procureTable.getProcureTableIdentifier()!=null?procureTable.getProcureTableIdentifier():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("供应商");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("结算方式");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getSettlementTypeName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("结算账户");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getBankAccount():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		head.setFieldValue(procureTable.getShippingMode()!=null?procureTable.getShippingMode().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货地址");
		head.setFieldValue(procureTable.getGoodsArrivalPlace()!=null?procureTable.getGoodsArrivalPlace():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货人");
		head.setFieldValue(procureTable.getDeliveryman()!=null?procureTable.getDeliveryman():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(procureTable.getPhone()!=null?procureTable.getPhone():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(procureTable.getFax()!=null?procureTable.getFax():"");
		heads.add(head);
		
		JSON.put("head", heads);
		
		
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格","单位", "仓库名称","退货数量", "退货单价","金额"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		Integer totalCount = 0;
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			
			String[] tbody = { 
					pc.getCommoditySpecification().getSpecificationIdentifier(),
					pc.getCommoditySpecification().getCommodity().getName(),
					pc.getCommoditySpecification().getSpecificationName(),
					pc.getCommoditySpecification().getBaseUnitName(),
					pc.getCommoditySpecification().getSpecWarehouseName()==null?"暂无":pc.getCommoditySpecification().getSpecWarehouseName(),
					pc.getArrivalQuantity()==null?0+"":pc.getArrivalQuantity()+"",
					(pc.getBusinessUnitPrice()==null?0.0:pc.getBusinessUnitPrice())+"",
					(pc.getTotalPrice()==null?0.0:pc.getTotalPrice())+"",
					
			};
			
			totalMoney += (pc.getTotalPrice()==null?0.0:pc.getTotalPrice());
			totalCount += pc.getArrivalQuantity();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal", totalCount);
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "7");
		totalCountJSON.put("colTotal", new BigDecimal(totalMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total",totalCountList);

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
		if (procureTable.getDepartment() != null) {
			footer.setFieldValue(procureTable.getDepartmentName());
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (procureTable.getOriginatorName() != null) {
			footer.setFieldValue(
					procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator()==null?"":procureTable.getOriginator());
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
		if (procureTable.getReviewer() != null) {
			if (procureTable.getReviewerName() != null) {
				footer.setFieldValue(
						procureTable.getReviewer() + "(" + procureTable.getReviewerName() + ")");
			} else {
				footer.setFieldValue(procureTable.getReviewer());
			}
		} else {
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary()!=null?procureTable.getSummary():"");
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(procureTable.getBranch()!=null?procureTable.getBranch():"总部");
		footers.add(footer);
		
		JSON.put("footer", footers);
		/* footer end */

		return JSON;
	}
	
	
	
	/**
	 * 
	 * 采购订单详情导出
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("exportExportProcureTableDetail")
	public boolean exportExportProcureTableDetail(HttpServletRequest request,HttpServletResponse response,String id) throws Exception{
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		String  fileName="采购订单详情";
		
		//List<ProcureTable>	list=this.selectById(request,id);
		ProcureTable list=this.selectById(request, id);
	
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		int totolMoney1=0;
		Double totolMoney2=0.0;
		Double totolMoney3=0.0;
		int totolArrivalQuantity=0;
		String totol[]=new String[10];
		//搜索的有数据
		if(list!=null){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[35];
			title[0]="日期";
			title[1]="单号";
			title[2]="供应商";
			title[3]="有效期至";
			
			title[4]="合同号";
			
			title[5]="到货时间";
			title[6]="到货地址";
			title[7]="付款方式";
			title[8]="对方联系人";
			title[9]="运输方式";
			title[10]="送货人";
			title[11]="传真";
			title[12]="联系电话";
			title[13]="规格编码";
			title[14]="商品名称";
			title[15]="规格";
			title[16]="品牌";
			title[17]="单位";
			title[18]="订货数量";
			title[19]="到货数量";
			title[20]="原始单价";
			title[21]="业务单价";
			title[22]="折扣%";
			title[23]="税率";
			title[24]="税额";
			title[25]="价税合计";
			title[26]="批号";
			title[27]="中止数量";
			title[28]="中止金额";
			title[29]="备注";
			title[30]="部门";
			title[31]="制单人";
			title[32]="审核人";
			title[33]="摘要";
			title[34]="分支机构";
			//保存要导出的内容
			
				
				
				for (ProcureCommodity tCommodity : list.getProcureCommoditys()) {
					value=new String[35];
					CommoditySpecification cs= tCommodity.getCommoditySpecification();
					
					if (tCommodity.getArrivalQuantity()==null) {
						tCommodity.setArrivalQuantity(0);
					}
					if (tCommodity.getSuspendQuantity()==null) {
						tCommodity.setSuspendQuantity(0);
					}
					if (tCommodity.getSuspendPrice()==null) {
						tCommodity.setSuspendPrice(0.0);
					}
						value[0] =dateFormat.format(list.getGenerateDate());
						value[1] =list.getIdentifier();
						value[2] =list.getSupcto()==null?"":list.getSupcto().getName();
						value[3] =dateFormat2.format(list.getEffectivePeriodEnd());
						value[4] =list.getContractNumber();
						
						value[5]=dateFormat2.format(list.getGoodsArrivalTime());
						value[6]=list.getGoodsArrivalPlace();
						value[7]=list.getSettlementType()==null?"":list.getSettlementType().getName();
						value[8]=list.getOrderer();
						value[9]=list.getShippingMode()==null?"":list.getShippingMode().getName()+"";
						value[10]=list.getDeliveryman();
						value[11]=list.getFax();
						value[12]=list.getPhone();
						value[13]=cs.getSpecificationIdentifier();
						value[14]=cs.getCommodity()==null?"":cs.getCommodity().getName();
						value[15]=cs.getSpecificationName();
						value[16]=cs.getCommodity()==null?"":cs.getCommodity().getBrand();
						value[17]=cs.getBaseUnitName();
						value[18]=tCommodity.getOrderNum()+"";
						value[19]=tCommodity.getArrivalQuantity()+"";
						value[20]=tCommodity.getOriginalUnitPrice()==null?"":tCommodity.getOriginalUnitPrice()+"";
						value[21]=tCommodity.getBusinessUnitPrice()==null?"":tCommodity.getBusinessUnitPrice()+"";
						value[22]=tCommodity.getDiscount()==null?"":tCommodity.getDiscount()+"";
						value[23]=tCommodity.getTaxRate()==null?"":tCommodity.getTaxRate()+"";
						value[24]=tCommodity.getAmountOfTax()==null?"":tCommodity.getAmountOfTax()+"";
						value[25]=tCommodity.getTotalTaxPrice()==null?"":tCommodity.getTotalTaxPrice()+"";
						value[26]=tCommodity.getLotNumber();
						value[27]=tCommodity.getSuspendQuantity()+"";
						value[28]=tCommodity.getSuspendPrice()+"";
						value[29]=tCommodity.getRemarks();
						value[30]=list.getDepartmentName();
						if(list.getOriginator()!=null){
							if(list.getOriginatorName()!=null){
								value[31]=list.getOriginator()+"("+list.getOriginatorName()+")";
							}
							else{
								value[31]=list.getOriginator();
							}
						}
						else{
							value[31]="";
						}
						
						if(list.getReviewer()==null){
							value[32]="";
						}
						else{
							if(list.getReviewerName()!=null){
								value[32]=list.getReviewer()+"("+list.getReviewerName()+")";
							}
							else{
								value[32]=list.getReviewer();
							}
						}
						value[33]=list.getSummary();
						value[34]="总部";
						
						totolMoney1+=tCommodity.getOrderNum();
						totolMoney2+=tCommodity.getTotalTaxPrice()==null?0.0:tCommodity.getTotalTaxPrice();
						totolMoney3+=tCommodity.getAmountOfTax()==null?0.0:tCommodity.getAmountOfTax();
						totolArrivalQuantity+=tCommodity.getArrivalQuantity();
						dataList.add(value);
						
					}
				//dataList.add(arr);
				
			
			
				totol[0]="合计";
				totol[1]="订货数量:"+totolMoney1;
				totol[2]="";
				totol[3]="";
				totol[4]="价税合计:"+totolMoney2;
				totol[5]="税额:"+totolMoney3;
				totol[6]="";
				totol[7]="到货数量:"+totolArrivalQuantity;
				
				dataList.add(totol);
			
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList);
		return true;
	}
	
	/**
	 * 其他收货单的导出
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("exportExportOtherReceiptsDetail")
	public boolean exportExportOtherReceiptsDetail(HttpServletRequest request,HttpServletResponse response,String id) throws Exception{
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		String  fileName="其他收货单详情";
		
		//List<ProcureTable>	list=this.selectById(request,id);
		ProcureTable list=this.selectById(request, id);
	
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		int totolMoney1=0;
		Double totolMoney2=0.0;
		Double totolMoney3=0.0;
		int totolArrivalQuantity=0;
		String totol[]=new String[10];
		//搜索的有数据
		if(list!=null){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[26];
			title[0]="日期";
			title[1]="单号";
			title[2]="供应商";
			title[3]="规格编码";
			title[4]="商品名称";
			title[5]="规格";
			title[6]="品牌";
			title[7]="单位";
			title[8]="订货数量";
			title[9]="到货数量";
			title[10]="原始单价";
			title[11]="业务单价";
			title[12]="折扣%";
			title[13]="税率";
			title[14]="税额";
			title[15]="价税合计";
			title[16]="批号";
			title[17]="中止数量";
			title[18]="中止金额";
			title[19]="备注";
			title[20]="部门";
			title[21]="制单人";
			title[22]="部门审核人";
			title[23]="财务审核人";
			title[24]="摘要";
			title[25]="分支机构";
			//保存要导出的内容
			
				
				
				for (ProcureCommodity tCommodity : list.getProcureCommoditys()) {
					value=new String[26];
					CommoditySpecification cs= tCommodity.getCommoditySpecification();
					
					if (tCommodity.getArrivalQuantity()==null) {
						tCommodity.setArrivalQuantity(0);
					}
					if (tCommodity.getSuspendQuantity()==null) {
						tCommodity.setSuspendQuantity(0);
					}
					if (tCommodity.getSuspendPrice()==null) {
						tCommodity.setSuspendPrice(0.0);
					}
						value[0] =dateFormat.format(list.getGenerateDate());
						value[1] =list.getIdentifier();
						value[2] ="其他";
						value[3]=cs.getSpecificationIdentifier();
						value[4]=cs.getCommodity().getName();
						value[5]=cs.getSpecificationName();
						value[6]=cs.getCommodity().getBrand();
						value[7]=cs.getBaseUnitName();
						value[8]=tCommodity.getOrderNum()+"";
						value[9]=tCommodity.getArrivalQuantity()+"";
						value[10]=tCommodity.getOriginalUnitPrice()+"";
						value[11]=tCommodity.getBusinessUnitPrice()+"";
						value[12]=tCommodity.getDiscount()+"";
						value[13]=tCommodity.getTaxRate()+"";
						value[14]=tCommodity.getAmountOfTax()+"";
						value[15]=tCommodity.getTotalTaxPrice()+"";
						value[16]=tCommodity.getLotNumber();
						value[17]=tCommodity.getSuspendQuantity()+"";
						value[18]=tCommodity.getSuspendPrice()+"";
						value[19]=tCommodity.getRemarks();
						value[20]=list.getDepartmentName();
						if(list.getOriginator()!=null){
							if(list.getOriginatorName()!=null){
								value[21]=list.getOriginator()+"("+list.getOriginatorName()+")";
							}
							else{
								value[21]=list.getOriginator();
							}
						}
						else{
							value[21]="";
						}
						
						if(list.getReviewer()==null){
							value[22]="";
						}
						else{
							if(list.getReviewerName()!=null){
								value[22]=list.getReviewer()+"("+list.getReviewerName()+")";
							}
							else{
								value[22]=list.getReviewer();
							}
						}
						if(list.getFinancialReviewer()==null){
							value[23]="";
						}
						else{
							if(list.getFinancialReviewerName()!=null){
								value[23]=list.getFinancialReviewer()+"("+list.getFinancialReviewerName()+")";
							}
							else{
								value[23]=list.getFinancialReviewer();
							}
						}
						
						value[24]=list.getSummary();
						value[25]="总部";
						
						totolMoney1+=tCommodity.getOrderNum();
						totolMoney2+=tCommodity.getTotalTaxPrice();
						totolMoney3+=tCommodity.getAmountOfTax();
						totolArrivalQuantity+=tCommodity.getArrivalQuantity();
						dataList.add(value);
						
					}
				//dataList.add(arr);
				
			
			
				totol[0]="合计";
				totol[1]="订货数量:"+totolMoney1;
				totol[2]="";
				totol[3]="";
				totol[4]="价税合计:"+totolMoney2;
				totol[5]="税额:"+totolMoney3;
				totol[6]="";
				totol[7]="到货数量:"+totolArrivalQuantity;
				
				dataList.add(totol);
			
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList);
		return true;
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
	 
	/**
	 * 入库单详情
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "inputOrderDetail", method = RequestMethod.POST)
	 public JSONObject inputOrderDetail(Integer id) {
		 ProcureTable procureTable=procureTableService.selectMsgToDetail(id);
		 return createInputOrderDetail(procureTable);
	 }
	 
	/**
	 * 部分入库单详情
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "partInputOrderDetail", method = RequestMethod.POST)
	 public JSONObject partInputOrderDetail(Integer id) {
		 ProcureTable procureTable=procureTableService.selectMsgToDetail(id);
		 return createPartInputOrderDetail(procureTable);
	 }
	
	/**
	 * 入库单引用详情
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "inputOrderReferenceDetail", method = RequestMethod.POST)
	 public JSONObject inputOrderReferenceDetail(Integer id) {
		 ProcureTable procureTable=procureTableService.selectMsgToDetail(id);
		 return createInputOrderReferenceDetail(procureTable);
	 }
	
	
	/**
	 * 生成入库单详情 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createInputOrderDetail(ProcureTable procureTable) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "入库单");
 		outboundOrderJSON.put("date", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(procureTable.getGenerateDate()));
		outboundOrderJSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
 
	 
		
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单号");
		head.setFieldValue(procureTable.getIdentifier());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("入库单");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("供应商");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getName():"其他");
		heads.add(head);
	    
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		head.setFieldValue(procureTable.getShippingMode()!=null?procureTable.getShippingMode().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货地址");
		head.setFieldValue(procureTable.getGoodsArrivalPlace()!=null?procureTable.getGoodsArrivalPlace():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货人");
		head.setFieldValue(procureTable.getDeliveryman()!=null?procureTable.getDeliveryman():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(procureTable.getFax()!=null?procureTable.getFax():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(procureTable.getPhone()!=null?procureTable.getPhone():"");
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = {"货品编码","仓库名称","货品名称","规格","品牌","单位","业务数量(袋)","业务数量(箱)","原始单价","折扣%","业务单价","税率","税款","价税合计","批号","生产日期","有效期至"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//业务数量合计
   		Integer orderNumTotal=0;
   		//税额
   		Double amountOfTaxTotal=0.0;
   		//
   		Double totalTaxPriceTotal=0.0;
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(pc.getCommodityId());
 			Integer commodityNum=pc.getOrderNum();
			Integer boxNum=commoditySpecification.getUnits().size()>1?commodityNum/commoditySpecification.getUnits().get(1).getRatioMolecular():0;
			
			String[] tbody = { pc.getCommoditySpecification().getSpecificationIdentifier(),
					pc.getCommoditySpecification().getSpecWarehouseName()==null?"暂无":pc.getCommoditySpecification().getSpecWarehouseName(),
					pc.getCommoditySpecification().getCommodity().getName(),
					pc.getCommoditySpecification().getSpecificationName(),
					pc.getCommoditySpecification().getCommodity().getBrand(),
					pc.getCommoditySpecification().getBaseUnitName(), (pc.getOrderNum()==null?0:pc.getOrderNum())+ "",boxNum+"",
					(pc.getOriginalUnitPrice()==null?0:pc.getOriginalUnitPrice()) + "",
					
					(pc.getDiscount()==null?0:pc.getDiscount())+ "",(pc.getBusinessUnitPrice()==null?0:pc.getBusinessUnitPrice())+"",
					(pc.getTaxRate()==null?0:pc.getTaxRate())+"",
					(pc.getAmountOfTax()==null?0:pc.getAmountOfTax())+"",
					(pc.getTotalTaxPrice()==null?0:pc.getTotalTaxPrice())+"",(pc.getLotNumber()==null?"":pc.getLotNumber()),"",""
					 };
			
			orderNumTotal+=pc.getOrderNum()==null?0:pc.getOrderNum();
			amountOfTaxTotal+=pc.getAmountOfTax()==null?0:pc.getAmountOfTax();
			totalTaxPriceTotal+=pc.getTotalTaxPrice()==null?0:pc.getTotalTaxPrice();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "6");
		totalCountJSON.put("colTotal",orderNumTotal.toString());
		totalCountList.add(totalCountJSON);
 
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "12");
		totalCountJSON.put("colTotal", new BigDecimal(amountOfTaxTotal).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "13");
		totalCountJSON.put("colTotal",new BigDecimal(totalTaxPriceTotal).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
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
 		footer.setFieldValue(procureTable.getDepartmentName()!=null?procureTable.getDepartmentName():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (procureTable.getOriginatorName()!= null) {
			footer.setFieldValue(procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator());
		}
		footers.add(footer);
 
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary()!=null?procureTable.getSummary():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(procureTable.getBranch()!=null?procureTable.getBranch():"");
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	/**
	 * 生成部分入库单详情 返回值为JSON格式
	 * 
	 * @param
	 * @return
	 */
	private JSONObject createPartInputOrderDetail(ProcureTable procureTable) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "部分入库单");
 		outboundOrderJSON.put("date", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(procureTable.getGenerateDate()));
		outboundOrderJSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
 
	 
		
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单号");
		head.setFieldValue(procureTable.getIdentifier());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("入库单");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("供应商");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getName():"其他");
		heads.add(head);
	    
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		head.setFieldValue(procureTable.getShippingMode()!=null?procureTable.getShippingMode().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货地址");
		head.setFieldValue(procureTable.getGoodsArrivalPlace()!=null?procureTable.getGoodsArrivalPlace():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货人");
		head.setFieldValue(procureTable.getDeliveryman()!=null?procureTable.getDeliveryman():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(procureTable.getFax()!=null?procureTable.getFax():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(procureTable.getPhone()!=null?procureTable.getPhone():"");
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */
		//data.procureCommoditys[i].arrivalQuantity
		/* table start */
		// thead
		String[] theads = {"货品编码","仓库名称","货品名称","规格","品牌","单位","本次到货数量(袋)","本次到货数量(箱)",/*"业务数量",*/"原始单价","折扣%","业务单价","税率","税款","价税合计","批号",
				"中止数量","中止金额","共到货数量(袋)","生产日期","有效期至",};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//业务数量合计
   		Integer orderNumTotal=0;
   		//税额
   		Double amountOfTaxTotal=0.0;
   		//
   		Double totalTaxPriceTotal=0.0;
  
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(pc.getCommodityId());
			/*Integer commodityNum=0;
			if(commoditySpecification.getInventories().size()>0) {
				Inventory inventory=commoditySpecification.getInventories().get(0);
			    commodityNum=inventory.getCommodityNum();
			}*/
			Integer partNum=pc.getArrivalQuantity()==null?0:pc.getArrivalQuantity();//部分入库数量
			Integer boxNum=commoditySpecification.getUnits().size()>1?partNum/commoditySpecification.getUnits().get(1).getRatioMolecular():0;
			
			Double businessUnitPrice=pc.getBusinessUnitPrice()==null?0.0:pc.getBusinessUnitPrice();//业务单价
			Double tax=pc.getTaxRate()==null?0.0:pc.getTaxRate();//税率
			Double partTaxPrice=partNum*businessUnitPrice*tax;//税款
			Double totalTaxPrice=partNum*businessUnitPrice*(1+tax);//价税合计
			
			DecimalFormat df = new DecimalFormat("#.##");
			String[] tbody = { pc.getCommoditySpecification().getSpecificationIdentifier(),
					pc.getCommoditySpecification().getSpecWarehouseName()==null?"暂无":pc.getCommoditySpecification().getSpecWarehouseName(),
					pc.getCommoditySpecification().getCommodity().getName(),
					pc.getCommoditySpecification().getSpecificationName(),
					pc.getCommoditySpecification().getCommodity().getBrand(),
					pc.getCommoditySpecification().getBaseUnitName(),partNum+"",boxNum+"", /*(pc.getOrderNum()==null?0:pc.getOrderNum())+ "",*/
					(pc.getOriginalUnitPrice()==null?0.0:pc.getOriginalUnitPrice()) + "",
					
					(pc.getDiscount()==null?0:pc.getDiscount())+ "",businessUnitPrice+"",
					tax+"",df.format(partTaxPrice),
					df.format(totalTaxPrice),(pc.getLotNumber()==null?"":pc.getLotNumber()),
					(pc.getSuspendQuantity()==null?"":pc.getSuspendQuantity())+"",(pc.getSuspendPrice()==null?"":df.format(pc.getSuspendPrice()))+"",
					(pc.getSuspendQuantity()==null?0:
						pc.getOrderNum()-pc.getSuspendQuantity())+"",
					"","" };
					
			
			orderNumTotal+=partNum;
			amountOfTaxTotal+=partTaxPrice;
			totalTaxPriceTotal+=totalTaxPrice;
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "6");
		totalCountJSON.put("colTotal",orderNumTotal.toString());
		totalCountList.add(totalCountJSON);
 
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "12");
		totalCountJSON.put("colTotal",new BigDecimal(amountOfTaxTotal).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "13");
		totalCountJSON.put("colTotal",new BigDecimal(totalTaxPriceTotal).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
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
 		footer.setFieldValue(procureTable.getDepartmentName()!=null?procureTable.getDepartmentName():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (procureTable.getOriginatorName() != null) {
			footer.setFieldValue(procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator());
		}
		footers.add(footer);
 
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary()!=null?procureTable.getSummary():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(procureTable.getBranch()!=null?procureTable.getBranch():"");
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	
	
	/**
	 * 生成入库单引用详情 返回值为JSON格式
	 * 
	 * @param
	 * @return
	 */
	private JSONObject createInputOrderReferenceDetail(ProcureTable procureTable) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "入库单引用");
 		outboundOrderJSON.put("date", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(procureTable.getGenerateDate()));
		outboundOrderJSON.put("oddNumbers", procureTable.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
 
	 
		
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单号");
		head.setFieldValue(procureTable.getIdentifier());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("入库单");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("供应商");
		head.setFieldValue(procureTable.getSupcto()!=null?procureTable.getSupcto().getName():"其他");
		heads.add(head);
	    
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		head.setFieldValue(procureTable.getShippingMode()!=null?procureTable.getShippingMode().getName():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货地址");
		head.setFieldValue(procureTable.getGoodsArrivalPlace()!=null?procureTable.getGoodsArrivalPlace():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("送货人");
		head.setFieldValue(procureTable.getDeliveryman()!=null?procureTable.getDeliveryman():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("传真");
		head.setFieldValue(procureTable.getFax()!=null?procureTable.getFax():"");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("联系电话");
		head.setFieldValue(procureTable.getPhone()!=null?procureTable.getPhone():"");
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */
		//data.procureCommoditys[i].arrivalQuantity
		/* table start */
		// thead
		String[] theads = {"货品编码","仓库名称","货品名称","规格","品牌","单位","到货数量(袋)","到货数量(箱)","原始单价","折扣%","业务单价","税率","税款","价税合计","批号","生产日期","有效期至"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//业务数量合计
   		Integer orderNumTotal=0;
   		//税额
   		Double amountOfTaxTotal=0.0;
   		//
   		Double totalTaxPriceTotal=0.0;
  
		for (ProcureCommodity pc : procureTable.getProcureCommoditys()) {
			CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(pc.getCommodityId());
			Integer partNum=pc.getArrivalQuantity()==null?0:pc.getArrivalQuantity(); //入库数量
			Integer boxNum=commoditySpecification.getUnits().size()>1?partNum/commoditySpecification.getUnits().get(1).getRatioMolecular():0;
			Double businessUnitPrice=0.0;//业务单价
			Double tax=0.0;//税率
			Double partTaxPrice=0.0;//税款
			Double totalTaxPrice=0.0;//价税合计
			
			businessUnitPrice=pc.getBusinessUnitPrice()==null?0.0:pc.getBusinessUnitPrice();
			tax=pc.getTaxRate()==null?0.0:pc.getTaxRate();
			//不是从其他收货单引用来的
			if(procureTable.getIsOtherReceipts()==0){
				partTaxPrice=partNum*businessUnitPrice*tax;
				totalTaxPrice=partNum*businessUnitPrice*(1+tax);
			}
			else{
				//是部分入库
				if(pc.getSuspendQuantity()!=null&&pc.getSuspendQuantity()>0){
					partTaxPrice=partNum*businessUnitPrice*tax;
					totalTaxPrice=partNum*businessUnitPrice*(1+tax);
				}
				//全部入库
				else{
					partTaxPrice=pc.getAmountOfTax();
					totalTaxPrice=pc.getTotalTaxPrice();
				}
			}
				
			DecimalFormat df = new DecimalFormat("#.##");
			String[] tbody = { pc.getCommoditySpecification().getSpecificationIdentifier(),
					pc.getCommoditySpecification().getSpecWarehouseName()==null?"暂无":pc.getCommoditySpecification().getSpecWarehouseName(),
					pc.getCommoditySpecification().getCommodity().getName(),
					pc.getCommoditySpecification().getSpecificationName(),
					pc.getCommoditySpecification().getCommodity().getBrand(),
					pc.getCommoditySpecification().getBaseUnitName(),partNum+"",boxNum+"",
					(pc.getOriginalUnitPrice()==null?0.0:pc.getOriginalUnitPrice()) + "",
					
					(pc.getDiscount()==null?0:pc.getDiscount())+ "",businessUnitPrice+"",
					tax+"",df.format(partTaxPrice),
					df.format(totalTaxPrice),(pc.getLotNumber()==null?"":pc.getLotNumber()),"","" };
					
			
			orderNumTotal+=partNum;
			amountOfTaxTotal+=partTaxPrice;
			totalTaxPriceTotal+=totalTaxPrice;
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "6");
		totalCountJSON.put("colTotal",orderNumTotal.toString());
		totalCountList.add(totalCountJSON);
 
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "12");
		totalCountJSON.put("colTotal",new BigDecimal(amountOfTaxTotal).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "13");
		totalCountJSON.put("colTotal",new BigDecimal(totalTaxPriceTotal).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"");
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
 		footer.setFieldValue(procureTable.getDepartmentName()!=null?procureTable.getDepartmentName():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (procureTable.getOriginatorName() != null) {
			footer.setFieldValue(procureTable.getOriginator() + "(" + procureTable.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(procureTable.getOriginator());
		}
		footers.add(footer);
 
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(procureTable.getSummary()!=null?procureTable.getSummary():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(procureTable.getBranch()!=null?procureTable.getBranch():"");
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
}
