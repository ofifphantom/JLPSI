package com.jl.psi.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

 import com.jl.psi.utils.SHAUtil;

public class SessionFilter implements Filter{
	private static Logger logger = Logger.getLogger(SessionFilter.class);

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse) res;
		//boolean success=request.getSession().getAttributeNames().hasMoreElements();
		boolean success=request.getSession().getAttribute("loginName")==null?false:true;
		System.out.println(request.getSession().getAttribute("loginName")==null);
		logger.info("过滤器拦截url==========="+request.getRequestURI()+"===========start");
		if(!success&&!request.getRequestURI().equals("/JLPSI/PictureCheckCode")
				&&!request.getRequestURI().equals("/JLPSI/doLogin")&&!request.getRequestURI().equals("/JLPSI/login")
				&&!request.getRequestURI().equals("/JLPSI/activity/createActivity")&&!(request.getRequestURI().indexOf("junlin")!=-1)
				&&!request.getRequestURI().equals("/JLPSI/commodityInfoApi/getCommodityInfo")) {
			try {
				SHAUtil.shaEncode("1");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.getRequestDispatcher("/login").forward(request,
					response); 
		}else {
			logger.info("过滤器拦截url==========="+request.getRequestURI()+"===========end");
			chain.doFilter(req, response);
		}
 
		
		
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	
	
}
