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
import com.jl.psi.model.Department;
import com.jl.psi.model.Log;
import com.jl.psi.model.SettlementType;
import com.jl.psi.service.DepartmentService;
import com.jl.psi.service.LogService;
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 部门Controller
 * @author 景雅倩
 * @date  2017-11-8  下午4:39:52
 * @Description TODO
 */
@Controller
@RequestMapping("/basic/department/")
public class DepartmentController extends BaseController{

	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private LogService logService;
	
	/**
	 * 进入部门维护页面
	 * @param request
	 * @param page 标志
	 * @return 页面路径
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "junlin/jsp/basic/department/departmentManager";
			
		return pageName;

	}
	
	/**
	 * 获取所有的部门信息
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getAllDepartment")
	public List<Department> getAllDepartment(HttpServletRequest request) {
		return departmentService.getAllDepartment();
	}
	
	/**
	 * 信息dataTables
	 * @param request
	 * @return
	 */
	@RequestMapping(value="dataTables",method=RequestMethod.POST)
	@ResponseBody
	public DataTables dataTables(HttpServletRequest request,String identifier, String name, String operatorIdentifier, String operatorTime) {
		DataTables dataTables = DataTables.createDataTables(request);

		return departmentService.dataTables(dataTables, identifier, name, operatorIdentifier, operatorTime);
		
	}
	/**
	 * 新增或编辑前判断名称是否存在
	 * @param request
	 * @param department
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/checkIsRepeat", method = RequestMethod.POST)
	public JSONObject checkIsRepeat(HttpServletRequest request, Department department) throws Exception {		
		JSONObject rmsg = new JSONObject();
		if(departmentService.checkIsRepeat(department).size()>0){
			rmsg.put("success", false);
			rmsg.put("msg", "该部门已存在，请勿重复添加!");
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
	@RequestMapping(value = "/addDepartment", method = RequestMethod.POST)
	public JSONObject addSupcto(HttpServletRequest request, Department department) throws Exception {
		
		JSONObject rmsg = new JSONObject();
		
		// 自动生成编号
		String identifier = SundryCodeUtil.getPosCode(Constants.CODE_DEPARTMENT);
		department.setIdentifier(identifier);
		// 添加操作时间
		Date operateTime = new Date();
		department.setOperatorTime(operateTime);
		// 添加操作人编号，从session中获取
		String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		department.setOperatorIdentifier(operatorIdentifier);
		
		if (departmentService.insertSelective(department) > 0) {
			//插入日志
			Log log =new Log();
			log.setOperateType(Constants.TYPE_LOG_DEPARTMENT);
			
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
	 * 编辑
	 * @param request
	 * @param 
	 * @return
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "updateDepartmentById", method = RequestMethod.POST)
	public JSONObject updateSupctoById(HttpServletRequest request,  Department department) throws Exception {
		
		JSONObject rmsg=new JSONObject();
		if (departmentService.updateByPrimaryKeySelective(department)>0) {
			
			//插入日志
			Log log =new Log();
			int id = department.getId();
			log.setOperateType(Constants.TYPE_LOG_DEPARTMENT);
			
			//操作对象
			String identifier=departmentService.selectByPrimaryKey(id).getIdentifier();
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
	@RequestMapping(value = "deleteDepartmentByIds", method = RequestMethod.POST)
	public JSONObject deleteSupctoByIds(HttpServletRequest request, String[] ids) throws Exception {
		
		JSONObject rmsg=new JSONObject();
		
		ArrayList<Integer> list=new ArrayList<Integer>();
		if(ids!=null && ids.length>0){
			for(String id:ids){
				int int_id = Integer.valueOf(id);
				list.add(int_id);
			}
		}
		//判断有没有被客户/供应商占用 如果有 返回编号
		List<Department> settlementIdentifier1 =  departmentService.selectDepartmentIdentifierByDepartmentId(list);
		
		if(settlementIdentifier1.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier1.size(); i++) {
				str += settlementIdentifier1.get(i).getIdentifier();
				if(i<settlementIdentifier1.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的部门("+str+")有关联的客户/供应商,删除失败！");
			return rmsg;
		}
		//判断有没有被员工占用 如果有 返回编号
		List<Department> settlementIdentifier2 =  departmentService.selectDepartmentIdentifierFromPersonByDepartmentId(list);
				
		if(settlementIdentifier2.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier2.size(); i++) {
				str += settlementIdentifier2.get(i).getIdentifier();
				if(i<settlementIdentifier2.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的部门("+str+")有关联的员工,删除失败！");
			return rmsg;
		}
		
		//判断有没有被采购订单占用 如果有 返回编号
		List<Department> settlementIdentifier3 =  departmentService.selectDepartmentIdentifierFromProcureTableByDepartmentId(list);
						
		if(settlementIdentifier3.size()>0){
			String str="";
			for (int i = 0; i < settlementIdentifier3.size(); i++) {
				str += settlementIdentifier3.get(i).getIdentifier();
				if(i<settlementIdentifier3.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的部门("+str+")有关联的采购订单,删除失败！");
			return rmsg;
		}
		//保存将要删除的对象编号
		List<Department> supctos = departmentService.getDepartmentByIds(list);
		if (departmentService.deleteDepartmentByIds(list)) {
			//插入日志
			Log log =new Log();
			//操作类型
			log.setOperateType(Constants.TYPE_LOG_DEPARTMENT);
			
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
	@RequestMapping(value="exportDepartment")
	public boolean exportDepartment(HttpServletRequest request,HttpServletResponse response,String identifier, String name, String operatorIdentifier) throws Exception{
		
		identifier =  URLDecoder.decode(identifier, "UTF-8");
		name = URLDecoder.decode(name, "UTF-8");
		operatorIdentifier = URLDecoder.decode(operatorIdentifier, "UTF-8");
		
		
		String fileName = "";//文档名称以及Excel里头部信息
		List<Department> departments=departmentService.selectMsgOrderBySearchMsg(identifier, name, operatorIdentifier);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		fileName = "部门信息";//文档名称以及Excel里头部信息
		
		//搜索的有数据
		if(departments.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[4];
			title[0]="编号";
			title[1]="名称";
			title[2]="操作人";
			title[3]="操作时间";
			
			//保存要导出的内容
			for(Department c:departments){
				value=new String[4];
				value[0]=c.getIdentifier();
				value[1]=c.getName();
				value[2]=c.getOperatorIdentifier()+"("+c.getPerson().getName()+")";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				value[3]=sdf.format(c.getOperatorTime());
				
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
	/**
	 * 部门一级分类
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getClassOnedepartment")
	public List<Department> getClassOnedepartment(){
		return departmentService.getClassOnedepartment();
	}
	/**
	 * 部门一级分类
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getClassTwodepartment")
	public List<Department> getClassTwodepartment(Integer departmentId){
		return departmentService.getClassTwodepartment(departmentId);
	}
}