package com.jl.mis.api;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.controller.BaseController;
import com.jl.psi.model.ApiCommodityMsg;
import com.jl.psi.service.CommoditySpecificationService;

/**
 * 商品信息API
 * @author 柳亚婷
 * @Description: TODO
 * @date: 2018年6月22日 上午9:41:48
 */
@Controller
@RequestMapping("/commodityInfoApi/")
public class CommodityInfoApi extends BaseController{
	
	@Autowired
	CommoditySpecificationService commoditySpecificationService;
	
	/**
	 * 供MIS后台商品添加的查询购销存商品 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "getCommodityInfo", method = RequestMethod.GET)
	public JSONObject getCommodityInfo(HttpServletRequest request, HttpServletResponse httpServletResponse) throws Exception {
		//解决跨域问题
        // 指定允许其他域名访问
        httpServletResponse.setHeader("Access-Control-Allow-Origin", "*");
        // 响应类型
        httpServletResponse.setHeader("Access-Control-Allow-Methods", "GET");
        // 响应头设置
        httpServletResponse.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
        
		JSONObject result = new JSONObject();
		//获取所有的商品信息(除去组装商品)，状态为通过
		List<ApiCommodityMsg> apiCommodityMsgs=new ArrayList<>();
		apiCommodityMsgs=commoditySpecificationService.selectCommodityMsgToMisGoodsApi();
		
		result.put("resultData", apiCommodityMsgs);
		result.put("code", 200);
		result.put("msg", "请求成功");
		return result;
	}

}
