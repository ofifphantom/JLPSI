package com.jl.psi.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSONObject;
import com.jl.psi.model.SalesPlanOrder;
import com.jl.psi.model.SalesPlanOrderCommodity;
import com.jl.psi.service.ActivityService;
@Controller
@RequestMapping("/activity/")
public class ActivityController {
	
	@Autowired
	private ActivityService  activityService;
	
	/**
	 * 处理从miss后台传来的订单
	 * @param requestJson
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value = "createActivity", method = RequestMethod.POST)
	  public  JSONObject  createActivity(@RequestBody String requestJson)  {
		  JSONObject result=new JSONObject();
		    try {
				net.sf.json.JSONObject json = net.sf.json.JSONObject.fromObject(requestJson);
				net.sf.json.JSONObject jsonobject = net.sf.json.JSONObject.fromObject(json.getString("planOrder"));
				Map<String, Class> map = new HashMap<String, Class>();
				map.put("salesPlanOrderCommodities",SalesPlanOrderCommodity.class); // key为teacher私有变量的属性名
				// 把JSON串转换成对象
				SalesPlanOrder spo = (SalesPlanOrder) net.sf.json.JSONObject.toBean(jsonobject, SalesPlanOrder.class, map);
				Integer activityId=json.getInt("activityId");
				Integer activityType=json.getInt("activityType");
				Date generatedTime=null;
				if(activityId!=0) {
					SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				    String d = format.format(json.getLong("generatedTime"));  
					   generatedTime=format.parse(d);
				}
				
						 
				activityService.createActivity(activityId, activityType,generatedTime, spo);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		  result.put("success", true);
		  return result;
		  
		  
	  } 
}
