<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = path + "/";
	String ipPath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String MISPath=request.getScheme()+"://"+request.getServerName()+":"+"8080";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<title>查看商品信息</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%@include file="/common.jsp"%>
<script
	src="${pageContext.request.contextPath}/junlin/script/Fraction.js"
	type="text/javascript"></script>
<style>
#editDiv {
	padding-top: 20px;
}

.col-xs-4.control-label {
	padding: 0;
}

/*单位信息*/
.unit {
	border: 2px dashed #eee;
	/*box-shadow: 2px 3px 10px rgba(0, 0, 0, 0.5);*/
	margin: 10px;
	padding: 10px;
	margin-bottom: 30px;
	position: relative;
	padding-top: 25px;
}

.close_unit {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #b5b5b5;
	z-index: 1;
	cursor: pointer;
}
#editDiv .jl-btn-importent,#editDiv .jl-btn-defult{
	float: right;
    margin-top: 13px;
}
.unit-title span{
    font-weight: bold;
    margin-left: 10px;
    border-left:5px solid #e8efd4;
    clear: both;
    padding: 0px 5px;
}
.jl-panel{
	position: relative;
}
#searchTime{
	width:190px
}
</style>
</head>

<body class="content" id="goodsManagerPage">
	<div class="page-content clearfix">
		<div id="Member_Ratings">
			<div class="d_Confirm_Order_style" style="margin-top: 10px;">
				<h4 class="text-title">查看商品信息</h4>
				<div class="search-div clearfix">
					<div class="clearfix">
						<span class="l_f"> 分类：
						<select id="searchClassificationOneId" onchange="getDataToTwoClassification(1)"></select> 
						<select id="searchClassificationTwoId"></select>
						</span> 
						<span class="l_f"> 商品名称： 
						<input type="text" value="" id="searchName" onblur="cky(this)" />
						</span> 
						<span class="l_f"> 操作人姓名： 
						<input type="text" value="" id="searchOperatorName" onblur="cky(this)" />
						</span> 
						<span class="l_f"> 供货商： 
						<select id="searchSupctoId"></select>
						</span> 
						<span class="l_f"> 
							起止时间： <input type="text"  value="" id="searchTime" placeholder="请选择时间" readonly=""  />
						</span>
						<span class="r_f"> 
						<input type="button" class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
					</div>

				</div>
				<div class="opration-div clearfix">
					<!-- <span class="r_f">
						<button type="button" class="btncss jl-btn-defult"
							onclick="goodsEduce()" style="margin-right: 0;">
							<i class="fa fa-download"></i> 导出全部
						</button>

					</span> <span class="r_f">
						<button type="button" class="btncss jl-btn-defult"
							onclick="goodsDel()">
							<i class="fa fa-trash"></i> 删除
						</button>
					</span> <span class="r_f">
						<button type="button" class="btncss jl-btn-defult"
							onclick="goodsAdd()">
							<i class="fa fa-plus"></i> 新增
						</button>
					</span> <span class="jl_f_l"> <input type="checkbox" name="id"
						id="checkAll" style="margin: 0 5px 0 0;"
						onclick="checkboxController(this)" />
					</span> <span class="jl_f_l"> <label for="checkAll">全选</label>
					</span> -->

				</div>
				<div class="table_menu_list">
					<form id="datatable_form">
						<table class="table table-striped table-hover col-xs-12"
							id="datatable">
							<thead class="table-header">
								<tr>
									<!-- <th>选择</th> -->
									<th>类别</th>
									<th>规格编号</th>
									<th>货品名</th>
									<th>属性</th>
									<th>单位</th>
									<th>规格</th>
									<th>采购价格</th>	
									<th>供货商</th>
									<th>状态</th>
									<th>操作人</th>
									<th>录入时间</th>
									<!-- <th width="30%">操作</th> -->
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="lookDiv" style="display: none;">
		<form class="container">
			<div class="row jl-title">
				<span>商品基本信息</span>
			</div>
			
			<div class="row jl-panel">
				<div class="col-xs-6">
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">编号：</label>
						<div class="col-xs-8" id="look_identifier"></div>
					</div>
					<div class="form-group">
						<label for="name" class="col-xs-4 control-label">产品名称：</label>
						<div class="col-xs-8" id="look_name" ></div>
					</div>
					<div class="form-group">
						<label for="classification_id_one" class="col-xs-4 control-label">货品类别：</label>
						<div class="col-xs-8" id="look_classificationId"></div>
					</div>
					<div class="form-group">
						<label for="basics_information" class="col-xs-4 control-label">基本信息：</label>
						<div class="col-xs-8" id="look_basicsInformation"></div>
					</div>
					<div class="form-group">
						<label for="attribute" class="col-xs-4 control-label">商品属性：</label>
						<div class="col-xs-8" id="look_attribute"></div>
					</div>
					<div class="form-group">
							<label for="" class="col-xs-4 control-label">默认税率：</label>
							<div class="col-xs-8" id="look_taxes">
							</div>
					</div>
					<div class="form-group">
						<label for="look_is_presell" class="col-xs-4 control-label">是否是预售：</label>
						<div class="col-xs-8" id="look_is_presell"></div>
					</div>
				</div>
				<div class="col-xs-6">
					
					<div class="form-group">
						<label for="supcto" class="col-xs-4 control-label">供货商：</label>
						<div class="col-xs-8" id="look_supctoId"></div>
					</div>
					
					<div class="form-group">
						<label for="mnemonic_code" class="col-xs-4 control-label">助记码：</label>
						<div class="col-xs-8" id="look_mnemonicCode"></div>
					</div>
					<div class="form-group">
						<label for="brand" class="col-xs-4 control-label">品牌：</label>
						<div class="col-xs-8" id="look_brand"></div>
					</div>
					
					<div class="form-group">
						<label for="zero_stock" class="col-xs-4 control-label">是否允许0库存出货：</label>
						<div class="col-xs-8" id="look_zeroStock"></div>
					</div>
					<div class="form-group">
						<label for="shout_name" class="col-xs-4 control-label">简称：</label>
						<div class="col-xs-8" id="look_shoutName"></div>
					</div>
					<div class="form-group">
						<label for="look_is_assemble" class="col-xs-4 control-label">是否是组装商品：</label>
						<div class="col-xs-8" id="look_is_assemble"></div>
					</div>
					
				</div>

			</div>
			
			<div class="row jl-title">
				<span>规格基本信息</span>
			</div>
			<div id="look_goodstypeDiv">
				<div class="row jl-panel">
					<div class="unit-title row"><span>基本信息</span></div>
					<div class="row unit">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">是否停用：</label>
								<div class="col-xs-8" id="look_is_delete"></div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">操作人：</label>
								<div class="col-xs-8" id="look_operatorIdentifier"></div>
							</div>
							<div class="form-group">
								<label for="specifications" class="col-xs-4 control-label">规格编号：</label>
								<div class="col-xs-8" id="look_specification_identifier"></div>
							</div>
							<div class="form-group">
								<label for="quality_period" class="col-xs-4 control-label">产品保质日期：</label>
								<div class="col-xs-8" id="look_qualityPeriod"></div>
							</div>
							<div class="form-group">
								<label for="warming_number" class="col-xs-4 control-label">预警数量：</label>
								<div class="col-xs-8" id="look_warningNumber"></div>
							</div>
							<div class="form-group">
								<label for="packaging_size" class="col-xs-4 control-label">包装尺寸：</label>
								<div class="col-xs-8" id="look_packagingSize"></div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">状态：</label>
								<div class="col-xs-8" id="look_state"></div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">录入时间：</label>
								<div class="col-xs-8" id="look_operatorTime"></div>
							</div>
							<div class="form-group">
								<label for="specifications" class="col-xs-4 control-label">规格：</label>
								<div class="col-xs-8" id="look_specifications"></div>
							</div>
							
							<div class="form-group">
								<label for="mini_order_quantity" class="col-xs-4 control-label">最小订货量：</label>
								<div class="col-xs-8" id="look_miniOrderQuantity"></div>
							</div>
							<div class="form-group">
								<label for="add_order_quantity" class="col-xs-4 control-label">最小订货增量：</label>
								<div class="col-xs-8" id="look_addOrderQuantity"></div>
							</div>
							
						</div>
					</div>
					
					
					<div class="look_unitDivAll">
						<div class="unit-title row"><span>基本单位信息</span></div>
						<div class="look_unitDiv row">
							<div class="unit clearfix check">
								<div class="col-xs-6">
									
									<div class="form-group">
										<label for="name " class="col-xs-4 control-label">单位名称：</label>
										<div class="col-xs-8" id="look_base_unit_name"></div>
									</div>
									<!-- <div class="form-group">
										<label for="ratio " class="col-xs-4 control-label">单位比率：</label>
										<div class="col-xs-8" id="look_base_unit_ratio"></div>
									</div> -->
									<div class="form-group">
										<label for="" class="col-xs-4 control-label">单价：</label>
										<div class="col-xs-8" id="look_base_unit_purchase_price"></div>
									</div>
								
									<div class="form-group">
										<label for="mini_price " class="col-xs-4 control-label">最低销售价格：</label>
										<div class="col-xs-8" id="look_base_unit_mini_price"></div>
									</div>
								</div>
								<div class="col-xs-6 ">
									<div class="form-group">
										<label for="bar_code " class="col-xs-4 control-label">条形码：</label>
										<div class="col-xs-8" id="look_base_unit_bar_code"></div>
									</div>
									<div class="form-group">
										<label for="commonly_price " class="col-xs-4 control-label">一般销售价格：</label>
										<div class="col-xs-8" id="look_base_unit_commonly_price"></div>
									</div>
									<!-- <div class="form-group">
										<label for="sales_unit " class="col-xs-4 control-label">销售单位：</label>
										<div class="col-xs-8" id="look_base_unit_sales_unit"></div>
									</div>
									<div class="form-group">
										<label for="Purchasing_unit " class="col-xs-4 control-label">采购单位：</label>
										<div class="col-xs-8" id="look_base_unit_purchasing_unit"></div>
									</div>
									<div class="form-group">
										<label for="warehouse_unit " class="col-xs-4 control-label">仓库单位：</label>
										<div class="col-xs-8" id="look_base_unit_warehouse_unit"></div>
									</div> -->
								</div>
		
							</div>
						</div>
						<div class="unit-title row otherUnitMsg"><span>其他单位信息</span></div>
						<div class="row otherUnitMsgDiv">
							<div class="unit clearfix check">
								<div class="col-xs-6">
									
									<div class="form-group">
										<label for="name " class="col-xs-4 control-label">单位名称：</label>
										<div class="col-xs-8" id="look_mini_order_name"></div>
									</div>
									<div class="form-group">
										<label for="ratio " class="col-xs-4 control-label">单位比率：</label>
										<div class="col-xs-8" id="look_mini_order_ratio"></div>
									</div>
									<!-- <div class="form-group">
										<label for="" class="col-xs-4 control-label">单价：</label>
										<div class="col-xs-8" id="look_mini_order_purchase_price"></div>
									</div>
									<div class="form-group">
										<label for="commonly_price " class="col-xs-4 control-label">一般销售价格：</label>
										<div class="col-xs-8" id="look_mini_order_commonly_price"></div>
									</div>
									<div class="form-group">
										<label for="mini_price " class="col-xs-4 control-label">最低销售价格：</label>
										<div class="col-xs-8" id="look_mini_order_mini_price"></div>
									</div> -->
								</div>
								<div class="col-xs-6 ">
									<div class="form-group">
										<label for="bar_code " class="col-xs-4 control-label">条形码：</label>
										<div class="col-xs-8" id="look_mini_order_bar_code"></div>
									</div>
									<!-- <div class="form-group">
										<label for="sales_unit " class="col-xs-4 control-label">销售单位：</label>
										<div class="col-xs-8" id="look_mini_order_sales_unit"></div>
									</div>
									<div class="form-group">
										<label for="Purchasing_unit " class="col-xs-4 control-label">采购单位：</label>
										<div class="col-xs-8" id="look_mini_order_purchasing_unit"></div>
									</div>
									<div class="form-group">
										<label for="warehouse_unit " class="col-xs-4 control-label">仓库单位：</label>
										<div class="col-xs-8" id="look_mini_order_warehouse_unit"></div>
									</div> -->
								</div>
		
							</div>
						</div>
						
					</div>
				
					<div class="look_inventoryDivAll">
						<div class="unit-title row"><span>存货信息</span>&nbsp;&nbsp;<b class="look_inventory_prompt"></b></div>
						
						<div id="look_inventory_div">
							<div class="unit clearfix" id="look_inventory1">
								<div class="col-xs-6">
									<div class="form-group">
										<label for="warehouse_id " class="col-xs-4 control-label">仓库名称：</label>
										<div class="col-xs-8 warehouse_id"></div>
									</div>
									<div class="form-group">
										<label for="mini_inventory " class="col-xs-4 control-label">库存下限：</label>
										<div class="col-xs-8 mini_inventory"></div>
									</div>
									<div class="form-group">
										<label for="max_inventory " class="col-xs-4 control-label">库存上限：</label>
										<div class="col-xs-8 max_inventory"></div>
									</div>
									<div class="form-group">
										<label for="carrying_amount" class="col-xs-4 control-label">账面金额：</label>
										<div class="col-xs-8 carrying_amount"></div>
									</div>
		
								</div>
								<div class="col-xs-6 ">
									<div class="form-group">
										<label for="occupied_inventory " class="col-xs-4 control-label">已占用数量：</label>
										<div class="col-xs-8 occupied_inventory"></div>
									</div>
									<div class="form-group">
										<label for="inventory " class="col-xs-4 control-label">实际数量：</label>
										<div class="col-xs-8 inventory"></div>
									</div>
									<div class="form-group">
										<label for="cost_price " class="col-xs-4 control-label">成本单价：</label>
										<div class="col-xs-8 cost_price"></div>
									</div>
								</div>
		
							</div>
		
						</div>
					</div>
				
				</div>
			</div>
		</form>
	</div>

	<!--新增 编辑 -->
	<!-- <div id="editDiv" style="display: none;">
		<form class="container">
			<div class="row jl-title">
				<span>商品基本信息</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<input type="text" class="hidden" id="commodity_id" />
					<input type="text" class="hidden" id="commodity_identifier" />
					<div class="form-group" id="edit_commodity_code_div">
						
					</div>
					<div class="form-group">
						<label for="name" class="col-xs-4 control-label">产品名称</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="edit_commodity_name" name="goodsname" data-provide="typeahead" placeholder="输入名称可自动进行检索"  onkeyup="cky(this)" onfocus="clearDisabled()" onblur="searchCommodityMsgByName()" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="classification_id_one" class="col-xs-4 control-label">货品类别</label>
						<div class="col-xs-4" style="padding-right: 0;">
							<select id="classification_id_one" class="form-control"
								style="border-right: 0;" onchange="getDataToTwoClassification(2)">

							</select>
						</div>
						<div class="col-xs-4" style="padding-left: 0;">
							<select id="edit_classification_id" class="form-control">

							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="basics_information" class="col-xs-4 control-label">基本信息</label>
						<div class="col-xs-8">
							<input type="text" class="form-control"
								id="edit_basics_information" onblur="cky(this)" maxlength="100"/>
						</div>
					</div>

					<div class="form-group">
						<label for="attribute" class="col-xs-4 control-label">商品属性</label>
						<div class="col-xs-8">
							<select name="" id="edit_attribute" class="form-control">
								<option value="-1">请选择</option>
								<option value="11">常温库</option>
								<option value="00">冷库</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label for="shout_name" class="col-xs-4 control-label">简称</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="edit_shout_name"
								onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="is_assemble" class="col-xs-4 control-label">是否是组装商品</label>
						<div class="col-xs-8">
							<select name="" id="is_assemble" class="form-control">
								<option value="-1">请选择</option>
								<option value="1">是</option>
								<option value="2">不是</option>
							</select>
						</div>
					</div>
					
				</div>
				<div class="col-xs-6">
					<div class="form-group" id="edit_commodity_time">
						
					</div>
					<div class="form-group">
						<label for="supcto" class="col-xs-4 control-label">供货商</label>
						<div class="col-xs-8">
							<select id="edit_supcto" class="form-control" name="">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="mnemonic_code" class="col-xs-4 control-label">助记码</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="edit_mnemonic_code"
								onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="brand" class="col-xs-4 control-label">品牌</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="edit_brand"
								onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					
					<div class="form-group">
						<label for="zero_stock" class="col-xs-4 control-label">是否允许0库存出货</label>
						<div class="col-xs-8">
							<select id="edit_zero_stock" class="form-control">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="0">不是</option>
								<option value="1">是</option>
							</select>
						</div>
					</div>
					<div class="form-group">
							<label for="" class="col-xs-4 control-label">默认税率</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_taxes" onkeyup="pressSmallNumZero(this)"/>
							</div>
					</div>
					<div class="form-group">
						<label for="is_presell" class="col-xs-4 control-label">是否是预售</label>
						<div class="col-xs-8">
							<select name="" id="is_presell" class="form-control">
								<option value="-1">请选择</option>
								<option value="1">是</option>
								<option value="2">不是</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row jl-title" >
				<span>商品规格</span> <button type="button" class="btncss jl-btn-importent" id="addSpecificationBtn" onclick="goodstypeAdd()">新增规格</button>
			</div>
			<div id="goodstypeDiv">
			</div>
			<div class="text-danger">注：该页面所有字段均为必填</div>
		</form>

	</div> -->

