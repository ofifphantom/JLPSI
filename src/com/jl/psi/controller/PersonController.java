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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.Log;
import com.jl.psi.model.Menu;
import com.jl.psi.model.Permission;
import com.jl.psi.model.Person;
import com.jl.psi.service.LogService;
import com.jl.psi.service.MenuService;
import com.jl.psi.service.PermissionService;
import com.jl.psi.service.PersonService;
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SHAUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 员工Controller
 * 
 * @author 景雅倩
 * @date 2017-11-8 下午4:39:52
 * @Description TODO
 */
@Controller
@RequestMapping("/basic/person/")
public class PersonController extends BaseController {

	@Autowired
	private PersonService personService;

	@Autowired
	private LogService logService;

	@Autowired
	private PermissionService permissionService;
	@Autowired
	private MenuService menuService;

	/**
	 * 进入员工维护页面
	 * 
	 * @param request
	 * @param page
	 *            标志
	 * @return 页面路径
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(HttpServletRequest request,int page) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName="";
		switch (page) {
		case 1:
			pageName = "junlin/jsp/basic/person/personManager";
			break;
		case 2:
			pageName = "junlin/jsp/backgroundManagement/background/resetPassword";
			break;
		default:
			break;
		}
		
		return pageName;

	}

	/**
	 * 根据部门id获取所有的业务员
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getAllPersonByDepartmentIdAndBusiness")
	public List<Person> getAllPersonByDepartmentIdAndBusiness(HttpServletRequest request, int departmentId) {
		return personService.getAllPersonByDepartmentIdAndBusiness(departmentId);
	}

	/**
	 * 信息dataTables
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "dataTables", method = RequestMethod.POST)
	@ResponseBody
	public DataTables dataTables(HttpServletRequest request, String identifier, String name,
			String operatorIdentifier,String departmentId,String area, String operatorTime) {
		
		DataTables dataTables = DataTables.createDataTables(request);

		return personService.dataTables(dataTables, identifier, name, operatorIdentifier, departmentId,area, operatorTime);

	}

	/**
	 * 新增前，查询登录名是否存在
	 * 
	 * @param request
	 * @param loginName
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "selectAdminByLoginName")
	public JSONObject selectAdminByLoginName(HttpServletRequest request, String loginName) throws Exception {
		JSONObject rmsg = new JSONObject();
		Person person = personService.findUserByLoginName(loginName);
		if (person != null) {
			// 往前台返回结果集
			rmsg.put("success", false);
			rmsg.put("msg", "该登录名已被占用!");
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}

	/**
	 * 添加
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addPerson", method = RequestMethod.POST)
	public JSONObject addPerson(HttpServletRequest request, Person person) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println("password:" + person.getPassword());
		// 获取选择的权限
		String[] permissions = person.getResIds().split(",");

		String bs = person.getBirthTimeStr();
		if (!"".equals(bs) && bs != null) {
			person.setBirthTime(sdf.parse(bs));
		} else {
			person.setBirthTime(null);
		}
		String es = person.getEntryTimeStr();
		if (!"".equals(es) && es != null) {
			person.setEntryTime(sdf.parse(es));
		} else {
			person.setEntryTime(null);
		}
		String qs = person.getQuitTimeStr();
		if (!"".equals(qs) && qs != null) {
			person.setQuitTime(sdf.parse(qs));
		} else {
			person.setQuitTime(null);
		}

		// 给密码加密
		person.setPassword(SHAUtil.shaEncode(person.getPassword()));

		JSONObject rmsg = new JSONObject();

		// 自动生成编号
		String identifier = SundryCodeUtil.getPosCode(Constants.CODE_PERSON);
		person.setIdentifier(identifier);
		// 添加操作时间
		Date operateTime = new Date();
		person.setOperatorTime(operateTime);
		// 添加操作人编号，从session中获取
		String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		person.setOperatorIdentifier(operatorIdentifier);

		if (personService.insertSelective(person) > 0) {

			// 往权限表中批添加该管理员的权限
			permissionService.insertBatch(permissions, person.getId(), identifier, operateTime);

			// 插入日志
			Log log = new Log();
			log.setOperateType(Constants.TYPE_LOG_PERSON);

			String operateObject = identifier + "(" + Constants.OPERATE_INSERT + ")";
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
	 * 编辑前，查询登录名是否存在
	 * 
	 * @param request
	 * @param loginName
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "selectAdminByLoginNameAndId")
	public JSONObject selectAdminByLoginNameAndId(HttpServletRequest request, Person person) throws Exception {
		JSONObject rmsg = new JSONObject();
		Person p = personService.selectByPrimaryKeyAndLoginName(person);
		if (p != null) {
			// 往前台返回结果集
			rmsg.put("success", false);
			rmsg.put("msg", "该登录名已被占用!");
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @param
	 * @return
	 * @throws Exception
	 */

