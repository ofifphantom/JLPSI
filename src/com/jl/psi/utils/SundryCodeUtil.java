package com.jl.psi.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 员工Code等获取
 * @author wk
 * @since 2017年1月20日13:21:57
 */
public class SundryCodeUtil {
	
	
	/**
	 * 流水编号获取规则
	 * @param Code类型代码 
	 * @return 流水编号
	 */
	public static String getPosCode(int code){
		
		//String company = "JLPSI";
		
		String result =  null;
		switch (code) {
		
		case Constants.CODE_ADMIN:
			result = Constants.NO_ADMIN + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_GOODSONECLASSIFICATION:
			result = Constants.NO_GOODSONECLASSIFICATION + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_GOODSTWOCLASSIFICATION:
			result = Constants.NO_GOODSTWOCLASSIFICATION + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_SUPPLIER:
			result = Constants.NO_SUPPLIER + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_CUSTOMER:
			result = Constants.NO_CUSTOMER + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_GOODS:
			result = Constants.NO_GOODS + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_SETTLEMENT:
			result = Constants.NO_SETTLEMENT + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_DEPARTMENT:
			result = Constants.NO_DEPARTMENT + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_WAREHOUSE:
			result = Constants.NO_WAREHOUSE + DateUtil.getCurDateTime();
			break;
		case Constants.CODE_PERSON:
			result = Constants.NO_PERSON + DateUtil.getCurDateTime();
			break;
		default:
			break;
		}
		return result;
	}
	
	/**
	 * 获取管理员所处的用户组名称
	 * @param userGroupNo 用户组编号
	 * @return
	 */
	public static String getUserGroup(int userGroupNo){
		String result =  null;
		switch (userGroupNo) {
		case Constants.USER_GROUP_SUPER_ADMINISTRATOR:
			result ="超级管理员";
			break;
		case Constants.USER_GROUP_ADMINISTRATOR:
			result ="管理员";
			break;
		case Constants.USER_GROUP_OPERATOR:
			result ="操作员";
			break;
		default:
			break;
		}
		return result;
	}
	
	/**
	 * 生成单据编号
	 * @param prefix 前缀
	 * @param maxIdentifier 现有的最大的编号
	 * @return
	 */
	public static String createInvoicesIdentifier(String prefix,String maxIdentifier){
		Date date=new Date();
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		String identifier=prefix+"-"+dateFormat.format(date);
		
		if(maxIdentifier!=null&&!"".equals(maxIdentifier)){
			String identifierSixNum=(Integer.parseInt(maxIdentifier.substring(maxIdentifier.length()-6,maxIdentifier.length()))+1)+"";
			
			switch (identifierSixNum.length()) {
			case 1:
				identifier+="-00000"+identifierSixNum;
				break;
			case 2:
				identifier+="-0000"+identifierSixNum;
				break;
			case 3:
				identifier+="-000"+identifierSixNum;
				break;
			case 4:
				identifier+="-00"+identifierSixNum;
				break;
			case 5:
				identifier+="-0"+identifierSixNum;
				break;
			case 6:
				identifier+="-"+identifierSixNum;
				break;
			case 7:
				identifier+="-000000";
				break;

			default:
				break;
			}
		}
		else{
			identifier+="-000000";
		}
		return identifier;
	}
	
	
}
