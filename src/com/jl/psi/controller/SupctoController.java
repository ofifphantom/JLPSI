package com.jl.psi.controller;


import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.Log;
import com.jl.psi.model.Supcto;
import com.jl.psi.model.SupctoCommodity;
import com.jl.psi.model.Warehouse;
import com.jl.psi.service.LogService;
import com.jl.psi.service.SupctoCommodityService;
import com.jl.psi.service.SupctoService;
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 客户/供应商Controller
 * @author 景雅倩
 * @date  2017-11-8  下午4:39:52
 * @Description TODO
 */
@Controller
@RequestMapping("/basic/supctoManager/")
public class SupctoController extends BaseController{

	@Autowired
	private SupctoService supctoService;
	@Autowired
	private SupctoCommodityService supctoCommodityService;
	@Autowired
	private LogService logService;
	/**
	 * 进入供应商/客户维护页面
	 * @param request
	 * @param page 标志
	 * @return 页面路径
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request, int page) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName = "";

		switch (page) {
		// 客户管理
		case 11:
			pageName = "junlin/jsp/basic/customer/customerManager";
			break;
		// 客户审核
		case 12:
			pageName = "junlin/jsp/basic/customer/customerDelivery";
			break;
		// 客户停用审核
		case 13:
			pageName = "junlin/jsp/basic/customer/customerDisabledDelivery";
			break;
		// 查看客户信息
		case 14:
			pageName = "junlin/jsp/basic/customer/viewCustomer";
			break;
		// 修改客户信息
		case 15:
			pageName = "junlin/jsp/basic/customer/editCustomer";
			break;
		// 客户修改审核
		case 16:
			pageName = "junlin/jsp/basic/customer/editCustomerDelivery";
			break;
		// 供应商管理
		case 21:
			pageName = "junlin/jsp/basic/supplier/supplierManager";
			break;
		// 供应商审核
		case 22:
			pageName = "junlin/jsp/basic/supplier/supplierDelivery";
			break;
		// 供应商停用审核
		case 23:
			pageName = "junlin/jsp/basic/supplier/supplierDisabledDelivery";
			break;
		// 查看供应商信息
		case 24:
			pageName = "junlin/jsp/basic/supplier/viewSupplier";
			break;
		// 修改供应商信息
		case 25:
			pageName = "junlin/jsp/basic/supplier/editSupplier";
			break;
		// 供应商修改审核
		case 26:
			pageName = "junlin/jsp/basic/supplier/editSupplierDelivery";
			break;
		default:
			break;
		}

		return pageName;

	}
	
	
	/**
	 * 信息dataTables
	 * @param request
	 * @param flag 标志 1：管理页面   2:审核页面  3:停用审核页面  4:查看信息页面 5:修改信息页面6:修改审核页面
	 * @param customerOrSupplier 客户/供应商：1：客户   2：供应商
	 * @return
	 */
	@RequestMapping(value="dataTables",method=RequestMethod.POST)
	@ResponseBody
	public DataTables dataTables(HttpServletRequest request,
			Integer flag ,Integer customerOrSupplier,
			String classificationId, String name, String fromType,String state,
			String provinceCode, String cityCode, String areaCode,
			String operatorIdentifier,String operatorTime) {
		
		DataTables dataTables = DataTables.createDataTables(request);

		return supctoService.getDataTables(dataTables, flag, customerOrSupplier, classificationId, name, fromType,state, provinceCode, cityCode, areaCode,operatorIdentifier,operatorTime);
		
	}
	
