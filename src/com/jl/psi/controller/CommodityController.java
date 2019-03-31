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

import org.apache.cxf.binding.corba.wsdl.Array;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jl.psi.model.Classification;
import com.jl.psi.model.Commodity;
import com.jl.psi.model.CommoditySpecification;
import com.jl.psi.model.Inventory;
import com.jl.psi.model.Log;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.model.SalesOrderCommodity;
import com.jl.psi.model.SettlementType;
import com.jl.psi.model.Supcto;
import com.jl.psi.model.SupctoCommodity;
import com.jl.psi.model.Unit;
import com.jl.psi.service.CommodityService;
import com.jl.psi.service.CommoditySpecificationService;
import com.jl.psi.service.InventoryService;
import com.jl.psi.service.LogService;
import com.jl.psi.service.ProcureTableService;
import com.jl.psi.service.SalesOrderService;
import com.jl.psi.service.SupctoCommodityService;
import com.jl.psi.service.UnitService;
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

import net.sf.json.JSONArray;

import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping("/basic/goods/commodity/")
public class CommodityController extends BaseController {
	// 当前类操作的类型(往log日志表中存储)
	private int operateType = Constants.TYPE_LOG_GOODS;
	// 声明Log类
	Log log;
	@Autowired
	CommodityService commodityService;
	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	@Autowired
	LogService logService;
	@Autowired
	UnitService unitService;
	@Autowired
	InventoryService inventoryService;
	@Autowired
	SupctoCommodityService supctoCommodityService;
	@Autowired
	ProcureTableService procureTableService;
	@Autowired
	SalesOrderService salesOrderService;
	

	/**
	 * 进入商品管理页面/商品审批页面
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
		// 商品管理页面
		case 1:
			pageName = "junlin/jsp/basic/goods/goodsManager";
			break;
		// 商品审批页面 ----已不需要
		case 2:
			pageName = "junlin/jsp/basic/goods/goodsDelivery";
			break;
		//采购填写销售价格
		case 3:
			pageName = "junlin/jsp/basic/goods/minSalesPrice";
			break;
		//采购审批
		case 4:
			pageName = "junlin/jsp/basic/goods/purchaseDelivery";
			break;
		//销售填写一般销售价格----已不需要
		case 5:
			pageName = "junlin/jsp/basic/goods/generalSalesPrice";
			break;
		//销售审批----已不需要
		case 6:
			pageName = "junlin/jsp/basic/goods/salesAudit";
			break;
		//查看商品页面
		case 7:
			pageName = "junlin/jsp/basic/goods/lookGoodsMessage";
			break;
		//采购修改总经理审批
		case 8:
			pageName = "junlin/jsp/basic/goods/managerDelivery";
			break;
		default:
			break;
		}

		return pageName;

	}

	/**
	 * 根据搜索条件获取商品规格的信息，显示在界面上
	 * 
	 * @param request
	 * @param messageOrDelivery
	 *            1:商品详情，2：采购填写页面 3：采购审核页面 4：销售填写页面 5：销售审批页面 ，6：查看商品页面，7：采购修改总经理审批页面
	 * @param identifier
	 *            分类编号
	 * @param name
	 *            分类名称
	 * @param operatorName
	 *            操作人姓名
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getCommodityMsg")
	public DataTables getCommodityMsg(HttpServletRequest request, Integer messageOrDelivery, Integer classificationId,
			String name, String operatorName, Integer supctoId,String searchTime,Integer searchState) {
		DataTables dataTables = DataTables.createDataTables(request);
		String endTime=null;
		String startTime=null;
		if(searchTime!=null&&!"".equals(searchTime)){
			String []times=searchTime.split(" ~ ");
			if(times.length==2){
				startTime=times[0];
				endTime=times[1];
			}
			
		}	
		System.out.println("messageOrDelivery:"+messageOrDelivery);
		return commoditySpecificationService.getCommodityMsg(dataTables, messageOrDelivery, classificationId, name,
				operatorName, supctoId,startTime,endTime,searchState);
	}

	/**
	 * 根据输入的内容从数据库中获取所有商品信息 模糊查询
	 * 
	 * @param request
	 */
	@ResponseBody
	@RequestMapping(value = "selectCommodityMsgByInputValue")
	public List<Commodity> selectCommodityMsgByInputValue(HttpServletRequest request, String inputValue) {
		List<Commodity> commodities = commodityService.selectByName(inputValue);
		return commodities;
	}

	/**
	 * 根据商品名称获取商品信息
	 * 
	 * @param request
	 */
	@ResponseBody
	@RequestMapping(value = "selectCommodityMsgByName")
	public List<Commodity> selectCommodityMsgByName(HttpServletRequest request, String name) {
		Commodity commodity = commodityService.selectCommodityMsgByName(name);
		List<Commodity> list=new ArrayList<>();
		if(commodity!=null){
			list.add(commodity);
		}
		return list;
	}
	

