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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.FormHeadAndFooter;
import com.jl.psi.model.Inventory;
import com.jl.psi.model.Log;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.model.SalesOrderReviewer;
import com.jl.psi.model.SalesPlanOrder;
import com.jl.psi.model.SalesPlanOrderCommodity;
import com.jl.psi.service.InventoryService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.SalesOrderCommodityService;
import com.jl.psi.service.SalesOrderReviewerService;
import com.jl.psi.service.SalesOrderService;
import com.jl.psi.service.SalesPlanOrderCommodityService;
import com.jl.psi.service.SalesPlanOrderService;
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
@RequestMapping("/sales/salesPlanOrder/")
public class SalesPlanOrderController extends BaseController {

	// 当前类操作的类型(往log日志表中存储)
	private int operateType = Constants.TYPE_LOG_SALES;

	// 声明Log类
	Log log;

	@Autowired
	SalesPlanOrderService salesPlanOrderService;
	@Autowired
	SalesPlanOrderCommodityService salesPlanOrderCommodityService;
	@Autowired
	LogService logService;
	@Autowired
	InventoryService inventoryService;

	/**
	 * 进入页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}

		return "junlin/jsp/sales/salesPlan";

	}

	/**
	 * 页面table数据的显示
	 * 
	 * @param request
	 * @param identifier
	 *            单据编号
	 * @param commodityName
	 *            商品名称
	 * @param originator
	 *            操作人编号
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getSalesPlanOrderMsg")
	public DataTables getSalesPlanOrderMsg(HttpServletRequest request, String identifier, String commodityName,
			String originator,String createTime,Integer state) {
		DataTables dataTables = DataTables.createDataTables(request);

		return salesPlanOrderService.getSalesPlanOrderMsg(dataTables, identifier, commodityName, originator, createTime,state);
	}

	/**
	 * 新增销售计划单 
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addSalesPlanOrder", method = RequestMethod.POST)
	public JSONObject addSalesPlanOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();

		// 获取ajax传递过来的参数
		String so = request.getParameter("salesPlanOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(so);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("salesPlanOrderCommodities", SalesPlanOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		SalesPlanOrder salesPlanOrder = (SalesPlanOrder) net.sf.json.JSONObject.toBean(jsonobject, SalesPlanOrder.class, map);
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		salesPlanOrder.setOriginator(userIdentifier);
		Date date = new Date();
		salesPlanOrder.setCreateTime(date);
		salesPlanOrder.setCurrency(1);
		salesPlanOrder.setBranch("总部");
		salesPlanOrder.setState(1);
		salesPlanOrder.setIsAppOrder(1);
		String maxIdentifier = salesPlanOrderService.selectMaxIdentifier();

		// 生成编号
		String identifier = SundryCodeUtil.createInvoicesIdentifier("SP", maxIdentifier);
		salesPlanOrder.setIdentifier(identifier);
		
		if (salesPlanOrderService.insertSelective(salesPlanOrder) > 0) {
			System.out.println("salesPlanOrder.getId():"+salesPlanOrder.getId());
			System.out.println("size:"+salesPlanOrder.getSalesPlanOrderCommodities().size());
			for (SalesPlanOrderCommodity spc : salesPlanOrder.getSalesPlanOrderCommodities()) {
				spc.setSalesPlanOrderId(salesPlanOrder.getId());
			}
			salesPlanOrderCommodityService.insertBeatch(salesPlanOrder.getSalesPlanOrderCommodities());
			// 根据规格id修改商品的占用数量
			Inventory inventory;
			for (SalesPlanOrderCommodity spoc : salesPlanOrder.getSalesPlanOrderCommodities()) {
				inventory = new Inventory();
				inventory.setSpecificationId(spoc.getCommoditySpecificationId());
				inventory.setOccupiedInventory(spoc.getNumber());
				inventoryService.updateOccupiedInventoryByCommoditySpecificationId(inventory);
				
			}
			// 往log表中插入操作数据
			insertLog(operateType, salesPlanOrder.getIdentifier(), Constants.OPERATE_INSERT, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
			return rmsg;

		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 删除销售计划单
	 * @param request
	 * @param id  销售计划单Id
	 * @param type 是否需要修改库存里的占用信息 0:不需要清库存，1：需要清库存
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteSalesPlanOrder", method = RequestMethod.POST)
	public JSONObject deleteSalesPlanOrder(HttpServletRequest request, Integer id,Integer type,String identifier) throws Exception {
		JSONObject rmsg = new JSONObject();
		List<SalesPlanOrderCommodity> salesPlanOrderCommodities=null;
		//需要清库存
		if(type==1){
			//获取销售计划单的商品
			salesPlanOrderCommodities=salesPlanOrderCommodityService.selectMsgBySalesPlanOrderId(id);
		}	
		SalesPlanOrder updateSalesPlanOrder=new SalesPlanOrder();
		updateSalesPlanOrder.setId(id);
		updateSalesPlanOrder.setState(4);
		if (salesPlanOrderService.updateByPrimaryKeySelective(updateSalesPlanOrder) > 0) {
			Inventory inventory;
			//解除库存锁定
			if(type==1&&(salesPlanOrderCommodities!=null&&salesPlanOrderCommodities.size()>0)){
				// 遍历商品 并根据规格id修改商品的占用数量（解除锁定库存）
				for (SalesPlanOrderCommodity spoc : salesPlanOrderCommodities) {
					inventory = new Inventory();
					inventory.setSpecificationId(spoc.getCommoditySpecificationId());
					inventory.setOccupiedInventory(spoc.getNumber());
					inventoryService.updateOccupiedInventoryToReduceByCommoditySpecificationId(inventory);
				}
			}		
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
	 * 销售计划单详情
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "salesPlanOrderDetail")
	public JSONObject salesPlanOrderDetail(Integer id) {
		SalesPlanOrder planOrder=salesPlanOrderService.getSalesPlanOrderDetail(id);
		return createSalesPlanOrderJSON(planOrder);			
	}
	
	/**
	 * 销售计划单详情--拼的json
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createSalesPlanOrderJSON(SalesPlanOrder planOrder) {
		JSONObject outboundOrderJSON = new JSONObject();
		outboundOrderJSON.put("title", "销售计划单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		outboundOrderJSON.put("date", dateFormat.format(planOrder.getCreateTime()));
		outboundOrderJSON.put("oddNumbers", planOrder.getIdentifier());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("计划对象");
		if(planOrder.getIsAppOrder()!=null&&planOrder.getIsAppOrder()==2){
			head.setFieldValue(planOrder.getSupcto()==null?"APP":planOrder.getSupcto().getName());
		}
		else{
			head.setFieldValue(planOrder.getSupcto()==null?"":planOrder.getSupcto().getName());
		}
		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("计划区间");
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		if(planOrder.getIsAppOrder()!=null&&planOrder.getIsAppOrder()==2){
			head.setFieldValue("");
		}
		else{
			if(planOrder.getCreateTime()!=null&&planOrder.getEndTime()!=null){
				head.setFieldValue(dateFormat2.format(planOrder.getCreateTime())+"~"+dateFormat2.format(planOrder.getEndTime()));
			}
			else{
				head.setFieldValue("");
			}
			
		}
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("结束日期");
		head.setFieldValue(planOrder.getEndTime()==null?"":dateFormat2.format(planOrder.getEndTime()));
		heads.add(head);
		  head = new FormHeadAndFooter();
		head.setFieldName("币种");	
		head.setFieldValue("人民币");		
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("汇率");
 		head.setFieldValue("");
		heads.add(head);
		head = new FormHeadAndFooter();
		head.setFieldName("金额");
		double totalMoney=0.0;
		for(SalesPlanOrderCommodity commodity:planOrder.getSalesPlanOrderCommodities()){
			totalMoney+=commodity.getMoney()==null?0.0:commodity.getMoney();
		}
 		head.setFieldValue(totalMoney+"");
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		head = new FormHeadAndFooter();
		head.setFieldName("分支机构");
 		head.setFieldValue("总部");
		heads.add(head);
		outboundOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格","品牌", "单位",  "业务数量","业务单价","金额","备注"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//业务数量
		Integer totalDeliverGoodsNum=0;

		for (SalesPlanOrderCommodity commodity:planOrder.getSalesPlanOrderCommodities()) {
			String[] tbody = { commodity.getCommoditySpecification().getSpecificationIdentifier(),
					commodity.getCommoditySpecification().getCommodity().getName(),
					commodity.getCommoditySpecification().getSpecificationName(),
					commodity.getCommoditySpecification().getCommodity().getBrand(),
					commodity.getCommoditySpecification().getBaseUnitName(), commodity.getNumber() + "",
					commodity.getUnitPrice() + "",commodity.getMoney()==null?0.0+"":commodity.getMoney()+"",commodity.getRemark()==null?"":commodity.getRemark()};
			//System.out.println("DeliverGoodsMoney:" + soc.getDeliverGoodsMoney());

			totalDeliverGoodsNum+=commodity.getNumber()==null?0:commodity.getNumber();
			tbodys.add(tbody);
		}
		// tbody end
		// total
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "5");
		totalCountJSON.put("colTotal",totalDeliverGoodsNum);
		totalCountList.add(totalCountJSON);
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "7");
		totalCountJSON.put("colTotal",totalMoney+"");
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
		footer.setFieldValue(planOrder.getPersonDepartmentName()==null?"":planOrder.getPersonDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(planOrder.getPersonName()==null?"":planOrder.getPersonName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (planOrder.getOriginatorName() != null) {
			footer.setFieldValue(planOrder.getOriginator()+"("+planOrder.getOriginatorName()+")");
		} else {
			footer.setFieldValue(planOrder.getOriginator()==null?"":planOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("地区");
		footer.setFieldValue("");
		footers.add(footer); 
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(planOrder.getSummary()==null?"":planOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单机构");
		footer.setFieldValue(planOrder.getBranch()==null?"总部":planOrder.getBranch());
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
