package com.jl.psi.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.binding.soap.interceptor.Soap11FaultOutInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.GetSessionUtil;
import com.sun.org.apache.xalan.internal.lib.NodeInfo;
import com.sun.org.apache.xpath.internal.operations.And;

@Controller
@RequestMapping("/basic/documentExport/")
public class DocumentExportContrller {
	
	
	@Autowired
	TakeStockOrderService takeStockOrderService;
	@Autowired
	BreakageOrderService breakageOrderservice;
	@Autowired
	PackageOrTeardownOrderService packageOrTeardownOrderService;
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
	WriteOffSubService  writeOffSubService;
	@Autowired
	BillsSubService billsSubService;
	@Autowired
	BillsService  billsService;
	@Autowired
	CommoditySpecificationService  commoditySpecificationService;
	DecimalFormat df1 = new DecimalFormat("0.00");
	NumberFormat nf = NumberFormat.getNumberInstance();
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/**
	 * 报表类型跳转
	 * @param orderType(1:组装单，2:拆卸单)
	 * @return 
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "switchMenu")
	public boolean switchMenu(Integer orderType,HttpServletRequest request,HttpServletResponse response) throws Exception {
		boolean flg=false;
		String data=request.getParameter("orderTime");
		String []  arr=data.split(" - ");

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//String 	commodityName = new String(request.getParameter("commodityName").getBytes("iso8859-1"), "utf-8");
		String  commodityName=URLDecoder.decode(request.getParameter("commodityName"), "UTF-8");
		//String 	supctoName=new String(request.getParameter("supctoName").getBytes("ISO-8859-1"),"UTF-8");
		//String 	brand=new String(request.getParameter("brand").getBytes("ISO-8859-1"),"UTF-8");
		String  supctoName=URLDecoder.decode(request.getParameter("supctoName"), "UTF-8");
		String  brand=URLDecoder.decode(request.getParameter("brand"), "UTF-8");
		String province=request.getParameter("province");
		String city=request.getParameter("city");
		String area=request.getParameter("area");
		String supctoTypeClassTwoId=request.getParameter("query_classification_two_id");
		if (supctoTypeClassTwoId.equals("null")) {
			System.out.println("supctoTypeClassTwoId>>>>"+supctoTypeClassTwoId);
			supctoTypeClassTwoId="";
		}
		if (province.equals("-1")||province.equals("null")) {
			
			province="";
		}
		if (city.equals("null")) {
			
			city="";
		}
		if (area.equals("-1")||area.equals("null")) {
			area="";
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("beginTime", arr[0]);
		params.put("closeTime", arr[1]);
		params.put("identifier", request.getParameter("identifier"));
		params.put("state", request.getParameter("state"));
		params.put("shippingModel", request.getParameter("shippingModel"));
		params.put("supctoTypeId", request.getParameter("supctoType"));
		params.put("supctoName", supctoName);//zh
		params.put("cname", commodityName);//zh
		params.put("commodity_identifier", request.getParameter("commodity_identifier"));
		params.put("brand", brand);//zh
		params.put("warehouseMsgId", request.getParameter("warehouseMsg"));
		params.put("area", area);//zh
		params.put("province", province);
		params.put("city", city);
		params.put("supctoTypeClassId", request.getParameter("query_classification_one_id"));
		params.put("departmentClassOneId", request.getParameter("departmentClassOne"));
		params.put("makeOrderPersonId", request.getParameter("makeOrderPerson"));
		params.put("checkDepartmentId", request.getParameter("checkDepartment"));
		params.put("checkPersonId", request.getParameter("checkPerson"));
		params.put("supctoTypeClassTwoId", supctoTypeClassTwoId);
		params.put("makeIdentifier", request.getParameter("makeIdentifier"));
		params.put("rewviewIdentifier", request.getParameter("rewviewIdentifier"));
		
		switch (orderType) {
		//报损单汇总表
		case 1:
			flg=this.exportBreakageOrder(request, response, params, arr);
			break;
		//采购订单汇总表
		case 2:
			flg=this.exportProcureOrderGether(request, response, params, arr);
			break;
		//采购订单明细表
		case 3:
			flg=this.exportProcureOrderDetail(request, response, params, arr);
			break;
		//采购计划汇总表
		case 4:
			flg=this.exportProcurePlanOrderGether(request, response, params, arr);
			break;
		//采购计划明细表
		case 5:
			flg=this.exportProcurePlanOrderDetail(request, response, params, arr);
			break;
		//采购开单汇总表
		case 6:
			flg=this.exportProcureFinishOrderDetailOrGether(request, response, params, arr, 1);
			break;
		//采购开单明细表
		case 7:
			flg=this.exportProcureFinishOrderDetailOrGether(request, response, params, arr, 2);
			break;
		//拆卸单明细表
		case 8:
			flg=this.exportPackageOrTeardownOrder(request, response, params, arr, 2);
			break;
		//出库单汇总表
		case 9:
			flg=this.exportExportSalesOrder(request, response, params, arr,2);
			break;
		//出库单明细表
		case 10:
			flg=this.exportExportSalesOrder(request, response, params, arr,1);
			break;
		//货品销售日常报表
		case 11:
			flg=this.exportSalesDayDetais(request, response, params, arr);
			break;
		//盘点单明细表
		case 12:
			flg=this.exportTakeStockOrder(request,response,params, arr);
			break;
		//入库单汇总表
		case 13:
			flg=this.exportImportOrderDetailOrGether(request, response, params, arr, 1);
			break;
		//入库单明细表
		case 14:
			flg=this.exportImportOrderDetailOrGether(request, response, params, arr, 2);
			break;
		//调拨单明细
		case 15:
			flg=this.exportAllotOrder(request, response, params, arr);
			break;
		//销售订单明细表
		case 16:
			flg=this.exportOrderDetail(request, response, params, arr);
			break;
		//销售计划单明细表
		case 17:
			flg=this.exportOrderPlanDetail(request, response, params, arr);
			break;
		//销售开单汇总表
		case 18:
			flg=this.exportSalesOrderOpenGether(request, response, params, arr);
			break;
		//销售开单明细表
		case 19:
			flg=this.exportSalesOrderOpenDetail(request, response, params, arr);
			break;
		//销售开单收款情况一览表
		case 20:
			flg=this.exportSalesOpenReceiveMoney(request, response, params, arr);
			break;
		//采购开单付款情况一览表
		case 21:
			flg=this.exportProcureFinishOrderPayMoneyDetail(request, response, params, arr);
			break;
		//销售毛利汇总表
		case 22:
			flg=this.exportProfitGether(request, response, params, arr);
			break;
		//销售毛利明细表
		case 23:
			flg=this.exportProfitDetail(request, response, params, arr);
			break;
		//应付账款汇总表
		case 24:
			flg=this.exportPayMoneyGether(request, response, params, arr,2);
			break;
		//应收账款汇总表
		case 25:
			flg=this.exportPayMoneyGether(request, response, params, arr,1);
			break;
		//账面库存汇总表
		case 26:
			flg=this.exportAccountsGether(request, response, params, arr);
			break;
		//账面库存明细表
		case 27:
			flg=this.exportAccountsDetail(request, response, params, arr);
			break;
		//组装单明细表
		case 28:
			flg=this.exportPackageOrTeardownOrder(request, response, params, arr, 1);
			break;
		//其他收货单明细表
		case 29:
			flg=this.exportOtherReceiveOrder(request, response, params, arr);
			break;
		//其他发货单明细表
		case 30:
			flg=this.exportOtherDeliverOrder(request, response, params, arr);
			break;
		default:
			break;
		}
		return flg;
	}
	/**
	 * 报损单汇总表
	 * 
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportBreakageOrder(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "报损单汇总表";//文档名称以及Excel里头部信息
		List<BreakageOrder>	list=breakageOrderservice.reporBreakOrdertMsg(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[9];
			title[0]="货品编码";
			title[1]="货品名称";
			title[2]="规格";
			title[3]="品牌";
			title[4]="仓库";
			title[5]="单位";
			
			title[6]="基本数量";
			title[7]="金额";
			title[8]="占用库存";
			//保存要导出的内容
			Double totolMoney=0.0;
			String totol[]=new String[8];
			for(BreakageOrder c:list){
				value=new String[9];
				
				for (BreakageOrderCommodity tCommodity : c.getBreakageOrderCommodities()) {
					value[0] = tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					
					value[1] =tCommodity.getCommoditySpecification().getCommodity().getName();
					value[2] =tCommodity.getCommoditySpecification().getSpecificationName();
					value[3] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
					value[4] =tCommodity.getCommoditySpecification().getInventories().get(0).getWarehouse().getName();
					value[5]=tCommodity.getCommoditySpecification().getUnits().get(0).getName();
					value[6]=tCommodity.getNumber()+"";
					value[7]=tCommodity.getMoney()+"";
					value[8]=c.getInventory().getOccupiedInventory()+"";
					
			        totolMoney+=tCommodity.getMoney();
					dataList.add(value);
				}
				
				//dataList.add(arr);
				
			}
			totol[0]="合计";
			totol[1]="";
			totol[2]="";
			totol[3]="";
			totol[4]="";
			totol[5]="";
			totol[6]="";
			totol[7]=totolMoney+"";
			dataList.add(totol);
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 盘点单明细表导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportTakeStockOrder(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "盘点单明细";//文档名称以及Excel里头部信息
		List<TakeStockOrder>	list=takeStockOrderService.reportTakeStockOrderMsg(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[12];
			title[0]="单号";
			title[1]="货品编码";
			title[2]="货品名称";
			title[3]="品牌";
			
			title[4]="开单日期";
			
			title[5]="单位";
			title[6]="数量";
			title[7]="单价";
			title[8]="金额";
			title[9]="备注";
			title[10]="批号";
			title[11]="占用库存";
			//保存要导出的内容
			for(TakeStockOrder c:list){
				value=new String[12];
				
				for (TakeStockOrderCommodity tCommodity : c.getTakeStockOrderCommodities()) {
					if (c.getSummary()==null) {
						c.setSummary("");
					}
					if (tCommodity.getProfitOrLossNum()==null) {
						tCommodity.setProfitOrLossNum(0);
					}
					if (tCommodity.getMoney()==null) {
						tCommodity.setMoney(0.0);
					}
					value[0] = c.getIdentifier();
					value[1] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[2] =tCommodity.getCommoditySpecification().getCommodity().getName();
					value[3] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
					value[4] =dateFormat.format(c.getTakeStockDate());
					value[5]=tCommodity.getCommoditySpecification().getUnits().get(0).getName();
					value[6]=tCommodity.getProfitOrLossNum()+"";
					value[7]=tCommodity.getUnitPrice()+"";
					value[8]=nf.format(tCommodity.getMoney())+"";
					value[9]=c.getSummary();
					value[10]="";
					value[11]=c.getInventory().getOccupiedInventory()+"";
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 组装单明细表
	 * 
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportPackageOrTeardownOrder(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr,Integer orderType) throws Exception{
		//response.setContentType("application/octet-stream; charset=utf-8");  
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		params.put("orderType", orderType);
		
		String fileName=null;
		if (orderType==1) {
			fileName = "组装单明细表";
		}else {
			fileName = "拆卸单明细表";
		}
	    //response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("gbk"), "utf-8")+".xlsx");  
//		String agent = request.getHeader("User-Agent");
//		fileName =CommonMethod.encodeDownloadFilename(fileName, agent);
		//文档名称以及Excel里头部信息
		List<PackageOrTeardownOrder>	list=packageOrTeardownOrderService.reportPackageOrTeardownOrderMsg(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		System.out.println(">>>>>>>list"+list.size());
		//搜索的有数据
		if (orderType==1) {
			if(list.size()>0){
				//需导出的表头与信息
				
				//保存Excel表头
				title=new String[9];
				
				title[0]="货品编码";
				title[1]="货品名称";
				title[2]="规格";
				title[3]="品牌";
				title[4]="仓库";
				title[5]="单位";
				title[6]="基本数量";
				title[7]="金额";
				title[8]="占用库存";
				//保存要导出的内容
				Double totolMoney=0.0;
				String totol[]=new String[15];
				for(PackageOrTeardownOrder c:list){
					value=new String[15];
					
					for (PackageOrTeardownOrderCommodity tCommodity : c.getPackageOrTeardownOrderCommodities()) {
						
						value[0] = tCommodity.getCommoditySpecification().getSpecificationIdentifier();
						
						value[1] =tCommodity.getCommoditySpecification().getCommodity().getName();
						value[2] =tCommodity.getCommoditySpecification().getSpecificationName();
						value[3] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
						value[4] =tCommodity.getCommoditySpecification().getInventories().get(0).getWarehouse().getName();
						value[5]=tCommodity.getCommoditySpecification().getUnits().get(0).getName();
						value[6]=c.getPackageOrTeardownNum()+"";
						value[7]=nf.format(c.getTotalMoney())+"";
						value[8]=c.getInventory().getOccupiedInventory()+"";
						totolMoney+=c.getTotalMoney();
						dataList.add(value);
					}
					
					//dataList.add(arr);
					
				}
				totol[0]="合计";
				totol[1]="";
				totol[2]="";
				totol[3]="";
				totol[4]="";
				totol[5]="";
				totol[6]="";
				totol[7]=nf.format(totolMoney)+"";
				
				dataList.add(totol);
				
			}
			//没有搜索到数据
			else{
				title=new String[1];
				title[0]=Constants.NO_DATA_EXPORT;//无数据提示
			}
		}else {
			if(list.size()>0){
				//需导出的表头与信息
				
				//保存Excel表头
				title=new String[10];
				title[0]="单号";
				title[1]="开单日期";
				title[2]="货品编码";
				title[3]="货品名称";
				title[4]="单位";
				title[5]="单价";
				title[6]="单位数量";
				title[7]="金额";
				title[8]="备注";
				title[9]="占用库存";
				//保存要导出的内容
				Double totolMoney=0.0;
				String totol[]=new String[15];
				for(PackageOrTeardownOrder c:list){
					value=new String[15];
					
					for (PackageOrTeardownOrderCommodity tCommodity : c.getPackageOrTeardownOrderCommodities()) {
						value[0]=c.getIdentifier();
						value[1]=dateFormat.format(c.getPackageOrTeardownDate());
						value[2] = tCommodity.getCommoditySpecification().getSpecificationIdentifier();
						
						value[3] =tCommodity.getCommoditySpecification().getCommodity().getName();
						value[4]=tCommodity.getCommoditySpecification().getUnits().get(0).getName();
						value[5]=c.getUnitPrice()+"";
						value[6]=c.getPackageOrTeardownNum()+"";
						value[7]=nf.format(c.getTotalMoney())+"";
						value[8]=c.getSummary()+"";
						value[9]=c.getInventory().getOccupiedInventory()+"";
						totolMoney+=c.getTotalMoney();
						dataList.add(value);
					}
					
					//dataList.add(arr);
					
				}
				totol[0]="合计";
				totol[1]="";
				totol[2]="";
				totol[3]="";
				totol[4]="";
				totol[5]="";
				totol[6]="";
				totol[7]=nf.format(totolMoney)+"";
				totol[8]="";
				
				dataList.add(totol);
				
			}
			//没有搜索到数据
			else{
				title=new String[1];
				title[0]=Constants.NO_DATA_EXPORT;//无数据提示
			}
		}
		
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 调拨单明细表导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportAllotOrder(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "调拨单明细";//文档名称以及Excel里头部信息
		List<AllotOrder>	list=allotOrderService.reportMsg(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息
					
			//保存Excel表头
			title=new String[14];
			title[0]="调出仓库名";
			title[1]="单据日期";
			title[2]="单号";
			title[3]="货品编码";
			
			title[4]="货品名称";
			
			title[5]="单位";
			title[6]="规格";
			title[7]="单价";
			title[8]="数量";
			title[9]="金额";
			title[10]="调入仓库名称";
			title[11]="制单员";
			title[12]="备注";
			title[13]="占用库存";
			//保存要导出的内容
			for(AllotOrder c:list){
				value=new String[14];
				
				for (AllotOrderCommodity tCommodity : c.getAllotOrderCommodities()) {
					if (c.getSummary()==null) {
						c.setSummary("");
					}
					if (c.getOriginator().contains("null")) {
						c.setOriginator("");
					}
					value[0] = c.getExportName();
					value[1] =dateFormat.format(c.getAllotDate());
					value[2] =c.getIdentifier();
					value[3] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[4] =tCommodity.getCommoditySpecification().getCommodity().getName();
					value[5]=tCommodity.getCommoditySpecification().getUnits().get(0).getName();
					value[6]=tCommodity.getCommoditySpecification().getSpecificationName();
					value[7]=tCommodity.getImportUnitPrice()+"";
					value[8]=tCommodity.getNumber()+"";
					value[9]=nf.format(tCommodity.getImportMoney())+"";
					value[10]=c.getImportName();
					value[11]=c.getOriginator();
					value[12]=c.getSummary();
					value[12]=c.getInventory().getOccupiedInventory()+"";
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 出库单明细表导出/出库单汇总表导出
	 * @param  orderType  1:出库单明细表导出 2:出库单汇总表导出
	 * @return 
	 */
	@ResponseBody
	public boolean exportExportSalesOrder(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr,Integer orderType) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		String  fileName=null;
		List<ProcureTable>	ptList=new ArrayList<>();
		List<SalesOrder> list=new ArrayList<>();
		String totol[]=new String[9];
		List<String[]> dataList=new ArrayList<>();
		String[] title = null; //保存Excel表头
		String[] value; //保存要导出的内容
		Double totolMoney=0.0;
		if (orderType==1) {
			fileName = "出库单明细";//文档名称以及Excel里头部信息
			//获取采购退货单出库单
			ptList=procureTableService.getSaleReturnDetailToReport(params);
			list=salesOrderService.reportExportSalesOrderDetail(params);
			
			
			//搜索的有数据
			if(list.size()>0||ptList.size()>0){
				//需导出的表头与信息				
				//保存Excel表头
				title=new String[13];
				title[0]="单号编号";
				title[1]="单据名称";
				title[2]="货品编码";
				title[3]="货品名称";
				
				title[4]="客户名称";
				
				title[5]="开单日期";
				title[6]="单位";
				title[7]="数量";
				title[8]="单价";
				title[9]="金额";
				title[10]="备注";
				title[11]="批号";
				title[12]="占用库存";
				
				for(SalesOrder c:list){
					
					value=new String[13];
					for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
						int type= c.getOrderType();
						String  orderName=null;
						String num=null;
						Double money=0.0;
						if (tCommodity.getDeliverGoodsMoney()==null) {
							tCommodity.setDeliverGoodsMoney(0.0);
						}
						if (type==3) {
							orderName="出库单";
							num=tCommodity.getDeliverGoodsNum()+"";
							money=tCommodity.getDeliverGoodsMoney();
						}else if (type==5) {
							orderName="返货单";
							num=tCommodity.getReturnGoodsNum()+"";
							money=tCommodity.getDeliverGoodsMoney();
						}else if (type==6) {
							orderName="销售退货单";
							num=tCommodity.getReturnGoodsNum()+"";
							money=tCommodity.getDeliverGoodsMoney();
						}else if (type==9) {
							orderName="其他发货单出库单";
							num=tCommodity.getDeliverGoodsNum()+"";
							money=tCommodity.getDeliverGoodsMoney();
						}
						if (tCommodity.getRemark()==null) {
							tCommodity.setRemark("");
						}
						if (tCommodity.getBatchNumber()==null) {
							tCommodity.setBatchNumber("");
						}
							value[0] = c.getIdentifier();
							value[1] =orderName;
							value[2] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
							value[3] =tCommodity.getCommoditySpecification().getCommodity().getName();
							value[4] =tCommodity.getCommoditySpecification().getCommodity().getSupcto()==null?"其他发货单出库单":tCommodity.getCommoditySpecification().getCommodity().getSupcto().getName();
							
							value[5]=dateFormat.format(c.getCreateTime());
							value[6]=tCommodity.getCommoditySpecification().getUnits().get(0).getName();
							value[7]=num;
							value[8]=tCommodity.getUnitPrice()+"";
							value[9]=nf.format(money)+"";
							value[10]=tCommodity.getRemark();
							value[11]=tCommodity.getBatchNumber();
							value[12]=c.getInventory().getOccupiedInventory()+"";
							dataList.add(value);
						
					}
				}
				for(ProcureTable pt:ptList){
					value=new String[13];
					for(ProcureCommodity po:pt.getProcureCommoditys()){
						value[0] = pt.getIdentifier();
						value[1] ="采购退货单出库单";
						value[2] =po.getCommoditySpecification().getSpecificationIdentifier();
						value[3] =po.getCommoditySpecification().getCommodity().getName();
						value[4] =pt.getSupcto()==null?"":pt.getSupcto().getName();
						
						value[5]=pt.getGenerateDate()==null?"":dateFormat.format(pt.getGenerateDate());
						value[6]=po.getCommoditySpecification().getBaseUnitName();
						value[7]=po.getArrivalQuantity()==null?"0":po.getArrivalQuantity()+"";
						value[8]=po.getBusinessUnitPrice()==null?"0.0":po.getBusinessUnitPrice()+"";
						value[9]=nf.format(po.getTotalPrice()==null?0:po.getTotalPrice());
						value[10]=po.getRemarks()==null?"":po.getRemarks();
						value[11]=po.getLotNumber()==null?"":po.getLotNumber();
						value[12]=pt.getInventory().getOccupiedInventory()+"";
						dataList.add(value);
					}
				}
				
			}
			//没有搜索到数据
			else{
				title=new String[1];
				title[0]=Constants.NO_DATA_EXPORT;//无数据提示
			}
		}else if (orderType==2) {
			fileName = "出库单汇总表";//文档名称以及Excel里头部信息
			//获取采购退货单出库单
			ptList=procureTableService.getSaleReturnAllMsgToReport(params);
			list=salesOrderService.reportExportSalesOrder(params);
			
			
			
			//搜索的有数据
			if(list.size()>0||ptList.size()>0){
				//需导出的表头与信息				
				//保存Excel表头
				title=new String[9];
				title[0]="货品编码";
				title[1]="货品名称";
				title[2]="规格";
				title[3]="品牌";
				title[4]="单位";
				title[5]="仓库";
				title[6]="数量";
				title[7]="金额";
				title[8]="占用库存";
				//保存要导出的内容
				for(SalesOrder c:list){
					
					value=new String[12];
					for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
						
						String num=null;
						Double money=0.0;
						boolean isHas=false;
							for(int j=0;j<ptList.size();j++){
								ProcureTable pt=ptList.get(j);
								for(int i=0;i<pt.getProcureCommoditys().size();i++){
									ProcureCommodity pc=pt.getProcureCommoditys().get(i);
									if(tCommodity.getCommoditySpecificationId().equals(pc.getCommodityId())){
										isHas=true;
										num=tCommodity.getDeliverGoodsNum()+pc.getArrivalQuantity()+"";
										money=(tCommodity.getDeliverGoodsMoney()==null?0.0:tCommodity.getDeliverGoodsMoney())+(pc.getTotalPrice()==null?0.0:pc.getTotalPrice());
				
										pt.getProcureCommoditys().remove(i);
										break;
									}	
								}				
								if(isHas){
									if(ptList.get(j).getProcureCommoditys().size()<=0){
										ptList.remove(j);
									}
									break;
								}
							}
							if(!isHas){		
								
								num=tCommodity.getDeliverGoodsNum()+"";
								money=tCommodity.getDeliverGoodsMoney()==null?0.0:tCommodity.getDeliverGoodsMoney();
							}
							value[0] = tCommodity.getCommoditySpecification().getSpecificationIdentifier();
							value[1] =tCommodity.getCommoditySpecification().getCommodity().getName();
							value[2] =tCommodity.getCommoditySpecification().getSpecificationName();
							value[3] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
							value[4] =tCommodity.getCommoditySpecification().getUnits().get(0).getName();
							value[5]=tCommodity.getWarehouse().getName();
							value[6]=num;
							value[7]=nf.format(money)+"";
							value[8]=c.getInventory().getOccupiedInventory()+"";
							totolMoney+=money;
							dataList.add(value);
						
					}
				}
				for(int j=0;j<ptList.size();j++){
					value=new String[12];
					ProcureTable pt=ptList.get(j);
					for(int i=0;i<pt.getProcureCommoditys().size();i++){
						ProcureCommodity pc=pt.getProcureCommoditys().get(i);
						String num=null;
						Double money=0.0;
						num=pc.getArrivalQuantity()+"";
						money=pc.getTotalPrice()==null?0.0:pc.getTotalPrice();
							
						value[0] = pc.getCommoditySpecification().getSpecificationIdentifier();
						value[1] =pc.getCommoditySpecification().getCommodity().getName();
						value[2] =pc.getCommoditySpecification().getSpecificationName();
						value[3] =pc.getCommoditySpecification().getCommodity().getBrand();
						value[4] =pc.getCommoditySpecification().getBaseUnitName();
						value[5]=pc.getCommoditySpecification().getSpecWarehouseName();
						value[6]=num;
						value[7]=nf.format(money)+"";
						value[8]=pt.getInventory().getOccupiedInventory()+"";
						totolMoney+=money;
						dataList.add(value);
					}				
				}
				if (orderType==2) {
					totol[0]="合计";
					totol[1]="";
					totol[2]="";
					totol[3]="";
					totol[4]="";
					totol[5]="";
					totol[6]="";
					totol[7]=nf.format(totolMoney)+"";
					dataList.add(totol);
				}
			}
			//没有搜索到数据
			else{
				title=new String[1];
				title[0]=Constants.NO_DATA_EXPORT;//无数据提示
			}
		}
		
		
		
		
		
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 销售订单明细表-按客户 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportOrderDetail(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "销售订单明细表-按客户";//文档名称以及Excel里头部信息
		
		List<SalesOrder>	list=salesOrderService.reportOrderDetail(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[15];
			title[0]="单号编号";
			title[1]="单据日期";
			title[2]="客户名称";
			title[3]="货品编码";
			
			title[4]="货品名称";
			
			title[5]="规格";
			title[6]="样品";
			title[7]="单位";
			title[8]="单价";
			title[9]="订货|数量(业)";
			title[10]="订货|金额";
			title[11]="备注";
			
			title[12]="业务员";
			title[13]="占用库存";
			title[14]="折扣率(%)";
			//保存要导出的内容
			for(SalesOrder c:list){
				
				value=new String[15];
				for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
					String isSpecialOffer=null;
					if (tCommodity.getRemark()==null) {
						tCommodity.setRemark("");
					}
					if (c.getIsSpecimen()==1) {
						isSpecialOffer="否";
					}else {
						isSpecialOffer="是";
					}
					if (c.getPerson()==null) {
						Person person=new Person();
						person.setName("");
						person.setPhone("");
						c.setPerson(person);
					}
					if (c.getPerson().getName()==null) {
						c.getPerson().setName("");
					}
					if (c.getPerson().getPhone()==null) {
						c.getPerson().setPhone("");
					}
					if (tCommodity.getDiscount()==null) {
						tCommodity.setDiscount(0.0);
					}
					if (tCommodity.getCommoditySpecification().getCommodity().getSupcto()==null) {
						Supcto supcto=new Supcto();
						if(c.getIsAppOrder()!=null&&c.getIsAppOrder()==2){
							supcto.setName("APP");
							supcto.setPhone(c.getPhone());
						}
						else{
							supcto.setName("");
							supcto.setPhone("");
						}
						tCommodity.getCommoditySpecification().getCommodity().setSupcto(supcto);
					}
					value[0] = c.getIdentifier();
					value[1] =dateFormat.format(c.getCreateTime());
					value[2] =tCommodity.getCommoditySpecification().getCommodity().getSupcto().getName();
					value[3] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[4] =tCommodity.getCommoditySpecification().getCommodity().getName();
					
					value[5]=tCommodity.getCommoditySpecification().getSpecificationName();
					value[6]=isSpecialOffer;
					value[7]=tCommodity.getCommoditySpecification().getUnits().get(0).getName();
					value[8]=tCommodity.getUnitPrice()+"";
					value[9]=tCommodity.getDeliverGoodsNum()+"";
					value[10]=nf.format(tCommodity.getDeliverGoodsMoney())+"";
					value[11]=tCommodity.getRemark();
					
					value[12]=c.getPerson().getName();
					value[13]=c.getInventory().getOccupiedInventory()+"";
					value[14]=tCommodity.getDiscount()+"";
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 销售计划单明细表-按客户 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportOrderPlanDetail(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "销售计划单明细表-按客户";//文档名称以及Excel里头部信息
		
		List<SalesPlanOrder>	list=planOrderService.reportSalesPlanOrderDetail(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[13];
			title[0]="单号编号";
			title[1]="单据日期";
			title[2]="客户名称";
			title[3]="货品编码";
			
			title[4]="货品名称";
			
			title[5]="规格";
			
			title[6]="单位";
			title[7]="单价";
			title[8]="订货|数量(业)";
			title[9]="订货|金额";
			title[10]="备注";
			title[11]="业务员";
			title[12]="占用库存";
			//保存要导出的内容
			for(SalesPlanOrder c:list){
				
				value=new String[14];
				for (SalesPlanOrderCommodity tCommodity : c.getSalesPlanOrderCommodities()) {
					if (c.getPerson()==null) {
						Person person=new Person();
						person.setName("");
						person.setPhone("");
						c.setPerson(person);
					}
					if (c.getPerson().getName()==null) {
						c.getPerson().setName("");
					}
					if (c.getPerson().getPhone()==null) {
						c.getPerson().setPhone("");
					}
					if (c.getSupcto()==null) {
						Supcto supcto=new Supcto();
						if(c.getIsAppOrder()!=null&&c.getIsAppOrder()==2){
							supcto.setName("APP");
						}
						else{
							supcto.setName("");
						}
						
						c.setSupcto(supcto);
					}
					if (tCommodity.getRemark()==null) {
						tCommodity.setRemark("");
					}					
					value[0] = c.getIdentifier();
					value[1] =dateFormat.format(c.getCreateTime());
					value[2] =c.getSupcto().getName();
					value[3] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[4] =tCommodity.getCommoditySpecification().getCommodity().getName();
					
					value[5]=tCommodity.getCommoditySpecification().getSpecificationName();
					value[6]=tCommodity.getCommoditySpecification().getUnits().get(0).getName();
					value[7]=tCommodity.getUnitPrice()+"";
					value[8]=tCommodity.getNumber()+"";
					value[9]=nf.format(tCommodity.getMoney())+"";
					value[10]=tCommodity.getRemark();
					value[11]=c.getPerson().getName();
					value[12]=c.getInventory().getOccupiedInventory()+"";
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 销售开单汇总表
	 * 
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportSalesOrderOpenGether(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "销售开单汇总表-按客户";//文档名称以及Excel里头部信息
		List<SalesOrder>	list=salesOrderService.reportSalesOrderOpenGether(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[8];
			title[0]="客户编码";
			title[1]="客户名称";
			title[2]="地区";
			title[3]="部门";
			title[4]="折损金额";
			title[5]="签收金额";
			title[6]="退货金额(含税)";
			title[7]="总金额";
			//保存要导出的内容
			Double totolMoney1=0.0;
			Double totolMoney2=0.0;
			Double totolMoney3=0.0;
			Double totolMoney4=0.0;
			String totol1[]=new String[8];
			for(SalesOrder  c:list){
				value=new String[8];
				
				for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
					if (tCommodity.getDamageMoney()==null) {
						tCommodity.setDamageMoney(0.0);
					}
					if (c.getSupcto().getIdentifier()==null) {
						c.getSupcto().setIdentifier("");
						c.getSupcto().setName("");
						c.getSupcto().setProvince("");
						c.getSupcto().setCity("");
						c.getSupcto().setArea("");
					}
					if (c.getSupcto().getCity()==null) {
						c.getSupcto().setCity("");
					}else if (c.getSupcto().getArea()==null) {
						c.getSupcto().setArea("");
					}
					if (tCommodity.getReceivingGoodsMoney()==null) {
						tCommodity.setReceivingGoodsMoney(0.0);
					}
					if (c.getSupcto().getDepartment()==null) {
						Department department=new Department();
						department.setName("");
						c.getSupcto().setDepartment(department);
					}
					value[0] = c.getSupcto().getIdentifier();
					
					value[1] =c.getSupcto().getName();
					value[2] =c.getSupcto().getProvince()+"  "+c.getSupcto().getCity()+"  "+c.getSupcto().getArea();
					value[3] =c.getSupcto().getDepartment().getName();
					Double damageMoney=tCommodity.getDamageMoney()==null?0.0:tCommodity.getDamageMoney();
					if(damageMoney>0){
						damageMoney=-damageMoney;
					}
					value[4] =nf.format(damageMoney)+"";
					value[5]=nf.format(tCommodity.getReceivingGoodsMoney())+"";
					value[6]=nf.format(c.getReturnMoney())+"";
					value[7]=nf.format(tCommodity.getReceivingGoodsMoney()-c.getReturnMoney())+"";
			        totolMoney1+=damageMoney;
			        
			        totolMoney2+=tCommodity.getReceivingGoodsMoney();
			        totolMoney3+=c.getReturnMoney();
			        totolMoney4+=tCommodity.getReceivingGoodsMoney()-c.getReturnMoney();
					dataList.add(value);
				}
				
				//dataList.add(arr);
				
			}
			totol1[0]="合计";
			totol1[1]="";
			totol1[2]="";
			totol1[3]="";
			totol1[4]=nf.format(totolMoney1)+"";
			totol1[5]=nf.format(totolMoney2)+"";
			totol1[6]=nf.format(totolMoney3)+"";
			totol1[7]=nf.format(totolMoney4)+"";
			dataList.add(totol1);
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 销售开单明细表 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportSalesOrderOpenDetail(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "销售开单明细表-按客户";//文档名称以及Excel里头部信息
		params.put("type", 2);
		List<SalesOrder>	list=salesOrderService.reportSalesOrderOpenDetail(params);
		List<SalesOrder>	list2=salesOrderService.reportSalesOrderReturnDetail(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[23];
			title[0]="类型";
			title[1]="单据日期";
			title[2]="单据编号";
			title[3]="客户名称";
			title[4]="货品编码";
			title[5]="货品名称";
			title[6]="规格";
			
			title[7]="单位";
			title[8]="单价";
			title[9]="签收数量";
			
			title[10]="折损金额";
			title[11]="签收金额";
			title[12]="税率";
			title[13]="税额";
			title[14]="摘要";
			title[15]="业务员";
			title[16]="审核人";
			title[17]="制单员";
			title[18]="地区";
			title[19]="部门";
			title[20]="占用数量";
			
			//保存要导出的内容
			for(SalesOrder c:list){
				
				value=new String[23];
				for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
					if (tCommodity.getDamageMoney()==null) {
						tCommodity.setDamageMoney(0.0);
					}
					if (c.getSupcto().getName()==null) {
						c.getSupcto().setIdentifier("");
						c.getSupcto().setName("");
						c.getSupcto().setProvince("");
						c.getSupcto().setCity("");
						c.getSupcto().setArea("");
					}
					if (c.getSupcto().getCity()==null) {
						c.getSupcto().setCity("");
					}else if (c.getSupcto().getArea()==null) {
						c.getSupcto().setArea("");
					}
					if (c.getReviewerName()==null) {
						c.setReviewerName("");
					}
					if (c.getSupcto().getDepartment()==null) {
						Department department=new Department();
						department.setName("");
						c.getSupcto().setDepartment(department);
					}
					value[0] = "销售开单";
					value[1] =c.getCreateTime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getCreateTime());
					value[2] =c.getIdentifier();
					value[3] = c.getSupcto().getName();
					value[4] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[5] =tCommodity.getCommoditySpecification().getCommodity().getName();
					value[6] =tCommodity.getCommoditySpecification().getSpecificationName();
					value[7] =tCommodity.getCommoditySpecification().getBaseUnitName();
					value[8]=tCommodity.getUnitPrice()+"";
					value[9]=tCommodity.getReceivingGoodsNum()+"";
					Double damageMoney=tCommodity.getDamageMoney()==null?0.0:new BigDecimal(tCommodity.getDamageMoney()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
					if(damageMoney>0){
						damageMoney=-damageMoney;
					}
					value[10]=nf.format(damageMoney)+"";
					value[11]=nf.format(tCommodity.getReceivingGoodsMoney())+"";
					value[12]=tCommodity.getTaxes()+"";
					value[13]=nf.format(tCommodity.getTaxesMoney())+"";
					value[14]=c.getSummary();
					value[15]=c.getPerson().getName();
					value[16]=c.getReviewerName();
					value[17]=c.getOriginatorName();
					value[18]=c.getSupcto().getProvince()+"  "+c.getSupcto().getCity()+"  "+c.getSupcto().getArea();
					value[19]=c.getSupcto().getDepartment().getName();
					value[20]=c.getInventory().getOccupiedInventory()+"";
					
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
			for(SalesOrder c:list2){
				
				value=new String[23];
				for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
					if (tCommodity.getDamageMoney()==null) {
						tCommodity.setDamageMoney(0.0);
					}
					if (c.getSupcto().getName()==null) {
						c.getSupcto().setIdentifier("");
						c.getSupcto().setName("");
						c.getSupcto().setProvince("");
						c.getSupcto().setCity("");
						c.getSupcto().setArea("");
					}
					if (c.getSupcto().getCity()==null) {
						c.getSupcto().setCity("");
					}else if (c.getSupcto().getArea()==null) {
						c.getSupcto().setArea("");
					}
					if (c.getReviewerName()==null) {
						c.setReviewerName("");
					}
					if (c.getSupcto().getDepartment()==null) {
						Department department=new Department();
						department.setName("");
						c.getSupcto().setDepartment(department);
					}
					value[0] = "销售退货";
					value[1] =c.getCreateTime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getCreateTime());
					value[2] =c.getIdentifier();
					value[3] = c.getSupcto().getName();
					value[4] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[5] =tCommodity.getCommoditySpecification().getCommodity().getName();
					value[6] =tCommodity.getCommoditySpecification().getSpecificationName();
					value[7] =tCommodity.getCommoditySpecification().getBaseUnitName();
					value[8]=tCommodity.getUnitPrice()+"";
					value[9]="-"+tCommodity.getReturnGoodsNum()+"";
					
					value[10]=tCommodity.getDamageMoney()+"";
					value[11]="-"+nf.format(tCommodity.getReturnGoodsNum()*tCommodity.getUnitPrice())+"";
					value[12]=tCommodity.getTaxes()+"";
					value[13]=nf.format(tCommodity.getTaxesMoney())+"";
					value[14]=c.getSummary();
					value[15]=c.getPerson().getName();
					value[16]=c.getReviewerName();
					value[17]=c.getOriginatorName();
					value[18]=c.getSupcto().getProvince()+"  "+c.getSupcto().getCity()+"  "+c.getSupcto().getArea();
					value[19]=c.getSupcto().getDepartment().getName();
					value[20]=c.getInventory().getOccupiedInventory()+"";
					
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 采购订单汇总表（按供应商）
	 * 
	 * @param 
	 * @return 
	 */ 
	@ResponseBody
	public boolean exportProcureOrderGether(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "采购订单汇总表-按供应商";//文档名称以及Excel里头部信息
		List<ProcureTable>	list=procureTableService.reportProcureOrderGether(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		String  supctoName="";
		String supctoIdentifier="";
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[5];
			title[0]="供应商编码";
			title[1]="供应商名称";
			title[2]="订货金额";
			title[3]="已收货金额";
			title[4]="未收货金额";
			
			
			//保存要导出的内容
			Double totolMoney1=0.0;
			Double totolMoney2=0.0;
			Double totolMoney3=0.0;
			String totol1[]=new String[8];
			for(ProcureTable  c:list){
				value=new String[8];
				
				for (ProcureCommodity tCommodity : c.getProcureCommoditys()) {
					if (c.getSupcto()==null) {
						Supcto supcto=new Supcto();
						supcto.setName("");
						supcto.setIdentifier("");
						c.setSupcto(supcto);
					}else {
						supctoIdentifier=c.getSupcto().getIdentifier();
						supctoName=c.getSupcto().getName();
					}
					if (tCommodity.getTotalTaxPrice()==null) {
						tCommodity.setTotalTaxPrice(0.0);
					}
					if (tCommodity.getSuspendPrice()==null) {
						tCommodity.setSuspendPrice(0.0);
					}
					if (tCommodity.getTotalPrice()==null) {
						tCommodity.setTotalPrice(0.0);
					}
					if (tCommodity.getArrivalMoney()==null) {
						tCommodity.setArrivalMoney(0.0);
					}
					if (tCommodity.getSuspendQuantity()==null) {
						tCommodity.setSuspendQuantity(0);
					}
					if (tCommodity.getSurplusMoney()==null) {
						tCommodity.setSurplusMoney(0.0);
					}
					if (tCommodity.getSurplusNum()==null) {
						tCommodity.setSurplusNum(0);
					}
					System.out.println(">>>>>>getSuspendPrice"+tCommodity.getSuspendPrice());
					System.out.println(">>>>>>getTotalPrice"+tCommodity.getTotalPrice());
					value[0] = supctoIdentifier;
					
					value[1] =supctoName;
					value[2] =nf.format(tCommodity.getTotalTaxPrice())+"";
					value[3] =nf.format(tCommodity.getTotalPrice())+"";
					value[4] =nf.format(tCommodity.getSuspendPrice())+"";
					
					
			        totolMoney1+=tCommodity.getTotalTaxPrice();
			        
			        totolMoney2+=tCommodity.getTotalPrice();
			        
			        totolMoney3+=tCommodity.getSuspendPrice();
					dataList.add(value);
				}
				
				//dataList.add(arr);
				
			}
			totol1[0]="合计";
			totol1[1]="";
			totol1[2]=nf.format(totolMoney1)+"";
			totol1[3]=nf.format(totolMoney2)+"";
			totol1[4]=nf.format(totolMoney3)+"";
			dataList.add(totol1);
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 采购订单明细表 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportProcureOrderDetail(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		String fileName = "采购订单明细表-按供应商";//文档名称以及Excel里头部信息
		
		List<ProcureTable>	list=procureTableService.reportProcureOrderDetail(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		Double totalMoney4 = 0.0;
		String totol1[]=new String[20];
		String  supctoName="";
		String supctoIdentifier="";
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[18];
			title[0]="供应商";
			title[1]="单据编号";
			title[2]="单据日期";
			title[3]="到货日期";
			title[4]="货品编码";
			title[5]="货品名称";
			title[6]="规格";
			
			title[7]="单位";
 			title[8]="单价";
			title[9]="订货|金额";
			
			title[10]="已收货|数量";
			title[11]="已收货|金额";
			title[12]="中止|数量";
			title[13]="中止|金额";
			title[14]="未收货|数量";
			title[15]="未收货|金额";
			title[16]="占用库存";
			title[17]="备注";
			
			//保存要导出的内容
			for(ProcureTable c:list){
				
				value=new String[20];
				for (ProcureCommodity tCommodity : c.getProcureCommoditys()) {
					String isLargess=null;
					if (tCommodity.getIsLargess()==null||tCommodity.getIsLargess()==1) {
						isLargess="×";
					}else if (tCommodity.getIsLargess()==2) {
						isLargess="√";
					}
					if (c.getSupcto()==null) {
						supctoIdentifier="";
						supctoName="其他";
					}else {
						supctoIdentifier=c.getSupcto().getIdentifier();
						supctoName=c.getSupcto().getName();
					}
					if (tCommodity.getTotalTaxPrice()==null) {
						tCommodity.setTotalTaxPrice(0.0);
					}
					if (tCommodity.getSuspendPrice()==null) {
						tCommodity.setSuspendPrice(0.0);
					}
					if (tCommodity.getTotalPrice()==null) {
						tCommodity.setTotalPrice(0.0);
					}
					if (tCommodity.getArrivalMoney()==null) {
						tCommodity.setArrivalMoney(0.0);
					}
					if (tCommodity.getSuspendQuantity()==null) {
						tCommodity.setSuspendQuantity(0);
					}
					if (tCommodity.getSurplusMoney()==null) {
						tCommodity.setSurplusMoney(0.0);
					}
					if (tCommodity.getSurplusNum()==null) {
						tCommodity.setSurplusNum(0);
					}
					if (c.getSupcto()==null) {
						Supcto supcto=new Supcto();
						supcto.setName("");
						supcto.setIdentifier("");
						c.setSupcto(supcto);
					}
					value[0] = c.getSupcto().getName();
					value[1] = c.getIdentifier();
					value[2] = dateFormat.format(c.getGenerateDate());
					value[3] = c.getGoodsArrivalTime()!=null?dateFormat2.format(c.getGoodsArrivalTime()):"";
					value[4] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[5] =tCommodity.getCommoditySpecification().getCommodity().getName();
					value[6] =tCommodity.getCommoditySpecification().getSpecificationName();
					value[7] =tCommodity.getCommoditySpecification().getBaseUnitName();
 					
					value[8]=tCommodity.getBusinessUnitPrice()+"";
					value[9]=nf.format(tCommodity.getTotalTaxPrice())+"";
					value[10]=(tCommodity.getArrivalQuantity()==null?0:tCommodity.getArrivalQuantity())+"";
					value[11]=nf.format(tCommodity.getArrivalMoney())+"";
					value[12]=tCommodity.getSuspendQuantity()+"";
					value[13]=nf.format(tCommodity.getSuspendPrice())+"";
					value[14]=tCommodity.getSurplusNum()+"";
					value[15]=nf.format(tCommodity.getSurplusMoney())+"";
					value[15]=c.getInventory().getOccupiedInventory()+"";
					value[16]=tCommodity.getRemarks()==null?"":tCommodity.getRemarks();
					
			        totalMoney1+=tCommodity.getTotalTaxPrice();
			        
			        totalMoney2+=tCommodity.getArrivalMoney();
			        
			        totalMoney3+=tCommodity.getSuspendPrice();
			        
			        totalMoney4+=tCommodity.getSurplusMoney();
					
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
			totol1[0]="合计";
			totol1[1]="";
			totol1[2]="";
			totol1[3]="";
			totol1[4]="";
			totol1[5]="";
			totol1[6]="";
			totol1[7]="";
			totol1[8]="";
 			totol1[9]=nf.format(totalMoney1)+"";
			totol1[10]="";
			totol1[11]=nf.format(totalMoney2)+"";
			totol1[12]="";
			totol1[13]=nf.format(totalMoney3)+"";
			totol1[14]="";
			totol1[15]=nf.format(totalMoney4)+"";
			totol1[16]="";
			dataList.add(totol1);
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 采购计划单汇总表（按供应商）
	 * 
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportProcurePlanOrderGether(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");

		String fileName = "采购计划单汇总表-公司计划";//文档名称以及Excel里头部信息
		List<ProcureTable>	list=procureTableService.reportProcurePlanOrderGether(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		String  supctoName="";
		String supctoIdentifier="";
		String arriveTime="";
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[5];
			title[0]="供应商编码";
			title[1]="供应商名称";
			title[2]="计划单号";
			title[3]="计划金额";
			title[4]="到货日期";
			
			
			//保存要导出的内容
			Double totolMoney1=0.0;
			String totol1[]=new String[8];
			for(ProcureTable  c:list){
				value=new String[8];
				
				for (ProcureCommodity tCommodity : c.getProcureCommoditys()) {
					if (c.getGoodsArrivalTime()==null) {
						//c.setGoodsArrivalTime(new Date());
						arriveTime="";
					}else {
						arriveTime=dateFormat2.format(c.getGoodsArrivalTime());
					}
					
					if (c.getSupcto()==null) {
						supctoIdentifier="";
						supctoName="";
					}else {
						supctoIdentifier=c.getSupcto().getIdentifier();
						supctoName=c.getSupcto().getName();
					}
					if (tCommodity.getTotalTaxPrice()==null) {
						tCommodity.setTotalTaxPrice(0.0);
					}
					if (tCommodity.getSuspendPrice()==null) {
						tCommodity.setSuspendPrice(0.0);
					}
					if (tCommodity.getTotalPrice()==null) {
						tCommodity.setTotalPrice(0.0);
					}
					value[0] =supctoIdentifier;
					
					value[1] =supctoName;
					value[2] =c.getIdentifier();
					value[3] =nf.format(tCommodity.getTotalTaxPrice())+"";
					value[4] =arriveTime;
					
					
					

			        totolMoney1+=tCommodity.getTotalTaxPrice();
					
				
					dataList.add(value);
				}
				
				//dataList.add(arr);
				
			}
			totol1[0]="合计";
			totol1[1]="";
			totol1[2]="";
			totol1[3]=nf.format(totolMoney1)+"";
			totol1[4]="";
			dataList.add(totol1);
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 采购计划单明细表 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportProcurePlanOrderDetail(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		String fileName = "采购计划单明细表-公司计划";//文档名称以及Excel里头部信息
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		List<ProcureTable>	list=procureTableService.reportProcurePlanOrderDetail(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		Double totalMoney1 = 0.0;
		String  supctoName="";
		String supctoIdentifier="";
		String totol1[]=new String[20];
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[13];
			title[0]="供应商";
			title[1]="单据编号";
			title[2]="单据日期";
			title[3]="到货日期";
			title[4]="货品编码";
			title[5]="货品名称";
			title[6]="规格";
			
			title[7]="单位";
			title[8]="单价";
			title[9]="计划数量";
			
			title[10]="计划金额";
			title[11]="占用库存";
			title[12]="备注";
			//保存要导出的内容
			for(ProcureTable c:list){
				
				value=new String[20];
				for (ProcureCommodity tCommodity : c.getProcureCommoditys()) {
					String isLargess=null;
					
					if (c.getSupcto()==null) {
						supctoIdentifier="";
						supctoName="";
					}else {
						supctoIdentifier=c.getSupcto().getIdentifier();
						supctoName=c.getSupcto().getName();
					}
					if (tCommodity.getTotalTaxPrice()==null) {
						tCommodity.setTotalTaxPrice(0.0);
					}
					if (tCommodity.getSuspendPrice()==null) {
						tCommodity.setSuspendPrice(0.0);
					}
					if (tCommodity.getTotalPrice()==null) {
						tCommodity.setTotalPrice(0.0);
					}
					if (tCommodity.getRemarks()==null) {
						tCommodity.setRemarks("");
					}
					value[0] = supctoName;
					value[1] = c.getIdentifier();
					
					value[2] = dateFormat.format(c.getGenerateDate());
					value[3] = c.getGoodsArrivalTime()!=null?dateFormat2.format(c.getGoodsArrivalTime()):"";
					value[4] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[5] =tCommodity.getCommoditySpecification().getCommodity().getName();
					value[6] =tCommodity.getCommoditySpecification().getSpecificationName();
					value[7] =tCommodity.getCommoditySpecification().getBaseUnitName();
					
					value[8]=tCommodity.getBusinessUnitPrice()+"";
					value[9]=tCommodity.getOrderNum()+"";
					value[10]=nf.format(tCommodity.getTotalPrice())+"";
					value[11]=c.getInventory().getOccupiedInventory()+"";
					value[12]=tCommodity.getRemarks();
					
					
					
			        totalMoney1+=tCommodity.getTotalPrice();
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
			totol1[0]="合计";
			totol1[1]="";
			totol1[2]="";
			totol1[3]="";
			totol1[4]="";
			totol1[5]="";
			totol1[6]="";
			totol1[7]="";
			totol1[8]="";
			totol1[9]="";
			totol1[10]=nf.format(totalMoney1)+"";
			totol1[11]="";
			
			dataList.add(totol1);
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 采购开单汇总表/明细表（按供应商）
	 * 
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportProcureFinishOrderDetailOrGether(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr,Integer type) throws Exception{
		params.put("type", type);
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName=null;
		if (type==1) {
			fileName = "采购开单汇总表-按供应商";//文档名称以及Excel里头部信息
		}else {
			fileName = "采购开单明细表-按供应商";
		}
		 
		List<ProcureTable>	list=procureTableService.reportProcureFinishOrderDetailOrGether(params);
		List<String[]> dataList=new ArrayList<>();
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		Double totalMoney4 = 0.0;
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			
			//需导出的表头与信息
			if (type==1) {
				title=new String[8];
				//保存Excel表头
				title[0]="供应商编码";
				title[1]="供应商名称";
				title[2]="采购货款";
				title[3]="进项税额";
				title[4]="金额";
				title[5]="采购费用";
				title[6]="退货货款(含税)";
				
			}else {
				title=new String[21];
				title[0]="分支机构";
				title[1]="供应商";
				title[2]="单据类型";
				title[3]="单据编号";
				title[4]="单据日期";
				title[5]="货品编码";
				title[6]="货品名称";
				title[7]="规格";
				title[8]="单位";
				title[9]="单价";
				title[10]="数量";
				title[11]="采购货款";
				title[12]="进项税额";
				title[13]="金额";
				title[14]="备注";
				title[15]="折扣率";
				title[16]="占用库存";
				title[17]="采购费用";
				title[18]="费后单价";
				
			}
			
			
			
			
			
			//保存要导出的内容
			
			String totol1[]=new String[21];
			for(ProcureTable  c:list){
				value=new String[21];
				if (c.getSupcto()==null) {
					Supcto supcto=new Supcto();
					supcto.setIdentifier("");
					supcto.setName("其他");
					c.setSupcto(supcto);
				}
				
				for (ProcureCommodity tCommodity : c.getProcureCommoditys()) {
					if (tCommodity.getAmountOfTax()==null) {
						tCommodity.setAmountOfTax(0.0);
					}
					if (type==1) {
						value[0] = c.getSupcto().getIdentifier();
						
						value[1] =c.getSupcto().getName();
						value[2] =nf.format(tCommodity.getArrivalMoney()==null?0.0:tCommodity.getArrivalMoney())+"";
						value[3] =nf.format(tCommodity.getAmountOfTax()==null?0.0:tCommodity.getAmountOfTax())+"";
						value[4] =nf.format((tCommodity.getArrivalMoney()==null?0.0:tCommodity.getArrivalMoney())+(tCommodity.getAmountOfTax()==null?0.0:tCommodity.getAmountOfTax())-c.getReturnMoney())+"";
						value[5] ="0";
						value[6] =c.getReturnMoney()+"";
						value[7] ="0";
				        totalMoney1+=tCommodity.getArrivalMoney()==null?0.0:tCommodity.getArrivalMoney();
				        
				        totalMoney2+=tCommodity.getAmountOfTax()==null?0.0:tCommodity.getAmountOfTax();
				        
				        totalMoney3+=(tCommodity.getArrivalMoney()==null?0.0:tCommodity.getArrivalMoney())+(tCommodity.getAmountOfTax()==null?0.0:tCommodity.getAmountOfTax())-c.getReturnMoney();
						totalMoney4+=c.getReturnMoney();
						dataList.add(value);
					}else {
						value[0] = "总部";
						value[1] = c.getSupcto().getName();
						value[2] = "采购开单";
						value[3] = c.getIdentifier();
						value[4] = dateFormat.format(c.getGenerateDate());
						value[5] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
						value[6] =tCommodity.getCommoditySpecification().getCommodity().getName();
						value[7] =tCommodity.getCommoditySpecification().getSpecificationName();
						value[8] =tCommodity.getCommoditySpecification().getBaseUnitName();
						
						value[9]=tCommodity.getBusinessUnitPrice()+"";
						value[10]=tCommodity.getArrivalQuantity()+"";
						value[11]=nf.format(tCommodity.getArrivalMoney())+"";
						value[12]=nf.format(tCommodity.getAmountOfTax())+"";
						value[13]=nf.format(tCommodity.getArrivalMoney()+tCommodity.getAmountOfTax())+"";
						value[14]=tCommodity.getRemarks()==null?"":tCommodity.getRemarks();
						value[15]=tCommodity.getDiscount()==null?"":tCommodity.getDiscount()+"";
						value[16]=c.getInventory().getOccupiedInventory()+"";
						value[17]="0";
						value[18]=tCommodity.getOriginalUnitPrice()+"";
						
				        totalMoney1+=tCommodity.getOrderNum();
				        
				        totalMoney2+=tCommodity.getArrivalMoney();
				        
				        totalMoney3+=tCommodity.getAmountOfTax();
				        
				        totalMoney4+=tCommodity.getArrivalMoney()+tCommodity.getAmountOfTax();
				        
						
						dataList.add(value);
					}
					
				}
				
				//dataList.add(arr);
				
			}
			if (type==2) {
				
				params.put("type2", 2);
				List<ProcureTable>	list2=procureTableService.reportProcureReturnOrderDetail(params);
				for (ProcureTable c : list2) {
					value=new String[21];
					for (ProcureCommodity tCommodity : c.getProcureCommoditys()) {
						value[0] = "总部";
						value[1] = c.getSupcto().getName();
						value[2] = "采购退货";
						value[3] = c.getIdentifier();
						value[4] = dateFormat.format(c.getGenerateDate());
						value[5] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
						value[6] =tCommodity.getCommoditySpecification().getCommodity().getName();
						value[7] =tCommodity.getCommoditySpecification().getSpecificationName();
						value[8] =tCommodity.getCommoditySpecification().getBaseUnitName();
						
						value[9]=tCommodity.getBusinessUnitPrice()+"";
						value[10]="-"+tCommodity.getArrivalQuantity()+"";
						value[11]="-"+nf.format(tCommodity.getArrivalQuantity()*tCommodity.getBusinessUnitPrice())+"";
						value[12]=nf.format(tCommodity.getArrivalQuantity()*tCommodity.getBusinessUnitPrice()*tCommodity.getTaxRate())+"";
						value[13]="-"+nf.format(tCommodity.getArrivalQuantity()*tCommodity.getBusinessUnitPrice())+"";
						value[14]=tCommodity.getRemarks()==null?"":tCommodity.getRemarks();
						value[15]=tCommodity.getDiscount()==null?"":tCommodity.getDiscount()+"";
						value[16]=c.getInventory().getOccupiedInventory()+"";
						value[17]="0";
						value[18]=tCommodity.getOriginalUnitPrice()+"";
						
				        totalMoney1-=tCommodity.getArrivalQuantity();
				        
				        totalMoney2-=tCommodity.getArrivalQuantity()*tCommodity.getBusinessUnitPrice();
				        
				        totalMoney3-=tCommodity.getArrivalQuantity()*tCommodity.getBusinessUnitPrice()*tCommodity.getTaxRate();
				        
				        totalMoney4-=tCommodity.getArrivalQuantity()*tCommodity.getBusinessUnitPrice();
				        
						
						dataList.add(value);
					}
				}
			}
			if (type==1) {
				totol1[0]="合计";
				totol1[1]="";
				totol1[2]=nf.format(totalMoney1)+"";
				totol1[3]=nf.format(totalMoney2)+"";
				totol1[4]=nf.format(totalMoney3)+"";
				totol1[5]="";
				totol1[6]=nf.format(totalMoney4)+"";
				totol1[7]="";
				dataList.add(totol1);
			}else {
				totol1[0]="合计";
				totol1[1]="";
				totol1[2]="";
				totol1[3]="";
				totol1[4]="";
				totol1[5]="";
				totol1[6]="";
				totol1[7]="";
				totol1[8]="";
				totol1[9]="";
				totol1[10]=nf.format(totalMoney1)+"";
				totol1[11]=nf.format(totalMoney2)+"";
				totol1[12]=nf.format(totalMoney3)+"";
				totol1[13]=nf.format(totalMoney4)+"";
				totol1[14]="";
				totol1[15]="";
				dataList.add(totol1);
			}
			
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 货品销售日报表 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportSalesDayDetais(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "货品销售日报表";// 文档名称以及Excel里头部信息
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<SalesOrder> list = salesOrderService.reportSalesDayDetais(params);
		List<SalesOrderCommodity> list2 = salesOrderCommodityService.reportSalesCommodityDatil(params);
		List<String[]> dataList = new ArrayList<>();
		String[] title; // 保存Excel表头
		String[] value; // 保存要导出的内容
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		
		Integer index = 8;
		Date start = sdf.parse(arr[0]);
		Date end = sdf.parse(arr[1]);
		List<Date> lists = CommonMethod.dateSplit(start, end);
		String totol1[] = new String[60];
		// 每天的合计数量
		Integer dataNum[] = new Integer[60];
		// 每天的合计金额
		Double dataMoney[] = new Double[60];
		// 搜索的有数据
		if (list.size() > 0) {
			// 需导出的表头与信息
			// 保存Excel表头
			title = new String[60];
			title[0] = "货品编码";
			title[1] = "货品名称";
			title[2] = "规格";
			title[3] = "品牌";
			title[4] = "单位";
			title[5] = "合计|数量";

			title[6] = "合计|金额";
			title[7] = "占用库存";
			try {
				Collections.sort(lists);
				if (!lists.isEmpty()) {
					for (Date date : lists) {
						// System.out.println(sdf.format(date));
						title[index] = sdf.format(date) + "|数量|金额";
						dataNum[index] = 0;
						dataMoney[index] = 0.0;
						index++;
					}
				}
			} catch (Exception e) {
			}
			// 保存要导出的内容

			for (SalesOrder c : list) {
				Integer totalNum = 0;
				Double Tmoney = 0.0;
				value = new String[60];
				
				for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {

					totalNum = tCommodity.getReceivingGoodsNum();
					Tmoney = tCommodity.getReceivingGoodsMoney();

					value[0] = tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[1] = tCommodity.getCommoditySpecification().getCommodity().getName();
					value[2] = tCommodity.getCommoditySpecification().getSpecificationName();
					value[3] = tCommodity.getCommoditySpecification().getCommodity().getBrand();
					value[4] = tCommodity.getCommoditySpecification().getBaseUnitName();
					try {
						for (int i = 8; index < title.length; i++) {
							Integer num = 0;
							Double money = 0.0;
							for (int j = 0; j < list2.size(); j++) {
								SalesOrderCommodity tCommodity2 = list2.get(j);
								if (title[i].contains(sdf.format(tCommodity2.getCreateTT()))) {
									if (tCommodity2.getCommoditySpecification().getId()
											.equals(tCommodity.getCommoditySpecification().getId())) {

										num += tCommodity2.getReceivingGoodsNum();
										money += tCommodity2.getReceivingGoodsMoney();

									} else {
										value[i] = "0";
									}

								}

							}

							value[i] = num + "|" + nf.format(money);
							dataNum[i] += num;
							dataMoney[i] += money;
						}
					} catch (Exception e) {
						// TODO: handle exception
					}
				}
				value[5] = totalNum + "";
				value[6] = Tmoney + "";
				value[7] = c.getInventory().getOccupiedInventory()+"";
				totalMoney1 += totalNum;
				totalMoney2 += Tmoney;
				dataList.add(value);
			}
			totol1[0] = "合计";
			totol1[1] = "";
			totol1[2] = "";
			totol1[3] = "";
			totol1[4] = "";
			totol1[5] = totalMoney1 + "";
			totol1[6] = nf.format(totalMoney2) + "";
			// 每日的数量金额合计
			for (int j = 8; j < lists.size() + 8; j++) {
				totol1[j] = dataNum[j] + "|" + nf.format(dataMoney[j]);
			}
			
			dataList.add(totol1);
		}

		// 没有搜索到数据
		else {
			title = new String[1];
			title[0] = Constants.NO_DATA_EXPORT;// 无数据提示
		}
		// 调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName, title, dataList, arr[0], arr[1]);
		return true;
	}
	/**
	 * 入库单汇总表/明细表-按供应商
	 * 
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportImportOrderDetailOrGether(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr,Integer type) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		params.put("type", type);
		
		String fileName=null;
		if (type==1) {
			fileName = "入库单汇总表";//文档名称以及Excel里头部信息
		}else {
			fileName = "入库单明细表";
		}
		 
		List<ProcureTable>	list=procureTableService.reportImportOrderDetailOrGether(params);
		List<SalesOrder>    list2=salesOrderService.reportReturnGoodsMsg(params);
		List<String[]> dataList=new ArrayList<>();
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double returnMoney = 0.0;
		Integer returnNum = 0;
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0||list2.size()>0){
			
			//需导出的表头与信息
			if (type==1) {
				title=new String[9];
				//保存Excel表头
				title[0]="货品编码";
				title[1]="货品名称";
				title[2]="规格";
				title[3]="品牌";
				title[4]="单位";
				title[5]="仓库";
				title[6]="数量";
				title[7]="金额";
				title[8]="占用库存";
			}else {
				title=new String[13];
				title[0]="单据编号";
				title[1]="单据名称";
				title[2]="货品编码";
				title[3]="货品名称";
				title[4]="品牌";
				title[5]="开单日期";
				title[6]="单位";
				title[7]="数量";
				title[8]="单价";
				title[9]="金额";
				title[10]="备注";
				title[11]="批号";
				title[12]="占用库存";
			}
			
			
			
			
			
			//保存要导出的内容
			
			String totol1[]=new String[20];
			for(ProcureTable  c:list){
				value=new String[20];
				
				for (ProcureCommodity tCommodity : c.getProcureCommoditys()) {
					if (type==1) {
						if (tCommodity.getTotalTaxPrice()==null) {
							tCommodity.setTotalTaxPrice(0.0);
						}
//						for(SalesOrder so: list2) {
//							for (SalesOrderCommodity soc : so.getSalesOrderCommodities()) {
//								if (tCommodity.getCommoditySpecification().getId().equals(soc.getCommoditySpecification().getId())) {
//									returnNum=soc.getReturnGoodsNum();
//									returnMoney=soc.getDeliverGoodsMoney();
//								}
//							}
//						}
						boolean isHas=false;
						Integer num=null;
						Double money=0.0;
						for(int j=0;j<list2.size();j++) {
							SalesOrder so=list2.get(j);
							for (int i = 0; i < so.getSalesOrderCommodities().size(); i++) {
								SalesOrderCommodity soc=so.getSalesOrderCommodities().get(i);
								if (tCommodity.getCommoditySpecification().getId().equals(soc.getCommoditySpecification().getId())) {
									isHas=true;
									num=soc.getReturnGoodsNum()+tCommodity.getOrderNum();
									money=(tCommodity.getTotalTaxPrice()==null?0.0:tCommodity.getTotalTaxPrice())+(soc.getDeliverGoodsMoney()==null?0.0:soc.getDeliverGoodsMoney());
									so.getSalesOrderCommodities().remove(i);
									value[0] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
									value[1] =tCommodity.getCommoditySpecification().getCommodity().getName();
									value[2] =tCommodity.getCommoditySpecification().getSpecificationName();
									value[3] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
									value[4] =tCommodity.getCommoditySpecification().getBaseUnitName();
									value[5] =tCommodity.getCommoditySpecification().getSpecWarehouseName()==null?"":tCommodity.getCommoditySpecification().getSpecWarehouseName();
									value[6] =num==null?"0":num+"";
									value[7] =nf.format(money)+"";
									value[8] =c.getInventory().getOccupiedInventory()+"";
									
							        totalMoney1+=money;
									dataList.add(value);
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
							num=tCommodity.getOrderNum();
							money=tCommodity.getTotalTaxPrice()==null?0.0:tCommodity.getTotalTaxPrice();
							value[0] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
							value[1] =tCommodity.getCommoditySpecification().getCommodity().getName();
							value[2] =tCommodity.getCommoditySpecification().getSpecificationName();
							value[3] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
							value[4] =tCommodity.getCommoditySpecification().getBaseUnitName();
							value[5] =tCommodity.getCommoditySpecification().getSpecWarehouseName()==null?"":tCommodity.getCommoditySpecification().getSpecWarehouseName();
							value[6] =num==null?"0":num+"";
							value[7] =nf.format(money)+"";
							value[8] =c.getInventory().getOccupiedInventory()+"";
							
					        totalMoney1+=money;
							dataList.add(value);
						}
						
						
					}else {
						if (tCommodity.getTotalTaxPrice()==null) {
							tCommodity.setTotalTaxPrice(0.0);
						}
						if (tCommodity.getRemarks()==null) {
							tCommodity.setRemarks("");
						}
						if (tCommodity.getLotNumber()==null) {
							tCommodity.setLotNumber("");
						}
						
						value[0] =c.getIdentifier();
						value[1] ="入库单";
						value[2] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
						value[3] =tCommodity.getCommoditySpecification().getCommodity().getName();
						value[4] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
						value[5] =dateFormat.format(c.getGenerateDate());
						value[6] =tCommodity.getCommoditySpecification().getBaseUnitName();
						value[7] =tCommodity.getOrderNum()==null?"0":tCommodity.getOrderNum()+"";
						value[8] =tCommodity.getBusinessUnitPrice()+"";
						value[9] =nf.format(tCommodity.getTotalTaxPrice())+"";
						value[10] =tCommodity.getRemarks();
						value[11] =tCommodity.getLotNumber();
						value[12] =c.getInventory().getOccupiedInventory()+"";
						dataList.add(value);
					}
					
				}
				
				//dataList.add(arr);
				
			}
			
				for (SalesOrder so : list2) {
					value=new String[20];
						for (SalesOrderCommodity soc : so.getSalesOrderCommodities()) {
							if (type==1) {
								String num=soc.getReturnGoodsNum()+"";
								Double money=soc.getDeliverGoodsMoney()==null?0.0:soc.getDeliverGoodsMoney();
								value[0] =soc.getCommoditySpecification().getSpecificationIdentifier();
								value[1] =soc.getCommoditySpecification().getCommodity().getName();
								value[2] =soc.getCommoditySpecification().getSpecificationName();
								value[3] =soc.getCommoditySpecification().getCommodity().getBrand();
								value[4] =soc.getCommoditySpecification().getBaseUnitName();
								value[5] =soc.getWarehouse().getName()==null?"":soc.getWarehouse().getName();
								value[6] =num==null?"0":num+"";
								value[7] =nf.format(money)+"";
								value[8] =so.getInventory().getOccupiedInventory()+"";
						        totalMoney1+=money;
						        dataList.add(value);
							}else {
							if (soc.getRemark()==null) {
								soc.setRemark("");
							}
							if (soc.getBatchNumber()==null) {
								soc.setBatchNumber("");
							}
							
							value[0] =so.getIdentifier();
							value[1] ="销售退货";
							value[2] =soc.getCommoditySpecification().getSpecificationIdentifier();
							value[3] =soc.getCommoditySpecification().getCommodity().getName();
							value[4] =soc.getCommoditySpecification().getCommodity().getBrand();
							value[5] =dateFormat.format(so.getCreateTime());
							value[6] =soc.getCommoditySpecification().getBaseUnitName();
							value[7] =soc.getReturnGoodsNum()==null?"0":soc.getReturnGoodsNum()+"";
							value[8] =soc.getUnitPrice()+"";
							value[9] =nf.format(soc.getDeliverGoodsMoney())+"";
							value[10] =soc.getRemark();
							value[11] =soc.getBatchNumber();
							value[12] =so.getInventory().getOccupiedInventory()+"";
							dataList.add(value);
						}
					}
				
			}
			if (type==1) {
				totol1[0]="合计";
				totol1[1]="";
				totol1[2]="";
				totol1[3]="";
				totol1[5]="";
				totol1[6]="";
				totol1[7]=nf.format(totalMoney1)+"";
				
				dataList.add(totol1);
			}else {

			}
			
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 销售毛利汇总表-按客户 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportProfitGether(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		String fileName = "销售毛利汇总表-按客户";//文档名称以及Excel里头部信息
		
		List<SalesOrder>	list=salesOrderService.reportProfitGether(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;
		Double totalMoney4 = 0.0;
		
		String totol1[]=new String[20];
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[8];
			title[0]="客户编号";
			title[1]="客户名称";
			title[2]="销售收入";
			title[3]="销售成本";
			title[4]="销售毛利";
			title[5]="销售毛利率";
//			title[6]="地区";
//			
//			title[7]="部门";
			
			
			//保存要导出的内容
			for(SalesOrder c:list){
				
				value=new String[20];
				for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
					if (c.getSupcto().getDepartment()==null) {
						Department department=new Department();
						department.setName("");
						c.getSupcto().setDepartment(department);
					}
					if (c.getSupcto().getName()==null) {
						c.getSupcto().setName("");
						c.getSupcto().setIdentifier("");
						c.getSupcto().setProvince("");
						c.getSupcto().setCity("");
						c.getSupcto().setArea("");
					}
					//销售成本
					Double vDouble=tCommodity.getDeliverGoodsMoney()-c.getReturnMoney();
					
					//销售毛利率
					Double vDouble2=((tCommodity.getReceivingGoodsMoney()-vDouble-c.getReturnMoney())/(tCommodity.getReceivingGoodsMoney()-c.getReturnMoney())*100);
					
					value[0] = c.getSupcto().getIdentifier();
					value[1] = c.getSupcto().getName();
					value[2] = nf.format(tCommodity.getReceivingGoodsMoney()-c.getReturnMoney())+"";
					value[3] = nf.format(vDouble)+"";
					value[4] =nf.format(tCommodity.getReceivingGoodsMoney()-vDouble-c.getReturnMoney())+"";
					value[5] =nf.format(vDouble2)+"%";
//					value[6] =c.getSupcto().getProvince()+" "+c.getSupcto().getCity()+" "+c.getSupcto().getArea();
//					value[7] =c.getSupcto().getDepartment().getName();
					
		
			        totalMoney1+=tCommodity.getReceivingGoodsMoney();
			        
			        totalMoney2+=vDouble;
			        
			        
			        totalMoney3+=tCommodity.getReceivingGoodsMoney()-vDouble;
			        
			        totalMoney4+=vDouble2;
					
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
			totol1[0]="合计";
			totol1[1]="";
			totol1[2]=nf.format(totalMoney1)+"";
			totol1[3]=nf.format(totalMoney2)+"";
			totol1[4]=nf.format(totalMoney3)+"";
			totol1[5]=nf.format(totalMoney4)+"";
//			totol1[6]="";
//			totol1[7]="";
			
			dataList.add(totol1);
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 销售毛利明细表 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportProfitDetail(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		String fileName = "销售毛利明细表";//文档名称以及Excel里头部信息
		
		List<SalesOrder>	list=salesOrderService.reportProfitDetail(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		Double returnMoney=null;
		String totol1[]=new String[20];
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[21];
			title[0]="分支机构";
			title[1]="单据编号";
			title[2]="单据日期";
			title[3]="货品编码";
			title[4]="规格";
			title[5]="单位";
			title[6]="客户编号";
			title[7]="客户名称";
			title[8]="销售单价";
			title[9]="成本单价";
			title[10]="销售数量";
			title[11]="销售收入";
			title[12]="销售成本";
			title[13]="销售毛利";
			title[14]="销售毛利率";
			title[15]="备注";
			title[16]="业务员";
			title[17]="地区";
			title[18]="部门";
			title[19]="退货数量";
			title[20]="退货金额";
			
			//保存要导出的内容
			for(SalesOrder c:list){
				
				value=new String[21];
				for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
					if (c.getSupcto().getDepartment()==null) {
						Department department=new Department();
						department.setName("");
						c.getSupcto().setDepartment(department);
					}
					if (c.getPerson()==null) {
						Person person =new Person();
						person.setName("");
						c.setPerson(person);
					}
					if (c.getSupcto().getName()==null) {
						c.getSupcto().setName("");
						c.getSupcto().setIdentifier("");
						c.getSupcto().setProvince("");
						c.getSupcto().setCity("");
						c.getSupcto().setArea("");
					}
					//销售成本
					Double vDouble=(tCommodity.getReceivingGoodsNum()-tCommodity.getReturnGoodsNum())*tCommodity.getCommoditySpecification().getUnits().get(0).getMiniPrice();
					//退货金额
					returnMoney=tCommodity.getReturnGoodsNum()*tCommodity.getUnitPrice();
					//销售毛利率
					Double vDouble2=(((tCommodity.getReceivingGoodsMoney()-vDouble-returnMoney)/(tCommodity.getReceivingGoodsMoney()-returnMoney))*100);
					
					value[0] ="总部";
					value[1] = c.getIdentifier();
					value[2] = dateFormat.format(c.getCreateTime());
					value[3] = tCommodity.getCommoditySpecification().getCommodity().getName();
					value[4] = tCommodity.getCommoditySpecification().getSpecificationName();
					value[5] = tCommodity.getCommoditySpecification().getBaseUnitName();
					value[6] = c.getSupcto().getIdentifier();
					value[7] = c.getSupcto().getName();
					value[8] =nf.format(tCommodity.getOldUnitPrice())+"";
					value[9] = tCommodity.getCommoditySpecification().getUnits().get(0).getMiniPrice()+"";
					value[10] = tCommodity.getReceivingGoodsNum()-tCommodity.getReturnGoodsNum()+"";
					
					value[11] = nf.format(tCommodity.getReceivingGoodsMoney()-returnMoney)+"";
					value[12] = nf.format(vDouble)+"";
					value[13] = nf.format(tCommodity.getReceivingGoodsMoney()-vDouble)+"";
					value[14] = nf.format(vDouble2)+"%";
					value[15] =tCommodity.getRemark();
					value[16] =c.getPerson().getName();
					value[17] =c.getSupcto().getProvince()+" "+c.getSupcto().getCity()+" "+c.getSupcto().getArea();
					value[18] =c.getSupcto().getDepartment().getName();
					value[19] =tCommodity.getReturnGoodsNum()+"";
					value[20] =returnMoney+"";
			
					
					
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 销售开单收款情况一览表 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportSalesOpenReceiveMoney(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		String fileName = "销售开单收款情况一览表";//文档名称以及Excel里头部信息
		params.put("type", 1);
		List<SalesOrder>	list=salesOrderService.reportSalesOpenReceiveMoney(params);
		List<SalesOrder>	list2=salesOrderService.reportSalesOrderReturnDetail(params);
		//List<WriteOffSub>  list2=writeOffSubService.reportSalesOpenReceiveMoney(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		NumberFormat nf = NumberFormat.getNumberInstance();
		nf.setRoundingMode(RoundingMode.UP);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		
		String type;
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[12];
			title[0]="单据类型";
			title[1]="单据编号";
			title[2]="单位名称";
			title[3]="单据日期";
			title[4]="销售金额";
			title[5]="已结算金额";
			title[6]="未结算金额";
			title[7]="制单人";
			title[8]="审核人";
			title[9]="业务员";
			title[10]="部门";
			title[11]="摘要";
			
				
				for (SalesOrder sales : list) {
					value=new String[20];
					for (SalesOrderCommodity poto : sales.getSalesOrderCommodities()) {
						if (poto.getRemark()==null) {
							poto.setRemark("");
						}
						if (sales.getOrderType()==2) {
							type="销售开单";
						}else {
							type="销售退货";
						}
						if (sales.getDepartmentName()==null) {
							sales.setDepartmentName("");
						}
						if (sales.getSupcto().getName()==null) {
							sales.getSupcto().setName("");
						}
						Double writeOffSubMoney=0.0;
						
						value[0] =type;
						value[1] =sales.getIdentifier();
						value[2] =sales.getSupcto().getName();
						value[3] =dateFormat.format(sales.getCreateTime());
						value[4] =nf.format(poto.getDeliverGoodsMoney()+poto.getTaxesMoney());
						value[5] =nf.format(sales.getReturnMoney());
						value[6] =nf.format((poto.getDeliverGoodsMoney()+poto.getTaxesMoney())-(sales.getReturnMoney()));
						value[7] =sales.getOriginatorName();
						value[8] =sales.getReviewerName();
						value[9] =sales.getPerson().getName();
						value[10] =sales.getSupcto().getDepartment().getName();
						value[11] =sales.getSummary();
								
						dataList.add(value);
					}
					
				}
			
			
			
			
			
		}
		if(list2.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[12];
			title[0]="单据类型";
			title[1]="单据编号";
			title[2]="单位名称";
			title[3]="单据日期";
			title[4]="销售金额";
			title[5]="已结算金额";
			title[6]="未结算金额";
			title[7]="制单人";
			title[8]="审核人";
			title[9]="业务员";
			title[10]="部门";
			title[11]="摘要";
			
				
				for (SalesOrder sales : list2) {
					value=new String[20];
					for (SalesOrderCommodity poto : sales.getSalesOrderCommodities()) {
						if (poto.getRemark()==null) {
							poto.setRemark("");
						}
						
						if (sales.getDepartmentName()==null) {
							sales.setDepartmentName("");
						}
						if (sales.getSupcto().getName()==null) {
							sales.getSupcto().setName("");
						}
						
						
						value[0] ="销售退货";
						value[1] =sales.getIdentifier();
						value[2] =sales.getSupcto().getName();
						value[3] =dateFormat.format(sales.getCreateTime());
						value[4] ="-"+nf.format(sales.getReturnMoney());
						value[5] =nf.format(poto.getReceivingGoodsMoney());
						value[6] =nf.format(sales.getReturnMoney()-poto.getReceivingGoodsMoney());
						value[7] =sales.getOriginatorName();
						value[8] =sales.getReviewerName();
						value[9] =sales.getPerson().getName();
						value[10] =sales.getSupcto().getDepartment().getName();
						value[11] =sales.getSummary();
								
						dataList.add(value);
					}
					
				}
			
			
			
			
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//没有搜索到数据
//		else{
//			title=new String[1];
//			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
//		}
		
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 采购开单付款情况一览表 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportProcureFinishOrderPayMoneyDetail(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		params.put("type2", 1);
		String fileName = "采购开单付款情况一览表";//文档名称以及Excel里头部信息
		
		List<ProcureTable>	list=procureTableService.reportProcureFinishOrderPayMoneyDetail(params);
		List<ProcureTable>	list2=procureTableService.reportProcureReturnOrderDetail(params);
		//List<WriteOffSub>  list2=writeOffSubService.reportSalesOpenReceiveMoney(params);
		params.put("billsType", 2);
		//List<BillsSub> list3=billsSubService.reportActualMoneyMsg(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		Double money1=0.0;
		
		String type;
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[21];
			title[0]="单据类型";
			title[1]="单据编号";
			title[2]="供应商名称";
			title[3]="单据日期";
			title[4]="采购金额";
			title[5]="已结算金额";
			title[6]="未结算金额";
			title[7]="联系人";
			title[8]="联系电话";
			title[9]="部门";
			
			title[10]="分支机构";
			title[11]="结算方式";
			
			title[12]="运输方式";
			title[13]="整单折扣(%)";
			title[14]="送货地址";
			title[15]="传真";
			title[16]="制单人";
			title[17]="审核人";
			title[18]="摘要";
			
			
			if (list.size()!=0) {
				for (ProcureTable sales : list) {
					for (ProcureCommodity poto : sales.getProcureCommoditys()) {
						value=new String[30];
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
						
						
						value[0]=type;
						value[1]=sales.getIdentifier();
						value[2]=sales.getSupcto().getName();
						value[3]=dateFormat.format(sales.getGenerateDate());
						value[4]=nf.format(poto.getTotalTaxPrice())+"";
								
								
						value[5]=nf.format(sales.getReturnMoney())+"";
						value[6]=nf.format(poto.getTotalTaxPrice()-sales.getReturnMoney())+"";
						value[7]=sales.getOrderer();
						value[8]=sales.getPhone();
					
						value[9]=sales.getDepartment().getName();
						
						value[10]="总部";
						value[11]=sales.getSettlementType().getName();
								
						value[12]=sales.getShippingMode().getName();
						value[13]=poto.getDiscount()+"";
						value[14]=sales.getGoodsArrivalPlace();
						value[15]=sales.getFax();
						value[16]=sales.getOriginator();
						value[17]=sales.getReviewer();
						value[18]=sales.getSummary();
						
						
						
						
						
						dataList.add(value);
					}
					
					
				}
				
				

			}
			if (list2.size()!=0) {
				for (ProcureTable sales : list2) {
					for (ProcureCommodity poto : sales.getProcureCommoditys()) {
						value=new String[30];
						
						
						
						value[0]="采购退货";
						value[1]=sales.getIdentifier();
						value[2]=sales.getSupcto().getName();
						value[3]=dateFormat.format(sales.getGenerateDate());
						value[4]=nf.format(-poto.getArrivalMoney())+"";
								
								
						value[5]=nf.format(sales.getReturnMoney())+"";
						value[6]=nf.format(poto.getArrivalMoney()-sales.getReturnMoney())+"";
						value[7]=sales.getOrderer();
						value[8]=sales.getPhone();
					
						value[9]=sales.getDepartment().getName();
						
						value[10]="总部";
						value[11]=sales.getSettlementType().getName();
								
						value[12]=sales.getShippingMode().getName();
						value[13]=poto.getDiscount()+"";
						value[14]=sales.getGoodsArrivalPlace();
						value[15]=sales.getFax();
						value[16]=sales.getOriginator();
						value[17]=sales.getReviewer();
						value[18]=poto.getRemarks();
						
						
						
						
						
						dataList.add(value);
					}
					
					
				}
				
				

			}
			
			
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 应收应付账款汇总表 导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportPayMoneyGether(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr,Integer orderType) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		String fileName=null;
		String[] title=null; //保存Excel表头
		String[] value=null; 
		List<Bills> resultMap=null;
		List<String[]> dataList=new ArrayList<>();
		String totol1[]=new String[20];
		Double totalMoney1 = 0.0;
		Double totalMoney2 = 0.0;
		Double totalMoney3 = 0.0;	
 		if(orderType==1) {
			  fileName = "应收帐款汇总表";//文档名称以及Excel里头部信息
			  resultMap=	billsService.reportPayOrderSales(params);
			  title =new String []{ "客户编号","客户名称", "本期增加应收款", "本期收款金额", "其中现金折扣"};

		}else {
			  fileName = "应付帐款汇总表";//文档名称以及Excel里头部信息
			resultMap=	billsService.reportPayOrderProcure(params);
			 title =new String []{ "供应商编号","供应商名称", "开单金额", "本次结算", "折扣金额"};
		}
		
 		//搜索的有数据
 		if (orderType==1) {
 			if(resultMap.size()>0){
 				for (Bills b : resultMap) {
 					for (BillsSub bs : b.getBillsSubs()) {
 						value=new String[30];
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
 						value[0]=b.getSupcto().getIdentifier()==null?"":b.getSupcto().getIdentifier();
 						value[1]=b.getSupcto().getName()==null?"":b.getSupcto().getName();
 						value[2]=b.getReceiveMoney()+b.getReturnMoney()+"";
 						
 						value[3]=bs.getTheMoeny()+"";
 						value[4]=bs.getRebateMoney()+"";
 						totalMoney1+=b.getReceiveMoney()+b.getReturnMoney();
 						totalMoney2+=bs.getTheMoeny();
 						totalMoney3+=bs.getRebateMoney();
 						
 						dataList.add(value);
 					}
 				}	
 				
 					totol1[0]="合计";
 					totol1[1]="";
 					totol1[2]=nf.format(totalMoney1)+"";
 					totol1[3]=nf.format(totalMoney2)+"";
 					totol1[4]=nf.format(totalMoney3)+"";
 					
 					dataList.add(totol1);
 				
 			}
 			//没有搜索到数据
 			else{
 				title=new String[1];
 				title[0]=Constants.NO_DATA_EXPORT;//无数据提示
 			}
		}else {
			if(resultMap.size()>0){
				for (Bills b : resultMap) {
					for (BillsSub bs : b.getBillsSubs()) {
						value=new String[30];
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
						value[0]=b.getSupcto().getIdentifier()==null?"":b.getSupcto().getIdentifier();
						value[1]=b.getSupcto().getName()==null?"":b.getSupcto().getName();
						value[2]=b.getReceiveMoney()+b.getReturnMoney()+"";
						
						value[3]=bs.getTheMoeny()+"";
						value[4]=bs.getRebateMoney()+"";
						totalMoney1+=b.getReceiveMoney()+b.getReturnMoney();
						totalMoney2+=bs.getTheMoeny();
						totalMoney3+=bs.getRebateMoney();
						
						dataList.add(value);
					}
				}	
				
					totol1[0]="合计";
					totol1[1]="";
					totol1[2]=nf.format(totalMoney1)+"";
					totol1[3]=nf.format(totalMoney2)+"";
					totol1[4]=nf.format(totalMoney3)+"";
					
					dataList.add(totol1);
				
			}
			//没有搜索到数据
			else{
				title=new String[1];
				title[0]=Constants.NO_DATA_EXPORT;//无数据提示
			}
		}
		
		
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 账面库存汇总表 -按商品
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportAccountsGether(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "账面库存汇总表";//文档名称以及Excel里头部信息
		
		List<CommoditySpecification>	list=commoditySpecificationService.reportAccountsGether(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		String totol1[]=new String[20];
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
		
		String type;
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[13];
			title[0]="仓库名称";
			title[1]="货品编码";
			title[2]="货品名称";
			title[3]="品牌";
			title[4]="货品规格";
			title[5]="单位";
			
			title[6]="收入|单价";
			title[7]="收入|数量";
			title[8]="收入|金额";
			title[9]="发出|单价";
			title[10]="发出|数量";
			title[11]="发出|金额";
			
			title[12]="占用库存";
			for (CommoditySpecification  pp : list) {
				value=new String[13];
				if (pp.getCommentPrice()==null) {
					pp.setCommentPrice(pp.getBaseMiniPrice());
				}
				if (pp.getOccupiedNum()==null) {
					pp.setOccupiedNum(0);
				}
				
				value[0]=pp.getSpecWarehouseName()==null?"":pp.getSpecWarehouseName();
				value[1]=pp.getSpecificationIdentifier();
				value[2]=pp.getCommodity().getName();
				value[3]=pp.getCommodity().getBrand();
				value[4]=pp.getSpecificationName();
				value[5]=pp.getBaseUnitName();
				value[6]=pp.getBaseMiniPrice()+"";
				value[7]=pp.getReceiveNum()+"";
				
				value[8]=nf.format(pp.getBaseMiniPrice()*pp.getReceiveNum())+"";
				value[9]=pp.getCommentPrice()+"";
				value[10]=pp.getSendNum()+"";
				
				
				value[11]=nf.format(pp.getCommentPrice()*pp.getSendNum())+""+"";
				value[12]=pp.getOccupiedNum()+"";
				totalMoney1+=pp.getBaseMiniPrice()*pp.getReceiveNum();
				totalMoney2+=pp.getCommentPrice()*pp.getSendNum();


				dataList.add(value);
				}
			
			totol1[0]="合计";
			totol1[1]="";
			totol1[2]="";
			totol1[3]="";
			totol1[4]="";
			totol1[5]="";
			totol1[6]="";
			totol1[7]="";
			totol1[8]=nf.format(totalMoney1)+"";
			totol1[9]="";
			totol1[10]="";
			totol1[11]=nf.format(totalMoney2)+"";
			totol1[12]="";
			
			
			dataList.add(totol1);
			
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 账面库存明细表 -按商品
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportAccountsDetail(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		String fileName = "账面库存明细表";//文档名称以及Excel里头部信息
		
		
		
		List<CommoditySpecification>	list=commoditySpecificationService.reportAccountsGether(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		String totol1[]=new String[20];
		
		Double dispathPrice=0.0;
		Integer dispathNum=0;
		Double dispathMoney=0.0;
		Double receiveMoney=0.0;
	 	
	 	Integer receiveNum=0;
	 	Double unitPrice=0.0;
	 	Double currentMoney=0.0;
	 	
	 	Integer currentNum=0;
	 	Double currentPrice=0.0;
		
		String type;
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息				
			//保存Excel表头
			title=new String[14];
			title[0]="分支机构";
			title[1]="仓库名称";
			title[2]="货品编码";
			title[3]="货品名称";
			
			title[4]="品牌";
			title[5]="货品规格";
			title[6]="单位";
			
			title[7]="收入|单价";
			title[8]="收入|数量";
			title[9]="收入|金额";
			title[10]="发出|单价";
			title[11]="发出|数量";
			title[12]="发出|金额";
			title[13]="占用库存";
			for (CommoditySpecification  pp : list) {
				if (pp.getCommentPrice()==null) {
					pp.setCommentPrice(pp.getBaseMiniPrice());
				}
				if (pp.getOccupiedNum()==null) {
					pp.setOccupiedNum(0);
				}
				value=new String[14];
				value[0]="总部";
				value[1]=pp.getSpecWarehouseName()==null?"":pp.getSpecWarehouseName();
				value[2]=pp.getSpecificationIdentifier();
				value[3]=pp.getCommodity().getName();
				value[4]=pp.getCommodity().getBrand();
				value[5]=pp.getSpecificationName();
				value[6]=pp.getBaseUnitName();
				value[7]=pp.getBaseMiniPrice()+"";
				value[8]=pp.getReceiveNum()+"";
				
				value[9]=nf.format(pp.getBaseMiniPrice()*pp.getReceiveNum())+"";
				value[10]=pp.getCommentPrice()+"";
				value[11]=pp.getSendNum()+"";
				
				
				value[12]=nf.format(pp.getCommentPrice()*pp.getSendNum())+""+"";
				value[13]=pp.getOccupiedNum()+"";
				


				dataList.add(value);
				}
			}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 盘点单明细表导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportOtherReceiveOrder(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		String fileName = "其他收货单明细";//文档名称以及Excel里头部信息
		List<ProcureTable>	list=procureTableService.reportOtherReceiveOrder(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[12];
			title[0]="单号";
			title[1]="货品编码";
			title[2]="货品名称";
			title[3]="品牌";
			
			title[4]="开单日期";
			
			title[5]="单位";
			title[6]="数量";
			title[7]="单价";
			title[8]="金额";
			title[9]="备注";
			title[10]="批号";
			title[11]="占用库存";
			//保存要导出的内容
			for(ProcureTable c:list){
				value=new String[15];
				
				for (ProcureCommodity tCommodity : c.getProcureCommoditys()) {
					
					value[0] = c.getIdentifier();
					value[1] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[2] =tCommodity.getCommoditySpecification().getCommodity().getName()+"("+tCommodity.getCommoditySpecification().getSpecificationName()+")";
					value[3] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
					value[4] =dateFormat.format(c.getGenerateDate());
					value[5]=tCommodity.getCommoditySpecification().getBaseUnitName();
					value[6]=tCommodity.getOrderNum()+"";
					value[7]=tCommodity.getBusinessUnitPrice()+"";
					value[8]=nf.format(tCommodity.getTotalTaxPrice())+"";
					value[9]=tCommodity.getRemarks();
					value[10]=tCommodity.getLotNumber();
					value[11]=c.getInventory().getOccupiedInventory()+"";
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
	/**
	 * 盘点单明细表导出
	 * @param 
	 * @return 
	 */
	@ResponseBody
	public boolean exportOtherDeliverOrder(HttpServletRequest request,HttpServletResponse response,Map<String, Object> params,String[] arr) throws Exception{
		nf.setRoundingMode(RoundingMode.HALF_DOWN);
		//保留两位小数
		nf.setMaximumFractionDigits(2); 
		
		String fileName = "其他发货单明细";//文档名称以及Excel里头部信息
		List<SalesOrder>	list=salesOrderService.reportOtherDeliverOrder(params);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(list.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[12];
			title[0]="单号";
			title[1]="货品编码";
			title[2]="货品名称";
			title[3]="品牌";
			
			title[4]="开单日期";
			
			title[5]="单位";
			title[6]="数量";
			title[7]="单价";
			title[8]="金额";
			title[9]="备注";
			title[10]="批号";
			title[11]="批号";
			//保存要导出的内容
			for(SalesOrder c:list){
				value=new String[15];
				
				for (SalesOrderCommodity tCommodity : c.getSalesOrderCommodities()) {
					
					value[0] = c.getIdentifier();
					value[1] =tCommodity.getCommoditySpecification().getSpecificationIdentifier();
					value[2] =tCommodity.getCommoditySpecification().getCommodity().getName()+"("+tCommodity.getCommoditySpecification().getSpecificationName()+")";
					value[3] =tCommodity.getCommoditySpecification().getCommodity().getBrand();
					value[4] =dateFormat.format(c.getCreateTime());
					value[5]=tCommodity.getCommoditySpecification().getBaseUnitName();
					value[6]=tCommodity.getDeliverGoodsNum()+"";
					value[7]=tCommodity.getUnitPrice()+"";
					value[8]=nf.format(tCommodity.getDeliverGoodsMoney())+"";
					value[9]=tCommodity.getRemark();
					value[10]=tCommodity.getBatchNumber();
					value[11]=c.getInventory().getOccupiedInventory()+"";
					dataList.add(value);
				}
				//dataList.add(arr);
				
			}
		}
		//没有搜索到数据
		else{
			title=new String[1];
			title[0]=Constants.NO_DATA_EXPORT;//无数据提示
		}
		//调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName,title, dataList,arr[0],arr[1]);
		return true;
	}
}
