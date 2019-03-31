package com.jl.psi.controller;


import java.math.BigDecimal;
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

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.AllotOrder;
import com.jl.psi.model.AllotOrderCommodity;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.FormHeadAndFooter;
import com.jl.psi.model.Inventory;
import com.jl.psi.model.Log;
import com.jl.psi.model.Unit;
import com.jl.psi.service.AllocteOrderService;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.WarehouseService;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;
/**
 * 调拨单controller
 * @author yanpengfei
 * @data 2018年6月14日 上午11:01:02
 * @Descriotion
 */
@Controller
@RequestMapping("/warehouse/base/allocationOrder/")
public class AlloctionOderController extends BaseController {
	// 当前类操作的类型(往log日志表中存储)
		private int operateType = Constants.TYPE_LOG_WAREHOUSE;
	// 声明Log类
	Log log;
	@Autowired
	private AllocteOrderService alloctionOderService;
	@Autowired
	WarehouseService  warehouseService;
	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	@Autowired
	LogService logService;  
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "junlin/jsp/warehouse/base/allocationList";

		return pageName;

	}
	
	/**
	 * 获取指定仓库商品信息
	 * @param warehouseId 仓库id
	 * @return 页面路径
	 */
	@ResponseBody
	@RequestMapping(value = "getWarehouseCommodity")
	public Object getWarehouseCommodity(Integer warehouseId) {
		
		ArrayList<CommoditySpecification> list=alloctionOderService.getWarehouseCommodity(warehouseId);
		for (CommoditySpecification commoditySpecification : list) {
			ArrayList<Unit>	units=(ArrayList<Unit>) commoditySpecification.getUnits();
			for (Unit unit : units) {
				Double avg=commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(commoditySpecification.getId());
				if (avg!=null) {
					System.out.println("不为空");
					unit.setMiniPrice(avg);
				}
				
			}
		}
		return list;
	}
	/**
	 * dataTables
	 * @param warehouseId 仓库id  makerPerson 制单人
	 * @return 页面路径
	 */
	@ResponseBody
	@RequestMapping(value = "getAllocationOrderMsg")
	public  DataTables getAllocationOrderMsg(HttpServletRequest request, Integer type, String  alloteDate,String originator) {

		DataTables dataTables = DataTables.createDataTables(request);
		Integer  warehouseId=GetSessionUtil.GetSessionUserWarehouseId(request);

		DataTables   dd=alloctionOderService.getAllocationOrderMsg(dataTables, warehouseId, alloteDate,originator,type);

		return  dd;
	}
	/**
	 * 根据id查询调拨单信息
	 * @param allocationId 调拨单id  
	 * @return 页面路径
	 */
	@ResponseBody
	@RequestMapping(value = "getAllocationOrderMsgById")
	public AllotOrder getAllocationOrderMsgById(Integer id) {
	    //System.out.println(">>>>>>>>>>>>"+id);
		return  alloctionOderService.getAllocationOrderMsgById(id);
	}
	/**
	 * 新增调拨单
	 * 
	 * @return 页面路径
	 */
	@ResponseBody
	@RequestMapping(value = "addAlloteOrder",method = RequestMethod.POST)
	public JSONObject addAlloteOrder(HttpServletRequest request) throws Exception {
		JSONObject rmsg=new JSONObject();
		//获取ajax传递过来的参数
		String aoc=request.getParameter("alloteOrder");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(aoc);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("allotOrderCommodities", AllotOrderCommodity.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		AllotOrder allotOrder = (AllotOrder) net.sf.json.JSONObject.toBean(jsonobject, AllotOrder.class, map);
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		allotOrder.setOriginator(GetSessionUtil.GetSessionUserIdentifier(request));
		allotOrder.setAllotDate(new Date());
		String  maxIdentifier=alloctionOderService.selectMaxIdentifier();
		// 生成编号
		String identifier = SundryCodeUtil.createInvoicesIdentifier("AL",maxIdentifier);
		allotOrder.setIdentifier(identifier);
		if (alloctionOderService.insertSelective(allotOrder)>0) {
			for (AllotOrderCommodity ac : allotOrder.getAllotOrderCommodities()) {
				ac.setAllotOrderId(allotOrder.getId());
					//更改每个商品对应的库存信息
					alloctionOderService.updateInventory(allotOrder.getImportWarehouseId(), ac.getCommoditySpecificationId());
					//更改销售商品表中的库存id
					alloctionOderService.updateSaleOrderCommodityWarehouseId(allotOrder.getImportWarehouseId(), ac.getCommoditySpecificationId(), allotOrder.getExportWarehouseId());
					
//				System.out.println("调入仓库id："+allotOrder.getImportWarehouseId());
//				System.out.println("商品规格id："+ac.getCommoditySpecificationId());
//				System.out.println("调出仓库id："+allotOrder.getExportWarehouseId());
				
			}
			//想调拨单中批量添加数据
			alloctionOderService.insertBeatch(allotOrder.getAllotOrderCommodities());
			insertLog(operateType, identifier, Constants.OPERATE_INSERT, new Date(), userIdentifier);
			rmsg.put("success", true);
			rmsg.put("msg", "操作成功");
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
	@RequestMapping(value = "/printAlloteOrder")
	public JSONObject printTakeStockOrder(HttpServletRequest request, Integer id) throws Exception {
		return createPrintAlloteOrderJSON(request, alloctionOderService.getAllocationOrderMsgById(id));
	}
	/**
	 * 调拨单单据打印信息
	 * @param takeStockOrder 盘点单信息
	 * @return 页面所需的信息   JSON格式
	 */
	private JSONObject createPrintAlloteOrderJSON(HttpServletRequest request,AllotOrder allotOrder) {
		JSONObject takeAlloteOrderJSON = new JSONObject();
		
		takeAlloteOrderJSON.put("title", "调拨单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		takeAlloteOrderJSON.put("date", dateFormat.format(allotOrder.getAllotDate()));
		takeAlloteOrderJSON.put("oddNumbers", allotOrder.getIdentifier());
		
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("调出仓库");
		head.setFieldValue(allotOrder.getExportName());
		heads.add(head);
		FormHeadAndFooter head1 = new FormHeadAndFooter();
		head1.setFieldName("调入仓库");
		head1.setFieldValue(allotOrder.getImportName());
		heads.add(head1);
		FormHeadAndFooter head2 = new FormHeadAndFooter();
		head2.setFieldName("运输方式");
		head2.setFieldValue(allotOrder.getShippingMode().getName());
		heads.add(head2);
		FormHeadAndFooter head3 = new FormHeadAndFooter();
		head3.setFieldName("调入机构");
		head3.setFieldValue(allotOrder.getImportBranch());
		heads.add(head3);
		FormHeadAndFooter head4 = new FormHeadAndFooter();
		head4.setFieldName("调整科目");
		head4.setFieldValue(allotOrder.getAdjustSubject());
		heads.add(head4);
		FormHeadAndFooter head5 = new FormHeadAndFooter();
		head5.setFieldName("送货地址");
		head5.setFieldValue(allotOrder.getSendGoodsPlace());
		heads.add(head5);
		takeAlloteOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead
		String[] theads = { "货品编码", "货品名称", "规格", "单位", "数量", "调入单价","调出单价","调入金额" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		for (AllotOrderCommodity acs : allotOrder.getAllotOrderCommodities()) {
			String[] tbody = { acs.getCommoditySpecification().getSpecificationIdentifier(),
					acs.getCommoditySpecification().getCommodity().getName(),
					acs.getCommoditySpecification().getSpecificationName(),
					acs.getCommoditySpecification().getUnits().get(0).getName(),
					acs.getNumber() + "",
					acs.getImportUnitPrice() + "",
					acs.getExportUnitPrice() + "",
					acs.getImportMoney() + "" };
			totalMoney += acs.getImportMoney();
			tbodys.add(tbody);
		}
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalMoney);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeAlloteOrderJSON.put("table", tableJSON);
		/* table end */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();
		footer.setFieldName("部门");
		footer.setFieldValue(allotOrder.getPerson().getDepartment().getName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("业务员");
		footer.setFieldValue(allotOrder.getPerson().getName());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (allotOrder.getPerson() != null) {
			footer.setFieldValue(allotOrder.getOriginator()+"("+allotOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(allotOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		
		
		footer.setFieldValue(allotOrder.getSummary());
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("打印人");
		footer.setFieldValue(GetSessionUtil.GetSessionUserIdentifier(request) + "(" + GetSessionUtil.GetSessionUserName(request) + ")");
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("打印日期");
		footer.setFieldValue(dateFormat.format(new Date()));
		footers.add(footer);
		takeAlloteOrderJSON.put("footer", footers);
		/* footer end */
		return takeAlloteOrderJSON;
	}
	/**
	 * 更改单据打印次数
	 * @param request
	 * @param id 单据id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateAllotOrderPrintNum")
	public JSONObject updateAllotOrderPrintNum(HttpServletRequest request, int id) throws Exception {

		JSONObject rmsg = new JSONObject();
		AllotOrder allotOrder = alloctionOderService.selectByPrimaryKey(id);
		System.out.println(allotOrder);
		String identifier = allotOrder.getIdentifier();
		
		int printNum = allotOrder.getPrintNum();
		printNum += 1;
		allotOrder = new AllotOrder();
		allotOrder.setId(id);
		allotOrder.setPrintNum(printNum);
		
		if (alloctionOderService.updateByPrimaryKeySelective(allotOrder) > 0) {
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
	 * 调拨单明细报表
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "reportMsg")
	public List<AllotOrder> reportMsg(Map<String, Object> params){
		List<AllotOrder>  list=alloctionOderService.reportMsg(params);
//		for (AllotOrder allotOrder : list) {
//		List<AllotOrderCommodity>	allotOrderCommodities=allotOrder.getAllotOrderCommodities();
//		for (AllotOrderCommodity allotOrderCommodity : allotOrderCommodities) {
//			//int csId=allotOrderCommodity.getCommoditySpecificationId();
//			for (Unit unit : allotOrderCommodity.getCommoditySpecification().getUnits()) {
//				Double avg=commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(allotOrderCommodity.getCommoditySpecificationId());
//				//System.out.println(">>>>>>>>>>>>>"+avg);
//				if (avg!=null) {
//					//System.out.println("不为空");
//					unit.setMiniPrice(avg);
//				}else {
//					//System.out.println("为空"+unit.getMiniPrice()+">>>>>>>csid"+allotOrderCommodity.getCommoditySpecificationId());
//				}
//		}
//		}
//		}
		
		return list;
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
		System.out.println(">>>>>>>>>>>identifier"+identifier);
		log.setOperateObject(identifier + "(" + operateMethod + ")");
		log.setOperateTime(date);
		log.setOperatorIdentifier(userIdentifier);
		logService.insert(log);
	}
	@ResponseBody
	@RequestMapping(value = "alloteOrderDetal")
	public JSONObject alloteOrderDetal(Integer id) {
		AllotOrder allotOrder=alloctionOderService.getAllocationOrderMsgById(id);
		return createAlloteOrderDetal(allotOrder);
	}
	/**
	 * 调拨单单据打印信息
	 * @param takeStockOrder 盘点单信息
	 * @return 页面所需的信息   JSON格式
	 */
	private JSONObject createAlloteOrderDetal(AllotOrder allotOrder) {
		JSONObject takeAlloteOrderJSON = new JSONObject();
		DecimalFormat df = new DecimalFormat("#.##");
		takeAlloteOrderJSON.put("title", "调拨单");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		takeAlloteOrderJSON.put("date", dateFormat.format(allotOrder.getAllotDate()));
		takeAlloteOrderJSON.put("oddNumbers", allotOrder.getIdentifier());
		
		/* head start */
		
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter head = new FormHeadAndFooter();
		head.setFieldName("单据类型");
		head.setFieldValue("同价调拨单");
		heads.add(head);
		 head = new FormHeadAndFooter();
		head.setFieldName("调出仓库");
		String exportPosition=warehouseService.selectByPrimaryKey(allotOrder.getExportWarehouseId()).getPosition();
		head.setFieldValue(exportPosition);
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("调出机构");
		head.setFieldValue("总部");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("运输方式");
		head.setFieldValue(allotOrder.getShippingMode().getName());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("调入仓库");
		String importPosition=warehouseService.selectByPrimaryKey(allotOrder.getImportWarehouseId()).getPosition();
		head.setFieldValue(importPosition);
		heads.add(head);

		head = new FormHeadAndFooter();
		head.setFieldName("调入机构");
		head.setFieldValue("总部");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("发货地址");
		head.setFieldValue(allotOrder.getExportPlace());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("收货地址");
		head.setFieldValue(allotOrder.getImportPlace());
		heads.add(head);
 
	    
		takeAlloteOrderJSON.put("head", heads);
		/* head end */

		/* table start */
		// thead  

		String[] theads = { "货品编码", "货品名称", "规格","品牌", "单位","条形码","商品批次", "业务数量(袋)", "业务数量(箱)", "调入单价","金额","生产日期","有效期至","备注" };
		// tbody start
		List<String[]> tbodys = new ArrayList<>();
		Double totalMoney = 0.0;
		Integer totalNumber=0;
		  
		for (AllotOrderCommodity acs : allotOrder.getAllotOrderCommodities()) {
			
			CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(acs.getCommoditySpecificationId());
 			Integer commodityNum=acs.getNumber();
			Integer boxNum=commoditySpecification.getUnits().size()>1?commodityNum/commoditySpecification.getUnits().get(1).getRatioMolecular():0;
			
			String[] tbody = { acs.getCommoditySpecification().getSpecificationIdentifier(),
					acs.getCommoditySpecification().getCommodity().getName(),
					acs.getCommoditySpecification().getSpecificationName(),
					acs.getCommoditySpecification().getCommodity().getBrand(),
					acs.getCommoditySpecification().getUnits().get(0).getName(),
					acs.getCommoditySpecification().getBarCode(),
					"",
					acs.getNumber() + "",boxNum+"",
					acs.getImportUnitPrice() + "",
					df.format(new BigDecimal(acs.getImportMoney())),
					"","",""};
			totalNumber+=acs.getNumber()==null?0:acs.getNumber();
			totalMoney+=acs.getImportMoney();
			
			tbodys.add(tbody);
		}
		List<JSONObject> totalCountList = new ArrayList<>();
		JSONObject totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "7");
		totalCountJSON.put("colTotal",totalNumber.toString());
		totalCountList.add(totalCountJSON);
 
		totalCountJSON = new JSONObject();
		totalCountJSON.put("col", "10");
		totalCountJSON.put("colTotal",df.format(new BigDecimal(totalMoney)));
		totalCountList.add(totalCountJSON);
		
 
		JSONObject totalJSON = new JSONObject();
		totalJSON.put("haveTotal", "true");
		totalJSON.put("total", totalCountList);

		JSONObject tableJSON = new JSONObject();
		tableJSON.put("thead", theads);
		tableJSON.put("tbody", tbodys);
		tableJSON.put("total", totalJSON);
		takeAlloteOrderJSON.put("table", tableJSON);
		/* table end */
		List<FormHeadAndFooter> footers = new ArrayList<>();
		FormHeadAndFooter footer = new FormHeadAndFooter();

		footer = new FormHeadAndFooter();
		footer.setFieldName("制单人");
		if (allotOrder.getPerson() != null) {
			footer.setFieldValue(allotOrder.getOriginator()+"("+allotOrder.getPerson().getName()+")");
		} else {
			footer.setFieldValue(allotOrder.getOriginator());
		}
		footers.add(footer);
		footer = new FormHeadAndFooter();
		footer.setFieldName("摘要");
		footer.setFieldValue(allotOrder.getSummary());
		footers.add(footer);
		
		footer = new FormHeadAndFooter();
		footer.setFieldName("分支机构");
		footer.setFieldValue("总部");
		footers.add(footer);
		takeAlloteOrderJSON.put("footer", footers);
		/* footer end */
		return takeAlloteOrderJSON;
	}
}