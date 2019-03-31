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
import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.Classification;
import com.jl.psi.model.Log;
import com.jl.psi.service.ClassificationService;
import com.jl.psi.service.LogService;
import com.jl.psi.utils.CommonMethod;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.DateUtil;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;

/**
 * 
 * @author 柳亚婷
 * @date 2018年4月2日 下午3:30:21
 * @Description 一二级分类的controller
 *
 */
@Controller
@RequestMapping("/basic/classification/")
public class ClassificationController extends BaseController {
	// 当前类操作的类型(往log日志表中存储)
	private int customerType = Constants.TYPE_LOG_CUSTOMER;
	private int goodsType = Constants.TYPE_LOG_GOODS;
	private int supplierType = Constants.TYPE_LOG_SUPPLIER;
	// 保存二级分类图片的文件夹名
	private String folderName = "TwoClassificationPicture";
	// 声明Log类
	Log log;

	@Autowired
	ClassificationService classificationService;
	@Autowired
	LogService logService;

	/**
	 * 进入一二级分类页面
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
		// 客户一级分类
		case 11:
			pageName = "junlin/jsp/basic/customer/classificationOne";
			break;
		// 客户二级分类
		case 12:
			pageName = "junlin/jsp/basic/customer/classificationTwo";
			break;
		// 供应商一级分类
		case 21:
			pageName = "junlin/jsp/basic/supplier/classificationOne";
			break;
		// 供应商二级分类
		case 22:
			pageName = "junlin/jsp/basic/supplier/classificationTwo";
			break;
		// 商品一级分类
		case 31:
			pageName = "junlin/jsp/basic/goods/classificationOne";
			break;
		// 商品二级分类
		case 32:
			pageName = "junlin/jsp/basic/goods/classificationTwo";
			break;
		default:
			break;
		}

		return pageName;

	}

	/**
	 * 根据搜索条件获取分类的信息，显示在界面上
	 * 
	 * @param request
	 * @param identifier
	 *            分类编号
	 * @param name
	 *            分类名称
	 * @param operatorName
	 *            操作人姓名
	 * @param type
	 *            分类类型( 客户：1，供应商：2，商品：3)
	 * @param oneOrTwo
	 *            一级分类还是二级分类(一级分类：1，二级分类：2)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getClassificationMsg")
	public DataTables getClassificationMsg(HttpServletRequest request, String identifier, String name,
			String operatorName, Integer type, Integer oneOrTwo,Integer oneClassification,String queryTime) {
		DataTables dataTables = DataTables.createDataTables(request);

		return classificationService.getClassificationMsg(dataTables, identifier, name, operatorName, type, oneOrTwo,oneClassification,queryTime);
	}

	/**
	 * 添加一级分类信息
	 * 
	 * @param request
	 * @param c
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addOneClassificationMsg", method = RequestMethod.POST)
	public JSONObject addOneClassificationMsg(HttpServletRequest request, Classification c) throws Exception {
		JSONObject rmsg = new JSONObject();
		// 商品的编号生成
		if (c.getType() == 3) {
			// 自动生成编号
			c.setIdentifier(SundryCodeUtil.getPosCode(Constants.CODE_GOODSONECLASSIFICATION));
		}
		// 供应商和客户的编号生成
		else {
			// 自动生成编号
			c.setIdentifier(generatedIdentifier(c.getType(), 1,0));
		}
		// 添加操作时间
		Date date = new Date();
		c.setOperatorTime(date);
		// 添加操作人编号，从session中获取
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		c.setOperatorIdentifier(userIdentifier);
		// 默认一级分类的父级Id为0
		c.setParentId(0);
		if (classificationService.insertSelective(c) > 0) {
			if (c.getType() == 1) {
				// 往log表中插入操作数据
				insertLog(customerType, c.getIdentifier() + "", Constants.OPERATE_INSERT, date, userIdentifier);
			} else if (c.getType() == 2) {
				// 往log表中插入操作数据
				insertLog(supplierType, c.getIdentifier() + "", Constants.OPERATE_INSERT, date, userIdentifier);
			} else if (c.getType() == 3) {
				// 往log表中插入操作数据
				insertLog(goodsType, c.getIdentifier() + "", Constants.OPERATE_INSERT, date, userIdentifier);
			}

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
	 * 添加时判断需要添加的分类是否重复 根据name和一二级分类标识符进行查询 不同一级分类下的二级分类可以重复
	 * 
	 * @param request
	 * @param name
	 *            分类名称
	 * @param parentId
	 *            父级ID
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectClassifityNamePreventRepeatAdd", method = RequestMethod.POST)
	public JSONObject selectClassifityNamePreventRepeatAdd(HttpServletRequest request, Classification c)
			throws Exception {
		JSONObject rmsg = new JSONObject();
		Classification classification = new Classification();
		classification = classificationService.selectClassifityNamePreventRepeatAdd(c);
		if (classification != null) {
			rmsg.put("success", false);
			if (c.getParentId() != null && c.getParentId() != 0) {
				rmsg.put("msg", "此一级分类下的该分类名称已存在，请勿重复添加!");
			} else {
				rmsg.put("msg", "该分类名称已存在，请勿重复添加!");
			}

			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}

	/**
	 * 点击编辑时根据主键ID查询信息
	 * 
	 * @param id
	 *            主键
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectById")
	public Classification selectById(HttpServletRequest request, String id) throws Exception {

		return classificationService.selectByPrimaryKey(Integer.parseInt(id));
	}

	/**
	 * 根据主键更新一级分类信息
	 * 
	 * @param Classification
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/updateOnePrimaryKey", method = RequestMethod.POST)
	public JSONObject updateOnePrimaryKey(HttpServletRequest request, Classification c) throws Exception {
		JSONObject rmsg = new JSONObject();

		// 往数据库中根据id修改信息
		int result = classificationService.updateByPrimaryKeySelective(c);
		if (result > 0) {
			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			if (c.getType() == 1) {
				// 往log表中插入操作数据
				insertLog(customerType, c.getIdentifier(), Constants.OPERATE_UPDATE, new Date(), userIdentifier);
			} else if (c.getType() == 2) {
				// 往log表中插入操作数据
				insertLog(supplierType, c.getIdentifier(), Constants.OPERATE_UPDATE, new Date(), userIdentifier);
			} else if (c.getType() == 3) {
				// 往log表中插入操作数据
				insertLog(goodsType, c.getIdentifier(), Constants.OPERATE_UPDATE, new Date(), userIdentifier);
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
	 * 修改时判断需要添加的分类是否重复 根据name和一二级分类标识符进行查询 不同一级分类下的二级分类可以重复
	 * 
	 * @param request
	 * @param Classification
	 *            分类信息
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectClassifityNamePreventRepeatEdit", method = RequestMethod.POST)
	public JSONObject selectClassifityNamePreventRepeatEdit(HttpServletRequest request, Classification c)
			throws Exception {
		JSONObject rmsg = new JSONObject();
		Classification classification = new Classification();
		classification = classificationService.selectClassifityNamePreventRepeatEdit(c);
		if (classification != null) {
			rmsg.put("success", false);
			if (c.getParentId() != null && c.getParentId() != 0) {
				rmsg.put("msg", "此一级分类下的该分类名称已存在，请勿重复添加!");
			} else {
				rmsg.put("msg", "该分类名称已存在，请勿重复添加!");
			}
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}

	/**
	 * 删除一级分类时需确认该分类下有无包含二级分类
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/selectTwoByOneClassificationId", method = RequestMethod.POST)
	public JSONObject selectTwoByOneClassificationId(HttpServletRequest request) throws Exception {
		JSONObject rmsg = new JSONObject();
		Classification classification = new Classification();
		// 获取从前台传入的选择的分类id
		String[] primaryKeys = request.getParameterValues("id");
		// 保存不能删除的分类名称
		ArrayList<String> notRemoveName = new ArrayList<>();
		// 把不能删除的分类名称组合成string类型输出到前台
		String resultClassificationName = "";

		for (int i = 0; i < primaryKeys.length; i++) {

			// 通过一级分类id查找二级分类，看是否有数据。>0表示有数据
			if (classificationService.selectTwoByOneId(Integer.parseInt(primaryKeys[i])).size() > 0) {
				// 通过主键查询分类数据。
				classification = classificationService.selectByPrimaryKey(Integer.parseInt(primaryKeys[i]));
				notRemoveName.add(classification.getName());
			}
		}
		for (int i = 0; i < notRemoveName.size(); i++) {
			if (i == 0) {
				resultClassificationName += "(";
			}
			if (i < notRemoveName.size() - 1) {
				resultClassificationName += notRemoveName.get(i) + "、";
			} else {
				resultClassificationName += notRemoveName.get(i);
			}
			if (i == notRemoveName.size() - 1) {
				resultClassificationName += ")";
			}

		}
		if (!"".equals(resultClassificationName)) {
			rmsg.put("success", false);
			rmsg.put("msg", resultClassificationName + "以上显示的分类名称下包含的有二级分类，请先删除二级分类!");
			return rmsg;
		}
		rmsg.put("success", true);
		return rmsg;
	}
	
	/**
	 * 删除前判断二级分类是否被占用
	 * @param request
	 * @param page 1：客户二级分类   2：供应商二级分类   3：商品二级分类
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/decideTwoClassificationIsExits", method = RequestMethod.POST)
	public JSONObject decideTwoClassificationIsExits(HttpServletRequest request,Integer page) throws Exception {
		JSONObject rmsg = new JSONObject();
		Classification classification = new Classification();
		// 获取从前台传入的选择的分类id
		String[] primaryKeys = request.getParameterValues("id");
		List<Integer> primaryKeyList=new ArrayList<>();
		for(String keys:primaryKeys){
			primaryKeyList.add(Integer.parseInt(keys));
		}
		
		// 保存不能删除的分类名称
		ArrayList<String> notRemoveName = new ArrayList<>();
		// 把不能删除的分类名称组合成string类型输出到前台
		String resultClassificationName = "";
		
				
		//客户
		if(page==1){
			Map<String,Object> map = new HashMap<>();
			map.put("customerOrSupplier", 1);
			map.put("list", primaryKeyList);
			List<Classification> classifications=classificationService.selectClassificationIsExistFromSupcto(map);
			if(classifications!=null&&classifications.size()>0){
				for(Classification c:classifications){
					notRemoveName.add(c.getName());
				}
			}
		}
		//供应商
		else if(page==2){
			Map<String,Object> map = new HashMap<>();
			map.put("customerOrSupplier", 2);
			map.put("list", primaryKeyList);
			List<Classification> classifications=classificationService.selectClassificationIsExistFromSupcto(map);
			if(classifications!=null&&classifications.size()>0){
				for(Classification c:classifications){
					notRemoveName.add(c.getName());
				}
			}
		}
		//商品
		else if(page==3){
			List<Classification> classifications=classificationService.selectClassificationIsExistFromCommodity(primaryKeyList);
			if(classifications!=null&&classifications.size()>0){
				for(Classification c:classifications){
					notRemoveName.add(c.getName());
				}
			}
		}
		for (int i = 0; i < notRemoveName.size(); i++) {
			if (i == 0) {
				resultClassificationName += "(";
			}
			if (i < notRemoveName.size() - 1) {
				resultClassificationName += notRemoveName.get(i) + "、";
			} else {
				resultClassificationName += notRemoveName.get(i);
			}
			if (i == notRemoveName.size() - 1) {
				resultClassificationName += ")";
			}

		}
		if (!"".equals(resultClassificationName)) {
			rmsg.put("success", false);
			rmsg.put("msg", resultClassificationName + "以上显示的二级分类已被占用，暂不能删除!");
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
		// 从前台中获取选中的id
		String[] primaryKeys = request.getParameterValues("id");
		// 在删除前保存要删除的分类的信息
		List<Classification> classificationList = classificationService.selectBatchByPrimaryKey(primaryKeys);
		int result = classificationService.deleteBatchByPrimaryKey(primaryKeys);
		// 保存往Log表中添加的操作对象的编号
		String identifierList = "";

		for (int i = 0; i < classificationList.size(); i++) {
			if (i < classificationList.size() - 1) {
				identifierList += classificationList.get(i).getIdentifier() + ",";
			} else {
				identifierList += classificationList.get(i).getIdentifier();
			}

		}
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		if (classificationList.get(0).getType() == 1) {
			// 往log表中插入操作数据
			insertLog(customerType, identifierList, Constants.OPERATE_DELETE, new Date(), userIdentifier);
		} else if (classificationList.get(0).getType() == 2) {
			// 往log表中插入操作数据
			insertLog(supplierType, identifierList, Constants.OPERATE_DELETE, new Date(), userIdentifier);
		} else if (classificationList.get(0).getType() == 3) {
			// 往log表中插入操作数据
			insertLog(goodsType, identifierList, Constants.OPERATE_DELETE, new Date(), userIdentifier);
		}

		if (result > 0) {
			rmsg.put("success", true);
			rmsg.put("msg", Constants.DELE_SUCCESS_MSG);
			return rmsg;
		}
		rmsg.put("success", false);
		rmsg.put("msg", Constants.DELE_FAILURE_MSG);
		return rmsg;
	}

	/**
	 * 获取所属分类下的所有的一级分类
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "selectAllOneClassifityByType")
	public List<Classification> selectAllOneClassifityByType(HttpServletRequest request, Integer type) {
		return classificationService.selectAllOneClassifityByType(type);
	}
	/**
	 * 获取一级分类下的所有的二级分类
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "selectAllTwoClassifityByParentId")
	public List<Classification> selectAllTwoClassifityByParentId(HttpServletRequest request, Integer parentId) {
		return classificationService.selectAllTwoClassifityByParentId(parentId);
	}

	/**
	 * 添加二级分类的信息
	 * 
	 * @param request
	 *            前台传入得数据
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "addTwoClassificationMsg", method = RequestMethod.POST)
	public JSONObject addTwoClassificationMsg(HttpServletRequest request, Classification c) throws Exception {
		// 商品的编号生成
		if (c.getType() == 3) {
			// 自动生成编号
			c.setIdentifier(SundryCodeUtil.getPosCode(Constants.CODE_GOODSTWOCLASSIFICATION));
		}
		// 供应商和客户的编号生成
		else {
			// 自动生成编号
			c.setIdentifier(generatedIdentifier(c.getType(), 2,c.getParentId()));
		}
		// 添加操作时间
		Date date = new Date();
		c.setOperatorTime(date);
		// 添加操作人编号，从session中获取
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		c.setOperatorIdentifier(userIdentifier);

		JSONObject rmsg = new JSONObject();
		if (classificationService.insertSelective(c) > 0) {
			if (c.getType() == 1) {
				// 往log表中插入操作数据
				insertLog(customerType, c.getIdentifier(), Constants.OPERATE_INSERT, date, userIdentifier);
			} else if (c.getType() == 2) {
				// 往log表中插入操作数据
				insertLog(supplierType, c.getIdentifier(), Constants.OPERATE_INSERT, date, userIdentifier);
			} else if (c.getType() == 3) {
				// 往log表中插入操作数据
				insertLog(goodsType, c.getIdentifier(), Constants.OPERATE_INSERT, date, userIdentifier);
			}

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
	 * 根据主键更新二级分类信息
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "updateTwoPrimaryKey", method = RequestMethod.POST)
	public JSONObject updateTwoPrimaryKey(HttpServletRequest request, Classification c) throws Exception {
		Classification classification = new Classification();
		JSONObject rmsg = new JSONObject();
		// 往数据库中根据id修改信息
		int result = classificationService.updateByPrimaryKeySelective(classification);
		if (result > 0) {

			// 获取当前操作人的编号
			String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
			if (c.getType() == 1) {
				// 往log表中插入操作数据
				insertLog(customerType, c.getIdentifier(), Constants.OPERATE_UPDATE, new Date(), userIdentifier);
			} else if (c.getType() == 2) {
				// 往log表中插入操作数据
				insertLog(supplierType, c.getIdentifier(), Constants.OPERATE_UPDATE, new Date(), userIdentifier);
			} else if (c.getType() == 3) {
				// 往log表中插入操作数据
				insertLog(goodsType, c.getIdentifier(), Constants.OPERATE_UPDATE, new Date(), userIdentifier);
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
	 * 一二级分类页面的导出操作
	 * 
	 * @param request
	 * @param response
	 * @param oneOrTwo
	 *            一二级分类的标识符
	 * @param identifier
	 *            编号搜索框内容
	 * @param name
	 *            名称搜索框内容
	 * @param operatorIdentifier
	 *            添加人编号搜索框内容
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/exportClassification")
	public boolean exportClassification(HttpServletRequest request, HttpServletResponse response, Integer oneOrTwo,
			Integer type, String searchIdentifier, String searchName, String searchOperatorName) throws Exception {
		System.out.println("oneOrTwo:" + Integer.parseInt(URLDecoder.decode(oneOrTwo + "", "UTF-8")));
		String fileName = "";// 文档名称以及Excel里头部信息
		List<Classification> clist = classificationService.selectMsgToExport(
				URLDecoder.decode(searchIdentifier, "UTF-8"), URLDecoder.decode(searchName, "UTF-8"),
				URLDecoder.decode(searchOperatorName, "UTF-8"), Integer.parseInt(URLDecoder.decode(type + "", "UTF-8")),
				Integer.parseInt(URLDecoder.decode(oneOrTwo + "", "UTF-8")));
		List<String[]> dataList = new ArrayList<>();
		String[] title; // 保存Excel表头
		String[] value; // 保存要导出的内容
		// 搜索的有数据
		if (clist.size() > 0) {
			// 一级菜单需导出的表头与信息
			if (Integer.parseInt(URLDecoder.decode(oneOrTwo + "", "UTF-8")) == 1) {
				switch (Integer.parseInt(URLDecoder.decode(type + "", "UTF-8"))) {
				case 1:
					fileName = "客户一级分类信息";// 文档名称以及Excel里头部信息
					break;
				case 2:
					fileName = "供应商一级分类信息";// 文档名称以及Excel里头部信息
					break;
				case 3:
					fileName = "商品一级分类信息";// 文档名称以及Excel里头部信息
					break;

				default:
					break;
				}

				// 保存Excel表头
				title = new String[5];
				title[0] = "编号";
				title[1] = "分类名称";
				title[2] = "关键词";
				title[3] = "操作人编号";
				title[4] = "操作时间";
				// 保存要导出的内容
				for (Classification c : clist) {
					value = new String[5];
					value[0] = c.getIdentifier();
					value[1] = c.getName();
					value[2] = c.getKeyWord();

					if (c.getOperatorIdentifier() != null && !"".equals(c.getOperatorIdentifier())) {
						if (c.getPerson() != null) {
							value[3] = c.getOperatorIdentifier() + "(" + c.getPerson().getName() + ")";
						} else {
							value[3] = c.getOperatorIdentifier();
						}

					} else {
						value[3] = "";
					}
					if (c.getOperatorTime() != null) {
						value[4] = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getOperatorTime());
					} else {
						value[4] = "";
					}

					dataList.add(value);
				}

			}
			// 二级菜单需导出的表头与信息
			else {
				switch (Integer.parseInt(URLDecoder.decode(type + "", "UTF-8"))) {
				case 1:
					fileName = "客户二级分类信息";// 文档名称以及Excel里头部信息
					break;
				case 2:
					fileName = "供应商二级分类信息";// 文档名称以及Excel里头部信息
					break;
				case 3:
					fileName = "商品二级分类信息";// 文档名称以及Excel里头部信息
					break;

				default:
					break;
				}
				// 保存Excel表头
				title = new String[6];
				title[0] = "编号";
				title[1] = "分类名称";
				title[2] = "关键词";
				title[3] = "所属一级分类";
				title[4] = "操作人编号";
				title[5] = "操作时间";
				// 保存要导出的内容
				for (Classification c : clist) {
					value = new String[6];
					value[0] = c.getIdentifier();
					value[1] = c.getName();
					value[2] = c.getKeyWord();
					if (c.getpClassification() != null) {
						value[3] = c.getpClassification().getName();
					} else {
						value[3] = "";
					}

					if (c.getOperatorIdentifier() != null && !"".equals(c.getOperatorIdentifier())) {
						if (c.getPerson() != null) {
							value[4] = c.getOperatorIdentifier() + "(" + c.getPerson().getName() + ")";
						} else {
							value[4] = c.getOperatorIdentifier();
						}

					} else {
						value[4] = "";
					}
					if (c.getOperatorTime() != null) {
						value[5] = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getOperatorTime());
					} else {
						value[5] = "";
					}
					dataList.add(value);
				}
			}
		}
		// 没有搜索到数据
		else {
			if (Integer.parseInt(URLDecoder.decode(oneOrTwo + "", "UTF-8")) == 1) {
				switch (Integer.parseInt(URLDecoder.decode(type + "", "UTF-8"))) {
				case 1:
					fileName = "客户一级分类信息";// 文档名称以及Excel里头部信息
					break;
				case 2:
					fileName = "供应商一级分类信息";// 文档名称以及Excel里头部信息
					break;
				case 3:
					fileName = "商品一级分类信息";// 文档名称以及Excel里头部信息
					break;

				default:
					break;
				}
			} else {
				switch (Integer.parseInt(URLDecoder.decode(type + "", "UTF-8"))) {
				case 1:
					fileName = "客户二级分类信息";// 文档名称以及Excel里头部信息
					break;
				case 2:
					fileName = "供应商二级分类信息";// 文档名称以及Excel里头部信息
					break;
				case 3:
					fileName = "商品二级分类信息";// 文档名称以及Excel里头部信息
					break;

				default:
					break;
				}
			}
			title = new String[1];
			title[0] = Constants.NO_DATA_EXPORT;// 无数据提示
		}
		// 调用公共方法导出数据
		CommonMethod.exportData(request, response, fileName, title, dataList);
		return true;
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

	
	/**
	 * 
	 * 供应商/客户编号的生成
	 * 
	 * 获取数据库中对应类型下的最大编号，生成新存数据的编号
	 * @param type 类型 1：客户 2：供应商 
	 * @param oneOrTwo 需要生成的是一级分类的编号还是二级分类的编号
	 * @param parentId 父级id
	 * @return
	 */
	private String generatedIdentifier(Integer type, Integer oneOrTwo, Integer parentId) {
		String identifier = "";
		String newOneClassififty = "";
		String twoOneClassififty = "";
		if (oneOrTwo == 1) {
			//根据类型获取一级分类最大的编号
			identifier = classificationService.selectMaxOneClaIdentifier(type);
			//如果没有获取到，说明该分类下的无一级分类，此时需要新添加
			if (identifier == null || "".equals(identifier)) {
				newOneClassififty = "00000";
			}
		} else {
			//根据父ID获取二级分类最大的编号
			identifier = classificationService.selectMaxTwoClaIdentifier(parentId);
			//如果没有获取到，说明该一级分类下的无二级分类，此时需要新添加
			if (identifier == null || "".equals(identifier)) {
				//获取一级分类的编号前两位，组合成新的二级分类的编号
				Classification classification = classificationService.selectByPrimaryKey(parentId);
				twoOneClassififty = classification.getIdentifier().substring(0, 2) + "001";
			}
		}

		//identifier="01000"(一级分类的编号) 
		//identifier="01023"(二级分类的编号) 
		//如果获取到的有编号
		if (identifier != null && !"".equals(identifier)) {
			String oneClassififty = identifier.substring(0, 2);
			String twoClassififty = identifier.substring(2, 5);
			// 需要生成一级分类的编号
			if (oneOrTwo == 1) {
				Integer oneClassififtyNum = Integer.parseInt(oneClassififty);
				Integer newOneClassififtyNum = oneClassififtyNum + 1;
				if (newOneClassififtyNum >= 100) {
					newOneClassififtyNum = 00;
				}
				if (newOneClassififtyNum < 10) {
					newOneClassififty = "0" + newOneClassififtyNum + "000";
				} else {
					newOneClassififty = newOneClassififtyNum + "000";
				}

			}
			// 需要生成二级分类的编号
			else {
				Integer twoClassififtyNum = Integer.parseInt(twoClassififty);
				Integer newTwoClassififtyNum = twoClassififtyNum + 1;
				if (newTwoClassififtyNum >= 1000) {
					newTwoClassififtyNum = 000;
				}
				if (newTwoClassififtyNum < 10) {
					twoOneClassififty = oneClassififty + "00" + newTwoClassififtyNum;
				} else if (newTwoClassififtyNum >= 10 && newTwoClassififtyNum < 100) {
					twoOneClassififty = oneClassififty + "0" + newTwoClassififtyNum;
				} else {
					twoOneClassififty = oneClassififty + newTwoClassififtyNum;
				}

			}
		}
		if (oneOrTwo == 1) {
			return newOneClassififty;
		} else {
			return twoOneClassififty;
		}
	}
}
