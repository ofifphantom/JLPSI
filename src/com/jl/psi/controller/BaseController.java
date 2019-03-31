package com.jl.psi.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.jl.psi.utils.Constants;
import com.jl.psi.utils.ResultInfo;
import com.jl.psi.utils.SHAUtil;

public class BaseController {

	public static ResultInfo info = new ResultInfo();
	
	/**
	 * 验证session是否失效
	 */
	public boolean checkSession(HttpServletRequest request){
		HttpSession session = request.getSession();
		if(!session.getAttributeNames().hasMoreElements()){
			try {
				SHAUtil.shaEncode("1");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return Constants.FAILURE;
		}else{
			return Constants.SUCCESS;
		}
	};
	
}
