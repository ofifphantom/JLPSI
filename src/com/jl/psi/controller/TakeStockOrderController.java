package com.jl.psi.controller;


import java.text.DecimalFormat;
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
import com.jl.psi.model.TakeStockOrder;
import com.jl.psi.model.TakeStockOrderCommodity;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.InventoryService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.PersonService;
import com.jl.psi.service.TakeStockOrderCommodityService;
import com.jl.psi.service.TakeStockOrderService;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 盘点单controller
 * @author 景雅倩
 * @date 2018年6月11日 下午7:02:10
 */
@Controller
@RequestMapping("/warehouse/base/takeStockOrder/")
public class TakeStockOrderController extends BaseController {

	// 当前类操作的类型(往log日志表中存储)
	private int operateType = Constants.TYPE_LOG_WAREHOUSE;

	// 声明Log类
	Log log;

	@Autowired
	TakeStockOrderService takeStockOrderService;
	@Autowired
	TakeStockOrderCommodityService takeStockOrderCommodityService;
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
		case 1:
			pageName = "junlin/jsp/warehouse/base/takeStockOrder/takeStockOrder";
			break;
		case 2:
			pageName = "junlin/jsp/warehouse/base/takeStockOrder/fillTakeStockOrder";
			break;
		case 3:
			pageName = "junlin/jsp/warehouse/base/takeStockOrder/financialAudit";
			break;
		case 4:
			pageName = "junlin/jsp/warehouse/base/takeStockOrder/managerAudit";
			break;

