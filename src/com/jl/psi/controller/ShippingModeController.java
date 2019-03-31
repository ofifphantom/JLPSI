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
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.Department;
import com.jl.psi.model.Log;
import com.jl.psi.model.ShippingMode;
import com.jl.psi.model.Supcto;
import com.jl.psi.model.SupctoCommodity;
import com.jl.psi.service.DepartmentService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.ShippingModeService;
import com.jl.psi.service.SupctoService;
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 运输方式Controller
 * @author 柳亚婷
 * @date  2018-04-17  下午2:05:52
 * @Description TODO
 */
@Controller
@RequestMapping("/basic/shippingMode/")
public class ShippingModeController extends BaseController{

	@Autowired
	private ShippingModeService shippingModeService;
	@Autowired
	private SupctoService supctoService;
	@Autowired
	private LogService logService;
	
	/**
	 * 进入运输方式维护页面
	 * @param request
	 * @param page 标志
	 * @return 页面路径
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "junlin/jsp/basic/shippingMode/shippingMode";
			
		return pageName;

	}
	
	/**
	 * 获取所有的运输方式信息
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getAllShippingMode")
	public List<ShippingMode> getAllShippingMode(HttpServletRequest request) {
		return shippingModeService.getAllShippingMode();
	}
	
	/**
	 * 信息dataTables
	 * @param request
	 * @return
	 */
	@RequestMapping(value="dataTables",method=RequestMethod.POST)
	@ResponseBody
	public DataTables dataTables(HttpServletRequest request, String name, String operatorIdentifier, String operatorTime) {
		DataTables dataTables = DataTables.createDataTables(request);

		return shippingModeService.getShippingModeMsg(dataTables, name, operatorIdentifier, operatorTime);
		
	}
	