	/**
	 * 根据供应商（2）还是客户（1）获取其所包含的所有信息
	 * @param request
	 * @param customerOrSupplier  供应商（2），客户（1）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getSupctoMsgByCustomerOrSupplier", method = RequestMethod.POST)
	public List<Supcto> getSupctoMsgByCustomerOrSupplier(HttpServletRequest request, Integer customerOrSupplier) throws Exception {
		
		return supctoService.selectAllMsgByCustomerOrSupplier(customerOrSupplier);
		
	}
	/**
	 * 根据供应商（2）还是客户（1）获取其所包含的所有信息
	 * @param request
	 * @param （1） 客户
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectAllCustomerByCustomerOrSupplier", method = RequestMethod.POST)
	public List<Supcto> selectAllCustomerByCustomerOrSupplier(HttpServletRequest request, Integer customerOrSupplier) throws Exception {

		return supctoService.selectAllCustomerByCustomerOrSupplier(customerOrSupplier);

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
	public JSONObject checkIsRepeat(HttpServletRequest request, Supcto supcto) throws Exception {		
		JSONObject rmsg = new JSONObject();
		if(supctoService.checkIsRepeat(supcto).size()>0){
			rmsg.put("success", false);
			if(supcto.getCustomerOrSupplier() == 1) {
				rmsg.put("msg", "该客户名称已存在，请勿重复添加!");
			}else {
				rmsg.put("msg", "该供应商名称已存在，请勿重复添加!");
			}
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}
	
	/**
	 * 添加客户/供应商
	 * @param request
	 * @param supcto  需注意：页面上应传过来是供应商（2）还是客户（1）
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addSupcto", method = RequestMethod.POST)
	public JSONObject addSupcto(HttpServletRequest request, Supcto supcto) throws Exception {
		JSONObject rmsg = new JSONObject();
		
		String goodsObj = supcto.getGoodsObj();
		JSONArray json = JSONArray.parseArray(goodsObj);
		
		
		String province = supcto.getProvinceCode();
		String city = supcto.getCityCode();
		String area = supcto.getAreaCode();
		
		String provinceCode = supcto.getProvince();
		String cityCode = supcto.getCity();
		String areaCode = supcto.getArea();
		if(!"-1".equals(provinceCode)&&provinceCode!=null){
			supcto.setProvince(province);
			supcto.setProvinceCode(provinceCode);
		}else{
			supcto.setProvince("");
			supcto.setProvinceCode("");
		}
		if(!"-1".equals(cityCode)&&cityCode!=null){
			supcto.setCity(city);
			supcto.setCityCode(cityCode);
		}else{
			supcto.setCity("");
			supcto.setCityCode("");
		}
		if(!"-1".equals(areaCode)&&areaCode!=null){
			supcto.setArea(area);
			supcto.setAreaCode(areaCode);
		}else{
			supcto.setArea("");
			supcto.setAreaCode("");
		}
		
		
		
		// 自动生成编号
		String identifier = "";
		int CustomerOrSupplier = supcto.getCustomerOrSupplier();
		if(CustomerOrSupplier == 1){//客户
			identifier = SundryCodeUtil.getPosCode(Constants.CODE_CUSTOMER);
		}else{//供应商
			identifier = SundryCodeUtil.getPosCode(Constants.CODE_SUPPLIER);
		}
		
		
		supcto.setIdentifier(identifier);
		// 添加操作时间
		Date operateTime = new Date();
		supcto.setOperatorTime(operateTime);
		// 添加操作人编号，从session中获取
		String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		supcto.setOperatorIdentifier(operatorIdentifier);
		//状态  默认为未送审
		supcto.setState(Constants.STATE_SUPCTO_NOTSUBMIT);
		//是否停用 默认为否
		supcto.setUseable(1);
		if (supctoService.insertSelective(supcto) > 0) {
			//插入日志
			Log log =new Log();
			int customerOrSupplier = supcto.getCustomerOrSupplier();
			int id = supcto.getId();
			
			
			//修改客户时修改客户往来产品表信息
			if(customerOrSupplier==1 && json!=null ){
				//SupctoCommodity插入信息
				SupctoCommodity supctoCommodity;
				 for(int i=0;i<json.size();i++){
					   JSONObject obj = json.getJSONObject(i);  // 遍历 jsonarray 数组，把每一个对象转成 json 对象
					   supctoCommodity = new SupctoCommodity();
					   supctoCommodity.setSupctoId(id);
					   supctoCommodity.setCommodityId((Integer)obj.get("id"));
					   supctoCommodity.setPrice((Double.parseDouble(obj.get("price").toString())));
					   supctoCommodityService.insert(supctoCommodity);
				 }
			}
			
			
			
			
			
			if(customerOrSupplier == 1){//客户
				log.setOperateType(Constants.TYPE_LOG_CUSTOMER);
			}else{//供应商
				log.setOperateType(Constants.TYPE_LOG_SUPPLIER);
			}
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
	@RequestMapping(value = "updateSupctoById", method = RequestMethod.POST)
	public JSONObject updateSupctoById(HttpServletRequest request,  Supcto supcto) throws Exception {
		String goodsObj = supcto.getGoodsObj();
		JSONArray json = JSONArray.parseArray(goodsObj);
		
		
		String province = supcto.getProvinceCode();
		String city = supcto.getCityCode();
		String area = supcto.getAreaCode();
		
		String provinceCode = supcto.getProvince();
		String cityCode = supcto.getCity();
		String areaCode = supcto.getArea();
		if(!"-1".equals(provinceCode)&&provinceCode!=null){
			supcto.setProvince(province);
			supcto.setProvinceCode(provinceCode);
		}else{
			supcto.setProvince("");
			supcto.setProvinceCode("");
		}
		if(!"-1".equals(cityCode)&&cityCode!=null){
			supcto.setCity(city);
			supcto.setCityCode(cityCode);
		}else{
			supcto.setCity("");
			supcto.setCityCode("");
		}
		if(!"-1".equals(areaCode)&&areaCode!=null){
			supcto.setArea(area);
			supcto.setAreaCode(areaCode);
		}else{
			supcto.setArea("");
			supcto.setAreaCode("");
		}
		
		
		
		JSONObject rmsg=new JSONObject();
		if (supctoService.updateByPrimaryKeySelective(supcto)>0) {
			int customerOrSupplier = supcto.getCustomerOrSupplier();
			int id = supcto.getId();
			//修改客户时修改客户往来产品表信息
			if(customerOrSupplier==1 && json!=null ){
				
				supctoCommodityService.deleteSupctoCommodityBySupctoId(id);//先删除信息
				//SupctoCommodity插入信息
				SupctoCommodity supctoCommodity;
				 for(int i=0;i<json.size();i++){
					   JSONObject obj = json.getJSONObject(i);  // 遍历 jsonarray 数组，把每一个对象转成 json 对象
					   supctoCommodity = new SupctoCommodity();
					   supctoCommodity.setSupctoId(id);
					   supctoCommodity.setCommodityId((Integer)obj.get("id"));
					   supctoCommodity.setPrice((Double.parseDouble(obj.get("price").toString())));
					   supctoCommodityService.insert(supctoCommodity);
				 }
			}
			
			
			//插入日志
			Log log =new Log();
		
			//操作类型
			if(customerOrSupplier == 1){//客户
				log.setOperateType(Constants.TYPE_LOG_CUSTOMER);
			}else{//供应商
				log.setOperateType(Constants.TYPE_LOG_SUPPLIER);
			}
			//操作对象
			String identifier=supctoService.selectByPrimaryKey(id).getIdentifier();
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
	 * 修改
	 * @param request
	 * @param 
	 * @return
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "editSupctoById", method = RequestMethod.POST)
	public JSONObject editSupctoById(HttpServletRequest request,  Supcto supcto) throws Exception {
		
		String goodsObj = supcto.getGoodsObj();
		JSONArray json = JSONArray.parseArray(goodsObj);
		
		
		String province = supcto.getProvinceCode();
		String city = supcto.getCityCode();
		String area = supcto.getAreaCode();
		
		String provinceCode = supcto.getProvince();
		String cityCode = supcto.getCity();
		String areaCode = supcto.getArea();
		if(!"-1".equals(provinceCode)&&provinceCode!=null){
			supcto.setProvince(province);
			supcto.setProvinceCode(provinceCode);
		}else{
			supcto.setProvince("");
			supcto.setProvinceCode("");
		}
		if(!"-1".equals(cityCode)&&cityCode!=null){
			supcto.setCity(city);
			supcto.setCityCode(cityCode);
		}else{
			supcto.setCity("");
			supcto.setCityCode("");
		}
		if(!"-1".equals(areaCode)&&areaCode!=null){
			supcto.setArea(area);
			supcto.setAreaCode(areaCode);
		}else{
			supcto.setArea("");
			supcto.setAreaCode("");
		}
		
		
		//新增一条新数据  设置新数据的相关信息
		int pId = supcto.getId();
		//根据id获取原数据信息
		Supcto s = supctoService.selectByPrimaryKey(pId);
		//1、编号为原数据的编号
		supcto.setIdentifier(s.getIdentifier());
		//2、操作时间为原单据生成时间
		supcto.setOperatorTime(s.getOperatorTime());
		//3、操作人编号为原单据操作人编号
		supcto.setOperatorIdentifier(s.getOperatorIdentifier());
		//4、状态为9（修改待审核）
		supcto.setState(9);
		//5、是否停用为1（未停用）
		supcto.setUseable(1);
		//6、父id为原数据id
		supcto.setParentId(pId);
		//7、id清空  
		supcto.setId(null);
		
		
		//处理页面disabled传不过来值的情况
		supcto.setName(s.getName());
		supcto.setMemoryCode(s.getMemoryCode());
		supcto.setRatepaying(s.getRatepaying());
		supcto.setSettlementTypeId(s.getSettlementTypeId());
		
		
		JSONObject rmsg=new JSONObject();
		if (supctoService.insertSelective(supcto)>0) {//新增一条新数据
			//修改原数据的显示或隐藏为隐藏
			Supcto pSupcto = new Supcto();
			pSupcto.setId(pId);
			pSupcto.setIsShow(2);
			supctoService.updateByPrimaryKeySelective(pSupcto);
			
			//处理往来产品信息
			int customerOrSupplier = supcto.getCustomerOrSupplier();
			
			if(customerOrSupplier==1 && json!=null ){
				int id = supcto.getId();
				//SupctoCommodity插入信息
				SupctoCommodity supctoCommodity;
				 for(int i=0;i<json.size();i++){
					   JSONObject obj = json.getJSONObject(i);  // 遍历 jsonarray 数组，把每一个对象转成 json 对象
					   supctoCommodity = new SupctoCommodity();
					   supctoCommodity.setSupctoId(id);
					   supctoCommodity.setCommodityId((Integer)obj.get("id"));
					   supctoCommodity.setPrice((Double.parseDouble(obj.get("price").toString())));
					   supctoCommodityService.insert(supctoCommodity);
				 }
			}
			
			
			//插入日志
			Log log =new Log();
		
			//操作类型
			if(customerOrSupplier == 1){//客户
				log.setOperateType(Constants.TYPE_LOG_CUSTOMER);
			}else{//供应商
				log.setOperateType(Constants.TYPE_LOG_SUPPLIER);
			}
			//操作对象
			String identifier=s.getIdentifier();
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
	 * 恢复
	 * @param request
	 * @param 
	 * @return
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "updateSupctoUsableById", method = RequestMethod.POST)
	public JSONObject updateSupctoUsableById(HttpServletRequest request,  Supcto supcto) throws Exception {
		
		JSONObject rmsg=new JSONObject();
		if (supctoService.updateByPrimaryKeySelective(supcto)>0) {
			
			//插入日志
			Log log =new Log();
			int id = supcto.getId();
			int customerOrSupplier = supcto.getCustomerOrSupplier();
			//操作类型
			if(customerOrSupplier == 1){//客户
				log.setOperateType(Constants.TYPE_LOG_CUSTOMER);
			}else{//供应商
				log.setOperateType(Constants.TYPE_LOG_SUPPLIER);
			}
			//操作对象
			String identifier=supctoService.selectByPrimaryKey(id).getIdentifier();
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
	 * 送审、通过、驳回、删除
	 * @param request
	 * @param ids id数组
	 * @param flag 2：送审  3：审核通过  4：审核未通过  5：停用待审核  6：停用审核驳回  7：已停用  8：已删除
	 * @param customerOrSupplier 1:客户  2：供应商
	 * @return
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "updateStateByIds", method = RequestMethod.POST)
	public JSONObject updateStateByIds(HttpServletRequest request,String[] ids, int flag,int customerOrSupplier) throws Exception {
	
		
		ArrayList<Integer> list=new ArrayList<Integer>();
		if(ids!=null && ids.length>0){
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}
		
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ids", list);
		
		
		JSONObject rmsg=new JSONObject();
		switch (flag) {
		case 2:
			map.put("state", Constants.STATE_SUPCTO_CHECKING);
			map.put("useable",null);
			rmsg.put("msg","操作成功，已送审！");
			break;
		case 3:
			map.put("state", Constants.STATE_SUPCTO_PASS);
			map.put("useable",null);
			rmsg.put("msg","操作成功，已通过！");
			break;
		case 4:
			map.put("state", Constants.STATE_SUPCTO_REFUSED);
			map.put("useable",null);
			rmsg.put("msg","操作成功，已驳回！");
			break;
		case 5:
			map.put("state", Constants.STATE_SUPCTO_DISABLEDCHECKING);
			map.put("useable",null);
			rmsg.put("msg","操作成功，已申请停用！");
			break;
		case 6:
			map.put("state", Constants.STATE_SUPCTO_DISABLEDREFUSED);
			map.put("useable",null);
			rmsg.put("msg","操作成功，已驳回！");
			break;
		case 7:
			map.put("state", Constants.STATE_SUPCTO_DISABLEDPASS);
			map.put("useable",2);
			rmsg.put("msg","操作成功，已通过！");
			break;
		case 8:
			if(customerOrSupplier == 2) {//删除供应商   判断有没有关联的商品/采购订单
				//判断有没有被占用 如果有 返回编号
				List<Supcto> supctoIdentifier1 =  supctoService.selectSupctoIdentifierByIdAndCommodity(list);
				if(supctoIdentifier1.size()>0){
					String str="";
					for (int i = 0; i < supctoIdentifier1.size(); i++) {
						str += supctoIdentifier1.get(i).getIdentifier();
						if(i<supctoIdentifier1.size()-1){
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的供应商("+str+")有关联的商品,删除失败！");
					return rmsg;
				}
				//判断有没有被占用 如果有 返回编号
				List<Supcto> supctoIdentifier2 =  supctoService.selectSupctoIdentifierFromProcureTableByIds(list);
				if(supctoIdentifier2.size()>0){					
					String str="";
					for (int i = 0; i < supctoIdentifier2.size(); i++) {
						str += supctoIdentifier2.get(i).getIdentifier();
						if(i<supctoIdentifier2.size()-1){
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的供应商("+str+")有关联的采购订单,删除失败！");
					return rmsg;
				}
			}else {//删除客户   判断有没有关联的销售订单/销售计划单
				//判断有没有被占用 如果有 返回编号
				List<Supcto> supctoIdentifier3 =  supctoService.selectSupctoIdentifierFromSalesOrderByIds(list);
				if(supctoIdentifier3.size()>0){	
					String str="";
					for (int i = 0; i < supctoIdentifier3.size(); i++) {
						str += supctoIdentifier3.get(i).getIdentifier();
						if(i<supctoIdentifier3.size()-1){
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的供应商("+str+")有关联的销售订单,删除失败！");
					return rmsg;
				}
				//判断有没有被占用 如果有 返回编号
				List<Supcto> supctoIdentifier4 =  supctoService.selectSupctoIdentifierFromSalesPlanOrderByIds(list);
				if(supctoIdentifier4.size()>0){	
					String str="";
					for (int i = 0; i < supctoIdentifier4.size(); i++) {
						str += supctoIdentifier4.get(i).getIdentifier();
						if(i<supctoIdentifier4.size()-1){
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的供应商("+str+")有关联的销售计划单,删除失败！");
					return rmsg;
				}
				
			}
			//判断有没有被bills占用 如果有 返回编号
			List<Supcto> supctoIdentifier5 =  supctoService.selectSupctoIdentifierFromBillsByIds(list);
			if(supctoIdentifier5.size()>0){
				String str="";
				for (int i = 0; i < supctoIdentifier5.size(); i++) {
					str += supctoIdentifier5.get(i).getIdentifier();
					if(i<supctoIdentifier5.size()-1){
						str += ",";
					}
				}
				rmsg.put("success", false);
				rmsg.put("msg", "要删除的供应商/客户("+str+")有关联的应收应付信息,删除失败！");
				return rmsg;
			}
			//判断有没有被bills占用 如果有 返回编号
			List<Supcto> supctoIdentifier6 =  supctoService.selectSupctoIdentifierFromWriteOffByIds(list);
			if(supctoIdentifier6.size()>0){
				String str="";
				for (int i = 0; i < supctoIdentifier6.size(); i++) {
					str += supctoIdentifier6.get(i).getIdentifier();
					if(i<supctoIdentifier6.size()-1){
						str += ",";
					}
				}
				rmsg.put("success", false);
				rmsg.put("msg", "要删除的供应商/客户("+str+")有关联的应收应付信息,删除失败！");
				return rmsg;
			}
			
			
			map.put("state", 11);
			map.put("useable",null);
			rmsg.put("msg","操作成功，已删除！");
			break;

		default:
			break;
		}
		
		
		
		
		if (supctoService.updateStateByIds(map)) {
			//保存操作的对象编号
			List<Supcto> supctos = supctoService.getSupctoByIds(list);
			//插入日志
			Log log =new Log();
			String operateObject="";
			switch (flag) {
			case 2:
				//操作类型
				if(customerOrSupplier == 1){
					log.setOperateType(Constants.TYPE_LOG_CUSTOMER);
				}else{
					log.setOperateType(Constants.TYPE_LOG_SUPPLIER);
				}
				
			 
				break;
			case 3:
				//操作类型
				log.setOperateType(Constants.TYPE_LOG_CHECK);
				break;
			case 4:
				//操作类型
				log.setOperateType(Constants.TYPE_LOG_CHECK);
				break;
			case 5:
				//操作类型
				if(customerOrSupplier == 1){
					log.setOperateType(Constants.TYPE_LOG_CUSTOMER);
				}else{
					log.setOperateType(Constants.TYPE_LOG_SUPPLIER);
				}
				
			 
				break;
			case 6:
				//操作类型
				log.setOperateType(Constants.TYPE_LOG_CHECK);
				break;
			case 7:
				//操作类型
				log.setOperateType(Constants.TYPE_LOG_CHECK);
				break;
			case 8:
				//操作类型
				if(customerOrSupplier == 1){
					log.setOperateType(Constants.TYPE_LOG_CUSTOMER);
				}else{
					log.setOperateType(Constants.TYPE_LOG_SUPPLIER);
				}
				break;

			default:
				break;
			}
			
			//操作对象
			operateObject="";
			for (int i = 0; i < supctos.size(); i++) {
				operateObject += supctos.get(i).getIdentifier();
				if(i < supctos.size()-1){
					operateObject += ",";
				}
			}
			if(flag == 8) {
				operateObject += "("+Constants.OPERATE_DELETE+")";
			}else {
				operateObject += "("+Constants.OPERATE_UPDATE+")";
			}
			
			log.setOperateObject(operateObject);
	
			//操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			//操作时间
			Date operateTime=new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);

			rmsg.put("success", true);
			
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败，请确认后重新操作！");
		return rmsg;
	}
	
	/**
	 * 修改驳回
	 * @param request
	 * @param ids id数组
	 * @param customerOrSupplier 1:客户  2：供应商
	 * @return
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "editReject", method = RequestMethod.POST)
	public JSONObject editReject(HttpServletRequest request,String[] ids, int customerOrSupplier) throws Exception {
		JSONObject rmsg=new JSONObject();
		
		ArrayList<Integer> list=new ArrayList<Integer>();
		if(ids!=null && ids.length>0){
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}
		
		//遍历数据获取相关数据的父ID和编号
	
		//保存操作的对象编号
		List<Supcto> supctos = supctoService.getSupctoByIds(list);
		//保存操作数据（新数据）的父id
		ArrayList<Integer> pIds = new ArrayList<>();
		String operateObject="";
		//操作对象
		for (int i = 0; i < supctos.size(); i++) {
			pIds.add(supctos.get(i).getParentId());//获取操作数据的父ID并加入列表
			operateObject += supctos.get(i).getIdentifier();
			if(i < supctos.size()-1){
				operateObject += ",";
			}
		}
		operateObject += "("+Constants.OPERATE_UPDATE+")";
		
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ids", pIds);
		map.put("isShow", 1);
		map.put("state", 10);
		
		if (supctoService.updateStateByIds(map)) {//更改原数据显示/隐藏为显示  且状态为10（修改审核驳回）
			//删除新数据
			supctoService.deleteSupctoByIds(list);
			if(customerOrSupplier == 1) {//客户
				//删除相关的往来产品
				supctoCommodityService.deleteSupctoCommodityBySupctoIds(list);
			}
			
			//插入日志
			Log log =new Log();
			//操作对象
			log.setOperateObject(operateObject);
			
			//操作类型
			log.setOperateType(Constants.TYPE_LOG_CHECK);
	
			//操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			//操作时间
			Date operateTime=new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);

			rmsg.put("success", true);
			rmsg.put("msg","操作成功，已驳回！");
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败，请确认后重新操作！");
		return rmsg;
	}
	
	
	/**
	 * 修改通过
	 * @param request
	 * @param ids id数组
	 * @param customerOrSupplier 1:客户  2：供应商
	 * @return
	 * @throws Exception
	 */
	
