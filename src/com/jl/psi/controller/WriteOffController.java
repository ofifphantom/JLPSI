package com.jl.psi.controller;

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
import com.jl.psi.model.Bills;
import com.jl.psi.model.BillsSub;
import com.jl.psi.model.FormHeadAndFooter;
import com.jl.psi.model.Supcto;
import	com.jl.psi.model.WriteOff;
import com.jl.psi.model.WriteOffSub;
import com.jl.psi.service.ProcureTableService;
import com.jl.psi.service.SalesOrderService;
import com.jl.psi.service.SupctoService;
import com.jl.psi.service.WriteOffService;
import com.jl.psi.service.WriteOffSubService;
import com.jl.psi.utils.Constants;
import com.jl.psi.utils.DataTables;
import com.jl.psi.utils.GetSessionUtil;
import com.jl.psi.utils.SundryCodeUtil;
/**
 * 处理核销单
 * @author guole
 *
 */
@Controller
@RequestMapping("receivable/writeoff/")
public class WriteOffController extends   BaseController{

	@Autowired
	private WriteOffService  writeOffService;
	@Autowired
	private WriteOffSubService writeOffSubService;
	@Autowired
	private SupctoService supctoService;
	@Autowired
	private SalesOrderService salesOrderService;
	@Autowired
	private ProcureTableService	procureTableService;
	
	
	/**
	 * 进入页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String WriteOff(HttpServletRequest request,int page) {
		if (!checkSession(request)) {
			return "redirect:/login";
		}
		String pageName="";
		switch (page) {
		// 预收冲应收
		case 1:
			pageName = "junlin/jsp/receivable/writeOffList/advanceReceivable";
			break;
		// 预付冲应付
		case 2:
			pageName = "junlin/jsp/receivable/writeOffList/advancePayable";
			break;
		// 应收冲应付
		case 5:
			pageName = "junlin/jsp/receivable/writeOffList/receivablePayable";
			break;
		// 应付冲应收
		case 6:
			pageName = "junlin/jsp/receivable/writeOffList/payableReceivable";
			break;
	  
		default:
			break;
		}
		return pageName;

	}

	/**
	 * 核销单信息 datatables分页
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="dataTables",method=RequestMethod.POST)
	public DataTables	dataTables(HttpServletRequest request,Integer type,String writeoffCode,Integer companyOne,Integer companyTwo,String dateSearch) {
 
		DataTables dataTables=  writeOffService.dataTables(DataTables.createDataTables(request),type,writeoffCode,companyOne,companyTwo,dateSearch);
		return dataTables;
 	}
	/**
	 * 持久化单据信息
	 * @param request
	 * @param billsJson
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="saveWriteOff",method=RequestMethod.POST)
	public JSONObject saveWriteOff(HttpServletRequest request,String writeOffJson) throws Exception {
 
		JSONObject result=new JSONObject();
		
		net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(writeOffJson);
		Map<String, Class> map = new HashMap<String, Class>();
		map.put("writeOffSubs", WriteOffSub.class); // key为teacher私有变量的属性名
		// 把JSON串转换成对象
		WriteOff wo = (WriteOff) net.sf.json.JSONObject.toBean(jsonobject, WriteOff.class, map);
		//生成单据单号
 		String code="AT";
 
 		String maxCode=writeOffService.selectMaxCode();
		String writeoffCode = SundryCodeUtil.createInvoicesIdentifier(code, maxCode);
		wo.setWriteoffCode(writeoffCode);
		wo.setCreateDate(new Date());
		wo.setBranch("总部");
		// 获取当前操作人的编号
		String userIdentifier = GetSessionUtil.GetSessionUserIdentifier(request);
		wo.setOriginator(userIdentifier);
		//插入单据信息
		int count=writeOffService.insertSelective(wo);
		if(count>0) {
			
			Double money=	supctoService.selectByPrimaryKey(wo.getCompanyOne()).getAdvanceMoney();
				money=money==null?0:money;
			if(wo.getType()==1||wo.getType()==2) {
				//如果是预收冲应收或预付冲应付
				DecimalFormat df = new DecimalFormat("#.##");
				supctoService.updateAdvanceMoney(wo.getCompanyOne(),Double.parseDouble(df.format(money-wo.getMoney())));
			} 
			for (WriteOffSub sub :wo.getWriteOffSubs()) {
				sub.setWriteoffId(wo.getId());
				//把对应核销过的 销售订单和采购订单设置已核销
				if(sub.getIsProcureSales()==1&&sub.getIsWriteoff()==1) {
					salesOrderService.updateByVerification(sub.getProcureSalesId());
				}else if(sub.getIsProcureSales()==2&&sub.getIsWriteoff()==1) {
					procureTableService.updateByVerification(sub.getProcureSalesId());
				}
			}
			//插入核销单
			 writeOffSubService.insertBatch(wo.getWriteOffSubs());
	 
			
			
		}
		result.put("success", true);
		result.put("msg", Constants.SAVE_SUCCESS_MSG);
		return result;
	}
	
	/**
	 * 获取单据子项列表
	 * @param supctoId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="subList",method=RequestMethod.POST)
	public JSONObject subList(Integer supctoId,Integer type,Integer supctoType) {
		JSONObject result = new JSONObject();
		result.put("success", false);
		try { 
			result = new JSONObject();
			List<WriteOffSub> subList=null;
			  //预收冲应收
			if(type==1) {
				subList=writeOffSubService.selectAdvanceReceivable(supctoId);
			// 预付冲应付
			  }else if(type==2) {
				  subList=writeOffSubService.selectAdvancePayable(supctoId);
				//  应收冲应付、  应付冲应收
			  }else if(type==5||type==6) {
				  if(supctoType==1) {
					  subList=writeOffSubService.selectBySaleId(supctoId, type);
				  }else if(supctoType==2) {
					  subList=writeOffSubService.selectByProcureId(supctoId, type);
				  }
			  }
//				//1 预收冲应收  5 应收冲应付、 6 应付冲应收 或 查客户
//			  if(type==1||supctoType==1) {
//				  subList=writeOffSubService.selectBySaleId(supctoId, type);
//				  //1 预收冲应收  5 应收冲应付、 6 应付冲应收 或查供应商
//			  }else if(type==2||supctoType==2){
//				  subList=writeOffSubService.selectByProcureId(supctoId, type);
//			  }
			
			result.put("subList", subList);
			result.put("success", true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	 
	/**
	 * 核销单详情
	 * @param supctoId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="detail",method=RequestMethod.POST)
	public JSONObject detail(Integer writeoffId) {
		JSONObject result = new JSONObject();
		result.put("success", false);
		try {
			result = new JSONObject();
			WriteOff writeOff=writeOffService.selectByPrimaryKey(writeoffId);
			Integer type=writeOff.getType();
 			List<WriteOffSub> subList=new ArrayList<WriteOffSub>();
			 switch(type) {
			 case 1:
				 subList.addAll(writeOffSubService.selectSalesById(writeoffId));
				 break;
			 case 2:
				 subList.addAll(writeOffSubService.selectProcureById(writeoffId));
				 break;
			 case 5:
				 subList.addAll(writeOffSubService.selectSalesById(writeoffId));
				 subList.addAll(writeOffSubService.selectProcureById(writeoffId));
				 break;
			 case 6:
				 subList.addAll(writeOffSubService.selectProcureById(writeoffId));
				 subList.addAll(writeOffSubService.selectSalesById(writeoffId));
				 break;
			 }
			
			 writeOff.setWriteOffSubs(subList);
		
			result.put("writeOff", writeOff);
			result.put("success", true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/**
	 * 单据详情
	 * @param id
	 * @return
 */
	@ResponseBody
	@RequestMapping(value = "writeOffDetail", method = RequestMethod.POST)
	 public JSONObject writeOffDetail(Integer id) {
 
		WriteOff writeOff=writeOffService.selectByPrimaryKey(id);
		Integer type=writeOff.getType();
			List<WriteOffSub> subList=new ArrayList<WriteOffSub>();
		 switch(type) {
		 case 1:
			 subList.addAll(writeOffSubService.selectSalesById(id));
			 break;
		 case 2:
			 subList.addAll(writeOffSubService.selectProcureById(id));
			 break;
		 case 5:
			 subList.addAll(writeOffSubService.selectSalesById(id));
			 subList.addAll(writeOffSubService.selectProcureById(id));
			 break;
		 case 6:
			 subList.addAll(writeOffSubService.selectProcureById(id));
			 subList.addAll(writeOffSubService.selectSalesById(id));
			 break;
		 }
		
		 writeOff.setWriteOffSubs(subList);
	 
	 return createWriteOffDetail(writeOff);
	 }
	private JSONObject createWriteOffDetail(WriteOff writeOff) {
		JSONObject outboundOrderJSON = new JSONObject();
		Integer type=writeOff.getType();
		String typeName="";
		String company1Title="";
		String company2Title="";
		String advanceType="";
		String tableTitle1="";
		String tableTitle2="";
		//客户单据引用
 		 switch(type) {
		 case 1:
			 typeName="预收冲应收";
			 company1Title="预收客户";
			 company2Title="应收客户";
			 advanceType="当前预收余额";
			  tableTitle1="单据引用";
			 break;
		 case 2:
			 typeName="预付冲应付";
			 company1Title="预付供应商";
			 company2Title="应付供应商";
			 advanceType="当前预付余额";
			 tableTitle1="单据引用";
 			 break;
		 case 5:
			 typeName="应收冲应付";
			 company1Title="应收客户";
			 company2Title="应付供应商";
			 advanceType="当前预收余额";
			tableTitle1="客户单据引用";
			tableTitle2="供应商单据引用";
			 break;
		 case 6:
			 company1Title="应付供应商";
			 company2Title="应收客户";
			 typeName="应付冲应收";
			 advanceType="当前预付余额";
			tableTitle1="供应商单据引用";
			tableTitle2="客户单据引用";
			 break;
		 }
 		outboundOrderJSON.put("title", "往来核销单");
 		outboundOrderJSON.put("date", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(writeOff.getCreateDate()));
		outboundOrderJSON.put("oddNumbers",writeOff.getWriteoffCode());
		/* head start */
		List<FormHeadAndFooter> heads = new ArrayList<>();
		FormHeadAndFooter	head = new FormHeadAndFooter();
		head.setFieldName("核销方式");
		head.setFieldValue(typeName);
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName(company1Title);
		head.setFieldValue(writeOff.getCompanyOneName());
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName(company2Title);
		head.setFieldValue(writeOff.getCompanyTwoName());
		heads.add(head);
		
	
		
		head = new FormHeadAndFooter();
		head.setFieldName("币种");
		head.setFieldValue("人民币");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("汇率");
		head.setFieldValue("1");
		heads.add(head);
		
		head = new FormHeadAndFooter();
		head.setFieldName("凭证号");
		head.setFieldValue(writeOff.getVoucherNo());
		heads.add(head);

		String[] theads = {"单据编号","单据日期","总金额","已结算金额","未结算金额","本次核销","核销","备注"};
		//销售订单
		List<String[]> tbodys1 = new ArrayList<>();
		//采购订单
		List<String[]> tbodys2 = new ArrayList<>();
		DecimalFormat df = new DecimalFormat("#.##");
		Double theMoneyTotal=0.0;
 			for(WriteOffSub sub:writeOff.getWriteOffSubs()) {
				String  orderTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sub.getOrderTime());
				String[]  tbody=new String[]{
				sub.getIdentifier(),orderTime,df.format(sub.getOrderMoney()).toString(),df.format(sub.getClearMoney()),
				df.format(sub.getStayMoney()),df.format(sub.getTheMoney()),sub.getIsWriteoff()==1?"是":"否",
				sub.getRemark()
				};
				if(type==1||type==2) {
					theMoneyTotal+=sub.getTheMoney();
					tbodys1.add(tbody);
				}else if(type==5) {
					if(sub.getIsProcureSales()==1) {
						tbodys1.add(tbody);
						theMoneyTotal+=sub.getTheMoney();
					}else {
						tbodys2.add(tbody);
					}
				}else if(type==6) {
					if(sub.getIsProcureSales()==2) {
						tbodys1.add(tbody);
						theMoneyTotal+=sub.getTheMoney();
					}else {
						tbodys2.add(tbody);
					}
				}
				
			}
 			//合计
 			List<JSONObject> totalCountList = new ArrayList<>();
			JSONObject totalCountJSON = new JSONObject();
			totalCountJSON.put("col", "5");
			totalCountJSON.put("colTotal",theMoneyTotal.toString());
			totalCountList.add(totalCountJSON);
			
