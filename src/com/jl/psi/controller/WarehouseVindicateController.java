package com.jl.psi.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.Warehouse;
import com.jl.psi.service.WarehouseService;
import com.jl.psi.utils.DataTables;

@Controller
@RequestMapping("basic/warehousevindicate/")
public class WarehouseVindicateController extends BaseController{
	
	@Autowired
	WarehouseService  warehouseService;
	/**
	 * 进入仓库页面
	 * @param request
	 * @return 页面路径
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request, int page) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "";
		switch (page) {
		//进入仓库商品查询
		case 1:
			pageName="junlin/jsp/warehouse/base/warehouseGoods";
			break;

		default:
			break;
		}
		return pageName;
	}
	/**
	 * 仓库商品dataTable
	 * @param request
	 * @return 页面路径
	 */
	@ResponseBody
	@RequestMapping(value = "getWarehouseMsg")
	public DataTables getProcureTableMsg(HttpServletRequest request,String brand,String commodityName,Integer warehouseId,Integer classficationId) {
		DataTables dataTables = DataTables.createDataTables(request);
		
		return warehouseService.getWarehouseMsg(dataTables,brand,commodityName,warehouseId,classficationId);
	}
	/**
	 * 
	 * 打印仓库商品的查询
	 * @param brand 品牌，commodityName 商品名称， warehouseId 仓库id，classficationId 类别id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "getAll",method = RequestMethod.POST)
	public Object getAll(String brand,String commodityName,Integer warehouseId,Integer classficationId) {
		return  warehouseService.getAll(brand,commodityName,warehouseId,classficationId);
	}
}
