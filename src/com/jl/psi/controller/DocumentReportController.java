package com.jl.psi.controller;



import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.jta.OC4JJtaTransactionManager;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.AllotOrder;
import com.jl.psi.model.AllotOrderCommodity;
import com.jl.psi.model.Bills;
import com.jl.psi.model.BillsSub;
import com.jl.psi.model.BreakageOrder;
import com.jl.psi.model.BreakageOrderCommodity;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.Department;
import com.jl.psi.model.PackageOrTeardownOrder;
import com.jl.psi.model.PackageOrTeardownOrderCommodity;
import com.jl.psi.model.Person;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.model.SalesPlanOrder;
import com.jl.psi.model.SalesPlanOrderCommodity;
import com.jl.psi.model.SettlementType;
import com.jl.psi.model.ShippingMode;
import com.jl.psi.model.Supcto;
import com.jl.psi.model.TakeStockOrder;
import com.jl.psi.model.TakeStockOrderCommodity;
import com.jl.psi.model.Warehouse;
import com.jl.psi.model.WriteOffSub;
import com.jl.psi.service.AllocteOrderService;
import com.jl.psi.service.BillsService;
import com.jl.psi.service.BillsSubService;
import com.jl.psi.service.BreakageOrderService;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.PackageOrTeardownOrderService;
import com.jl.psi.service.ProcureTableService;
import com.jl.psi.service.SalesOrderCommodityService;
import com.jl.psi.service.SalesOrderService;
import com.jl.psi.service.SalesPlanOrderService;
import com.jl.psi.service.TakeStockOrderService;
import com.jl.psi.service.WriteOffSubService;
import com.jl.psi.utils.GetSessionUtil;
import com.sun.glass.ui.GestureSupport;
import com.sun.org.apache.xpath.internal.operations.Mod;
import com.sun.scenario.effect.impl.prism.ps.PPSBlend_ADDPeer;



@Controller
@RequestMapping("/basic/documentReport/")
public class DocumentReportController extends BaseController{

	@Autowired
	PackageOrTeardownOrderService packageOrTeardownOrderService;
	@Autowired
	TakeStockOrderService takeStockOrderService;
	@Autowired
	BreakageOrderService breakageOrderservice;
	@Autowired
	AllocteOrderService  allotOrderService;
	@Autowired
	SalesOrderService  salesOrderService;
	@Autowired
	SalesPlanOrderService planOrderService;
	@Autowired
	ProcureTableService procureTableService;
	@Autowired
	SalesOrderCommodityService salesOrderCommodityService;
	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	@Autowired
	WriteOffSubService  writeOffSubService;
	@Autowired
	BillsService billsService;
	@Autowired
	BillsSubService billsSubService;
	DecimalFormat df1 = new DecimalFormat("0.00");
	NumberFormat nf = NumberFormat.getNumberInstance();
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "junlin/jsp/documentReport/documentReport";

