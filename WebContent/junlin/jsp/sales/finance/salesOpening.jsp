<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

	<head>
		<meta charset="utf-8" />
		<title>销售开单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		
		
	<style>
			#editDiv {
				padding-top: 20px;
			}
			#foldlossDiv{
				margin:50px auto;
			}
			#foldlossDiv table th {
				text-align: center;
			}
			.jl-panel{
				padding: 30px;
			}
			#foldlossDiv .jl-panel{
				position: relative;
			}
			.jl-title .r_f{
				margin-top: 15px;
			}
			#query_time{
			width:190px
			}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">销售开单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							单号： <input type="text" value="" id="query_identifier"/>
							</span>
								<span class="l_f"> 
								客户名称： <input type="text" value="" id="query_supctoId" />
							</span>
								<span class="l_f"> 
								货品名称： <input type="text"  value="" id="query_goodsName"/>
							</span>
							
							<span class="l_f" style="margin-left:19px"> 
								起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
							</span>
							<span class="l_f"> 
								状态：<select id="query_state" >
									<option value="-1" selected="selected">--请选择--</option>
									<option value="1">审核中</option>
									<option value="2">审核通过</option>
									<option value="3">审核驳回</option>
									<option value="4">已开单</option>
								</select>
							</span>
							<span class="r_f"> 
								<input type="button" id="btn_search" class="btncss btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>单号</th>
									<th>客户</th>
									<th>货品名称</th>
									<th>结算方式</th>
									<th>日期</th>
									<th>有效期至</th>
									<th>制单人</th>
									<th>是否样品</th>
									<th>状态</th>
									<th>操作</th>
								</tr>

							</thead>
							<tbody>
								
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<!--详情 -->
		<div id="lookDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>是否为样品单</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">是否为样品单:</label>
							<div class="col-xs-8 look_is_specimen">
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">生成时间:</label>
							<div class="col-xs-8 look_create_time">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">客户:</label>
							<div class="col-xs-8 look_supcto_id" >
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">有效期至:</label>
							<div class="col-xs-8 look_end_validity_time">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">发货地点:</label>
							<div class="col-xs-8 look_deliver_goods_place">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">收货人:</label>
							<div class="col-xs-8 look_consignee">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">结算方式:</label>
							<div class="col-xs-8 look_payment">
							</div>
						</div>
						
						
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">单号:</label>
							<div class="col-xs-8 look_identifier">
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">运输方式:</label>
							<div class="col-xs-8 look_shipping_mode_id">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">联系电话:</label>
							<div class="col-xs-8 look_phone">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">订货人:</label>
							<div class="col-xs-8 look_orderer">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">传真:</label>
							<div class="col-xs-8 look_fax">
							</div>
						</div>
						<div class="form-group" id="look_advance_scale_div">
						<label for="" class="col-xs-4 control-label">预收金额:</label>
						<div class="col-xs-8 look_advance_scale"></div>
					</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">发货数量:</label>
							<div class="col-xs-8 look_all_deliver_goods_num" >
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">签收数量:</label>
							<div class="col-xs-8 look_all_receiving_goods_num">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">折损数量:</label>
							<div class="col-xs-8 look_all_damage_num" >
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">返货数量:</label>
							<div class="col-xs-8 look_all_return_goods_num">
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">金额:</label>
							<div class="col-xs-8 look_all_deliver_goods_money" >
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">签收金额:</label>
							<div class="col-xs-8 look_all_receiving_goods_money">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">折损金额:</label>
							<div class="col-xs-8 look_all_damage_money">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">税额:</label>
							<div class="col-xs-8 look_all_taxes_money">
							</div>
						</div>
					</div>
				</div>
				
				<div class="row jl-title">
					<span>商品</span>

				</div>
				<div id="allGoodsDiv_look">
					

				</div>
				
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务员:</label>
							<div class="col-xs-8 look_person_id">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">销售开单审核人:</label>
							<div class="col-xs-8 look_reviewer_sales_Opening_id">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">分支机构:</label>
							<div class="col-xs-8 look_branch">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">摘要:</label>
							<div class="col-xs-8 look_summary">
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">部门:</label>
							<div class="col-xs-8 look_department_id">
							</div>

						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">申请修改开单审核人:</label>
							<div class="col-xs-8 look_reviewer_revision_sales_Opening_id">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">制单人:</label>
							<div class="col-xs-8 look_originator">
							</div>
						</div>
						
					</div>
				</div>

			</form>

		</div>
		
		
		<div id="foldlossDiv" style="display: none;">
			<form action="" class="container">
				<div class="row jl-title">
					<span>折损单</span>
					<i>
						<input type="button" class="btncss jl-btn-importent" id="foldLossBtn"  value="新增折损单" onclick="foldLossAdd(this)">
					</i>
					<i class="r_f">
					</i>
				</div>
				
				<div class="row jl-title ">
					<span>返货单</span>
					<i >
						<input type="button" class="btncss jl-btn-importent" id="returnListBtn"  value="新增返货单" onclick="returnListAdd(this)">
					</i>
					<i class="r_f">
					</i>
				</div>
				
				<div class="text-danger">注：该页面所有字段均为必填</div>
			</form>
			
		</div>
	</body>
	<script>
	laydate.render({
		elem: "#query_time",
		range:'~'
	});
	var oTable1;
	$("#btn_search").click(function() {
		
		$("#checkAll").removeAttr("checked");
		oTable1.fnDraw();
	});
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
							"page":8,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": $("#query_supctoId").val(),
							"isSpecimen":0,
							"createTime": $("#query_time").val(),
							"state": $("#query_state").val()
								
						});
					},
					"url": "<%=basePath%>sales/salesOrder/getSalesOrderMsg"
							},

							"aoColumns" : [{
										"mData" : "identifier",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											
												return '<td><span class="look-span" onclick="salesOrderDetail('
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

									},{
										"mData" : "commoditysName",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"
									},
									{
										"mData" : "payment",
										"bSortable" : false,
										"sWidth" : "8%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {

											switch (data) {
											case 1:
												return "预付款";
												
											case 2:
												return "货到付款";
												
											case 3:
												return "账期";
												
											default:
												return "";
												
											}
										}
									},
									{
										"mData" : "createTime",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender": function(data) {
											return getSmpFormatDateByLong(data, true);
										}

									},
									{
										"mData" : "endValidityTime",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender": function(data) {
											return getSmpFormatDateByLong(data, false);
										}

									},{
										"mData": "person.name",
										"bSortable": false,
										"sWidth": "10%",
										"sClass": "center",
										"mRender": function(data,type,row) {
											if(data!=null&&data!=""){
												if(row.person!=null){
													return row.originator+"("+data+")";
												}else{
													return data;
												}
												
											}
											else{
												return "";
											}
											
										}
									},{
										"mData" : "isSpecimen",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender": function(data) {
											switch (data) {
											case 1:
												return "否";
												
											case 2:
												return "是";
												
											default:
												return "";
												
											}
										}
									},
									{
										"mData" : "state",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {

											switch (data) {
											case 1:
												return "未送审";
												break;
											case 2:
												return "订单待审核";
												break;
											case 3:
												return "订单审核驳回";
												break;
											case 4:
												return "待收预付款";
												break;
											case 5:
												return "待打印备货单";
												break;
											case 6:
												return "作废审核中";
												break;
											case 7:
												return "作废审核中";
												break;
											case 8:
												return "作废审核中";
												break;
											case 9:
												return "作废审核驳回";
												break;
											case 10:
												return "已作废";
												break;
											case 11:
												return "备货中";
												break;
											case 12:
												return "已出库";
												break;
											case 13:
												return "销售开单待审核";
												break;
											case 14:
												return "销售开单驳回";
												break;
											case 15:
												return "已开单";
												break;
											case 16:
												return "申请修改待审核";
												break;
											case 17:
												return "申请修改审核驳回";
												break;
											case 18:
												return "申请修改审核通过";
												break;
											case 19:
												return "折损单待审核";
												break;
											case 20:
												return "折损单审核驳回";
												break;
											case 21:
												return "折损单审核通过";
												break;
											case 22:
												return "折损单待审核";
												break;
											case 23:
												return "折损单审核驳回";
												break;
											case 24:
												return "可开单";
												break;
											case 25:
												return "作废审核驳回";
												break;
											case 26:
												return "已开返货单";
												break;
											default:
												break;
											}
										}

									},

									{
										"mData" : "id",
										"bSortable" : false,
										"sWidth" : "20%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											switch (row.state) {
											case 13:
												return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail('
												+data
												+')" value="详情" /></td>'
												break;

											case 14:
												return '<td><input type="button" class="btncss edit" onclick=\'salesOpeningModify('+JSON.stringify(row)+')\' value="编辑" /></td>'
												break;
												
											case 15:
												return '<td><input type="button" class="btncss edit" onclick="salesOpeningAudit('
												+data
												+')" value="申请修改" /></td>'
												break;

											case 16:
												return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail('
												+data
												+')" value="详情" /></td>'
												break;
												
											case 17:
												return '<td><input type="button" class="btncss edit" onclick="salesOpeningAudit('
												+data
												+')" value="申请修改" /></td>'	
												break;

											case 18:
												return '<td><input type="button" class="btncss edit" onclick=\'salesOpeningModify('+JSON.stringify(row)+')\' value="编辑" /></td>'	
												break;
												
											case 21:
												return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail('
												+data
												+')" value="详情" /></td>'		
												break;

											case 22:
												return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail('
												+data
												+')" value="详情" /></td>'		
												break;
												
											case 23:
												return '<td><input type="button" class="btncss edit" onclick=\'salesOpeningModify('+JSON.stringify(row)+')\' value="编辑" /></td>'			
												break;

											default:
												break;
											}
											
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
	});
		
	/*详情*/
	function salesOrderDetail(id) {
		<%-- $("#allGoodsDiv_look").html("");
		ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectSalesOpeningDetailById",{"id":id},function(data){
			if(data.isSpecimen==1){
				$(".look_is_specimen").html("否");
			}
			else{
				$(".look_is_specimen").html("是");
			}	
			$(".look_create_time").html(getSmpFormatDateByLong(data.createTime,false));
			if(data.supcto!=null){
				$(".look_supcto_id").html(data.supcto.name);
			}
			else{
				$(".look_supcto_id").html();
			}
			$(".look_end_validity_time").html(getSmpFormatDateByLong(data.endValidityTime,false));
			$(".look_deliver_goods_place").html(data.deliverGoodsPlace);
			$(".look_consignee").html(data.consignee);
			switch (data.payment) {
			case 1:
				$(".look_payment").html("预付款");
				$("#look_advance_scale_div").removeClass("hidden");
				$(".look_advance_scale").html(data.advanceScale);
				break;
			case 2:
				$(".look_payment").html("货到付款");
				$("#look_advance_scale_div").addClass("hidden");
				break;
			case 3:
				$(".look_payment").html("账期");
				$("#look_advance_scale_div").addClass("hidden");
				break;
			default:
				break;
			}
			$(".look_identifier").html(data.identifier);
			if(data.shippingMode!=null){
				$(".look_shipping_mode_id").html(data.shippingMode.name);
			}
			else{
				$(".look_shipping_mode_id").html("");
			}
			
			$(".look_phone").html(data.phone);
			$(".look_orderer").html(data.orderer);
			$(".look_fax").html(data.fax);
			$(".look_advance_scale").html(data.advanceScale);		
			$(".look_person_id").html(data.personName);
			if(data.salesOpeningIdentifier!=null&&data.salesOpeningIdentifier!=""){
				if(data.salesOpeningName!=null&&data.salesOpeningName!=""){
					$(".look_reviewer_sales_Opening_id").html(data.salesOpeningIdentifier+"("+data.salesOpeningName+")");
				}
				else{
					$(".look_reviewer_sales_Opening_id").html(data.salesOpeningIdentifier);
				}
			}
			else{
				$(".look_reviewer_sales_Opening_id").html("");
			}
			
			if(data.revisionsalesOpeningIdentifier!=null&&data.revisionsalesOpeningIdentifier!=""){
				if(data.revisionsalesOpeningName!=null&&data.revisionsalesOpeningName!=""){
					$(".look_reviewer_revision_sales_Opening_id").html(data.salesOpeningIdentifier+"("+data.revisionsalesOpeningName+")");
				}
				else{
					$(".look_reviewer_revision_sales_Opening_id").html(data.salesOpeningIdentifier);
				}
			}
			else{
				$(".look_reviewer_revision_sales_Opening_id").html("");
			}
			
			$(".look_branch").html(data.branch);
			$(".look_department_id").html(data.personDepartmentName);
			if(data.person!=null){
				$(".look_originator").html(data.originator+"("+data.person.name+")");
			}
			else{
				$(".look_originator").html(data.originator);
			}
			
			$(".look_summary").html(data.summary);
			
			var allDeliverGoodsNum=0;//总发货数量
			var allDeliverGoodsMoney=0;//总金额
			var allReceivingGoodsNum=0;//总签收数量
			var allReceivingGoodsMoney=0;//总签收金额
			var allDamageNum=0;//总折损数量
			var allDamageMoney=0;//总折损金额
			var allReturnGoodsNum=0;//总返货数量
			var allTaxesMoney=0;//总税额
			for(var i=0;i<data.salesOrderCommodities.length;i++){
				
				goodsAdd(i+1);
				$("#look_goodDiv"+(i+1)+" .look_commodity_name").html(data.salesOrderCommodities[i].commoditySpecification.commodity.name);
				$("#look_goodDiv"+(i+1)+" .look_base_unit").html(data.salesOrderCommodities[i].commoditySpecification.baseUnitName);
				$("#look_goodDiv"+(i+1)+" .look_commodity_specification_name").html(data.salesOrderCommodities[i].commoditySpecification.specificationName);
				$("#look_goodDiv"+(i+1)+" .look_commodity_specification_iden").html(data.salesOrderCommodities[i].commoditySpecification.specificationIdentifier);
				$("#look_goodDiv"+(i+1)+" .look_discount").html(data.salesOrderCommodities[i].discount);
				$("#look_goodDiv"+(i+1)+" .look_taxes").html(data.salesOrderCommodities[i].taxes);
				$("#look_goodDiv"+(i+1)+" .look_deliver_goods_money").html(data.salesOrderCommodities[i].deliverGoodsMoney);
				allDeliverGoodsMoney+=data.salesOrderCommodities[i].deliverGoodsMoney;
				$("#look_goodDiv"+(i+1)+" .look_remark").html(data.salesOrderCommodities[i].remark);
				$("#look_goodDiv"+(i+1)+" .look_deliver_goods_num").html(data.salesOrderCommodities[i].deliverGoodsNum);
				allDeliverGoodsNum+=data.salesOrderCommodities[i].deliverGoodsNum;
				$("#look_goodDiv"+(i+1)+" .look_unit_price").html(data.salesOrderCommodities[i].unitPrice);
				$("#look_goodDiv"+(i+1)+" .look_taxes_money").html(data.salesOrderCommodities[i].taxesMoney);
				allTaxesMoney+=data.salesOrderCommodities[i].taxesMoney;
				//签收数量&金额
				$("#look_goodDiv"+(i+1)+" .look_receiving_goods_num").html(data.salesOrderCommodities[i].receivingGoodsNum);
				allReceivingGoodsNum+=data.salesOrderCommodities[i].receivingGoodsNum;
				$("#look_goodDiv"+(i+1)+" .look_receiving_goods_money").html(data.salesOrderCommodities[i].receivingGoodsMoney);
				allReceivingGoodsMoney+=data.salesOrderCommodities[i].receivingGoodsMoney;
				//折损数量&金额
				$("#look_goodDiv"+(i+1)+" .look_damage_num").html(data.salesOrderCommodities[i].damageNum);
				allDamageNum+=data.salesOrderCommodities[i].damageNum;
				$("#look_goodDiv"+(i+1)+" .look_damage_money").html(data.salesOrderCommodities[i].damageMoney);
				allDamageMoney+=data.salesOrderCommodities[i].damageMoney;
				//返货数量
				$("#look_goodDiv"+(i+1)+" .look_return_goods_num").html(data.salesOrderCommodities[i].returnGoodsNum);
				allReturnGoodsNum+=data.salesOrderCommodities[i].returnGoodsNum;
				
			} 
			$(".look_all_deliver_goods_num").html(allDeliverGoodsNum);
			$(".look_all_deliver_goods_money").html(allDeliverGoodsMoney);
			$(".look_all_receiving_goods_num").html(allReceivingGoodsNum);
			$(".look_all_receiving_goods_money").html(allReceivingGoodsMoney);
			$(".look_all_damage_num").html(allDamageNum);
			$(".look_all_damage_money").html(allDamageMoney);
			$(".look_all_return_goods_num").html(allReturnGoodsNum);
			$(".look_all_taxes_money").html(allTaxesMoney);
		}) --%>
		$("#lookDiv").html("");
		$.ajax({
			type: "post",
			url: "<%=basePath%>sales/salesOrder/salesOrderDetail",
			dataType : "json",
			data: {
				"id" : id,
				"type":2
			},
			success: function(res) {
				let bill = new DetailBill(res);
				let $content = bill.toPrint();
				$("#lookDiv").html($content);
			}
		});
		layer.open({
			type: 1,
			title: "销售开单详情",
			closeBtn: 1,
			area: ['100%', '100%'],
			content: $("#lookDiv"),
			btn: ['关闭']
		});
	}

	/*申请修改*/
	function salesOpeningAudit(id) {
		var ids=[id];
		publicMessageLayer("申请修改该订单", function() {
			ajaxJquery("POST","<%=basePath%>sales/salesOrder/updateStateByIds",{"ids":ids,"state":16,"isCheck":0,"reviewerType":0,"msg":"操作成功！"},function(data){
				if(data.success) {
					laysuccess(data.msg);
					oTable1.fnDraw(false);
				} else {
					layfail(data.msg);
				}
			})
		})
	}
	
	let nofoldLossdatajson=[];
	let noreturnListdatajson=[];
	let foldLossdatajson=[];
	let returnListdatajson=[];
	let foldLossOrderId=0;
	let returnListOrderId=0;
	let foldLossOrderState=0;
	let returnListOrderIdState=0;
	/*编辑*/
	function salesOpeningModify(row){
		var isHasFoldLoss=false;//是否含有折损单
		var isHasreturnList=false;//是否含有返货单
		foldLossdatajson=[];
		returnListdatajson=[];
		nofoldLossdatajson=[];
		noreturnListdatajson=[];
		foldLossOrderId=0;
		returnListOrderId=0;
		foldLossOrderState=0;
		returnListOrderIdState=0;
		//查询是否有折损单
		ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectMsgByParentIdAndOrderType",{"orderType":4,"parentId":row.parentId},function(data){
			
			if(data!=null&&data!=""&&data.id>0){
				isHasFoldLoss=true;
				foldLossOrderId=data.id;
				console.log("foldLossOrderId:"+foldLossOrderId+" foldLossOrderState:"+foldLossOrderState);
				foldLossOrderState=data.state;
				for(var i=0;i<data.salesOrderCommodities.length;i++){
					let foldLossObj={
							"socId":0,
							"goodsspecId":0,
							"goodsname":0,
							"goodsprise":0,
							"goodstaxes":0,
							"foldLossNum":0,
							"foldLossMoney":0,
							"deliverGoodsNum":0
						};
					
						foldLossObj.socId=data.salesOrderCommodities[i].id;
						foldLossObj.goodsspecId=data.salesOrderCommodities[i].commoditySpecificationId;
						foldLossObj.goodsname=data.salesOrderCommodities[i].commoditySpecification.commodity.name+"("+data.salesOrderCommodities[i].commoditySpecification.specificationName+")";
						foldLossObj.goodsprise=data.salesOrderCommodities[i].unitPrice;
						foldLossObj.goodstaxes=data.salesOrderCommodities[i].taxes;
						foldLossObj.foldLossNum=data.salesOrderCommodities[i].damageNum;
						foldLossObj.foldLossMoney=data.salesOrderCommodities[i].damageMoney;
						foldLossObj.deliverGoodsNum=data.salesOrderCommodities[i].deliverGoodsNum;
						foldLossdatajson.push(foldLossObj);
					
				}
				console.log("foldLossdatajson：");
				console.log(foldLossdatajson);
			}
		})
		//查询是否有返货单
		ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectMsgByParentIdAndOrderType",{"orderType":5,"parentId":row.parentId},function(data){
			
			if(data!=null&&data.id>0){
				isHasreturnList=true;
				returnListOrderId=data.id;
				returnListOrderIdState=data.state;
				for(var i=0;i<data.salesOrderCommodities.length;i++){
					let returnListObj={
							"socId":0,
							"goodsspecId":0,
							"goodsname":0,
							"returnListNum":0,
							"wareHouseId":0,
							"deliverGoodsNum":0
						};
					
						returnListObj.socId=data.salesOrderCommodities[i].id;
						returnListObj.goodsspecId=data.salesOrderCommodities[i].commoditySpecificationId;
						returnListObj.goodsname=data.salesOrderCommodities[i].commoditySpecification.commodity.name+"("+data.salesOrderCommodities[i].commoditySpecification.specificationName+")";
						returnListObj.returnListNum=data.salesOrderCommodities[i].returnGoodsNum;
						returnListObj.wareHouseId=data.salesOrderCommodities[i].warehouseId;
						returnListObj.deliverGoodsNum=data.salesOrderCommodities[i].deliverGoodsNum;
						console.log("warehouseId:"+data.salesOrderCommodities[i].warehouseId);
						returnListdatajson.push(returnListObj);
					
					
				}
				console.log("returnListdatajson：");
				console.log(returnListdatajson);
			}
		})
		/*请根据情况修改if条件*/
		if(isHasFoldLoss){
			let $checkbox=`<input type="button" class="btncss jl-btn-warm" value="修改" onclick="modifyOrder(this)">`;
			$("#foldLossBtn").parents(".jl-title").find(".r_f").html($checkbox);
			
			/*若之前有折损单，请传入数据*/
			//let datajson=[{"socId":123,"goodsname":123,"goodsprise":12,"foldLossNum":1,"foldLossMoney":10}];
			
			foldLossAdd("#foldLossBtn",foldLossdatajson);
			
			$("#foldLossBtn").parents(".jl-title").next().find("input[type='text']").attr("disabled","disabled");
		}else{
			/*之前没有折损单*/
			$("#foldLossBtn").removeClass("hidden");
			foldLossOrderId=0;
			foldLossOrderState=0;
			for(var i=0;i<row.salesOrderCommodities.length;i++){
				let foldLossObj={
						"socId":0,
						"goodsspecId":0,
						"goodsname":0,
						"goodsprise":0,
						"goodstaxes":0,
						"deliverGoodsNum":0,
						"foldLossNum":0,
						"foldLossMoney":0
					};
				
					foldLossObj.socId=0;
					foldLossObj.goodsspecId=row.salesOrderCommodities[i].commoditySpecificationId;
					foldLossObj.goodsname=row.salesOrderCommodities[i].commoditySpecification.commodity.name+"("+row.salesOrderCommodities[i].commoditySpecification.specificationName+")";
					foldLossObj.goodsprise=row.salesOrderCommodities[i].unitPrice;
					foldLossObj.goodstaxes=row.salesOrderCommodities[i].taxes;
					foldLossObj.deliverGoodsNum=row.salesOrderCommodities[i].deliverGoodsNum;
					foldLossObj.foldLossNum=0;
					foldLossObj.foldLossMoney=0;
					
					nofoldLossdatajson.push(foldLossObj);
				
			}
			console.log(" nofoldLossdatajson：");
			console.log(nofoldLossdatajson);
		}
		
		if(isHasreturnList){
			let $checkbox=`<input type="button" class="btncss jl-btn-warm" value="修改" onclick="modifyOrder(this)">`;
			$("#returnListBtn").parents(".jl-title").find(".r_f").html($checkbox);
			
			/*若之前有返货单据，请传入数据*/
			//let datajson=[{"socId":123,"goodsname":123},{"socId":123,"goodsname":123,"returnListNum":1}];
			
			returnListAdd("#returnListBtn",returnListdatajson);
			
			$("#returnListBtn").parents(".jl-title").next().find("input[type='text']").attr("disabled","disabled");
		}else{
			/*之前没有返货单*/
			$("#returnListBtn").removeClass("hidden");
			returnListOrderId=0;
			returnListOrderIdState=0;
			for(var i=0;i<row.salesOrderCommodities.length;i++){
				let returnListObj={
						"socId":0,
						"goodsspecId":0,
						"goodsname":0,
						"returnListNum":0,
						"wareHouseId":0,
						"deliverGoodsNum":0
					};
				
					returnListObj.socId=0;
					returnListObj.goodsspecId=row.salesOrderCommodities[i].commoditySpecificationId;
					returnListObj.goodsname=row.salesOrderCommodities[i].commoditySpecification.commodity.name+"("+row.salesOrderCommodities[i].commoditySpecification.specificationName+")";
					returnListObj.returnListNum=0;
					returnListObj.wareHouseId=0;
					returnListObj.deliverGoodsNum=row.salesOrderCommodities[i].deliverGoodsNum;
					
					noreturnListdatajson.push(returnListObj);
				
			}
			console.log(" noreturnListdatajson：");
			console.log(noreturnListdatajson);
		}
		
		layer.open({
			type: 1,
			title: "修改销售开单",
			closeBtn: 1,
			area: ['100%', '100%'],
			content: $("#foldlossDiv"),
			btn: ['提交','取消'],
			yes:function (index){
				/* if(!decideInput()){
					laywarn("输入框中请输入大于0的数");	
					return;
				} */
				
				 let salesOpeningMsg = JSON.stringify(getTableJson(row.id,row.state));
				
				 ajaxJquery("POST","<%=basePath%>sales/salesOrder/updateSalesOpening",{"salesOpening":salesOpeningMsg},function(data){
					
					if(data.success){
						layer.close(index);
						laysuccess(data.msg);
						oTable1.fnDraw(false);
					}
					else{
						layer.close(index);
						layfail(data.msg);
					}
					
				}) 
			},
			end: function(index, layero){
				layer.close(index);
				clearForm("foldlossDiv");
				$("#foldlossDiv .jl-panel").remove();
				$(".jl-title .r_f").html("")
				}
		});
	}
	
	/*新增表格*/
	function TableAdd(thisbtn,$str){
		let $brother=$(thisbtn).parents(".jl-title");
		$brother.after($str);
		$(thisbtn).addClass("hidden");
	}
	/*新增折损单*/
	function foldLossAdd(thisbtn,datajson){
		let $str0=`<div class="row jl-panel" id="foldLossTableDiv">`;
		let $closespan=`<span class="close_span" onclick="delform(this)"><i class="fa fa-times"></i></span>`;
		let $str1=`<table class="table table-bordered table-striped table-hover col-xs-12" id="foldLossTable" border="" cellspacing="0" cellpadding="0">
					<tr>
						<th>折损商品</th><th>单价</th><th>税率</th><th>发货数量</th><th>折损数量</th><th>折损金额</th>
					</tr>`;
		let $str2=``;
		let $str3=`</table></div>`;
		let jsonarr;
		if(datajson){
			jsonarr=datajson;
		}else{
			foldLossTableIsUpdate=true;
			jsonarr=nofoldLossdatajson;
			$str0=$str0+$closespan;
		}
		console.log("jsonarr",jsonarr);
		for(let arrkey=0;arrkey<jsonarr.length;arrkey++){
			$str2+=`<tr>
						<td class="hidden">`+jsonarr[arrkey]["socId"]+`</td>
						<td class="hidden">`+jsonarr[arrkey]["goodsspecId"]+`</td>
						<td>`+jsonarr[arrkey]["goodsname"]+`</td>
						<td>`+jsonarr[arrkey]["goodsprise"]+`</td>
						<td>`+jsonarr[arrkey]["goodstaxes"]+`</td>
						<td>`+jsonarr[arrkey]["deliverGoodsNum"]+`</td>
						<td><input type="text" class="form-control" id="foldLossNum"  value="`+jsonarr[arrkey]["foldLossNum"]+`" attr-num="`+jsonarr[arrkey]["foldLossNum"]+`" onkeyup="wreckMoney(this)"   maxlength="9" /></td>
 						<td><input type="text" class="form-control"  value="`+jsonarr[arrkey]["foldLossMoney"]+`" attr-money="`+jsonarr[arrkey]["foldLossMoney"]+`" onkeyup="pressMoney(this)"/></td>
					</tr>`;
		}
		TableAdd(thisbtn,$str0+$str1+$str2+$str3);
		
	}
	/*新增返货单*/
	function returnListAdd(thisbtn,datajson){
		let $str0=`<div class="row jl-panel" id="returnListTableDiv">`;
		let $closespan=`<span class="close_span" onclick="delform(this)"><i class="fa fa-times"></i></span>`;
		let $str1=`<table class="table table-bordered table-striped table-hover col-xs-12" id="returnListTable" border="" cellspacing="0" cellpadding="0">
					<tr>
						<th>返货商品</th><th>发货数量</th><th>返货数量</th>
					</tr>`;
					
		let $str2=``;
		let $str3=`</table></div>`;
			
		let jsonarr;
		if(datajson){
			jsonarr=datajson;
		}else{
			returnListTableIsUpdate=true;
			jsonarr=noreturnListdatajson;
			$str0=$str0+$closespan;
		}
		for(let arrkey=0;arrkey<jsonarr.length;arrkey++){
			let returnNum = jsonarr[arrkey]["returnListNum"];
			if(returnNum==null){
				returnNum = 0; 
			}
			$str2+=`<tr>
						<td class="hidden">`+jsonarr[arrkey]["socId"]+`</td>
						<td class="hidden">`+jsonarr[arrkey]["goodsspecId"]+`</td>
						<td class="hidden">`+jsonarr[arrkey]["returnListNum"]+`</td>
						<td class="hidden">`+jsonarr[arrkey]["wareHouseId"]+`</td>
						<td>`+jsonarr[arrkey]["goodsname"]+`</td>
						<td class="deliver_GoodsNum">`+jsonarr[arrkey]["deliverGoodsNum"]+`</td>
						<td><input type="text" class="form-control" value="`+returnNum+`" attr-num="`+returnNum+`" onkeyup="pressInteger(this)" onblur="returnMoney(this)" maxlength="9" id="return_num"/></td>
					</tr>`;
		}
		
		TableAdd(thisbtn,$str0+$str1+$str2+$str3);
	}
	var foldLossTableIsUpdate=false;//折损单是否被修改
	var returnListTableIsUpdate=false;//返货单是否被修改
	
	/*删除商品*/
	function delform(thisspan){
		if($(thisspan).parent().attr("id")=="foldLossTableDiv"){
			foldLossTableIsUpdate=false;
		}else if($(thisspan).parent().attr("id")=="returnListTableDiv"){	
			returnListTableIsUpdate=false;
		}
		$(thisspan).parent().prev().find("input").removeClass("hidden");
		$(thisspan).parent().remove();
	}
	
	
	//修改返货单/折损单信息
	function modifyOrder(thisInput){	
		if($(thisInput).parents(".jl-title").next().attr("id")=="foldLossTableDiv"){
			foldLossTableIsUpdate=true;
		}else if($(thisInput).parents(".jl-title").next().attr("id")=="returnListTableDiv"){
			returnListTableIsUpdate=true;
		}
		$(thisInput).parents(".jl-title").next().find("input[type='text']").attr("disabled",false);
		$(thisInput).val("取消");
		$(thisInput).attr("onclick","cancelModifyOrder(this)");
		
	}
	
	//取消修改返货单/折损单信息
	function cancelModifyOrder(thisInput){
		if($(thisInput).parents(".jl-title").next().attr("id")=="foldLossTableDiv"){
			//复原折损单
			$(thisInput).parents(".jl-title").next().remove();
			foldLossAdd("#foldLossBtn",foldLossdatajson);
			foldLossTableIsUpdate=false;
		}else if($(thisInput).parents(".jl-title").next().attr("id")=="returnListTableDiv"){
			//复原返货单
			$(thisInput).parents(".jl-title").next().remove();
			returnListAdd("#returnListBtn",returnListdatajson);
			returnListTableIsUpdate=false;
		}
		
		$(thisInput).parents(".jl-title").next().find("input[type='text']").attr("disabled","disabled");
		$(thisInput).val("修改");
		$(thisInput).attr("onclick","modifyOrder(this)");
		
		
	}
	
	
	/* 查看详情时的商品添加 */
	function goodsAdd(index){
		let goodsDiv=`<div class="row jl-panel" id="look_goodDiv`+index+`">
			<div class="col-xs-6">
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">货品名称:</label>
				<div class="col-xs-8 look_commodity_name">

				</div>
			</div>

			<div class="form-group">
				<label for="" class="col-xs-4 control-label">单位:</label>
				<div class="col-xs-8 look_base_unit">
				</div>
			</div>

			

			<div class="form-group">
				<label for="" class="col-xs-4 control-label">折扣%:</label>
				<div class="col-xs-8 look_discount">
				</div>
			</div>
			
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">发货数量:</label>
				<div class="col-xs-8 look_deliver_goods_num">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">签收数量:</label>
				<div class="col-xs-8 look_receiving_goods_num">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">税率:</label>
				<div class="col-xs-8 look_taxes">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">折损数量:</label>
				<div class="col-xs-8 look_damage_num">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">返货数量:</label>
				<div class="col-xs-8 look_return_goods_num">
				</div>
			</div>
			
		</div>
		<div class="col-xs-6">
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">规格:</label>
				<div class="col-xs-8 look_commodity_specification_name">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">规格编号:</label>
				<div class="col-xs-8 look_commodity_specification_iden">
				</div>
			</div>
			
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">单价:</label>
				<div class="col-xs-8 look_unit_price">
				</div>
			</div>

			<div class="form-group">
				<label for="" class="col-xs-4 control-label">金额:</label>
				<div class="col-xs-8 look_deliver_goods_money">
				</div>
			</div>
			
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">签收金额:</label>
				<div class="col-xs-8 look_receiving_goods_money">
				</div>
			</div>
			
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">税额:</label>
				<div class="col-xs-8 look_taxes_money">
				</div>
			</div>

			<div class="form-group">
				<label for="" class="col-xs-4 control-label">折损金额:</label>
				<div class="col-xs-8 look_damage_money">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">备注:</label>
				<div class="col-xs-8 look_remark">
				</div>
			</div>

		</div>
	</div>`;
	
	$("#allGoodsDiv_look").append(goodsDiv);
	}
	
	//判断是输入框输入的值是否正确
	function decideInput(){
		var flag=true;
		$("#foldlossDiv input[type='text']").each(function(trIndex,trObj){
			
			if($(trObj).attr("id")!="foldLossNum"){
				if(!isnotEmpty($(trObj).val())||$(trObj).val()-0<=0){
					flag=false;
				}
			}
			
		})
		return flag;
	}
	
	/* 拼成需要往后台传的json */
	function getTableJson(salesOpeningId,salesOpeningState){
		
		if(foldLossTableIsUpdate){
			foldLossOrderIsUpdate=2;//折损单被修改
		}
		else{
			foldLossOrderIsUpdate=1;
		}
		if(returnListTableIsUpdate){
			returnListOrderIsUpdate=2;//返货单被修改
		}
		else{
			returnListOrderIsUpdate=1;
		}
		let resultArr={"salesOpeningId":salesOpeningId,"salesOpeningState":salesOpeningState,
				"foldLossOrderId":foldLossOrderId,"returnListOrderId":returnListOrderId,
				"foldLossOrderState":foldLossOrderState,"returnListOrderIdState":returnListOrderIdState,
				"foldLossOrderIsUpdate":foldLossOrderIsUpdate,"returnListOrderIsUpdate":returnListOrderIsUpdate,
				"foldLossOrder":[],"returnListOrder":[]};
		
		$("#foldLossTable tr").each(function(trIndex,trObj){
			let foldLossObj={
					"socId":0,
					"goodsspecId":0,
					"foldLossNum":0,
					"foldLossMoney":0
				};
			if(trIndex!=0){
				foldLossObj.socId=$(trObj).children().first().html()-0;
				foldLossObj.goodsspecId=$(trObj).children().first().next().html()-0;
				foldLossObj.foldLossNum=$(trObj).find("input[type='text']").first().val()-0;
				foldLossObj.foldLossMoney=$(trObj).find("input[type='text']").last().val()-0;
				resultArr.foldLossOrder.push(foldLossObj);
			}
			
		  });
		$("#returnListTable tr").each(function(trIndex,trObj){
			let returnListObj={
					"socId":0,
					"goodsspecId":0,
					"returnListNum":0,
					"oldReturnListNum":0,
					"wareHouseId":0
				};
			if(trIndex!=0){
				returnListObj.socId=$(trObj).children().first().html()-0;
				returnListObj.goodsspecId=$(trObj).children().first().next().html()-0;
				returnListObj.returnListNum=$(trObj).find("input[type='text']").val()-0;
				returnListObj.oldReturnListNum=$(trObj).children().first().next().next().html()-0;
				returnListObj.wareHouseId=$(trObj).children().first().next().next().next().html()-0;
				resultArr.returnListOrder.push(returnListObj);
			}
			
		  });
		console.log("resultArr:");
		console.log(resultArr);
		return resultArr;
		
	}
	

	function wreckMoney(thisInput){
		var tr = thisInput.parentNode.parentNode;
		pressInteger(thisInput);
		let goods_num = thisInput.value;
		var return_num=$("#returnListTable tr:gt(0)").eq(tr.rowIndex-1).children("td:eq(6)").find("input").val();
		var deliver_GoodsNum=$("#returnListTable tr:gt(0)").eq(tr.rowIndex-1).children().eq(5).html();
		var  goodNum=deliver_GoodsNum-return_num;
		if(goods_num>parseInt(goodNum)){
			layfail("折损数量不能大于发货数量与返货数量之差");
			thisInput.value=goodNum;
		}

	}
	function returnMoney(thisInput){
		
		pressInteger(thisInput);
		let goods_num = thisInput.value;
		var goodNum=$(thisInput).parent().prev().html();
		if(goods_num>parseInt(goodNum)){
			layfail("返货数量不能大于发货数量");
			thisInput.value=goodNum;
		}

	}
	
</script>

</html>