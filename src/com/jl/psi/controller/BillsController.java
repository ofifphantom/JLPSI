package com.jl.psi.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.TTCCLayout;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.Bills;
import com.jl.psi.model.BillsSub;
import com.jl.psi.model.FormHeadAndFooter;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.Supcto;
import com.jl.psi.service.BillsService;
import com.jl.psi.service.BillsSubService;
import com.jl.psi.service.SupctoService;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 单据信息处理
 * @author guole
 *
 */
@Controller
@RequestMapping("/receivable/bills/")
public class BillsController extends BaseController{

	@Autowired
	private BillsService billsService;
	@Autowired
	private BillsSubService billsSubService;
	@Autowired
	private SupctoService supctoService;
	
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
		// 预收冲应收
		case 1:
			pageName = "junlin/jsp/receivable/accountReceivable";
			break;
		// 应付款单
		case 2:
			pageName = "junlin/jsp/receivable/payables";
			break;
		// 预收款单
		case 3:
			pageName = "junlin/jsp/receivable/advancesReceived";
			break;
		// 预付款单
		case 4:
			pageName = "junlin/jsp/receivable/prepaidBill";
			break;
	  
		default:
			break;
		}

		return pageName;

	}

	/**
	 * 单据信息 datatables分页
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="dataTables",method=RequestMethod.POST)
	public DataTables	dataTables(HttpServletRequest request,String billsType,String billsCode,Integer customerSupplierId,String dateSearch) {
 
		DataTables dataTables=  billsService.dataTables(DataTables.createDataTables(request),billsType,billsCode,customerSupplierId,dateSearch);
		return dataTables;
 	}
	/**
	 * 持久化单据信息
	 * @param request
	 * @param billsJson
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="saveBills",method=RequestMethod.POST)
	public JSONObject saveBills(HttpServletRequest request,String billsJson) throws Exception {
 
		JSONObject result=new JSONObject();
		
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(billsJson);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("billsSubs", BillsSub.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		Bills bills = (Bills) net.sf.json.JSONObject.toBean(jsonobject, Bills.class, map);
		//生成单据单号
 		String code="AC";
      if(bills.getBillsType()==2||bills.getBillsType()==4) {
    	  code="AP";
      }
      String maxCode=billsService.selectMaxCode(bills.getBillsType());
		String billsCode = SundryCodeUtil.createInvoicesIdentifier(code, maxCode);
		bills.setBillsCode(billsCode);
		bills.setBillsDate(new Date());
		bills.setBranch("总部");
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		bills.setOriginator(userIdentifier);
		//插入单据信息
		int count=billsService.insertSelective(bills);
		if(count>0) {
			
			Double money=	supctoService.selectByPrimaryKey(bills.getCustomerSupplierId()).getAdvanceMoney();
				money=money==null?0:money;
				DecimalFormat df = new DecimalFormat("#.##");

			if(bills.getBillsType()==3||bills.getBillsType()==4) {
				//如果是预收单，预付单 存入余额 
				supctoService.updateAdvanceMoney(bills.getCustomerSupplierId(),
						Double.parseDouble(df.format(money+bills.getMoney())));
			}else {
				//如果是应收单，应付单 消减余额 
				if(bills.getOrderType()==1){
					//开单
					supctoService.updateAdvanceMoney(bills.getCustomerSupplierId(),Double.parseDouble(df.format(money-bills.getMoney())));
				}else{
					//退货单
					supctoService.updateAdvanceMoney(bills.getCustomerSupplierId(),Double.parseDouble(df.format(money+bills.getMoney())));

				}
				

			}
			for (BillsSub sub :bills.getBillsSubs()) {
				sub.setBillsId(bills.getId());
			}
			//插入单据子信息
			billsSubService.insertBatch(bills.getBillsSubs());
		}
		result.put("success", true);
		result.put("msg", Constants.SAVE_SUCCESS_MSG);
		return result;
	}
	
	/**
	 * 获取单据子项列表
	 * @param supctoId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="subList",method=RequestMethod.POST)
	public JSONObject subList(Integer supctoId,Integer billsType) {
		JSONObject result = new JSONObject();
		result.put("success", false);
		try { 
			result = new JSONObject();
			List<BillsSub> subList=null;
			//1.收款单，2付款单，3，预收款单，4，预付款单
			
			switch(billsType) {
				case 1:
					subList=billsSubService.selectByOne(supctoId);
					break;
				case 2:
					subList=billsSubService.selectByTwo(supctoId);
					break;
				case 3:
					subList=billsSubService.selectByThree(supctoId);
					break;
				case 4:
					subList=billsSubService.selectByFour(supctoId);
					break;
			}
			
 
			
			result.put("subList", subList);
			result.put("success", true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	 
//	/**
//	 * 单据详情
//	 * @param supctoId
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value="detail",method=RequestMethod.POST)
//	public JSONObject detail(Integer billsId) {
//		JSONObject result = new JSONObject();
//		result.put("success", false);
//		try {
//			result = new JSONObject();
//			Bills bills=billsService.selectByPrimaryKey(billsId);
// 			List<BillsSub> subList=null;
//			Integer billsType=bills.getBillsType();
//			Integer orderType=bills.getOrderType();
//			String orderName="";
//			if(billsType==1&&orderType==1){
//				subList=billsSubService.selectSalesByBillsId(billsId);
//			}else if(billsType==1&&orderType==2){
//				subList=billsSubService(billsId);
//			}else if(billsType==2&&orderType==1){
//				subList=billsSubService.selectSalesByBillsId(billsId);
//			}else if(billsType==2&&orderType==2){
//				subList=billsSubService.selectSalesByBillsId(billsId);
//			}else if(billsType==3){
//				subList=billsSubService.selectSalesByBillsId(billsId);
//			}else if(billsType==4){
//				subList=billsSubService.selectProcureByBillsId(billsId);
//			}
//			if(billsType==1||billsType==3) {
//				  subList=billsSubService.selectSalesByBillsId(billsId);
//
//
//			}else {
//				  subList=billsSubService.selectProcureByBillsId(billsId);
//
//			}
//			
//			bills.setBillsSubs(subList);
//		
//			result.put("bills", bills);
//			result.put("success", true);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return result;
//	}
	
	/**
	 * 单据详情
	 * @param id
	 * @return
 */
	@ResponseBody
	@RequestMapping(value = "billsDetail", method = RequestMethod.POST)
	 public JSONObject billsDetail(Integer id) {
 
	 
 			Bills bills=billsService.selectByPrimaryKey(id);
 			Supcto supcto=supctoService.selectByPrimaryKey(bills.getCustomerSupplierId());
 			bills.setBalance(supcto!=null?(supcto.getAdvanceMoney()==null?0:supcto.getAdvanceMoney()):0);
 			List<BillsSub> subList=null;
			Integer billsType=bills.getBillsType();
			Integer orderType=bills.getOrderType();
 			if(billsType==1&&orderType==1){
				subList=billsSubService.selectSalesByBillsId(id);
			}else if(billsType==1&&orderType==2){
				subList=billsSubService.selectReturnSalesByBillsId(id);
			}else if(billsType==2&&orderType==1){
				subList=billsSubService.selectProcureByBillsId(id);
			}else if(billsType==2&&orderType==2){
				subList=billsSubService.selectReturnProcureByBillsId(id);
			}else if(billsType==3){
				subList=billsSubService.selectSalesByBillsId(id);
			}else if(billsType==4){
				subList=billsSubService.selectProcureByBillsId(id);
			}
			
			bills.setBillsSubs(subList);
	 
	 return createBillsDetail(bills);
	 }
	
	/**
	 * 生成详情 返回值为JSON格式
	 * 
	 * @param salesOrder
	 * @return
	 */
	private JSONObject createBillsDetail(Bills bills) {
		JSONObject outboundOrderJSON = new JSONObject();
		Integer billsType=bills.getBillsType();
		String title="";
		String typeName="";
		String balanceField="";
		if(billsType==1) {
			title="应收款";
 			  typeName="收";
		}else if(billsType==2) {
			title="应付款";
 			 typeName="付";
		}else if(billsType==3) {
			title="预收款";
 			 typeName="收";
		}else {
			title="预付款";
 			 typeName="付";
		}
		outboundOrderJSON.put("title", title);
 		outboundOrderJSON.put("date", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(bills.getBillsDate()));
		outboundOrderJSON.put("oddNumbers", bills.getBillsCode());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
 
	
 
		
		FormHeadAndFooter	head = new FormHeadAndFooter();
		head.setFieldName("往来单位");
		head.setFieldValue(bills.getCustomerSupplierName());
		heads.add(head);
	    
		head = new FormHeadAndFooter();
		head.setFieldName(typeName+"款类型");
		head.setFieldValue(title);
		heads.add(head);
		
	
		
		head = new FormHeadAndFooter();
		head.setFieldName("开户银行");
		head.setFieldValue(bills.getBank());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("银行账号");
		head.setFieldValue(bills.getBankAccount());
		heads.add(head);

		/* head end */
 
		JSONObject table=createTable(bills,typeName);
		outboundOrderJSON.put("table1", table.get("table1"));
		 outboundOrderJSON.put("table2", table.get("table2"));
		/* table end */
			head = new FormHeadAndFooter();
			head.setFieldName("预"+typeName+"金额");
			head.setFieldValue(table.getString("theMoenyTotal"));
			heads.add(head);
			outboundOrderJSON.put("head", heads);
		/* footer start */
		List<FormHeadAndFooter> footers = new ArrayList<>();
 
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
 		footer.setFieldValue(bills.getDepartmentName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(bills.getPersonName());
		footers.add(footer);
 
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		footer.setFieldValue(
				bills.getOriginatorName()!=null?(bills.getOriginator() + "(" + bills.getOriginatorName()+ ")"):bills.getOriginator()
		);
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(bills.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue(bills.getBranch());
		footers.add(footer);
		outboundOrderJSON.put("footer", footers);
		/* footer end */

		return outboundOrderJSON;
	}
	public JSONObject createTable(Bills bills,String typeName) {
		JSONObject tableJson=new JSONObject();
		Integer billsType=bills.getBillsType();
		Integer orderType=bills.getOrderType();
		String orderName="";
		if(billsType==1&&orderType==1){
			orderName="销售开单";
		}else if(billsType==1&&orderType==2){
			orderName="销售退货";
		}else if(billsType==2&&orderType==1){
			orderName="采购开单";
		}else if(billsType==2&&orderType==2){
			orderName="采购退货";
		}else if(billsType==3){
			orderName="销售开单";
		}else if(billsType==4){
			orderName="采购开单";
		}
		String[] theads = {};
	  
		List<String[]> tbodys = new ArrayList<>();
		String[] tbody= {};
		Double orderMoneyTotal=0.0;
		Double stayMoneyTotal=0.0;
		Double clearingMoneyTotal=0.0;
 		Double theMoenyTotal=0.0;
 		Double actualMoneyTotal=0.0;
 		Double rebateMoneyTotal=0.0;
		for (BillsSub bs : bills.getBillsSubs()) {
			DecimalFormat df = new DecimalFormat("#.##");
			//单据编号
			String identifier=bs.getIdentifier();
			//单据日期
			String  orderTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(bs.getOrderTime());
			//开单金额
			String  orderMoney=df.format(bs.getOrderMoney());
			//本次结算
			String theMoeny=bs.getTheMoeny().toString();
			String remark=bs.getRemark();
		
			theMoenyTotal=Double.parseDouble(df.format(theMoenyTotal+bs.getTheMoeny()));
			
			if(bills.getBillsType()==1||bills.getBillsType()==2) {
				orderMoneyTotal=Double.parseDouble(df.format(orderMoneyTotal+bs.getOrderMoney()));
				clearingMoneyTotal=Double.parseDouble(df.format(clearingMoneyTotal+bs.getClearingMoney()));
				stayMoneyTotal=Double.parseDouble(df.format(stayMoneyTotal+bs.getStayMoney()));
		 		
		 		actualMoneyTotal=Double.parseDouble(df.format(actualMoneyTotal+bs.getActualMoney()));
		 		rebateMoneyTotal=Double.parseDouble(df.format(rebateMoneyTotal+bs.getRebateMoney()));
				 tbody=new String[] {identifier,orderTime,orderMoney,df.format(bs.getClearingMoney()),df.format(bs.getStayMoney()),
						 theMoeny,"是",df.format(bs.getActualMoney()),bs.getRebate().toString(),df.format(bs.getRebateMoney()),
						 remark,orderName};
				 
			}else {
				  
				  tbody=new String[] {identifier,orderTime,orderMoney, 
						  theMoeny,
						  remark,orderName};
			} 
			tbodys.add(tbody);
		
		}
		JSONObject tableJSON1 = new JSONObject();
		String theMoneyName="本次结算";
		if(bills.getBillsType()==3){
			theMoneyName="本次收款";
		}
		if(bills.getBillsType()==1||bills.getBillsType()==2) {
			 theads=new String[]{"单据编号","单据日期","开单金额","已结算金额","待结算",theMoneyName,typeName+"款","实"+typeName+"金额","折扣%","折扣金额","备注","单据类型"};
			
			 List<JSONObject> totalCountList = new ArrayList<>();
				JSONObject totalCountJSON = new JSONObject();
				totalCountJSON.put("col", "2");
				totalCountJSON.put("colTotal",orderMoneyTotal.toString());
				totalCountList.add(totalCountJSON);
		 
				totalCountJSON = new JSONObject();
				totalCountJSON.put("col", "3");
				totalCountJSON.put("colTotal",clearingMoneyTotal.toString());
				totalCountList.add(totalCountJSON);
				
				totalCountJSON = new JSONObject();
				totalCountJSON.put("col", "4");
				totalCountJSON.put("colTotal",stayMoneyTotal.toString());
				totalCountList.add(totalCountJSON);	
				totalCountJSON = new JSONObject();
				totalCountJSON.put("col", "5");
				totalCountJSON.put("colTotal",theMoenyTotal.toString());
				totalCountList.add(totalCountJSON);
				totalCountJSON = new JSONObject();
				totalCountJSON.put("col", "7");
				totalCountJSON.put("colTotal",actualMoneyTotal.toString());
				totalCountList.add(totalCountJSON);
				totalCountJSON = new JSONObject();
				totalCountJSON.put("col", "9");
				totalCountJSON.put("colTotal",rebateMoneyTotal.toString());
				totalCountList.add(totalCountJSON);
				JSONObject totalJSON = new JSONObject();
				totalJSON.put("haveTotal", "true");
				totalJSON.put("total", totalCountList);
 				tableJSON1.put("thead", theads);
				tableJSON1.put("tbody", tbodys);
				tableJSON1.put("total", totalJSON);
		}else {
			theads=new String[]{"单据编号","单据日期","订单金额","本次结算","备注","单据类型"};
			tableJSON1.put("thead", theads);
			tableJSON1.put("tbody", tbodys);
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "false");
		   tableJSON1.put("total", totalJSON);
 		}
		String[] theads2=new String[] {"币种","金额","结算方式",typeName+"款账户","开户银行","银行账户","票号","备注"};
		List<String[]>  tbody2s=new ArrayList<String[]>();
		String[]  tbody2=new String[] {"人民币",
				((bills.getBillsType()==1||bills.getBillsType()==2)?
						actualMoneyTotal.toString():theMoenyTotal.toString()),
				bills.getPaymentName(),bills.getAccount(),
				bills.getBank(),bills.getBankAccount(),bills.getTicketNo(),bills.getRemark()};
		tbody2s.add(tbody2);
		JSONObject tableJSON2 = new JSONObject();
		JSONObject totalJSON2 = new JSONObject();
		totalJSON2.put("haveTotal", "false");
		tableJSON2.put("thead", theads2);
		tableJSON2.put("tbody", tbody2s);
		tableJSON2.put("total", totalJSON2);
		tableJson.put("table1", tableJSON1);
		tableJson.put("table2", tableJSON2);
	 
		tableJson.put("theMoenyTotal",(bills.getBillsType()==1||bills.getBillsType()==2)?
				actualMoneyTotal.toString():theMoenyTotal.toString());
		return tableJson;
	}
	
	
	/**
	 * 应收款单查询待添加 销售退货单
	 * @param supctoId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="returnSales",method=RequestMethod.POST)
	public JSONObject returnSales(Integer supctoId) {
		JSONObject result = new JSONObject();
		result.put("success", false);
		try { 
			
			result = new JSONObject();
			List<BillsSub>	subList=billsSubService.selectByOne(supctoId);
 			List<BillsSub>	returnList=billsSubService.selectReturnSales(supctoId);
			result.put("subList", subList);
			result.put("returnList", returnList);
			result.put("success", true);
		} catch (Exception e) {
 			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 应收款单查询待添加 销售退货单
	 * @param supctoId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="returnProcure",method=RequestMethod.POST)
	public JSONObject returnProcure(Integer supctoId) {
		JSONObject result = new JSONObject();
		result.put("success", false);
		try { 
			
			result = new JSONObject();
			List<BillsSub>	subList=billsSubService.selectByTwo(supctoId);
 			List<BillsSub>	returnList=billsSubService.selectReturnProcure(supctoId);
			result.put("subList", subList);
			result.put("returnList", returnList);
			result.put("success", true);
		} catch (Exception e) {
 			e.printStackTrace();
		}
		return result;
	}
}