</body>
<script>
		
		//var subjects = ['PHP 宝宝开心 就折磨干', 'MySQL', 'SQL', 'PostgreSQL', 'HTML', 'CSS', 'HTML5', 'CSS3', 'JSON','14578952 绝味鸭脖 鸭架 好好吃'];
    	$('#edit_commodity_name').typeahead({
    		source: function(query, process) {
    			$("#edit_commodity_name").removeAttr("onblur");
				return $.ajax({
					url: '<%=basePath%>basic/goods/commodity/selectCommodityMsgByInputValue',
					type: 'post',
					data: {
						inputValue: query
					},
					success: function(result) {
						var resultList = [];
						console.log(result.length);
						for(var i = 0; i < result.length; i++) {
							var aItem = result[i].identifier + " " + result[i].name;
							resultList.push(aItem);
						}
						return process(resultList);
					},
				});

			},
    		updater: function (obj) {
	            var str=obj.split(" ");
	            
	            return str[1];
	        }
    	})
		
		/* 日期控件的初始化 */
		laydate.render({
			elem: "#edit_quality_period",
			type: 'date',
			format: 'yyyy-MM-dd',
			min:0
		});
		
		var oTable1;
		$("#btn_search").click(function() {
			$("#checkAll").removeAttr("checked");
			oTable1.fnDraw();
		});
		
		$("#is_presell").change(function() {
			if($(this).val()==1){
				$("#edit_zero_stock").val(1);
				$("#edit_zero_stock").attr("disabled","disabled");
			}
			else{
				$("#edit_zero_stock").val(-1);
				$("#edit_zero_stock").removeAttr("disabled","disabled");
			}
		});
		
		jQuery(function($) {
			laydate.render({
				elem: "#searchTime",
				range:'~'
			});
			
			//datatable赋值
			oTable1 = $('#datatable')
				.dataTable({
					"aaSorting": [
						[0, "desc"]
					], //默认第几个排序
					"bStateSave": false, //状态保存
					"bLengthChange": false, //改变每页显示数据数量
					"bFilter": false, //列搜索
					"iDisplayLength": 10, //默认每页显示的记录数
					"iDisplayStart": 0,
					"bServerSide": true, //是否开启服务端查询
					"sDom": 't<"row"<"col-sm-6"i><"col-sm-6"p>>',
					"ajax": {
						"type": "post",
						"dataType": "json",
						"async": false,
						"data": function(d) {
							return $.extend({}, d, {
								//添加额外的参数传给服务器(可以多个)
								"messageOrDelivery":6,
								"classificationId": $("#searchClassificationTwoId").val(),
								"name": $("#searchName").val(),
								"operatorName": $("#searchOperatorName").val(),
								"supctoId": $("#searchSupctoId").val(),
								"searchTime":$("#searchTime").val()				
							});
						},
						"url": "<%=basePath%>basic/goods/commodity/getCommodityMsg"
					},

					"aoColumns": [/* {
							"mData": "id",
							"bSortable": true,
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								return '<td><input type="checkbox" name="id" value="' + row.id + '" onclick="checkboxClick(\'#checkAll\')"/></td>';
							}
						}, */ {
							"mData": "commodity.classificationId",
							"bSortable": false,
							"sWidth": "8%",
							"sClass": "center",
							"mRender": function(data,type,row) {
								if(data!=null&&data!=""){
									if(row.commodity.classification!=null){
										return row.commodity.classification.name;
									}
									else{
										return data;
									}
								}
								else{
									return "";
								}
								
								
							}

						}, {
							"mData": "specificationIdentifier",
							"bSortable": false,
							"sWidth": "15%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								return '<td><span class="look-span" onclick="goodsDetail(' + row.id + ')">'+data+'</span></td>';
							}
						}, {
							"mData": "commodity.name",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center"
						}, {
							"mData": "commodity.attribute",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								if(data=="00"){
									return '冷库';	
								}
								else if(data=="11"){
									return '常温库';	
								}
								else if(data=="01"){
									return '预留';	
								}
								else if(data=="10"){
									return '预留';	
								}
									
							}

						}, {
							"mData": "units",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								if(data!=null&&data.length>0){
									for(var i=0;i<data.length;i++){
										if(data[i].basicUnit==1){
											return data[i].name;
										}
									} 
								}
								else{
									return '无';
								} 
								//return data.length;
								
							}

						}, {
							"mData": "specificationName",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center"

						}, {
							"mData": "units",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data,type,row) {
								if(data!=null){
									for(var i=0;i<data.length;i++){
										if(data[i].basicUnit==1){
											if(data[i].purchasePrice!=null){
												return data[i].purchasePrice;
											}
											else{
												return "0";
											}		
										}
									} 							
								}
								else{
									return "0";
								}
							}

						}, {
							"mData": "commodity.supctoId",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data,type,row) {
								if(row.commodity.supcto!=null){
									return row.commodity.supcto.name;
								}
								else{
									return "";
								}
							}

						}, {
							"mData": "state",
							"bSortable": false,
							"sWidth": "8%",
							"sClass": "center",
							"mRender": function(data,type,row) {
								 if(row.isDelete==1){
									return "已停用";
								}
								else{
									switch(data){
									case 1:
										return "未送审";
										break;
									case 2:
										return "待采购填写";
										break;
									case 9:
										return "采购审核中";
										break;
									case 4:
										return "采购审核驳回";
										break;
									case 5:
										return "待销售填写";
										break;
									case 6:
										return "销售审核中";
										break;
									case 7:
										return "销售审核驳回";
										break;
									case 3:
										return "销售审核通过";
										break;
									default:
										return "";
										break;
									}
								}
								return data;
								
							}

						}, {
							"mData": "operatorIdentifier",
							"bSortable": false,
							"sWidth": "15%",
							"sClass": "center",
							"mRender": function(data,type,row) {
								if(data!=null&&data!=""){
									if(row.person!=null){
										return data+"("+row.person.name+")";
									}
									else{
										return data;
									}
									
								}
								else{
									return "";
								}
								
							}
						}, {
							"mData": "operatorTime",
							"bSortable": false,
							"sWidth": "15%",
							"sClass": "center",
							"mRender": function(data,type,row) {
								if(data!=null&&data!=""){
									return getSmpFormatDateByLong(data, true);
								}
								else{
									return "";
								}
								
							}
						}/* ,

						{
							"mData": "id",
							"bSortable": false,
							"sWidth": "15%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								if(row.isDelete==1){
									return '<td><input type="button" class="btncss edit" value="启用" onclick="goodsStop('+data+',0)"/></td>'	
								}
								else{
									if(row.state==1||row.state==10){
										return '<td><input type="button" class="btncss edit"' +
										'onclick="goodsEdit(' + data + ')" value="编辑" />'+
										'<input type="button" class="btncss edit" onclick="goodsDelivery('+data+')" value="送至采购填写" /></td>'
									}
									else if(row.state==9||row.state==6||row.state==8){
										return '<td><input type="button" class="btncss edit" value="审核中" disabled="disabled" /></td>'
									}
									else if(row.state==2||row.state==5||row.state==4||row.state==7){
										return '<td><input type="button" class="btncss edit" value="填写中" disabled="disabled" /></td>'
									}
									else if(row.state==3){
										return '<td><input type="button" class="btncss edit" onclick="goodsStop('+data+',1)" value="停用" /></td>'									
									}
									
								}

								
							}
						} */
					],
					"oLanguage": {
						// 国际化配置
						"sLengthMenu": "每页显示 _MENU_ 条记录",
						"sZeroRecords": "没有数据记录",
						"sInfo": "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
						"sInfoEmpty": "",
						"sInfoFiltered": "(全部记录数 _MAX_ 条)",
						"oPaginate": {
							"sFirst": "首页",
							"sPrevious": "前一页",
							"sNext": "后一页",
							"sLast": "尾页"
						}
					}
				});
			//给添加时需要选择的供货商下拉框赋值
			getSupctoMsgByCustomerOrSupplier();
			//给添加时需要选择的仓库下拉框赋值
			getAllWarehouseMsg();
			/* 给页面里的一级分类下拉框赋值 */
			getDataToOneClassification(1);
		});
		
		//给页面里或者添加时需要选择的一级分类下拉框赋值
		function getDataToOneClassification(pageOrUpdateAndAdd){
			$.ajax({
				url: '<%=basePath%>basic/classification/selectAllOneClassifityByType',
				type: "POST",
				dataType: "json",
				data:{
					"type":3
				},
				async: false,
				cache: false,
				success: function(data) {
					//修改或者添加页面的分类下拉菜单
					if(pageOrUpdateAndAdd==2){
						$("#edit_classification_id").html("");
						$("#classification_id_one").html("");
						
						$("#edit_classification_id").append("<option value='-1' selected>--请先选择一级分类--</option>");
						if(data.length==0){
							$("#classification_id_one").append("<option value='-1' selected>--暂无数据，请到一级分类页面进行添加--</option>");	
						}
						else{
							$("#classification_id_one").append("<option value='-1' selected>--请选择--</option>");
							for(var i=0;i<data.length;i++){							
								var option = $("<option value='"+data[i].id+"'>"
										+ data[i].name + "</option>");
								$("#classification_id_one").append(option);
							}
						}	
					}
					//页面里的分类下拉菜单
					else{
						$("#searchClassificationOneId").html("");
						$("#searchClassificationTwoId").html("");
						
						$("#searchClassificationTwoId").append("<option value='-1' selected>--请先选择一级分类--</option>");
						if(data.length==0){
							$("#searchClassificationOneId").append("<option value='-1' selected>--暂无数据，请到一级分类页面进行添加--</option>");	
						}
						else{
							$("#searchClassificationOneId").append("<option value='-1' selected>--请选择--</option>");
							for(var i=0;i<data.length;i++){							
								var option = $("<option value='"+data[i].id+"'>"
										+ data[i].name + "</option>");
								$("#searchClassificationOneId").append(option);
							}
						}
					}
					
				}
			});
		}
		
		//给页面里或者添加时需要选择的二级分类下拉框赋值
		function getDataToTwoClassification(pageOrUpdateAndAdd){
			
			var parentId;
			if(pageOrUpdateAndAdd==2){
				parentId=$("#classification_id_one").val()-0;
			}
			else{
				parentId=$("#searchClassificationOneId").val()-0;
			}
			if(parentId>=0){
				$.ajax({
					url: '<%=basePath%>basic/classification/selectAllTwoClassifityByParentId',
					type: "POST",
					dataType: "json",
					data:{
						"parentId":parentId
					},
					async: false,
					cache: false,
					success: function(data) {
						//修改或者添加页面的分类下拉菜单
						if(pageOrUpdateAndAdd==2){
							$("#edit_classification_id").html("");
							if(data.length==0){
								$("#edit_classification_id").append("<option value='-1' selected>--暂无数据，请到二级分类页面进行添加--</option>");					
							}
							else{
								$("#edit_classification_id").append("<option value='-1' selected>--请选择--</option>");
								for(var i=0;i<data.length;i++){							
									var option = $("<option value='"+data[i].id+"'>"
											+ data[i].name + "</option>");
									$("#edit_classification_id").append(option);
								}
							}
						}
						//页面里的分类下拉菜单
						else{
							$("#searchClassificationTwoId").html("");
							if(data.length==0){
								$("#searchClassificationTwoId").append("<option value='-1' selected>--暂无数据，请到二级分类页面进行添加--</option>");					
							}
							else{
								$("#searchClassificationTwoId").append("<option value='-1' selected>--请选择--</option>");
								for(var i=0;i<data.length;i++){							
									var option = $("<option value='"+data[i].id+"'>"
											+ data[i].name + "</option>");
									$("#searchClassificationTwoId").append(option);
								}
							}
						}
						
					}
				});
			}
			else{
				if(pageOrUpdateAndAdd==2){
					$("#edit_classification_id").html("");
					$("#edit_classification_id").append("<option value='-1' selected>--请先选择一级分类--</option>");
				}
				else{
					$("#searchClassificationTwoId").html("");
					$("#searchClassificationTwoId").append("<option value='-1' selected>--请先选择一级分类--</option>");	
				}
			}
		}
		
		//给编辑时需要选择的二级分类下拉框赋值
		function getDataToTwoClassificationEdit(twoClassificationId){
			var parentId=$("#classification_id_one").val()-0;
			if(parentId>=0){
				$.ajax({
					url: '<%=basePath%>basic/classification/selectAllTwoClassifityByParentId',
					type: "POST",
					dataType: "json",
					data:{
						"parentId":parentId
					},
					async: false,
					cache: false,
					success: function(data) {
						$("#edit_classification_id").html("");
						if(data.length==0){
							$("#edit_classification_id").append("<option value='-1' selected>--暂无数据，请到二级分类页面进行添加--</option>");					
						}
						else{
							$("#edit_classification_id").append("<option value='-1' selected>--请选择--</option>");
							for(var i=0;i<data.length;i++){							
								var option = $("<option value='"+data[i].id+"'>"
										+ data[i].name + "</option>");
								$("#edit_classification_id").append(option);
							}
							$("#edit_classification_id").val(twoClassificationId);
						}
					}
				});
			}
			else{
				$("#edit_classification_id").html("");
				$("#edit_classification_id").append("<option value='-1' selected>--请先选择一级分类--</option>");
			}
		}
		
		
		//给添加时需要选择的供货商下拉框赋值
		function getSupctoMsgByCustomerOrSupplier(){
			$.ajax({
				url: '<%=basePath%>basic/supctoManager/getSupctoMsgByCustomerOrSupplier',
				type: "POST",
				dataType: "json",
				data:{
					"customerOrSupplier":2
				},
				async: false,
				cache: false,
				success: function(data) {
					$("#edit_supcto").html("");
					$("#searchSupctoId").html("");
					if(data.length==0){
						$("#edit_supcto").append("<option value='-1' selected>--暂无数据，请到供应商页面进行添加--</option>");	
						$("#searchSupctoId").append("<option value='-1' selected>--暂无数据，请到供应商页面进行添加--</option>");	
					}
					else{
						$("#edit_supcto").append("<option value='-1' selected>--请选择--</option>");
						$("#searchSupctoId").append("<option value='-1' selected>--请选择--</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"'>"
									+ data[i].name + "</option>");
							$("#edit_supcto").append(option);
							option = $("<option value='"+data[i].id+"'>"
									+ data[i].name + "</option>");
							$("#searchSupctoId").append(option);
						}
					}
				}
			});
		}
		
		var isHasWarehouseMsg=false;
		//给添加时需要选择的仓库下拉框赋值
		function getAllWarehouseMsg(){
			$.ajax({
				url: '<%=basePath%>basic/warehouse/selectAllWarehouse',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				success: function(data) {
					$("#warehouse_id"+inventory_index_num+"").html("");
					if(data.length==0){
						isHasWarehouseMsg=false;
						$("#warehouse_id"+inventory_index_num+"").append("<option value='-1' selected>--暂无数据，请到仓库页面进行添加--</option>");	
						$("#warehouse_id"+inventory_index_num+"").html("");
					}
					else{
						isHasWarehouseMsg=true;
						$("#warehouse_id"+inventory_index_num+"").append("<option value='-1' selected>--请选择--</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"'>"
									+ data[i].name + "</option>");
							$("#warehouse_id"+inventory_index_num+"").append(option);
						}
					}
				}
			});
		}
		
		/* 填写商品名称后 搜索该名称对应的供货商及分类信息，显示在页面中 */
		function searchCommodityMsgByName() {
			$.ajax({
				url: '<%=basePath%>/basic/goods/commodity/selectCommodityMsgByName',
				type: "POST",
				dataType: "json",
				data: {
					"name": $("#edit_commodity_name").val()
				},
				async: false,
				cache: false,
				success: function(data) {
					if(data != null) {
						$("#classification_id_one").val(data.classification.parentId);
						$("#edit_classification_id").empty();
						var option = $("<option selected value='" + data.classification.id + "'>" +
							data.classification.name + "</option>");
						$("#edit_classification_id").append(option);
						$("#classification_id_one").attr("disabled", "true");
						$("#edit_classification_id").attr("disabled", "true");
						$("#commodity_id").val(data.id);
						$("#commodity_identifier").val(data.identifier);
						$("#edit_basics_information").val(data.basicsInformation);
						$("#edit_attribute").val(data.attribute);
						$("#edit_shout_name").val(data.shoutName);
						$("#edit_supcto").val(data.supctoId);
						$("#edit_mnemonic_code").val(data.mnemonicCode);
						$("#edit_brand").val(data.brand);
						$("#edit_zero_stock").val(data.zeroStock);
						$("#edit_taxes").val(data.taxes);
						$("#is_assemble").val(data.isAssemble);
						$("#is_presell").val(data.isPresell);
						
						//全部设为不可更改
						$("#commodity_id").attr("disabled", "true");
						$("#commodity_identifier").attr("disabled", "true");
						$("#edit_basics_information").attr("disabled", "true");
						$("#edit_attribute").attr("disabled", "true");
						$("#edit_shout_name").attr("disabled", "true");
						$("#edit_supcto").attr("disabled", "true");
						$("#edit_mnemonic_code").attr("disabled", "true");
						$("#edit_brand").attr("disabled", "true");
						$("#edit_zero_stock").attr("disabled", "true");
						$("#edit_taxes").attr("disabled", "true");
						$("#is_assemble").attr("disabled", "true");
						$("#is_presell").attr("disabled", "true");
					}
				}
			});
		}
		
		/* 当填写名称时,商品里的输入框清空disabled事件 */
		function clearDisabled() {
			$("#commodity_id").val("");
			$("#commodity_identifier").val("");
			$("#edit_basics_information").val("");
			$("#edit_attribute").val("-1");
			$("#edit_shout_name").val("");
			$("#edit_supcto").val("-1");
			$("#edit_mnemonic_code").val("");
			$("#edit_brand").val("");
			$("#edit_zero_stock").val("-1");
			$("#edit_taxes").val("");
			$("#is_assemble").val("-1");
			$("#is_presell").val("-1");
			
			$("#classification_id_one").removeAttr("disabled");
			$("#edit_classification_id").removeAttr("disabled");
			$("#commodity_id").removeAttr("disabled");
			$("#commodity_identifier").removeAttr("disabled");
			$("#edit_basics_information").removeAttr("disabled");
			$("#edit_attribute").removeAttr("disabled");
			$("#edit_shout_name").removeAttr("disabled");
			$("#edit_supcto").removeAttr("disabled");
			$("#edit_mnemonic_code").removeAttr("disabled");
			$("#edit_brand").removeAttr("disabled");
			$("#edit_zero_stock").removeAttr("disabled");
			$("#edit_taxes").removeAttr("disabled");
			$("#is_assemble").removeAttr("disabled");
			$("#is_presell").removeAttr("disabled");
			getDataToOneClassification(2);
		}
		
		let unit_index_num=2;

		
		
		/*单位信息添加*/
		function unitAdd(thisbtn,addOrUpdate){
			
			let thispanelid=0;
			if(thisbtn==""){
				thispanelid=0;
			}
			else{
				thispanelid=$(thisbtn).attr("attr-id");
			}
			let str=`<div class="unit clearfix" id="unit`+unit_index_num+`" attr-id="`+thispanelid+`">
				<span class="close_unit" onclick="unitDel(this)"><i class="fa fa-times"></i></span>
							
							<div class="col-xs-6 ">
								<input type="text" class="form-control unit_id hidden"/>
								<div class="form-group">
									<div class="col-xs-4 text-right">
										<input type="radio" id="funda_f`+unit_index_num+`" class="funda_f" name="funda_f`+thispanelid+`" onclick="unitRadiocheck(this)"/>
									</div>
									<div  class="col-xs-8 text-left">选中该单位信息为基本单位</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label">单位名称</label>
									<div class="col-xs-8">
										<input type="text" class="form-control unit-name" id="name`+unit_index_num+`" onblur="decideUnitNameIsRepeat(this)"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label ">单位比率</label>
									<div class="col-xs-8">
										<input type="text" class="form-control ratio " id="ratio" onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
									</div>
								</div>
								<div class="form-group">
									<label  class="col-xs-4 control-label ">一般销售价格</label>
									<div class="col-xs-8">
										<input type="text" class="form-control commonly_price" id="commonly_price " disabled="disabled" placeholder="由销售填写"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label ">最低销售价格</label>
									<div class="col-xs-8">
										<input type="text" class="form-control mini_price" id="mini_price " disabled="disabled" placeholder="由采购填写"/>
									</div>
								</div>
							</div>
							<div class="col-xs-6 ">
								<div class="form-group">
									<div class="col-xs-4 text-right">
										<input type="radio" class="funda_s" name="funda_s`+thispanelid+`"/>
									</div>
									<div  class="col-xs-8 text-left">选中该单位信息为最小订货批量单位</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label">条形码</label>
									<div class="col-xs-8">
										<input type="text" class="form-control bar_code" id="bar_code " onblur="cky(this)"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label">销售单位</label>
									<div class="col-xs-8">
										<input type="text" class="form-control sales_unit" id="sales_unit " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label">采购单位</label>
									<div class="col-xs-8">
										<input type="text" class="form-control purchasing_unit" id="purchasing_unit " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label">仓库单位</label>
									<div class="col-xs-8">
										<input type="text" class="form-control warehouse_unit" id="warehouse_unit " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
									</div>
								</div>
							</div>
						</div>`;
						if(addOrUpdate==1){
							let hasEmpty=false;
							
							$("#goodstypeDiv"+thispanelid+" .unitDiv input[type='text']").each(function(){
							    //console.log($(this).val());
							    if(!$(this).hasClass("hidden")&&!$(this).hasClass("commonly_price")&&!$(this).hasClass("mini_price")){		
							    	 if($(this).val()==""){
									    	hasEmpty=true;
									    	laywarn("请将单位信息填写完整，再添加新的单位信息");
									    }
							    }
							   
							});
							if(hasEmpty==false){
								$("#goodstypeDiv"+thispanelid+" .unitDiv").append(str);
								unit_index_num++;
							}
						}
						else{
							$("#goodstypeDiv"+thispanelid+" .unitDiv").append(str);
							unit_index_num++;
						}
			
			
		}
		
		function unitPriceKeyUp(e){
			pressMoney(e);
			var $parents=$(e).parents(".unit");
			var commonly_price=$parents.find(".commonly_price").val();
			var mini_price=$parents.find(".mini_price").val();
			console.log("commonly_price:"+commonly_price+" mini_price:"+mini_price);
			if(commonly_price-0>0){
				if(mini_price-0>0){
					if(commonly_price-0<mini_price-0){
						laywarn("最低销售价格应小于一般销售价格，请重新填写。");	
						$parents.find(".mini_price").val("");
					}
				}
			}	
		}
		
		/*单位信息添加前的清空以及新添第一个*/
		function unitAddOrUpdateFirst(num){
			unit_index_num=2;
			$("#goodstypeDiv"+num+" .unitDiv").html("");
			let str=`<div class="unit clearfix" id="unit`+num+`" attr-id="`+num+`">

				<div class="col-xs-6">
					<div class="form-group">
						<input type="text" class="form-control unit_id hidden"/>
						<div class="col-xs-4 text-right">
							<input type="radio" id="funda_f1" class="funda_f" name="funda_f`+num+`" checked=""
								onclick="unitRadiocheck(this)" />
						</div>
						<div class="col-xs-8 text-left">选中该单位信息为基本单位</div>
					</div>
					<div class="form-group">
						<label for="name1" class="col-xs-4 control-label">单位名称</label>
						<div class="col-xs-8">
							<input type="text" class="form-control unit-name" id="name1"
								onblur="decideUnitNameIsRepeat(this)" />
						</div>
					</div>
					<div class="form-group">
						<label for="ratio" class="col-xs-4 control-label">单位比率</label>
						<div class="col-xs-8">
							<input type="text" class="form-control ratio" id="firstRadio"
								 disabled="disabled" value="1" onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
						</div>
					</div>
					<div class="form-group">
						<label for="commonly_price" class="col-xs-4 control-label">一般销售价格</label>
						<div class="col-xs-8">
							<input type="text" class="form-control commonly_price"
								id="commonly_price " disabled="disabled" placeholder="由销售填写"/>
						</div>
					</div>
					<div class="form-group">
						<label for="mini_price" class="col-xs-4 control-label">最低销售价格</label>
						<div class="col-xs-8">
							<input type="text" class="form-control mini_price"
								id="mini_price " disabled="disabled" placeholder="由采购填写" />
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<div class="col-xs-4 text-right">
							<input type="radio" id="funda_s1" class="funda_s" name="funda_s`+num+`" checked="" />
						</div>
						<div class="col-xs-8 text-left">选中该单位信息为最小订货批量单位</div>
					</div>
					<div class="form-group">
						<label for="bar_code " class="col-xs-4 control-label">条形码</label>
						<div class="col-xs-8">
							<input type="text" class="form-control bar_code" id="bar_code"
								onblur="cky(this)" maxlength="100" />
						</div>
					</div>
					<div class="form-group">
						<label for="sales_unit " class="col-xs-4 control-label">销售单位</label>
						<div class="col-xs-8">
							<input type="text" class="form-control sales_unit"
								id="sales_unit" onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
						</div>
					</div>
					<div class="form-group">
						<label for="purchasing_unit " class="col-xs-4 control-label">采购单位</label>
						<div class="col-xs-8">
							<input type="text" class="form-control purchasing_unit"
								id="purchasing_unit " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
						</div>
					</div>
					<div class="form-group">
						<label for="warehouse_unit " class="col-xs-4 control-label">仓库单位</label>
						<div class="col-xs-8">
							<input type="text" class="form-control warehouse_unit"
								id="warehouse_unit " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
						</div>
					</div>
				</div>

			</div>`;
			$("#goodstypeDiv"+num+" .unitDiv").append(str);
			
		}
		
		/*单位信息删除*/
		function unitDel(thisspan){
			if($(thisspan).parent().find("input[class='funda_f']").is(':checked')){
				
				layfail("该单位为基本单位，不能删除！")
				
				/* $("input[name='funda_f']").get(0).checked=true; 
				
				$('#firstRadio').val("1");
				$(".ratio").removeAttr("disabled");
				$('#firstRadio').attr("disabled","disabled"); */
				
				
			}else if($(thisspan).parent().find("input[class='funda_s']").is(':checked')){
				
				$("input[class='funda_s']").get(0).checked=true; 
				$(thisspan).parent().remove();
				
			}else{
				$(thisspan).parent().remove();
			}
			
			
			
			
		}
		
		/* 填写单位名称时判断该名称是否已存在 */
		function decideUnitNameIsRepeat(thisName){
			var parentId=$(thisName).parents(".unit").attr("attr-id");
			var onBlurId=$(thisName).attr("id");
			var inputName=$(thisName).val();
			if(inputName!=""){
				$("#goodstypeDiv"+parentId+" .unit-name").each(function(index, val){
					var eachId=$(val).attr("id");
					if(onBlurId!=eachId){
						if($(val).val()==inputName){
							$(thisName).val("");
							laywarn("该单位名称已存在，请重新填写");	
						}
					}
				});	
			}	
		}
		
		
		var checkedRadioId="unit0";//保存选中的基础单位区域的id值
		/*单位信息选择*/
		function unitRadiocheck(thisradio){
			var parentId=$(thisradio).parents(".unit").attr("attr-id");
			//获取要设置为基本单位的单位比率、销售单位、采购单位、仓库单位
			var checkedId=$(thisradio).parents('.unit').attr("id");
			var checkedRatio=$(thisradio).parents('.unit').find('.ratio').val();
			if(checkedRatio==""){
				$("#"+checkedRadioId+"").find(':radio').eq(0).prop("checked",true);
				$(thisradio).removeAttr("checked");
				laywarn("请先填写单位比率");		
			}
			else{
				$("#goodstypeDiv"+parentId+" .unitDiv .unit").each(function(index, val){
					var eachId=$(val).attr("id");
					if(checkedId!=eachId){
						var eachRatio=$(val).find('.ratio').val();	
						var eachFenzi=0;
						var eachFenmu=0;
						var checkedFenzi=0;
						var checkedFenmu=0;
						if(eachRatio.indexOf("/")>0){
							var attr=eachRatio.split('/');
							eachFenzi=attr[0];
							eachFenmu=attr[1];
						}
						else{
							eachFenzi=eachRatio;
							eachFenmu=1;
						}
						if(checkedRatio.indexOf("/")>0){
							var attr=checkedRatio.split('/');
							checkedFenzi=attr[0];
							checkedFenmu=attr[1];
						}
						else{
							checkedFenzi=checkedRatio;
							checkedFenmu=1;
						}
						let m = new Fraction(eachFenzi, eachFenmu);
						console.log("eachFenzi:"+eachFenzi+","+"eachFenmu:"+eachFenmu+","+"checkedFenzi:"+checkedFenzi+","+"checkedFenmu:"+checkedFenmu);
						console.log(m.printFraction());
						//$(val).find('.ratio').val(eachRatio+"/"+checkedRatio);
						$(val).find('.ratio').val(m.multiply(new Fraction(checkedFenmu, checkedFenzi)).printFraction());
					}
				});
				//获取其他单位的单位比率、销售单位、采购单位、仓库单位
				//先换算单位比率，换算过后通过单位比率换算销售单位、采购单位、仓库单位
				//然后赋值
				$(thisradio).parents('.unit').find('.ratio').val("1");
				if(editOrAdd==1){
					$("#goodstypeDiv"+parentId+" .ratio").removeAttr("disabled");
					$(thisradio).parents('.unit').find('.ratio').attr("disabled","disabled");	
				}
				
				checkedRadioId=checkedId;
			}
			
		}
		
		
		/* 选择仓库时判断所选的仓库是否已存在 */
		function decideWarehouseIsRepeat(thisWarehouse){
			var parentId=$(thisWarehouse).parents(".unit").attr("attr-id");
			var selectId=$(thisWarehouse).attr("id");
			var selectWarehouse=$(thisWarehouse).val();
			$("#goodstypeDiv"+parentId+" select").each(function(index, val){
				var eachId=$(val).attr("id");
				if(selectId!=eachId){
					if($(val).val()==selectWarehouse){
						$(thisWarehouse).val("-1");
						laywarn("该仓库已存在，请重新选择");	
					}
				}
			});
		}
		
		/*库存信息删除*/
		function inventoryDel(thisspan){
			$(thisspan).parents(".inventoryDiv").prev().find("button").removeClass("hidden");
			$(thisspan).parent().remove();
		}
		
		
		let inventory_index_num=1;
		/*库存信息添加*/
		function inventoryAdd(thisbtn){
			
			if(!isHasWarehouseMsg){
				laywarn("暂无仓库信息，请先添加");	
			}
			else if($(thisbtn).parents(".goodsSpecificationDiv").find(".inventoryDiv").children().length<1){
				$(thisbtn).addClass("hidden");
				let panelid=0;
				if(thisbtn==""){
					panelid=0;
				}
				else{
					panelid=$(thisbtn).attr("attr-id");
				}
				
				inventory_index_num++;
				let inventorystr=`
					<div class="unit clearfix " id="inventory`+inventory_index_num+`" attr-id="`+panelid+`">
						<span class="close_unit" onclick="inventoryDel(this)"><i class="fa fa-times "></i></span>
						<div class="col-xs-6 ">
							<input type="text" class="form-control inventory_id hidden"/>
							<div class="form-group">
								<label for="warehouse_id`+inventory_index_num+`" class="col-xs-4 control-label">仓库名称</label>
								<div class="col-xs-8">
									<select id="warehouse_id`+inventory_index_num+`" class="form-control warehouse_id"  onchange="decideWarehouseIsRepeat(this)">
									
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="mini_inventory " class="col-xs-4 control-label">库存下限</label>
								<div class="col-xs-8">
									<input type="text" class="form-control mini_inventory" id="mini_inventory " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
							</div>
						</div>
						<div class="col-xs-6 ">
							<div class="form-group">
								<label for="max_inventory " class="col-xs-4 control-label">库存上限</label>
								<div class="col-xs-8">
									<input type="text" class="form-control max_inventory" id="max_inventory " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
							</div>
							<div class="form-group">
								<label for=" " class="col-xs-4 control-label">商品数量</label>
								<div class="col-xs-8">
									<input type="text" class="form-control commodity_num" id="commodity_num" onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
							</div>
						</div>

					</div>`;
			$("#goodstypeDiv"+panelid+" .inventoryDiv").append(inventorystr);
			//给添加时需要选择的仓库下拉框赋值
			getAllWarehouseMsg();
			}
		}
		
		/* 添加库存信息第一个 */
		function inventoryAddFirst(num){
			$("#goodstypeDiv"+num+" .inventoryDiv").html("");
			if(!isHasWarehouseMsg){
				laywarn("暂无仓库信息，请先添加");	
			}
			else{
				inventory_index_num=1;
				let inventorystr=`<div class="unit clearfix " id="inventory1" attr-id="`+num+`">
						<span class="close_unit" onclick="inventoryDel(this)"><i
							class="fa fa-times "></i></span>
						<div class="col-xs-6 ">
							<input type="text" class="form-control inventory_id hidden"/>
							<div class="form-group">
								<label for="warehouse_id1" class="col-xs-4 control-label">仓库名称</label>
								<div class="col-xs-8">
									<select id="warehouse_id1" class="form-control warehouse_id"
										onchange="decideWarehouseIsRepeat(this)">

									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="mini_inventory" class="col-xs-4 control-label">库存下限</label>
								<div class="col-xs-8">
									<input type="text" class="form-control mini_inventory"
										id="mini_inventory " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
							</div>


						</div>
						<div class="col-xs-6 ">
							<div class="form-group">
								<label for="max_inventory" class="col-xs-4 control-label">库存上限</label>
								<div class="col-xs-8">
									<input type="text" class="form-control max_inventory"
										id="max_inventory " onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
							</div>
							<div class="form-group">
								<label for=" " class="col-xs-4 control-label">商品数量</label>
								<div class="col-xs-8">
									<input type="text" class="form-control commodity_num" id="commodity_num" onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
							</div>
						</div>

					</div>`;
				$("#goodstypeDiv"+num+" .inventoryDiv").append(inventorystr);
				//给添加时需要选择的仓库下拉框赋值
				getAllWarehouseMsg();
				
			}
		}
		
		/* 填写规格名称时判断该名称是否已存在 */
		function decideSpecificationNameIsRepeat(thisName){	
			var onBlurId=$(thisName).attr("id");
			var inputName=$(thisName).val();
			var isRepeat=false;
			if(inputName!=""){
				$(".edit_specifications").each(function(index, val){
					
					var eachId=$(val).attr("id");
					console.log("goodsSpecificationDiv index:"+index+" onBlurId:"+onBlurId+" eachId:"+eachId);
					if(onBlurId!=eachId){
						if($(val).val()==inputName){
							$(thisName).val("");
							isRepeat=true;		
						}
					}
					console.log("goodsSpecificationDiv isRepeat:"+isRepeat);
				});	
			}
			var commodityId=$("#commodity_id").val();
			if(!isRepeat&&commodityId!=""){
				$.ajax({
					url: '<%=basePath%>basic/goods/commodity/selectGoodsSpecificationNamePreventRepeat',
					type: "POST",
					dataType: "json",
					data:{
						"specificationName":inputName,
						"commodityId":commodityId,
						"addOrUpdate":1
					},
					async: false,
					cache: false,
					traditional:true,//阻止深度序列化
					success: function(data) {
						if(!data.success) {
							$(thisName).val("");
							isRepeat=true;
						}
					}
				});
			}
			
			if(isRepeat){
				laywarn("该规格已存在，请重新填写");	
			}
		}
		
		

		/*送审*/
		function goodsDelivery(id) {
			var ids=[];
			ids.push(id);
				
			publicMessageLayer("送该商品去采购部", function() {
				$.ajax({
					url: '<%=basePath%>basic/goods/commodity/operateCommodityState',
					type: "POST",
					dataType: "json",
					data:{
						"ids":ids,
						"operate":2
					},
					async: false,
					cache: false,
					traditional:true,//阻止深度序列化
					success: function(data) {
						if(data.success) {
							laysuccess(data.msg);
							oTable1.fnDraw(false);
							$("#checkAll").removeAttr("checked");
						} else {
							layfail(data.msg);
						}
					}
				});
			})
		}

		/*详情*/
		function goodsDetail(id) {
			

			//获取数据显示在界面中
			$.ajax({
				url: '<%=basePath%>basic/goods/commodity/selectCommoditySpecificationMsgById',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"id": id
				},
				success: function(data) {
					if(data.isDelete==0){
						$("#look_is_delete").html("否");
					}
					else{
						$("#look_is_delete").html("是");
					}
					
					$("#look_identifier").html(data.commodity.identifier);
					$("#look_name").html(data.commodity.name);
					$("#look_basicsInformation").html(data.commodity.basicsInformation);
					$("#look_mnemonicCode").html(data.commodity.mnemonicCode);
					$("#look_brand").html(data.commodity.brand);
					$("#look_supctoId").html(data.commodity.supcto.name);
					$("#look_classificationId").html(data.commodity.classification.name);
					$("#look_shoutName").html(data.commodity.shoutName);
					if(data.commodity.zeroStock==0){
						$("#look_zeroStock").html("不是");
					}
					else{
						$("#look_zeroStock").html("是");
					}
					$("#look_taxes").html(data.commodity.taxes);
					switch (data.commodity.attribute) {
					case "00":
						$("#look_attribute").html("冷库");
						break;
					case "01":
						$("#look_attribute").html("预留");				
						break;
					case "10":
						$("#look_attribute").html("预留");
						break;
					case "11":
						$("#look_attribute").html("常温库");
						break;

					default:
						break;
					}
					if(data.commodity.isAssemble==1){
						$("#look_is_assemble").html("是");
					}
					else{
						$("#look_is_assemble").html("不是");
					}
					if(data.commodity.isPresell==1){
						$("#look_is_presell").html("是");
					}
					else{
						$("#look_is_presell").html("不是");
					}
					
					$("#look_specifications").html(data.specificationName);
					$("#look_specification_identifier").html(data.specificationIdentifier);
					$("#look_qualityPeriod").html(data.qualityPeriod+data.qualityPeriodUnit);
					$("#look_warningNumber").html(data.warningNumber);
					switch(data.state){
					case 1:
						$("#look_state").html("未送审");
						break;
					case 2:
						$("#look_state").html("待采购填写");
						break;
					case 9:
						$("#look_state").html("采购审核中");
						break;
					case 4:
						$("#look_state").html("采购审核驳回");
						break;
					case 5:
						$("#look_state").html("待销售填写");
						break;
					case 6:
						$("#look_state").html("销售审核中");
						break;
					case 7:
						$("#look_state").html("销售审核驳回");
						break;
					case 3:
						$("#look_state").html("销售审核通过");
						break;
					default:
						$("#look_state").html("");
						break;
					}
					if(data.person!=null){
						$("#look_operatorIdentifier").html(data.operatorIdentifier+"("+data.person.name+")");	
					}
					else{
						$("#look_operatorIdentifier").html(data.operatorIdentifier);
					}
					
					$("#look_operatorTime").html(getSmpFormatDateByLong(data.operatorTime, true));
					
					$("#look_miniOrderQuantity").html(data.miniOrderQuantity);
					$("#look_addOrderQuantity").html(data.addOrderQuantity);
					$("#look_packagingSize").html(data.packagingSize);
					
					
					
					for(var i=0;i<data.units.length;i++){
						if(i==0){
							
							if(data.units[i].purchasePrice!=null&&data.units[i].purchasePrice>0){
								$("#look_base_unit_purchase_price").html(data.units[i].purchasePrice);
							}
							else{
								$("#look_base_unit_purchase_price").html(0);
							}
							
							$("#look_base_unit_name").html(data.units[i].name);
							if(data.units[i].ratioDenominator==1){
								$("#look_base_unit_ratio").html(data.units[i].ratioMolecular);
							}
							else{
								$("#look_base_unit_ratio").html(data.units[i].ratioMolecular+"/"+data.units[i].ratioDenominator);
							}
							
							$("#look_base_unit_commonly_price").html(data.units[i].commonlyPrice);
							$("#look_base_unit_mini_price").html(data.units[i].miniPrice);
							$("#look_base_unit_bar_code").html(data.units[i].barCode);
							$("#look_base_unit_sales_unit").html(data.units[i].salesUnit);
							$("#look_base_unit_purchasing_unit").html(data.units[i].purchasingUnit);
							$("#look_base_unit_warehouse_unit").html(data.units[i].warehouseUnit);
						}
						
						if(data.units.length>1&&i==1){
							$(".otherUnitMsg").removeClass("hidden");
							$(".otherUnitMsgDiv").removeClass("hidden");
							if(data.units[i].purchasePrice!=null&&data.units[i].purchasePrice>0){
								$("#look_mini_order_purchase_price").html(data.units[i].purchasePrice);
							}
							else{
								$("#look_mini_order_purchase_price").html(0);
							}
							$("#look_mini_order_name").html(data.units[i].name);
							if(data.units[i].ratioDenominator==1){
								$("#look_mini_order_ratio").html(data.units[i].ratioMolecular);
							}
							else{
								$("#look_mini_order_ratio").html(data.units[i].ratioMolecular+"/"+data.units[i].ratioDenominator);
							}
							
							$("#look_mini_order_commonly_price").html(data.units[i].commonlyPrice);
							$("#look_mini_order_mini_price").html(data.units[i].miniPrice);
							$("#look_mini_order_bar_code").html(data.units[i].barCode);
							$("#look_mini_order_sales_unit").html(data.units[i].salesUnit);
							$("#look_mini_order_purchasing_unit").html(data.units[i].purchasingUnit);
							$("#look_mini_order_warehouse_unit").html(data.units[i].warehouseUnit);
						}
						else{
							$(".otherUnitMsg").addClass("hidden");
							$(".otherUnitMsgDiv").addClass("hidden");
						}
						
					}
					$("#look_inventory_div").html("");
					for(var i=0;i<data.inventories.length;i++){

							$(".look_inventory_prompt").html("");
							let inventoryDiv=`
							<div class="unit clearfix" id="look_inventory`+(i+1)+`">
								<div class="col-xs-6">
								<div class="form-group">
									<label for="warehouse_id " class="col-xs-4 control-label">仓库名称：</label>
									<div class="col-xs-8 warehouse_id"></div>
								</div>
								<div class="form-group">
									<label for="mini_inventory " class="col-xs-4 control-label">库存下限：</label>
									<div class="col-xs-8 mini_inventory"></div>
								</div>
								<div class="form-group">
									<label for="max_inventory " class="col-xs-4 control-label">库存上限：</label>
									<div class="col-xs-8 max_inventory"></div>
								</div>
								<div class="form-group">
									<label for="carrying_amount" class="col-xs-4 control-label">账面金额：</label>
									<div class="col-xs-8 carrying_amount"></div>
								</div>

							</div>
							<div class="col-xs-6 ">
								<div class="form-group">
									<label for="occupied_inventory " class="col-xs-4 control-label">已占用数量：</label>
									<div class="col-xs-8 occupied_inventory"></div>
								</div>
								<div class="form-group">
									<label for="inventory " class="col-xs-4 control-label">实际数量：</label>
									<div class="col-xs-8 inventory"></div>
								</div>
								<div class="form-group">
									<label for="cost_price " class="col-xs-4 control-label">成本单价：</label>
									<div class="col-xs-8 cost_price"></div>
								</div>
							</div>
						</div>`
						$("#look_inventory_div").append(inventoryDiv);
						
						$("#look_inventory"+(i+1)+" .warehouse_id").html(data.inventories[i].warehouse.name);
						$("#look_inventory"+(i+1)+" .mini_inventory").html(data.inventories[i].miniInventory);
						$("#look_inventory"+(i+1)+" .max_inventory").html(data.inventories[i].maxInventory);
						//账面金额：账面库存*成本单价
						$("#look_inventory"+(i+1)+" .carrying_amount").html((data.inventories[i].inventory-data.inventories[i].occupiedInventory)*data.inventories[i].costPrice);
						//$("#look_inventory"+(i+1)+" .carrying_amount").html("暂没查");
						$("#look_inventory"+(i+1)+" .occupied_inventory").html(data.inventories[i].occupiedInventory);
						//实际数量：账面库存+占用数量
						$("#look_inventory"+(i+1)+" .inventory").html(data.inventories[i].inventory);
						$("#look_inventory"+(i+1)+" .cost_price").html(data.inventories[i].costPrice);
					}
					
					 if(data.inventories.length==0){
						// $("#look_inventory1").remove();
						 $(".look_inventory_prompt").html("暂无该信息");
					}	
				}
			});
			layer.open({
				type: 1,
				title: "商品详情 ",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#lookDiv "),
				btn: ['关闭']
			});
		}
		var editOrAdd=1;//2表示编辑，1表示添加

		/*修改*/
		function goodsEdit(id) {
			editOrAdd=2;
			$("#addSpecificationBtn").attr("hidden","true");
			$("#edit_commodity_code_div").html('<label for="mnemonic_code" class="col-xs-4 control-label">产品编码</label><div class="col-xs-8"><input type="text" class="form-control" id="edit_commodity_code" onblur="cky(this)" disabled="disabled" /></div>');
			$("#edit_commodity_time").html('<label for="mnemonic_code" class="col-xs-4 control-label">录入时间</label><div class="col-xs-8"><input type="text" class="form-control" id="edit_add_time" onblur="cky(this)" disabled="disabled" /></div>')
			$("#edit_commodity_name").attr("disabled","disabled");	
			$("#commodity_id").attr("disabled", "true");
			$("#commodity_identifier").attr("disabled", "true");
			$("#classification_id_one").attr("disabled", "true");
			$("#edit_classification_id").attr("disabled", "true");
			$("#edit_basics_information").attr("disabled", "true");
			$("#edit_attribute").attr("disabled", "true");
			$("#edit_shout_name").attr("disabled", "true");
			$("#edit_supcto").attr("disabled", "true");
			$("#edit_mnemonic_code").attr("disabled", "true");
			$("#edit_brand").attr("disabled", "true");
			$("#edit_zero_stock").attr("disabled", "true");
			$("#edit_taxes").attr("disabled", "true");
			$("#is_assemble").attr("disabled", "true");
			$("#is_presell").attr("disabled", "true");
			
			getDataToOneClassification(2);
			//获取数据显示在界面中
			$.ajax({
				url: '<%=basePath%>basic/goods/commodity/selectCommoditySpecificationMsgById',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"id": id
				},
				success: function(data) {
					//商品信息
					$("#edit_commodity_code").val(data.commodity.identifier);
					$("#edit_add_time").val(getSmpFormatDateByLong(data.operatorTime, true));
					$("#commodity_id").val(data.commodity.id);
					$("#commodity_identifier").val(data.commodity.identifier);
					$("#edit_commodity_name").val(data.commodity.name);
					$("#edit_basics_information").val(data.commodity.basicsInformation);
					$("#edit_attribute").val(data.commodity.attribute);
					$("#classification_id_one").val(data.commodity.classification.parentId);
					getDataToTwoClassificationEdit(data.commodity.classification.id);
					$("#edit_shout_name").val(data.commodity.shoutName);			
					$("#edit_mnemonic_code").val(data.commodity.mnemonicCode);
					$("#edit_brand").val(data.commodity.brand);
					$("#edit_supcto").val(data.commodity.supctoId);
					$("#edit_zero_stock").val(data.commodity.zeroStock);	
					$("#edit_taxes").val(data.commodity.taxes);
					$("#is_assemble").val(data.commodity.isAssemble);
					$("#is_presell").val(data.commodity.isPresell);
					
					//规格信息
					goodstypeAddfirst();
					$(".edit_specification_id").val(data.id);
					$(".edit_specifications").val(data.specificationName);
					$(".edit_quality_period").val(data.qualityPeriod);
					$(".edit_quality_period_unit").val(data.qualityPeriodUnit);
					$(".edit_warming_number").val(data.warningNumber);
					$(".edit_weight").val(data.weight);
					$(".edit_mini_order_quantity").val(data.miniOrderQuantity);
					$(".edit_add_order_quantity").val(data.addOrderQuantity);
					$(".edit_packaging_size").val(data.packagingSize);
					
					$(".edit_specifications").attr("disabled", "true");
					$(".edit_packaging_size").attr("disabled", "true");
					$(".edit_weight").attr("disabled", "true");
					
					unitAddOrUpdateFirst(0);
					//单位信息
					if(data.units.length==1){
						$("#unit0 .unit-name").attr("disabled", "true");
						$("#unit0 .ratio").attr("disabled", "true");
						$("#unit0 .bar_code").attr("disabled", "true");
						
						$("#unit0 .unit_id").val(data.units[0].id);
						$("#unit0 .unit-name").val(data.units[0].name);
						if(data.units[0].ratioDenominator==1){
							$("#unit0 .ratio").val(data.units[0].ratioMolecular);
						}
						else{
							$("#unit0 .ratio").val(data.units[0].ratioMolecular+"/"+data.units[0].ratioDenominator);
						}	
						//$("#unit0 .commonly_price").val(data.units[0].commonlyPrice);
						//$("#unit0 .mini_price").val(data.units[0].miniPrice);
						$("#unit0 .bar_code").val(data.units[0].barCode);
						$("#unit0 .sales_unit").val(data.units[0].salesUnit);
						$("#unit0 .purchasing_unit").val(data.units[0].purchasingUnit);
						$("#unit0 .warehouse_unit").val(data.units[0].warehouseUnit);
					}
					else{
						for(var i=0;i<data.units.length;i++){
							if(i>0){
								unitAdd("",2);
								$("#unit"+(i+1)).find(".unit-name").attr("disabled", "true");
								$("#unit"+(i+1)+" .bar_code").attr("disabled", "true");
								
								$("#unit"+(i+1)).find(".unit_id").val(data.units[i].id);
								$("#unit"+(i+1)).find(".unit-name").val(data.units[i].name);
								if(data.units[i].ratioDenominator==1){
									$("#unit"+(i+1)).find(".ratio").val(data.units[i].ratioMolecular);
								}
								else{
									$("#unit"+(i+1)).find(".ratio").val(data.units[i].ratioMolecular+"/"+data.units[i].ratioDenominator);
								}	
								$("#unit"+(i+1)).find(".commonly_price").val(data.units[i].commonlyPrice);
								$("#unit"+(i+1)+" .mini_price").val(data.units[i].miniPrice);
								$("#unit"+(i+1)+" .bar_code").val(data.units[i].barCode);
								$("#unit"+(i+1)+" .sales_unit").val(data.units[i].salesUnit);
								$("#unit"+(i+1)+" .purchasing_unit").val(data.units[i].purchasingUnit);
								$("#unit"+(i+1)+" .warehouse_unit").val(data.units[i].warehouseUnit);
								if(data.units[i].basicUnit==1){
									$("#unit"+(i+1)+"").find(":radio").eq(0).prop("checked",true);							
									$("#unit"+(i+1)+"").find('.ratio').attr("disabled","disabled");	
									checkedRadioId="unit"+(i+1);
								}
								else{
									$("#unit"+(i+1)+"").find(":radio").eq(0).removeAttr("checked");
									$("#unit"+(i+1)+" .ratio").removeAttr("disabled");
								}
								if(data.units[i].miniPurchasing==1){
									$("#unit"+(i+1)+"").find(":radio").eq(1).prop("checked",true);
								}
								else{
									$("#unit"+(i+1)+"").find(":radio").eq(1).removeAttr("checked");
								}
							}
							else{
								$("#unit"+(i)).find(".unit-name").attr("disabled", "true");
								$("#unit"+(i)+" .bar_code").attr("disabled", "true");
								
								$("#unit"+(i)).find(".unit_id").val(data.units[i].id);
								$("#unit"+(i)).find(".unit-name").val(data.units[i].name);
								if(data.units[i].ratioDenominator==1){
									$("#unit"+(i)).find(".ratio").val(data.units[i].ratioMolecular);
								}
								else{
									$("#unit"+(i)).find(".ratio").val(data.units[i].ratioMolecular+"/"+data.units[i].ratioDenominator);
								}	
								//$("#unit"+(i)).find(".commonly_price").val(data.units[i].commonlyPrice);
								//$("#unit"+(i)+" .mini_price").val(data.units[i].miniPrice);
								$("#unit"+(i)+" .bar_code").val(data.units[i].barCode);
								$("#unit"+(i)+" .sales_unit").val(data.units[i].salesUnit);
								$("#unit"+(i)+" .purchasing_unit").val(data.units[i].purchasingUnit);
								$("#unit"+(i)+" .warehouse_unit").val(data.units[i].warehouseUnit);
								if(data.units[i].basicUnit==1){
									$("#unit"+(i)+"").find(":radio").eq(0).prop("checked",true);							
									$("#unit"+(i)+"").find('.ratio').attr("disabled","disabled");	
									checkedRadioId="unit"+(i+1);
								}
								else{
									$("#unit"+(i)+"").find(":radio").eq(0).removeAttr("checked");
									$("#unit"+(i)+" .ratio").removeAttr("disabled");
								}
								if(data.units[i].miniPurchasing==1){
									$("#unit"+(i)+"").find(":radio").eq(1).prop("checked",true);
								}
								else{
									$("#unit"+(i)+"").find(":radio").eq(1).removeAttr("checked");
								}
							}
							$(".ratio").attr("disabled","disabled");	
							
						}
					}
					
					inventoryAddFirst(0);
					
					if(data.inventories.length==1){
						$("#inventory1 .inventory_id").val(data.inventories[0].id);
						$("#inventory1 .warehouse_id").val(data.inventories[0].warehouseId);
						$("#inventory1 .mini_inventory").val(data.inventories[0].miniInventory);
						$("#inventory1 .max_inventory").val(data.inventories[0].maxInventory);
						$("#inventory1 .commodity_num").val(data.inventories[0].commodityNum);
						
						$("#inventory1 .commodity_num").attr("disabled", "true");
						
						$("#inventory1").parents(".inventoryDivAll").find("button").addClass("hidden");
					}
					/* else if(data.inventories.length>1){
						for(var i=0;i<data.units.length;i++){
							if(i>0){
								inventoryAdd("");				
							}
							$("#inventory"+(i+1)+" .inventory_id").val(data.inventories[i].id);
							$("#inventory"+(i+1)+" .warehouse_id").val(data.inventories[i].warehouseId);
							$("#inventory"+(i+1)+" .mini_inventory").val(data.inventories[i].miniInventory);
							$("#inventory"+(i+1)+" .max_inventory").val(data.inventories[i].maxInventory);
							$("#inventory"+(i+1)+" .commodity_num").val(data.inventories[i].commodityNum);
							
							$("#inventory"+(i+1)+" .commodity_num").attr("disabled", "true");
						}
					} */
					else{
						$("#inventory1").remove();
					}
					
					
				}
			});
			
			layer.open({
				type: 1,
				title: "编辑商品 ",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv "),
				btn: ['提交', '取消'],
				yes: function(index) {
					if(!decideInputAndSelectHasValue()){
						laywarn("表单未填写完整，请完善后再提交");	
						return;
					}
					//编辑提交时先判断该分类下的此商品名称是否存在
					<%-- $.ajax({
						url: '<%=basePath%>basic/goods/commodity/selectGoodsNamePreventRepeatEdit',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data: {
							"id":id,
							"name":$("#edit_commodity_name").val(),
							"classificationId":$("#edit_classification_id").val(),
							"supctoId":$("#edit_supcto").val()
						},
						success: function(data) {
							if(data.success) { --%>
								$.ajax({
									url: '<%=basePath%>basic/goods/commodity/editCommodityMsg',
									type: "POST",
									dataType: "json",
									data:{
										"commodityData":JSON.stringify(commodityDataToJSON())
									},
									async: false,
									cache: false,
									success: function(data) {
										if(data.success) {
											laysuccess(data.msg);
											oTable1.fnDraw(false);
											$("#checkAll").removeAttr("checked");
										} else {
											layfail(data.msg);
										}
									}
								});
								/* layer.close(index);
							} else {
								laywarn(data.msg);
							}

						}
					}); */
					layer.close(index);
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv ", " ");
					
					$("#edit_commodity_code_div").html('');
					$("#edit_commodity_time").html('')
					$("#edit_commodity_name").attr("disabled",false);	
					$("#edit_specifications").attr("disabled",false);	
					$("#edit_supcto").attr("disabled",false);	
					$("#edit_attribute").attr("disabled",false);
					
					$("#edit_commodity_name").removeAttr("disabled");	
					$("#commodity_id").removeAttr("disabled");	
					$("#commodity_identifier").removeAttr("disabled");	
					$("#classification_id_one").removeAttr("disabled");	
					$("#edit_classification_id").removeAttr("disabled");	
					$("#edit_basics_information").removeAttr("disabled");	
					$("#edit_attribute").removeAttr("disabled");	
					$("#edit_shout_name").removeAttr("disabled");	
					$("#edit_supcto").removeAttr("disabled");	
					$("#edit_mnemonic_code").removeAttr("disabled");	
					$("#edit_brand").removeAttr("disabled");	
					$("#edit_zero_stock").removeAttr("disabled");	
					$("#edit_taxes").removeAttr("disabled");	
					$("#is_assemble").removeAttr("disabled");	
					$("#is_presell").removeAttr("disabled");	
				}
			});
		}
		/*新增*/
		function goodsAdd() {
			editOrAdd=1;
			getDataToOneClassification(2);
			goodstypeAddfirst();
			layer.open({
				type: 1,
				title: "新增商品 ",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv "),
				btn: ['提交', '取消'],
				yes: function(index) {
					
					if(!decideInputAndSelectHasValue()){
						laywarn("表单未填写完整，请完善后再提交");	
						return;
					}
					//商品已存在
					if($("#commodity_id").val()!=""){
						MessageLayer("该商品已存在，保存即为新增规格。", function() {
							$.ajax({
								url: '<%=basePath%>basic/goods/commodity/addCommodityMsg',
								type: "POST",
								dataType: "json",
								data:{
									"commodityData":JSON.stringify(commodityDataToJSON())
								},
								async: false,
								cache: false,
								success: function(data) {
									if(data.success) {
										laysuccess(data.msg);
										oTable1.fnDraw(false);
										$("#checkAll").removeAttr("checked");
									} else {
										layfail(data.msg);
									}
									layer.close(index);
								}
								
							});

						})
					}
					//商品不存在
					else{
						$.ajax({
							url: '<%=basePath%>basic/goods/commodity/addCommodityMsg',
							type: "POST",
							dataType: "json",
							data:{
								"commodityData":JSON.stringify(commodityDataToJSON())
							},
							async: false,
							cache: false,
							success: function(data) {
								if(data.success) {
									laysuccess(data.msg);
									oTable1.fnDraw(false);
									$("#checkAll").removeAttr("checked");
								} else {
									layfail(data.msg);
								}
								layer.close(index);
							}
						});
						
					}
					
					//添加时先判断该分类下的此商品名称是否存在
					<%-- $.ajax({
						url: '<%=basePath%>basic/goods/commodity/selectGoodsNamePreventRepeatAdd',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data: {
							"name":$("#edit_commodity_name").val()
						},
						success: function(data) {
							if(data.success) {
								$.ajax({
									url: '<%=basePath%>basic/goods/commodity/addCommodityMsg',
									type: "POST",
									dataType: "json",
									data:{
										"commodityData":JSON.stringify(commodityDataToJSON())
									},
									async: false,
									cache: false,
									success: function(data) {
										if(data.success) {
											laysuccess(data.msg);
											oTable1.fnDraw(false);
											$("#checkAll").removeAttr("checked");
										} else {
											layfail(data.msg);
										}
									}
								});
								 layer.close(index);
							} else {
								laywarn(data.msg);
							}

						}
					}); --%>
					
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", " ");
					checkedRadioId="unit0";
					$("#edit_zero_stock").removeAttr("disabled","disabled");
				}
			});
		}
		/*删除*/
		function goodsDel() {
			//判断有无选择
			var str = "";
			$("input:checkbox[name='id']:checked").each(function() {
				if($(this).attr("id")!="checkAll"){
					str += $(this).val() + ",";
				}
			})
			if(str == "") {
				laywarn("请选择数据!");
				return;
			}
			$.ajax({
				url: '<%=basePath%>basic/goods/commodity/afterDelDecide',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: $("#datatable_form").serialize(),
				success: function(data) {
					if(data.success) {
						publicMessageLayer("删除选中数据", function() {
							$.ajax({
								url: '<%=basePath%>basic/goods/commodity/delBatchByPrimaryKey',
								type: "POST",
								dataType: "json",
								async: false,
								cache: false,
								data: $("#datatable_form").serialize(),
								success: function(data) {
									if(data.success) {
										laysuccess(data.msg);
										oTable1.fnDraw(false);
										$("#checkAll").removeAttr("checked");
									} else {
										layfail(data.msg);
									}
								}
							});

						})
					} else {
						layer.msg(data.msg, {
							icon: 0,
							time: 2500
						});
					}
				}
			});
			
			
		}
		
		/*停用*/
		function goodsStop(id,isDelete){
			var title="";
			if(isDelete==0){
				title="启用该商品"
			}
			else{
				title="停用该商品"
			}
			publicMessageLayer(title, function() {
				$.ajax({
					url: '<%=basePath%>basic/goods/commodity/notUseOrUse',
					type: "POST",
					dataType: "json",
					data:{
						"id":id,
						"isDelete":isDelete
					},
					async: false,
					cache: false,
					success: function(data) {
						if(data.success) {
							laysuccess(data.msg);
							oTable1.fnDraw(false);
							$("#checkAll").removeAttr("checked");
							if(isDelete==1){
								console.log("下架mis");
								//下架mis的商品
								$.ajax({
									url: '<%=MISPath%>/JLMIS/backgroundConfiguration/goods/goodsManager/offShelvesOperation',
									type: "POST",
									dataType: "json",
									data:{
										"commoditySpecId":id
									},
									async: false,
									cache: false,
									success: function(data) {
									}
								});
							}
						} else {
							layfail(data.msg);
						}
					}
				});
			})
		}

		/*导出全部*/
		function goodsEduce() {
			var export_classificationTwoId=encodeURI(encodeURI($("#searchClassificationTwoId").val()));
			var export_searchName=encodeURI(encodeURI($("#searchName").val()));
			var export_operatorName=encodeURI(encodeURI($("#searchOperatorName").val()));
			var export_supctoId=encodeURI(encodeURI($("#searchSupctoId").val()));
			
			publicMessageLayer("导出全部下列显示的数据", function() {
				var URL="<%=basePath%>basic/goods/commodity/exportCommodity?searchClassificationTwoId="+export_classificationTwoId+"&searchName="+export_searchName+"&searchOperatorName="+export_operatorName+"&searchSupctoId="+export_supctoId;
				 location.href=URL;
				return false;			
		})
		}
		
		/* 新增或者编辑时判断数据有没有填写完整 */
		function decideInputAndSelectHasValue(){
			var inputValue=true;
			var selectValue=true;
			$("#editDiv input[type='text']").each(function(index, val){	
				if(!$(val).hasClass("hidden")&&!$(val).hasClass("commonly_price")&&!$(val).hasClass("mini_price")){				
					if($(val).val()==""){
					inputValue=false;
				}	
				}
					
			});	
			$("#editDiv select").each(function(index, val){	
				if($(val).val()==-1){
					selectValue=false;
				}		
			});
			if(!inputValue||!selectValue){
				return false;
			}
			else{
				return true;
			}
			
		}
		
		/* 提交或者编辑时 把数据整合成json传入后台 */
		function commodityDataToJSON(){
			console.log("commodity_identifier",$("#commodity_identifier").val());
			//商品基础的信息
			var commodityDataJSON={"id":$("#commodity_id").val(),"identifier":$("#commodity_identifier").val(),"name":$("#edit_commodity_name").val(),"basicsInformation":$("#edit_basics_information").val(),"attribute":$("#edit_attribute").val(),"classificationId":$("#edit_classification_id").val(),"shoutName":$("#edit_shout_name").val(),
					"mnemonicCode":$("#edit_mnemonic_code").val(),"brand":$("#edit_brand").val(),"supctoId":$("#edit_supcto").val(),"zeroStock":$("#edit_zero_stock").val(),"taxes":$("#edit_taxes").val(),"isAssemble":$("#is_assemble").val(),"isPresell":$("#is_presell").val(),
					"commoditySpecifictions":[]};
			//商品规格的信息
			$("#goodstypeDiv .goodsSpecificationDiv").each(function(index, goodsval){
				var goodsSpecificationDataJSON={"id":$(goodsval).find(".edit_specification_id").val(),"specificationName":$(goodsval).find(".edit_specifications").val(),"commodityId":$("#commodity_id").val(),"qualityPeriod":$(goodsval).find(".edit_quality_period").val(),"qualityPeriodUnit":$(goodsval).find(".edit_quality_period_unit").val(),"miniOrderQuantity":$(goodsval).find(".edit_mini_order_quantity").val(),
						"addOrderQuantity":$(goodsval).find(".edit_add_order_quantity").val(),"packagingSize":$(goodsval).find(".edit_packaging_size").val(),"warningNumber":$(goodsval).find(".edit_warming_number").val(),"weight":$(goodsval).find(".edit_weight").val(),
						"units":[],"inventories":[]};
				//获取商品单位的信息，添加到商品基础的信息里
				$(goodsval).find(".unitDiv .unit").each(function(index, val){
					console.log("index:"+index);
					var isBaseUnitChecked=0;//是否为基础单位
					var isminiPurchasingChecked=0;//是否为最小订货量单位
					if($(val).find("[class='funda_f']").is(":checked")){
						isBaseUnitChecked=1;
					}
					if($(val).find("[class='funda_s']").is(":checked")){
						isminiPurchasingChecked=1;
					}
					console.log("isBaseUnitChecked:"+isBaseUnitChecked);
					console.log("isminiPurchasingChecked:"+isminiPurchasingChecked);
					var denominator=0;//分母
					var molecular=0;//分子
					if($(val).find(".ratio").val().indexOf("/")>0){
						var arr = $(val).find(".ratio").val().split('/'); 
						denominator=arr[1];
						molecular=arr[0];
					}else{
						denominator=1;
						molecular=$(val).find(".ratio").val();
					}
					var unitDataJSON={"basicUnit":isBaseUnitChecked,"miniPurchasing":isminiPurchasingChecked,"barCode":$(val).find(".bar_code").val(),"salesUnit":$(val).find(".sales_unit").val(),"purchasingUnit":$(val).find(".purchasing_unit").val(),
							"warehouseUnit":$(val).find(".warehouse_unit").val(),"name":$(val).find(".unit-name").val(),"ratioDenominator":denominator,"ratioMolecular":molecular};	
					
					goodsSpecificationDataJSON.units[index]=unitDataJSON;	
				});
				
				//获取库存的信息，添加到商品基础的信息里
				$(goodsval).find(".inventoryDiv .unit").each(function(index, val){	
					
					var inventoryDataJSON={"warehouseId":$(val).find(".warehouse_id").val(),"maxInventory":$(val).find(".max_inventory").val(),"miniInventory":$(val).find(".mini_inventory").val(),"inventory":$(val).find(".commodity_num").val(),"commodityNum":$(val).find(".commodity_num").val()};	
					
					goodsSpecificationDataJSON.inventories[index]=inventoryDataJSON;	
				});
				commodityDataJSON.commoditySpecifictions[index]=goodsSpecificationDataJSON;
			});
			
			
			
			console.log(commodityDataJSON);
			return commodityDataJSON;
		}
		
		let goodstypeDivid=1;
		/*新增商品规格*/
		function goodstypeAdd(){
			let goodstypestr=`<div class="row jl-panel goodsSpecificationDiv" id="goodstypeDiv`+goodstypeDivid+`">
				<input type="text" class="form-control edit_specification_id hidden"  />
					<span class="close_unit" onclick="inventoryDel(this)"><i class="fa fa-times "></i></span>
					<div class="unit-title row"><span>基本信息</span></div>
					<div class="row unit">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="edit_specifications" class="col-xs-4 control-label">规格</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_specifications" id="edit_specifications`+goodstypeDivid+`"
									onblur="decideSpecificationNameIsRepeat(this)" onkeyup="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="quality_period" class="col-xs-4 control-label">产品保质日期</label>
							<div class="col-xs-4" style="padding-right: 0;">
								<input type="text" class="edit_quality_period form-control" style=" border-right:0;height: 32px;" onkeyup="pressInteger(this)" maxlength="9"/>
							</div>
							<div class="col-xs-4 " style="padding-left: 0;">
								<select class="form-control edit_quality_period_unit">
								<option value="-1">请选择</option>
								<option value="年">年</option>
								<option value="月">月</option>
								<option value="日">日</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="warming_number" class="col-xs-4 control-label">预警数量</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_warming_number"
									onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">商品重量</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_weight" 
									onblur="cky(this)" onkeyup="pressMoney(this)" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="mini_order_quantity" class="col-xs-4 control-label">最小订货量</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_mini_order_quantity" onblur="cky(this)"
									onkeyup="pressInteger(this)" maxlength="9"/>
							</div>
						</div>
						<div class="form-group">
							<label for="add_order_quantity" class="col-xs-4 control-label">最小订货增量</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_add_order_quantity" onblur="cky(this)"
									onkeyup="pressInteger(this)" maxlength="9"/>
							</div>
						</div>
						<div class="form-group">
							<label for="packaging_size" class="col-xs-4 control-label">包装尺寸</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_packaging_size"
									onblur="cky(this)" />
							</div>
						</div>
					</div>
					</div>
					
					<div class="unitDivAll">
						<div class="unit-title row"><span>单位信息</span><button type="button" class="btncss jl-btn-defult" onclick="unitAdd(this,1)" attr-id="`+goodstypeDivid+`">新增单位信息</button></div>
						<div class="unitDiv row"></div>
						</div>
					<div>
					<div class="inventoryDivAll">
						<div class="unit-title row"><span>存货信息</span><button type="button" class="btncss jl-btn-defult" onclick="inventoryAdd(this)" attr-id="`+goodstypeDivid+`">新增存货信息</button></div>
						
						<div class="inventoryDiv">
						</div>
					<div>
				</div>`;
				
				$("#goodstypeDiv").append(goodstypestr);
				unitAddOrUpdateFirst(goodstypeDivid);
				console.log(goodstypeDivid);
				goodstypeDivid++;
		}
		
		
		/*添加商品规格第一个*/
		function goodstypeAddfirst(){
			$("#goodstypeDiv").html("");
			let goodstypestr=`
				<div class="row jl-panel goodsSpecificationDiv" id="goodstypeDiv0">
					<input type="text" class="form-control edit_specification_id hidden"  />
					<div class="unit-title row"><span>基本信息</span></div>
					<div class="row unit">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="edit_specifications" class="col-xs-4 control-label">规格</label>
								<div class="col-xs-8">
									<input type="text" class="form-control edit_specifications" id="edit_specifications0"
										onblur="decideSpecificationNameIsRepeat(this)" onkeyup="cky(this)" maxlength="100"/>
								</div>
							</div>
							<div class="form-group">
								<label for="quality_period" class="col-xs-4 control-label">产品保质日期</label>
								<div class="col-xs-4" style="padding-right:0;">
									<input type="text" class="edit_quality_period form-control" style=" border-right:0;height: 32px;" onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
								<div class="col-xs-4" style="padding-left: 0;">
									<select class="form-control edit_quality_period_unit" >
									<option value="-1">请选择</option>
									<option value="年">年</option>
									<option value="月">月</option>
									<option value="日">日</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="warming_number" class="col-xs-4 control-label">预警数量</label>
								<div class="col-xs-8">
									<input type="text" class="form-control edit_warming_number"
										onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9" />
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">商品重量</label>
								<div class="col-xs-8">
									<input type="text" class="form-control edit_weight"
										onblur="cky(this)" onkeyup="pressMoney(this)" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="mini_order_quantity" class="col-xs-4 control-label">最小订货量</label>
								<div class="col-xs-8">
									<input type="text" class="form-control edit_mini_order_quantity" onblur="cky(this)"
										onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
							</div>
							<div class="form-group">
								<label for="add_order_quantity" class="col-xs-4 control-label">最小订货增量</label>
								<div class="col-xs-8">
									<input type="text" class="form-control edit_add_order_quantity" onblur="cky(this)"
										onkeyup="pressInteger(this)" maxlength="9"/>
								</div>
							</div>
							<div class="form-group">
								<label for="packaging_size" class="col-xs-4 control-label">包装尺寸</label>
								<div class="col-xs-8">
									<input type="text" class="form-control edit_packaging_size"
										onblur="cky(this)" />
								</div>
							</div>
						</div>
					</div>
					
					<div class="unitDivAll">
						<div class="unit-title row"><span>单位信息</span><button type="button" class="btncss jl-btn-defult" onclick="unitAdd(this,1)" attr-id="0">新增单位信息</button></div>
						<div class="unitDiv row">
						</div>
					</div>
					<div class="inventoryDivAll">
						<div class="unit-title row"><span>存货信息</span><button type="button" class="btncss jl-btn-defult" onclick="inventoryAdd(this)" attr-id="0">新增存货信息</button></div>
						<div class="inventoryDiv"></div>
						</div>
					</div>
				</div>`;
				
				$("#goodstypeDiv").html(goodstypestr);
				unitAddOrUpdateFirst(0);
		}
		
		
		
		
		
	</script>
</html>