	@ResponseBody
	@RequestMapping(value = "editPass", method = RequestMethod.POST)
	public JSONObject editPass(HttpServletRequest request,String[] ids, int customerOrSupplier) throws Exception {
		JSONObject rmsg=new JSONObject();
		
		ArrayList<Integer> list=new ArrayList<Integer>();
		if(ids!=null && ids.length>0){
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}
		
		//遍历数据获取相关数据的父ID和编号
	
		//保存操作的对象编号
		List<Supcto> supctos = supctoService.getSupctoByIds(list);
		
		Supcto supcto;
		int pId,id;
		String operateObject="";
		Map<String, Object> map=new HashMap<String, Object>();
		
		try {
			for (int i = 0; i < supctos.size(); i++) {
				supcto = supctos.get(i);
				id = supcto.getId();
				pId = supcto.getParentId(); 
				//保存操作的对象编号
				operateObject += supctos.get(i).getIdentifier();
				if(i < supctos.size()-1){
					operateObject += ",";
				}
				//删除原数据
				supctoService.deleteByPrimaryKey(pId);
				if(customerOrSupplier == 1) {//客户
					//删除相关的往来产品
					supctoCommodityService.deleteSupctoCommodityBySupctoId(pId);
				}
				//更新新数据  1：状态修改为3  2：id修改为父id  3： 清空父id
				supctoService.updateNewDataById(id);
				//更新往来产品相关的客户id
				if(customerOrSupplier == 1) {//客户
					map.put("oldId", id);
					map.put("newId", pId);
					supctoCommodityService.updateSupctoIdBySupctoId (map);
				}
				
			}
			operateObject += "("+Constants.OPERATE_UPDATE+")";
			//插入日志
			Log log =new Log();
			//操作对象
			log.setOperateObject(operateObject);
			
			//操作类型
			log.setOperateType(Constants.TYPE_LOG_CHECK);

			//操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			//操作时间
			Date operateTime=new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);

			rmsg.put("success", true);
			rmsg.put("msg","操作成功，已通过！");
			return rmsg;
		} catch (Exception e) {
			rmsg.put("success", false);
			rmsg.put("msg", "操作失败，请确认后重新操作！");
			return rmsg;
		}
		
		
		
		
		
		
		