	/**
	 * 新增前判断名称是否存在
	 * @param request
	 * @param shippingMode
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectShippingModeNamePreventRepeatAdd", method = RequestMethod.POST)
	public JSONObject selectShippingModeNamePreventRepeatAdd(HttpServletRequest request, ShippingMode shippingMode) throws Exception {		
		JSONObject rmsg = new JSONObject();
		if(shippingModeService.selectShippingModeNamePreventRepeatAdd(shippingMode).size()>0){
			rmsg.put("success", false);
			rmsg.put("msg", "该运输方式已存在，请勿重复添加!");
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
	@RequestMapping(value = "/addShippingMode", method = RequestMethod.POST)
	public JSONObject addShippingMode(HttpServletRequest request, ShippingMode shippingMode) throws Exception {
		
		JSONObject rmsg = new JSONObject();
		// 添加操作时间
		Date operateTime = new Date();
		shippingMode.setOperatorTime(operateTime);
		// 添加操作人编号，从session中获取
		String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		shippingMode.setOperatorIdentifier(operatorIdentifier);
		
		if (shippingModeService.insertSelective(shippingMode) > 0) {
			//插入日志
			Log log =new Log();
			log.setOperateType(Constants.TYPE_LOG_SHIPPINGMODE);
			
			String operateObject=shippingMode.getName()+"("+Constants.OPERATE_INSERT+")";
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
	 * 编辑前判断名称是否存在
	 * @param request
	 * @param shippingMode
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectShippingModeNamePreventRepeatedit", method = RequestMethod.POST)
	public JSONObject selectShippingModeNamePreventRepeatedit(HttpServletRequest request, ShippingMode shippingMode) throws Exception {		
		JSONObject rmsg = new JSONObject();
		if(shippingModeService.selectShippingModeNamePreventRepeatedit(shippingMode).size()>0){
			rmsg.put("success", false);
			rmsg.put("msg", "该运输方式已存在，请勿重复添加!");
			return rmsg;
		}
		rmsg.put("success", true);
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
	@RequestMapping(value = "updateShippingModeById", method = RequestMethod.POST)
	public JSONObject updateShippingModeById(HttpServletRequest request,  ShippingMode shippingMode) throws Exception {
		
		JSONObject rmsg=new JSONObject();
		if (shippingModeService.updateByPrimaryKeySelective(shippingMode)>0) {
			
			//插入日志
			Log log =new Log();
			int id = shippingMode.getId();
			log.setOperateType(Constants.TYPE_LOG_SHIPPINGMODE);
			
			//操作对象
			String operateObject = shippingMode.getName() + "("+Constants.OPERATE_UPDATE+")";
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
	 * 删除前判断该运输方式是否被占用，被占用则不能删除
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/afterDelDecide", method = RequestMethod.POST)
	public JSONObject afterDelDecide(HttpServletRequest request, String[] ids) throws Exception {
		JSONObject rmsg = new JSONObject();
		ArrayList<Integer> list=new ArrayList<Integer>();
	
		if(ids!=null && ids.length>0){
			for(String id:ids){
				int int_id = Integer.valueOf(id);
				list.add(int_id);
			}
		}	
		List<String> isExitsCommoditySpec=new ArrayList<>();
		
		//查客户
		List<Supcto> supctos=supctoService.getSupctoByTransportMode(list);
		//在客户里被占用
		if(supctos!=null&&supctos.size()>0){
			for(Supcto s: supctos){
				for(int i=0;i<list.size();i++){
					if(s.getId()==list.get(i)){
						isExitsCommoditySpec.add(s.getShippingMode().getName());
						list.remove(i);
						break;
					}
				}
			}
		}
		if(list.size()>0){
			//查采购
			List<ShippingMode> shippingModes2=shippingModeService.selectShippingModeIsExistFromPT(list);
			//在采购单中已被占用
			if (shippingModes2 != null && shippingModes2.size() > 0) {
				for(ShippingMode s: shippingModes2){
					for(int i=0;i<list.size();i++){
						if(s.getId()==list.get(i)){
							isExitsCommoditySpec.add(s.getName());
							list.remove(i);
							break;
						}
					}
				}
			}
			
			if(list.size()>0){
				//查销售
				List<ShippingMode> shippingModes3=shippingModeService.selectShippingModeIsExistFromSO(list);
				//在销售单中已被占用
				if (shippingModes3 != null && shippingModes3.size() > 0) {
					for(ShippingMode s: shippingModes3){
						for(int i=0;i<list.size();i++){
							if(s.getId()==list.get(i)){
								isExitsCommoditySpec.add(s.getName());
								list.remove(i);
								break;
							}
						}
					}
				}
				
				if(list.size()>0){
					//查调拨
					List<ShippingMode> shippingModes4=shippingModeService.selectShippingModeIsExistFromAO(list);
					//在调拨单中已被占用
					if (shippingModes4 != null && shippingModes4.size() > 0) {
						for(ShippingMode s: shippingModes4){
							for(int i=0;i<list.size();i++){
								if(s.getId()==list.get(i)){
									isExitsCommoditySpec.add(s.getName());
									list.remove(i);
									break;
								}
							}
						}
					}				
				}			
			}		
		}
				
		String notDelete="(";
		if(isExitsCommoditySpec!=null&&isExitsCommoditySpec.size()>0){
			for(int i=0;i<isExitsCommoditySpec.size();i++){
				if(i<isExitsCommoditySpec.size()-1){
					notDelete+=isExitsCommoditySpec.get(i)+",";
				}else{
					notDelete+=isExitsCommoditySpec.get(i);
				}
			}
			notDelete+=")";
			rmsg.put("msg", notDelete + "以上显示的运输方式已被占用,暂不能删除!");
			rmsg.put("success", false);
			return rmsg;
		}	
		rmsg.put("success", true);
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
	@RequestMapping(value = "deleteShippingModeByIds", method = RequestMethod.POST)
	public JSONObject deleteShippingModeByIds(HttpServletRequest request, String[] ids) throws Exception {
		
		JSONObject rmsg=new JSONObject();
		// 在删除前保存要删除的运输方式的信息
		List<ShippingMode> shippingModes=  shippingModeService.selectBatchByPrimaryKey(ids);
		if (shippingModeService.deleteBatchByPrimaryKey(ids)>0) {
			//插入日志
			Log log =new Log();
			//操作类型
			log.setOperateType(Constants.TYPE_LOG_SHIPPINGMODE);
			
			String str="";
			if(shippingModes.size()>0){
				
				for (int i = 0; i < shippingModes.size(); i++) {
					str += shippingModes.get(i).getName();
					if(i<shippingModes.size()-1){
						str += ",";
					}
				}
			}
			str += "("+Constants.OPERATE_DELETE+")";
			
			log.setOperateObject(str);
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
	@RequestMapping(value="exportShippingMode")
	public boolean exportShippingMode(HttpServletRequest request,HttpServletResponse response, String name, String operatorIdentifier) throws Exception{
		
		name = URLDecoder.decode(name, "UTF-8");
		operatorIdentifier = URLDecoder.decode(operatorIdentifier, "UTF-8");
		
		
		String fileName = "运输方式信息";//文档名称以及Excel里头部信息
		List<ShippingMode> shippingModes=shippingModeService.exportShippingMode(name, operatorIdentifier);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		
		//搜索的有数据
		if(shippingModes.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[3];
			title[0]="名称";
			title[1]="操作人";
			title[2]="操作时间";
			
			//保存要导出的内容
			for(ShippingMode c:shippingModes){
				value=new String[3];
				value[0]=c.getName();
				if(c.getPerson()!=null){
					value[1]=c.getOperatorIdentifier()+"("+c.getPerson().getName()+")";
				}
				else{
					value[1]=c.getOperatorIdentifier();
				}	
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				if(c.getOperatorTime()!=null){
					value[2]=sdf.format(c.getOperatorTime());
				}
				else{
					value[2]="";
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