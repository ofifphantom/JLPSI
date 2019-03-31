package com.jl.psi.controller;

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
import com.jl.psi.model.BreakageOrder;
import com.jl.psi.model.BreakageOrderCommodity;
import com.jl.psi.model.FormHeadAndFooter;
import com.jl.psi.model.Inventory;
import com.jl.psi.model.Log;
import com.jl.psi.model.Unit;
import com.jl.psi.service.BreakageOrderCommodityService;
import com.jl.psi.service.BreakageOrderService;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.InventoryService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.PersonService;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 报损单controller
 * @author 景雅倩
 * @date 2018年6月14日 下午5:01:28
 */
@Controller
@RequestMapping("/warehouse/base/breakageOrder/")
public class BreakageOrderController extends BaseController {

	// 当前类操作的类型(往log日志表中存储)
	private int operateType = Constants.TYPE_LOG_WAREHOUSE;

	// 声明Log类
	Log log;

	@Autowired
	BreakageOrderService breakageOrderService;
	@Autowired
	BreakageOrderCommodityService breakageOrderCommodityService;
	@Autowired
	LogService logService;
	@Autowired
	InventoryService inventoryService;
	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	@Autowired
	PersonService personService;
	/**
	 * 进入页面
	 * @return
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request, int page) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "";

		switch (page) {
		case 1://报损单维护页面
			pageName = "junlin/jsp/warehouse/base/breakageOrder/breakageOrder";
			break;
		case 2://财务送审页面
			pageName = "junlin/jsp/warehouse/base/breakageOrder/breakageOrderFinancial";
			break;
		case 3://报损单审批页面
			pageName = "junlin/jsp/warehouse/base/breakageOrder/breakageOrderAudit";
			break;
		default:
			break;
		}

		return pageName;

	}

	/**
	 * 页面DataTable展示信息
	 * @param request
	 * @param page 标志哪个页面(1:报损单维护页面  2:财务送审页面  3:报损单审批页面)
	 * @param warehouseName 仓库名称
	 * @param breakageDate 日期
	 * @param originator 制单人
	 * @return
	 */
	@RequestMapping(value="dataTables",method=RequestMethod.POST)
	@ResponseBody
	public DataTables dataTables(HttpServletRequest request,
			Integer page, Integer warehouseId, String breakageDate, String originator,String searchType) {
		DataTables dataTables = DataTables.createDataTables(request);

		return breakageOrderService.getDataTables(dataTables, page, warehouseId, breakageDate, originator,searchType);
		
	}
	
