package com.jl.psi.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.service.MessageService;
import com.jl.psi.service.ProcureTableService;
import com.jl.psi.service.SalesPlanOrderService;
import com.jl.psi.utils.DataTables;

/**
 * 首页
 * @author guole
 *
 */
@Controller
@RequestMapping("/basic/index/")
public class IndexController extends BaseController{

	@Autowired
	private MessageService messageService;
	@Autowired
	private ProcureTableService	procureTableService;
	@Autowired
	private SalesPlanOrderService	salesPlanOrderService;
	
	
	@RequestMapping(value = "index", method = RequestMethod.GET)
	public String index() {
		
		return "first";
	}
	
	/**
	 * 判断session是否过期
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="checkSessionIsExist",method=RequestMethod.GET)
	public JSONObject checkSessionIsExist(HttpServletRequest request) {
		JSONObject result=new JSONObject();
		if (!checkSession(request)) {
			result.put("success", false);
		}
		else{
			result.put("success", true);
		}
		return result;
 	}

	/**
	 * 消息提示 datatables分页
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="messages/dataTables",method=RequestMethod.POST)
	public DataTables	dataTables(HttpServletRequest request) {
		String  userId=request.getSession().getAttribute("userId").toString();
		DataTables dataTables=  messageService.dataTables(DataTables.createDataTables(request),userId);
		return dataTables;
 	}
	
	/**
	 * 订单警报提示
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="alert",method=RequestMethod.POST)
	public JSONObject	alert(HttpServletRequest request) {
		JSONObject result=new JSONObject();
		//查询计划采购订单到期数量 (离到期时间还剩两天)
		Integer procureCount= procureTableService.selectExpirationCount();
		//查询计划销售订单到期数量(离到期时间还剩两天)
		Integer saolesCount=salesPlanOrderService.selectExpirationCount();
		result.put("procureCount",procureCount);
		result.put("saolesCount",saolesCount);
		return result;
 	}
}
