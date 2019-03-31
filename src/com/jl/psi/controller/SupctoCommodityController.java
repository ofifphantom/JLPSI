package com.jl.psi.controller;



import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jl.psi.model.SupctoCommodity;
import com.jl.psi.service.SupctoCommodityService;

/**
 * 客户商品信息Controller
 * @author 景雅倩
 * @date  2017-11-8  下午4:39:52
 * @Description TODO
 */
@Controller
@RequestMapping("/basic/supctoCommodity/")
public class SupctoCommodityController extends BaseController{

	
	@Autowired
	private SupctoCommodityService supctoCommodityService;
	
	/**
	 * 根据客户id查询信息
	 * @param request
	 * @param supctoId 客户id
	 * @param flag  1：详情   2：编辑
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "selectSupctoCommodityBySupctoId")
	public List<SupctoCommodity> selectSupctoCommodityBySupctoId(HttpServletRequest request,Integer supctoId,Integer flag) throws Exception {

		return supctoCommodityService.selectSupctoCommodityBySupctoId(supctoId,flag);
	}
	
	/**
	 * 根据商品规格ID以及客户Id查询价格
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "selectPriceByCommoditySpIdAndSupId")
	public SupctoCommodity selectPriceByCommoditySpIdAndSupId(HttpServletRequest request,SupctoCommodity supctoCommodity) throws Exception {
		Double price=supctoCommodityService.selectPriceByCommoditySpIdAndSupId(supctoCommodity);
		supctoCommodity.setPrice(price);
		return supctoCommodity;
	}
	
	
	
}