	@ResponseBody
	@RequestMapping(value = "updatePersonById", method = RequestMethod.POST)
	public JSONObject updatePersonById(HttpServletRequest request, Person person) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		System.out.println("resIds:" + person.getResIds());
		System.out.println("person.getId():" + person.getId());
		System.out.println(" person.getIdentifier():" + person.getIdentifier());
		System.out.println(" person.getPassword():" + person.getPassword());
		person.setPassword(null);
		// 获取选择的权限
		String[] permissions = person.getResIds().split(",");

		String bs = person.getBirthTimeStr();
		if (!"".equals(bs) && bs != null) {
			person.setBirthTime(sdf.parse(bs));
		} else {
			person.setBirthTime(null);
		}
		String es = person.getEntryTimeStr();
		if (!"".equals(es) && es != null) {
			person.setEntryTime(sdf.parse(es));
		} else {
			person.setEntryTime(null);
		}
		String qs = person.getQuitTimeStr();
		if (!"".equals(qs) && qs != null) {
			person.setQuitTime(sdf.parse(qs));
		} else {
			person.setQuitTime(null);
		}

		JSONObject rmsg = new JSONObject();
		if (personService.updateByPrimaryKeySelective(person) > 0) {
			// 修改时先删除权限表中属于该管理员的所有权限，重新添加
			if (permissionService.deleteByUserId(person.getId()) >= 0) {
				// 往权限表中批添加该管理员的权限
				permissionService.insertBatch(permissions, person.getId(),
						GetSessionUtil.GetSessionUserIdentifier(request), new Date());
			}
			// 插入日志
			Log log = new Log();
			int id = person.getId();
			log.setOperateType(Constants.TYPE_LOG_PERSON);

			// 操作对象
			String identifier = personService.selectByPrimaryKey(id).getIdentifier();
			String operateObject = identifier + "(" + Constants.OPERATE_UPDATE + ")";
			log.setOperateObject(operateObject);

			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			// 操作时间
			Date operateTime = new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 删除（根据id列表删）
	 * 
	 * @param request
	 * @param ids
	 *            id数组
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "deletePersonByIds", method = RequestMethod.POST)
	public JSONObject deletePersonByIds(HttpServletRequest request, String[] ids) throws Exception {

		JSONObject rmsg = new JSONObject();
		int userId = GetSessionUtil.GetSessionUserId(request);
		ArrayList<Integer> list = new ArrayList<Integer>();
		if (ids != null && ids.length > 0) {
			for (String id : ids) {
				int int_id = Integer.valueOf(id);
				if(userId==int_id) {
					String identifier = personService.selectByPrimaryKey(userId).getIdentifier();
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工("+identifier+",)为当前登录账户，删除失败！");
					return rmsg;
				}
				list.add(int_id);
			}
		}
		// 判断有没有被客户/供应商占用 如果有 返回编号
		List<Person> settlementIdentifier1 = personService.selectPersonIdentifierFromSupctoByPersonId(list);
		if (settlementIdentifier1.size() > 0) {
			String str = "";
			for (int i = 0; i < settlementIdentifier1.size(); i++) {
				str += settlementIdentifier1.get(i).getIdentifier();
				if (i < settlementIdentifier1.size() - 1) {
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的员工(" + str + ")有关联的客户/供应商,删除失败！");
			return rmsg;
		}
		// 判断有没有被盘点单占用 如果有 返回编号
		List<Person> settlementIdentifier2 = personService.selectPersonIdentifierFromTakeStockOrderByPersonId(list);
		if (settlementIdentifier2.size() > 0) {
			String str = "";
			for (int i = 0; i < settlementIdentifier2.size(); i++) {
				str += settlementIdentifier2.get(i).getIdentifier();
				if (i < settlementIdentifier2.size() - 1) {
					str += ",";
				}
			}
			rmsg.put("success", false);
			rmsg.put("msg", "要删除的员工(" + str + ")有关联的盘点单,删除失败！");
			return rmsg;
		}
		// 判断有没有被组装/拆卸单占用 如果有 返回编号
				List<Person> settlementIdentifier3 = personService.selectPersonIdentifierFromPackageOrTeardownOrderByPersonId(list);
				if (settlementIdentifier3.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier3.size(); i++) {
						str += settlementIdentifier3.get(i).getIdentifier();
						if (i < settlementIdentifier3.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的组装/拆卸单,删除失败！");
					return rmsg;
				}
				// 判断有没有被调拨单占用 如果有 返回编号
				List<Person> settlementIdentifier4 = personService.selectPersonIdentifierFromAllotOrderByPersonId(list);
				if (settlementIdentifier4.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier4.size(); i++) {
						str += settlementIdentifier4.get(i).getIdentifier();
						if (i < settlementIdentifier4.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的调拨单,删除失败！");
					return rmsg;
				}
				// 判断有没有被报损单占用 如果有 返回编号
				List<Person> settlementIdentifier5 = personService.selectPersonIdentifierFromBreakageOrderByPersonId(list);
				if (settlementIdentifier5.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier5.size(); i++) {
						str += settlementIdentifier5.get(i).getIdentifier();
						if (i < settlementIdentifier5.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的报损单,删除失败！");
					return rmsg;
				}
				// 判断有没有被销售订单占用 如果有 返回编号
				List<Person> settlementIdentifier6 = personService.selectPersonIdentifierFromSalesOrderByPersonId(list);
				if (settlementIdentifier6.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier6.size(); i++) {
						str += settlementIdentifier6.get(i).getIdentifier();
						if (i < settlementIdentifier6.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的销售订单,删除失败！");
					return rmsg;
				}
				// 判断有没有被销售计划单占用 如果有 返回编号
				List<Person> settlementIdentifier7 = personService.selectPersonIdentifierFromSalesPlanOrderByPersonId(list);
				if (settlementIdentifier7.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier7.size(); i++) {
						str += settlementIdentifier7.get(i).getIdentifier();
						if (i < settlementIdentifier7.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的销售计划单,删除失败！");
					return rmsg;
				}
				// 判断有没有被分类占用 如果有 返回编号
				List<Person> settlementIdentifier8 = personService.selectPersonIdentifierFromClassificationByPersonId(list);
				if (settlementIdentifier8.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier8.size(); i++) {
						str += settlementIdentifier8.get(i).getIdentifier();
						if (i < settlementIdentifier8.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的分类信息,删除失败！");
					return rmsg;
				}
				// 判断有没有被商品规格占用 如果有 返回编号
				List<Person> settlementIdentifier9 = personService.selectPersonIdentifierFromCommoditySpecificationByPersonId(list);
				if (settlementIdentifier9.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier9.size(); i++) {
						str += settlementIdentifier9.get(i).getIdentifier();
						if (i < settlementIdentifier9.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的商品,删除失败！");
					return rmsg;
				}
				// 判断有没有被部门占用 如果有 返回编号
				List<Person> settlementIdentifier10 = personService.selectPersonIdentifierFromDepartmentByPersonId(list);
				if (settlementIdentifier10.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier10.size(); i++) {
						str += settlementIdentifier10.get(i).getIdentifier();
						if (i < settlementIdentifier10.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的部门,删除失败！");
					return rmsg;
				}
				/*// 判断有没有被日志占用 如果有 返回编号
				List<Person> settlementIdentifier11 = personService.selectPersonIdentifierFromLogByPersonId(list);
				if (settlementIdentifier11.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier11.size(); i++) {
						str += settlementIdentifier11.get(i).getIdentifier();
						if (i < settlementIdentifier11.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的日志,删除失败！");
					return rmsg;
				}*/
				/*// 判断有没有被权限占用 如果有 返回编号
				List<Person> settlementIdentifier12 = personService.selectPersonIdentifierFromPermissionByPersonId(list);
				if (settlementIdentifier12.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier12.size(); i++) {
						str += settlementIdentifier12.get(i).getIdentifier();
						if (i < settlementIdentifier12.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的权限,删除失败！");
					return rmsg;
				}*/
				// 判断有没有被结算方式占用 如果有 返回编号
				List<Person> settlementIdentifier13 = personService.selectPersonIdentifierFromSettlementTypeByPersonId(list);
				if (settlementIdentifier13.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier13.size(); i++) {
						str += settlementIdentifier13.get(i).getIdentifier();
						if (i < settlementIdentifier13.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的结算方式,删除失败！");
					return rmsg;
				}
				// 判断有没有被运输方式占用 如果有 返回编号
				List<Person> settlementIdentifier14 = personService.selectPersonIdentifierFromShippingModeByPersonId(list);
				if (settlementIdentifier14.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier14.size(); i++) {
						str += settlementIdentifier14.get(i).getIdentifier();
						if (i < settlementIdentifier14.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的运输方式,删除失败！");
					return rmsg;
				}
				// 判断有没有被仓库占用 如果有 返回编号
				List<Person> settlementIdentifier15 = personService.selectPersonIdentifierFromWarehouseByPersonId(list);
				if (settlementIdentifier15.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier15.size(); i++) {
						str += settlementIdentifier15.get(i).getIdentifier();
						if (i < settlementIdentifier15.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的仓库,删除失败！");
					return rmsg;
				}
				// 判断有没有被采购订单占用 如果有 返回编号
				List<Person> settlementIdentifier16 = personService.selectPersonIdentifierFromProcureTableByPersonId(list);
				if (settlementIdentifier16.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier16.size(); i++) {
						str += settlementIdentifier16.get(i).getIdentifier();
						if (i < settlementIdentifier16.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的采购订单,删除失败！");
					return rmsg;
				}
				// 判断有没有被销售订单审批表占用 如果有 返回编号
				List<Person> settlementIdentifier17 = personService.selectPersonIdentifierFromSalesOrderReviewerByPersonId(list);
				if (settlementIdentifier17.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier17.size(); i++) {
						str += settlementIdentifier17.get(i).getIdentifier();
						if (i < settlementIdentifier17.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的销售订单,删除失败！");
					return rmsg;
				}
				// 判断有没有被bills表占用 如果有 返回编号
				List<Person> settlementIdentifier18 = personService.selectPersonIdentifierFromBillsByPersonId(list);
				if (settlementIdentifier18.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier18.size(); i++) {
						str += settlementIdentifier18.get(i).getIdentifier();
						if (i < settlementIdentifier18.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的应收应付信息,删除失败！");
					return rmsg;
				}
				// 判断有没有被writeoff表占用 如果有 返回编号
				List<Person> settlementIdentifier19 = personService.selectPersonIdentifierFromWriteOffByPersonId(list);
				if (settlementIdentifier19.size() > 0) {
					String str = "";
					for (int i = 0; i < settlementIdentifier19.size(); i++) {
						str += settlementIdentifier19.get(i).getIdentifier();
						if (i < settlementIdentifier19.size() - 1) {
							str += ",";
						}
					}
					rmsg.put("success", false);
					rmsg.put("msg", "要删除的员工(" + str + ")有关联的应收应付信息,删除失败！");
					return rmsg;
				}

		// 保存将要删除的对象编号
		List<Person> supctos = personService.getPersonByIds(list);
		if (personService.deletePersonByIds(list)) {
			// 根据管理员id删除权限表中对应的权限
			permissionService.deletePermissionByUserIds(list);

			// 插入日志
			Log log = new Log();
			// 操作类型
			log.setOperateType(Constants.TYPE_LOG_PERSON);

			// 操作对象
			String operateObject = "";
			for (int i = 0; i < supctos.size(); i++) {
				operateObject += supctos.get(i).getIdentifier();
				if (i < supctos.size() - 1) {
					operateObject += ",";
				}
			}
			operateObject += "(" + Constants.OPERATE_DELETE + ")";

			log.setOperateObject(operateObject);
			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			// 操作时间
			Date operateTime = new Date();
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
	 * 获取所有的菜单
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "selectAllMenu")
	public JSONArray selectAllMenu(HttpServletRequest request, String id) {
		List<Menu> listall = menuService.selectByAll();
		JSONArray menuall = changMenutoJason(listall, 0);
		List<Menu> list = new ArrayList<Menu>();
		if (id != null && !"".equals(id)) {
			for (Permission object : personService.selectAdminMsgById(id).getPermissions()) {
				list.add(object.getMenu());
			}
		}
		// JSONArray menu=changMenutoJason(list,0);
		changMenutoJasonall(menuall, list);
		;
		return menuall;
	}

	
	
	/**
	 * 获取页面左边的菜单列表
	 * 
	 * @param request
	 * @param id
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "selectMenuById")
	public JSONArray selectMenuById(HttpServletRequest request, String id) {
		List<Menu> list = new ArrayList<Menu>();
		List<Menu> listall = menuService.selectByAll();
		List<Integer> menuParent = new ArrayList<Integer>();
		for (Permission object : personService.selectAdminMsgById(id).getPermissions()) {
			System.out.println("menuId:"+object.getMenu().getId()+"--"+"sort:"+object.getMenu().getSort());
			//获取用户拥有的权限里的父节点
			if (object.getMenu().getSort() != null && object.getMenu().getSort() == 0) {
				menuParent.add(object.getMenu().getId());
			}
			//子节点
			else {
				list.add(object.getMenu());
			}
			
			//判断父节点是否存在，若不存在，添加到列表里，直到父节点为0（即为最外层的节点）为止
			Integer parentId=object.getMenu().getParentId();
			while(parentId!=0){
				boolean ishas=parentIdIsExit(parentId,menuParent);//判断父节点是否存在
				if (!ishas) {
					menuParent.add(parentId);
				}
				Menu menu=menuService.selectByPrimaryKey(parentId);
				parentId=menu.getParentId();
			}
			

		}
		for (Menu menu : listall) {
			for (Integer Pid : menuParent) {
				if (menu.getId() == Pid) {
					list.add(menu);
				}
			}
		}
		JSONArray array = changMenutoJason(list, 0);

		changMenutoJasonall(array);

		return array;
	}
	
	/**
	 * 判断父节点是否存在
	 */
	private boolean parentIdIsExit(Integer parentId,List<Integer> menuParentList){
		boolean have = false;
		for (Integer Pid : menuParentList) {
			//判断该节点的父节点是否已存入列表里
			if (Pid == parentId||parentId==0) {
				have = true;
			}
		}
		return have;	
	}

	/**
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	public JSONArray changMenutoJason(List<Menu> menus, Integer parentid) {
		JSONArray array = new JSONArray();
		for (Menu menu : menus) {
			JSONObject jsonObject = new JSONObject();
			if (menu.getSort() != null && menu.getSort() == 0) {
				if (menu.getParentId() == parentid) {
					jsonObject.put("id", menu.getId());
					jsonObject.put("text", menu.getName());
					jsonObject.put("state", "closed");
					jsonObject.put("children", changMenutoJason(menus, menu.getId()));
					array.add(jsonObject);
				}
			} else {
				if (menu.getParentId() == parentid) {
					jsonObject.put("id", menu.getId());
					jsonObject.put("text", menu.getName());
					jsonObject.put("iconCls", "icon-no");
					JSONObject o = new JSONObject();
					o.put("name", menu.getUrl());
					jsonObject.put("attributes", o);
					array.add(jsonObject);
				}
			}

		}
		return array;
	}

	/**
	 * 
	 * @param request
	 * @param id
	 * @return
	 */

	public void changMenutoJasonall(JSONArray menusall, List<Menu> menu) {
		for (int i = 0; i < menusall.size(); i++) {
			((JSONObject) menusall.get(i)).put("state", "open");
			for (int j = 0; j < menu.size(); j++) {
				if (((JSONObject) menusall.get(i)).get("id").equals(menu.get(j).getId())) {
					((JSONObject) menusall.get(i)).put("checked", true);
					break;
				}
			}
			if (((JSONObject) menusall.get(i)).get("children") != null) {
				changMenutoJasonall((JSONArray) ((JSONObject) menusall.get(i)).get("children"), menu);
			}
		}
	}

	public void changMenutoJasonall(JSONArray menusall) {
		if (menusall.get(0) != null) {
			((JSONObject) menusall.get(0)).put("state", "open");
			if (((JSONObject) menusall.get(0)).get("children") != null) {
				changMenutoJasonall((JSONArray) ((JSONObject) menusall.get(0)).get("children"));
			}
		}
	}

	/**
	 * 判断输入的原密码与登陆的密码是否一样
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "decidePwd")
	public JSONObject decidePwd(HttpServletRequest request, String password) throws Exception {
		JSONObject rmsg = new JSONObject();
		if ((request.getSession().getAttribute("password")).equals(SHAUtil.shaEncode(password))) {
			rmsg.put("success", true);
			return rmsg;
		}
		rmsg.put("success", false);
		return rmsg;
	}

	/**
	 * 修改密码
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updatePwd")
	public JSONObject updatePwd(HttpServletRequest request, String password) throws Exception {
		JSONObject rmsg = new JSONObject();
		Person p = new Person();
		p.setId((Integer) request.getSession().getAttribute("userId"));
		p.setPassword(SHAUtil.shaEncode(password));
		if (personService.updateByPrimaryKeySelective(p) > 0) {
			// 插入日志
			Log log = new Log();
			// 操作类型
			log.setOperateType(Constants.TYPE_LOG_PERSON);

			// 操作对象
			log.setOperateObject(((String) request.getSession().getAttribute("identifier")) + "(" + Constants.OPERATE_UPDATE + ")");
			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			// 操作时间
			Date operateTime = new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);

			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}
	/**
	 * 修改密码
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updatePwdById")
	public JSONObject updatePwdById(HttpServletRequest request, String password,int id) throws Exception {
		JSONObject rmsg = new JSONObject();
		Person p = new Person();
		p.setId(id);
		p.setPassword(SHAUtil.shaEncode(password));
		if (personService.updateByPrimaryKeySelective(p) > 0) {
			// 插入日志
			Log log = new Log();
			// 操作类型
			log.setOperateType(Constants.TYPE_LOG_PERSON);

			// 操作对象
			log.setOperateObject(((String) request.getSession().getAttribute("identifier")) + "(" + Constants.OPERATE_UPDATE + ")");
			// 操作人
			String operatorIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			log.setOperatorIdentifier(operatorIdentifier);
			// 操作时间
			Date operateTime = new Date();
			log.setOperateTime(operateTime);
			logService.insert(log);

			int sessionUserId = (Integer) request.getSession().getAttribute("userId");
			if(id==sessionUserId) {
				rmsg.put("logout", true);
			}else {
				rmsg.put("logout", false);
			}
			rmsg.put("success", true);
			rmsg.put("msg", Constants.UPDATE_SUCCESS_MSG);
			return rmsg;
		}
		
		rmsg.put("success", false);
		rmsg.put("msg", Constants.UPDATE_FAILURE_MSG);
		return rmsg;
	}
	/**
	 * 导出信息
	 * 
	 * @param request
	 * @param response
	 * @param identifier
	 *            编号
	 * @param name
	 *            名称
	 * @param operatorIdentifier
	 *            操作人
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "exportPerson")
	public boolean exportPerson(HttpServletRequest request, HttpServletResponse response, String identifier,
			String name, String operatorIdentifier) throws Exception {

		identifier = URLDecoder.decode(identifier, "UTF-8");
		name = URLDecoder.decode(name, "UTF-8");
		operatorIdentifier = URLDecoder.decode(operatorIdentifier, "UTF-8");

		String fileName = "";// 文档名称以及Excel里头部信息
		List<Person> persons = personService.selectMsgOrderBySearchMsg(identifier, name, operatorIdentifier);
		List<String[]> dataList = new ArrayList<>();
		String[] title; // 保存Excel表头
		String[] value; // 保存要导出的内容
		fileName = "员工信息";// 文档名称以及Excel里头部信息

		// 搜索的有数据
		if (persons.size() > 0) {
			// 需导出的表头与信息

			// 保存Excel表头
			title = new String[25];
			title[0] = "编号";
			title[1] = "员工姓名";
			title[2] = "类型名称";
			title[3] = "部门";
			title[4] = "入职日期";
			title[5] = "职务";
			title[6] = "学历";
			title[7] = "性别";
			title[8] = "身份证号";
			title[9] = "出生日期";
			title[10] = "籍贯";
			title[11] = "联系手机号";
			title[12] = "家庭电话";
			title[13] = "常用电话";
			title[14] = "备用电话";
			title[15] = "邮编";
			title[16] = "住址";
			title[17] = "邮箱";
			title[18] = "是否离职";
			title[19] = "离职日期";
			title[20] = "是否为业务员";
			title[21] = "所属仓库";
			title[22] = "备注";
			title[23] = "操作人";
			title[24] = "操作时间";
			SimpleDateFormat sdf0 = new SimpleDateFormat("yyyy-MM-dd");
			// 保存要导出的内容
			for (Person c : persons) {
				value = new String[25];
				value[0] = c.getIdentifier();
				value[1] = c.getName();
				value[2] = c.getType();
				value[3] = c.getDepartment().getName();
				if (c.getEntryTime() != null) {
					value[4] = sdf0.format(c.getEntryTime());
				} else {
					value[4] = "";
				}

				value[5] = c.getDuties();
				value[6] = c.getEducation();
				value[7] = c.getSex();
				value[8] = c.getIdNumber();
				if (c.getBirthTime() != null) {
					value[9] = sdf0.format(c.getBirthTime());
				} else {
					value[9] = "";
				}

				value[10] = c.getNativePlace();
				value[11] = c.getPhone();
				value[12] = c.getHomePhone();
				value[13] = c.getCommonPhone();
				value[14] = c.getReservePhone();
				value[15] = c.getPostcode();
				value[16] = c.getHomeAddress();
				value[17] = c.getMailbox();
				switch (c.getQuite()) {
				case 0:
					value[18] = "否";
					break;
				case 1:
					value[18] = "是";
					break;
				default:
					value[18] = "";
					break;
				}
				if (c.getQuitTime() != null) {
					value[19] = sdf0.format(c.getQuitTime());
				} else {
					value[19] = "";
				}

				switch (c.getBusiness()) {
				case 0:
					value[20] = "否";
					break;
				case 1:
					value[20] = "是";
					break;
				default:
					value[20] = "";
					break;
				}
				value[21] = c.getWarehouseName();
				value[22] = c.getRemark();
				value[23] = c.getOperatorIdentifier() + "(" + c.getUser().getName() + ")";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				value[24] = sdf.format(c.getOperatorTime());

				dataList.add(value);
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

}