	/**
	 * 商品信息的存储
	 * 
	 * @param request
	 * @param c
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addCommodityMsg", method = RequestMethod.POST)
	public JSONObject addCommodityMsg(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String c = request.getParameter("commodityData");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(c);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("commoditySpecifictions", CommoditySpecification.class); // key为teacher私有变量的属性名
		map.put("units", Unit.class); // key为teacher私有变量的属性名
		map.put("inventories", Inventory.class);
		// 把JSON串转换成对象
		Commodity commodity = (Commodity) net.sf.json.JSONObject.toBean(jsonobject, Commodity.class, map);
		 System.out.println("getIsAssemble:"+commodity.getIsAssemble());
		// 添加操作人编号，从session中获取
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		// 添加操作时间
		Date date = new Date();
		// 保存已经添加好单位和库存的商品规格id，以供添加失败时的删除操作
		List<Integer> commoditySpecificationIds = new ArrayList<>();
		// 保存已经添加的商品规格编号，以供log日志的存储
		List<String> commoditySpecificationIdentifiers = new ArrayList<>();
		// 商品信息已存在，现只新增规格
		if (commodity.getId() != null && commodity.getId() > 0) {
			// 获取该商品下最大的规格，截取后两位进行加一的操作
			String maxSpecificationIdentifier = commoditySpecificationService
					.selectMaxSpecificationIdentifierByCommodityId(commodity.getId());
			int index = 0;
			for (CommoditySpecification cs : commodity.getCommoditySpecifictions()) {
				index++;
				// 添加编号--在商品编号的基础上添加
				String specificationIdentifier = commodity.getIdentifier();

				if (maxSpecificationIdentifier == null || "".equals(maxSpecificationIdentifier)) {
					specificationIdentifier += "00";
				} else {
					String oldlasttwoMunString = maxSpecificationIdentifier
							.substring(maxSpecificationIdentifier.length() - 2, maxSpecificationIdentifier.length());
					String lastTwpMun = (Integer.parseInt(oldlasttwoMunString) + index) + "";

					if (lastTwpMun.length() == 1) {
						specificationIdentifier += "0" + lastTwpMun;
					} else {
						if (lastTwpMun.length() > 2) {
							specificationIdentifier += "00";
						} else {
							specificationIdentifier += lastTwpMun;
						}

					}
				}
				cs.setSpecificationIdentifier(specificationIdentifier);

				cs.setCommodityId(commodity.getId());
				cs.setOperatorIdentifier(userIdentifier);
				cs.setOperatorTime(date);
				// 默认设置为未删除
				cs.setIsDelete(0);
				// 默认设置为采购审核
				cs.setState(9);
			}
			if (commoditySpecificationService.insertBatch(commodity.getCommoditySpecifictions())) {

				for (CommoditySpecification cs : commodity.getCommoditySpecifictions()) {
					for (Unit u : cs.getUnits()) {
						u.setSpecificationId(cs.getId());
					}
					for (Inventory in : cs.getInventories()) {
						in.setSpecificationId(cs.getId());
					}
					if (unitService.insertBatch(cs.getUnits()) == cs.getUnits().size()) {
						// 有库存信息时，需要往库存表中存储信息
						if (cs.getInventories().size() > 0) {
							//System.out.println("库存：" + cs.getInventories().get(0).getCommodityNum());
							if (inventoryService.insertBatch(cs.getInventories()) == cs.getInventories().size()) {
								// 所有信息添加成功
								commoditySpecificationIds.add(cs.getId());
								// log记录所有规格编号
								commoditySpecificationIdentifiers.add(cs.getSpecificationIdentifier());

							} else {
								// 单位以及库存mapper里的删除参数改为list
								// 根据商品规格ID列表 删除可能存储好的库存信息
								inventoryService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
								// 根据商品规格ID列表 删除存储好的单位信息
								unitService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
								// 根据商品ID删除存储好的商品规格信息
								commoditySpecificationService.deleteByCommodityId(commodity.getId());
								rmsg.put("success", false);
								rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
								return rmsg;
							}
						}
						// 无库存信息则不需要往库存表中存储信息
						else {
							// 所有信息添加成功
							commoditySpecificationIds.add(cs.getId());
							// log记录所有规格编号
							commoditySpecificationIdentifiers.add(cs.getSpecificationIdentifier());

						}
					} else {
						// 根据商品规格ID列表 删除可能存储好的单位信息
						unitService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
						// 根据商品ID删除存储好的商品规格信息
						commoditySpecificationService.deleteByCommodityId(commodity.getId());
						rmsg.put("success", false);
						rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
						return rmsg;
					}
				}

			}
		}
		// 新增商品和规格
		else {
			// 生成商品的编号 (年月日8位 二级分类编号5位 是否为允许0库存出库1位 冷库/常温库/等等2位 0001-9999)
			// commodity.setIdentifier(SundryCodeUtil.getPosCode(Constants.CODE_GOODS));
			String identifier = "";
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			identifier = dateFormat.format(date) + commodity.getClassificationId() + commodity.getZeroStock()
					+ commodity.getAttribute();
			String maxIdentifier = commodityService.selectMaxIdentifier();
			if (maxIdentifier == null || "".equals(maxIdentifier)) {
				identifier += "0000";
			} else {
				String oldlastFourMunString = maxIdentifier.substring(maxIdentifier.length() - 4,
						maxIdentifier.length());
				String lastFourMun = (Integer.parseInt(oldlastFourMunString) + 1) + "";
				//System.out.println("lastFourMun:" + lastFourMun);
				if (lastFourMun.length() == 1) {
					identifier += "000" + lastFourMun;
				} else if (lastFourMun.length() == 2) {
					identifier += "00" + lastFourMun;
				} else if (lastFourMun.length() == 3) {
					identifier += "0" + lastFourMun;
				} else {
					if (lastFourMun.length() > 4) {
						identifier += "0000";
					} else {
						identifier += lastFourMun;
					}

				}
			}
			commodity.setIdentifier(identifier);
			//System.out.println("identifier:" + identifier);
			if (commodityService.insertSelective(commodity) > 0) {
				// 获取该商品下最大的规格，截取后两位进行加一的操作
				String maxSpecificationIdentifier = commoditySpecificationService
						.selectMaxSpecificationIdentifierByCommodityId(commodity.getId());
				int index = 0;
				for (CommoditySpecification cs : commodity.getCommoditySpecifictions()) {
					index++;
					// 添加编号--在商品编号的基础上添加
					String specificationIdentifier = commodity.getIdentifier();

					if (maxSpecificationIdentifier == null || "".equals(maxSpecificationIdentifier)) {
						specificationIdentifier += "0" + (index - 1);
					} else {
						String oldlasttwoMunString = maxSpecificationIdentifier.substring(
								maxSpecificationIdentifier.length() - 2, maxSpecificationIdentifier.length());
						String lastTwpMun = (Integer.parseInt(oldlasttwoMunString) + index) + "";
						//System.out.println("lastTwpMun:" + lastTwpMun);
						if (lastTwpMun.length() == 1) {
							specificationIdentifier += "0" + lastTwpMun;
						} else {
							if (lastTwpMun.length() > 2) {
								specificationIdentifier += "00";
							} else {
								specificationIdentifier += lastTwpMun;
							}

						}
					}
					cs.setSpecificationIdentifier(specificationIdentifier);
					cs.setCommodityId(commodity.getId());
					cs.setOperatorIdentifier(userIdentifier);
					cs.setOperatorTime(date);
					// 默认设置为未删除
					cs.setIsDelete(0);
					// 默认设置为采购审核
					cs.setState(9);
				}
				if (commoditySpecificationService.insertBatch(commodity.getCommoditySpecifictions())) {

					for (CommoditySpecification cs : commodity.getCommoditySpecifictions()) {
						for (Unit u : cs.getUnits()) {
							u.setSpecificationId(cs.getId());
						}
						for (Inventory in : cs.getInventories()) {
							in.setSpecificationId(cs.getId());
						}
						if (unitService.insertBatch(cs.getUnits()) == cs.getUnits().size()) {
							// 有库存信息时，需要往库存表中存储信息
							if (cs.getInventories().size() > 0) {
								//System.out.println("库存：" + cs.getInventories().get(0).getCommodityNum());
								if (inventoryService.insertBatch(cs.getInventories()) == cs.getInventories().size()) {
									// 所有信息添加成功
									commoditySpecificationIds.add(cs.getId());
									// log记录所有规格编号
									commoditySpecificationIdentifiers.add(cs.getSpecificationIdentifier());

								} else {
									// 单位以及库存mapper里的删除参数改为list
									// 根据商品规格ID列表 删除可能存储好的库存信息
									inventoryService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
									// 根据商品规格ID列表 删除存储好的单位信息
									unitService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
									// 根据商品ID删除存储好的商品规格信息
									commoditySpecificationService.deleteByCommodityId(commodity.getId());
									// 删除存储好的商品信息
									commodityService.deleteByPrimaryKey(commodity.getId());
									rmsg.put("success", false);
									rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
									return rmsg;
								}
							}
							// 无库存信息则不需要往库存表中存储信息
							else {
								// 所有信息添加成功
								commoditySpecificationIds.add(cs.getId());
								// log记录所有规格编号
								commoditySpecificationIdentifiers.add(cs.getSpecificationIdentifier());

							}
						} else {
							// 根据商品规格ID列表 删除可能存储好的单位信息
							unitService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
							// 根据商品ID删除存储好的商品规格信息
							commoditySpecificationService.deleteByCommodityId(commodity.getId());
							// 删除存储好的商品信息
							commodityService.deleteByPrimaryKey(commodity.getId());
							rmsg.put("success", false);
							rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
							return rmsg;
						}
					}

				} else {
					// 删除存储好的商品信息
					commodityService.deleteByPrimaryKey(commodity.getId());
					rmsg.put("success", false);
					rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
					return rmsg;
				}

			}
		}

		// 添加成功后，在最外面判断list的长度是否是规格的长度，若是，则所有都添加成功，若不是，则删除所有添加好的，返回添加失败
		if (commoditySpecificationIds.size() == commodity.getCommoditySpecifictions().size()) {
			String identifiers = "";
			for (int i = 0; i < commoditySpecificationIdentifiers.size(); i++) {
				if (i == 0) {
					identifiers = "(";
				}
				if (i < commoditySpecificationIdentifiers.size() - 1) {
					identifiers += commoditySpecificationIdentifiers.get(i) + ",";
				} else {
					identifiers += commoditySpecificationIdentifiers.get(i) + ")";
				}
			}
			// 往log表中插入操作数据
			insertLog(operateType, identifiers, Constants.OPERATE_INSERT, date, userIdentifier);
			// 往前台返回结果集
			rmsg.put("success", true);
			rmsg.put("msg", Constants.SAVE_SUCCESS_MSG);
			return rmsg;
		} else {
			// 单位以及库存mapper里的删除参数改为list
			// 根据商品规格ID列表 删除可能存储好的库存信息
			inventoryService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
			// 根据商品规格ID列表 删除存储好的单位信息
			unitService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
			// 根据商品ID删除存储好的商品规格信息
			commoditySpecificationService.deleteByCommodityId(commodity.getId());
			// 删除存储好的商品信息
			commodityService.deleteByPrimaryKey(commodity.getId());

			rmsg.put("success", false);
			rmsg.put("msg", Constants.SAVE_FAILURE_MSG);
			return rmsg;
		}
	}

	/**
	 * 新增前判断该商品名是否存在
	 * 
	 * @param request
	 * @param c
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectGoodsNamePreventRepeatAdd", method = RequestMethod.POST)
	public JSONObject selectGoodsNamePreventRepeatAdd(HttpServletRequest request, Commodity c) throws Exception {
		JSONObject rmsg = new JSONObject();
		Commodity commodity = new Commodity();
		commodity = commodityService.selectGoodsNamePreventRepeatAdd(c);
		if (commodity != null) {
			rmsg.put("success", false);
			rmsg.put("msg", "此商品名称已存在，请勿重复添加!");
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}

	/**
	 * 判断该商品的规格名是否存在
	 * 
	 * @param request
	 * @param cs
	 * @param addOrUpdate
	 *            1:新增 2：编辑
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectGoodsSpecificationNamePreventRepeat", method = RequestMethod.POST)
	public JSONObject selectGoodsSpecificationNamePreventRepeat(HttpServletRequest request, CommoditySpecification cs,
			Integer addOrUpdate) throws Exception {
		JSONObject rmsg = new JSONObject();
		List<CommoditySpecification> commoditySpecification = new ArrayList<>();
		commoditySpecification = commoditySpecificationService.selectGoodsSpecificationNamePreventRepeat(cs,
				addOrUpdate);
		if (commoditySpecification.size() > 0) {
			rmsg.put("success", false);
			rmsg.put("msg", "此商品下的该规格名称已存在，请勿重复添加!");
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}

	/**
	 * 查看商品详情/编辑
	 * 
	 * @param id
	 *            主键
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectCommoditySpecificationMsgById")
	public CommoditySpecification selectCommodityMsgById(HttpServletRequest request, String id) throws Exception {
		CommoditySpecification commoditySpecification=commoditySpecificationService.lookCommoditySpecificationDetail(Integer.parseInt(id));
		for(Unit un:commoditySpecification.getUnits()){
			if(un.getBasicUnit()==1){
				un.setPurchasePrice(procureTableService.getOriginalUnitPrice(commoditySpecification.getId()));
			}
		}
		for(Inventory inv:commoditySpecification.getInventories()){
			if(commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(commoditySpecification.getId())!=null&&commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(commoditySpecification.getId())>0){
				inv.setCostPrice(commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(commoditySpecification.getId()));
			}
			else{
				inv.setCostPrice(0.0);
			}
			
		}
		return commoditySpecification;
	}

	/**
	 * 商品信息的编辑 只能修改规格的信息，商品的信息不能修改
	 * 
	 * @param request
	 * @param c
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/editCommodityMsg", method = RequestMethod.POST)
	public JSONObject editCommodityMsg(HttpServletRequest request) throws Exception {
		String type = request.getParameter("type");
		
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String c = request.getParameter("commodityData");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(c);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("commoditySpecifictions", CommoditySpecification.class); // key为teacher私有变量的属性名
		map.put("units", Unit.class); // key为teacher私有变量的属性名
		map.put("inventories", Inventory.class);
		// 把JSON串转换成对象
		Commodity commodity = (Commodity) net.sf.json.JSONObject.toBean(jsonobject, Commodity.class, map);
		CommoditySpecification commoditySpecification = commodity.getCommoditySpecifictions().get(0);
		if("1".equals(type)) {//商品正常的编辑
			commoditySpecification.setState(9); 
			List<Integer> commoditySpecificationIds = new ArrayList<>();
			if (commoditySpecificationService.updateByPrimaryKeySelective(commoditySpecification) > 0) {
				//修改商品的默认税率
				Commodity commodity2=new Commodity();
				commodity2.setId(commodity.getId());
				commodity2.setTaxes(commodity.getTaxes());
				commodity2.setMnemonicCode(commodity.getMnemonicCode());
				commodity2.setShoutName(commodity.getShoutName());
				commodityService.updateByPrimaryKeySelective(commodity2);
				
				commoditySpecificationIds.add(commoditySpecification.getId());
				// 先删除存储好的单位信息
				unitService.deleteByCommoditySpecificationIds(commoditySpecificationIds);

				// 重新保存单位信息
				for (Unit u : commoditySpecification.getUnits()) {
					u.setSpecificationId(commoditySpecification.getId());
				}

				if (unitService.insertBatch(commoditySpecification.getUnits()) == commoditySpecification.getUnits()
						.size()) {
					// 删除可能存储好的库存信息
					inventoryService.deleteByCommoditySpecificationIds(commoditySpecificationIds);
					// 重新保存库存信息
					for (Inventory in : commoditySpecification.getInventories()) {
						in.setSpecificationId(commoditySpecification.getId());
					}
					// 有库存信息时，需要往库存表中存储信息
					if (commoditySpecification.getInventories().size() > 0) {
						if (inventoryService.insertBatch(commoditySpecification.getInventories()) == commoditySpecification
								.getInventories().size()) {
							// 往log表中插入操作数据
							insertLog(operateType, commodity.getIdentifier(),
									Constants.OPERATE_UPDATE, new Date(), GetSessionUtil.GetSessionUserIdentifier(request));
							// 往前台返回结果集
							rmsg.put("success", true);
							rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
							return rmsg;
						}
					}
					// 无库存信息则不需要往库存表中存储信息
					else {
						// 往log表中插入操作数据
						insertLog(operateType, commodity.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
								GetSessionUtil.GetSessionUserIdentifier(request));
						// 往前台返回结果集
						rmsg.put("success", true);
						rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
						return rmsg;
					}
				}
			}
		}else if("2".equals(type)) {//可以被引用的商品的修改
			Commodity tempCommodity = new Commodity();
			tempCommodity.setId(commodity.getId());
			tempCommodity.setTempTaxes(commodity.getTaxes());
			
			CommoditySpecification tempCommoditySpecification = new CommoditySpecification();
			tempCommoditySpecification.setId(commoditySpecification.getId());
			tempCommoditySpecification.setTempState(10);
			tempCommoditySpecification.setTempMiniOrderQuantity(commoditySpecification.getMiniOrderQuantity());
			tempCommoditySpecification.setTempAddOrderQuantity(commoditySpecification.getAddOrderQuantity());
			tempCommoditySpecification.setTempWarningNumber(commoditySpecification.getWarningNumber());
			if (commoditySpecification.getInventories().size() > 0) {//有存货信息
				Inventory inventory = commoditySpecification.getInventories().get(0);
				tempCommoditySpecification.setTempWarehouseId(inventory.getWarehouseId());
				tempCommoditySpecification.setTempMaxInventory(inventory.getMaxInventory());
				tempCommoditySpecification.setTempMiniInventory(inventory.getMiniInventory());
				tempCommoditySpecification.setTempInventory(inventory.getInventory());
			}
			if (commoditySpecificationService.updateByPrimaryKeySelective(tempCommoditySpecification) > 0) {
				commodityService.updateByPrimaryKeySelective(tempCommodity);
				// 往log表中插入操作数据
				insertLog(operateType, commodity.getIdentifier(), Constants.OPERATE_UPDATE, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));
				// 往前台返回结果集
				rmsg.put("success", true);
				rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
				return rmsg;
			}
			
		}
		

		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 删除前判断该商品是否被占用，被占用则不能删除
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/afterDelDecide", method = RequestMethod.POST)
	public JSONObject afterDelDecide(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 从前台中获取选中的id
		String[] primaryKeys = request.getParameterValues("id");
		//查客户
		List<SupctoCommodity> supctoCommodities = supctoCommodityService.selectByCommodityIds(primaryKeys);
		List<Integer> primaryKeyList=new ArrayList<>();
		for(String keys:primaryKeys){
			primaryKeyList.add(Integer.parseInt(keys));
		}
		List<String> isExitsCommoditySpec=new ArrayList<>();
		//在客户中已被占用
		if (supctoCommodities != null && supctoCommodities.size() > 0) {
			for(SupctoCommodity sc: supctoCommodities){
				for(int i=0;i<primaryKeyList.size();i++){
					if(sc.getCommodityId().equals(primaryKeyList.get(i))){
						isExitsCommoditySpec.add(sc.getCommoditySpecification().getSpecificationIdentifier());
						primaryKeyList.remove(i);
						break;
					}
				}
			}
			
		}
		
		if(primaryKeyList.size()>0){
			//查采购
			List<CommoditySpecification> commoditySpecifications1=commoditySpecificationService.selectCommodityIsExistFromPC(primaryKeyList);
			//在采购单中已被占用
			if (commoditySpecifications1 != null && commoditySpecifications1.size() > 0) {
				for(CommoditySpecification cs: commoditySpecifications1){
					for(int i=0;i<primaryKeyList.size();i++){
						if(cs.getId().equals(primaryKeyList.get(i))){
							isExitsCommoditySpec.add(cs.getSpecificationIdentifier());
							primaryKeyList.remove(i);
							break;
						}
					}
				}
			}
			
			if(primaryKeyList.size()>0){
				//查销售
				List<CommoditySpecification> commoditySpecifications2=commoditySpecificationService.selectCommodityIsExistFromSOC(primaryKeyList);
				//在销售订单中已被占用
				if (commoditySpecifications2 != null && commoditySpecifications2.size() > 0) {
					for(CommoditySpecification cs: commoditySpecifications2){
						for(int i=0;i<primaryKeyList.size();i++){
							if(cs.getId().equals(primaryKeyList.get(i))){
								isExitsCommoditySpec.add(cs.getSpecificationIdentifier());
								primaryKeyList.remove(i);
								break;
							}
						}
					}
				}
				
				if(primaryKeyList.size()>0){
					//查销售计划单
					List<CommoditySpecification> commoditySpecifications3=commoditySpecificationService.selectCommodityIsExistFromSPOC(primaryKeyList);
					//在销售计划中已被占用
					if (commoditySpecifications3 != null && commoditySpecifications3.size() > 0) {
						for(CommoditySpecification cs: commoditySpecifications3){
							for(int i=0;i<primaryKeyList.size();i++){
								if(cs.getId().equals(primaryKeyList.get(i))){
									isExitsCommoditySpec.add(cs.getSpecificationIdentifier());
									primaryKeyList.remove(i);
									break;
								}
							}
						}
					}
					
					if(primaryKeyList.size()>0){
						//查调拨单
						List<CommoditySpecification> commoditySpecifications4=commoditySpecificationService.selectCommodityIsExistFromAOC(primaryKeyList);
						//在调拨单中已被占用
						if (commoditySpecifications4 != null && commoditySpecifications4.size() > 0) {
							for(CommoditySpecification cs: commoditySpecifications4){
								for(int i=0;i<primaryKeyList.size();i++){
									if(cs.getId().equals(primaryKeyList.get(i))){
										isExitsCommoditySpec.add(cs.getSpecificationIdentifier());
										primaryKeyList.remove(i);
										break;
									}
								}
							}
						}
						
						if(primaryKeyList.size()>0){
							//查报损单
							List<CommoditySpecification> commoditySpecifications5=commoditySpecificationService.selectCommodityIsExistFromBOC(primaryKeyList);
							//在报损单中已被占用
							if (commoditySpecifications5 != null && commoditySpecifications5.size() > 0) {
								for(CommoditySpecification cs: commoditySpecifications5){
									for(int i=0;i<primaryKeyList.size();i++){
										if(cs.getId().equals(primaryKeyList.get(i))){
											isExitsCommoditySpec.add(cs.getSpecificationIdentifier());
											primaryKeyList.remove(i);
											break;
										}
									}
								}
							}
							
							if(primaryKeyList.size()>0){
								//查组装/拆卸单
								List<CommoditySpecification> commoditySpecifications6=commoditySpecificationService.selectCommodityIsExistFromPOOC(primaryKeyList);
								//在查组装/拆卸单中已被占用
								if (commoditySpecifications6 != null && commoditySpecifications6.size() > 0) {
									for(CommoditySpecification cs: commoditySpecifications6){
										for(int i=0;i<primaryKeyList.size();i++){
											if(cs.getId().equals(primaryKeyList.get(i))){
												isExitsCommoditySpec.add(cs.getSpecificationIdentifier());
												primaryKeyList.remove(i);
												break;
											}
										}
									}
								}
								if(primaryKeyList.size()>0){
									//查组装/拆卸单
									List<CommoditySpecification> commoditySpecifications7=commoditySpecificationService.selectCommodityIsExistFromTSOC(primaryKeyList);
									//在查组装/拆卸单中已被占用
									if (commoditySpecifications7 != null && commoditySpecifications7.size() > 0) {
										for(CommoditySpecification cs: commoditySpecifications7){
											for(int i=0;i<primaryKeyList.size();i++){
												if(cs.getId().equals(primaryKeyList.get(i))){
													isExitsCommoditySpec.add(cs.getSpecificationIdentifier());
													primaryKeyList.remove(i);
													break;
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		System.out.println("isExitsCommoditySpec.size:"+isExitsCommoditySpec.size());
		String notDeleteCommodity = "(";
		if (isExitsCommoditySpec != null && isExitsCommoditySpec.size() > 0) {
			for (int i = 0; i < isExitsCommoditySpec.size(); i++) {
				if (i < isExitsCommoditySpec.size() - 1) {
						notDeleteCommodity += isExitsCommoditySpec.get(i) + ",";
					
				} else {
				
					notDeleteCommodity += isExitsCommoditySpec.get(i);
					
				}
			}
			notDeleteCommodity += ")";
			rmsg.put("msg", notDeleteCommodity + "以上显示的商品已被占用,暂不能删除!");
			rmsg.put("success", false);
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}

	/**
	 * 根据主键(批量/单个)删除类型信息
	 * 
	 * @param build
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/delBatchByPrimaryKey", method = RequestMethod.POST)
	public JSONObject delBatchByPrimaryKey(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 从前台中获取选中的id 规格id
		String[] primaryKeys = request.getParameterValues("id");
		List<Integer> primaryKeyList = new ArrayList<>();
		for (String id : primaryKeys) {
			primaryKeyList.add(Integer.parseInt(id));
		}
		// 在删除前保存要删除的分类的信息
		List<CommoditySpecification> commoditySpecificationList = commoditySpecificationService
				.selectBatchByPrimaryKey(primaryKeyList);
		// 保存商品id
		//List<Integer> commodityIds = new ArrayList<>();
		//for (CommoditySpecification cs : commoditySpecificationList) {
			//commodityIds.add(cs.getCommodityId());
		//}
		if (commoditySpecificationService.updateStateToDeleteByIds(primaryKeyList)) {
			// 保存需要删除的商品id
			//List<Integer> shouldDelCommodityIds = new ArrayList<>();
			// 判断删除规格后的商品还有没有规格。若没有规格，则需要把该商品信息一起删除。
			//List<Commodity> commodities = commodityService.selectBatchByPrimaryKey(commodityIds);
			//for (Commodity commodity : commodities) {
				//if (commodity.getCommoditySpecifictions() == null
						//|| commodity.getCommoditySpecifictions().size() <= 0) {
					//shouldDelCommodityIds.add(commodity.getId());
			//	}
			//}
			// 有需要删除的商品信息
			//if (shouldDelCommodityIds.size() > 0) {
				//commodityService.deleteBatchByPrimaryKey(shouldDelCommodityIds);
			//}

			// 删除单位信息以及库存信息
			//unitService.deleteByCommoditySpecificationIds(primaryKeyList);
			//inventoryService.deleteByCommoditySpecificationIds(primaryKeyList);

			// 保存往Log表中添加的操作对象的编号
			String identifierList = "";

			for (int i = 0; i < commoditySpecificationList.size(); i++) {
				if (i < commoditySpecificationList.size() - 1) {
					identifierList += commoditySpecificationList.get(i).getSpecificationIdentifier() + ",";
				} else {
					identifierList += commoditySpecificationList.get(i).getSpecificationIdentifier();
				}

			}
			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);

			// 往log表中插入操作数据
			insertLog(operateType, identifierList, Constants.OPERATE_DELETE, new Date(), userIdentifier);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.DELE_SUCCESS_MSG);
			return rmsg;
		}

		rmsg.put("success", false);
		rmsg.put("msg", Constants.DELE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 操作商品状态( 2：待采购填写   4：采购审核驳回 5：待销售填写中  7：销售审核驳回  3：销售审核通过 )
	 * 
	 * @param request
	 * @param c
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/operateCommodityState", method = RequestMethod.POST)
	public JSONObject operateCommodityState(HttpServletRequest request, String[] ids, int operate) throws Exception {
		JSONObject rmsg = new JSONObject();
		//System.out.println("ids.length:" + ids.length);
		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				list.add(Integer.valueOf(ids[i]));
			}
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", list);

		switch (operate) {
		
		// 待采购填写 (填完商品信息送至财务)
		case 2:
			map.put("state", 2);
			break;
		// 采购审核驳回
		case 4:
			map.put("state",4);
			break;
		// 采购审批通过
		case 5:
			map.put("state",5);
			break;
		// 销售审核驳回
		case 7:
			map.put("state", 7);
			break;
		// 销售审核通过  || 采购修改审批通过
		case 3:
			map.put("state", 3);
			break;
		// 总经理审核通过
		/*case 3:
			map.put("state", 3);
			break;
		// 总经理审核驳回
		case 10:
			map.put("state", 10);
			break;	*/
		//采购修改审批驳回
		case 11:
			map.put("state", 11);
			break;	
		//采购修改总经理审批通过
		case -1:
			map.put("state", -1);
			break;
		//销售修改审批驳回
		case 13:
			map.put("state", 13);
			break;
		//销售修改审批通过
		case -2:
			map.put("state", -1);
			break;
		//采购修改审批通过
		case 14:
			map.put("state", 14);
			break;
		//采购修改总经理审批驳回
		case 15:
			map.put("state", 15);
			break;
		default:
			break;
		}

		if (commoditySpecificationService.updateStateByIds(map)) {
			//采购修改审批通过时更新数据  start
			if(operate == -1) {
				CommoditySpecification commoditySpecification = null;
				Commodity commodity = null;
				Inventory inventory = null;
				for (Integer id : list) {
					commoditySpecification = commoditySpecificationService.lookCommoditySpecificationDetail(id);
					commoditySpecification.setMiniOrderQuantity(commoditySpecification.getTempMiniOrderQuantity());
					commoditySpecification.setAddOrderQuantity(commoditySpecification.getTempAddOrderQuantity());
					commoditySpecification.setWarningNumber(commoditySpecification.getTempWarningNumber());
					
					commodity = commoditySpecification.getCommodity();
					commodity.setTaxes(commodity.getTempTaxes());
					
					if (commoditySpecificationService.updateByPrimaryKeySelective(commoditySpecification) > 0) {
						commodityService.updateByPrimaryKeySelective(commodity);

						if(commoditySpecification.getTempMiniInventory() != null) {//修改或新增了存货信息
							if(commoditySpecification.getInventories().size() > 0) {//修改了存货信息
								inventory = commoditySpecification.getInventories().get(0);
								inventory.setMaxInventory(commoditySpecification.getTempMaxInventory());
								inventory.setMiniInventory(commoditySpecification.getTempMiniInventory());
								inventoryService.updateByPrimaryKeySelective(inventory);
							}else {//新增存货信息
								inventory = new Inventory();
								inventory.setSpecificationId(id);
								inventory.setWarehouseId(commoditySpecification.getTempWarehouseId());
								inventory.setMaxInventory(commoditySpecification.getTempMaxInventory());
								inventory.setMiniInventory(commoditySpecification.getTempMiniInventory());
								inventory.setInventory(commoditySpecification.getTempInventory());
								inventory.setCommodityNum(commoditySpecification.getTempInventory());
								inventoryService.insertSelective(inventory);
							}
							 
							
						}
					}
				}
			}
			//采购修改审批通过时更新数据  end
			
			//销售修改审批通过时更新数据  start
			if(operate == -2) {

				CommoditySpecification commoditySpecification = null;
				Unit unit = null;
				for (Integer id : list) {
					commoditySpecification = commoditySpecificationService.lookCommoditySpecificationDetail(id);
					for(Unit un:commoditySpecification.getUnits()){
						if(un.getBasicUnit() == 1) {//基本单位
							unit=new Unit();
							unit.setId(un.getId());
							unit.setCommonlyPrice(un.getTempCommonlyPrice());
							unitService.updateByPrimaryKeySelective(unit);
						}
					}
					
				}
			
			}
			//销售修改审批通过时更新数据  end
			
			//修改审批驳回或修改审批通过后清空临时数据
			if(operate == -1 || operate == 11|| operate == 15) {
				commoditySpecificationService.clearTempDate(list);
			}
			
			
			// 保存操作的对象编号
			List<CommoditySpecification> commoditySpecifications = commoditySpecificationService
					.selectBatchByPrimaryKey(list);

			// 操作对象
			String operateObject = "";
			for (int i = 0; i < commoditySpecifications.size(); i++) {
				operateObject += commoditySpecifications.get(i).getSpecificationIdentifier();
				if (i < commoditySpecifications.size() - 1) {
					operateObject += ",";
				}
			}

			// 往log表中插入操作数据
			// 送审
			if(operate==8){
				insertLog(Constants.TYPE_LOG_GOODS, operateObject + "", Constants.OPERATE_UPDATE, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));
			}
			else{
				insertLog(Constants.TYPE_LOG_CHECK, operateObject + "", Constants.OPERATE_UPDATE, new Date(),
						GetSessionUtil.GetSessionUserIdentifier(request));
			}
		
			rmsg.put("success", true);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", "操作失败,请刷新页面后重新尝试。");
		return rmsg;

	}

	
	/**
	 * 设置停用/启用
	 * 
	 * @param request
	 * @param c
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/notUseOrUse", method = RequestMethod.POST)
	public JSONObject notUseOrUse(HttpServletRequest request, CommoditySpecification cs) throws Exception {
		JSONObject rmsg = new JSONObject();
	    CommoditySpecification commoditySpecification=new CommoditySpecification();
	    commoditySpecification=commoditySpecificationService.selectByPrimaryKey(cs.getId());
		if (commoditySpecificationService.updateByPrimaryKeySelective(cs) > 0) {
			insertLog(Constants.TYPE_LOG_GOODS, commoditySpecification.getSpecificationIdentifier() + "", Constants.OPERATE_UPDATE, new Date(),
					GetSessionUtil.GetSessionUserIdentifier(request));
			rmsg.put("success", true);
			rmsg.put("msg", Constants.OPERATION_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.OPERATION_FAILURE_MSG);
		return rmsg;
	}
	
	/**
	 * 采购填写销售价格
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/editCommodityPrice", method = RequestMethod.POST)
	public JSONObject editCommodityPrice(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String c = request.getParameter("commodityData");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(c);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("commoditySpecifictions", CommoditySpecification.class); // key为teacher私有变量的属性名
		map.put("units", Unit.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		Commodity commodity = (Commodity) net.sf.json.JSONObject.toBean(jsonobject, Commodity.class, map);
		
		int purchaseOrSales=0;//1表示采购填写 2表示销售填写
		Unit unit;
		if(commodity!=null){
			if(commodity.getCommoditySpecifictions()!=null){
				for(CommoditySpecification commoditySpecification:commodity.getCommoditySpecifictions()){
					if(commoditySpecification.getUnits()!=null){
						//修改单位信息里的价格信息
						for(Unit un:commoditySpecification.getUnits()){
							unit=new Unit();
							unit.setId(un.getId());
							//采购填写最低销售价格
							if(un.getMiniPrice()!=null&&un.getMiniPrice()>=0){
								unit.setMiniPrice(un.getMiniPrice());
									purchaseOrSales=1;
							}
							//销售填写一般销售价格
							else if(un.getCommonlyPrice()!=null&&un.getCommonlyPrice()>=0){
								unit.setCommonlyPrice(un.getCommonlyPrice());
								purchaseOrSales=2;
							}
							unitService.updateByPrimaryKeySelective(unit);
						}
						
						CommoditySpecification specification;
						//修改商品状态为去审核
						if(purchaseOrSales==1){
							//采购审核中
							specification=new CommoditySpecification();
							specification.setId(commoditySpecification.getId());
							specification.setState(9);
						}else{
							//销售审核中
							specification=new CommoditySpecification();
							specification.setId(commoditySpecification.getId());
							specification.setState(6);
						}
						if(commoditySpecificationService.updateByPrimaryKeySelective(specification)>0){
							//加入log日志
							insertLog(Constants.TYPE_LOG_GOODS, commoditySpecification.getSpecificationIdentifier() + "", Constants.OPERATE_UPDATE, new Date(),
									GetSessionUtil.GetSessionUserIdentifier(request));
							
							rmsg.put("success", true);
							rmsg.put("msg", "添加成功，已送审!");
							return rmsg;
						}
						
					}
					
				}
			}
			
		}
		
		rmsg.put("success", false);
		rmsg.put("msg", "添加失败，请刷新页面后重新尝试。");
		return rmsg;
		
	
	}
	
	/**
	 * 销售修改一般销售价格
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/editCommodityPrice2", method = RequestMethod.POST)
	public JSONObject editCommodityPrice2(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 获取ajax传递过来的参数
		String c = request.getParameter("commodityData");
		// 将json格式的字符串转换成JSONObject 对象
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(c);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("commoditySpecifictions", CommoditySpecification.class); // key为teacher私有变量的属性名
		map.put("units", Unit.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		Commodity commodity = (Commodity) net.sf.json.JSONObject.toBean(jsonobject, Commodity.class, map);
		
		Unit unit;
		if(commodity!=null){
			if(commodity.getCommoditySpecifictions()!=null){
				for(CommoditySpecification commoditySpecification:commodity.getCommoditySpecifictions()){
					if(commoditySpecification.getUnits()!=null){
						//修改单位信息里的价格信息
						for(Unit un:commoditySpecification.getUnits()){
							unit=new Unit();
							unit.setId(un.getId());
							unit.setTempCommonlyPrice(un.getCommonlyPrice());
							unitService.updateByPrimaryKeySelective(unit);
						}
						
						CommoditySpecification specification;
						//修改商品临时状态
						specification=new CommoditySpecification();
						specification.setId(commoditySpecification.getId());
						specification.setTempState(12);
					
					if(commoditySpecificationService.updateByPrimaryKeySelective(specification)>0){
						//加入log日志
						insertLog(Constants.TYPE_LOG_GOODS, commoditySpecification.getSpecificationIdentifier() + "", Constants.OPERATE_UPDATE, new Date(),
								GetSessionUtil.GetSessionUserIdentifier(request));
							
						rmsg.put("success", true);
						rmsg.put("msg", "修改成功，已送审!");
						return rmsg;
					}
						
					}
					
				}
			}
			
		}
		rmsg.put("success", false);
		rmsg.put("msg", "修改失败，请刷新页面后重新尝试。");
		return rmsg;
		
	}

	/**
	 * 导出商品信息
	 * 
	 * @param request
	 * @param response
	 * @param searchIdentifier
	 *            商品编号
	 * @param searchName
	 *            商品名
	 * @param searchOperatorName
	 *            操作人姓名
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/exportCommodity")
	public boolean exportCommodity(HttpServletRequest request, HttpServletResponse response,
			String searchClassificationTwoId, String searchName, String searchOperatorName, String searchSupctoId)
			throws Exception {
		String fileName = "商品信息";// 文档名称以及Excel里头部信息
		List<Commodity> clist = new ArrayList<>();
		clist = commodityService.exportCommodityMsg(
				Integer.parseInt(URLDecoder.decode(searchClassificationTwoId, "UTF-8")),
				URLDecoder.decode(searchName, "UTF-8"), URLDecoder.decode(searchOperatorName, "UTF-8"),
				Integer.parseInt(URLDecoder.decode(searchSupctoId, "UTF-8")));
		for(int i=0;i<clist.size();i++){
			for(CommoditySpecification commoditySpecification:clist.get(i).getCommoditySpecifictions()){
				for(Unit un:commoditySpecification.getUnits()){
					if(un.getBasicUnit()==1||un.getMiniPurchasing()==1){
						un.setPurchasePrice(procureTableService.getOriginalUnitPrice(commoditySpecification.getId()));
					}
				}
			}
		}
		
		List<String[]> dataList = new ArrayList<>();
		String[] title; // 保存Excel表头
		String[] value; // 保存要导出的内容
		// 搜索的有数据
		if (clist.size() > 0) {
			// 保存Excel表头
			title = new String[43];
			title[0] = "商品编号";
			title[1] = "商品名称";
			title[2] = "分类名称";
			title[3] = "品牌";
			title[4] = "是否允许0库存出货";
			title[5] = "简称";
			title[6] = "助记码";
			title[7] = "基本信息";
			title[8] = "货品属性";
			title[9] = "供销商";
			title[10] = "默认税率";

			title[11] = "规格信息";
			title[12] = "规格编号";
			title[13] = "规格名称";
			title[14] = "是否停用";
			title[15] = "保质日期";
			title[16] = "最小订货量";
			title[17] = "最小订货增量";
			title[18] = "包装尺寸";
			title[19] = "预警数量";
			title[20] = "状态";
			title[21] = "操作人编号";
			title[22] = "操作时间";

			title[23] = "基本单位信息";
			title[24] = "单位名称";
			title[25] = "单价";
			title[26] = "单位比率";
			title[27] = "一般销售价格";
			title[28] = "最低销售价格";
			title[29] = "条形码";
			title[30] = "销售单位";
			title[31] = "采购单位";
			title[32] = "仓库单位";

			title[33] = "最小订货批量单位信息";
			title[34] = "单位名称";
			title[35] = "单价";
			title[36] = "单位比率";
			title[37] = "一般销售价格";
			title[38] = "最低销售价格";
			title[39] = "条形码";
			title[40] = "销售单位";
			title[41] = "采购单位";
			title[42] = "仓库单位";

			// 保存要导出的内容
			for (Commodity c : clist) {
				for (int i=0;i<c.getCommoditySpecifictions().size();i++) {		
					CommoditySpecification cs=c.getCommoditySpecifictions().get(i);
					value = new String[43];
					if(i==0){
						value[0] = c.getIdentifier();
						value[1] = c.getName();
						value[2] = c.getClassification().getName();
						value[3] = c.getBrand();
						if (c.getZeroStock() == 0) {
							value[4] = "不允许";
						} else {
							value[4] = "允许";
						}
						value[5] = c.getShoutName();
						value[6] = c.getMnemonicCode();
						value[7] = c.getBasicsInformation();
						if ("00".equals(c.getAttribute())) {
							value[8] = "冷库";
						} else if ("01".equals(c.getAttribute())) {
							value[8] = "待定";
						} else if ("10".equals(c.getAttribute())) {
							value[8] = "待定";
						} else if ("11".equals(c.getAttribute())) {
							value[8] = "常温库";
						}
						if(c.getSupcto()!=null){
							value[9] = c.getSupcto().getName();
						}
						else{
							value[9] = "";
						}
						
						value[10] = c.getTaxes() + "";
					}
					value[11] = "";
					value[12] = cs.getSpecificationIdentifier();
					value[13] = cs.getSpecificationName();
					if (cs.getIsDelete() == 0) {
						value[14] = "未停用";
					} else {
						value[14] = "已停用";
					}

					value[15] = cs.getQualityPeriod() + cs.getQualityPeriodUnit();
					value[16] = cs.getMiniOrderQuantity() + "";
					value[17] = cs.getAddOrderQuantity() + "";
					value[18] = cs.getPackagingSize();
					value[19] = cs.getWarningNumber() + "";
					switch (cs.getState()) {
					case 1:
						value[20] = "未送审";
						break;
					case 2:
						value[20] = "待采购填写";
						break;
					case 9:
						value[20] = "采购审核中";
						break;
					case 4:
						value[20] = "采购审核驳回";
						break;
					case 5:
						value[20] = "待销售填写";
						break;
					case 6:
						value[20] = "销售审核中";
						break;
					case 7:
						value[20] = "销售审核驳回";
						break;
					case 8:
						value[20] = "总经理审核中";
						break;
					case 3:
						value[20] = "总经理审核通过";
						break;
					case 10:
						value[20] = "总经理审核驳回";
						break;
					default:
						break;
					}
					if (cs.getOperatorIdentifier() != null && !"".equals(cs.getOperatorIdentifier())) {
						if (cs.getPerson() != null) {
							value[21] = cs.getOperatorIdentifier() + "(" + cs.getPerson().getName() + ")";
						} else {
							value[21] = cs.getOperatorIdentifier();
						}

					} else {
						value[21] = "";
					}
					if (cs.getOperatorTime() != null) {
						value[22] = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cs.getOperatorTime());
					} else {
						value[22] = "";
					}

					for (Unit u : cs.getUnits()) {
						if (u.getBasicUnit() == 1) {
							value[23] = "";
							value[24] = u.getName();
							if(u.getPurchasePrice()!=null&&u.getPurchasePrice()>0){
								value[25] = u.getPurchasePrice()+"";
								value[35] = u.getPurchasePrice()+"";
							}
							else{
								value[25] = 0+"";
								value[35] = 0+"";
							}
							
							if (u.getRatioDenominator() == 1) {
								value[26] = u.getRatioMolecular() + "";
							} else {
								value[26] = u.getRatioMolecular() + "/" + u.getRatioDenominator();
							}
							if(u.getCommonlyPrice() !=null && !(u.getCommonlyPrice()+"").equals("null") &&u.getCommonlyPrice()>0){
								value[27] = u.getCommonlyPrice() + "";
							}
							else{
								value[27] ="未填";
								
							}
							System.out.println("miniprice:"+!(u.getMiniPrice()+"").equals("null"));
							if( u.getMiniPrice() !=null&& !(u.getMiniPrice()+"").equals("null")&&u.getMiniPrice()>=0){
								value[28] = u.getMiniPrice() + "";
								
							}
							else{
								value[28] = "未填";
							}
							
							value[29] = u.getBarCode();
							value[30] = u.getSalesUnit() + "";
							value[31] = u.getPurchasingUnit() + "";
							value[32] = u.getWarehouseUnit() + "";
						}

						if (u.getMiniPurchasing() == 1) {
							value[33] = "";
							value[34] = u.getName();
							
							if (u.getRatioDenominator() == 1) {
								value[36] = u.getRatioMolecular() + "";
							} else {
								value[36] = u.getRatioMolecular() + "/" + u.getRatioDenominator();
							}

							value[37] = u.getCommonlyPrice() + "";
							value[38] = u.getMiniPrice() + "";
							value[39] = u.getBarCode();
							value[40] = u.getSalesUnit() + "";
							value[41] = u.getPurchasingUnit() + "";
							value[42] = u.getWarehouseUnit() + "";
						}
					}
					dataList.add(value);
				}

				
			}
		}
		// 没有搜索到数据
		else {
			title = new String[1];
			title[0] = Constants.NO_DATA_EXPORT;// 无数据提示
		}
		// 调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName, title, dataList);
		return true;
	}
	
	/**
	 * 获取所有审核通过且未停用的商品信息
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getAllCommodityByStateAndIsDelete")
	public List<CommoditySpecification> getAllCommodityByStateAndIsDelete(HttpServletRequest request) {
		return commoditySpecificationService.getAllCommodityByStateAndIsDelete();
	}
	
	/**
	 * 根据供应商id获取所有审核通过且未停用的商品信息
	 * 如果supctoId传的是0  则说明查找所有的审核通过且未停用的商品信息
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getAllCommodityByStateAndIsDeleteBySupctoId")
	public List<CommoditySpecification> getAllCommodityByStateAndIsDeleteBySupctoId(HttpServletRequest request,Integer supctoId) {
		List<CommoditySpecification> commoditySpecifications=commoditySpecificationService.getAllCommodityByStateAndIsDeleteBySupctoId(supctoId);
		if(commoditySpecifications!=null&&commoditySpecifications.size()>0){
			for(CommoditySpecification specification:commoditySpecifications){
				specification.setSpecOriginalUnitPrice(procureTableService.getOriginalUnitPrice(specification.getId()));
			}
		}
		
		return commoditySpecifications;
	}
	
	/**
	 * 根据仓库id获取所有审核通过且未停用的有库存记录的商品信息
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getHasInventoryCommodityByStateAndIsDeleteAndWarehouseId")
	public List<CommoditySpecification> getHasInventoryCommodityByStateAndIsDeleteAndWarehouseId(HttpServletRequest request,int warehouseId) {
		//获取商品信息
		List<CommoditySpecification> commoditySpecifications = commoditySpecificationService.getHasInventoryCommodityByStateAndIsDeleteAndWarehouseId(warehouseId);
		//设置移动平均价
		Double movingAveragePrice;
		for (int i = 0; i < commoditySpecifications.size(); i++) {
			movingAveragePrice = commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(commoditySpecifications.get(i).getId());
			
			if(movingAveragePrice == null) {
				movingAveragePrice = commoditySpecifications.get(i).getBaseMiniPrice();
			}
			commoditySpecifications.get(i).setMovingAveragePrice(movingAveragePrice);
		}
		
		return commoditySpecifications;
	}
	
	/**
	 * 获取所有审核通过且未停用的有库存商品信息
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getHasInventoryCommodityByStateAndIsDeleteBySupctoId")
	public List<CommoditySpecification> getHasInventoryCommodityByStateAndIsDeleteBySupctoId(HttpServletRequest request) {
		List<CommoditySpecification> commoditySpecifications=commoditySpecificationService.getHasInventoryCommodityByStateAndIsDeleteBySupctoId();
		//设置移动平均价
		Double movingAveragePrice;
		if(commoditySpecifications!=null&&commoditySpecifications.size()>0){
			for(CommoditySpecification specification:commoditySpecifications){
				specification.setSpecOriginalUnitPrice(procureTableService.getOriginalUnitPrice(specification.getId()));
				movingAveragePrice = commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(specification.getId());
				specification.setMovingAveragePrice(movingAveragePrice);
			}
		}
		return commoditySpecifications;
	}
	
	/**
	 * 销售订单和销售计划单的商品获取方法
	 * 新增时获取所有审核通过且未停用的有库存商品信息
	 * 编辑时获取所有商品信息，动态加上该订单占用的库存，剔除掉没有库存的商品
	 * @param request
	 * @param updateOrAdd 1:add 2:update
	 * @param orderId 销售订单/计划单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saleOrderGetHasInventoryCommodityByStateAndIsDelete")
	public List<CommoditySpecification> saleOrderGetHasInventoryCommodityByStateAndIsDelete(HttpServletRequest request,Integer updateOrAdd,Integer orderId) {
		List<CommoditySpecification> commoditySpecifications=new ArrayList<>();
		if(updateOrAdd==1){
			//如果是新增，则直接通过getHasInventoryCommodityByStateAndIsDeleteBySupctoId该方法获取商品信息。
			commoditySpecifications=commoditySpecificationService.getHasInventoryCommodityByStateAndIsDeleteBySupctoId();
		}else{
			//如果是编辑，则获取所有的审核通过且未停用的商品信息，临时给占用数量减去该销售订单/计划单购买的商品个数，去除没有库存的商品。
			commoditySpecifications=commoditySpecificationService.getAllCommodityByStateAndIsDelete();
			SalesOrder salesOrder=salesOrderService.selectOrderDetailById(orderId);
			if(salesOrder.getSalesOrderCommodities().size()>0){
				for(SalesOrderCommodity salesOrderCommodity:salesOrder.getSalesOrderCommodities()){
					for(int i=0;i<commoditySpecifications.size();i++){
						if(commoditySpecifications.get(i).getInventories()!=null){
							//临时给占用数量减去该销售订单/计划单购买的商品个数
							if(commoditySpecifications.get(i).getId().equals(salesOrderCommodity.getCommoditySpecificationId())){
								commoditySpecifications.get(i).getInventories().get(0).setOccupiedInventory(commoditySpecifications.get(i).getInventories().get(0).getOccupiedInventory()-salesOrderCommodity.getDeliverGoodsNum());
								break;
							}
						}
						
					}
				}
			}
			//去除没有库存的商品
			for(int i=0;i<commoditySpecifications.size();i++){
				if(commoditySpecifications.get(i).getInventories()!=null&&commoditySpecifications.get(i).getInventories().size()>0){
					if(commoditySpecifications.get(i).getInventories().get(0).getInventory()-commoditySpecifications.get(i).getInventories().get(0).getOccupiedInventory()<=0){
						commoditySpecifications.remove(i);
						i--;
					}
				}
				else{
					commoditySpecifications.remove(i);
					i--;
				}
			}
			
			if(salesOrder.getSalesOrderCommodities().size()>0){
				for(SalesOrderCommodity salesOrderCommodity:salesOrder.getSalesOrderCommodities()){
					for(int i=0;i<commoditySpecifications.size();i++){
						if(commoditySpecifications.get(i).getInventories()!=null){
							//再恢复原占用数量
							if(commoditySpecifications.get(i).getId().equals(salesOrderCommodity.getCommoditySpecificationId())){
								commoditySpecifications.get(i).getInventories().get(0).setOccupiedInventory(commoditySpecifications.get(i).getInventories().get(0).getOccupiedInventory()+salesOrderCommodity.getDeliverGoodsNum());
								break;
							}
						}
						
					}
				}
			}
			
		}
		
		//设置移动平均价
		Double movingAveragePrice;
		if(commoditySpecifications!=null&&commoditySpecifications.size()>0){
			for(CommoditySpecification specification:commoditySpecifications){
				specification.setSpecOriginalUnitPrice(procureTableService.getOriginalUnitPrice(specification.getId()));
				movingAveragePrice = commoditySpecificationService.getMovingAveragePriceByCommoditySpecificationId(specification.getId());
				specification.setMovingAveragePrice(movingAveragePrice);
			}
		}
		return commoditySpecifications;
	}
	
    /**
     * 获取所有商品信息，并结合客户所涉及的商品信息进行结果筛选
     *
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getAllCommodity")
    public List<Commodity> getAllCommodity(){
		List<Commodity> commodityList = commodityService.getAllCommodity();

		return  commodityList;
	}
	/**
	 * 根据商品id获取商品规格编号
	 * @param commodityId 商品id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getAllSpecificationIdentifier")
	public List<CommoditySpecification>  getAllSpecificationIdentifier(Integer commodityId){
		//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+commodityId);
		return commoditySpecificationService.getAllSpecificationIdentifier(commodityId);
	}
	/**
	 * 根据商品编号获取商品仓库信息
	 * @param identifier 商品规格编号
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getCommodityWarehouse")
	public Inventory  getCommodityWarehouse(String identifier){
		//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+identifier);
		Inventory  inventory=inventoryService.getCommodityWarehouse(identifier);
		
		return inventory;
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
	public void insertLog(Integer operateType, String identifier, String operateMethod, Date date,
			String userIdentifier) throws Exception {
		log = new Log();
		log.setOperateType(operateType);
		log.setOperateObject(identifier + "(" + operateMethod + ")");
		log.setOperateTime(date);
		log.setOperatorIdentifier(userIdentifier);
		logService.insert(log);
	}

	
	

	
}
