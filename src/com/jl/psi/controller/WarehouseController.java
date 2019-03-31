package com.jl.psi.controller;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.Warehouse;
import com.jl.psi.model.Department;
import com.jl.psi.model.Log;
import com.jl.psi.service.LogService;
import com.jl.psi.service.WarehouseService;
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 
 * @author 景雅倩
 * @date  2018年4月9日  下午4:26:25
 * @Description 仓库信息管理Controller
 *
 */
@Controller
@RequestMapping("basic/warehouse/")
public class WarehouseController extends BaseController{
	
	@Autowired
	WarehouseService warehouseService;
	@Autowired
	private LogService logService;
	/**
	 * 查询所有的仓库信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "selectAllWarehouse")
	public List<Warehouse> selectAllMsg(HttpServletRequest request) throws Exception {

		return warehouseService.selectAllMsg();
	}
	
	
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
		// 进入仓库维护页面
		case 1:
			pageName = "junlin/jsp/basic/warehouse/warehouseManager";
			break;
		// 销售订单引用页面
		case 2:
			pageName = "junlin/jsp/warehouse/outOfTheTreasury/documentReference/salesOrderReference";
			break;
		// 销售订单作废审核页面
		case 3:
			pageName = "junlin/jsp/warehouse/outOfTheTreasury/audit/orderInvalidationrAudit";
			break;
		// 出库单页面
		case 4:
			pageName = "junlin/jsp/warehouse/outOfTheTreasury/outboundOrder";
			break;
		// 返货单页面
		case 5:
			pageName = "junlin/jsp/warehouse/base/returnList";
			break;
		default:
			break;
		}

		return pageName;

	}
	
	/**
	 * 仓库基础信息维护页面的dataTables
	 * @param request
	 * @return
	 */
	@RequestMapping(value="dataTables")
	@ResponseBody
	public DataTables dataTables(HttpServletRequest request,String identifier, String name, String operatorIdentifier,String area, String operatorTime) {
		DataTables dataTables = DataTables.createDataTables(request);

		return warehouseService.dataTables(dataTables, identifier, name, operatorIdentifier,area, operatorTime);
		
	}
	/**
	 * 新增或编辑前判断是否存在
	 * @param request
	 * @param department
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/checkIsRepeat", method = RequestMethod.POST)
	public JSONObject checkIsRepeat(HttpServletRequest request, Warehouse warehouse) throws Exception {		
		JSONObject rmsg = new JSONObject();
		if(warehouseService.checkIsRepeat(warehouse).size()>0){
			rmsg.put("success", false);
			rmsg.put("msg", "该仓库已存在，请勿重复添加!");
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}
	/**
	 * 添加
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addWarehouse", method = RequestMethod.POST)
	public JSONObject addSupcto(HttpServletRequest request, Warehouse warehouse) throws Exception {
		
		JSONObject rmsg = new JSONObject();
		
		// 自动生成编号
		String identifier = SundryCodeUtil.getPosCode(Constants.CODE_WAREHOUSE);
		warehouse.setIdentifier(identifier);
		// 添加操作时间
		Date operateTime = new Date();
		warehouse.setOperatorTime(operateTime);
		// 添加操作人编号，从session中获取
		String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		warehouse.setOperatorIdentifier(operatorIdentifier);
		
		if (warehouseService.insertSelective(warehouse) > 0) {
			//插入日志
			Log log =new Log();
			log.setOperateType(Constants.TYPE_LOG_WAREHOUSE);
			
			String operateObject=identifier+"("+Constants.OPERATE_INSERT+")";
			log.setOperateObject(operateObject);
			log.setOperatorIdentifier(operatorIdentifier);
			log.setOperateTime(operateTime);
			logService.insert(log);
			// 往前台返回结果集
			rmsg.put("success", true);
			rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
			return rmsg;
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.SAVE_FAILURE_MSG);

		return rmsg;
	}
	
	/**
	 * 
	 * @param request
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "selectWarehouseById")
	public List<Warehouse> selectWarehouseById(Integer id){
		
		
		return warehouseService.selectWarehouseById(id);
	}
	/**
	 * 编辑
	 * @param request
	 * @param 
	 * @return
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "updateWarehouseById", method = RequestMethod.POST)
	public JSONObject updateSupctoById(HttpServletRequest request,  Warehouse warehouse) throws Exception {
		
		JSONObject rmsg=new JSONObject();
		if (warehouseService.updateByPrimaryKeySelective(warehouse)>0) {
			
			//插入日志
			Log log =new Log();
			int id = warehouse.getId();
			log.setOperateType(Constants.TYPE_LOG_WAREHOUSE);
			
			//操作对象
			String identifier=warehouseService.selectByPrimaryKey(id).getIdentifier();
			String operateObject = identifier + "("+Constants.OPERATE_UPDATE+")";
			log.setOperateObject(operateObject);
			
			//操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			//操作时间
			Date operateTime=new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);
			
			
			rmsg.put("success", true);
			rmsg.put("msg",Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}
	
	
	/**
	 * 删除（根据id列表删）
	 * @param request
	 * @param ids  id数组
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "deleteWarehouseByIds", method = RequestMethod.POST)
	public JSONObject deleteSupctoByIds(HttpServletRequest request, String[] ids) throws Exception {
		
		JSONObject rmsg=new JSONObject();
		
		ArrayList<Integer> list=new ArrayList<Integer>();
		if(ids!=null && ids.length>0){
			for(String id:ids){
				int int_id = Integer.valueOf(id);
				list.add(int_id);
			}
		}
		//判断有没有被占用 如果有 返回编号
		List<Warehouse> settlementIdentifier1 =  warehouseService.selectWarehouseIdentifierByWarehouseId(list);
		
		if(settlementIdentifier1.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier1.size(); i++) {
				str += settlementIdentifier1.get(i).getIdentifier();
				if(i<settlementIdentifier1.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的仓库("+str+")有关联的商品,删除失败！");
			return rmsg;
		}
		
		//判断有没有被占用 如果有 返回编号
		List<Warehouse> settlementIdentifier2 =  warehouseService.selectWarehouseIdentifierFromAllotOrderByWarehouseId(list);
				
		if(settlementIdentifier2.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier2.size(); i++) {
				str += settlementIdentifier2.get(i).getIdentifier();
				if(i<settlementIdentifier2.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的仓库("+str+")有关联的调拨单,删除失败！");
			return rmsg;
		}
		//判断有没有被占用 如果有 返回编号
		List<Warehouse> settlementIdentifier3 =  warehouseService.selectWarehouseIdentifierFromBreakageOrderByWarehouseId(list);
						
		if(settlementIdentifier3.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier3.size(); i++) {
				str += settlementIdentifier3.get(i).getIdentifier();
				if(i<settlementIdentifier3.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的仓库("+str+")有关联的报损单,删除失败！");
			return rmsg;
		}		
		//判断有没有被占用 如果有 返回编号
		List<Warehouse> settlementIdentifier4 =  warehouseService.selectWarehouseIdentifierFromPackageOrTeardownOrderByWarehouseId(list);
						
		if(settlementIdentifier4.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier4.size(); i++) {
				str += settlementIdentifier4.get(i).getIdentifier();
				if(i<settlementIdentifier4.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的仓库("+str+")有关联的组装/拆卸单,删除失败！");
			return rmsg;
		}				
		//判断有没有被占用 如果有 返回编号
		List<Warehouse> settlementIdentifier5 =  warehouseService.selectWarehouseIdentifierFromTakeStockOrderByWarehouseId(list);
						
		if(settlementIdentifier5.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier5.size(); i++) {
				str += settlementIdentifier5.get(i).getIdentifier();
				if(i<settlementIdentifier5.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的仓库("+str+")有关联的盘点单,删除失败！");
			return rmsg;
		}
		//判断有没有被占用 如果有 返回编号
		List<Warehouse> settlementIdentifier6 =  warehouseService.selectWarehouseIdentifierFromPersonByWarehouseId(list);
								
		if(settlementIdentifier6.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier6.size(); i++) {
				str += settlementIdentifier6.get(i).getIdentifier();
				if(i<settlementIdentifier6.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的仓库("+str+")有关联的员工,删除失败！");
			return rmsg;
		}
		//保存将要删除的对象编号
		List<Warehouse> supctos = warehouseService.getWarehouseByIds(list);
		if (warehouseService.deleteWarehouseByIds(list)) {
			//插入日志
			Log log =new Log();
			//操作类型
			log.setOperateType(Constants.TYPE_LOG_WAREHOUSE);
			
			//操作对象
			String operateObject="";
			for (int i = 0; i < supctos.size(); i++) {
				operateObject += supctos.get(i).getIdentifier();
				if(i < supctos.size()-1){
					operateObject += ",";
				}
			}
			operateObject += "("+Constants.OPERATE_DELETE+")";
			
			log.setOperateObject(operateObject);
			//操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			//操作时间
			Date operateTime=new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);
			
			rmsg.put("success", true);
			rmsg.put("msg", Constants.DELE_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.DELE_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 导出信息
	 * @param request
	 * @param response
	 * @param identifier 编号
	 * @param name 名称
	 * @param operatorIdentifier 操作人
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="exportWarehouse")
	public boolean exportWarehouse(HttpServletRequest request,HttpServletResponse response,String identifier, String name, String operatorIdentifier) throws Exception{
		
		identifier =  URLDecoder.decode(identifier, "UTF-8");
		name = URLDecoder.decode(name, "UTF-8");
		operatorIdentifier = URLDecoder.decode(operatorIdentifier, "UTF-8");
		
		
		String fileName = "";//文档名称以及Excel里头部信息
		List<Warehouse> warehouses=warehouseService.selectMsgOrderBySearchMsg(identifier, name, operatorIdentifier);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		fileName = "仓库信息";//文档名称以及Excel里头部信息
		
		//搜索的有数据
		if(warehouses.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[5];
			title[0]="编号";
			title[1]="名称";
			title[2]="位置";
			title[3]="操作人";
			title[4]="操作时间";
			
			//保存要导出的内容
			for(Warehouse c:warehouses){
				value=new String[5];
				value[0]=c.getIdentifier();
				value[1]=c.getName();
				value[2]=c.getPosition();
				if(c.getPerson()!=null){
					value[3]=c.getOperatorIdentifier()+"("+c.getPerson().getName()+")";
				}
				else{
					value[3]=c.getOperatorIdentifier();
				}
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				if(c.getOperatorTime()!=null){
					value[4]=sdf.format(c.getOperatorTime());
				}
				else{
					value[4]="";
				}
				
				
				dataList.add(value);
			}
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

}