		default:
			break;
		}

		return pageName;

	}

	/**
	 * 页面DataTable展示信息
	 * @param request
	 * @param page 标志哪个页面(1:财务发起页面  2:仓库盘点页面  3:财务审核页面  4:总经理审核页面)
	 *
	 * @param takeStockDate 日期
	 * @param originator 制单人
	 * @return
	 */
	@RequestMapping(value="dataTables",method=RequestMethod.POST)
	@ResponseBody
	public DataTables dataTables(HttpServletRequest request,
			Integer page, Integer warehouseId, String takeStockDate, String originator,String searchType) {
		DataTables dataTables = DataTables.createDataTables(request);
		
		return takeStockOrderService.getDataTables(dataTables, page, warehouseId, takeStockDate, originator,searchType);
		
	}
	
	/**
	 * 根据主键id查询详情
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "selectTakeStockOrderDetailById")
	public TakeStockOrder selectTakeStockOrderDetailById(HttpServletRequest request, Integer id) {
		return takeStockOrderService.selectTakeStockOrderDetailById(id);
	}
	
	/**
	 * 新增盘点单 
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addTakeStockOrder", method = RequestMethod.POST)
	public JSONObject addTakeStockOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();

		// 获取ajax传递过来的参数
		String tso = request.getParameter("takeStockOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(tso);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("takeStockOrderCommodities", TakeStockOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		TakeStockOrder takeStockOrder = (TakeStockOrder) net.sf.json.JSONObject.toBean(jsonobject, TakeStockOrder.class, map);
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		takeStockOrder.setOriginator(userIdentifier);
		
		//状态默认为1
		takeStockOrder.setState(1);
		
		String maxIdentifier = takeStockOrderService.selectMaxIdentifier();
		// 生成编号
		String identifier = SundryCodeUtil.createInvoicesIdentifier("BA", maxIdentifier);
		takeStockOrder.setIdentifier(identifier);
		takeStockOrder.setIsDelete(0);
		if (takeStockOrderService.insertSelective(takeStockOrder) > 0) {
			for (TakeStockOrderCommodity tsoc : takeStockOrder.getTakeStockOrderCommodities()) {
				
				tsoc.setTakeStockOrderId(takeStockOrder.getId());
			}
			//向盘点单商品表中批量添加数据
			takeStockOrderCommodityService.insertBeatch(takeStockOrder.getTakeStockOrderCommodities());
			// 往log表中插入操作数据
			insertLog(operateType, takeStockOrder.getIdentifier(), Constants.OPERATE_INSERT, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
			return rmsg;

		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 编辑盘点单
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/editTakeStockOrder", method = RequestMethod.POST)
	public JSONObject editSalesOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		
		// 获取ajax传递过来的参数
		String tso = request.getParameter("takeStockOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(tso);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("takeStockOrderCommodities", TakeStockOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		TakeStockOrder takeStockOrder = (TakeStockOrder) net.sf.json.JSONObject.toBean(jsonobject, TakeStockOrder.class, map);
		
		if (takeStockOrderService.updateByPrimaryKeySelective(takeStockOrder) > 0) {
			takeStockOrderCommodityService.deleteMsgByTakeStockOrderId(takeStockOrder.getId());

			for (TakeStockOrderCommodity tsoc : takeStockOrder.getTakeStockOrderCommodities()) {
				tsoc.setTakeStockOrderId(takeStockOrder.getId());
			}
			//向盘点单商品表中批量添加数据
			takeStockOrderCommodityService.insertBeatch(takeStockOrder.getTakeStockOrderCommodities());
			// 往log表中插入操作数据
			insertLog(operateType, takeStockOrder.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
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
	 * 删除盘点单
	 * @param id 盘点单id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteTakeStockOrder", method = RequestMethod.POST)
	public JSONObject deleteTakeStockOrder(HttpServletRequest request, Integer id) throws Exception {
		JSONObject rmsg = new JSONObject();
		TakeStockOrder takeStockOrder = takeStockOrderService.selectByPrimaryKey(id);
		if (takeStockOrderService.deleteByPrimaryKey(id) > 0) {
 			// 往log表中插入操作数据
			insertLog(operateType, takeStockOrder.getIdentifier(), Constants.OPERATE_DELETE, new Date(),
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
	 * @param state（ 1:未发送至仓库    2:仓库盘点中   3:待财务审批   4：财务审批驳回   5:待总经理审批   6:总经理审批驳回   7:已完成）
	 *            要修改为的状态值
	 * @param isCheck
	 *            是否是审核 0:否，1：是（决定是否修改财务审批人/总经理审批人）
	 * @param reviewerType
	 *            审批类型（1：财务审核，2：总经理审核）isCheck == 0时请传0
	 * @param msg
	 *            操作成功后页面中弹出的消息提醒内容（如："操作成功，已通过"、"操作成功，已驳回"等）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateStateByIds", method = RequestMethod.POST)
	public JSONObject updateStateByIds(HttpServletRequest request, String[] ids, int state, int isCheck,
			int reviewerType, String msg) throws Exception {
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
			switch (reviewerType) {
			case 1://财务审批
				map.put("financeReviewer", operatorIdentifier);
				map.put("managerReviewer", null);
				break;
			case 2://总经理审批
				map.put("financeReviewer", null);
				map.put("managerReviewer", operatorIdentifier);
				break;
			default:
				map.put("financeReviewer", null);
				map.put("managerReviewer", null);
				break;
			}
			
		}
		if (takeStockOrderService.updateStateByIds(map)) {
			//总经理审批通过时修改商品的库存数为实盘数量
			if(state == 7) {//总经理审批通过
				int realNum;
				int commoditySpecificationId;
				Inventory inventory = new Inventory();
				for (int i = 0; i < list.size(); i++) {//遍历盘点单id列表
					List<TakeStockOrderCommodity> takeStockOrderCommodities= takeStockOrderCommodityService.selectByTakeStockOrderId(list.get(i));//根据盘点单id获取盘点商品列表
					for (int j = 0; j < takeStockOrderCommodities.size(); j++) {//遍历某个盘点单的商品列表
						//获取实盘数量
						realNum = takeStockOrderCommodities.get(j).getRealNum();
						//获取商品规格id
						commoditySpecificationId = takeStockOrderCommodities.get(j).getCommoditySpecificationId();
						
						inventory.setInventory(realNum);//设置库存为实盘数量
						inventory.setSpecificationId(commoditySpecificationId);//设置商品规格id
						//根据商品规格id修改商品的库存数量为实盘数量
						inventoryService.updateInventoryByCommoditySpecificationId(inventory);
					}
				
				}
			}
			
			
			// 插入日志
			// 保存操作的对象编号
			List<TakeStockOrder> takeStockOrders = takeStockOrderService.getTakeStockOrderByIds(list);
			// 操作对象
			String operateObject = "";
			for (int i = 0; i < takeStockOrders.size(); i++) {
				operateObject += takeStockOrders.get(i).getIdentifier();
				if (i < takeStockOrders.size() - 1) {
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
	/**
	 * 仓库盘点页面编辑
	 * @param request
	 * @param id TakeStockOrder的id
	 * @param identifier TakeStockOrder的编号
	 * @param commodity TakeStockOrderCommodity信息（id 实盘数 盈亏数 金额）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "editTakeStockOrderCommodity", method = RequestMethod.POST)
	public JSONObject editTakeStockOrderCommodity(HttpServletRequest request, int id, String identifier, String commodity) throws Exception {
		JSONObject rmsg = new JSONObject();
		JSONArray json = JSONArray.parseArray(commodity); // 首先把字符串转成 JSONArray对象
		TakeStockOrder tso = new TakeStockOrder();
		tso.setId(id);
		tso.setState(3);// 修改状态为待财务审核
		

		// 修改盘点单的状态为待财务审核
		if (takeStockOrderService.updateByPrimaryKeySelective(tso) > 0) {//修改成功
			//遍历对应的盘点商品信息  修改实盘数量、盈亏数量、金额
			TakeStockOrderCommodity takeStockOrderCommodity = new TakeStockOrderCommodity();
			for (int i = 0; i < json.size(); i++) {
				JSONObject job = json.getJSONObject(i); // 遍历jsonarray数组，把每一个对象转成json 对象
				takeStockOrderCommodity.setId(job.getInteger("id"));
				takeStockOrderCommodity.setRealNum(job.getInteger("realNum"));
				takeStockOrderCommodity.setProfitOrLossNum(job.getInteger("profitOrLossNum"));
				takeStockOrderCommodity.setMoney(job.getDouble("money"));
				takeStockOrderCommodityService.updateByPrimaryKeySelective(takeStockOrderCommodity);
			}
			// 往log表中插入操作数据
			insertLog(operateType, identifier, Constants.OPERATE_UPDATE, new Date(),
								GetSessionUtil.GetSessionUserIdentifier(request));
			
			rmsg.put("success", true);
			rmsg.put("msg", "操作成功！");
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败，请确认后重新操作！");
		return rmsg;
															
	}
	
	/**
	 * 打印
	 * @param request
	 * @param id 盘点单id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/printTakeStockOrder")
	public JSONObject printTakeStockOrder(HttpServletRequest request, Integer id) throws Exception {
		return createPrintTakeStockOrderJSON(request, takeStockOrderService.selectTakeStockOrderDetailById(id));
	}
	
	/**
	 * 更改单据打印次数
	 * @param request
	 * @param id 单据id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateTakeStockOrderPrintNum")
	public JSONObject updateTakeStockOrderPrintNum(HttpServletRequest request, int id) throws Exception {

		JSONObject rmsg = new JSONObject();
		TakeStockOrder takeStockOrder = takeStockOrderService.selectByPrimaryKey(id);
		String identifier = takeStockOrder.getIdentifier();
		int printNum = takeStockOrder.getPrintNum();
		printNum += 1;
		takeStockOrder = new TakeStockOrder();
		takeStockOrder.setId(id);
		takeStockOrder.setPrintNum(printNum);
		if (takeStockOrderService.updateByPrimaryKeySelective(takeStockOrder) > 0) {
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
	 * 生成盘点单单据打印信息
	 * @param takeStockOrder 盘点单信息
	 * @return 页面所需的信息   JSON格式
	 */
	private JSONObject createPrintTakeStockOrderJSON(HttpServletRequest request, TakeStockOrder takeStockOrder) {
		JSONObject takeStockOrderJSON = new JSONObject();
		takeStockOrderJSON.put("title", "盘点单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		takeStockOrderJSON.put("date", dateFormat.format(takeStockOrder.getTakeStockDate()));
		takeStockOrderJSON.put("oddNumbers", takeStockOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("仓库");
		head.setFieldValue(takeStockOrder.getWarehouseName());
		heads.add(head);
		takeStockOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位", "账面数量", "实盘数量","盈亏数量","业务单价", "金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (TakeStockOrderCommodity tsoc : takeStockOrder.getTakeStockOrderCommodities()) {
			String[] tbody = { tsoc.getCommoditySpecification().getSpecificationIdentifier(),
					tsoc.getCommoditySpecification().getCommodity().getName(),
					tsoc.getCommoditySpecification().getSpecificationName(),
					tsoc.getCommoditySpecification().getBaseUnitName(),
					tsoc.getInventoryNum() + "",
					tsoc.getRealNum() + "",
					tsoc.getProfitOrLossNum() + "",
					tsoc.getUnitPrice() + "",
					tsoc.getMoney() + "" };
			totalMoney += tsoc.getMoney();
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

		takeStockOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(takeStockOrder.getDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(takeStockOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (takeStockOrder.getOriginatorName() != null && takeStockOrder.getOriginatorName() != "") {
			footer.setFieldValue(takeStockOrder.getOriginator() + "(" + takeStockOrder.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(takeStockOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(takeStockOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("打印人");
		footer.setFieldValue(GetSessionUtil.GetSessionUserIdentifier(request) + "(" + GetSessionUtil.GetSessionUserName(request) + ")");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("打印日期");
		footer.setFieldValue(dateFormat.format(new Date()));
		footers.add(footer);
		takeStockOrderJSON.put("footer", footers);
		/* footer end */

		return takeStockOrderJSON;
	}
	/**
	 * 盘点单报表信息
	 * @param 
	 * @return
	 */
//	@ResponseBody
//	@RequestMapping(value = "reportTakeStockOrderMsg")
//	public List<TakeStockOrder>  reportTakeStockOrderMsg(){
//		return takeStockOrderService.reportTakeStockOrderMsg();
//	}
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
	
	
	/**
	 * 更改单据打印次数
	 * @param request
	 * @param id 单据id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "takeStockOrderDetail")
	public JSONObject takeStockOrderDetail( int id) throws Exception {
		TakeStockOrder takeStockOrder = takeStockOrderService.selectTakeStockOrderDetailById(id);
		return createTakeStockOrderDetail(takeStockOrder);
	}
	/**
	 * 生成盘点单详情
	 * @param takeStockOrder 盘点单信息
	 * @return 页面所需的信息   JSON格式
	 */
	private JSONObject createTakeStockOrderDetail(TakeStockOrder takeStockOrder) {
		JSONObject takeStockOrderJSON = new JSONObject();
		takeStockOrderJSON.put("title", "盘点单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		takeStockOrderJSON.put("date", dateFormat.format(takeStockOrder.getTakeStockDate()));
		takeStockOrderJSON.put("oddNumbers", takeStockOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("仓库");
		head.setFieldValue(takeStockOrder.getWarehouseName());
		heads.add(head);
		takeStockOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位", "账面数量", "实盘数量(袋)", "实盘数量(箱)","盈亏数量","业务单价", "金额",
				"条形码","产品批号","生产日期","有效期至","备注"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
	    Integer totalInventoryNum=0;
	    Integer totalRealNum=0;
	    Integer totalProfitOrLossNum=0;
	    DecimalFormat df1 = new DecimalFormat("0.0");   
		for (TakeStockOrderCommodity tsoc : takeStockOrder.getTakeStockOrderCommodities()) {
			CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(tsoc.getCommoditySpecificationId());
			//Inventory inventory=commoditySpecification.getInventories().get(0);
			Integer commodityNum=tsoc.getRealNum()==null?0:tsoc.getRealNum();
		 
			Integer boxNum=commoditySpecification.getUnits().size()>1?commodityNum/commoditySpecification.getUnits().get(1).getRatioMolecular():0;
			
  
			String[] tbody = { tsoc.getCommoditySpecification().getSpecificationIdentifier(),
					tsoc.getCommoditySpecification().getCommodity().getName(),
					tsoc.getCommoditySpecification().getSpecificationName(),
					tsoc.getCommoditySpecification().getBaseUnitName(),
					tsoc.getInventoryNum() + "",
					(tsoc.getRealNum()==null?0:tsoc.getRealNum()) + "",
					boxNum+ "",
					(tsoc.getProfitOrLossNum()==null?0:tsoc.getProfitOrLossNum()) + "",
					(tsoc.getUnitPrice()==null?0.0:tsoc.getUnitPrice()) + "",
					(tsoc.getMoney()==null?0.0:df1.format(tsoc.getMoney())) + "" ,
					commoditySpecification.getUnits().get(0).getBarCode(),
					"","","",""
 					};
			
			totalInventoryNum+= tsoc.getInventoryNum()==null?0:tsoc.getInventoryNum();
		    totalRealNum+=tsoc.getRealNum()==null?0:tsoc.getRealNum();
		    totalProfitOrLossNum+=tsoc.getProfitOrLossNum()==null?0:tsoc.getProfitOrLossNum();
		    totalMoney += tsoc.getMoney()==null?0:tsoc.getMoney();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "4");
		totalCountJSON.put("colTotal",totalInventoryNum.toString());
		totalCountList.add(totalCountJSON);	
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal",totalRealNum.toString());
		totalCountList.add(totalCountJSON);
		
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "7");
		totalCountJSON.put("colTotal",totalProfitOrLossNum.toString());
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		
		totalCountJSON.put("col", "9");
		totalCountJSON.put("colTotal",df1.format(totalMoney));
		totalCountList.add(totalCountJSON);
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);

		takeStockOrderJSON.put("table", tableJSON);
		/* table end */

		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
 
		FormHeadAndFooter	footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (takeStockOrder.getOriginatorName() != null && takeStockOrder.getOriginatorName() != "") {
			footer.setFieldValue(takeStockOrder.getOriginator() + "(" + takeStockOrder.getOriginatorName() + ")");
		} else {
			footer.setFieldValue(takeStockOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("财务审核人");
		footer.setFieldValue(takeStockOrder.getFinanceReviewerName()==null?"":takeStockOrder.getFinanceReviewer() + "("+takeStockOrder.getFinanceReviewerName()+ ")");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("总经理审核人");
		footer.setFieldValue(takeStockOrder.getManagerReviewerName()==null?"":takeStockOrder.getManagerReviewer() + "("+takeStockOrder.getManagerReviewerName()+ ")");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(takeStockOrder.getSummary()!=null?takeStockOrder.getSummary():"");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue("总部");
		footers.add(footer);
		takeStockOrderJSON.put("footer", footers);
		/* footer end */
 

		return takeStockOrderJSON;
	}
}
