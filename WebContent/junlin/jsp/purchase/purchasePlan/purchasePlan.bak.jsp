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
		<title>采购计划单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		
		
		<link href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
	    <script src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
		<style>
			#editDiv {
				padding-top: 20px;
			}
			#goodsAddBtn {
				float: right;
				margin-top: 13px;
			}
			#edit_goodDiv .jl-panel {
				position: relative;
			}
			
			
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">采购计划单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							单号： <input type="text" value="" id="query_identifier"/>
						</span>
							<span class="l_f"> 
							供应商名称： <input type="text" value="" id="query_supctoId"/>
						</span>
							<span class="l_f"> 
							货品名称： <input type="text"  value="" id="query_goodsName"/>
						</span>
							<span class="r_f"> 
							<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="purchasePlanRefresh()" style="margin-right: 0;"><i class="fa fa-refresh"></i>刷新</button>
						</span>
						<span class="r_f">
							<button type="button" class="btncss jl-btn-defult" onclick="purchaseOrderAdd()" style="margin-right: 0;">
								<i class="fa fa-plus"></i>新增
							</button>
						</span>
						<span class="jl_f_l">
							<input type="checkbox" name="id" id="checkAll" style="margin:0 5px 0 0;" onclick="checkboxController(this)"/>
						</span>
						<span class="jl_f_l">
							<label for="checkAll">全选</label>
						</span>

					</div>
					<div class="table_menu_list">
						<form id="datatable_form">
							<table class="table table-striped table-hover col-xs-12" id="datatable">
								<thead class="table-header">
									<tr>
										<th>选择</th>
										<th>单号</th>
										<th>供应商</th>
										<th>货品名称</th>
										<th>业务单价</th>
										<th>业务数量</th>
										<th>金额</th>
										<th>日期</th>
										<th>状态</th>
										<th>app订单</th>
										<th width="20%">操作</th>
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

		<!--详情 -->
		<div id="lookDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">日期：</label>
							<div class="col-xs-8" id="look_generateDate">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">供应商：</label>
							<div class="col-xs-8" id="look_supcto_name">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">有效期至：</label>
							<div class="col-xs-8" id="look_effectivePeriodEnd">
								123456
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">到货时间：</label>
							<div class="col-xs-8" id="look_goodsArrivalTime">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">到货地址：</label>
							<div class="col-xs-8" id="look_goodsArrivalPlace">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">订货人：</label>
							<div class="col-xs-8" id="look_orderer">
								123456
							</div>
						</div>
					<div class="form-group" id="look_prepaidAmount_div">
						<label for="" class="col-xs-4 control-label">预付金额：</label>
						<div class="col-xs-8" id="look_prepaidAmount">123456</div>
					</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">单号：</label>
							<div class="col-xs-8" id="look_identifier">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">运输方式：</label>
							<div class="col-xs-8" id="look_transportationMode">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">送货人：</label>
							<div class="col-xs-8" id="look_deliveryman">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">传真：</label>
							<div class="col-xs-8" id="look_fax">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">联系电话：</label>
							<div class="col-xs-8" id="look_phone">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">付款方式：</label>
							<div class="col-xs-8" id="look_payType">
								123456
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务数量：</label>
							<div class="col-xs-8" id="look_total_orderNum">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">税额：</label>
							<div class="col-xs-8" id="look_total_amountOfTax">
								123456
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">货款：</label>
							<div class="col-xs-8" id="look_total_paymentForGoods">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">金额：</label>
							<div class="col-xs-8" id="look_total_totalPrice">
								123456
							</div>
						</div>
					</div>
				</div>
				
				<div class="row jl-title">
					<span>商品</span>
				</div>
				<div id="look_goodDiv">
				
				
				</div>
				
				
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">部门：</label>
							<div class="col-xs-8" id="look_departmentId">
								123456
							</div>
						</div>
						<!--<div class="form-group">
							<label for="" class="col-xs-4 control-label">审核人：</label>
							<div class="col-xs-8" id="look_reviewer">
								123456
							</div>
						</div>-->
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">摘要：</label>
							<div class="col-xs-8" id="look_summary">
								123456
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">制单人：</label>
							<div class="col-xs-8" id="look_originator">
								123456
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">分支机构：</label>
							<div class="col-xs-8" id="look_branch">
								总部
								
							</div>
						</div>
					</div>
				</div>

			</form>
		</div>
		
		<!--编辑 -->
		<div id="editDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<input type="text" class="form-control hidden" id="edit_procure_table_id" />
						 <div class="form-group hidden">
							<label for="" class="col-xs-4 control-label">日期</label>
							<div class="col-xs-8">
								<input type="text" class="form-control hidden" id="edit_generateDate" disabled="disabled"/>
							</div>
						</div> 
						<div class="form-group" id="edit_supctoIdDiv">
							<label for="" class="col-xs-4 control-label">供应商</label>
							<div class="col-xs-8">

								<select id="edit_supcto_id" class="form-control">

								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="" class="col-xs-4 control-label">有效期至</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_effectivePeriodEnd" readonly="readonly" placeholder="请选择有效期" />
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">到货时间</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_goodsArrivalTime" readonly="readonly" placeholder="请选择到货时间"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">到货地址</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_goodsArrivalPlace" onkeyup="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">订货人</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_orderer" onkeyup="cky(this)" maxlength="100"/>
							</div>
						</div>
						
						<div class="form-group hidden" id="edit_prepaidAmount_div">
							<label for="" class="col-xs-4 control-label">预付金额</label>
							<div class="col-xs-8">
								<input type="text" class="form-control hidden" id="edit_prepaidAmount" onkeyup="pressMoney(this)" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group hidden">
							<label for="" class="col-xs-4 control-label">单号</label>
							<div class="col-xs-8">
								<input type="text" class="form-control hidden" id="edit_identifier" disabled="disabled" />
							</div>
						</div> 
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">运输方式</label>
							<div class="col-xs-8">
								<select id="edit_transportationMode" class="form-control">
								</select>
							</div>
						</div>
						 
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">送货人</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_deliveryman" onkeyup="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">传真</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_fax" onkeyup="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">联系电话</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_phone" onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="11"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">付款方式</label>
							<div class="col-xs-8">
								<select class="form-control" id="edit_payType">
								</select>
							</div>
						</div>
						
						
					</div>
				</div>
						   <div class="row jl-title">
				<span>合计</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">业务数量：</label>
						<div class="col-xs-8" id="add_total_orderNum">0</div>
					</div>
				
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">税额：</label>
						<div class="col-xs-8" id="add_total_amountOfTax">0</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">货款：</label>
						<div class="col-xs-8" id="add_total_paymentForGoods">0</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">金额：</label>
						<div class="col-xs-8" id="add_total_totalTaxPrice">0</div>
					</div>

				</div>
			</div>
				<div class="row jl-title">
				<span>商品</span>
				<button type="button" class="btncss jl-btn-importent"
					id="goodsAddBtn" onclick="goodsAdd(1,1)">新增</button>
				</div>
				<div id="edit_goodDiv"></div>
				<!-- <div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务数量</label>
							<div class="col-xs-8">
								<input type="text" id="edit_total_orderNum" value="" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">税额</label>
							<div class="col-xs-8">
								<input type="text" id="edit_total_amountOfTax" value="" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">货款</label>
							<div class="col-xs-8">
								<input type="text" id="edit_total_paymentForGoods" value="" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">金额</label>
							<div class="col-xs-8">
								<input type="text" id="edit_total_totalPrice" value="" class="form-control"/>
							</div>
						</div>
					</div>
				</div> -->
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6 ">
					   <!-- <div class="form-group hidden">
							<label for="" class="col-xs-4 control-label">部门</label>
							<div class="col-xs-8">
								<input id="edit_departmentId" class="form-control hidden"/>
							</div>
						</div>
						<div class="form-group hidden">
							<label for="" class="col-xs-4 control-label">审核人</label>
							<div class="col-xs-8">
								<input type="text" id="edit_reviewer_identifier" value="" class="form-control hidden"/>
							</div>
						</div>-->
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">摘要</label>
							<div class="col-xs-8">
								<input type="text" id="edit_summary" value="" class="form-control" onkeyup="cky(this)" maxlength="100"/>
							</div>
						</div>
					</div>
					 <div class="col-xs-6">
						<!--<div class="form-group hidden">
							<label for="" class="col-xs-4 control-label">制单人</label>
							<div class="col-xs-8">
								<input type="text" id="edit_originator_identifier" value="" class="form-control hidden"/>
							</div>
						</div>
						<div class="form-group hidden">
							<label for="" class="col-xs-4 control-label">分支机构</label>
							<div class="col-xs-8">
								<input type="text" id="edit_branch" class="form-control hidden"   value="总部" />
							</div>
						</div>-->
					</div> 
				</div>
				
				<div class="text-danger">注：该页面所有字段均为必填</div>

			</form>

		</div>

	</body>

	<script>
	var oTable1;
	$("#btn_search").click(function() {
		$("#checkAll").removeAttr("checked");
		oTable1.fnDraw();
	});
	$("#edit_payType").on('change',function(){
		if($(this).val()==1){
			$("#edit_prepaidAmount_div").removeClass("hidden");
			$("#edit_prepaidAmount").removeClass("hidden");
			
		}else{
			$("#edit_prepaidAmount_div").addClass("hidden");
			$("#edit_prepaidAmount").addClass("hidden");
		}
	})
	
	jQuery(function($) {
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
							"page":1,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": $("#query_supctoId").val(),
							"planOrOrder":1
								
						});
					},
					"url": "<%=basePath%>purchase/procuretable/getProcureTableMsg"
							},

							"aoColumns" : [
									{
										"mData" : "id",
										"bSortable" : true,
										"sWidth" : "5%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return '<td><input type="checkbox" name="id" value="'
													+ row.id
													+ '" onclick="checkboxClick(\'#checkAll\')"/></td>';
										}
									},
									{
										"mData" : "identifier",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return '<td><span class="look-span" onclick="purchasePlanDetail('
													+ row.id
													+ ')">'
													+ data
													+ '</span></td>';
										}
									},
									{
										"mData" : "supctoId",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											if (row.supcto != null) {
												return row.supcto.name;
											} else {
												return "";
											}
										}

									},
									{
										"mData" : "commoditysName",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"
									},
									{
										"mData" : "businessUnitPrices",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"

									},
									{
										"mData" : "orderNums",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"

									},
									{
										"mData" : "totalTaxPrices",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
											"mRender": function(data) {
  												if(data!="null"){
													return data;
												}else{
													return 0;
												}
 											}
									},
									{
										"mData" : "generateDate",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender": function(data) {
											return getSmpFormatDateByLong(data, true);
										}
									},
									{
										"mData" : "state",
										"bSortable" : false,
										"sWidth" : "8%",
										"sClass" : "center",
										"mRender": function(data, type, row) {
											if(row.planOrOrder==2){
												return "已生成订单";
											}
											else{
												return "未生成订单";
											}
											
										}

									},
									{
										"mData" : "isAppOrder",
										"bSortable" : false,
										"sWidth" : "8%",
 										"sClass" : "center",
										"mRender": function(data, type, row) {
											if(row.isAppOrder==2){
												return "是";
											}
											else{
												return "否";
											}
											
										}

									},
									{
										"mData" : "id",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											if(row.planOrOrder==2){
												return '<td><input type="button" class="btncss edit purchasePlanDetailBtn" onclick="purchasePlanDetail('+data+')" value="详情" /></td>'
											}
											else{
												return '<td><input type="button" class="btncss edit toPurchaseOrderBtn" onclick=\'purchasePlanEdit(' + JSON.stringify(row) + ')\' value="生成采购订单" /></td>'
											}
											
					/* 			/* 			/*事件委托 begin*/
											//详情采购计划单
											$("#datatable").delegate(".purchasePlanDetailBtn", "click", function() {
												that.purchasePlanDetailEvent($(this).attr("attr-tid"));
											})
											//生成采购订单
											$("#datatable").delegate(".toPurchaseOrderBtn", "click", function() {
												that.toPurchaseOrderEvent($(this).attr("attr-tid"));
											}) */ */
										}
									} ],
							"oLanguage" : {
								// 国际化配置
								"sLengthMenu" : "每页显示 _MENU_ 条记录",
								"sZeroRecords" : "没有数据记录",
								"sInfo" : "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
								"sInfoEmpty" : "",
								"sInfoFiltered" : "(全部记录数 _MAX_ 条)",
								"oPaginate" : {
									"sFirst" : "首页",
									"sPrevious" : "前一页",
									"sNext" : "后一页",
									"sLast" : "尾页"
								}
							}
						});
		
		/* 获取所有结算方式*/
		getAllSettlementType();
		/* 获取所有运输方式*/
		getAllShippingMode();
		//给添加时需要选择的供货商下拉框赋值
		getSupctoMsgByCustomerOrSupplier();
	});
	
	
		latdate("#edit_effectivePeriodEnd");
		latdate("#edit_goodsArrivalTime");
		
		/*刷新页面，查看系统是否有新的计划单生成，如果有，就刷新datetable*/
		function purchasePlanRefresh() {
			let index = layer.load(1, {
			  shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			
			
			setTimeout(function(){
				layer.close(index);
				$("#checkAll").removeAttr("checked");
				oTable1.fnDraw();
			},1000)
			
		}
		
		/* 获取所有结算方式*/
		function getAllSettlementType(){
			$.ajax({
				url: '<%=basePath%>basic/settlementType/getAllSettlementType',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				success: function(data) {
					if(data.length==0){
						$("#edit_payType").append("<option value='-1' selected>--暂无数据，请到结算方式页面进行添加。--</option>");					
					}
					else{
						$("#edit_payType").append("<option value='-1' selected>--请选择--</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"'>"
									+ data[i].name + "</option>");
							$("#edit_payType").append(option);
						}
					}
				}
			});
		}
		
		/* 获取所有运输方式*/
		function getAllShippingMode(){
			$.ajax({
				url: '<%=basePath%>basic/shippingMode/getAllShippingMode',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				success: function(data) {
					if(data.length==0){
						$("#edit_transportationMode").append("<option value='-1' selected>--暂无数据，请到运输方式页面进行添加。--</option>");					
					}
					else{
						$("#edit_transportationMode").append("<option value='-1' selected>--请选择--</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"'>"
									+ data[i].name + "</option>");
							$("#edit_transportationMode").append(option);
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
					$("#edit_supcto_id").html("");
					if(data.length==0){
						$("#edit_supcto_id").append("<option value='-1' selected>--暂无数据，请到供应商页面进行添加--</option>");	
					}
					else{
						$("#edit_supcto_id").append("<option value='-1' selected>--请选择--</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"'>"
									+ data[i].name + "</option>");
							$("#edit_supcto_id").append(option);
						}
					}
				}
			});
			$('#edit_supcto_id').searchableSelect();
		}
		
		var commodityMsgList=[];//保存查出来的商品
		var selectedCommodity={};//记录哪一个select选择了哪一个商品规格
		var commodityIsSelected={};//商品规格是否被选择。
		//给添加时需要选择的商品信息下拉框赋值
		function getCommodityMsg(supctoId){
			//情况合计值
			$("#add_total_totalTaxPrice").html(0);
			$("#add_total_orderNum").html(0);
			$("#add_total_amountOfTax").html(0);
			$("#add_total_paymentForGoods").html(0);
			
			commodityIsSelected={};//还原
			commodityMsgList=[];//还原
			if(supctoId==-1){
				selectedCommodity={};//还原
				$(".edit_commodity_name_div").each(function(index,val){
					$(val).html("");
					var selectparentId =$(val).attr("attr-id");
					var num=selectparentId.substring(8,selectparentId.length)+"";
					$(val).html("<select id='edit_commodity_name"+num+"' class='form-control edit_commodity_name' ><option value='-1' selected>--请先选择供应商--</option></select>");
					clearForm("goodsMsg"+num, "");
				})
				
			}
			else{
				$.ajax({
					url: '<%=basePath%>basic/goods/commodity/getAllCommodityByStateAndIsDeleteBySupctoId',
					type: "POST",
					dataType: "json",
					data:{
						"supctoId":supctoId
					},
					async: false,
					cache: false,
					success: function(data) {
						commodityMsgList=[];
						commodityMsgList=data;
						$(".edit_commodity_name_div").each(function(index,val){
							$(val).html("");
							var selectparentId =$(val).attr("attr-id");
							var num=selectparentId.substring(8,selectparentId.length)+"";
							$(val).html("<select id='edit_commodity_name"+num+"' class='form-control edit_commodity_name' ></select>");
							if(data.length==0){
								$(val).find("select").append("<option value='-1' selected>--暂无数据，请到商品页面进行添加--</option>");	
							}
							else{
								$(val).find("select").append("<option value='-1' selected>--请选择商品--</option>");
								for(var i=0;i<data.length;i++){
									
									var option = $("<option value='"+data[i].id+"'>" + data[i].commodity.name + " "+data[i].specificationName+"</option>");
									$(val).find("select").append(option);
								}
							}
							$(val).find("select").searchableSelect();
						})
					}
				});
			}
			
		}
		
		
		/* 商品选择框的值改变事件 */
		function selectCommodityMsg(e,selectValId){	
			debugger
			var selectparentId =e.element.parents(".col-xs-8").attr("attr-id");
			var num=selectparentId.substring(8,selectparentId.length)+"";
			if(selectValId!=-1){
				for(var i=0;i<commodityMsgList.length;i++){
					if(commodityMsgList[i].id==selectValId){
						
						//先判断现在选择的商品规格与之前选择的是否是一样的。
						if(selectedCommodity[num]!=selectValId){
							//如果不一样，则先判断选择的这个规格是否已经被选择。
							//1表示被选中，0表示未被选中
							if(commodityIsSelected[selectValId]==1){				
								//若被选择，则提示不能重复选择。
								laywarn("该规格已被选中，请勿重复选择。");
								SearchableSelectsetValue("#edit_commodity_name"+num,-1);
								if(typeof(selectedCommodity[num]) == "undefined"){
									//同时修改该select选择的未-1
									selectedCommodity[num]=-1;
								}
								else{
									if(selectedCommodity[num]!=-1){
										//把之前选择的规格的状态改为未选中
										commodityIsSelected[selectedCommodity[num]]=0;
									}
									//同时修改该select选择的未-1
									selectedCommodity[num]=-1;
								}
								
								$("#"+selectparentId+" .edit_commodity_specifications_id").val("");
								$("#"+selectparentId+" .edit_commodity_identifier").val("");
								$("#"+selectparentId+" .edit_commodity_brand").val("");
								$("#"+selectparentId+" .edit_commodity_specifications").val("");
								$("#"+selectparentId+" .edit_commodity_unit").val("");
								$("#"+selectparentId+" .edit_procureCommodity_taxRate").val("");
								$("#"+selectparentId+" .edit_procureCommodity_originalUnitPrice").val("");
								$("#"+selectparentId+" .edit_procureCommodity_originalUnitPrice").removeAttr("disabled");
								$("#"+selectparentId+" .edit_procureCommodity_businessUnitPrice").val("");
								
								$("#"+selectparentId+" .edit_procureCommodity_discount").val("");
								$("#"+selectparentId+" .edit_procureCommodity_containsTaxPrice").val("");
								$("#"+selectparentId+" .edit_procureCommodity_totalPrice").val("");
								$("#"+selectparentId+" .edit_procureCommodity_amountOfTax").val("");
								$("#"+selectparentId+" .edit_procureCommodity_lotNumber").val("");
								$("#"+selectparentId+" .edit_procureCommodity_paymentForGoods").val("");
								$("#"+selectparentId+" .edit_procureCommodity_orderNum").val("");
								
							}
							else{
								//说明是第一次保存
								if(typeof(selectedCommodity[num]) == "undefined"){
									//同时修改该select选择的规格id
									selectedCommodity[num]=selectValId;
									if(selectedCommodity[num]!=-1){
										//把之前选择的规格的状态改为未选中
										commodityIsSelected[selectedCommodity[num]]=0;
									}		
									//则修改现在选择的规格的状态为选中
									commodityIsSelected[selectValId]=1;
								}
								else{
									//若未被选择 
									if(selectedCommodity[num]!=-1){
										//把之前选择的规格的状态改为未选中
										commodityIsSelected[selectedCommodity[num]]=0;
									}	
									//则修改现在选择的规格的状态为选中
									commodityIsSelected[selectValId]=1;
									//同时修改该select选择的规格id
									selectedCommodity[num]=selectValId;
								}
								console.log("baseUnitName:"+commodityMsgList[i].baseUnitName);
								$("#"+selectparentId+" .edit_commodity_specifications_id").val(commodityMsgList[i].id);
								$("#"+selectparentId+" .edit_commodity_identifier").val(commodityMsgList[i].specificationIdentifier);
								$("#"+selectparentId+" .edit_commodity_brand").val(commodityMsgList[i].commodity.brand);
								$("#"+selectparentId+" .edit_commodity_specifications").val(commodityMsgList[i].specificationName);
								$("#"+selectparentId+" .edit_commodity_unit").val(commodityMsgList[i].baseUnitName);
								$("#"+selectparentId+" .edit_procureCommodity_taxRate").val(commodityMsgList[i].commodity.taxes);
								if(commodityMsgList[i].specOriginalUnitPrice!=null&&commodityMsgList[i].specOriginalUnitPrice>0){
									$("#"+selectparentId+" .edit_procureCommodity_originalUnitPrice").val(commodityMsgList[i].specOriginalUnitPrice);
									$("#"+selectparentId+" .edit_procureCommodity_originalUnitPrice").attr("disabled","disabled");
									$("#"+selectparentId+" .edit_procureCommodity_businessUnitPrice").val(commodityMsgList[i].specOriginalUnitPrice);
								}
								else{
									$("#"+selectparentId+" .edit_procureCommodity_originalUnitPrice").val("");
									$("#"+selectparentId+" .edit_procureCommodity_originalUnitPrice").removeAttr("disabled");
									$("#"+selectparentId+" .edit_procureCommodity_businessUnitPrice").val("");
								}
								
								$("#"+selectparentId+" .edit_procureCommodity_discount").val("");
								$("#"+selectparentId+" .edit_procureCommodity_containsTaxPrice").val("");
								$("#"+selectparentId+" .edit_procureCommodity_totalPrice").val("");
								$("#"+selectparentId+" .edit_procureCommodity_amountOfTax").val("");
								$("#"+selectparentId+" .edit_procureCommodity_lotNumber").val("");
								$("#"+selectparentId+" .edit_procureCommodity_paymentForGoods").val("");
								$("#"+selectparentId+" .edit_procureCommodity_orderNum").val("");
							}
						}
					}		
				}	
			}
			else{
				if(typeof(selectedCommodity[num]) != "undefined"&&selectedCommodity[num]!=-1){
					//把之前选择的规格的状态改为未选中
					commodityIsSelected[selectedCommodity[num]]=0;
				}
				//同时修改该select选择的未-1
				selectedCommodity[num]=-1;
				
				$("#"+selectparentId+" .edit_commodity_specifications_id").val("");
				$("#"+selectparentId+" .edit_commodity_identifier").val("");
				$("#"+selectparentId+" .edit_commodity_brand").val("");
				$("#"+selectparentId+" .edit_commodity_specifications").val("");
				$("#"+selectparentId+" .edit_commodity_unit").val("");
				$("#"+selectparentId+" .edit_procureCommodity_taxRate").val("");
				$("#"+selectparentId+" .edit_procureCommodity_originalUnitPrice").val("");
				$("#"+selectparentId+" .edit_procureCommodity_originalUnitPrice").removeAttr("disabled");
				$("#"+selectparentId+" .edit_procureCommodity_businessUnitPrice").val("");
				
				$("#"+selectparentId+" .edit_procureCommodity_amountOfTax").val("");
				$("#"+selectparentId+" .edit_procureCommodity_paymentForGoods").val("");
				$("#"+selectparentId+" .edit_procureCommodity_totalPrice").val("");
				$("#"+selectparentId+" .edit_procureCommodity_containsTaxPrice").val("");
				
				$("#"+selectparentId+" .edit_procureCommodity_orderNum").val("");
				$("#"+selectparentId+" .edit_procureCommodity_discount").val("");
				$("#"+selectparentId+" .edit_procureCommodity_remarks").val("");
				$("#"+selectparentId+" .edit_procureCommodity_lotNumber").val("");
				
				
			}
			console.log(selectedCommodity);
			console.log(commodityIsSelected);
				
		}
		
		/* 给商品详情添加div */
		function appendGoodsDiv_look(index){	
			
			let goodsDiv=`<div class="row jl-panel" id="lookgoodsMsg`+index+`">
				<div class="col-xs-6">
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">规格编码：</label>
					<div class="col-xs-8 look_commodity_identifier" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">规格：</label>
					<div class="col-xs-8 look_commodity_specifications" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">单位：</label>
					<div class="col-xs-8 look_commodity_unit" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">业务数量：</label>
					<div class="col-xs-8 look_procureCommodity_orderNum" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">含税价：</label>
					<div class="col-xs-8 look_procureCommodity_containsTaxPrice" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">税率：</label>
					<div class="col-xs-8 look_procureCommodity_taxRate" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">货款：</label>
					<div class="col-xs-8 look_procureCommodity_paymentForGoods" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">批号：</label>
					<div class="col-xs-8 look_procureCommodity_lotNumber" id="">
						123456
					</div>
				</div>
				
			</div>
			<div class="col-xs-6">
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">货品名称：</label>
					<div class="col-xs-8 look_commodity_name" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">品牌：</label>
					<div class="col-xs-8 look_commodity_brand" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">原始单价：</label>
					<div class="col-xs-8 look_procureCommodity_originalUnitPrice" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">折扣%：</label>
					<div class="col-xs-8 look_procureCommodity_discount" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">业务单价：</label>
					<div class="col-xs-8 look_procureCommodity_businessUnitPrice" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">税额：</label>
					<div class="col-xs-8 look_procureCommodity_amountOfTax" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">金额：</label>
					<div class="col-xs-8 look_procureCommodity_totalPrice" id="">
						123456
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">备注：</label>
					<div class="col-xs-8 look_procureCommodity_remarks" id="">
						123456
					</div>
				</div>
				<!-- <div class="form-group">
					<label for="" class="col-xs-4 control-label">赠品：</label>
					<div class="col-xs-8 look_procureCommodity_isLargess" id="">
						123456
					</div>
				</div> -->
				<!--<div class="form-group">
					<label for="" class="col-xs-4 control-label">到货日期：</label>
					<div class="col-xs-8 look_procureCommodity_arrivalDate" id="">
						123456
					</div>
				</div> -->
			</div>
		</div>`
		
		$("#look_goodDiv").append(goodsDiv);
		}
		
		let goods_index=1;
		/*新增商品*/
		function  goodsAdd(index,addOrUpdate){
			//1是新增，2是编辑
			if(addOrUpdate==1){
				index=goods_index;
			}
			
			let str=`<div class="row jl-panel procureCommodity" id="goodsMsg`+index+`">
				<span class="close_span" onclick="goodsDel(this)"><i class="fa fa-times"></i></span>
					<div class="col-xs-6">
						<input type="text" id="" class="form-control edit_purchase_commodity_id hidden"/>
						<div class="form-group">
							<input type="text" id="" class="form-control edit_commodity_specifications_id hidden"/>
							<label class="col-xs-4 control-label">货品名称</label>
							<div class="col-xs-8 edit_commodity_name_div" attr-id="goodsMsg`+index+`">
								<select id="edit_commodity_name`+goods_index+`" class="form-control edit_commodity_name" > 
									<option value='-1' selected>--请先选择供应商--</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">规格</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_commodity_specifications"
									readonly="readonly" placeholder="请先选择商品名称" />
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">单位</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_commodity_unit"
									readonly="readonly" placeholder="请先选择商品名称" />
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">原始单价</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_originalUnitPrice" onblur="getBusinessUnitPrice(this)" onkeyup="pressMoney(this)"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务数量</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_orderNum" onblur="getAmountOfTax(this)" onkeyup="pressInteger(this)" maxlength="9"/>
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">折扣%</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_discount" onblur="getBusinessUnitPrice(this)" onkeyup="pressInteger1(this)" maxlength="9"/>
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">含税价</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_containsTaxPrice" disabled="disabled" placeholder="请先填写原始单价、税率"/>
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">金额</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_totalPrice" disabled="disabled" placeholder="请先填写原始单价、税率、业务数量"/>
							</div>
						</div>
						<!--<div class="form-group">
							<label for="" class="col-xs-4 control-label">赠品</label>
							<div class="col-xs-8">
								<select id="" class="form-control edit_procureCommodity_isLargess">
									<option value="-1">--请选择--</option>
									<option value="0">不是</option>
									<option value="1">是</option>
								</select>
							</div>
						</div>-->
						<!-- <div class="form-group">
							<label for="" class="col-xs-4 control-label">到货日期</label>
							<div class="col-xs-8">
								<input type="text" id="edit_procureCommodity_arrivalDate`+goods_index+`" value="" class="form-control edit_procureCommodity_arrivalDate"
									 readonly="readonly" placeholder="请选择到货日期" />
							</div>
						</div> -->

					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="goods_code" class="col-xs-4 control-label">规格编码</label>
							<div class="col-xs-8">
								<input class="form-control edit_commodity_identifier" type="text" name="" id="" value=""
									readonly="readonly" placeholder="请先选择商品名称" />
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">品牌</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_commodity_brand"
									readonly="readonly" placeholder="请先选择商品名称" />
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">税率</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_taxRate" onblur="getAmountOfTax(this)" onkeyup="pressSmallNumZero(this)"/>
							</div>
						</div>
						
				
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务单价</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_businessUnitPrice" disabled="disabled" placeholder="请先填写原始单价"/>
							</div>
						</div>

						
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">税额</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_amountOfTax"  disabled="disabled" placeholder="请先填写原始单价、税率、业务数量"/>
							</div>
						</div>
						

						<div class="form-group">
							<label for="" class="col-xs-4 control-label">批号</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_lotNumber" onkeyup="cky(this)"/>
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">货款</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_paymentForGoods" disabled="disabled" placeholder="请先填写原始单价、税率、业务数量"/>
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">备注</label>
							<div class="col-xs-8">
								<input type="text" id="" value="" class="form-control edit_procureCommodity_remarks" onkeyup="cky(this)"/>
							</div>
						</div>
						
					</div>
				</div>`;
		$("#edit_goodDiv").append(str);
		$("#edit_commodity_name"+goods_index+"").html("");
		if(commodityMsgList.length<=0){
			if($("#edit_supcto_id").val()==-1){		
				$("#edit_commodity_name"+goods_index+"").append("<option value='-1' selected>--请先选择供应商--</option>");
			}
			else{	
				$("#edit_commodity_name"+goods_index+"").append("<option value='-1' selected>--暂无数据，请到商品页面进行添加--</option>");	
			}	
		}
		else{
			
			$("#edit_commodity_name"+goods_index+"").append("<option value='-1' selected>--请选择商品--</option>");
			for(var i=0;i<commodityMsgList.length;i++){
				var option = $("<option value='"+commodityMsgList[i].id+"'>" + commodityMsgList[i].commodity.name + " "+commodityMsgList[i].specificationName+"</option>");
				$("#edit_commodity_name"+goods_index+"").append(option);
			}
			
		}
		$("#edit_commodity_name"+goods_index).searchableSelect();
	    goods_index++;
		}

		

		/*生成采购订单*/
		function purchasePlanEdit(row) {
			
			MessageLayer("确定生成采购订单？", function() {
				$.ajax({
					url: '<%=basePath%>purchase/procuretable/updatePlanByPrimaryKey',
					type: "POST",
					dataType: "json",
					data:{
						"id":row.id,
						"identifier":row.identifier
					},
					async: false,
					cache: false,
					success: function(data) {
						if(data.success) {
							laysuccess("已生成采购订单，请至采购订单管理页面查看相应订单");
							oTable1.fnDraw();
							$("#checkAll").removeAttr("checked");
						} else {
							layfail("生成失败");
						}
						layer.close(index);
					}
				});
			})
			
		}
		
		/*新增*/
		function purchaseOrderAdd() {
			$("#edit_goodDiv").html();
			goodsAdd(1,1);
			clearSearchableSelect('edit_supcto_id');
			layer.open({
				type : 1,
				title : "新增采购计划单",
				closeBtn : 1,
				area : [ '100%', '' ],
				content : $("#editDiv"),
				btn : [ '提交', '取消' ],
				yes : function(index) {
					if(!decideInputAndSelectHasValue()){
						laywarn("表单未填写完整，请完善后再提交");	
						return;
					}
					if(!checkMobilePhone($("#edit_phone").val())){
						laywarn("请输入正确的联系电话!");
						return false;
					}
					if(!checkFax($("#edit_fax").val())){
						laywarn("请输入正确的传真!");
						return false;
					}
					$.ajax({
						url: '<%=basePath%>purchase/procuretable/addPurchaseOrder?planOrTable='+1,
						type: "POST",
						dataType: "json",
						data:{
							"procureTable":JSON.stringify(procureTableDataToJSON())
						},
						async: false,
						cache: false,
						success: function(data) {
							if(data.success) {
								laysuccess(data.msg);
								oTable1.fnDraw();
								$("#checkAll").removeAttr("checked");
							} else {
								layfail(data.msg);
							}
							layer.close(index);
						}
					});
				},
				end : function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "");
					clearSearchableSelect('edit_commodity_name');
					clearSearchableSelect('edit_supcto_id');
					goods_index=0;
					$("#edit_goodDiv").html("");
				}
			});
		}
		
		
		/*详情*/
		function purchasePlanDetail(id) {
			//获取数据显示在界面中
			<%-- $.ajax({
				url: '<%=basePath%>purchase/procuretable/selectById',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"id": id
				},
				success: function(data) {
					if(data.generateDate!=null){
						$("#look_generateDate").html(getSmpFormatDateByLong(data.generateDate,true));
					}
					else{
						$("#look_generateDate").html("");
					}
					if(data.supcto!=null){
						$("#look_supcto_name").html(data.supcto.name);
					}
					else{
						$("#look_supcto_name").html("");
					}
					
					if(data.effectivePeriodEnd!=null){
						$("#look_effectivePeriodEnd").html(getSmpFormatDateByLong(data.effectivePeriodEnd,false));
					}
					else{
						$("#look_effectivePeriodEnd").html("");
					}
					if(data.goodsArrivalTime!=null){
						$("#look_goodsArrivalTime").html(getSmpFormatDateByLong(data.goodsArrivalTime,false));
					}
					else{
						$("#look_goodsArrivalTime").html("");
					}
					$("#look_goodsArrivalPlace").html(data.goodsArrivalPlace);
					$("#look_orderer").html(data.orderer);
					
					$("#look_identifier").html(data.identifier);
					if(data.shippingMode!=null){
						$("#look_transportationMode").html(data.shippingMode.name);
					}
					else{
						$("#look_transportationMode").html("");
					}
					
					$("#look_deliveryman").html(data.deliveryman);
					$("#look_fax").html(data.fax);
					$("#look_phone").html(data.phone);
					if(data.settlementType!=null){
						$("#look_payType").html(data.settlementType.name);
					}
					else{
						$("#look_payType").html("");
					}
					
					if(data.payType==1){
						$("#look_prepaidAmount_div").removeClass("hidden");
						$("#look_prepaidAmount").removeClass("hidden");
						$("#look_prepaidAmount").html(data.prepaidAmount);
					}else{
						$("#look_prepaidAmount_div").addClass("hidden");
						$("#look_prepaidAmount").addClass("hidden");
					}
					
					$("#look_goodDiv").html("");
					var order_num_total=0;
					var total_price_total=0;
					var payment_for_goods_total=0;
					var amount_of_tax_total=0;
					/* 商品 */
					for(var i=0;i<data.procureCommoditys.length;i++){
						appendGoodsDiv_look(i+1);
						if(data.procureCommoditys[i].commoditySpecification!=null){
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_name").html(data.procureCommoditys[i].commoditySpecification.commodity.name);
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_specifications").html(data.procureCommoditys[i].commoditySpecification.specificationName);
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_unit").html(data.procureCommoditys[i].commoditySpecification.baseUnitName);
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_identifier").html(data.procureCommoditys[i].commoditySpecification.specificationIdentifier);
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_brand").html(data.procureCommoditys[i].commoditySpecification.commodity.brand);
							if(data.procureCommoditys[i].taxRate<=0){
								$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_taxRate").html(data.procureCommoditys[i].commoditySpecification.commodity.taxes);
							}
							else{
								$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_taxRate").html(data.procureCommoditys[i].taxRate);
							}
						}
						else{
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_name").html("");
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_specifications").html("");
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_unit").html("");
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_identifier").html("");
							$("#lookgoodsMsg"+(i+1)+" .look_commodity_brand").html("");
						}
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_orderNum").html(data.procureCommoditys[i].orderNum);
						order_num_total+=data.procureCommoditys[i].orderNum;
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_containsTaxPrice").html(data.procureCommoditys[i].containsTaxPrice);
						
						
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_paymentForGoods").html(data.procureCommoditys[i].paymentForGoods);
						payment_for_goods_total+=data.procureCommoditys[i].paymentForGoods;
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_lotNumber").html(data.procureCommoditys[i].lotNumber);
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_remarks").html(data.procureCommoditys[i].remarks);	
						if(data.procureCommoditys[i].originalUnitPrice!=null&&data.procureCommoditys[i].originalUnitPrice>0){
							$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_originalUnitPrice").html(data.procureCommoditys[i].originalUnitPrice);
						}
						else{
							$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_originalUnitPrice").html("0");
						}
						
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_discount").html(data.procureCommoditys[i].discount);
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_businessUnitPrice").html(data.procureCommoditys[i].businessUnitPrice);
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_amountOfTax").html(data.procureCommoditys[i].amountOfTax);
						amount_of_tax_total+=data.procureCommoditys[i].amountOfTax;
						$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_totalPrice").html(data.procureCommoditys[i].totalPrice);
						total_price_total+=data.procureCommoditys[i].totalPrice;
						/* if(data.procureCommoditys[i].isLargess==1){
							$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_isLargess").html("是");
						}
						else{
							$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_isLargess").html("不是");
						} */
						
						if(data.procureCommoditys[i].arrivalDate!=null){
							$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_arrivalDate").html(getSmpFormatDateByLong(data.procureCommoditys[i].arrivalDate,false));
						}
						else{
							$("#lookgoodsMsg"+(i+1)+" .look_procureCommodity_arrivalDate").html("");
						}
						
					}
					
					/* 合计 */
					$("#look_total_orderNum").html(order_num_total);
					$("#look_total_amountOfTax").html(amount_of_tax_total.toFixed(2));
					$("#look_total_paymentForGoods").html(payment_for_goods_total.toFixed(2));
					$("#look_total_totalPrice").html(total_price_total.toFixed(2));
					
					/* 其他 */
					$("#look_departmentId").html(data.departmentName);
					$("#look_summary").html(data.summary);
					if(data.originator!=null&&data.originator!=""){
						if(data.originatorName!=""){
							$("#look_originator").html(data.originator+"("+data.originatorName+")");
						}
						else{
							$("#look_originator").html(data.originator);
						}
					}
					else{
						$("#look_originator").html("");
					}
					
					$("#look_branch").html(data.branch);
					
				}
			}); --%>
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>/purchase/procuretable/detailPurchasePlanOrder",
				dataType : "json",
				data: {
					"id" : id
				},
				success: function(res) {
					let bill = new DetailBill(res);
					let $content = bill.toPrint();
					$("#lookDiv").html($content);
				}
			});
			
			layer.open({
				type: 1,
				title: "采购计划单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#lookDiv"),
				btn: ['关闭']
			});
		}
		
		/* 编辑时判断数据有没有填写完整 */
		function decideInputAndSelectHasValue(){
			var inputValue=true;
			var selectValue=true;
			$("#editDiv input[type='text']").each(function(index, val){	
				if(!$(val).hasClass("hidden")){				
					if($(val).val()==""&&$(val).attr("class")!="searchable-select-input"){
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
		
		/* 保存或者生成订单时 把数据整合成json传入后台 */
		function procureTableDataToJSON(){
			var prepaidAmount;
			if($("#edit_payType").val()==1){
				prepaidAmount=$("#edit_prepaidAmount").val();
			}
			else{
				prepaidAmount=null;
			}
			//采购订单的信息
			var procureTableDataJSON={"id":$("#edit_procure_table_id").val(),"identifier":$("#edit_identifier").val(),"supctoId":$("#edit_supcto_id").val(),"effectivePeriodEndString":$("#edit_effectivePeriodEnd").val(),"goodsArrivalTimeString":$("#edit_goodsArrivalTime").val(),"goodsArrivalPlace":$("#edit_goodsArrivalPlace").val(),"transportationMode":$("#edit_transportationMode").val(),
					"deliveryman":$("#edit_deliveryman").val(),"fax":$("#edit_fax").val(),
					"phone":$("#edit_phone").val(),"orderer":$("#edit_orderer").val(),"prepaidAmount":prepaidAmount,"summary":$("#edit_summary").val(),"payType":$("#edit_payType").val(),
					"procureCommoditys":[]};
			//获取采购商品的信息，添加到采购订单的商品信息里
			$("#edit_goodDiv .procureCommodity").each(function(index, val){
					
				var procureCommodityDataJSON={"id":$(val).find(".edit_purchase_commodity_id").val(),"commodityId":$(val).find(".edit_commodity_specifications_id").val(),"procureTableId":$("#edit_purchase_id").val(),"taxRate":$(val).find(".edit_procureCommodity_taxRate").val(),"amountOfTax":$(val).find(".edit_procureCommodity_amountOfTax").val(),"orderNum":$(val).find(".edit_procureCommodity_orderNum").val(),
						"lotNumber":$(val).find(".edit_procureCommodity_lotNumber").val(),"originalUnitPrice":$(val).find(".edit_procureCommodity_originalUnitPrice").val(),"discount":$(val).find(".edit_procureCommodity_discount").val(),"businessUnitPrice":$(val).find(".edit_procureCommodity_businessUnitPrice").val(),
						"remarks":$(val).find(".edit_procureCommodity_remarks").val(),"containsTaxPrice":$(val).find(".edit_procureCommodity_containsTaxPrice").val(),"paymentForGoods":$(val).find(".edit_procureCommodity_paymentForGoods").val(),"containsTaxPrice":$(val).find(".edit_procureCommodity_containsTaxPrice").val(),
						"paymentForGoods":$(val).find(".edit_procureCommodity_paymentForGoods").val(),"totalPrice":$(val).find(".edit_procureCommodity_totalPrice").val()};	
					
				procureTableDataJSON.procureCommoditys[index]=procureCommodityDataJSON;	
			});
			
			console.log(procureTableDataJSON);
			return procureTableDataJSON;
		}
		
		/*删除商品*/
		function goodsDel(thisspan){
			var selectparentId =$(thisspan).parent().attr("id");
    		var num=selectparentId.substring(8,selectparentId.length)+"";
    		console.log("num:"+num);
			if($("#edit_goodDiv>div").length>1){
				commodityIsSelected[selectedCommodity[num]]=0;
				delete(selectedCommodity[num]);
				$(thisspan).parent().remove();
			}else{
				layfail("商品不能为空");
			}
			 /*  重新计算合计信息 */
			var totalTaxPrice=0;
			var totalOrderNum=0;
			var totalAmountOfTax=0;
			var totalPaymentForGoods=0;
			$(".edit_procureCommodity_totalPrice").each(function(){
	 			totalTaxPrice+=parseFloat($(this).val());

			});
			$(".edit_procureCommodity_orderNum").each(function(){
				totalOrderNum+=parseFloat($(this).val());

			}); 
			$(".edit_procureCommodity_amountOfTax").each(function(){
				totalAmountOfTax+=parseFloat($(this).val());

			});
			$(".edit_procureCommodity_paymentForGoods").each(function(){
				totalPaymentForGoods+=parseFloat($(this).val());

			});
			
			$("#add_total_totalTaxPrice").html(totalTaxPrice.toFixed(2));
			$("#add_total_orderNum").html(totalOrderNum);
			$("#add_total_amountOfTax").html(totalAmountOfTax.toFixed(2));
			$("#add_total_paymentForGoods").html(totalPaymentForGoods.toFixed(2));
		}
		
		function accountDetail(thisimg){
			layer.photos({
			  photos: '#accountShowDiv .jl-panel>div>div'
			  ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
			});
		}
		
		/* 获取业务单价 */
		function getBusinessUnitPrice(e){
			var originalUnitPriceInput=$(e).parents(".procureCommodity").find(".edit_procureCommodity_originalUnitPrice").val();
			var discountInput=$(e).parents(".procureCommodity").find(".edit_procureCommodity_discount").val();
			//税率
			var taxRateInput=$(e).parents(".procureCommodity").find(".edit_procureCommodity_taxRate").val();
			
			if(originalUnitPriceInput!=""&&originalUnitPriceInput-0>0){
				var originalUnitPrice=originalUnitPriceInput-0;
				if(discountInput!=""&&discountInput-0>0){
					var discount=(discountInput-0)/100;
					if(discount==1){
						discount=0;
					}
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_businessUnitPrice").val((originalUnitPrice*discount).toFixed(2));
				}
				else{
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_businessUnitPrice").val(originalUnitPrice.toFixed(2));	
				}
				//业务单价
				var businessUnitPriceInput=$(e).parents(".procureCommodity").find(".edit_procureCommodity_businessUnitPrice").val();
				if(businessUnitPriceInput!=""&&businessUnitPriceInput>0){
					var businessUnitPrice=businessUnitPriceInput-0;
					if(taxRateInput!=""&&taxRateInput>=0){
						var taxRate=taxRateInput-0;
						$(e).parents(".procureCommodity").find(".edit_procureCommodity_containsTaxPrice").val((businessUnitPrice*(1+taxRate)).toFixed(2));//含税价
					}
					else{
						$(e).parents(".procureCommodity").find(".edit_procureCommodity_containsTaxPrice").val("");
					}
				}
				else{
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_containsTaxPrice").val("");
				}
				
			}
			else{
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_businessUnitPrice").val("");	
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_containsTaxPrice").val("");
			}
			
			getAmountOfTax(e);
		}
		
		/* 获取税额和价税合计  */
		function getAmountOfTax(e){
			//税额=业务数量*业务单价*税率
			//含税价=业务单价*（1+税率）
			//货款=金额=含税价*数量
			
			//业务单价
			var businessUnitPriceInput=$(e).parents(".procureCommodity").find(".edit_procureCommodity_businessUnitPrice").val();
			//税率
			var taxRateInput=$(e).parents(".procureCommodity").find(".edit_procureCommodity_taxRate").val();
			//订货数量
			var orderNumInput=$(e).parents(".procureCommodity").find(".edit_procureCommodity_orderNum").val();
			
			
			if(businessUnitPriceInput!=""&&businessUnitPriceInput-0>0){
				var businessUnitPrice=businessUnitPriceInput-0;
				if(orderNumInput!=""&&orderNumInput>0){
					var orderNum=orderNumInput-0;
					if(taxRateInput!=""&&taxRateInput>=0){
						var taxRate=taxRateInput-0;
						$(e).parents(".procureCommodity").find(".edit_procureCommodity_amountOfTax").val((taxRate*orderNum*businessUnitPrice).toFixed(2));//税额
						$(e).parents(".procureCommodity").find(".edit_procureCommodity_paymentForGoods").val((orderNum*businessUnitPrice*(1+taxRate)).toFixed(2));//货款
						$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalPrice").val((orderNum*businessUnitPrice*(1+taxRate)).toFixed(2));//金额		
						
					}
					else{
						$(e).parents(".procureCommodity").find(".edit_procureCommodity_amountOfTax").val("");	
						$(e).parents(".procureCommodity").find(".edit_procureCommodity_paymentForGoods").val("");
						$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalPrice").val("");
						
					}
				}
				else{
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_amountOfTax").val("");	
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_paymentForGoods").val("");	
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalPrice").val("");
				}
				
				if(taxRateInput!=""&&taxRateInput>=0){
					var taxRate=taxRateInput-0;
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_containsTaxPrice").val((businessUnitPrice*(1+taxRate)).toFixed(2));//含税价
				}else{
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_containsTaxPrice").val("");//含税价
				}
				
				
			}
			else{
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_amountOfTax").val("0");	
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalTaxPrice").val("0");	
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalPrice").val("0");
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_containsTaxPrice").val("0");//含税价
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_paymentForGoods").val("0");
			}
			
		 /*  重新计算合计信息 */
			var totalTaxPrice=0;
			var totalOrderNum=0;
			var totalAmountOfTax=0;
			var totalPaymentForGoods=0;
			$(".edit_procureCommodity_totalPrice").each(function(){
	 			totalTaxPrice+=parseFloat($(this).val());

			});
			$(".edit_procureCommodity_orderNum").each(function(){
				totalOrderNum+=parseFloat($(this).val());

			}); 
			$(".edit_procureCommodity_amountOfTax").each(function(){
				totalAmountOfTax+=parseFloat($(this).val());

			});
			$(".edit_procureCommodity_paymentForGoods").each(function(){
				totalPaymentForGoods+=parseFloat($(this).val());

			});
			
			$("#add_total_totalTaxPrice").html(totalTaxPrice.toFixed(2));
			$("#add_total_orderNum").html(totalOrderNum);
			$("#add_total_amountOfTax").html(totalAmountOfTax.toFixed(2));
			$("#add_total_paymentForGoods").html(totalPaymentForGoods.toFixed(2));
			
			
		}
		function pressInteger1(ob) {
    		ob.value = ob.value.replace(/[^\d]/g, ""); //清除"数字"以外的字符
    		if(ob.value>100){
    			laywarn("折扣最多100%");
    			ob.value="";
    		}
    	}
	</script>

</html>