		/*//保存操作数据（新数据）的父id
		ArrayList<Integer> pIds = new ArrayList<>();
		String operateObject="";
		//操作对象
		for (int i = 0; i < supctos.size(); i++) {
			pIds.add(supctos.get(i).getParentId());//获取操作数据的父ID并加入列表
			operateObject += supctos.get(i).getIdentifier();
			if(i < supctos.size()-1){
				operateObject += ",";
			}
		}
		operateObject += "("+Constants.OPERATE_UPDATE+")";
		
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ids", list);
		map.put("clear", 1);
		map.put("state", 3);
		
		if (supctoService.updateStateByIds(map)) {//更改新数据状态3（通过）且清空父Id
			//删除原数据
			supctoService.deleteSupctoByIds(pIds);
			if(customerOrSupplier == 1) {//客户
				//删除相关的往来产品
				supctoCommodityService.deleteSupctoCommodityBySupctoIds(pIds);
			}
			
			//插入日志
			Log log =new Log();
			//操作对象
			log.setOperateObject(operateObject);
			
			//操作类型
			log.setOperateType(Constants.TYPE_LOG_CHECK);
	
			//操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			//操作时间
			Date operateTime=new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);

			rmsg.put("success", true);
			rmsg.put("msg","操作成功，已通过！");
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败，请确认后重新操作！");
		return rmsg;*/
	}
	
	

	/**
	 * 删除（根据id列表删）
	 * @param request
	 * @param ids  id数组
	 * @param  customerOrSupplier 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "deleteSupctoByIds", method = RequestMethod.POST)
	public JSONObject deleteSupctoByIds(HttpServletRequest request, String[] ids,int customerOrSupplier) throws Exception {
		
		JSONObject rmsg=new JSONObject();
		
		ArrayList<Integer> list=new ArrayList<Integer>();
		if(ids!=null && ids.length>0){
			for(String id:ids){
				int int_id = Integer.valueOf(id);
				list.add(int_id);
			}
		}
		if(customerOrSupplier == 2) {//删除供应商   判断有没有关联的商品/采购订单
			//判断有没有被占用 如果有 返回编号
			List<Supcto> supctoIdentifier1 =  supctoService.selectSupctoIdentifierByIdAndCommodity(list);
			if(supctoIdentifier1.size()>0){
				String str="";
				for (int i = 0; i < supctoIdentifier1.size(); i++) {
					str += supctoIdentifier1.get(i).getIdentifier();
					if(i<supctoIdentifier1.size()-1){
						str += ",";
					}
				}
				rmsg.put("success", false);
				rmsg.put("msg", "要删除的供应商("+str+")有关联的商品,删除失败！");
				return rmsg;
			}
			//判断有没有被占用 如果有 返回编号
			List<Supcto> supctoIdentifier2 =  supctoService.selectSupctoIdentifierFromProcureTableByIds(list);
			if(supctoIdentifier2.size()>0){					
				String str="";
				for (int i = 0; i < supctoIdentifier2.size(); i++) {
					str += supctoIdentifier2.get(i).getIdentifier();
					if(i<supctoIdentifier2.size()-1){
						str += ",";
					}
				}
				rmsg.put("success", false);
				rmsg.put("msg", "要删除的供应商("+str+")有关联的采购订单,删除失败！");
				return rmsg;
			}
		}else {//删除客户   判断有没有关联的销售订单/销售计划单
			//判断有没有被占用 如果有 返回编号
			List<Supcto> supctoIdentifier3 =  supctoService.selectSupctoIdentifierFromSalesOrderByIds(list);
			if(supctoIdentifier3.size()>0){	
				String str="";
				for (int i = 0; i < supctoIdentifier3.size(); i++) {
					str += supctoIdentifier3.get(i).getIdentifier();
					if(i<supctoIdentifier3.size()-1){
						str += ",";
					}
				}
				rmsg.put("success", false);
				rmsg.put("msg", "要删除的供应商("+str+")有关联的销售订单,删除失败！");
				return rmsg;
			}
			//判断有没有被占用 如果有 返回编号
			List<Supcto> supctoIdentifier4 =  supctoService.selectSupctoIdentifierFromSalesPlanOrderByIds(list);
			if(supctoIdentifier4.size()>0){	
				String str="";
				for (int i = 0; i < supctoIdentifier4.size(); i++) {
					str += supctoIdentifier4.get(i).getIdentifier();
					if(i<supctoIdentifier4.size()-1){
						str += ",";
					}
				}
				rmsg.put("success", false);
				rmsg.put("msg", "要删除的供应商("+str+")有关联的销售计划单,删除失败！");
				return rmsg;
			}
			
		}
		//判断有没有被bills占用 如果有 返回编号
		List<Supcto> supctoIdentifier5 =  supctoService.selectSupctoIdentifierFromBillsByIds(list);
		if(supctoIdentifier5.size()>0){
			String str="";
			for (int i = 0; i < supctoIdentifier5.size(); i++) {
				str += supctoIdentifier5.get(i).getIdentifier();
				if(i<supctoIdentifier5.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的供应商/客户("+str+")有关联的应收应付信息,删除失败！");
			return rmsg;
		}
		//判断有没有被bills占用 如果有 返回编号
		List<Supcto> supctoIdentifier6 =  supctoService.selectSupctoIdentifierFromWriteOffByIds(list);
		if(supctoIdentifier6.size()>0){
			String str="";
			for (int i = 0; i < supctoIdentifier6.size(); i++) {
				str += supctoIdentifier6.get(i).getIdentifier();
				if(i<supctoIdentifier6.size()-1){
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的供应商/客户("+str+")有关联的应收应付信息,删除失败！");
			return rmsg;
		}
		
		
		//保存将要删除的对象编号
		List<Supcto> supctos = supctoService.getSupctoByIds(list);
		if (supctoService.deleteSupctoByIds(list)) {
			supctoCommodityService.deleteSupctoCommodityBySupctoIds(list);//删除SupctoCommodity信息
			//插入日志
			Log log =new Log();
			//操作类型
			if(customerOrSupplier == 1){//客户
				log.setOperateType(Constants.TYPE_LOG_CUSTOMER);
			}else{//供应商
				log.setOperateType(Constants.TYPE_LOG_SUPPLIER);
			}
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
	 * @param flag 标志 1：管理页面   2:审核页面
	 * @param customerOrSupplier 客户/供应商：1：客户   2：供应商
	 * @param classificationId
	 * @param name
	 * @param fromType
	 * @param state
	 * @param provinceCode
	 * @param cityCode
	 * @param areaCode
	 * @param operatorIdentifier
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="exportSupcto")
	public boolean exportSupcto(HttpServletRequest request,HttpServletResponse response,
			Integer flag ,Integer customerOrSupplier,
			String classificationId, String name, String fromType,String state,
			String provinceCode, String cityCode, String areaCode,
			String operatorIdentifier) throws Exception{
		
		classificationId = URLDecoder.decode(classificationId, "UTF-8");
		fromType = URLDecoder.decode(fromType, "UTF-8");
		state = URLDecoder.decode(state, "UTF-8");
		provinceCode = URLDecoder.decode(provinceCode, "UTF-8");
		cityCode = URLDecoder.decode(cityCode, "UTF-8");
		areaCode = URLDecoder.decode(areaCode, "UTF-8");
		name = URLDecoder.decode(name, "UTF-8");
		operatorIdentifier = URLDecoder.decode(operatorIdentifier, "UTF-8");
		
		String fileName = "";//文档名称以及Excel里头部信息
		List<Supcto> supctos=supctoService.selectMsgOrderBySearchMsg(
				flag,customerOrSupplier, 
				classificationId,name,fromType, state,
				provinceCode,cityCode,areaCode,
				operatorIdentifier);
		List<String[]> dataList=new ArrayList<>();
		String[] title; //保存Excel表头
		String[] value; //保存要导出的内容
		if(flag == 1 && customerOrSupplier == 1){
			fileName = "客户信息";//管理页面文档名称以及Excel里头部信息
		}
		else if(flag == 2 && customerOrSupplier == 1){
			fileName = "客户审核信息";//审核页面文档名称以及Excel里头部信息
		}else if(flag == 1 && customerOrSupplier == 2){
			fileName = "供应商信息";//管理页面文档名称以及Excel里头部信息
		}
		else if(flag == 2 && customerOrSupplier == 2){
			fileName = "供应商审核信息";//审核页面文档名称以及Excel里头部信息
		}
		//搜索的有数据
		if(supctos.size()>0){
			//需导出的表头与信息
			
			//保存Excel表头
			title=new String[35];
			title[0]="是否停用";
			title[1]="编号";
			title[2]="单位名称";
			title[3]="全称";
			if(customerOrSupplier==1){
				title[4]="客户编码";
			}else{
				title[4]="供应商编码";
			}
			title[5]="等级";
			title[6]="分类";
			title[7]="往来类型";
			title[8]="结算方式";
			title[9]="联系手机";
			title[10]="联系人";
			title[11]="常用电话";
			title[12]="备用电话";
			title[13]="通讯地址";
			title[14]="运输方式";
			title[15]="邮编";
			title[16]="传真";
			title[17]="网址";
			title[18]="银行账号 ";
			title[19]="开户银行";
			title[20]="纳税识别编号";
			title[21]="邮箱";
			title[22]="发票类型";
			if(customerOrSupplier==1){
				title[23]="送货地址";
			}else{
				title[23]="供应商地址";
			}
			title[24]="信用天数";
			title[25]="信用金额";
			title[26]="币种";
			title[27]="默认税率";
			title[28]="部门";
			title[29]="业务员";
			title[30]="备注";
			title[31]="操作人";
			title[32]="操作时间";
			title[33]="状态";
			if(customerOrSupplier==1){
				title[34]="地址";
			}
			
			
			
			//保存要导出的内容
			for(Supcto c:supctos){
				value=new String[35];
				switch (c.getUseable()) {
				case 1:
					value[0]="未停用";
					break;
				case 2:
					value[0]="已停用";
					break;
				default:
					break;
				}
				value[1] = c.getIdentifier();
				value[2] = c.getName();
				value[3] = c.getFullName();
				value[4] = c.getMemoryCode();
				if(c.getFrade()==null){
					value[5]="";
				}else{
					switch (c.getFrade()) {
					case 1:
						value[5]="一级";
						break;
					case 2:
						value[5]="二级";
						break;
					case 3:
						value[5]="三级";
						break;
					default:
						value[5]="";
						break;
					}
				}
				
				if(c.getClassification()==null){
					value[6]="";	
				}else{
					value[6]=c.getClassification().getName();	
				}
				
				if(c.getFromType()==null){
					value[7]="";	
				}else{
					switch (c.getFromType()) {
					case 1:
						value[7]="账期";
						break;
					case 2:
						value[7]="现金";
						break;
					default:
						value[7]="";
						break;
					}
				}
				
				value[8]=c.getSettlementType().getName();
				value[9]=c.getPhone();
				value[10]=c.getContactPeople();
				value[11]=c.getCommonPhone();
				value[12]=c.getReservePhone();
				value[13]=c.getCommunicationAddress();
				if(c.getShippingModeId()==null){
					value[14]="";	
				}else if(c.getShippingMode() == null){
					value[14]="";
				}else {
					value[14]=c.getShippingMode().getName();
				}
				value[15]=c.getPostcode();
				value[16]=c.getFax();
				value[17]=c.getWebsite();
				value[18]=c.getBankAccount();
				value[19]=c.getBank();
				value[20]=c.getRatepaying();
				value[21]=c.getMailbox();
				if(c.getInvoiceType()==null){
					value[22]="";	
				}else{
					switch (c.getInvoiceType()) {
					case 1:
						value[22]="增票";
						break;
					case 2:
						value[22]="普票";
						break;
					
					default:
						value[22]="";
						break;
					}
				}
				value[23]=c.getDeliveryAddress();
				if(c.getCreditDays() == null){
					value[24]="";
				}else{
					value[24]=c.getCreditDays()+"天";
				}
				if(c.getCreditMoney() == null){
					value[25]="";
				}else{
					value[25]=c.getCreditMoney()+"元";
				}
				
				if(c.getCurrency()!=null && c.getCurrency()==1) {
					value[26]="人民币";
				}else{
					value[26]="";
				}
				
				
				if(c.getTaxes() == null){
					value[27]="";
				}else{
					value[27]=c.getTaxes()+"";
				}
				if(c.getDepartment() == null){
					value[28]="";
				}else{
					value[28]=c.getDepartment().getName();
				}
				if(c.getPerson() == null){
					value[29]="";
				}else{
					value[29]=c.getPerson().getName();
				}
				
				
				value[30]=c.getRemark();
				
				value[31]=c.getOperatorIdentifier()+"("+c.getUser().getName()+")";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				value[32]=sdf.format(c.getOperatorTime());
				switch (c.getState()) {
				case 1:
					value[33]="未送审";
					break;
				case 2:
					value[33]="待审核";
					break;
				case 3:
					value[33]="已通过";
					break;
				case 4:
					value[33]="已驳回";
					break;
				case 5:
					value[33]="停用待审核";
					break;
				case 6:
					value[33]="停用审核驳回";
					break;
				case 7:
					value[33]="已停用";
					break;
				case 8:
					value[33]="已恢复使用";
					break;
				default:
					break;
				}
				if(customerOrSupplier==1){
					value[34]=c.getProvince()+c.getCity()+c.getArea();
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
	@ResponseBody
	@RequestMapping(value = "/getSupcto", method = RequestMethod.POST)
	public	Supcto getSupcto(HttpServletRequest request, Integer id) throws Exception {
		
		return supctoService.selectByPrimaryKey(id);
		
	}
	
}