			JSONObject totalJSON = new JSONObject();
			totalJSON.put("haveTotal", "true");
			totalJSON.put("total", totalCountList);
			//table1
			JSONObject tableJSON1=new JSONObject();
			tableJSON1.put("thead", theads);
			tableJSON1.put("tbody", tbodys1);
			tableJSON1.put("total", totalJSON);
			tableJSON1.put("title", tableTitle1);
			outboundOrderJSON.put("table", tableJSON1);
			if(tbodys2.size()>0) {
				//table2
				JSONObject tableJSON2=new JSONObject();
				tableJSON2.put("thead", theads);
				tableJSON2.put("tbody", tbodys2);
				tableJSON2.put("total", totalJSON);
				tableJSON2.put("title", tableTitle2);
				outboundOrderJSON.put("table1", tableJSON1);
				outboundOrderJSON.put("table2", tableJSON2);
			}
			/* footer start */
			List<FormHeadAndFooter> footers = new ArrayList<>();
	 
			FormHeadAndFooter footer = new FormHeadAndFooter();
			footer.setFieldName("部门");
	 		footer.setFieldValue(writeOff.getDepartmentName());
			footers.add(footer);
			footer = new FormHeadAndFooter();
			footer.setFieldName("业务员");
			footer.setFieldValue(writeOff.getPersonName());
			footers.add(footer);
	 
			footer = new FormHeadAndFooter();
			footer.setFieldName("制单人");
			footer.setFieldValue(
					writeOff.getOriginatorName()!=null?(writeOff.getOriginator() + "(" + writeOff.getOriginatorName()+ ")"):writeOff.getOriginator()
			);
			footers.add(footer);
			footer = new FormHeadAndFooter();
			footer.setFieldName("摘要");
			footer.setFieldValue(writeOff.getSummary());
			footers.add(footer);
			footer = new FormHeadAndFooter();
			footer.setFieldName("分支机构");
			footer.setFieldValue(writeOff.getBranch());
			footers.add(footer);
			
			head = new FormHeadAndFooter();
			head.setFieldName(advanceType);
			head.setFieldValue(theMoneyTotal.toString());
			heads.add(head);
			outboundOrderJSON.put("head", heads);
			outboundOrderJSON.put("footer", footers);
			/* footer end */
 		 return outboundOrderJSON;
	}
}
