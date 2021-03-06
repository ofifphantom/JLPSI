<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta charset="utf-8" />
		<title>销售填写一般销售价格</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>

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
			
			
			#editDiv .jl-btn-importent,
			#editDiv .jl-btn-defult {
				float: right;
				margin-top: 13px;
			}
			
			.unit-title span {
				font-weight: bold;
				margin-left: 10px;
				border-left: 5px solid #e8efd4;
				clear: both;
				padding: 0px 5px;
			}
			
			.jl-panel {
				position: relative;
			}
			#searchTime{
				width:190px
			}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">销售填写一般销售价格</h4>
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

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
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
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<!-- <tr>

									<td>
										<span class="look-span" onclick="goodsDetail()">100010001</span>
									</td>
									<td>1</td>
									<td>2</td>
									<td>3</td>
									<td>4</td>
									<td>5</td>
									<td>6</td>
									<td>7</td>
									<td>8</td>
									<td>9</td>
									<td>10</td>
									<td>
										<input type="button" class="btncss edit" onclick="goodsEdit()" value="填写" />
									</td>
								</tr>
								<tr>
									<td>
										<span class="look-span" onclick="goodsDetail()">100010002</span>
									</td>
									<td>1</td>
									<td>2</td>
									<td>3</td>
									<td>4</td>
									<td>5</td>
									<td>6</td>
									<td>7</td>
									<td>8</td>
									<td>9</td>
									<td>10</td>
									<td>
										<input type="button" class="btncss edit" value="填写" disabled="disabled" />
									</td>
								</tr>
 -->
							</tbody>
						</table>
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
								<!-- 	<div class="form-group">
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
		<div id="editDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>商品基本信息</span>
				</div>
				<div class="row jl-panel">
				<input type="text" class="hidden" id="commodity_id" />
					<div class="col-xs-6">
						<div class="form-group">
							<label for="edit_commodity_name" class="col-xs-4 control-label">产品名称</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_commodity_name" disabled="disabled" />
							</div>
						</div>
						<div class="form-group">
							<label for="classification_id_one" class="col-xs-4 control-label">货品类别</label>
							<div class="col-xs-4" style="padding-right: 0;">
								<select id="classification_id_one" class="form-control" style="border-right: 0;" disabled="disabled">

								</select>
							</div>
							<div class="col-xs-4" style="padding-left: 0;">
								<select id="edit_classification_id" class="form-control" disabled="disabled">

								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="basics_information" class="col-xs-4 control-label">基本信息</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_basics_information" disabled="disabled" />
							</div>
						</div>

						<div class="form-group">
							<label for="attribute" class="col-xs-4 control-label">商品属性</label>
							<div class="col-xs-8">
								<select name="" id="edit_attribute" class="form-control" disabled="disabled">
									<option value="-1">请选择</option>
									<option value="11">常温库</option>
									<option value="00">冷库</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="shout_name" class="col-xs-4 control-label">简称</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_shout_name" disabled="disabled" />
							</div>
						</div>
						<div class="form-group">
							<label for="is_assemble" class="col-xs-4 control-label">是否是组装商品</label>
							<div class="col-xs-8">
								<select name="" id="is_assemble" class="form-control" disabled="disabled">
									<option value="-1">请选择</option>
									<option value="1">是</option>
									<option value="2">不是</option>
								</select>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="supcto" class="col-xs-4 control-label">供货商</label>
							<div class="col-xs-8">
								<input id="edit_supcto" class="form-control" name="" disabled="disabled" />
							</div>
						</div>
						<div class="form-group">
							<label for="mnemonic_code" class="col-xs-4 control-label">助记码</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_mnemonic_code" disabled="disabled" />
							</div>
						</div>
						<div class="form-group">
							<label for="brand" class="col-xs-4 control-label">品牌</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_brand" disabled="disabled" disabled="disabled" />
							</div>
						</div>

						<div class="form-group">
							<label for="zero_stock" class="col-xs-4 control-label">是否允许0库存出货</label>
							<div class="col-xs-8">
								<select id="edit_zero_stock" class="form-control" disabled="disabled">
									<option value="-1" selected="selected">--请选择--</option>
									<option value="0">不是</option>
									<option value="1">是</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">默认税率</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_taxes" disabled="disabled" />
							</div>
						</div>
						<div class="form-group">
							<label for="is_presell" class="col-xs-4 control-label">是否是预售</label>
							<div class="col-xs-8">
								<select name="" id="is_presell" class="form-control" disabled="disabled">
									<option value="-1">请选择</option>
									<option value="1">是</option>
									<option value="2">不是</option>
								</select>
							</div>
						</div>
					</div>
				</div>

				<div class="row jl-title">
					<span>商品规格</span>
				</div>
				<div id="goodstypeDiv">

				</div>

			</form>

		</div>

	</body>
	<script>
	var oTable1;
	$("#btn_search").click(function() {
		$("#checkAll").removeAttr("checked");
		oTable1.fnDraw();
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
							"messageOrDelivery":4,
							"classificationId": $("#searchClassificationTwoId").val(),
							"name": $("#searchName").val(),
							"operatorName": $("#searchOperatorName").val(),
							"supctoId": $("#searchSupctoId").val(),
							"searchTime":$("#searchTime").val()				
						});
					},
					"url": "<%=basePath%>basic/goods/commodity/getCommodityMsg"
				},

				"aoColumns": [{
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
									switch (row.tempState) {
									case 10:
										return "采购修改审核中";
										break;
									case 11:
										return "采购修改审核驳回";
										break;
									case 12:
										return "销售修改审核中";
										break;
									case 13:
										return "销售修改审核驳回";
										break;
									case 14:
										return "采购修改总经理审核中";
										break;

									default:
										return "销售审核通过";
										break;
									}
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
					},

					{
						"mData": "id",
						"bSortable": false,
						"sWidth": "15%",
						"sClass": "center",
						"mRender": function(data, type, row) {
							if(row.state == 5 || row.state == 7){
								return '<td><input type="button" class="btncss edit" onclick="goodsEdit('+data+')" value="填写" /></td>'				
							}else if(row.state == 3){
								if(row.tempState == 10 || row.tempState == 12|| row.tempState == 14){
									return '<td><input type="button" class="btncss edit" value="审核中" disabled="disabled" /></td>'
								}else{
									return '<td><input type="button" class="btncss edit" onclick="goodsEdit2('+data+')" value="修改" /></td>'	
								}
											
							}
										
						}
					}
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
		/* 给页面里的一级分类下拉框赋值 */
		getDataToOneClassification(1);
		//给添加时需要选择的供货商下拉框赋值
		getSupctoMsgByCustomerOrSupplier();
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
	
	//给添加时需要选择的仓库下拉框赋值
	function getAllWarehouseMsg(inventory_index_num){
		$.ajax({
			url: '<%=basePath%>basic/warehouse/selectAllWarehouse',
			type: "POST",
			dataType: "json",
			async: false,
			cache: false,
			success: function(data) {
				$("#warehouse_id"+inventory_index_num+"").html("");
				if(data.length==0){
					$("#warehouse_id"+inventory_index_num+"").append("<option value='-1' selected>--暂无数据，请到仓库页面进行添加--</option>");	
					$("#warehouse_id"+inventory_index_num+"").html("");
				}
				else{
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
	
	/*填写*/
	function goodsEdit(id) {
		/*
		 * 请在此处为表单赋值
		 */
		ajaxJquery("GET","<%=basePath%>basic/goods/commodity/selectCommoditySpecificationMsgById",{"id":id},function(data){
			getDataToOneClassification(2);
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
			if(data.commodity.supcto!=null){
				$("#edit_supcto").val(data.commodity.supcto.name);
			}
			else{
				$("#edit_supcto").val("");
			}
			
			$("#edit_zero_stock").val(data.commodity.zeroStock);	
			$("#edit_taxes").val(data.commodity.taxes);
			$("#is_assemble").val(data.commodity.isAssemble);
			$("#is_presell").val(data.commodity.isPresell);
			
			addGoodstype(data);//添加商品规格方法
		})
		layer.open({
			type: 1,
			title: "填写一般销售价格 ",
			closeBtn: 1,
			area: ['100%', '100%'],
			content: $("#editDiv "),
			btn: ['提交并送审', '取消'],
			yes: function(index) {
				if(!decideInputHasValue())return;
				var inputflag=true;
				$("#goodstypeDiv .goodsSpecificationDiv").each(function(index, goodsval){
					var goodsSpecificationDataJSON={"id":$(goodsval).find(".edit_specification_id").val(),"commodityId":$("#commodity_id").val(),"specificationIdentifier":$(goodsval).find(".edit_specification_identifier").val(),
													"units":[]};
					//获取商品单位的信息，添加到商品基础的信息里
					$(goodsval).find(".unitDiv .unit").each(function(index, val){
						if(index==1)return;
						var $parents=$(val).parents(".unit");
						var commonly_price=$(val).find(".commonly_price").val();
						var mini_price=$(val).find(".mini_price").val();
						if(commonly_price-0>0){
								if((commonly_price-0)<(mini_price-0)){
									inputflag=false;					
								}
						}else{
							inputflag=false;
							
						}
					});
				});
				if(!inputflag){
					laywarn("一般销售价格不能为0并且应大于最低销售价格，请重新填写。");
					return ;
				}
				
				ajaxJquery("POST","<%=basePath%>basic/goods/commodity/editCommodityPrice",{"commodityData":JSON.stringify(commodityDataToJSON())},function(data){
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").removeAttr("checked");
					} else {
						layfail(data.msg);
					}
					layer.close(index);
				}) 
			},
			end: function(index, layero) {
				layer.close(index);
				clearForm("editDiv ", " ");
				$("#goodstypeDiv").html("")
			}
		});
	}

	
	/*填写*/
	function goodsEdit2(id) {
		/*
		 * 请在此处为表单赋值
		 */
		ajaxJquery("GET","<%=basePath%>basic/goods/commodity/selectCommoditySpecificationMsgById",{"id":id},function(data){
			getDataToOneClassification(2);
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
			if(data.commodity.supcto!=null){
				$("#edit_supcto").val(data.commodity.supcto.name);
			}
			else{
				$("#edit_supcto").val("");
			}
			
			$("#edit_zero_stock").val(data.commodity.zeroStock);	
			$("#edit_taxes").val(data.commodity.taxes);
			$("#is_assemble").val(data.commodity.isAssemble);
			$("#is_presell").val(data.commodity.isPresell);
			
			addGoodstype(data);//添加商品规格方法
		})
		layer.open({
			type: 1,
			title: "修改一般销售价格 ",
			closeBtn: 1,
			area: ['100%', '100%'],
			content: $("#editDiv "),
			btn: ['提交并送审', '取消'],
			yes: function(index) {
				if(!decideInputHasValue())return;
				var inputflag=true;
				$("#goodstypeDiv .goodsSpecificationDiv").each(function(index, goodsval){
					var goodsSpecificationDataJSON={"id":$(goodsval).find(".edit_specification_id").val(),"commodityId":$("#commodity_id").val(),"specificationIdentifier":$(goodsval).find(".edit_specification_identifier").val(),
													"units":[]};
					//获取商品单位的信息，添加到商品基础的信息里
					$(goodsval).find(".unitDiv .unit").each(function(index, val){
						if(index==1)return;
						var $parents=$(val).parents(".unit");
						var commonly_price=$(val).find(".commonly_price").val();
						var mini_price=$(val).find(".mini_price").val();
						if(commonly_price-0>0){
								if((commonly_price-0)<(mini_price-0)){
									inputflag=false;					
								}
						}else{
							inputflag=false;
							
						}
					});
				});
				if(!inputflag){
					laywarn("一般销售价格不能为0并且应大于最低销售价格，请重新填写。");
					return ;
				}
				
				ajaxJquery("POST","<%=basePath%>basic/goods/commodity/editCommodityPrice2",{"commodityData":JSON.stringify(commodityDataToJSON())},function(data){
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").removeAttr("checked");
					} else {
						layfail(data.msg);
					}
					layer.close(index);
				}) 
			},
			end: function(index, layero) {
				layer.close(index);
				clearForm("editDiv ", " ");
				$("#goodstypeDiv").html("")
			}
		});
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
						switch (data.tempState) {
						case 10:
							$("#look_state").html("采购修改审核中");
							break;
						case 11:
							$("#look_state").html("采购修改审核驳回");
							break;
						case 12:
							$("#look_state").html("销售修改审核中");
							break;
						case 13:
							$("#look_state").html("销售修改审核驳回");
							break;
						default:
							$("#look_state").html("销售审核通过");
							break;
						}
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
					 
					//修改审批中的详情展示处理
					 if(data.tempState == 12){
						 $("#look_base_unit_commonly_price").html(data.units[0].tempCommonlyPrice);
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

		
		/*添加商品规格
		 * 参数：规格data
		 */
		function addGoodstype(data){
			/*
			 * 请在此处为商品添加规格,并未规格赋值
			 */
			$("#goodstypeDiv").append(getGoodstypeDiv(0));
			$(".edit_specification_id").val(data.id);
			$(".edit_specifications").val(data.specificationName);
			$(".edit_quality_period").val(data.qualityPeriod);
			$(".edit_quality_period_unit").val(data.qualityPeriodUnit);
			$(".edit_warming_number").val(data.warningNumber);
			$(".edit_weight").val(data.weight);
			$(".edit_mini_order_quantity").val(data.miniOrderQuantity);
			$(".edit_add_order_quantity").val(data.addOrderQuantity);
			$(".edit_packaging_size").val(data.packagingSize);
			$(".edit_specification_identifier").val(data.specificationIdentifier);
			for(var i=0;i<data.units.length;i++){
				$("#goodstypeDiv0 .unitDiv").append(getUnit(0, i));
				$("#unit"+i).find(".unit-name").attr("disabled", "true");
				$("#unit"+(i)+" .bar_code").attr("disabled", "true");
				
				if(i==0){
					$("#unit"+(i)).find(".unit_id").val(data.units[i].id);
					$("#unit"+(i)).find(".unit-name").val(data.units[i].name);
					if(data.units[i].ratioDenominator==1){
						$("#unit"+(i)).find(".ratio").val(data.units[i].ratioMolecular);
					}
					else{
						$("#unit"+(i)).find(".ratio").val(data.units[i].ratioMolecular+"/"+data.units[i].ratioDenominator);
					}	
					$("#unit"+(i)).find(".commonly_price").val(data.units[i].commonlyPrice);
					$("#unit"+(i)+" .mini_price").val(data.units[i].miniPrice);
					$("#unit"+(i)+" .bar_code").val(data.units[i].barCode);
					$("#unit"+(i)+" .sales_unit").val(data.units[i].salesUnit);
					$("#unit"+(i)+" .purchasing_unit").val(data.units[i].purchasingUnit);
					$("#unit"+(i)+" .warehouse_unit").val(data.units[i].warehouseUnit);
				}else{
					$("#unit"+(i)).find(".unit_id").val(data.units[i].id);
					$("#unit"+(i)).find(".unit-name").val(data.units[i].name);
					if(data.units[i].ratioDenominator==1){
						$("#unit"+(i)).find(".ratio").val(data.units[i].ratioMolecular);
					}
					else{
						$("#unit"+(i)).find(".ratio").val(data.units[i].ratioMolecular+"/"+data.units[i].ratioDenominator);
					}
					$("#unit"+(i)+" .bar_code").val(data.units[i].barCode);
				}
				
				if(data.units[i].basicUnit==1){
					$("#unit"+(i)+" .base-unit").val("是");
				}
				else{
					$("#unit"+(i)+" .base-unit").val("否");	
				}
				if(data.units[i].miniPurchasing==1){
					$("#unit"+(i)+" .mini-purchasing-unit").val("是");
				}
				else{
					$("#unit"+(i)+" .mini-purchasing-unit").val("否");
				}
			}
			
			if(data.inventories.length==1){
				
				$("#goodstypeDiv0 .inventoryDiv").append(inventoryAdd(0, 1));
				//给添加时需要选择的仓库下拉框赋值
				getAllWarehouseMsg(1);
				
				$("#inventory1 .inventory_id").val(data.inventories[0].id);
				$("#inventory1 .warehouse_id").val(data.inventories[0].warehouseId);
				$("#inventory1 .mini_inventory").val(data.inventories[0].miniInventory);
				$("#inventory1 .max_inventory").val(data.inventories[0].maxInventory);
				$("#inventory1 .commodity_num").val(data.inventories[0].commodityNum);
				
				$("#inventory1 .commodity_num").attr("disabled", "true");
				
				$("#inventory1").parents(".inventoryDivAll").find("button").addClass("hidden");
			}
			else{
				$("#goodstypeDiv0 .inventoryDiv").append("<div style='margin-left:20px'>暂无信息</div>");
			}
			
			
			
		}
		

		/*返回规格Div
		 * 参数：规格Div的标识id
		 */
		function getGoodstypeDiv(goodstypeDivid) {
			var goodstypestr = `<div class="row jl-panel goodsSpecificationDiv" id="goodstypeDiv` + goodstypeDivid + `">
				<input type="text" class="form-control edit_specification_id hidden"  />
				<input type="text" class="form-control edit_specification_identifier hidden"  />
					<div class="unit-title row"><span>基本信息</span></div>
					<div class="row unit">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="edit_specifications" class="col-xs-4 control-label">规格</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_specifications" id="edit_specifications` + goodstypeDivid + `" disabled="disabled"/>
							</div>
						</div>
						<div class="form-group">
							<label for="quality_period" class="col-xs-4 control-label">产品保质日期</label>
							<div class="col-xs-4" style="padding-right: 0;">
								<input type="text" class="edit_quality_period form-control" style=" border-right:0;height: 32px;" disabled="disabled"/>
							</div>
							<div class="col-xs-4 " style="padding-left: 0;">
								<select class="form-control edit_quality_period_unit" disabled="disabled">
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
								<input type="text" class="form-control edit_warming_number" disabled="disabled"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">商品重量</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_weight" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="mini_order_quantity" class="col-xs-4 control-label">最小订货量</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_mini_order_quantity" disabled="disabled"/>
							</div>
						</div>
						<div class="form-group">
							<label for="add_order_quantity" class="col-xs-4 control-label">最小订货增量</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_add_order_quantity" disabled="disabled"/>
							</div>
						</div>
						<div class="form-group">
							<label for="packaging_size" class="col-xs-4 control-label">包装尺寸</label>
							<div class="col-xs-8">
								<input type="text" class="form-control edit_packaging_size" disabled="disabled"/>
							</div>
						</div>
					</div>
					</div>
					
					<div class="unitDivAll">
						<div class="unit-title row"><span>单位信息</span></div>
						<div class="unitDiv row">
						</div>
						</div>
					<div>
					<div class="inventoryDivAll">
						<div class="unit-title row"><span>存货信息</span></div>
						
						<div class="inventoryDiv">
						</div>
					<div>
				</div>`;
				return goodstypestr;

		}

		/*返回单位Div
		 * 参数：规格Div的标识id，单位Div的标识num
		 */
		function getUnit(thispanelid, unit_index_num) {
			if(unit_index_num==1){
				return `<div class="unit clearfix" id="unit` + unit_index_num + `" attr-id="` + thispanelid + `">
				<div class="col-xs-6 ">
				<input type="text" class="form-control unit_id hidden"/>
				
				<div class="form-group">
					<label class="col-xs-4 control-label">单位名称</label>
					<div class="col-xs-8">
						<input type="text" class="form-control unit-name" id="name` + unit_index_num + `" disabled="disabled"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-4 control-label ">单位比率</label>
					<div class="col-xs-8">
						<input type="text" class="form-control ratio " id="ratio" disabled="disabled" />
					</div>
				</div>
				<div class="form-group hidden">
					<label  class="col-xs-4 control-label ">一般销售价格</label>
					<div class="col-xs-8">
						<input type="text" class="form-control commonly_price" id="commonly_price"  onkeyup="pressMoney(this)" value="1" />
					</div>
				</div>
				<div class="form-group hidden">
					<label class="col-xs-4 control-label ">最低销售价格</label>
					<div class="col-xs-8">
						<input type="text" class="form-control mini_price" id="mini_price " value="10" disabled="disabled" />
					</div>
				</div>
			</div>
			<div class="col-xs-6 ">
				<div class="form-group hidden">
					<label class="col-xs-4 control-label">最小订货批量单位</label>
					<div class="col-xs-8">
						<input type="text" class="form-control unit-name"  value="否" disabled="disabled" value="1"/>
					</div>
					
				</div>
				<div class="form-group">
					<label class="col-xs-4 control-label">条形码</label>
					<div class="col-xs-8">
						<input type="text" class="form-control bar_code" id="bar_code " disabled="disabled"/>
					</div>
				</div>
				<div class="form-group hidden">
					<label class="col-xs-4 control-label">销售单位</label>
					<div class="col-xs-8">
						<input type="text" class="form-control sales_unit" id="sales_unit " disabled="disabled" value="1"/>
					</div>
				</div>
				<div class="form-group hidden">
					<label class="col-xs-4 control-label">采购单位</label>
					<div class="col-xs-8">
						<input type="text" class="form-control purchasing_unit" id="purchasing_unit " disabled="disabled" value="1"/>
					</div>
				</div>
				<div class="form-group hidden">
					<label class="col-xs-4 control-label">仓库单位</label>
					<div class="col-xs-8">
						<input type="text" class="form-control warehouse_unit" id="warehouse_unit " disabled="disabled" value="1"/>
					</div>
				</div>
			</div>
		</div>`;}
			var str = `<div class="unit clearfix" id="unit` + unit_index_num + `" attr-id="` + thispanelid + `">
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<div class="col-xs-4 text-right">
											<input type="radio" id="funda_f1" class="funda_f" name="funda_f`+unit_index_num+`" checked=""
												onclick="unitRadiocheck(this)" />
										</div>
										<div class="col-xs-8 text-left">该单位信息为基本单位</div>
									</div>
								</div>
							</div>
							<div class="col-xs-6 ">
								<input type="text" class="form-control unit_id hidden"/>
								
								<div class="form-group">
									<label class="col-xs-4 control-label">单位名称</label>
									<div class="col-xs-8">
										<input type="text" class="form-control unit-name" id="name` + unit_index_num + `" disabled="disabled"/>
									</div>
								</div>
								<div class="form-group hidden">
									<label class="col-xs-4 control-label ">单位比率</label>
									<div class="col-xs-8">
										<input type="text" class="form-control ratio " id="ratio" disabled="disabled"/>
									</div>
								</div>
								<div class="form-group">
									<label  class="col-xs-4 control-label ">一般销售价格</label>
									<div class="col-xs-8">
										<input type="text" class="form-control commonly_price" id="commonly_price"  onkeyup="pressMoney(this)" />
									</div>
								</div>
								
							</div>
							<div class="col-xs-6 ">
								<div class="form-group hidden">
									<label class="col-xs-4 control-label">最小订货批量单位</label>
									<div class="col-xs-8">
										<input type="text" class="form-control unit-name"  value="否" disabled="disabled"/>
									</div>
									
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label">条形码</label>
									<div class="col-xs-8">
										<input type="text" class="form-control bar_code" id="bar_code " disabled="disabled"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 control-label ">最低销售价格</label>
									<div class="col-xs-8">
										<input type="text" class="form-control mini_price" id="mini_price " value="10" disabled="disabled"/>
									</div>
								</div>
								<div class="form-group hidden">
									<label class="col-xs-4 control-label">销售单位</label>
									<div class="col-xs-8">
										<input type="text" class="form-control sales_unit" id="sales_unit " disabled="disabled"/>
									</div>
								</div>
								<div class="form-group hidden">
									<label class="col-xs-4 control-label">采购单位</label>
									<div class="col-xs-8">
										<input type="text" class="form-control purchasing_unit" id="purchasing_unit " disabled="disabled"/>
									</div>
								</div>
								<div class="form-group hidden">
									<label class="col-xs-4 control-label">仓库单位</label>
									<div class="col-xs-8">
										<input type="text" class="form-control warehouse_unit" id="warehouse_unit " disabled="disabled"/>
									</div>
								</div>
							</div>
						</div>`;
			return str;

		}

		/*返回仓库Div
		 * 参数：规格Div的标识id，仓库Div的标识num
		 */
		function inventoryAdd(panelid, inventory_index_num) {
			var inventorystr = `
					<div class="unit clearfix " id="inventory` + inventory_index_num + `" attr-id="` + panelid + `">
						<div class="col-xs-6 ">
							<input type="text" class="form-control inventory_id hidden"/>
							<div class="form-group">
								<label for="warehouse_id` + inventory_index_num + `" class="col-xs-4 control-label">仓库名称</label>
								<div class="col-xs-8">
									<select id="warehouse_id` + inventory_index_num + `" class="form-control warehouse_id"  disabled="disabled">
									
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="mini_inventory " class="col-xs-4 control-label">库存下限</label>
								<div class="col-xs-8">
									<input type="text" class="form-control mini_inventory" id="mini_inventory " disabled="disabled"/>
								</div>
							</div>
						</div>
						<div class="col-xs-6 ">
							<div class="form-group">
								<label for="max_inventory " class="col-xs-4 control-label">库存上限</label>
								<div class="col-xs-8">
									<input type="text" class="form-control max_inventory" id="max_inventory " disabled="disabled"/>
								</div>
							</div>
							<div class="form-group">
								<label for=" " class="col-xs-4 control-label">商品数量</label>
								<div class="col-xs-8">
									<input type="text" class="form-control commodity_num" id="commodity_num" disabled="disabled"/>
								</div>
							</div>
						</div>

					</div>`;
					return inventorystr;
		}
		function unitPriceBlur(e){
			var $parents=$(e).parents(".unit");
			var commonly_price=$parents.find(".commonly_price").val();
			var mini_price=$parents.find(".mini_price").val();
			
			if(commonly_price-0>0){
					if((commonly_price-0)<(mini_price-0)){
						laywarn("一般销售价格应大于最低销售价格，请重新填写。");	
						return;
					}
			}else{
				laywarn("一般销售价格不能为0，请重新填写。");
				return;
			}
		}
		
		/* 新增或者编辑时判断数据有没有填写完整 */
		function decideInputHasValue(){
			var inputValue=true;
			$("#goodstypeDiv .goodsSpecificationDiv").each(function(index, goodsval){
				var goodsSpecificationDataJSON={"id":$(goodsval).find(".edit_specification_id").val(),"commodityId":$("#commodity_id").val(),"specificationIdentifier":$(goodsval).find(".edit_specification_identifier").val(),
												"units":[]};
				//获取商品单位的信息，添加到商品基础的信息里
				$(goodsval).find(".unitDiv .unit").each(function(index, val){	
					if($(val).find(".commonly_price").val()==null||$(val).find(".commonly_price").val()==""){
						inputValue=false;
					}
				});
			});
			console.log("inputValue",inputValue);
			if(!inputValue){
				layfail("一般销售价格不能为空");
				return false;
			}
			else{
				return true;
			}
			
		}
		
		/* 提交或者编辑时 把数据整合成json传入后台 */
		function commodityDataToJSON(){
			
			//商品基础的信息
			var commodityDataJSON={"id":$("#commodity_id").val(),"commoditySpecifictions":[]};
			//商品规格的信息
			$("#goodstypeDiv .goodsSpecificationDiv").each(function(index, goodsval){
				var goodsSpecificationDataJSON={"id":$(goodsval).find(".edit_specification_id").val(),"commodityId":$("#commodity_id").val(),"specificationIdentifier":$(goodsval).find(".edit_specification_identifier").val(),
												"units":[]};
				//获取商品单位的信息，添加到商品基础的信息里
				$(goodsval).find(".unitDiv .unit").each(function(index, val){	
					var unitDataJSON={"id":$(val).find(".unit_id").val(),"commonlyPrice":$(val).find(".commonly_price").val()};	
					
					goodsSpecificationDataJSON.units[index]=unitDataJSON;	
				});
				
				commodityDataJSON.commoditySpecifictions[index]=goodsSpecificationDataJSON;
			});
			
			
			
			console.log(commodityDataJSON);
			return commodityDataJSON;
		}
		
	</script>
</html>