	/**
	 * 根据主键id查询详情
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "selectBreakageOrderDetailById")
	public BreakageOrder selectBreakageOrderDetailById(HttpServletRequest request, Integer id) {
		return breakageOrderService.selectBreakageOrderDetailById(id);
	}
	
	/**
	 * 新增报损单
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addBreakageOrder", method = RequestMethod.POST)
	public JSONObject addBreakageOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();

		// 获取ajax传递过来的参数
		String bo = request.getParameter("breakageOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(bo);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("breakageOrderCommodities", BreakageOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		BreakageOrder breakageOrder = (BreakageOrder) net.sf.json.JSONObject.toBean(jsonobject, BreakageOrder.class, map);
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		breakageOrder.setOriginator(userIdentifier);
		//设置日期为当前日期
		breakageOrder.setBreakageDate(new Date());
		//状态默认为1
		breakageOrder.setState(1);
		breakageOrder.setIsDelete(0);
		String maxIdentifier = breakageOrderService.selectMaxIdentifier();
		// 生成编号
		String identifier = SundryCodeUtil.createInvoicesIdentifier("AT", maxIdentifier);
		breakageOrder.setIdentifier(identifier);
		
		if (breakageOrderService.insertSelective(breakageOrder) > 0) {
			for (BreakageOrderCommodity boc : breakageOrder.getBreakageOrderCommodities()) {
				boc.setBreakageOrderId(breakageOrder.getId());
			}//向报损单商品表中批量添加数据
			breakageOrderCommodityService.insertBeatch(breakageOrder.getBreakageOrderCommodities());
			// 往log表中插入操作数据
			insertLog(operateType, breakageOrder.getIdentifier(), Constants.OPERATE_INSERT, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
			return rmsg;

		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 编辑报损单
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/editBreakageOrder", method = RequestMethod.POST)
	public JSONObject editBreakageOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		
		// 获取ajax传递过来的参数
		String bo = request.getParameter("breakageOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(bo);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("breakageOrderCommodities", BreakageOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		BreakageOrder breakageOrder = (BreakageOrder) net.sf.json.JSONObject.toBean(jsonobject, BreakageOrder.class, map);
				
		if (breakageOrderService.updateByPrimaryKeySelective(breakageOrder) > 0) {
			breakageOrderCommodityService.deleteMsgByBreakageOrderId(breakageOrder.getId());

			for (BreakageOrderCommodity boc : breakageOrder.getBreakageOrderCommodities()) {
				boc.setBreakageOrderId(breakageOrder.getId());
			}
			//向报损单商品表中批量添加数据
			breakageOrderCommodityService.insertBeatch(breakageOrder.getBreakageOrderCommodities());
			// 往log表中插入操作数据
			insertLog(operateType, breakageOrder.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
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
	 * 删除报损单
	 * @param id 报损单id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteBreakageOrder", method = RequestMethod.POST)
	public JSONObject deleteBreakageOrder(HttpServletRequest request, Integer id) throws Exception {
		JSONObject rmsg = new JSONObject();
		BreakageOrder breakageOrder = breakageOrderService.selectByPrimaryKey(id);
		if (breakageOrderService.deleteByPrimaryKey(id) > 0) {
 			// 往log表中插入操作数据
			insertLog(operateType, breakageOrder.getIdentifier(), Constants.OPERATE_DELETE, new Date(),
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
	 * 根据id列表更改状态
	 * 
	 * @param request
	 * @param ids
	 *            id列表
	 * @param state（ 1：未发送至财务   2：未送审   3：待审核   4：已驳回   5：已完成）
	 *            要修改为的状态值
	 * @param isCheck
	 *            是否是审核 0:否，1：是（决定是否修改审批人）
	 * @param msg
	 *            操作成功后页面中弹出的消息提醒内容（如："操作成功，已通过"、"操作成功，已驳回"等）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateStateByIds", method = RequestMethod.POST)
	public JSONObject updateStateByIds(HttpServletRequest request, String[] ids, int state, int isCheck, String msg) throws Exception {
		// 操作人
		String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", list);
		map.put("state", state);

		JSONObject rmsg = new JSONObject();
		rmsg.put("msg", msg);
		//判断是否需要修改审核人信息
		if(isCheck == 1) {
			map.put("reviewer", operatorIdentifier);
		}else {
			map.put("reviewer", null);
		}
		if (breakageOrderService.updateStateByIds(map)) {
			//审批通过时修改商品的库存数为：原库存-报损数量
			if(state == 5) {//审批通过
				int number;
				int commoditySpecificationId;
				Inventory inventory = new Inventory();
				for (int i = 0; i < list.size(); i++) {//遍历报损单id列表
					List<BreakageOrderCommodity> breakageOrderCommodities = breakageOrderCommodityService.selectByBreakageOrderId(list.get(i));//根据报损单id获取报损商品列表
					for (int j = 0; j < breakageOrderCommodities.size(); j++) {//遍历某个报损单的商品列表
						//获取报损数量
						number = breakageOrderCommodities.get(j).getNumber();
						//获取商品规格id
						commoditySpecificationId = breakageOrderCommodities.get(j).getCommoditySpecificationId();
						
						inventory.setInventory(number);//设置库存为实盘数量
						inventory.setSpecificationId(commoditySpecificationId);//设置商品规格id
						//根据商品规格id修改商品的库存数量为实盘数量
						inventoryService.updateReduceGoodsInventory(inventory);
					}
				
				}
			}
			
			
			// 插入日志
			// 保存操作的对象编号
			List<BreakageOrder> breakageOrders = breakageOrderService.getBreakageOrderByIds(list);
			// 操作对象
			String operateObject = "";
			for (int i = 0; i < breakageOrders.size(); i++) {
				operateObject += breakageOrders.get(i).getIdentifier();
				if (i < breakageOrders.size() - 1) {
					operateObject += ",";
				}
			}
			
			// 操作类型
			int operateType;
			if (isCheck == 1) {
				operateType = Constants.TYPE_LOG_CHECK;
			} else {
				operateType = Constants.TYPE_LOG_WAREHOUSE;
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
//	/**
//	 * 报损单报表
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value = "reporBreakOrdertMsg")
//	public List<BreakageOrder> reporBreakOrdertMsg(){
//		
//		List<BreakageOrder> breakageOrders=breakageOrderService.reporBreakOrdertMsg();
//		for (BreakageOrder breakageOrder : breakageOrders) {
//		List<BreakageOrderCommodity>	breakageOrderCommodities=breakageOrder.getBreakageOrderCommodities();
//		for (BreakageOrderCommodity breakageOrderCommodity : breakageOrderCommodities) {
//			for (Unit unit : breakageOrderCommodity.getCommoditySpecification().getUnits()) {
//				Double avg=commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(breakageOrderCommodity.getCommoditySpecificationId());
//				System.out.println(">>>>>>>>>>>>>"+avg);
//				if (avg!=null) {
//					System.out.println("不为空");
//					unit.setMiniPrice(avg);
//				}else {
//					System.out.println("为空"+unit.getMiniPrice()+">>>>>>>csid"+breakageOrderCommodity.getCommoditySpecificationId());
//				}
//			}
//			
//		}
//		}
//		return breakageOrders;
//	}
	/**
	 * 打印
	 * @param request
	 * @param id 报损单id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/printBreakageOrder")
	public JSONObject printBreakageOrder(HttpServletRequest request, Integer id) throws Exception {
		return createPrintBreakageOrderJSON(request, breakageOrderService.selectBreakageOrderDetailById(id));
	}
	
	/**
	 * 更改单据打印次数
	 * @param request
	 * @param id 单据id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateBreakageOrderPrintNum")
	public JSONObject updateBreakageOrderPrintNum(HttpServletRequest request, int id) throws Exception {

		JSONObject rmsg = new JSONObject();
		BreakageOrder breakageOrder = breakageOrderService.selectByPrimaryKey(id);
		String identifier = breakageOrder.getIdentifier();
		int printNum = breakageOrder.getPrintNum();
		printNum += 1;
		breakageOrder = new BreakageOrder();
		breakageOrder.setId(id);
		breakageOrder.setPrintNum(printNum);
		if (breakageOrderService.updateByPrimaryKeySelective(breakageOrder) > 0) {
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
	 * 生成报损单单据打印信息
	 * @param breakageOrder 报损单信息
	 * @return 页面所需的信息   JSON格式
	 */
	private JSONObject createPrintBreakageOrderJSON(HttpServletRequest request, BreakageOrder breakageOrder) {
		JSONObject breakageOrderJSON = new JSONObject();
		breakageOrderJSON.put("title", "报损单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		breakageOrderJSON.put("date", dateFormat.format(breakageOrder.getBreakageDate()));
		breakageOrderJSON.put("oddNumbers", breakageOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("仓库");
		head.setFieldValue(breakageOrder.getWarehouseName());
		heads.add(head);
		breakageOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位", "报损数量", "业务单价", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (BreakageOrderCommodity bo : breakageOrder.getBreakageOrderCommodities()) {
			String[] tbody = { bo.getCommoditySpecification().getSpecificationIdentifier(),
					bo.getCommoditySpecification().getCommodity().getName(),
					bo.getCommoditySpecification().getSpecificationName(),
					bo.getCommoditySpecification().getBaseUnitName(),
					bo.getNumber() + "",
					bo.getUnitPrice() + "",
					bo.getMoney() + "" };
			totalMoney += bo.getMoney();
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

		breakageOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(breakageOrder.getDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(breakageOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (breakageOrder.getOriginatorName() != null && breakageOrder.getOriginatorName() != "") {
			footer.setFieldValue(breakageOrder.getOriginator() + "(" + breakageOrder.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(breakageOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(breakageOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("打印人");
		footer.setFieldValue(GetSessionUtil.GetSessionUserIdentifier(request) + "(" + GetSessionUtil.GetSessionUserName(request) + ")");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("打印日期");
		footer.setFieldValue(dateFormat.format(new Date()));
		footers.add(footer);
		breakageOrderJSON.put("footer", footers);
		/* footer end */

		return breakageOrderJSON;
	}
	@ResponseBody
	@RequestMapping(value = "breakageOrderDetail")
	public JSONObject breakageOrderDetail(Integer id) throws Exception {
		BreakageOrder breakageOrder=breakageOrderService.selectBreakageOrderDetailById(id);
		return createBreakageOrderDetail(breakageOrder);
	}
	
	/**
	 * 报损单
	 * @param breakageOrder 报损单信息
	 * @return 页面所需的信息   JSON格式
	 */
	private JSONObject createBreakageOrderDetail( BreakageOrder breakageOrder) {
		JSONObject breakageOrderJSON = new JSONObject();
		breakageOrderJSON.put("title", "报损单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		breakageOrderJSON.put("date", dateFormat.format(breakageOrder.getBreakageDate()));
		breakageOrderJSON.put("oddNumbers", breakageOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("仓库");
		head.setFieldValue(breakageOrder.getWarehouseName());
		heads.add(head);
		breakageOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "品牌","条形码","单位", "数量", "业务单价", "金额","产品批号","生产日期","有效期至","备注" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		Integer totalNumber=0;
		for (BreakageOrderCommodity bo : breakageOrder.getBreakageOrderCommodities()) {
			String[] tbody = { bo.getCommoditySpecification().getSpecificationIdentifier(),
					bo.getCommoditySpecification().getCommodity().getName(),
					bo.getCommoditySpecification().getSpecificationName(),
					bo.getCommoditySpecification().getCommodity().getBrand(),
					bo.getCommoditySpecification().getBarCode(),
					bo.getCommoditySpecification().getBaseUnitName(),
					bo.getNumber() + "",
					bo.getUnitPrice() + "",
					bo.getMoney() + "",
					"","","",""};
			totalMoney += bo.getMoney();
			totalNumber+=bo.getNumber();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "6");
		totalCountJSON.put("colTotal",totalNumber.toString());
		totalCountList.add(totalCountJSON);
 
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "8");
		totalCountJSON.put("colTotal",totalMoney.toString());
		totalCountList.add(totalCountJSON);
 
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		breakageOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(breakageOrder.getDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(breakageOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (breakageOrder.getOriginatorName() != null && breakageOrder.getOriginatorName() != "") {
			footer.setFieldValue(breakageOrder.getOriginator() + "(" + breakageOrder.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(breakageOrder.getOriginator());
		}
		footers.add(footer);
		
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("审核人");
 		if(breakageOrder.getReviewer()!=null){
			if(breakageOrder.getReviewerName()!=null){
				footer.setFieldValue(breakageOrder.getReviewer()+"("+breakageOrder.getReviewerName()+")");
			}
			else{
				footer.setFieldValue(breakageOrder.getReviewer());
			}
		}
		else{
			footer.setFieldValue("");
		}
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(breakageOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue("总部");
		footers.add(footer);
		breakageOrderJSON.put("footer", footers);
		/* footer end */

		return breakageOrderJSON;
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
	private void insertLog(Integer operateType, String identifier, String operateMethod, Date date,
			String userIdentifier) throws Exception {
		log = new Log();
		log.setOperateType(operateType);
		log.setOperateObject(identifier + "(" + operateMethod + ")");
		log.setOperateTime(date);
		log.setOperatorIdentifier(userIdentifier);
		logService.insert(log);
	}
}