		return pageName;
		
	}
	/**
	 * 报表类型跳转
	 * @param orderType(1:组装单，2:拆卸单)
	 * @return 
	 * @throws UnsupportedEncodingException 
	 */
	@ResponseBody
	@RequestMapping(value = "switchMenu")
	public JSONObject switchMenu(Integer orderType,HttpServletRequest request) throws UnsupportedEncodingException {
		JSONObject jsonObject=null;
		String data=request.getParameter("orderTime");
		String []  arr=data.split(" - ");
		String 	commodityName = new String(request.getParameter("commodityName"));
		System.out.println(data);
		String 	supctoName=new String(request.getParameter("supctoName"));
		String 	brand=new String(request.getParameter("brand"));
		String province=request.getParameter("province");
		String city=request.getParameter("city");
		String area=request.getParameter("area");
		System.out.println(">>>>>>>>report"+city);
		if (province.equals("-1")) {
			System.out.println("province -1");
			province="";
		}
		if (city.equals("null")) {
			city="";
		}
		if (area.equals("-1")) {
			area="";
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("beginTime", arr[0]);
		params.put("closeTime", arr[1]);
		params.put("identifier", request.getParameter("identifier"));
		params.put("state", request.getParameter("state"));
		params.put("shippingModel", request.getParameter("shippingModel"));
		params.put("supctoTypeId", request.getParameter("supctoType"));
		params.put("supctoName", supctoName);
		params.put("cname", commodityName);
		params.put("commodity_identifier", request.getParameter("commodity_identifier"));
		params.put("brand", brand);
		params.put("warehouseMsgId", request.getParameter("warehouseMsg"));
		params.put("area", area);
		params.put("province", province);
		params.put("city", city);
		params.put("supctoTypeClassId", request.getParameter("query_classification_one_id"));
		
		params.put("departmentClassOneId", request.getParameter("departmentClassOne"));
		params.put("makeOrderPersonId", request.getParameter("makeOrderPerson"));
		params.put("checkDepartmentId", request.getParameter("checkDepartment"));
		params.put("checkPersonId", request.getParameter("checkPerson"));
		params.put("supctoTypeClassTwoId", request.getParameter("query_classification_two_id"));
		params.put("makeIdentifier", request.getParameter("makeIdentifier"));
		params.put("rewviewIdentifier", request.getParameter("rewviewIdentifier"));
		System.out.println(">>>>>supctoTypeClassTwoId"+request.getParameter("checkDepartment")+request.getParameter("checkPerson"));
		switch (orderType) {
		//报损单汇总表
		case 1:
			jsonObject=this.reportBreakageOrder(params, arr);
			break;
		//采购订单汇总表
		case 2:
			jsonObject=this.reportProcureOrderGether(params, arr);
			break;
		//采购订单明细表
		case 3:
			jsonObject=this.reportProcureOrderDetail(params, arr);
			break;
		//采购计划汇总表
		case 4:
			jsonObject=this.reportProcurePlanOrderGether(params, arr);
			break;
		//采购计划明细表
		case 5:
			jsonObject=this.reportProcurePlanOrderDetail(params, arr);
			break;
		//采购开单汇总表
		case 6:
			jsonObject=this.reportProcureFinishOrderDetailOrGether(params, arr, 1);
			break;
		//采购开单明细表
		case 7:
			jsonObject=this.reportProcureFinishOrderDetailOrGether(params, arr, 2);
			break;
		//拆卸单明细表
		case 8:
			jsonObject=this.reportPackageOrTeardownOrder(2, params, arr);
			break;
		//出库单汇总表
		case 9:
			jsonObject=this.reportGatherSalesOrder(params, arr);
			break;
		//出库单明细表
		case 10:
			jsonObject=this.reportExportSalesOrder(params,arr);
			break;
		//货品销售日常报表
		case 11:
			jsonObject=this.reportSalesDayDetais(params, arr);
			break;
		//盘点单明细表
		case 12:
			jsonObject=this.reportTakeStockOrder(params, arr);
			break;
		//入库单汇总表
		case 13:
			jsonObject=this.reportImportOrderDetailOrGether(params, arr, 1);
			break;
		//入库单明细表
		case 14:
			jsonObject=this.reportImportOrderDetailOrGether(params, arr, 2);
			break;
		//调拨单明细
		case 15:
			jsonObject=this.reportAllotOrder(params, arr);
			break;
		//销售订单明细表
		case 16:
			jsonObject=this.reportOrderDetail(params, arr);
			break;
		//销售计划单明细表
		case 17:
			jsonObject=this.reportOrderPlanDetail(params, arr);
			break;
		//销售开单汇总表
		case 18:
			jsonObject=this.reportSalesOrderOpenGether(params, arr);
			break;
		//销售开单明细表
		case 19:
			jsonObject=this.reportSalesOrderOpenDetail(params, arr);
			break;
		//销售开单收款情况一览表
		case 20:
			jsonObject=this.reportSalesOpenReceiveMoney(params, arr);
			break;
		//采购开单付款情况一览表
		case 21:
			jsonObject=reportProcureFinishOrderPayMoneyDetail(request,params, arr);
			break;
		//销售毛利汇总表
		case 22:
			jsonObject=this.reportProfitGether(params, arr);
			break;
		//销售毛利明细表
		case 23:
			jsonObject=this.reportProfitDetail(params, arr);
			break;
		//应付账款汇总表
		case 24:
			jsonObject=this.reportPayMoneyGether(params, arr,2);
			break;
		//应收账款汇总表
		case 25:
			jsonObject=this.reportPayMoneyGether(params, arr,1);
			break;
		//账面库存汇总表
		case 26:
			jsonObject=this.reportAccountsGether(params, arr);
			break;
		//账面库存明细表
		case 27:
			jsonObject=this.reportAccountsDetail(params, arr);
			break;
		//组装单明细表
		case 28:
			jsonObject=this.reportPackageOrTeardownOrder(1, params, arr);
			break;
		//其他收货单明细表
		case 29:
			jsonObject=this.reportOtherReceiveOrder(params, arr);
			break;
		//其他发货单明细表
		case 30:
			jsonObject=this.reportOtherDeliverOrder(params, arr);
			break;
		default:
			break;
		}
		return jsonObject;
	}
	/**
	 * 组装单/拆卸单明细表
	 * @param orderType(1:组装单，2:拆卸单)
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportPackageOrTeardownOrder(Integer orderType,Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  packageOrTeardownJSON= new JSONObject();
		params.put("orderType", orderType);
		
		List<PackageOrTeardownOrder>	list=packageOrTeardownOrderService.reportPackageOrTeardownOrderMsg(params);
		if (orderType==1) {
			packageOrTeardownJSON.put("title", "组装单明细表");
		}else {
			packageOrTeardownJSON.put("title", "拆卸单明细表");
		}
		
		packageOrTeardownJSON.put("beginDate", arr[0]);
		packageOrTeardownJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		if (orderType==1) {
			String[] theads = { "货品编码", "货品名称", "规格","品牌","单位","仓库","基本数量","金额","占用库存" };
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			Double totalMoney = 0.0;
			
			for (PackageOrTeardownOrder pp : list) {
				for (PackageOrTeardownOrderCommodity poto : pp.getPackageOrTeardownOrderCommodities()) {
					String[] tbody= {
							
							poto.getCommoditySpecification().getSpecificationIdentifier(),
							poto.getCommoditySpecification().getCommodity().getName(),
							poto.getCommoditySpecification().getSpecificationName(),
							poto.getCommoditySpecification().getCommodity().getBrand(),
							
							poto.getCommoditySpecification().getUnits().get(0).getName(),
							poto.getCommoditySpecification().getInventories().get(0).getWarehouse().getName(),
							pp.getPackageOrTeardownNum()+"",
							nf.format(pp.getTotalMoney())+"",
							pp.getInventory().getOccupiedInventory()+""};
					
			        totalMoney+=pp.getTotalMoney();
					tbodys.add(tbody);
				}
			}
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			List<JSONObject> tt = new ArrayList<>();
			JSONObject totalJSONColumns = new JSONObject();
			totalJSONColumns.put("columns", 8);
			totalJSONColumns.put("content", nf.format(totalMoney));
			tt.add(totalJSONColumns);
			totalJSON.put("total", tt);
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			packageOrTeardownJSON.put("table", tableJSON);
		}else {
			String[] theads = {"单号","开单日期","货品编码", "货品名称","单位","单位数量","单价","金额","备注","占用库存" };
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			Double totalMoney = 0.0;
			
			for (PackageOrTeardownOrder pp : list) {
				for (PackageOrTeardownOrderCommodity poto : pp.getPackageOrTeardownOrderCommodities()) {
					
							
							String[] tbody= {
									pp.getIdentifier(),
									dateFormat.format(pp.getPackageOrTeardownDate()),
									poto.getCommoditySpecification().getSpecificationIdentifier(),
									poto.getCommoditySpecification().getCommodity().getName(),
									
									poto.getCommoditySpecification().getUnits().get(0).getName(),
									pp.getPackageOrTeardownNum()+"",
									pp.getUnitPrice()+"",
									nf.format(pp.getTotalMoney())+"",
									pp.getSummary(),
									pp.getInventory().getOccupiedInventory()+""};
							
					        
					
			        totalMoney+=pp.getTotalMoney();
					tbodys.add(tbody);
				}
			}
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			List<JSONObject> tt = new ArrayList<>();
			JSONObject totalJSONColumns = new JSONObject();
			totalJSONColumns.put("columns", 8);
			totalJSONColumns.put("content", nf.format(totalMoney));
			tt.add(totalJSONColumns);
			totalJSON.put("total", tt);
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			packageOrTeardownJSON.put("table", tableJSON);
		}
		
		
		
		return packageOrTeardownJSON;
		
	}
	/**
	 * 盘点单报表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	@RequestMapping(value = "reportPackageOrTeardownOrderMsg")
	public JSONObject reportTakeStockOrder(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		List<TakeStockOrder>	list=takeStockOrderService.reportTakeStockOrderMsg(params);
		takeStockOrderJSON.put("title", "盘点单明细表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "单号", "货品编码", "货品名称", "品牌","开单日期","单位", "数量","单价","金额","备注","批号","占用库存" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		for (TakeStockOrder  pp : list) {
			for (TakeStockOrderCommodity poto : pp.getTakeStockOrderCommodities()) {
				if (pp.getSummary()==null) {
					pp.setSummary("");
				}
				if (poto.getProfitOrLossNum()==null) {
					poto.setProfitOrLossNum(0);
				}
				if (poto.getMoney()==null) {
					poto.setMoney(0.0);
				}
				String[] tbody= {pp.getIdentifier(),
						
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getCommodity().getBrand(),
						dateFormat.format(pp.getTakeStockDate()),
						poto.getCommoditySpecification().getUnits().get(0).getName(),
						poto.getProfitOrLossNum()+"",
						poto.getUnitPrice()+"",
						nf.format(poto.getMoney())+"",
						pp.getSummary(),
						"",
						pp.getInventory().getOccupiedInventory()+""};
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "false");
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 报损单汇总表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	@RequestMapping(value = "reportBreakageOrder")
	public JSONObject reportBreakageOrder(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		List<BreakageOrder>	list=breakageOrderservice.reporBreakOrdertMsg(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		takeStockOrderJSON.put("title", "报损单汇总表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "品牌","仓库","单位","基本数量","金额","占用库存" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (BreakageOrder  pp : list) {
			for (BreakageOrderCommodity poto : pp.getBreakageOrderCommodities()) {
				String[] tbody= {
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						poto.getCommoditySpecification().getCommodity().getBrand(),
						poto.getCommoditySpecification().getInventories().get(0).getWarehouse().getName(),
						poto.getCommoditySpecification().getUnits().get(0).getName(),
						poto.getNumber()+"",
						nf.format(poto.getMoney())+"",
						pp.getInventory().getOccupiedInventory()+""};
				
		        totalMoney+=poto.getMoney();
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		List<JSONObject> tt = new ArrayList<>();
		JSONObject totalJSONColumns = new JSONObject();
		totalJSONColumns.put("columns", 8);
		totalJSONColumns.put("content", nf.format(totalMoney));
		tt.add(totalJSONColumns);
		totalJSON.put("total", tt);
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 调拨单明细表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportAllotOrder(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		List<AllotOrder>	list=allotOrderService.reportMsg(params);
		takeStockOrderJSON.put("title", "调拨单明细表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "行号","调出仓库名", "单据日期", "单号", "货品编码","货品名称","单位","规格", "单价","数量","金额","调入仓库名称","制单员","备注","占用库存" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//Integer num=list.size();
		Integer num2=1;
		for (AllotOrder  pp : list) {
			
			for (AllotOrderCommodity poto : pp.getAllotOrderCommodities()) {
				if (pp.getSummary()==null) {
					pp.setSummary("");
				}
				if (pp.getOriginator().contains("null")) {
					pp.setOriginator("");
				}
				if (pp.getImportName()==null) {
					pp.setImportName("");
				}
				
				String[] tbody= {
						num2+"",
						pp.getExportName(),
						dateFormat.format(pp.getAllotDate()),
						pp.getIdentifier(),
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getUnits().get(0).getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						
						
						poto.getImportUnitPrice()+"",
						poto.getNumber()+"",
						
						nf.format(poto.getImportMoney())+"",
						pp.getImportName(),
						pp.getOriginator(),
						pp.getSummary(),
						pp.getInventory().getOccupiedInventory()+""};
				tbodys.add(tbody);
				num2++;
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "false");
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 出库单明细表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportExportSalesOrder(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		//获取销售出库单和其他发货单出库单
		List<SalesOrder>	list=salesOrderService.reportExportSalesOrderDetail(params);
		//获取采购退货单出库单
		List<ProcureTable>	ptList=procureTableService.getSaleReturnDetailToReport(params);
		takeStockOrderJSON.put("title", "出库单明细表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "单号编号", "单据名称", "货品编码", "货品名称","客户/供应商名称","开单日期","单位", "数量","单价","金额","备注","批号","占用库存" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		for (SalesOrder  pp : list) {
			for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
				int type= pp.getOrderType();
				String  orderName=null;
				String num=null;
				double money=0.0;
				if (poto.getDeliverGoodsMoney()==null) {
					poto.setDeliverGoodsMoney(0.0);
				}
				if (type==3) {
					orderName="出库单";
					num=poto.getDeliverGoodsNum()+"";
					money=poto.getDeliverGoodsMoney();
				}else if (type==5) {
					orderName="返货单";
					num=poto.getReturnGoodsNum()+"";
					money=poto.getDeliverGoodsMoney();
				}else if (type==6) {
					orderName="销售退货单";
					num=poto.getReturnGoodsNum()+"";
					money=poto.getDeliverGoodsMoney();
				}else if (type==9) {
					orderName="其他发货单出库单";
					num=poto.getDeliverGoodsNum()+"";
					money=poto.getDeliverGoodsMoney();
				}
				if (poto.getRemark()==null) {
					poto.setRemark("");
				}
				if (poto.getBatchNumber()==null) {
					poto.setBatchNumber("");
				}
				String[] tbody= {
						pp.getIdentifier(),
						orderName,
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getCommodity().getSupcto()==null?"其他":poto.getCommoditySpecification().getCommodity().getSupcto().getName(),
						dateFormat.format(pp.getCreateTime()),
						poto.getCommoditySpecification().getUnits().get(0).getName(),
						num,
						poto.getUnitPrice()+"",
						nf.format(money),
						poto.getRemark(),
						poto.getBatchNumber(),
						pp.getInventory().getOccupiedInventory()+""};
				tbodys.add(tbody);
			}
		}
		
		for(ProcureTable pt:ptList){
			for(ProcureCommodity po:pt.getProcureCommoditys()){
				String[] tbody= {
						pt.getIdentifier(),
						"采购退货单出库单",
						po.getCommoditySpecification().getSpecificationIdentifier(),
						po.getCommoditySpecification().getCommodity().getName(),
						pt.getSupcto()==null?"":pt.getSupcto().getName(),
						pt.getGenerateDate()==null?"":dateFormat.format(pt.getGenerateDate()),
						po.getCommoditySpecification().getBaseUnitName(),
						po.getArrivalQuantity()==null?"0":po.getArrivalQuantity()+"",
						po.getBusinessUnitPrice()==null?"0.0":po.getBusinessUnitPrice()+"",
						nf.format(po.getTotalPrice()==null?0:po.getTotalPrice()),
						po.getRemarks()==null?"":po.getRemarks(),
						po.getLotNumber()==null?"":po.getLotNumber(),
						pt.getInventory().getOccupiedInventory()+""};
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "false");
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 出库单汇总表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportGatherSalesOrder(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		//获取销售出库单和其他发货单出库单
		List<SalesOrder>	list=salesOrderService.reportExportSalesOrder(params);
		//获取采购退货单出库单
		List<ProcureTable>	ptList=procureTableService.getSaleReturnAllMsgToReport(params);
		takeStockOrderJSON.put("title", "出库单汇总表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "货品编码"/*, "单据名称"*/, "货品名称","规格","品牌","单位","仓库", "数量","金额","占用库存"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (SalesOrder  pp : list) {
			for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
				boolean isHas=false;//判断采购退货单出库单相应的商品是否已汇总到结果集中
				String num=null;
				Double money=0.0;
				for(int j=0;j<ptList.size();j++){
					ProcureTable pt=ptList.get(j);
					for(int i=0;i<pt.getProcureCommoditys().size();i++){
						ProcureCommodity pc=pt.getProcureCommoditys().get(i);
						//判断两个结果集中是否有重复的商品信息，如果有重复的结果集，则把数量和金额加到输出的结果中，踢出采购退货单出库单列表的该数据。
						if(poto.getCommoditySpecificationId().equals(pc.getCommodityId())){
							isHas=true;//已汇总
							num=poto.getDeliverGoodsNum()+pc.getArrivalQuantity()+"";
							money=(poto.getDeliverGoodsMoney()==null?0.0:poto.getDeliverGoodsMoney())+(pc.getTotalPrice()==null?0.0:pc.getTotalPrice());
							pt.getProcureCommoditys().remove(i);
							break;
						}	
					}
					//如果汇总了，判断该采购退货单出库单列表中的子列表是否已被剔除完，若剔除完，则该父列表也会被剔除
					if(isHas){
						if(ptList.get(j).getProcureCommoditys().size()<=0){
							ptList.remove(j);
						}
						break;
					}
				}
				//两个结果集在本次循环中无交集，则把销售出库单的结果放入最终的结果集中。
				if(!isHas){
					num=poto.getDeliverGoodsNum()+"";
					money=(poto.getDeliverGoodsMoney()==null?0.0:poto.getDeliverGoodsMoney());
				}
				String[] tbody= {
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						/*orderName,*/
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						poto.getCommoditySpecification().getCommodity().getBrand(),
						poto.getCommoditySpecification().getUnits().get(0).getName(),
						
						poto.getWarehouse().getName(),
						num,
						nf.format(money)+"",
						pp.getInventory().getOccupiedInventory()+""};
		        totalMoney+=money;
				
				tbodys.add(tbody);
			}
		}
		//说明采购退货单出库单中有商品数据而销售出库单中没有，此时需要把该列数据加入最终的结果集中。
		if(ptList.size()>0){
			for(int j=0;j<ptList.size();j++){
				ProcureTable pt=ptList.get(j);
				for(int i=0;i<pt.getProcureCommoditys().size();i++){
					ProcureCommodity pc=pt.getProcureCommoditys().get(i);
					String num=null;
					Double money=0.0;
					num=pc.getArrivalQuantity()+"";
					money=pc.getTotalPrice()==null?0.0:pc.getTotalPrice();
						
					String[] tbody= {
							pc.getCommoditySpecification().getSpecificationIdentifier(),
							pc.getCommoditySpecification().getCommodity().getName(),
							pc.getCommoditySpecification().getSpecificationName(),
							pc.getCommoditySpecification().getCommodity().getBrand(),
							pc.getCommoditySpecification().getBaseUnitName(),
							
							pc.getCommoditySpecification().getSpecWarehouseName(),
							num,
							nf.format(money)+"",
							pt.getInventory().getOccupiedInventory()+""};
				    totalMoney+=money;
					tbodys.add(tbody);
						
				}				
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		List<JSONObject> tt = new ArrayList<>();
		JSONObject totalJSONColumns = new JSONObject();
		totalJSONColumns.put("columns", 8);
		totalJSONColumns.put("content", nf.format(totalMoney));
		tt.add(totalJSONColumns);
		totalJSON.put("total", tt);
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 销售订单明细表-按客户
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportOrderDetail(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		List<SalesOrder>	list=salesOrderService.reportOrderDetail(params);
		takeStockOrderJSON.put("title", "销售订单明细表-按客户");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "单号编号", "单据日期", "客户名称", "货品编码","货品名称","规格","样品","单位", "单价","订货|数量(业)","订货|金额","备注","业务员","占用库存","折扣率(%)" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		for (SalesOrder  pp : list) {
			for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
				String isSpecialOffer=null;
				if (poto.getRemark()==null) {
					poto.setRemark("");
				}
				if (pp.getIsSpecimen()==1) {
					isSpecialOffer="否";
				}else {
					isSpecialOffer="是️";
				}
				if (pp.getPerson()==null) {
					Person person=new Person();
					person.setName("");
					person.setPhone("");
					pp.setPerson(person);
				}
				if (pp.getPerson().getName()==null) {
					pp.getPerson().setName("");
				}
				if (pp.getPerson().getPhone()==null) {
					pp.getPerson().setPhone("");
				}
				if (poto.getDiscount()==null) {
					poto.setDiscount(0.0);
				}
				if (poto.getCommoditySpecification().getCommodity().getSupcto()==null) {
					Supcto supcto=new Supcto();
					if(pp.getIsAppOrder()!=null&&pp.getIsAppOrder()==2){
						supcto.setName("APP");
						supcto.setPhone(pp.getPhone());
					}
					else{
						supcto.setName("");
						supcto.setPhone("");
					}
					
					poto.getCommoditySpecification().getCommodity().setSupcto(supcto);
				}
				String[] tbody= {
						pp.getIdentifier(),
						dateFormat.format(pp.getCreateTime()),
						poto.getCommoditySpecification().getCommodity().getSupcto().getName(),
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						isSpecialOffer,
						poto.getCommoditySpecification().getUnits().get(0).getName(),
						poto.getUnitPrice()+"",
						poto.getDeliverGoodsNum()+"",
						nf.format(poto.getDeliverGoodsMoney())+"",
						poto.getRemark(),
	
						pp.getPerson().getName(),
						pp.getInventory().getOccupiedInventory()+"",
						poto.getDiscount()+""};
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "false");
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 销售计划单明细表-按客户
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportOrderPlanDetail(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		List<SalesPlanOrder>	list=planOrderService.reportSalesPlanOrderDetail(params);
		takeStockOrderJSON.put("title", "销售计划单明细表-按客户");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		
		/* table start */
		// thead
		String[] theads = { "单号编号", "单据日期", "客户名称", "货品编码","货品名称","规格","单位", "单价","订货|数量(业)","订货|金额","备注","业务员","占用库存" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		for (SalesPlanOrder  pp : list) {
			for (SalesPlanOrderCommodity poto : pp.getSalesPlanOrderCommodities()) {
				
				if (pp.getPerson()==null) {
					Person person=new Person();
					person.setName("");
					person.setPhone("");
					pp.setPerson(person);
				}
				if (pp.getPerson().getName()==null) {
					pp.getPerson().setName("");
				}
				if (pp.getPerson().getPhone()==null) {
					pp.getPerson().setPhone("");
				}
				if (pp.getSupcto()==null) {
					Supcto supcto=new Supcto();
					if(pp.getIsAppOrder()!=null&&pp.getIsAppOrder()==2){
						supcto.setName("APP");
					}
					else{
						supcto.setName("");
					}
					
					pp.setSupcto(supcto);
				}
				if (poto.getRemark()==null) {
					poto.setRemark("");
				}
				
				//System.out.println(pp.getId()+"name"+pp.getPerson().getName()+"phone>>>"+pp.getPerson().getPhone());
				String[] tbody= {
						pp.getIdentifier(),
						dateFormat.format(pp.getCreateTime()),
						pp.getSupcto().getName(),
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						
						poto.getCommoditySpecification().getUnits().get(0).getName(),
						poto.getUnitPrice()+"",
						poto.getNumber()+"",
						nf.format(poto.getMoney())+"",
						poto.getRemark(),
						pp.getPerson().getName(),
						pp.getInventory().getOccupiedInventory()+""};
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "false");
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 销售开单汇总表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportSalesOrderOpenGether(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		List<SalesOrder>	list=salesOrderService.reportSalesOrderOpenGether(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		//SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		takeStockOrderJSON.put("title", "销售开单汇总表-按客户");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "客户编码", "客户名称", "地区", "部门","折损金额","签收金额","退货金额(含税)","总金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		Double totalMoney4 = 0.0;
		for (SalesOrder  pp : list) {
			for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
				if (poto.getDamageMoney()==null) {
					poto.setDamageMoney(0.0);
				}
				
				
				if (pp.getSupcto().getCity()==null) {
					pp.getSupcto().setCity("");
				} 
				if (pp.getSupcto().getArea()==null) {
					pp.getSupcto().setArea("");
				}
				if (pp.getSupcto().getProvince()==null) {
					pp.getSupcto().setProvince("");
				}
				if (poto.getReceivingGoodsMoney()==null) {
					poto.setReceivingGoodsMoney(0.0);
				}
				if (pp.getSupcto().getIdentifier()==null) {
					pp.getSupcto().setIdentifier("");
					pp.getSupcto().setName("");
					pp.getSupcto().setProvince("");
					pp.getSupcto().setCity("");
					pp.getSupcto().setArea("");
				}
				if (pp.getSupcto().getDepartment()==null) {
					Department department=new Department();
					department.setName("");
					pp.getSupcto().setDepartment(department);
				}
				Double damageMoney=poto.getDamageMoney()==null?0.0:poto.getDamageMoney();
				if(damageMoney>0){
					damageMoney=-damageMoney;
				}
				System.out.println(">>>>>"+poto.getDamageMoney());
				String[] tbody= {
						pp.getSupcto().getIdentifier(),
						pp.getSupcto().getName(),
						pp.getSupcto().getProvince()+"  "+pp.getSupcto().getCity()+"  "+pp.getSupcto().getArea(),
						pp.getSupcto().getDepartment().getName(),
						nf.format(damageMoney)+"",
						nf.format(poto.getReceivingGoodsMoney())+"",
						pp.getReturnMoney()+"",
						nf.format(poto.getReceivingGoodsMoney()-pp.getReturnMoney())};
				
		        totalMoney1+=damageMoney;

		        
		        totalMoney2+=poto.getReceivingGoodsMoney();
		        
		        totalMoney3+=poto.getReceivingGoodsMoney()-pp.getReturnMoney();
				totalMoney4+=pp.getReturnMoney();
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		List<JSONObject> tt = new ArrayList<>();
		JSONObject totalJSONColumns1 = new JSONObject();
		totalJSONColumns1.put("columns", 6);
		totalJSONColumns1.put("content", nf.format(totalMoney2));
		tt.add(totalJSONColumns1);
		JSONObject totalJSONColumns2 = new JSONObject();
		totalJSONColumns2.put("columns", 5);
		totalJSONColumns2.put("content", nf.format(totalMoney1));
		tt.add(totalJSONColumns2);
		JSONObject totalJSONColumns3 = new JSONObject();
		totalJSONColumns3.put("columns", 8);
		totalJSONColumns3.put("content", nf.format(totalMoney3));
		tt.add(totalJSONColumns3);
		JSONObject totalJSONColumns4 = new JSONObject();
		totalJSONColumns4.put("columns", 7);
		totalJSONColumns4.put("content", nf.format(totalMoney4));
		tt.add(totalJSONColumns4);
		totalJSON.put("total", tt);
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 销售开单明细表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportSalesOrderOpenDetail(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		params.put("type", 2);
		List<SalesOrder>	list=salesOrderService.reportSalesOrderOpenDetail(params);
		List<SalesOrder>	list2=salesOrderService.reportSalesOrderReturnDetail(params);
		takeStockOrderJSON.put("title", "销售开单明细表-按客户");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "类型", "单据日期", "单据编号","客户名称", "货品编码", "货品名称", "规格","单位", "单价","签收数量","折损金额","签收金额","税率","税额","摘要","业务员","审核人","制单员","地区","部门","占用数量" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		for (SalesOrder  pp : list) {
			for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
				if (poto.getDamageMoney()==null) {
					poto.setDamageMoney(0.0);
				}
				
				if (pp.getSupcto().getName()==null) {
					pp.getSupcto().setIdentifier("");
					pp.getSupcto().setName("");
					pp.getSupcto().setProvince("");
					pp.getSupcto().setCity("");
					pp.getSupcto().setArea("");
				}
				if (pp.getSupcto().getCity()==null) {
					pp.getSupcto().setCity("");
				} 
				if (pp.getSupcto().getArea()==null) {
					pp.getSupcto().setArea("");
				}
				if (pp.getSupcto().getProvince()==null) {
					pp.getSupcto().setProvince("");
				}
				if (pp.getReviewerName()==null) {
					pp.setReviewerName("");
				}
				if (pp.getSupcto().getDepartment()==null) {
					Department department=new Department();
					department.setName("");
					pp.getSupcto().setDepartment(department);
				}
				Double damageMoney=poto.getDamageMoney()==null?0.0:new BigDecimal(poto.getDamageMoney()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				if(damageMoney>0){
					damageMoney=-damageMoney;
				}
				String[] tbody= {
						"销售开单",
						pp.getCreateTime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(pp.getCreateTime()),
						pp.getIdentifier(),
						pp.getSupcto().getName(),
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						
						poto.getCommoditySpecification().getBaseUnitName(),
						poto.getUnitPrice()+"",
						poto.getReceivingGoodsNum()+"",
						nf.format(damageMoney)+"",
						nf.format(poto.getReceivingGoodsMoney())+"",
						poto.getTaxes()+"",
						nf.format(poto.getTaxesMoney())+"",
						pp.getSummary(),
						pp.getPerson().getName(),
						pp.getReviewerName(),
						pp.getOriginatorName(),
						pp.getSupcto().getProvince()+"  "+pp.getSupcto().getCity()+"  "+pp.getSupcto().getArea(),
						pp.getSupcto().getDepartment().getName(),
						pp.getInventory().getOccupiedInventory()+""
						
						};
				tbodys.add(tbody);
			}
		}
		for (SalesOrder  pp : list2) {
			for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
				
					poto.setDamageMoney(0.0);
				
				
				if (pp.getSupcto().getName()==null) {
					pp.getSupcto().setIdentifier("");
					pp.getSupcto().setName("");
					pp.getSupcto().setProvince("");
					pp.getSupcto().setCity("");
					pp.getSupcto().setArea("");
				}
				if (pp.getSupcto().getCity()==null) {
					pp.getSupcto().setCity("");
				} 
				if (pp.getSupcto().getArea()==null) {
					pp.getSupcto().setArea("");
				}
				if (pp.getSupcto().getProvince()==null) {
					pp.getSupcto().setProvince("");
				}
				if (pp.getReviewerName()==null) {
					pp.setReviewerName("");
				}
				if (pp.getSupcto().getDepartment()==null) {
					Department department=new Department();
					department.setName("");
					pp.getSupcto().setDepartment(department);
				}

				String[] tbody= {
						"销售退货",
						pp.getCreateTime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(pp.getCreateTime()),
						pp.getIdentifier(),
						pp.getSupcto().getName(),
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						
						poto.getCommoditySpecification().getBaseUnitName(),
						poto.getUnitPrice()+"",
						"-"+poto.getReturnGoodsNum()+"",
						poto.getDamageMoney()+"",
						"-"+nf.format(poto.getReturnGoodsNum()*poto.getUnitPrice())+"",
						poto.getTaxes()+"",
						nf.format(poto.getTaxesMoney())+"",
						pp.getSummary(),
						pp.getPerson().getName(),
						pp.getReviewerName(),
						pp.getOriginatorName(),
						pp.getSupcto().getProvince()+"  "+pp.getSupcto().getCity()+"  "+pp.getSupcto().getArea(),
						pp.getSupcto().getDepartment().getName(),
						pp.getInventory().getOccupiedInventory()+""
						};
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "false");
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 采购订单汇总表-按供应商
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportProcureOrderGether(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		List<ProcureTable>	list=procureTableService.reportProcureOrderGether(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		takeStockOrderJSON.put("title", "采购订单汇总表-按供应商");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "供应商编码", "供应商名称", "订货金额", "已收金额","未收金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		String  supctoName="";
		String supctoIdentifier="";
		for (ProcureTable  pp : list) {
			for (ProcureCommodity poto : pp.getProcureCommoditys()) {
				if (pp.getSupcto()==null) {
					supctoIdentifier="";
					supctoName="";
				}else {
					supctoIdentifier=pp.getSupcto().getIdentifier();
					supctoName=pp.getSupcto().getName();
				}
				if (poto.getTotalTaxPrice()==null) {
					poto.setTotalTaxPrice(0.0);
				}
				if (poto.getSuspendPrice()==null) {
					poto.setSuspendPrice(0.0);
				}
				if (poto.getTotalPrice()==null) {
					poto.setTotalPrice(0.0);
				}
				if (poto.getArrivalMoney()==null) {
					poto.setArrivalMoney(0.0);
				}
				if (poto.getSuspendQuantity()==null) {
					poto.setSuspendQuantity(0);
				}
				if (poto.getSurplusMoney()==null) {
					poto.setSurplusMoney(0.0);
				}
				if (poto.getSurplusNum()==null) {
					poto.setSurplusNum(0);
				}
				String[] tbody= {
						supctoIdentifier,
						supctoName,
						nf.format(poto.getTotalTaxPrice())+"",
						nf.format(poto.getTotalPrice())+"",
						nf.format(poto.getSuspendPrice())+""};
				
				
		        totalMoney1+=poto.getTotalTaxPrice();
		        
		        totalMoney2+=poto.getTotalPrice();
		        
		        totalMoney3+=poto.getSuspendPrice();
		        
				
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		List<JSONObject> tt = new ArrayList<>();
		JSONObject totalJSONColumns1 = new JSONObject();
		totalJSONColumns1.put("columns", 3);
		totalJSONColumns1.put("content", nf.format(totalMoney1));
		tt.add(totalJSONColumns1);
		JSONObject totalJSONColumns2 = new JSONObject();
		totalJSONColumns2.put("columns", 4);
		totalJSONColumns2.put("content", nf.format(totalMoney2));
		tt.add(totalJSONColumns2);
		JSONObject totalJSONColumns3 = new JSONObject();
		totalJSONColumns3.put("columns", 5);
		totalJSONColumns3.put("content", nf.format(totalMoney3));
		tt.add(totalJSONColumns3);
		totalJSON.put("total", tt);
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 采购订单明细表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportProcureOrderDetail(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		List<ProcureTable>	list=procureTableService.reportProcureOrderDetail(params);
		takeStockOrderJSON.put("title", "采购订单明细表-按供应商");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "供应商", "单据编号", "单据日期", "到货日期","货品编码", "货品名称","规格","单位","单价","订货|金额","已收货|数量","已收货|金额","中止|数量","中止|金额","未收货|数量","未收货|金额","占用库存","备注" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		Double totalMoney4 = 0.0;
		String  supctoName="";
		String supctoIdentifier="";
		for (ProcureTable  pp : list) {
			for (ProcureCommodity poto : pp.getProcureCommoditys()) {
				if (pp.getSupcto()==null) {
					supctoIdentifier="";
					supctoName="";
				}else {
					supctoIdentifier=pp.getSupcto().getIdentifier();
					supctoName=pp.getSupcto().getName();
					System.out.println(supctoIdentifier);
					System.out.println(supctoName);
				}
				if (poto.getTotalTaxPrice()==null) {
					poto.setTotalTaxPrice(0.0);
				}
				if (poto.getSuspendPrice()==null) {
					poto.setSuspendPrice(0.0);
				}
				if (poto.getTotalPrice()==null) {
					poto.setTotalPrice(0.0);
				}
				
				String isLargess=null;
				if (poto.getIsLargess()==null||poto.getIsLargess()==1) {
					isLargess="×";
				}else if (poto.getIsLargess()==2) {
					isLargess="√";
				}
				if (poto.getArrivalMoney()==null) {
					poto.setArrivalMoney(0.0);
				}
				if (poto.getSuspendQuantity()==null) {
					poto.setSuspendQuantity(0);
				}
				if (poto.getSurplusMoney()==null) {
					poto.setSurplusMoney(0.0);
				}
				if (poto.getSurplusNum()==null) {
					poto.setSurplusNum(0);
				}
				if (pp.getGoodsArrivalTime()==null) {
					pp.setGoodsArrivalTime(null);
				}
				String[] tbody= {
						supctoName,
						pp.getIdentifier(),
						dateFormat.format(pp.getGenerateDate()),
						pp.getGoodsArrivalTime()!=null?dateFormat2.format(pp.getGoodsArrivalTime()):"",
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						
						poto.getCommoditySpecification().getBaseUnitName(),
				 
						poto.getBusinessUnitPrice()+"",
						nf.format(poto.getTotalTaxPrice())+"",
						(poto.getArrivalQuantity()==null?0:poto.getArrivalQuantity())+"",
 						nf.format(poto.getArrivalMoney())+"",
						poto.getSuspendQuantity()+"",
						nf.format(poto.getSuspendPrice())+"",
						poto.getSurplusNum()+"",
						nf.format(poto.getSurplusMoney())+"",
						pp.getInventory().getOccupiedInventory()==null?"0":pp.getInventory().getOccupiedInventory()+"",
						poto.getRemarks()==null?"":poto.getRemarks()
						};
				
//				BigDecimal bd1 = new BigDecimal(Double.toString(totalMoney1)); 
//		        BigDecimal bd2 = new BigDecimal(Double.toString(poto.getTotalPrice()));
//		        totalMoney1=totalMoney1+bd1.add(bd2).doubleValue();
		        totalMoney1+=poto.getTotalTaxPrice();
//		        BigDecimal bd3 = new BigDecimal(Double.toString(totalMoney2)); 
//		        BigDecimal bd4 = new BigDecimal(Double.toString(poto.getArrivalMoney()));
//		        totalMoney2=totalMoney2+bd3.add(bd4).doubleValue();
		        totalMoney2+=poto.getArrivalMoney();
//		        BigDecimal bd5 = new BigDecimal(Double.toString(totalMoney3)); 
//		        BigDecimal bd6 = new BigDecimal(Double.toString(poto.getSuspendPrice()));
//		        totalMoney3=totalMoney3+bd5.add(bd6).doubleValue();
		        totalMoney3+=poto.getSuspendPrice();
//		        BigDecimal bd7 = new BigDecimal(Double.toString(totalMoney4)); 
//		        BigDecimal bd8 = new BigDecimal(Double.toString(poto.getSurplusMoney()));
//		        totalMoney4=totalMoney4+bd7.add(bd8).doubleValue();
		        totalMoney4+=poto.getSurplusMoney();
				
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		List<JSONObject> tt = new ArrayList<>();
		JSONObject totalJSONColumns1 = new JSONObject();
		totalJSONColumns1.put("columns", 10);
		totalJSONColumns1.put("content", nf.format(totalMoney1));
		tt.add(totalJSONColumns1);
		JSONObject totalJSONColumns2 = new JSONObject();
		totalJSONColumns2.put("columns", 12);
		totalJSONColumns2.put("content", nf.format(totalMoney2));
		tt.add(totalJSONColumns2);
		JSONObject totalJSONColumns3 = new JSONObject();
		totalJSONColumns3.put("columns", 14);
		totalJSONColumns3.put("content", nf.format(totalMoney3));
		tt.add(totalJSONColumns3);
		JSONObject totalJSONColumns4 = new JSONObject();
		totalJSONColumns4.put("columns", 16);
		totalJSONColumns4.put("content", nf.format(totalMoney4));
		tt.add(totalJSONColumns4);
		totalJSON.put("total", tt);
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 采购计划单汇总表-按供应商
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportProcurePlanOrderGether(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		List<ProcureTable>	list=procureTableService.reportProcurePlanOrderGether(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");

		takeStockOrderJSON.put("title", "采购计划单汇总表-公司计划");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		String arriveTime="";
		/* table start */
		// thead
		String[] theads = { "供应商编码", "供应商名称", "计划单号", "计划金额","到货日期" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney1 = 0.0;
		for (ProcureTable  pp : list) {
			for (ProcureCommodity poto : pp.getProcureCommoditys()) {
				if (pp.getGoodsArrivalTime()==null) {
					arriveTime="";
					//pp.setGoodsArrivalTime(new Date());
				}else {
					arriveTime=dateFormat2.format(pp.getGoodsArrivalTime());
				}
				if (pp.getSupcto()==null) {
					Supcto supcto=new Supcto();
					supcto.setName("");
					supcto.setIdentifier("");
					pp.setSupcto(supcto);
					
				}
				if (poto.getTotalTaxPrice()==null) {
					poto.setTotalTaxPrice(0.0);
				}
				String[] tbody= {
						pp.getSupcto().getIdentifier(),
						pp.getSupcto().getName(),
						pp.getIdentifier(),
						nf.format(poto.getTotalTaxPrice())+"",
						arriveTime};
				
				

		        totalMoney1+=poto.getTotalTaxPrice();
				
				
				
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		List<JSONObject> tt = new ArrayList<>();
		JSONObject totalJSONColumns1 = new JSONObject();
		totalJSONColumns1.put("columns", 4);
		totalJSONColumns1.put("content", nf.format(totalMoney1));
		tt.add(totalJSONColumns1);
		totalJSON.put("total", tt);
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 采购计划单明细表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportProcurePlanOrderDetail(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		List<ProcureTable>	list=procureTableService.reportProcurePlanOrderDetail(params);
		takeStockOrderJSON.put("title", "采购计划单明细表-公司计划");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "供应商", "单据编号", "单据日期", "到货日期","货品编码", "货品名称","规格","单位","单价","计划数量","计划金额","占用库存","备注" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney1 = 0.0;
		for (ProcureTable  pp : list) {
			for (ProcureCommodity poto : pp.getProcureCommoditys()) {
				
				
				if (pp.getSupcto()==null) {
					Supcto supcto=new Supcto();
					supcto.setName("");
					supcto.setIdentifier("");
					pp.setSupcto(supcto);
					
				}
				if (poto.getRemarks()==null) {
					poto.setRemarks("");
				}
				String[] tbody= {
						pp.getSupcto().getName(),
						pp.getIdentifier(),
						dateFormat.format(pp.getGenerateDate()),
						pp.getGoodsArrivalTime()!=null?dateFormat2.format(pp.getGoodsArrivalTime()):"",
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						
						poto.getCommoditySpecification().getBaseUnitName(),
						poto.getBusinessUnitPrice()+"",
						poto.getOrderNum()+"",
						nf.format(poto.getTotalPrice()==null?0.0:poto.getTotalPrice())+"",
						pp.getInventory().getOccupiedInventory()+"",
						poto.getRemarks()
						};
//				BigDecimal bd1 = new BigDecimal(Double.toString(totalMoney1)); 
//		        BigDecimal bd2 = new BigDecimal(Double.toString(poto.getTotalPrice()));
//		        totalMoney1=totalMoney1+bd1.add(bd2).doubleValue();
		        totalMoney1+=poto.getTotalPrice()==null?0.0:poto.getTotalPrice();
				
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		List<JSONObject> tt = new ArrayList<>();
		JSONObject totalJSONColumns1 = new JSONObject();
		totalJSONColumns1.put("columns", 11);
		totalJSONColumns1.put("content", nf.format(totalMoney1));
		tt.add(totalJSONColumns1);
		
		totalJSON.put("total", tt);
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 采购开单汇总表/明细表-按供应商
	 * @param  type 1：汇总表 2：明细表
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportProcureFinishOrderDetailOrGether(Map<String, Object> params,String [] arr,Integer type){
		params.put("type", type);
		List<ProcureTable>	list=procureTableService.reportProcureFinishOrderDetailOrGether(params);
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		Double totalMoney4 = 0.0;
		Double totalMoney5 = 0.0;
		Double totalMoney6 = 0.0;
		if (type==1) {
			takeStockOrderJSON.put("title", "采购开单汇总表-按供应商");
			takeStockOrderJSON.put("beginDate", arr[0]);
			takeStockOrderJSON.put("endDate", arr[1]);
			/* table start */
			// thead
			String[] theads = { "供应商编码", "供应商名称", "采购货款", "进项税额","金额","采购费用","退货货款(含税)" };
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			
			for (ProcureTable  pp : list) {
				for (ProcureCommodity poto : pp.getProcureCommoditys()) {
					if (pp.getSupcto()==null) {
						Supcto supcto=new Supcto();
						supcto.setName("其他");
						supcto.setIdentifier("");
						pp.setSupcto(supcto);
						
					}
					String[] tbody= {
							pp.getSupcto().getIdentifier(),
							pp.getSupcto().getName(),
							nf.format( poto.getArrivalMoney()==null?0.0:poto.getArrivalMoney() )+"",
							nf.format( poto.getAmountOfTax()==null?0.0:poto.getAmountOfTax())+"",
							nf.format((poto.getArrivalMoney()==null?0.0:poto.getArrivalMoney())+(poto.getAmountOfTax()==null?0.0:poto.getAmountOfTax())-pp.getReturnMoney())+"",
							"0",
							pp.getReturnMoney()+""
							};
					
					
					
					totalMoney1+=poto.getArrivalMoney()==null?0.0:poto.getArrivalMoney();
			        
					totalMoney2+=poto.getAmountOfTax()==null?0.0:poto.getAmountOfTax();
			        
					totalMoney3+=(poto.getArrivalMoney()==null?0.0:poto.getArrivalMoney())+(poto.getAmountOfTax()==null?0.0:poto.getAmountOfTax())-pp.getReturnMoney();
					totalMoney4+=pp.getReturnMoney();
					
					tbodys.add(tbody);
				}
			}
			System.out.println(nf.format(totalMoney1));
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			List<JSONObject> tt = new ArrayList<>();
			JSONObject totalJSONColumns1 = new JSONObject();
			totalJSONColumns1.put("columns", 3);
			totalJSONColumns1.put("content", nf.format(totalMoney1));
			tt.add(totalJSONColumns1);
			JSONObject totalJSONColumns2 = new JSONObject();
			totalJSONColumns2.put("columns", 4);
			totalJSONColumns2.put("content", nf.format(totalMoney2));
			tt.add(totalJSONColumns2);
			JSONObject totalJSONColumns3 = new JSONObject();
			totalJSONColumns3.put("columns", 5);
			totalJSONColumns3.put("content", nf.format(totalMoney3));
			tt.add(totalJSONColumns3);
			JSONObject totalJSONColumns4 = new JSONObject();
			totalJSONColumns4.put("columns", 7);
			totalJSONColumns4.put("content", nf.format(totalMoney4));
			tt.add(totalJSONColumns4);
			totalJSON.put("total", tt);
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		}else {
			params.put("type2", 2);
			List<ProcureTable>	list2=procureTableService.reportProcureReturnOrderDetail(params);
			takeStockOrderJSON.put("title", "采购开单明细表-按供应商");
			takeStockOrderJSON.put("beginDate", arr[0]);
			takeStockOrderJSON.put("endDate", arr[1]);
			/* table start */
			// thead
			String[] theads = { "分支机构","供应商","单据类型", "单据编号", "单据日期", "货品编码", "货品名称","规格","单位","单价","数量","采购货款","进项税额","金额","备注","折扣率","占用库存","采购费用","费后单价" };
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			for (ProcureTable  pp : list) {
				for (ProcureCommodity poto : pp.getProcureCommoditys()) {
					
					if (pp.getSupcto()==null) {
						Supcto supcto=new Supcto();
						supcto.setName("");
						supcto.setIdentifier("");
						pp.setSupcto(supcto);
						
					}
					if (poto.getAmountOfTax()==null) {
						poto.setAmountOfTax(0.0);
					}
					if (poto.getTotalTaxPrice()==null) {
						poto.setTotalTaxPrice(0.0);
					}
					String[] tbody= {
							"总部",
							pp.getSupcto().getName(),
							"采购开单",
							pp.getIdentifier(),
							dateFormat.format(pp.getGenerateDate()),
							poto.getCommoditySpecification().getSpecificationIdentifier(),
							poto.getCommoditySpecification().getCommodity().getName(),
							poto.getCommoditySpecification().getSpecificationName(),
							
							poto.getCommoditySpecification().getBaseUnitName(),
							poto.getBusinessUnitPrice()+"",
							poto.getArrivalQuantity()+"",
							nf.format(poto.getArrivalMoney())+"",
							nf.format(poto.getAmountOfTax())+"",
							nf.format(poto.getArrivalMoney()+poto.getAmountOfTax())+"",
							poto.getRemarks()==null?"":poto.getRemarks(),
							poto.getDiscount()==null?"":poto.getDiscount()+"",
							pp.getInventory().getOccupiedInventory()+"",
							"0",
							poto.getOriginalUnitPrice()+""
							
							};
					
			        totalMoney1+=poto.getOrderNum();
			        
			        totalMoney2+=poto.getArrivalMoney();
			        
			        totalMoney3+=poto.getAmountOfTax();
			        
			        totalMoney4+=poto.getArrivalMoney()+poto.getAmountOfTax();
					
					tbodys.add(tbody);
				}
			}
			for (ProcureTable  pp : list2) {
				for (ProcureCommodity poto : pp.getProcureCommoditys()) {
					
					if (pp.getSupcto()==null) {
						Supcto supcto=new Supcto();
						supcto.setName("");
						supcto.setIdentifier("");
						pp.setSupcto(supcto);
						
					}
					if (poto.getAmountOfTax()==null) {
						poto.setAmountOfTax(0.0);
					}
					if (poto.getTotalTaxPrice()==null) {
						poto.setTotalTaxPrice(0.0);
					}
					String[] tbody= {
							"总部",
							pp.getSupcto().getName(),
							"采购退货",
							pp.getIdentifier(),
							dateFormat.format(pp.getGenerateDate()),
							poto.getCommoditySpecification().getSpecificationIdentifier(),
							poto.getCommoditySpecification().getCommodity().getName(),
							poto.getCommoditySpecification().getSpecificationName(),
							
							poto.getCommoditySpecification().getBaseUnitName(),
							poto.getBusinessUnitPrice()+"",
							"-"+poto.getArrivalQuantity()+"",
							"-"+nf.format(poto.getArrivalQuantity()*poto.getBusinessUnitPrice())+"",
							nf.format(poto.getArrivalQuantity()*poto.getBusinessUnitPrice()*poto.getTaxRate())+"",
							"-"+nf.format(poto.getArrivalQuantity()*poto.getBusinessUnitPrice())+"",
							poto.getRemarks()==null?"":poto.getRemarks(),
							poto.getDiscount()==null?"":poto.getDiscount()+"",
							pp.getInventory().getOccupiedInventory()+"",
							"0",
							poto.getBusinessUnitPrice()+""
							
							};
					
			        totalMoney1-=poto.getArrivalQuantity();
			        
			        totalMoney2-=poto.getArrivalQuantity()*poto.getBusinessUnitPrice();
			        
			        totalMoney3-=poto.getArrivalQuantity()*poto.getBusinessUnitPrice()*poto.getTaxRate();
			        
			        totalMoney4-=poto.getArrivalQuantity()*poto.getBusinessUnitPrice();
					
					tbodys.add(tbody);
				}
			}
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			List<JSONObject> tt = new ArrayList<>();
			JSONObject totalJSONColumns1 = new JSONObject();
			totalJSONColumns1.put("columns", 11);
			totalJSONColumns1.put("content", nf.format(totalMoney1));
			tt.add(totalJSONColumns1);
			JSONObject totalJSONColumns2 = new JSONObject();
			totalJSONColumns2.put("columns", 12);
			totalJSONColumns2.put("content", nf.format(totalMoney2));
			tt.add(totalJSONColumns2);
			JSONObject totalJSONColumns3 = new JSONObject();
			totalJSONColumns3.put("columns", 13);
			totalJSONColumns3.put("content", nf.format(totalMoney3));
			tt.add(totalJSONColumns3);
			JSONObject totalJSONColumns4 = new JSONObject();
			totalJSONColumns4.put("columns", 14);
			totalJSONColumns4.put("content", nf.format(totalMoney4));
			tt.add(totalJSONColumns4);
			totalJSON.put("total", tt);
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		}
		
		
		
		return takeStockOrderJSON;
	}
	/**
	 * 货品销售日报表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportSalesDayDetais(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		List<SalesOrder>	list=salesOrderService.reportSalesDayDetais(params);
		takeStockOrderJSON.put("title", "货品销售日报表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "货品编码","货品名称", "规格","品牌","单位","合计|数量","合计|金额","占用库存" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Integer totalNum=0;
		Double money=0.0;
		for (SalesOrder  pp : list) {
			for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
				System.out.println(">>>>>>>>>>>>>>>>>>");
				
				
					totalNum=poto.getReceivingGoodsNum();
					money=poto.getReceivingGoodsMoney();
					
				
				
				String[] tbody= {
						
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName(),
						poto.getCommoditySpecification().getSpecificationName(),
						poto.getCommoditySpecification().getCommodity().getBrand(),
						poto.getCommoditySpecification().getBaseUnitName(),
						totalNum+"",
						nf.format(money)+"",
						pp.getInventory().getOccupiedInventory()+""
						};
				
				

		        
		        
		        
				totalMoney1+=totalNum;
				totalMoney2+=money;
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		List<JSONObject> tt = new ArrayList<>();
		JSONObject totalJSONColumns1 = new JSONObject();
		totalJSONColumns1.put("columns", 6);
		totalJSONColumns1.put("content", totalMoney1);
		tt.add(totalJSONColumns1);
		JSONObject totalJSONColumns2 = new JSONObject();
		totalJSONColumns2.put("columns", 7);
		totalJSONColumns2.put("content", nf.format(totalMoney2));
		tt.add(totalJSONColumns2);
		totalJSON.put("total", tt);
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 入库单汇总表/明细表-按供应商
	 * @param  type 1：汇总表 2：明细表
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportImportOrderDetailOrGether(Map<String, Object> params,String [] arr,Integer type){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		params.put("type", type);
		List<ProcureTable>	list=procureTableService.reportImportOrderDetailOrGether(params);
		List<SalesOrder>    list2=salesOrderService.reportReturnGoodsMsg(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double returnMoney = 0.0;
		Integer returnNum = 0;
		String orderName="";
		if (type==1) {
			takeStockOrderJSON.put("title", "入库单汇总表");
			takeStockOrderJSON.put("beginDate", arr[0]);
			takeStockOrderJSON.put("endDate", arr[1]);
			/* table start */
			// thead
			String[] theads = { "货品编号", "货品名称", "规格", "品牌","单位","仓库","数量","金额","占用库存" };
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			
			for (ProcureTable  pp : list) {
				for (ProcureCommodity poto : pp.getProcureCommoditys()) {
					if (poto.getTotalTaxPrice()==null) {
						poto.setTotalTaxPrice(0.0);
					}
					boolean isHas=false;
					Integer num=0;
					Double money=0.0;
					for(int j=0;j<list2.size();j++) {
						SalesOrder so=list2.get(j);
						for (int i = 0; i < so.getSalesOrderCommodities().size(); i++) {
							SalesOrderCommodity soc=so.getSalesOrderCommodities().get(i);
							if (poto.getCommoditySpecification().getId().equals(soc.getCommoditySpecification().getId())) {
								isHas=true;
								num=soc.getReturnGoodsNum()+poto.getOrderNum();
								money=(poto.getTotalTaxPrice()==null?0.0:poto.getTotalTaxPrice())+(soc.getDeliverGoodsMoney()==null?0.0:soc.getDeliverGoodsMoney());
								so.getSalesOrderCommodities().remove(i);
								break;
							}
						}
						if (isHas) {
							if (list2.get(j).getSalesOrderCommodities().size()<=0) {
								list2.remove(j);
							}
							break;
						}
					}
					if (!isHas) {
						num=poto.getOrderNum();
						money=poto.getTotalTaxPrice()==null?0.0:poto.getTotalTaxPrice();
					}
					
					String[] tbody= {
							poto.getCommoditySpecification().getSpecificationIdentifier(),
							poto.getCommoditySpecification().getCommodity().getName(),
							poto.getCommoditySpecification().getSpecificationName(),
							poto.getCommoditySpecification().getCommodity().getBrand(),
							poto.getCommoditySpecification().getBaseUnitName(),
							poto.getCommoditySpecification().getSpecWarehouseName()==null?"":poto.getCommoditySpecification().getSpecWarehouseName(),
							num==null?"0":num+"",
							nf.format(money)+"",
							pp.getInventory().getOccupiedInventory()+""};
					
			        totalMoney1+=money;
					tbodys.add(tbody);
				}
			}
			if (list2.size()>0) {
				for (SalesOrder so : list2) {
					for (SalesOrderCommodity soc : so.getSalesOrderCommodities()) {
						String num=soc.getReturnGoodsNum()+"";
						Double money=soc.getDeliverGoodsMoney()==null?0.0:soc.getDeliverGoodsMoney();
						String[] tbody= {
								soc.getCommoditySpecification().getSpecificationIdentifier(),
								soc.getCommoditySpecification().getCommodity().getName(),
								soc.getCommoditySpecification().getSpecificationName(),
								soc.getCommoditySpecification().getCommodity().getBrand(),
								soc.getCommoditySpecification().getBaseUnitName(),
								soc.getWarehouse().getName()==null?"":soc.getWarehouse().getName(),
								num==null?"0":num+"",
								nf.format(money)+"",
								so.getInventory().getOccupiedInventory()+""};
						
				        totalMoney1+=money;
						tbodys.add(tbody);
					}
				}
			}
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			List<JSONObject> tt = new ArrayList<>();	
			JSONObject totalJSONColumns1 = new JSONObject();
			totalJSONColumns1.put("columns", 8);
			totalJSONColumns1.put("content", nf.format(totalMoney1));
			tt.add(totalJSONColumns1);
			
			totalJSON.put("total", tt);
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		}else {
			takeStockOrderJSON.put("title", "入库单明细表");
			takeStockOrderJSON.put("beginDate", arr[0]);
			takeStockOrderJSON.put("endDate", arr[1]);
			/* table start */
			// thead
			String[] theads = {  "单据编号","单据名称","货品编码", "货品名称","品牌","开单日期","单位","数量","单价","金额","备注","批号","占用库存" };
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			for (ProcureTable  pp : list) {
				for (ProcureCommodity poto : pp.getProcureCommoditys()) {
					
					if (poto.getTotalTaxPrice()==null) {
						poto.setTotalTaxPrice(0.0);
					}
					if (poto.getRemarks()==null) {
						poto.setRemarks("");
					}
					if (poto.getLotNumber()==null) {
						poto.setLotNumber("");
					}
					if (poto.getOrderNum()==null) {
						poto.setOrderNum(0);
					}
					String[] tbody= {
							pp.getIdentifier(),
							"入库单",
							poto.getCommoditySpecification().getSpecificationIdentifier(),
							poto.getCommoditySpecification().getCommodity().getName(),
							poto.getCommoditySpecification().getCommodity().getBrand(),
							dateFormat.format(pp.getGenerateDate()),
							poto.getCommoditySpecification().getBaseUnitName(),
							poto.getOrderNum()+"",
							poto.getBusinessUnitPrice()+"",
							nf.format(poto.getTotalTaxPrice())+"",
							poto.getRemarks(),
							poto.getLotNumber(),
							pp.getInventory().getOccupiedInventory()+"",
							};
					
					tbodys.add(tbody);
				}
			}
			for (SalesOrder so : list2) {
				for (SalesOrderCommodity soc : so.getSalesOrderCommodities()) {
					//System.out.println(poto.getCommoditySpecification().getId()+">>>>>>>"+soc.getCommoditySpecification().getId());
					if (soc.getRemark()==null) {
						soc.setRemark("");
					}
					if (soc.getBatchNumber()==null) {
						soc.setBatchNumber("");
					}
					if (soc.getReturnGoodsNum()==null) {
						soc.setReturnGoodsNum(0);
					}
					String[] tbody= {
							so.getIdentifier(),
							"销售退货",
							soc.getCommoditySpecification().getSpecificationIdentifier(),
							soc.getCommoditySpecification().getCommodity().getName(),
							soc.getCommoditySpecification().getCommodity().getBrand(),
							dateFormat.format(so.getCreateTime()),
							soc.getCommoditySpecification().getBaseUnitName(),
							soc.getReturnGoodsNum()+"",
							soc.getUnitPrice()+"",
							nf.format(soc.getDeliverGoodsMoney())+"",
							soc.getRemark(),
							soc.getBatchNumber(),
							so.getInventory().getOccupiedInventory()+""
							};
					
					tbodys.add(tbody);
				}
			}
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "false");
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		}
		
		
		
		return takeStockOrderJSON;
	}
	/**
	 * 销售毛利汇总表-按客户
	 * @param  type 1：汇总表 2：明细表
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportProfitGether(Map<String, Object> params,String [] arr){
	
		List<SalesOrder>	list=salesOrderService.reportProfitGether(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
	
		Double totalMoney1 = 0.0;//销售收入
		Double totalMoney2 = 0.0;//销售成本
		Double totalMoney3 = 0.0;//销售毛利
		Double totalMoney4 = 0.0;//销售毛利率
		takeStockOrderJSON.put("title", "销售毛利汇总表-按客户");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
			/* table start */
			// thead
			String[] theads = { "客户编号","客户名称","销售收入", "销售成本", "销售毛利", "销售毛利率"/*, "地区","部门"*/};
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			for (SalesOrder  pp : list) {
				for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
					//销售成本
					if (poto.getDamageMoney()==null) {
						poto.setDamageMoney(0.0);
					}
					if (pp.getSupcto().getCity()==null) {
						pp.getSupcto().setCity("");
					}else if (pp.getSupcto().getArea()==null) {
						pp.getSupcto().setArea("");
					}
					if (poto.getReceivingGoodsMoney()==null) {
						poto.setReceivingGoodsMoney(0.0);
					}
					if (pp.getSupcto().getDepartment()==null) {
						Department department=new Department();
						department.setName("");
						pp.getSupcto().setDepartment(department);
					}
					if (pp.getSupcto().getName()==null) {
						pp.getSupcto().setName("");
						pp.getSupcto().setIdentifier("");
						pp.getSupcto().setProvince("");
						pp.getSupcto().setCity("");
						pp.getSupcto().setArea("");
					}
					//销售成本
					Double vDouble=poto.getDeliverGoodsMoney()-pp.getReturnMoney();
					
					//销售毛利率
					Double vDouble2=((poto.getReceivingGoodsMoney()-vDouble-pp.getReturnMoney())/(poto.getReceivingGoodsMoney()-pp.getReturnMoney())*100);
					String[] tbody= {
							pp.getSupcto().getIdentifier(),
							pp.getSupcto().getName(),
							nf.format(poto.getReceivingGoodsMoney()-pp.getReturnMoney())+"",
							nf.format(vDouble)+"",
							nf.format(poto.getReceivingGoodsMoney()-vDouble-pp.getReturnMoney())+"",
							nf.format(vDouble2)+"%"/*,
							pp.getSupcto().getProvince()+"-"+pp.getSupcto().getCity()+"-"+pp.getSupcto().getArea(),
							pp.getSupcto().getDepartment().getName()*/
							};
					
					
			        totalMoney1+=poto.getReceivingGoodsMoney();
			        
			        totalMoney2+=vDouble;
			        
			        totalMoney3+=poto.getReceivingGoodsMoney()-vDouble;
			        
			        totalMoney4+=vDouble2;
					
					tbodys.add(tbody);
				}
			}
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			List<JSONObject> tt = new ArrayList<>();
			JSONObject totalJSONColumns1 = new JSONObject();
			totalJSONColumns1.put("columns", 3);
			totalJSONColumns1.put("content", nf.format(totalMoney1));
			tt.add(totalJSONColumns1);
			JSONObject totalJSONColumns2 = new JSONObject();
			totalJSONColumns2.put("columns", 4);
			totalJSONColumns2.put("content", nf.format(totalMoney2));
			tt.add(totalJSONColumns2);
			JSONObject totalJSONColumns3 = new JSONObject();
			totalJSONColumns3.put("columns", 5);
			totalJSONColumns3.put("content", nf.format(totalMoney3));
			tt.add(totalJSONColumns3);
			JSONObject totalJSONColumns4 = new JSONObject();
			totalJSONColumns4.put("columns", 6);
			totalJSONColumns4.put("content", nf.format(totalMoney4)+"%");
			tt.add(totalJSONColumns4);
			totalJSON.put("total", tt);
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		
		
		
		
		return takeStockOrderJSON;
	}
	/**
	 * 销售毛利明细表
	 * @param  
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportProfitDetail(Map<String, Object> params,String [] arr){
	
		List<SalesOrder>	list=salesOrderService.reportProfitDetail(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		
		
		takeStockOrderJSON.put("title", "销售毛利明细表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		Double returnMoney=null;
			/* table start */
			// thead
			String[] theads = { "分支机构","单据编号","单据日期","货品名称","规格","单位","客户编号","客户名称","销售单价","成本单价","销售数量","销售收入", "销售成本", "销售毛利", "销售毛利率","备注","业务员", "地区","部门","退货数量","退货金额"};
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			for (SalesOrder  pp : list) {
				for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
					//销售成本
					Double vDouble=(poto.getReceivingGoodsNum()-poto.getReturnGoodsNum())*poto.getCommoditySpecification().getUnits().get(0).getMiniPrice();
					//退货金额
					returnMoney=poto.getReturnGoodsNum()*poto.getUnitPrice();
					//销售毛利率
					Double vDouble2=(((poto.getReceivingGoodsMoney()-vDouble-returnMoney)/(poto.getReceivingGoodsMoney()-returnMoney))*100);
					
					if (poto.getRemark()==null) {
						poto.setRemark("");
					}
					if (pp.getPerson()==null) {
						Person person=new Person();
							person.setName("");
						pp.setPerson(person);
					}
					if (pp.getSupcto().getDepartment()==null) {
						Department department=new Department();
						department.setName("");
						pp.getSupcto().setDepartment(department);
					}
					if (pp.getSupcto().getName()==null) {
						pp.getSupcto().setName("");
						pp.getSupcto().setIdentifier("");
						pp.getSupcto().setProvince("");
						pp.getSupcto().setCity("");
						pp.getSupcto().setArea("");
					}
					String[] tbody= {
							"总部",
							pp.getIdentifier(),
							dateFormat.format(pp.getCreateTime()),
							poto.getCommoditySpecification().getCommodity().getName(),
							poto.getCommoditySpecification().getSpecificationName(),
							poto.getCommoditySpecification().getBaseUnitName(),
							pp.getSupcto().getIdentifier(),
							pp.getSupcto().getName(),
							nf.format(poto.getOldUnitPrice())+"",
							poto.getCommoditySpecification().getUnits().get(0).getMiniPrice()+"",
							poto.getReceivingGoodsNum()-poto.getReturnGoodsNum()+"",
							nf.format(poto.getReceivingGoodsMoney()-returnMoney)+"",
							nf.format(vDouble)+"",
							nf.format(poto.getReceivingGoodsMoney()-vDouble)+"",
							nf.format(vDouble2)+"%",
							poto.getRemark(),
							pp.getPerson().getName(),
							pp.getSupcto().getProvince()+" "+pp.getSupcto().getCity()+" "+pp.getSupcto().getArea(),
							pp.getSupcto().getDepartment().getName(),
							poto.getReturnGoodsNum()+"",
							returnMoney+""
						
							};
					
					tbodys.add(tbody);
				}
			}
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "false");
			
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		
		
		
		
		return takeStockOrderJSON;
	}
	/**
	 * 销售开单收款情况一览表
	 * @param  
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportSalesOpenReceiveMoney(Map<String, Object> params,String [] arr){
	params.put("type", 1);
		List<SalesOrder>	list=salesOrderService.reportSalesOpenReceiveMoney(params);
		List<SalesOrder>	list2=salesOrderService.reportSalesOrderReturnDetail(params);
		//List<WriteOffSub>  list2=writeOffSubService.reportSalesOpenReceiveMoney(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		
		String type;
		takeStockOrderJSON.put("title", "销售开单收款情况一览表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
			/* table start */
			// thead
			String[] theads = { "单据类型","单据编号","单位名称","单据日期","销售金额","已结算金额","未结算金额","制单人","审核人","业务员","部门","摘要"};
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			if (list.size()!=0) {
				
				for (SalesOrder sales : list) {
					
					for (SalesOrderCommodity poto : sales.getSalesOrderCommodities()) {
						if (sales.getSupcto()==null) {
							Supcto supcto=new Supcto();
							supcto.setName("");
							sales.setSupcto(supcto);
						}
						if (sales.getSupcto().getName()==null) {
							sales.getSupcto().setName("");
						}
						if (poto.getRemark()==null) {
							poto.setRemark("");
						}
						if (sales.getOrderType()==2) {
							type="销售开单";
						}else {
							type="销售退货";
						}
						if (sales.getSupcto().getDepartment()==null) {
							Department department=new Department();
							department.setName("");
							sales.getSupcto().setDepartment(department);
						}
						
						
						String[] tbody= {
								type,
								sales.getIdentifier(),
								sales.getSupcto().getName(),
								dateFormat.format(sales.getCreateTime()),
								nf.format(poto.getDeliverGoodsMoney()+poto.getTaxesMoney()),
								nf.format(sales.getReturnMoney()),
								nf.format((poto.getDeliverGoodsMoney()+poto.getTaxesMoney())-(sales.getReturnMoney())),
								sales.getOriginatorName(),
								sales.getReviewerName(),
								sales.getPerson().getName(),
								sales.getSupcto().getDepartment().getName(),
								sales.getSummary()
								};
						
						tbodys.add(tbody);
						
					}
					
//					
				}
			}
			if (list2.size()!=0) {
				
				for (SalesOrder sales : list2) {
					
					for (SalesOrderCommodity poto : sales.getSalesOrderCommodities()) {
						if (sales.getSupcto()==null) {
							Supcto supcto=new Supcto();
							supcto.setName("");
							sales.setSupcto(supcto);
						}
						if (sales.getSupcto().getName()==null) {
							sales.getSupcto().setName("");
						}
						if (poto.getRemark()==null) {
							poto.setRemark("");
						}
						
						if (sales.getSupcto().getDepartment()==null) {
							Department department=new Department();
							department.setName("");
							sales.getSupcto().setDepartment(department);
						}
						
						
						String[] tbody= {
								"销售退货",
								sales.getIdentifier(),
								sales.getSupcto().getName(),
								dateFormat.format(sales.getCreateTime()),
								"-"+nf.format(sales.getReturnMoney()),
								nf.format(poto.getReceivingGoodsMoney()),
								nf.format(sales.getReturnMoney()-poto.getReceivingGoodsMoney()),
								sales.getOriginatorName(),
								sales.getReviewerName(),
								sales.getPerson().getName(),
								sales.getSupcto().getDepartment().getName(),
								sales.getSummary()
								};
						
						tbodys.add(tbody);
						
					}
					
//					
				}
			}
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "false");
			
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		return takeStockOrderJSON;
	}
	/**
	 * 采购开单付款情况一览表
	 * @param  
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportProcureFinishOrderPayMoneyDetail(HttpServletRequest request,Map<String, Object> params,String [] arr){
	params.put("type2", 1);
		List<ProcureTable>	list=procureTableService.reportProcureFinishOrderPayMoneyDetail(params);
		List<ProcureTable>	list2=procureTableService.reportProcureReturnOrderDetail(params);
		
		//List<WriteOffSub>  list2=writeOffSubService.reportSalesOpenReceiveMoney(params);
		params.put("billsType", 2);
		//List<BillsSub> list3=billsSubService.reportActualMoneyMsg(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		//已结算金额
		Double money1=0.0;
		String type;
		takeStockOrderJSON.put("title", "采购开单付款情况一览表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
			/* table start */
			// thead
			String[] theads = { "单据类型","单据编号","供应商名称","单据日期","采购金额","已结算金额","未结算金额","联系人","联系电话","部门","分支机构","结算方式","运输方式","整单折扣(%)","送货地址","传真","制单人","审核人","摘要"};
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			//if (list2.size()!=0) {
				for (ProcureTable sales : list) {
					for (ProcureCommodity poto : sales.getProcureCommoditys()) {
						if (sales.getOriginator()==null) {
							sales.setOriginator("");
						}
						
						if (sales.getOrderType()==1) {
							type="采购收货";
						}else {
							type="采购退货";
						}
						if (sales.getDepartmentName()==null) {
							sales.setDepartmentName("");
						}
						if (sales.getSupcto()==null) {
							Supcto supcto=new Supcto();
							supcto.setName("");
							sales.setSupcto(supcto);
						}
						if (sales.getOrderer()==null) {
							sales.setOrderer("");
						}
						if (sales.getPhone()==null) {
							sales.setPhone("");
						}
						if (sales.getSettlementType()==null) {
							SettlementType settlementType=new SettlementType();
							settlementType.setName("");
							sales.setSettlementType(settlementType);
						}
						if (sales.getShippingMode()==null) {
							ShippingMode shippingMode=new ShippingMode();
							shippingMode.setName("");
							sales.setShippingMode(shippingMode);
						}
						if (sales.getGoodsArrivalPlace()==null) {
							sales.setGoodsArrivalPlace("");
						}
						if (sales.getFax()==null) {
							sales.setFax("");
						}
						if (sales.getOriginator()==null) {
							sales.setOriginator("");
						}
						if (sales.getTotalTaxPrices()==null) {
							sales.setTotalTaxPrices("");
						}
						if (poto.getDiscount()==null) {
							poto.setDiscount(0);
						}
						if (sales.getDepartment()==null) {
							Department department=new Department();
							department.setName("");
							sales.setDepartment(department);
						}
						
						String[] tbody= {
								type,
								sales.getIdentifier(),
								sales.getSupcto().getName(),
								dateFormat.format(sales.getGenerateDate()),
								nf.format(poto.getTotalTaxPrice())+"",
								
								
								nf.format(sales.getReturnMoney())+"",
								nf.format(poto.getTotalTaxPrice()-sales.getReturnMoney())+"",
								sales.getOrderer(),
								sales.getPhone(),
								
								sales.getDepartment().getName(),
								
								"总部",
								sales.getSettlementType().getName(),
								
								sales.getShippingMode().getName(),
								poto.getDiscount()+"",
								sales.getGoodsArrivalPlace(),
								sales.getFax(),
								sales.getOriginator(),
								sales.getReviewer(),
								sales.getSummary()
								};
						
						tbodys.add(tbody);
					}
					
					
				}

				for (ProcureTable sales : list2) {
					for (ProcureCommodity poto : sales.getProcureCommoditys()) {
						
						
						String[] tbody= {
								"采购退货",
								sales.getIdentifier(),
								sales.getSupcto().getName(),
								dateFormat.format(sales.getGenerateDate()),
								nf.format(-poto.getArrivalMoney())+"",
								
								
								nf.format(sales.getReturnMoney())+"",
								nf.format(poto.getArrivalMoney()-sales.getReturnMoney())+"",
								sales.getOrderer(),
								sales.getPhone(),
								
								sales.getDepartment().getName(),
								
								"总部",
								sales.getSettlementType().getName(),
								
								sales.getShippingMode().getName(),
								poto.getDiscount()+"",
								sales.getGoodsArrivalPlace(),
								sales.getFax(),
								sales.getOriginator(),
								sales.getReviewer(),
								poto.getRemarks()
								};
						
						tbodys.add(tbody);
					}
					
					
				}
			
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "false");
			
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		
		
		
		
		return takeStockOrderJSON;
	}
 /**
  * 应收应付账款汇总表
  * @param params
  * @param arr
  * @param orderType 1应收,2应付
  * @return
  */
	@ResponseBody
	public JSONObject reportPayMoneyGether(Map<String, Object> params,String [] arr,Integer orderType){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		List<Bills> resultMap=null;
		String[] theads=null;
		if(orderType==1) {
			
			resultMap=billsService.reportPayOrderSales(params);
		}else {
			resultMap=billsService.reportPayOrderProcure(params);
		}

		JSONObject  takeStockOrderJSON= new JSONObject();

		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		if (orderType==1) {
			 theads =new String []{ "客户编号","客户名称", "本期增加应收款", "本期收款金额", "其中现金折扣"};
			takeStockOrderJSON.put("title", "应收账款汇总表");
		}else {
			 theads =new String []{ "供应商编号","供应商名称", "本期增加应付款", "本期付款金额", "其中现金折扣"};
			takeStockOrderJSON.put("title", "应付账款汇总表");
		}
		
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
 
		
 		 
			List<String[]> tbodys = new ArrayList<>();
		if (orderType==1) {
			if (resultMap.size()>0) {
				for (Bills b : resultMap) {
					for (BillsSub bs : b.getBillsSubs()) {
						if (b.getReceiveMoney()==null) {
							b.setReceiveMoney(0.0);
						}
						if (b.getReturnMoney()==null) {
							b.setReturnMoney(0.0);
						}
						if (b.getSupcto()==null) {
							Supcto supcto=new Supcto();
							supcto.setIdentifier("");
							supcto.setName("");
						}
						if (bs.getTheMoeny()==null) {
							bs.setTheMoeny(0.0);
						}
						if (bs.getRebateMoney()==null) {
							bs.setRebateMoney(0.0);
						}
						String[] tbody= {
								b.getSupcto().getIdentifier()==null?"":b.getSupcto().getIdentifier(),
								b.getSupcto().getName()==null?"":b.getSupcto().getName(),
								b.getReceiveMoney()+b.getReturnMoney()+"",
								bs.getTheMoeny()+"",
								bs.getRebateMoney()+""
								};
						totalMoney1+=b.getReceiveMoney()+b.getReturnMoney();
						totalMoney2+=bs.getTheMoeny();
						totalMoney3+=bs.getRebateMoney();
						tbodys.add(tbody);
					}
				}
			}
		}else {
			if (resultMap.size()>0) {
				for (Bills b : resultMap) {
					for (BillsSub bs : b.getBillsSubs()) {
						if (b.getReceiveMoney()==null) {
							b.setReceiveMoney(0.0);
						}
						if (b.getReturnMoney()==null) {
							b.setReturnMoney(0.0);
						}
						if (b.getSupcto()==null) {
							Supcto supcto=new Supcto();
							supcto.setIdentifier("");
							supcto.setName("");
						}
						if (bs.getTheMoeny()==null) {
							bs.setTheMoeny(0.0);
						}
						if (bs.getRebateMoney()==null) {
							bs.setRebateMoney(0.0);
						}
						String[] tbody= {
								b.getSupcto().getIdentifier()==null?"":b.getSupcto().getIdentifier(),
								b.getSupcto().getName()==null?"":b.getSupcto().getName(),
								b.getReceiveMoney()+b.getReturnMoney()+"",
								bs.getTheMoeny()+"",
								bs.getRebateMoney()+""
								};
						totalMoney1+=b.getReceiveMoney()+b.getReturnMoney();
						totalMoney2+=bs.getTheMoeny();
						totalMoney3+=bs.getRebateMoney();
						tbodys.add(tbody);
					}
				}
			}
		}
			
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			List<JSONObject> tt = new ArrayList<>();
			JSONObject totalJSONColumns1 = new JSONObject();
			totalJSONColumns1.put("columns", 3);
			totalJSONColumns1.put("content", nf.format(totalMoney1));
			tt.add(totalJSONColumns1);
			JSONObject totalJSONColumns2 = new JSONObject();
			totalJSONColumns2.put("columns", 4);
			totalJSONColumns2.put("content", nf.format(totalMoney2));
			tt.add(totalJSONColumns2);
			JSONObject totalJSONColumns3 = new JSONObject();
			totalJSONColumns3.put("columns", 5);
			totalJSONColumns3.put("content", nf.format(totalMoney3));
			tt.add(totalJSONColumns3);
 
			totalJSON.put("total", tt);
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
	 
			
 
 
		
		return takeStockOrderJSON;
	}
//	/**
//	 * 应收账款汇总表
//	 * @param  
//	 * @return 
//	 */
//	@ResponseBody
//	public JSONObject reportGetMoneyGether(Map<String, Object> params,String [] arr){
//		NumberFormat nf = NumberFormat.getNumberInstance();
//		nf.setRoundingMode(RoundingMode.UP);
//		//保留两位小数
//		nf.setMaximumFractionDigits(2);
//		List<SalesOrder>	list=salesOrderService.reportGetMoneyGetherOne(params);
//		List<SalesOrder>	list2=salesOrderService.reportGetMoneyGetherTwo(params);
//		List<SalesOrder>	list3=salesOrderService.reportGetMoneyGetherThree(params);
//		JSONObject  takeStockOrderJSON= new JSONObject();
////		NumberFormat nf = NumberFormat.getNumberInstance();
////		nf.setRoundingMode(RoundingMode.UP);
////		//保留两位小数
////		nf.setMaximumFractionDigits(2); 
//		
//		Double totalMoney1 = 0.0;
//		Double totalMoney2 = 0.0;
//		Double totalMoney3 = 0.0;
//		Double totalMoney4 = 0.0;
//		Double totalMoney5 = 0.0;
//		Double returnOrderMoney=0.0;
//		Double noPayMoney=0.0;
//		Double discountMoney=0.0;
//		takeStockOrderJSON.put("title", "应收账款汇总表");
//		takeStockOrderJSON.put("beginDate", arr[0]);
//		takeStockOrderJSON.put("endDate", arr[1]);
//			/* table start */
//			// thead
//			String[] theads = { "客户编号","客户名称","初期应收款", "本期增加应收款", "本期收款", "其中现金折扣", "期末结存应收款"};
//			// tbody start
//			List<String[]> tbodys = new ArrayList<>();
//			if (list2.size()==0&&list3.size()!=0) {
//				for (SalesOrder  pp : list) {
//					for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()){
//						for (SalesOrder payMoney : list3) {
//							if (pp.getSupcto().getId()==payMoney.getSupcto().getId()) {
//								noPayMoney=payMoney.getAdvanceScale()-pp.getAdvanceScale();
//							}
//						}
//						if (poto.getReceivingGoodsMoney()==null) {
//							poto.setReceivingGoodsMoney(0.0);
//						}
//						if (pp.getAdvanceScale()==null) {
//							pp.setAdvanceScale(0.0);
//						}
//						String[] tbody={
//								pp.getSupcto().getIdentifier(),
//								pp.getSupcto().getName(),
//								df1.format(noPayMoney)+"",
//								df1.format(poto.getReceivingGoodsMoney()-returnOrderMoney)+"",
//								df1.format(pp.getAdvanceScale())+"",
//								df1.format(discountMoney)+"",
//								df1.format(poto.getReceivingGoodsMoney()-pp.getAdvanceScale())+""
//							};
//						
//						
//				        totalMoney1+=noPayMoney;
//				        
//				        totalMoney2+=poto.getReceivingGoodsMoney()-returnOrderMoney;
//				        
//				        totalMoney3+=pp.getAdvanceScale();
//				        
//				        totalMoney4+=discountMoney;	
//				        
//				        totalMoney5+=poto.getReceivingGoodsMoney()-pp.getAdvanceScale();
//							
//							tbodys.add(tbody);
//					}
//				}
//			}
//			if (list3.size()==0&&list2.size()!=0) {
//				for (SalesOrder  pp : list) {
//					for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()){
//						for (SalesOrder returnMoney : list2) {
//							if (pp.getSupcto().getId()==returnMoney.getSupcto().getId()) {
//								if (returnMoney.getAdvanceScale()==null) {
//									returnMoney.setAdvanceScale(0.0);
//								}
//								returnOrderMoney=returnMoney.getAdvanceScale();
//							}
//						}
//						if (poto.getReceivingGoodsMoney()==null) {
//							poto.setReceivingGoodsMoney(0.0);
//						}
//						if (pp.getAdvanceScale()==null) {
//							pp.setAdvanceScale(0.0);
//						}
//						System.out.println(pp.getSupcto());
//						String[] tbody={
//								pp.getSupcto().getIdentifier(),
//								pp.getSupcto().getName(),
//								df1.format(noPayMoney)+"",
//								df1.format(poto.getReceivingGoodsMoney()-returnOrderMoney)+"",
//								df1.format(pp.getAdvanceScale())+"",
//								df1.format(discountMoney)+"",
//								df1.format(poto.getReceivingGoodsMoney()-pp.getAdvanceScale())+""
//							};
//						totalMoney1+=noPayMoney;
//				        
//				        totalMoney2+=poto.getReceivingGoodsMoney()-returnOrderMoney;
//				        
//				        totalMoney3+=pp.getAdvanceScale();
//				        
//				        totalMoney4+=discountMoney;	
//				        
//				        totalMoney5+=poto.getReceivingGoodsMoney()-pp.getAdvanceScale();
//							tbodys.add(tbody);
//					}
//				}
//			}
//			if (list3.size()!=0&&list2.size()!=0) {
//				for (SalesOrder  pp : list) {
//					for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
//						//System.out.println(">>>>>>>>>"+pp.getPrepaidAmount());
////						if (pp.getPrepaidAmount()==null) {
////							pp.setPrepaidAmount(0.0);
////						}
//						for (SalesOrder returnMoney : list2) {
//							
//							if (returnMoney.getAdvanceScale()==null) {
//								returnMoney.setAdvanceScale(0.0);
//							}
//							for (SalesOrder payMoney : list3) {
//								
////								if (payMoney.getPrepaidAmount()==null) {
////									payMoney.setPrepaidAmount(0.0);
////								}
//								System.out.println("3"+pp.getSupcto().getId());
//								System.out.println("4"+returnMoney.getSupcto().getId());
//								System.out.println(pp.getSupcto().getId()==returnMoney.getSupcto().getId());
//								if (pp.getSupcto().getId()==returnMoney.getSupcto().getId()) {
//									
//									returnOrderMoney=returnMoney.getAdvanceScale();
//									System.out.println(">>>>>>"+returnMoney.getAdvanceScale());
//									System.out.println("returnOrder>>"+returnOrderMoney);
//									if (returnMoney.getSupcto().getId()==payMoney.getSupcto().getId()) {
//										noPayMoney=payMoney.getAdvanceScale()-pp.getAdvanceScale();
//									}
//								}
//							}
//						}
//						if (returnOrderMoney==null) {
//							returnOrderMoney=0.0;
//						}
//						if (poto.getReceivingGoodsMoney()==null) {
//							poto.setReceivingGoodsMoney(0.0);
//						}
//						if (pp.getAdvanceScale()==null) {
//							pp.setAdvanceScale(0.0);
//						}
//						String[] tbody={
//								pp.getSupcto().getIdentifier(),
//								pp.getSupcto().getName(),
//								df1.format(noPayMoney)+"",
//								df1.format(poto.getReceivingGoodsMoney()-returnOrderMoney)+"",
//								df1.format(pp.getAdvanceScale())+"",
//								df1.format(discountMoney)+"",
//								df1.format(poto.getReceivingGoodsMoney()-pp.getAdvanceScale())+""
//							};
//						totalMoney1+=noPayMoney;
//				        
//				        totalMoney2+=poto.getReceivingGoodsMoney()-returnOrderMoney;
//				        
//				        totalMoney3+=pp.getAdvanceScale();
//				        
//				        totalMoney4+=discountMoney;	
//				        
//				        totalMoney5+=poto.getReceivingGoodsMoney()-pp.getAdvanceScale();
//						tbodys.add(tbody);
//						
//					}
//				}
//			}else if (list2.size()==0&&list3.size()==0) {
//				for (SalesOrder  pp : list) {
//					for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()){
//						if (poto.getReceivingGoodsMoney()==null) {
//							poto.setReceivingGoodsMoney(0.0);
//						}
//						if (pp.getAdvanceScale()==null) {
//							pp.setAdvanceScale(0.0);
//						}
//						String[] tbody={
//								pp.getSupcto().getIdentifier(),
//								pp.getSupcto().getName(),
//								df1.format(noPayMoney)+"",
//								df1.format(poto.getReceivingGoodsMoney()-returnOrderMoney)+"",
//								df1.format(pp.getAdvanceScale())+"",
//								df1.format(discountMoney)+"",
//								df1.format(poto.getReceivingGoodsMoney()-pp.getAdvanceScale())+""
//							};
//						totalMoney1+=noPayMoney;
//				        
//				        totalMoney2+=poto.getReceivingGoodsMoney()-returnOrderMoney;
//				        
//				        totalMoney3+=pp.getAdvanceScale();
//				        
//				        totalMoney4+=discountMoney;	
//				        
//				        totalMoney5+=poto.getReceivingGoodsMoney()-pp.getAdvanceScale();
//							tbodys.add(tbody);
//					}
//				}
//			}
//			
//			JSONObject totalJSON = new JSONObject();
//			totalJSON.put("haveTotal", "true");
//			List<JSONObject> tt = new ArrayList<>();
//			JSONObject totalJSONColumns1 = new JSONObject();
//			totalJSONColumns1.put("columns", 3);
//			totalJSONColumns1.put("content", df1.format(totalMoney1));
//			tt.add(totalJSONColumns1);
//			JSONObject totalJSONColumns2 = new JSONObject();
//			totalJSONColumns2.put("columns", 4);
//			totalJSONColumns2.put("content", df1.format(totalMoney2));
//			tt.add(totalJSONColumns2);
//			JSONObject totalJSONColumns3 = new JSONObject();
//			totalJSONColumns3.put("columns", 5);
//			totalJSONColumns3.put("content", df1.format(totalMoney3));
//			tt.add(totalJSONColumns3);
//			JSONObject totalJSONColumns4 = new JSONObject();
//			totalJSONColumns4.put("columns", 6);
//			totalJSONColumns4.put("content", df1.format(totalMoney4));
//			tt.add(totalJSONColumns4);
//			JSONObject totalJSONColumns5 = new JSONObject();
//			totalJSONColumns5.put("columns", 7);
//			totalJSONColumns5.put("content", df1.format(totalMoney5));
//			tt.add(totalJSONColumns5);
//			totalJSON.put("total", tt);
//			JSONObject tableJSON = new JSONObject();
//			tableJSON.put("thead", theads);
//			tableJSON.put("tbody", tbodys);
//			tableJSON.put("total", totalJSON);
//			takeStockOrderJSON.put("table", tableJSON);
//		
//		
//		
//		
//		return takeStockOrderJSON;
//	}
	/**
	 * 账面库存汇总表 -按商品
	 * @param  
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportAccountsGether(Map<String, Object> params,String [] arr){
		
		List<CommoditySpecification>	list=commoditySpecificationService.reportAccountsGether(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		Double totalMoney4 = 0.0;
	
		Double dispathPrice=0.0;
		Integer dispathNum=0;
		Double dispathMoney=0.0;
		Double receiveMoney=0.0;
	 	
	 	Integer receiveNum=0;
	 	Double unitPrice=0.0;
	 	Double currentMoney=0.0;
	 	
	 	Integer currentNum=0;
	 	Double currentPrice=0.0;
		takeStockOrderJSON.put("title", "账面库存汇总表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "仓库名称","货品编码","货品名称","品牌", "货品规格", "单位", "收入|单价", "收入|数量", "收入|金额", "发出|单价", "发出|数量", 
				"发出|金额","占用库存"};
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		//if (list2.size()==0&&list3.size()!=0) {
			for (CommoditySpecification  pp : list) {
				if (pp.getCommentPrice()==null) {
					pp.setCommentPrice(pp.getBaseMiniPrice());
				}
				if (pp.getOccupiedNum()==null) {
					pp.setOccupiedNum(0);
				}
				String[] tbody={
						
						pp.getSpecWarehouseName()==null?"":pp.getSpecWarehouseName(),
						pp.getSpecificationIdentifier(),
						pp.getCommodity().getName(),
						pp.getCommodity().getBrand(),
						pp.getSpecificationName(),
						pp.getBaseUnitName(),
						pp.getBaseMiniPrice()+"",
						pp.getReceiveNum()+"",
						nf.format(pp.getBaseMiniPrice()*pp.getReceiveNum())+"",
						pp.getCommentPrice()+"",
						pp.getSendNum()+"",
						nf.format(pp.getCommentPrice()*pp.getSendNum())+"",
						pp.getOccupiedNum()+""
					};
					totalMoney1+=pp.getBaseMiniPrice()*pp.getReceiveNum();
					totalMoney2+=pp.getCommentPrice()*pp.getSendNum();
					tbodys.add(tbody);
					
						
						

						
			
		}
			
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			List<JSONObject> tt = new ArrayList<>();
			JSONObject totalJSONColumns1 = new JSONObject();
			totalJSONColumns1.put("columns", 10);
			totalJSONColumns1.put("content", nf.format(totalMoney1));
			tt.add(totalJSONColumns1);
			JSONObject totalJSONColumns2 = new JSONObject();
			totalJSONColumns2.put("columns", 13);
			totalJSONColumns2.put("content", nf.format(totalMoney2));
			tt.add(totalJSONColumns2);
//			JSONObject totalJSONColumns3 = new JSONObject();
//			totalJSONColumns3.put("columns", 15);
//			totalJSONColumns3.put("content", nf.format(totalMoney3));
//			tt.add(totalJSONColumns3);
//			JSONObject totalJSONColumns4 = new JSONObject();
//			totalJSONColumns4.put("columns", 18);
//			totalJSONColumns4.put("content", nf.format(totalMoney4));
//			tt.add(totalJSONColumns4);
			totalJSON.put("total", tt);
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		
		
		
			//}
		return takeStockOrderJSON;
		
	}
	/**
	 * 账面库存明细表 -按商品
	 * @param  
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportAccountsDetail(Map<String, Object> params,String [] arr){
	
		List<CommoditySpecification>	list=commoditySpecificationService.reportAccountsGether(params);
		//List<ProcureTable>	list2=procureTableService.reportAccountsGetherTwo(params);
		//List<SalesOrder>	list3=salesOrderService.reportAccountsGetherOne(params);
		JSONObject  takeStockOrderJSON= new JSONObject();
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		Double totalMoney4 = 0.0;
	
		Double dispathPrice=0.0;
		Integer dispathNum=0;
		Double dispathMoney=0.0;
		Double receiveMoney=0.0;
	 	
	 	Integer receiveNum=0;
	 	Double unitPrice=0.0;
	 	Double currentMoney=0.0;
	 	
	 	Integer currentNum=0;
	 	Double currentPrice=0.0;
		takeStockOrderJSON.put("title", "账面库存明细表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
			/* table start */
			// thead
			String[] theads = { "分支机构","仓库名称","货品编码","货品名称","品牌", "货品规格", "单位", "收入|单价", "收入|数量", "收入|金额", "发出|单价", "发出|数量", 
					"发出|金额","占用库存"};
			// tbody start
			List<String[]> tbodys = new ArrayList<>();
			//if (list2.size()==0&&list3.size()!=0) {
				for (CommoditySpecification  pp : list) {
					if (pp.getCommentPrice()==null) {
						pp.setCommentPrice(pp.getBaseMiniPrice());
					}
					if (pp.getOccupiedNum()==null) {
						pp.setOccupiedNum(0);
					}
					String[] tbody={
							"总部",
							pp.getSpecWarehouseName()==null?"":pp.getSpecWarehouseName(),
							pp.getSpecificationIdentifier(),
							pp.getCommodity().getName(),
							pp.getCommodity().getBrand(),
							pp.getSpecificationName(),
							pp.getBaseUnitName(),
							pp.getBaseMiniPrice()+"",
							pp.getReceiveNum()+"",
							nf.format(pp.getBaseMiniPrice()*pp.getReceiveNum())+"",
							pp.getCommentPrice()+"",
							pp.getSendNum()+"",
							nf.format(pp.getCommentPrice()*pp.getSendNum())+"",
							pp.getOccupiedNum()+""
						};

						tbodys.add(tbody);
						
							
							

							
				
			}
			
			
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "false");
			JSONObject tableJSON = new JSONObject();
			tableJSON.put("thead", theads);
			tableJSON.put("tbody", tbodys);
			tableJSON.put("total", totalJSON);
			takeStockOrderJSON.put("table", tableJSON);
		
		
		
			//}
		return takeStockOrderJSON;
		
	}
	/**
	 * 其他收货单明细表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportOtherReceiveOrder(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		List<ProcureTable>	list=procureTableService.reportOtherReceiveOrder(params);
		takeStockOrderJSON.put("title", "其他收货单明细表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "单号", "货品编码", "货品名称","品牌","开单日期","单位","数量","单价","金额","备注","批号","占用库存" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney1 = 0.0;
		for (ProcureTable  pp : list) {
			for (ProcureCommodity poto : pp.getProcureCommoditys()) {
				
				
				String[] tbody= {
						pp.getIdentifier(),
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName()+"("+poto.getCommoditySpecification().getSpecificationName()+")",
						poto.getCommoditySpecification().getCommodity().getBrand(),
						dateFormat.format(pp.getGenerateDate()),
						poto.getCommoditySpecification().getBaseUnitName(),
						poto.getOrderNum()+"",
						poto.getBusinessUnitPrice()+"",
						
						nf.format(poto.getTotalTaxPrice())+"",
						poto.getRemarks(),
						poto.getLotNumber(),
						pp.getInventory().getOccupiedInventory()+""
						};
//				BigDecimal bd1 = new BigDecimal(Double.toString(totalMoney1)); 
//		        BigDecimal bd2 = new BigDecimal(Double.toString(poto.getTotalPrice()));
//		        totalMoney1=totalMoney1+bd1.add(bd2).doubleValue();
		        
				
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "false");
		
		
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * 其他发货单明细表
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public JSONObject reportOtherDeliverOrder(Map<String, Object> params,String [] arr){
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2);
		JSONObject  takeStockOrderJSON= new JSONObject();
		
		List<SalesOrder>	list=salesOrderService.reportOtherDeliverOrder(params);
		takeStockOrderJSON.put("title", "其他发货单明细表");
		takeStockOrderJSON.put("beginDate", arr[0]);
		takeStockOrderJSON.put("endDate", arr[1]);
		/* table start */
		// thead
		String[] theads = { "单号", "货品编码", "货品名称","品牌","开单日期","单位","数量","单价","金额","备注","批号","占用库存" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney1 = 0.0;
		for (SalesOrder  pp : list) {
			for (SalesOrderCommodity poto : pp.getSalesOrderCommodities()) {
				
				
				String[] tbody= {
						pp.getIdentifier(),
						poto.getCommoditySpecification().getSpecificationIdentifier(),
						poto.getCommoditySpecification().getCommodity().getName()+"("+poto.getCommoditySpecification().getSpecificationName()+")",
						poto.getCommoditySpecification().getCommodity().getBrand(),
						dateFormat.format(pp.getCreateTime()),
						poto.getCommoditySpecification().getBaseUnitName(),
						poto.getDeliverGoodsNum()+"",
						poto.getUnitPrice()+"",
						
						nf.format(poto.getDeliverGoodsMoney())+"",
						poto.getRemark(),
						poto.getBatchNumber(),
						pp.getInventory().getOccupiedInventory()+""
						};
//				BigDecimal bd1 = new BigDecimal(Double.toString(totalMoney1)); 
//		        BigDecimal bd2 = new BigDecimal(Double.toString(poto.getTotalPrice()));
//		        totalMoney1=totalMoney1+bd1.add(bd2).doubleValue();
		        
				
				tbodys.add(tbody);
			}
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "false");
		
		
		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeStockOrderJSON.put("table", tableJSON);
		
		return takeStockOrderJSON;
	}
	/**
	 * test
	 * @param 
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("test")
	public List<SalesOrder> reportExportSalesOrder(Map<String, Object> params){
		
		return 	salesOrderService.reportSalesOrderOpenGether(params);
	}
	@ResponseBody
	@RequestMapping("test2")
	public List<ProcureTable> test2(Map<String, Object> params){
		
		return procureTableService.reportProcureOrderGether(params);
	}
}
