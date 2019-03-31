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
<title>销售订单</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%@include file="/common.jsp"%>


<link
	href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css"
	rel="stylesheet" type="text/css">
<script
	src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
<style>
#editDiv {
	padding-top: 20px;
}

#editDiv .jl-panel {
	position: relative;
}

.input-group-addon {
	padding: 0 10px;
	background: #fff;
	border-left: none;
}

.input-group {
	line-height: 16.8px;
}
</style>
</head>

<body class="content" id="salesOrder_content">
	<div class="page-content clearfix">
		<div id="Member_Ratings">
			<div class="d_Confirm_Order_style" style="margin-top: 10px;">
				<h4 class="text-title">销售订单</h4>
				<div class="search-div clearfix">
					<div class="clearfix">
						<span class="l_f"> 单号： <input type="text" value=""
							id="query_identifier" />
						</span> <span class="l_f"> 客户名称： <input type="text" value=""
							id="query_supctoId" />
						</span> <span class="l_f"> 货品名称： <input type="text" value=""
							id="query_goodsName" />
						</span> <span class="l_f"> 是否为样品单： <select id="query_isSpecimen">
								<option value="0">请选择</option>
								<option value="1">否</option>
								<option value="2">是</option>
						</select>
						</span> </span> <span class="r_f"> <input type="button" id="btn_search"
							class="btncss btn_search" value="搜索" />
						</span>
					</div>

				</div>
				<div class="opration-div clearfix">
					<!--<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="salesOrderRefresh()" style="margin-right: 0;"><i class="fa fa-refresh"></i>刷新</button>
						</span>-->
					<!--<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="salesOrderDel()"><i class="fa fa-trash"></i> 删除</button>
						</span>-->
					<span class="r_f">
						<button type="button" class="btncss jl-btn-defult"
							onclick="salesOrderAdd()" style="margin-right: 0;">
							<i class="fa fa-plus"></i>新增
						</button>
					</span>
					<!--<span class="jl_f_l">
							<input type="checkbox" name="id" id="checkAll" style="margin:0 5px 0 0;" onclick="checkboxController(this)"/>
						</span>
						<span class="jl_f_l">
							<label for="checkAll">全选</label>
						</span>-->

				</div>
				<div class="table_menu_list">
					<table class="table table-striped table-hover col-xs-12"
						id="datatable">
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
								<th>app订单</th>
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
						<div class="col-xs-8 look_is_specimen"></div>
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
						<div class="col-xs-8 look_create_time"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">客户:</label>
						<div class="col-xs-8 look_supcto_id"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">有效期至:</label>
						<div class="col-xs-8 look_end_validity_time"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">发货地点:</label>
						<div class="col-xs-8 look_deliver_goods_place"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">收货人:</label>
						<div class="col-xs-8 look_consignee"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">结算方式:</label>
						<div class="col-xs-8 look_payment"></div>
					</div>
					<div class="form-group" id="look_advance_scale_div">
						<label for="" class="col-xs-4 control-label">预收金额:</label>
						<div class="col-xs-8 look_advance_scale"></div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">单号:</label>
						<div class="col-xs-8 look_identifier"></div>
					</div>

					<div class="form-group">
						<label for="" class="col-xs-4 control-label">运输方式:</label>
						<div class="col-xs-8 look_shipping_mode_id"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">联系电话:</label>
						<div class="col-xs-8 look_phone"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">订货人:</label>
						<div class="col-xs-8 look_orderer"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">收货地点:</label>
						<div class="col-xs-8 look_receipt_goods_place"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">传真:</label>
						<div class="col-xs-8 look_fax"></div>
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
						<div class="col-xs-8 look_all_deliver_goods_num"></div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">金额:</label>
						<div class="col-xs-8 look_all_deliver_goods_money" ></div>
					</div>
					
				</div>
				<div class="col-xs-6">
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">税额:</label>
						<div class="col-xs-8 look_all_taxes_money"></div>
					</div>
					
				</div>
			</div>
			
			<div class="row jl-title">
				<span>商品</span>

			</div>
			<div id="allGoodsDiv_look"></div>
			
			<div class="row jl-title">
				<span>其他</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">业务员:</label>
						<div class="col-xs-8 look_person_id"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">制单人:</label>
						<div class="col-xs-8 look_originator"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">领导作废审核人:</label>
						<div class="col-xs-8 look_revokeLeader_id"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">分支机构:</label>
						<div class="col-xs-8 look_branch"></div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">部门:</label>
						<div class="col-xs-8 look_department_id"></div>

					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">审核人:</label>
						<div class="col-xs-8 look_reviewer_id"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">仓库作废审核人:</label>
						<div class="col-xs-8 look_revokeWarehouse_id"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">摘要:</label>
						<div class="col-xs-8 look_summary"></div>
					</div>
				</div>
			</div>

		</form>

	</div>


	<!--编辑 -->
	<div id="editDiv" style="display: none;">
		<form class="container">
			<input type="text" class="form-control hidden" id="edit_sales_id" />
			<div class="row jl-title">
				<span>是否为样品单</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">是否为样品单</label>
						<div class="col-xs-8">
							<select class="form-control edit_is_specimen"
								id="edit_is_specimen">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="2">是</option>
								<option value="1">否</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="row jl-title">
				<span>基本信息</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group hidden" id="edit_generateDate_div">
						<label for="" class="col-xs-4 control-label">日期</label>
						<div class="col-xs-8">
							<input type="text" class="form-control hidden"
								id="edit_generateDate" disabled="disabled" />
						</div>
					</div>
					<div class="form-group" id="edit_supctoId_kehu_Div">
						<label for="" class="col-xs-4 control-label">客户</label>
						<div class="col-xs-8">
							<input type="text" id="edit_supctoId_input" class="form-control hidden" disabled="true"/>
						</div>
						
						<div class="col-xs-8">
							<select class="form-control" id="edit_supctoId">

							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">有效期至</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="effective_date"
								readonly="readonly" placeholder="请选择有效期" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">发货地点</label>
						<div class="col-xs-8">
							<input type="text" class="form-control"
								id="edit_deliver_goods_place" maxlength="100" onkeyup="cky(this)" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">收货人</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" maxlength="100" id="edit_consignee"
								onkeyup="cky(this)" />
						</div>
					</div>

					<div class="form-group">
						<label for="" class="col-xs-4 control-label">传真</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" maxlength="100" id="edit_fax"
								onkeyup="cky(this)" />
						</div>
					</div>
					<div class="form-group hidden" id="edit_advance_scale_div">
						<label for="" class="col-xs-4 control-label">预收金额</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="edit_advance_scale"
								onkeyup="pressMoney(this)" />
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group hidden" id="edit_identifier_div">
						<label for="" class="col-xs-4 control-label">单号</label>
						<div class="col-xs-8">
							<input type="text" class="form-control hidden"
								id="edit_identifier" disabled="disabled" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">结算方式</label>
						<div class="col-xs-8">
							<select id="edit_payType" name="" class="form-control">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1" >预付款</option>
								<option value="2" >货到付款</option>
								<option value="3" >账期</option>
							</select>
						</div>
					</div>
					<%--<div class="form-group">--%>
					<%--<label for="" class="col-xs-4 control-label">发货时间</label>--%>
					<%--<div class="col-xs-8">--%>
					<%--<input type="text" class="form-control" id="send_time" readonly="readonly" placeholder="请选择发货时间"/>--%>
					<%--</div>--%>
					<%--</div>--%>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">运输方式</label>
						<div class="col-xs-8">
							<select name="" class="form-control" id="edit_transportationMode">

							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">联系电话</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="edit_phone"
								onkeyup="cky(this)" maxlength="11" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">收货地点</label>
						<div class="col-xs-8">
							<input type="text" class="form-control"
								id="edit_receipt_goods_place" maxlength="100" onkeyup="cky(this)" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">订货人</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" maxlength="100" id="edit_orderer"
								onkeyup="cky(this)" />
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
							<label for="" class="col-xs-4 control-label">发货数量</label>
							<div class="col-xs-8">
								<input type="text" id="total_commodity_num" value="" class="form-control" disabled="disabled"/>
							</div>
						</div>
						
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">金额</label>
							<div class="col-xs-8">
								<input type="text" id="total_commodity_price" value="" class="form-control" disabled="disabled"/>
							</div>
						</div>
					</div>
				</div>
			<div class="row jl-title">
				<span>商品</span> <b class="r_f" style="margin-top: 13px;">
					<button type="button" class="btncss jl-btn-importent"
						onclick="goodsAdd()">新增</button>
				</b>

			</div>


			<div id="edit_goodDiv"></div>

			<div class="row jl-title">
				<span>其他</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">部门</label>
							<div class="col-xs-8">
								<select id="department_id" class="form-control" name="departmentId" >
									<option value="-1" selected="selected">--请选择--</option>
								
								</select>
							</div>
							
						</div>
						
						<!--<div class="form-group">
							<label for="" class="col-xs-4 control-label">审核人</label>
							<div class="col-xs-8">
								<input type="text" value="" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">分支机构</label>
							<div class="col-xs-8">
								<input type="text" value="" class="form-control"/>
							</div>
						</div>-->
						<div class="form-group">
						<label for="" class="col-xs-4 control-label">摘要</label>
						<div class="col-xs-8">
							<input type="text" value="" class="form-control"
								id="edit_summary" onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">业务员</label>
						<div class="col-xs-8">
							<select id="person_id" class="form-control" name="personId" >
							 	<option value="-1" selected="selected">--请先选择部门--</option>
								
						 	</select>
						</div>
					</div>
					<!-- <div class="form-group">
							<label for="" class="col-xs-4 control-label">制单人</label>
							<div class="col-xs-8">
								<input type="text" value="" class="form-control" id="anb"/>
							</div>
						</div>-->
					
				</div>
			</div>
			<div class="text-danger">注：该页面所有字段均为必填</div>

		</form>

	</div>


	<!--作废订单提示框，请于JS配置内容-->
	<div id="alertDiv" style="display: none;">
		<div class="container">
			<article class="text-center" style="line-height: 65px;"> </article>
			<div class="form-group">
				<div class="col-xs-12 text-center">
					<button type="button" class="btncss jl-btn-importent">确定(3s)</button>
					<button type="button" class="btncss jl-btn-defult">取消</button>
				</div>
			</div>
		</div>
	</div>

</body>

<script>

		let goodsIndext=0;
        $(function(){
            getSupctoMsgByCustomerOrSupplier();
            getAllShippingMode();
            //getAllSettlementType();

		})
	$("#edit_payType").on('change',function(){
		if($(this).val()==1){
			$("#edit_advance_scale_div").removeClass("hidden");
			$("#edit_advance_scale").removeClass("hidden");
			
		}else{
			$("#edit_advance_scale_div").addClass("hidden");
			$("#edit_advance_scale").addClass("hidden");
		}
	})
	
	$("#edit_is_specimen").on('change',function(){
		
		$("#edit_goodDiv .salesOrderCommodity").each(function(index, val){
			//是 金额以及税额都为0
			if($("#edit_is_specimen").val()=="2"){
				$(val).find(".edit_deliverGoodsMoney").val(0);
				$(val).find(".edit_deliverGoodsMoney").attr("disabled","disabled");
				$(val).find(".edit_taxesMoney").val(0);
				$(val).find(".edit_taxesMoney").attr("disabled","disabled");
			}
			//不是
			else{
				if(orderIsPlanOrder==0){
					$(val).find(".edit_deliverGoodsMoney").val("");
					//$(val).find(".edit_deliverGoodsMoney").removeAttr("disabled");
				}
				
				$(val).find(".edit_taxesMoney").val("");
				//$(val).find(".edit_taxesMoney").removeAttr("disabled");
				onkeyUpBindEach();
			}
		})
				
		
			
	})
	
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
							"page":1,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": $("#query_supctoId").val(),
							"isSpecimen":$("#query_isSpecimen").val()
								
						});
					},
					"url": "<%=basePath%>sales/salesOrder/getSalesOrderMsg"
							},

							"aoColumns" : [
								
									{
										"mData" : "identifier",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											if(row.breakCode!=null&&row.breakCode>0){
												return '<td><span class="look-span" onclick="salesOrderDetail('
												+ row.id
												+ ')">' + data + '-'+row.breakCode+'</span></td>';
											}
											else{
												return '<td><span class="look-span" onclick="salesOrderDetail('
												+ row.id
												+ ')">'
												+ data
												+ '</span></td>';
											}
											
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
										"sWidth" : "10%",
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
 											if(data!=null&&data!=""){
												return getSmpFormatDateByLong(data, false);
											}else{
												return "";
												}
											
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
											case 32:
												return "未出库";
												break;
											case 33:
												//是app订单
												if(row.isAppOrder!=null&&row.isAppOrder==2){
													if(row.isReturnGoods==1){
														return "申请退货中";
													}
													else if(row.isReturnGoods==2){
														return "待退货入库";
													}
													else if(row.isReturnGoods==3){
														return "已退货入库";
													}
													else{
														return "已出库";
													}
												}
												else{
													return "已出库";
												}	
												
												
												break;
											case 34:
												return "作废审核中";
												break;
											case 35:
												return "待备货";
												break;
											default:
												break;
											}
										}

									},

									{
										"mData" : "isAppOrder",
										"bSortable" : false,
										"sWidth" : "20%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											if(data!=null&&data==2){
												return '<td>是</td>'
											}
											else{
												return '<td>否</td>'
											}			
										}
									},

									{
										"mData" : "id",
										"bSortable" : false,
										"sWidth" : "20%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											if(row.state==1||row.state==3){
												return '<td><input type="button" class="btncss edit"'
												+ 'onclick="salesOrderEdit('
												+ data
												+ ')" value="编辑" />'
												+ '<input type="button" class="btncss edit" onclick=\'salesOrderDeliver('
												+JSON.stringify(row)+')\' value="送审" />'
												+'<input type="button" class="btncss edit" onclick="salesOrderDel(' + data + ')" value="删除" /></td>'
											}
											else if(row.state==4 || row.state==5 || row.state==9 || row.state==11 ||row.state==25){
												return '<td><input type="button" class="btncss edit" onclick=\'salesOrderStop('+JSON.stringify(row)+')\' value="作废" /></td>'
											}else{
												return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail('
												+data
												+')" value="详情" /></td>'
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
		
		/*部门下拉框赋值 */
		$.ajax({
			url :'<%=basePath%>/basic/department/getAllDepartment' ,
			type : "POST",
			dataType : "json",
			data: {},
			success : function(data) {
				$("#department_id").empty();
				if(data.length==0){
					$("#department_id").append('<option value="-1" selected="selected">--暂无部门信息，请去添加--</option>');
				}
				else{
					$("#department_id").append('<option value="-1" selected="selected">--请选择--</option>');
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#department_id").append(option);
						
					}
				}
				
			}
		});
	});
		
		
		
		latdate("#effective_date");
		latdate("#send_time");
		
		
		
		
		
		/*刷新页面，查看系统是否有新的计划单生成，如果有，就刷新datetable*/
		function salesOrderRefresh() {
			laysuccess("已生成销售订单，请至销售订单管理页面查看相应订单");
		}

		/*采用采购这个计划单，点击这个按钮后，本订单将生成销售订单，并出现在销售订单列表，并于销售订单中消失。*/
		function salesOrderDeliver(row) {
			if(row.payment==null){
				laywarn("请先完善单据后再送审!");
				return;
			}
			publicMessageLayer("将本订单送审", function() {
				$.ajax({
					url: '<%=basePath%>sales/salesOrder/judgeIsSplitOrder',
					type: "POST",
					dataType: "json",
					data:{
						"salesOrderId":row.id
					},
					async: false,
					cache: false,
					success: function(data) {
						//不需要进行分单
						if(data.success) {
							$.ajax({
								url: '<%=basePath%>sales/salesOrder/submitSalesOrder',
								type: "POST",
								dataType: "json",
								data:{
									"salesOrderId":row.id,
									"identifier":row.identifier,
									"flag":1
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
						}
						//需要进行分单
						else {
							layer.open({
								type: 1,
								title: "提示",
								closeBtn: 1,
								area: ['400px', '150px'],
								content: "<div class='text-center' style='height: 50px;line-height: 67px;'>" + data.msg + "</div>",
								btn: ['确认', '取消'],
								yes: function(index) {
									$.ajax({
										url: '<%=basePath%>sales/salesOrder/submitSalesOrder',
										type: "POST",
										dataType: "json",
										data:{
											"salesOrderId":row.id,
											"identifier":row.identifier,
											"flag":1
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
								}
							});
							
						}
						layer.close(index);
					}
				});
				
			})
		}
		
		
		
		$("#department_id").change(function(){
			if($("#department_id").val()==-1){
				$("#person_id").empty();
				$("#person_id").append('<option value="-1" selected="selected">--请先选择部门--</option>');
			}
			else{
				person(0);
			}
			
		});
		
		function person(personId){
			/* 业务员下拉框赋值 */
			$.ajax({
				url :'<%=basePath%>/basic/person/getAllPersonByDepartmentIdAndBusiness' ,
				type : "POST",
				dataType : "json",
				data: {
					"departmentId" : $("#department_id").val()
				},
				success : function(data) {
					$("#person_id").empty();
					if(data.length==0){
						$("#person_id").append('<option value="-1" selected="selected">--该部门暂无业务员，请去添加--</option>');
					}
					else{
						$("#person_id").append('<option value="-1" selected="selected">--请选择--</option>');
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
							$("#person_id").append(option);
							
						}
						if(personId>0){
							$("#person_id").val(personId);
						}
					}
					
				}
			});
		}
		var updateOrAdd=0;//1:add 2:update
		var updateOrderId=0;//编辑时的订单id

		/*新增*/
		function salesOrderAdd() {
			updateOrAdd=1;
			selectedCommodity={};//记录哪一个select选择了哪一个商品规格
	    	commodityIsSelected={};//商品规格是否被选择。
			$("#edit_generateDate").addClass("hidden");
			$("#edit_generateDate_div").addClass("hidden");
			$("#edit_identifier").addClass("hidden");
			$("#edit_identifier_div").addClass("hidden");
			goodsAdd();
			layer.open({
				type: 1,
				title: "新增销售订单",
				closeBtn: 1,
				area: ['100%', ''],
				content: $("#editDiv"),
				btn: ['提交','取消'],
				yes:function(index){
					if(!decideInputAndSelectHasValue()){
						laywarn("表单未填写完整，请完善后再提交");	
						return;
					}
					var flag=true;
					$("#edit_goodDiv .salesOrderCommodity").each(function(index, val){

		    			if($(val).find(".edit_deliverGoodsNum").val()-0==0){
		    				flag = false;
		    			}
		    		});
					if(!flag){
						laywarn("发货数量不能为0。");
						return false;
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
						url: '<%=basePath%>sales/salesOrder/addSalesOrder?planOrTable='+2,
						type: "POST",
						dataType: "json",
						data:{
							"salesOrder":JSON.stringify(salesOrderDataJSON())
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
				end: function(index, layero){
					layer.close(index);
					$("#edit_goodDiv").html("");
					clearForm("editDiv","");
					clearSearchableSelect('edit_supctoId');
					selectedCommodity={};//记录哪一个select选择了哪一个商品规格
			    	commodityIsSelected={};//商品规格是否被选择。
  				}
			});
			
			
		}
		let orderIsPlanOrder=0;//订单是否从计划单而来 0表示不是，1表示是
		/*修改*/
		function salesOrderEdit(id) {
			updateOrAdd=2;
			updateOrderId=id;
			layer.open({
				type: 1,
				title: "编辑销售订单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					if(!decideInputAndSelectHasValue()){
						laywarn("表单未填写完整，请完善后再提交");	
						return;
					}
					var flag=true;
					$("#edit_goodDiv .salesOrderCommodity").each(function(index, val){

		    			if($(val).find(".edit_deliverGoodsNum").val()-0==0){
		    				flag = false;
		    			}
		    		});
					if(!flag){
						laywarn("发货数量不能为0。");
						return false;
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
						url: '<%=basePath%>sales/salesOrder/editSalesOrder',
						type: "POST",
						dataType: "json",
						data:{
							"salesOrder":JSON.stringify(salesOrderDataJSON())
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
				end: function(index, layero) {
					layer.close(index);
					$("#edit_goodDiv").html("");
					clearForm("editDiv", "");
					clearSearchableSelect('edit_supctoId');
					$("#edit_supctoId_input").addClass("hidden");
					$("#edit_supctoId").removeClass("hidden");
					$("#edit_supctoId").parent().removeClass("hidden");
					selectedCommodity={};//记录哪一个select选择了哪一个商品规格
			    	commodityIsSelected={};//商品规格是否被选择。
				}
			});
			
			
			
			$("#edit_goodDiv").html("");
			ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectOrderDetailById",{"id":id},function(data){
				$("#edit_sales_id").val(data.id);
				$("#edit_is_specimen").val(data.isSpecimen);
				$("#edit_generateDate").removeClass("hidden");
				$("#edit_generateDate_div").removeClass("hidden");
				$("#edit_generateDate").val(getSmpFormatDateByLong(data.createTime,true));
				if(data.supctoId!=null){
					$("#edit_supctoId_input").addClass("hidden");
					$("#edit_supctoId").removeClass("hidden");
					SearchableSelectsetValue("#edit_supctoId",data.supctoId);
				}
				else{
					$("#edit_supctoId_input").removeClass("hidden");
					$("#edit_supctoId").addClass("hidden");
					$("#edit_supctoId").parent().addClass("hidden");
					$("#edit_supctoId_input").val("无");
				}
				
				$("#effective_date").val(getSmpFormatDateByLong(data.endValidityTime,false));
				$("#edit_deliver_goods_place").val(data.deliverGoodsPlace);
				$("#edit_receipt_goods_place").val(data.receiptGoodsPlace);
				$("#edit_consignee").val(data.consignee);
				if(data.payment==null){
					$("#edit_payType").val(-1);
				}else{
					$("#edit_payType").val(data.payment);
				}
				
				switch (data.payment) {
				case 1:
					$("#edit_advance_scale_div").removeClass("hidden");
					$("#edit_advance_scale").removeClass("hidden");
					$("#edit_advance_scale").val(data.advanceScale);
					break;
				case 2:
					
					$("#edit_advance_scale_div").addClass("hidden");
					$("#edit_advance_scale").addClass("hidden");
					break;
				case 3:
					
					$("#edit_advance_scale_div").addClass("hidden");
					$("#edit_advance_scale").addClass("hidden");
					break;
				default:
					break;
				}
				$("#edit_identifier").removeClass("hidden");
				$("#edit_identifier_div").removeClass("hidden");
				$("#edit_identifier").val(data.identifier);
				if(data.shippingModeId == null){
					$("#edit_transportationMode").val(-1);
				}else{
					$("#edit_transportationMode").val(data.shippingModeId);
				}
				
				
				$("#edit_phone").val(data.phone);
				$("#edit_orderer").val(data.orderer);
				$("#edit_fax").val(data.fax);			
				$("#department_id").val(data.personDepartmentId);	
				
				$("#edit_summary").val(data.summary);
				person(data.personId);
				
				var deliverGoodsNum=0;
				var deliverGoodsMoney=0.0;
				goodsIndext=1;
				for(var i=0;i<data.salesOrderCommodities.length;i++){
					
					goodsAdd();
					selectedCommodity[(i+1)+""]=data.salesOrderCommodities[i].commoditySpecification.id;
					commodityIsSelected[data.salesOrderCommodities[i].commoditySpecification.id+""]=1;
					
					$("#edit_goodDiv"+(i+1)+" .edit_sales_commodity_id").val(data.salesOrderCommodities[i].id);
					console.log("data.salesPlanOrderId:"+data.salesPlanOrderId);
					//是从销售计划单生成的销售订单
					if(data.salesPlanOrderId!=null&&data.salesPlanOrderId>0){
						orderIsPlanOrder=1;
						$("#edit_goodDiv"+(i+1)+" .edit_goods_name_input_div").removeClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .edit_goods_name_input").removeClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .inputValue").addClass("hidden");
						SearchableSelectsetValue("#edit_goodDiv"+(i+1)+" .edit_goods_name",data.salesOrderCommodities[i].commoditySpecificationId);
						$("#edit_goodDiv"+(i+1)+" .edit_goods_name_input").val(data.salesOrderCommodities[i].commoditySpecification.commodity.name);
						$("#edit_goodDiv"+(i+1)+" .edit_deliverGoodsMoney").attr("disabled","disabled");
						$("#edit_goodDiv"+(i+1)+" .edit_deliverGoodsNum").attr("disabled","disabled");
					}
					else{
						orderIsPlanOrder=0;
						SearchableSelectsetValue("#edit_goodDiv"+(i+1)+" .edit_goods_name",data.salesOrderCommodities[i].commoditySpecificationId);
						//$("#edit_goodDiv"+(i+1)+" .edit_deliverGoodsMoney").removeAttr("disabled");
						$("#edit_goodDiv"+(i+1)+" .edit_deliverGoodsNum").removeAttr("disabled");
						$("#edit_goodDiv"+(i+1)+" .edit_goods_name_input_div").addClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .edit_goods_name_input").addClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .inputValue").removeClass("hidden");
					}
					
					$("#edit_goodDiv"+(i+1)+" .edit_commodity_unit").val(data.salesOrderCommodities[i].commoditySpecification.baseUnitName);
					$("#edit_goodDiv"+(i+1)+" .edit_commodity_specifications_id").val(data.salesOrderCommodities[i].commoditySpecification.specificationName);
					$("#edit_goodDiv"+(i+1)+" .edit_commodity_identifier").val(data.salesOrderCommodities[i].commoditySpecification.specificationIdentifier);
					$("#edit_goodDiv"+(i+1)+" .edit_discount").val(data.salesOrderCommodities[i].discount);
					$("#edit_goodDiv"+(i+1)+" .edit_taxes").val(data.salesOrderCommodities[i].taxes);
					$("#edit_goodDiv"+(i+1)+" .edit_deliverGoodsMoney").val(data.salesOrderCommodities[i].deliverGoodsMoney);
					$("#edit_goodDiv"+(i+1)+" .edit_remark").val(data.salesOrderCommodities[i].remark);
					$("#edit_goodDiv"+(i+1)+" .edit_deliverGoodsNum").val(data.salesOrderCommodities[i].deliverGoodsNum);
					$("#edit_goodDiv"+(i+1)+" .edit_warehouse_id").val(data.salesOrderCommodities[i].warehouseId);
					deliverGoodsNum+=data.salesOrderCommodities[i].deliverGoodsNum;
					deliverGoodsMoney+=data.salesOrderCommodities[i].deliverGoodsMoney;
					
					console.log("oldUnitPrice:"+data.salesOrderCommodities[i].oldUnitPrice);
					//没有申请特价
					if(data.salesOrderCommodities[i].isSpecialOffer==1){
						$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice").removeClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice .edit_unitPrice").removeClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice").addClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").addClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice .edit_unitPrice").val(data.salesOrderCommodities[i].unitPrice);
						if(data.salesOrderCommodities[i].oldUnitPrice!=null&&data.salesOrderCommodities[i].oldUnitPrice>0){
							$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice").removeClass("hidden");
							$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").removeClass("hidden");
							$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice").addClass("hidden");
							$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice .edit_unitPrice").addClass("hidden");
							$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").val(data.salesOrderCommodities[i].unitPrice);
							
							$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice .edit_unitPrice").attr("attr-flag","1");
							$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice .edit_unitPrice").attr("disabled","disabled");
							let $parent=$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").parent();
							let $label=$parent.find("label");
							
							$label.text("申请特价");
						}
						
					}
					//申请特价
					else{
						$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice").removeClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").removeClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice").addClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .commodity_unitPrice .edit_unitPrice").addClass("hidden");
						$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").val(data.salesOrderCommodities[i].unitPrice);

						$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").attr("attr-flag","2");
						$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").removeAttr("disabled");
						
						let $parent=$("#edit_goodDiv"+(i+1)+" .supcto_unitPrice .edit_unitPrice").parent();
						let $label=$parent.find("label");
						$label.text("使用原价");
						oldValue=data.salesOrderCommodities[i].oldUnitPrice;
					}
					
					$("#edit_goodDiv"+(i+1)+" .edit_batch_number").val(data.salesOrderCommodities[i].batchNumber);
					$("#edit_goodDiv"+(i+1)+" .edit_taxesMoney").val(data.salesOrderCommodities[i].taxesMoney);
				} 
				$("#total_commodity_num").val(deliverGoodsNum);
				$("#total_commodity_price").val(deliverGoodsMoney);
			})
			
		}
		
		/*详情*/
		function salesOrderDetail(id) {
			<%-- $("#allGoodsDiv_look").html("");
			ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectOrderDetailById",{"id":id},function(data){
				
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
				$(".look_receipt_goods_place").html(data.receiptGoodsPlace);
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
				$(".look_person_id").html(data.personName);
				if(data.reviewerIdentifier == null || data.reviewerName == null){
					$(".look_reviewer_id").html("");
				}else{
					$(".look_reviewer_id").html(data.reviewerIdentifier+"("+data.reviewerName+")");
				}
				if(data.revokeLeaderIdentifier == null || data.revokeLeaderName == null){
					$(".look_revokeLeader_id").html("");
				}else{
					$(".look_revokeLeader_id").html(data.revokeLeaderIdentifier+"("+data.revokeLeaderName+")");
				}
				if(data.revokeWarehouseIdentifier == null || data.revokeWarehouseName == null){
					$(".look_revokeWarehouse_id").html("");
				}else{
					$(".look_revokeWarehouse_id").html(data.revokeWarehouseIdentifier+"("+data.revokeWarehouseName+")");
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
				var allTaxesMoney=0;//总税额
				for(var i=0;i<data.salesOrderCommodities.length;i++){
					goodsAdd_look(i+1);
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
					$("#look_goodDiv"+(i+1)+" .look_batch_number").html(data.salesOrderCommodities[i].batchNumber);
					$("#look_goodDiv"+(i+1)+" .look_taxes_money").html(data.salesOrderCommodities[i].taxesMoney);
					allTaxesMoney+=data.salesOrderCommodities[i].taxesMoney;
				} 
				$(".look_all_deliver_goods_num").html(allDeliverGoodsNum);
				$(".look_all_deliver_goods_money").html(allDeliverGoodsMoney.toFixed(2));
				$(".look_all_taxes_money").html(allTaxesMoney.toFixed(2));
			}) --%>
			
			$("#lookDiv").html("");
			$.ajax({
				type: "post",
				url: "<%=basePath%>sales/salesOrder/salesOrderDetail",
				dataType : "json",
				data: {
					"id" : id,
					"type":1
				},
				success: function(res) {
					let bill = new DetailBill(res);
					let $content = bill.toPrint();
					$("#lookDiv").html($content);
				}
			});
			
			layer.open({
				type: 1,
				title: "销售订单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#lookDiv"),
				btn: ['关闭']
			});
		}
		
		/*删除*/
		function salesOrderDel(id) {
			publicMessageLayer("删除该订单", function() {
				$.ajax({
					url: '<%=basePath%>sales/salesOrder/deletePurchaseOrder',
					type: "POST",
					dataType: "json",
					data:{
						"id":id
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
			})
		}
		
		
		/*添加商品*/

		function goodsAdd(){
			let goodsStr=`<div class="row jl-panel salesOrderCommodity" id="edit_goodDiv`+goodsIndext+`">
			<span class="close_span" onclick="goodsDel(this)"><i class="fa fa-times"></i></span>
						<div class="col-xs-6">
						<input type="text" value="" class="form-control edit_sales_commodity_id hidden" />
						<input type="text" value="" class="form-control edit_warehouse_id hidden" />
							<div class="form-group">
								<label for="edit_goods_name`+goodsIndext+`" class="col-xs-4 control-label">货品名称</label>
								<div class="col-xs-8 edit_goods_name_input_div hidden">
									<input type="text" id="" class="form-control edit_goods_name_input hidden" disabled/>
								</div>
								<div class="col-xs-8 inputValue" attr-id="edit_goodDiv`+goodsIndext+`">
									<select id="edit_goods_name`+goodsIndext+`" class="form-control edit_goods_name" >					   
									</select>
								</div>
							</div>
							
							
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单位</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_commodity_unit" readonly="readonly" placeholder="请先选择商品名称"/>
								</div>
							</div>
							

							
							
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">折扣%</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_discount" maxlength="3" onkeyup="pressInteger1(this)"/>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">税率</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_taxes" onkeyup="getAmountOfTax(this)"/>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">金额</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_deliverGoodsMoney"  disabled="disabled" placeholder="请先填写发货数量"/>
								</div>
							</div>

							<div class="form-group">
								<label for="" class="col-xs-4 control-label">批号</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_batch_number" onkeyup="cky(this)"/>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">规格</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_commodity_specifications_id" readonly="readonly" placeholder="请先选择商品名称"/>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">规格编号</label>
								<div class="col-xs-8">
								<input class="form-control edit_commodity_identifier" type="text" name="" id="" value=""
								readonly="readonly" placeholder="请先选择商品名称" />
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">发货数量</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_deliverGoodsNum" onkeyup="onkeyUpBind(this)" maxlength="9"/>
								</div>
							</div>

							
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单价</label>
								<div class="col-xs-8">
									<div class="commodity_unitPrice">
										<input type="text" class="form-control edit_unitPrice" disabled="disabled" attr-flag="1" onkeyup="onkeyUpBind(this)">
						    		</div>
									<div class="input-group supcto_unitPrice hidden">
										<input type="text" class="form-control edit_unitPrice hidden" aria-label="..." disabled="disabled" attr-flag="1" onkeyup="onkeyUpBind(this)">
									    <span class="input-group-addon edit_isSpecialOffer_span" onmousedown ="specialOffer(this)">
									        <label for="specialOffer`+goodsIndext+`" aria-label="...">申请特价</label>
									    </span>
						    		</div>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">税额</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_taxesMoney" disabled="disabled" placeholder="请先填写税率、发货数量"/>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">备注</label>
								<div class="col-xs-8">
									<input type="text" value="" class="form-control edit_remark" onkeyup="cky(this)" maxlength="100"/>
								</div>
							</div>
							
							
						</div>
					</div>`;
					
			
			$("#edit_goodDiv").append(goodsStr);
			$("#specialOffer"+goodsIndext+"").removeAttr("checked");
            getAllCommodity("#edit_goods_name"+goodsIndext);
			$("#edit_goods_name"+goodsIndext).searchableSelect();
			
			
			//是 金额以及税额都为0
			if($("#edit_is_specimen").val()==2){
				console.log("if")
				console.log("goodsIndext",goodsIndext);
				$("#edit_goodDiv"+goodsIndext).find(".edit_deliverGoodsMoney").val(0);
				//$("#edit_goodDiv"+goodsIndext).find(".edit_deliverGoodsMoney").attr("disabled","disabled");
				$("#edit_goodDiv"+goodsIndext).find(".edit_taxesMoney").val(0);
				//$("#edit_goodDiv"+goodsIndext).find(".edit_taxesMoney").attr("disabled","disabled");
			}
			/* //不是
			else {
				console.log("else不是样品单")
				$("#edit_goodDiv"+goodsIndext+" .edit_deliverGoodsMoney").removeAttr("disabled");
				$("#edit_goodDiv"+goodsIndext+" .edit_taxesMoney").removeAttr("disabled");
				//$("#edit_goods_name"+goodsIndext).find(".edit_deliverGoodsMoney").val("");
				//$("#edit_goods_name"+goodsIndext).find(".edit_taxesMoney").val("");
				
			} */
			

			goodsIndext++;
			
			
		}
		
		
		/* 查看详情时的商品添加 */
		function goodsAdd_look(index){
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

				<!--<div class="form-group">
					<label for="" class="col-xs-4 control-label">返货数量:</label>
					<div class="col-xs-8">
					</div>
				</div>-->

				<div class="form-group">
					<label for="" class="col-xs-4 control-label">折扣%:</label>
					<div class="col-xs-8 look_discount">
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">税率:</label>
					<div class="col-xs-8 look_taxes">
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">金额:</label>
					<div class="col-xs-8 look_deliver_goods_money">
					</div>
				</div>
				<!--<div class="form-group">
					<label for="" class="col-xs-4 control-label">签收金额:</label>
					<div class="col-xs-8">
					</div>
				</div>-->
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">批号:</label>
					<div class="col-xs-8 look_batch_number">
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
					<label for="" class="col-xs-4 control-label">发货数量:</label>
					<div class="col-xs-8 look_deliver_goods_num">
					</div>
				</div>
				<!--<div class="form-group">
					<label for="" class="col-xs-4 control-label">签收数量:</label>
					<div class="col-xs-8">
					</div>
				</div>-->

				<div class="form-group">
					<label for="" class="col-xs-4 control-label">单价:</label>
					<div class="col-xs-8 look_unit_price">
					</div>
				</div>

				<div class="form-group">
					<label for="" class="col-xs-4 control-label">税额:</label>
					<div class="col-xs-8 look_taxes_money">
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">备注:</label>
					<div class="col-xs-8 look_remark">
					</div>
				</div>
				<!--<div class="form-group">
					<label for="" class="col-xs-4 control-label">折损金额:</label>
					<div class="col-xs-8">
					</div>
				</div>-->

			</div>
		</div>`;
		
		$("#allGoodsDiv_look").append(goodsDiv);
		}
		
		/*商品*/
		function goodsDel(thisspan){
			var selectparentId =$(thisspan).parent().attr("id");
    		var num=selectparentId.substring(12,selectparentId.length)+"";
    		
	    	
			if($("#edit_goodDiv>div").length>1){
				commodityIsSelected[selectedCommodity[num]]=0;
				delete(selectedCommodity[num]);
				$(thisspan).parent().remove();
			}else{
				layfail("商品不能为空");
			}
			
		}
		
		function salesOrderStop(row){
			var state=0;
			if(row.state==4){
				state=34;
			}else if(row.state==11||row.state==25){
				state=7;
			}else{
				state=6;
			}
			layerTwoConfrim($("#alertDiv"), "提示框", "确定作废该订单?",function(){
				var ids=[row.id+""];
				
				/*这是一个回调函数，请在此处书写点击作废的确定后需要执行的代码*/
				$.ajax({
					url: '<%=basePath%>sales/salesOrder/updateStateByIds',
					type: "POST",
					dataType: "json",
					data:{
						"ids":ids,
						"state":state,
						"isCheck":0,
						"reviewerType":0,
						"msg":"操作成功，已送审"
					},
					async: false,
					cache: false,
					traditional:true,
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
			});
		}
		
		let oldValue;
		/*特价改变事件*/
		function specialOffer(thisdiv){
			let $parent=$(thisdiv).parent();
			let $price=$parent.find("input[type='text']");
			let $label=$parent.find("label");
			
			switch ($price.attr("attr-flag")) {
			case "1":
				$price.removeAttr("disabled");
				$label.text("使用原价");
				$price.attr("attr-flag","2");
				oldValue=$price.val();
				onkeyUpBind(thisdiv);
				break;
			case "2":
				
				$price.attr("attr-flag","1");
				$price.attr("disabled","disabled");
				$label.text("申请特价");
				$price.val(oldValue+"");
				onkeyUpBind(thisdiv);
				break;
			default:
				break;
			}
			return ;
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

        //给添加时需要选择的客户下拉框赋值
        function getSupctoMsgByCustomerOrSupplier(){
            $.ajax({
                url: '<%=basePath%>basic/supctoManager/selectAllCustomerByCustomerOrSupplier',
                type: "POST",
                dataType: "json",
                data:{
                    "customerOrSupplier":1
                },
                async: false,
                cache: false,
                success: function(data) {
                    $("#edit_supctoId").html("");
                    if(data.length==0){
                        $("#edit_supctoId").append("<option value='-1' selected>--暂无数据，请到供应商页面进行添加--</option>");
                    }
                    else{
                        $("#edit_supctoId").append("<option value='-1' selected>--请选择--</option>");
                        for(var i=0;i<data.length;i++){
                            var option = $("<option value='"+data[i].id+"'>"
                                + data[i].name + "</option>");
                            $("#edit_supctoId").append(option);
                        }
                    }
                }
            });
            $('#edit_supctoId').searchableSelect();
            $("#edit_supctoId").next().css("z-index","2");
        }
        
        /* 获取所有结算方式*/
        <%-- function getAllSettlementType(){
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
        } --%>

        var commodityMsgList=[];//保存查出来的商品
    	var selectedCommodity={};//记录哪一个select选择了哪一个商品规格
    	var commodityIsSelected={};//商品规格是否被选择。
        /* 获取所有商品信息*/
        function getAllCommodity(idstr){
        	//commodityIsSelected={};//还原
    		commodityMsgList=[];//还原
            $.ajax({
                url: '<%=basePath%>basic/goods/commodity/saleOrderGetHasInventoryCommodityByStateAndIsDelete',
                type: "POST",
                dataType: "json",
                async: false,
                cache: false,
                data:{
                	"updateOrAdd":updateOrAdd,
        			"orderId":updateOrderId
                },
                success: function(data) {
                	commodityMsgList=[];
					commodityMsgList=data;
					 $(idstr).html("")
                    $(idstr).html("<select class='form-control'></select>")
                    if(data.length==0){
                        $(idstr).append("<option value='-1' selected>--暂无数据，请到商品页面进行添加。--</option>");
                    }
                    else{
                        $(idstr).append("<option value='-1' selected>--请选择商品--</option>");
                        for(var i=0;i<data.length;i++){
                            var option = $("<option value='"+data[i].id+"'>"
                                + data[i].commodity.name+" "+data[i].specificationName + "</option>");
                            $(idstr).append(option);
                        }

                    }
                }
            });
        }
    	
        /* 客户选择框的值改变事件 */
    	function selectSupctoMsg(e,selectValId){	
        	 if(selectValId>0){
        			//获取采购商品的信息，添加到采购订单的商品信息里
            		$("#edit_goodDiv .salesOrderCommodity").each(function(index, val){
            			//说明该商品选择框选择的有商品	
            			if($(val).find(".edit_goods_name").val()>0){
            				$.ajax({
				                url: '<%=basePath%>basic/supctoCommodity/selectPriceByCommoditySpIdAndSupId',
				                type: "POST",
				                dataType: "json",
				                async: false,
				                cache: false,
				                data:{
				                	"supctoId":selectValId,
				                	"commodityId":$(val).find(".edit_goods_name").val()
				                },
				                success: function(data) {
				                	
				                	if(commodityMsgList.length==0){
				                		
				                	}
				                	else{
				                		
				                		//客户资料里设置的有该商品的销售价格
					                	if(data!=null&&data.price!=null){
					                		
					                		$(val).find(".supcto_unitPrice").removeClass("hidden");
					                		$(val).find(".supcto_unitPrice .edit_unitPrice").removeClass("hidden");
					                		$(val).find(".commodity_unitPrice .edit_unitPrice").addClass("hidden");
					                		$(val).find(".commodity_unitPrice").addClass("hidden");
					                		$(val).find(".supcto_unitPrice .edit_unitPrice").val(data.price);
					                	}
					                	//客户资料里设置的没有该商品的销售价格，显示商品建立时填写的一般销售价格
					                	else{
					                		
					                		$(val).find(".commodity_unitPrice").removeClass("hidden");
					                		$(val).find(".commodity_unitPrice .edit_unitPrice").removeClass("hidden");
					                		$(val).find(".supcto_unitPrice .edit_unitPrice").addClass("hidden");
					                		$(val).find(".supcto_unitPrice").addClass("hidden");
					                		for(var i=0;i<commodityMsgList.length;i++){
					                			if(commodityMsgList[i].id==$(val).find(".edit_goods_name").val()){
					                				$(val).find(".commodity_unitPrice .edit_unitPrice").val(commodityMsgList[i].baseCommonlyPrice);
					                			}
					                		}
					                		
					                	}
				                	}
				                	
				                }
				            });	
            			}
            			else{
            				
            				$(val).find(".commodity_unitPrice").removeClass("hidden");
	                		$(val).find(".commodity_unitPrice .edit_unitPrice").removeClass("hidden");
	                		$(val).find(".supcto_unitPrice .edit_unitPrice").addClass("hidden");
	                		$(val).find(".supcto_unitPrice").addClass("hidden");
	                		$(val).find(".commodity_unitPrice .edit_unitPrice").attr("placeholder","请先选择商品");
            			}
            			
            		});
        	}
        	else{
        		//获取采购商品的信息，添加到采购订单的商品信息里
        		$("#edit_goodDiv .salesOrderCommodity").each(function(index, val){
        			
        				$(val).find(".commodity_unitPrice").removeClass("hidden");
                		$(val).find(".commodity_unitPrice .edit_unitPrice").removeClass("hidden");
                		$(val).find(".supcto_unitPrice .edit_unitPrice").addClass("hidden");
                		$(val).find(".supcto_unitPrice").addClass("hidden");
                		$(val).find(".commodity_unitPrice .edit_unitPrice").attr("placeholder","请先选择客户");
        		
        		});
        	}
        	 onkeyUpBindEach();
        }
    	
        /* 商品选择框的值改变事件 */
    	function selectCommodityMsg(e,selectValId){	
    		var selectparentId =e.element.parents(".col-xs-8").attr("attr-id");
    		var num=selectparentId.substring(12,selectparentId.length)+"";
    		
    		if(selectValId>0){
    			for(var i=0;i<commodityMsgList.length;i++){
    				if(commodityMsgList[i].id==selectValId){
    					
    					//先判断现在选择的商品规格与之前选择的是否是一样的。
    					if(selectedCommodity[num]!=selectValId){
    						
    						//如果不一样，则先判断选择的这个规格是否已经被选择。
    						//1表示被选中，0表示未被选中
    						if(commodityIsSelected[selectValId]==1){
    							//若被选择，则提示不能重复选择。
    							laywarn("该规格已被选中，请勿重复选择。");
    							SearchableSelectsetValue("#edit_goods_name"+num,-1);
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
    							$("#"+selectparentId+" .edit_commodity_specifications").val("");
    							$("#"+selectparentId+" .edit_commodity_unit").val("");
    							$("#"+selectparentId+" .edit_taxes").val("");
    							
    							$("#"+selectparentId+" .commodity_unitPrice").removeClass("hidden");
    	                		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").removeClass("hidden");
    	                		$("#"+selectparentId+" .supcto_unitPrice .edit_unitPrice").addClass("hidden");
    	                		$("#"+selectparentId+" .supcto_unitPrice").addClass("hidden");
    	                		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").val("");
    	                		$("#"+selectparentId+" .edit_warehouse_id").val("");
    	                		$("#"+selectparentId+" .edit_deliverGoodsNum").val("");
    							
    	                	
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
    							
    							$("#"+selectparentId+" .edit_commodity_specifications_id").val(commodityMsgList[i].specificationName);
    							$("#"+selectparentId+" .edit_commodity_identifier").val(commodityMsgList[i].specificationIdentifier);
    							$("#"+selectparentId+" .edit_commodity_specifications").val(commodityMsgList[i].specificationName);
    							$("#"+selectparentId+" .edit_commodity_unit").val(commodityMsgList[i].baseUnitName);
    							$("#"+selectparentId+" .edit_taxes").val(commodityMsgList[i].commodity.taxes);
    							$("#"+selectparentId+" .edit_warehouse_id").val(commodityMsgList[i].specWarehouseId);
    							$("#"+selectparentId+" .edit_deliverGoodsNum").val("");
    							if($("#edit_supctoId").val()!=null&&$("#edit_supctoId").val()>0){
    								console.log("supctoId",$("#edit_supctoId").val());
    								console.log("commodityId",selectValId);
    								 $.ajax({
    						                url: '<%=basePath%>basic/supctoCommodity/selectPriceByCommoditySpIdAndSupId',
    						                type: "POST",
    						                dataType: "json",
    						                async: false,
    						                cache: false,
    						                data:{
    						                	"supctoId":$("#edit_supctoId").val(),
    						                	"commodityId":selectValId
    						                },
    						                success: function(data) {
    						                	console.log("commodata",data);
    						                	//客户资料里设置的有该商品的销售价格
    						                	if(data.price!=null){
    						                		$("#"+selectparentId+" .supcto_unitPrice").removeClass("hidden");
    						                		$("#"+selectparentId+" .supcto_unitPrice .edit_unitPrice").removeClass("hidden");
    						                		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").addClass("hidden");
    						                		$("#"+selectparentId+" .commodity_unitPrice").addClass("hidden");
    						                		$("#"+selectparentId+" .supcto_unitPrice .edit_unitPrice").val(data.price);
    						                	}
    						                	//客户资料里设置的没有该商品的销售价格，显示商品建立时填写的一般销售价格
    						                	else{
    						                		$("#"+selectparentId+" .supcto_unitPrice").addClass("hidden");
    						                		$("#"+selectparentId+" .supcto_unitPrice .edit_unitPrice").addClass("hidden");
    						                		$("#"+selectparentId+" .commodity_unitPrice").removeClass("hidden");
    						                		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").removeClass("hidden");
    						                		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").val(commodityMsgList[i].baseCommonlyPrice);
    						                	}
    						                }
    						            });
    							}
    							else{
    								$("#"+selectparentId+" .supcto_unitPrice").addClass("hidden");
			                		$("#"+selectparentId+" .supcto_unitPrice .edit_unitPrice").addClass("hidden");
			                		$("#"+selectparentId+" .commodity_unitPrice").removeClass("hidden");
			                		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").removeClass("hidden");
			                		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").attr("placeholder","请先选择客户");
    							}

    	                		
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
    			$("#"+selectparentId+" .edit_commodity_specifications").val("");
    			$("#"+selectparentId+" .edit_commodity_unit").val("");
    			$("#"+selectparentId+" .edit_taxes").val("");
    			$("#"+selectparentId+" .edit_warehouse_id").val("");
    			
    			$("#"+selectparentId+" .commodity_unitPrice").removeClass("hidden");
        		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").removeClass("hidden");
        		$("#"+selectparentId+" .supcto_unitPrice .edit_unitPrice").addClass("hidden");
        		$("#"+selectparentId+" .supcto_unitPrice").addClass("hidden");
        		$("#"+selectparentId+" .commodity_unitPrice .edit_unitPrice").val("");
        		$("#"+selectparentId+" .edit_deliverGoodsNum").val("");

    		}
    		
    		 onkeyUpBindEach();	
    	}
        
    	/* 编辑时判断数据有没有填写完整 */
    	function decideInputAndSelectHasValue(){
    		var inputValue=true;
    		var selectValue=true;
    		$("#editDiv input[type='text']").each(function(index, val){	
    			if(!$(val).hasClass("hidden")){				
    				if($(val).val()==""&&$(val).attr("class")!="searchable-select-input"){
    				inputValue=false;
    				console.log("input:"+$(val).attr("class")+" "+$(val).attr("id"));
    				}	
    			}
    				
    		});	
    		$("#editDiv select").each(function(index, val){	
    			if($(val).val()==-1){
    				selectValue=false;
    				console.log("select:"+$(val).attr("class"));
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
    	function salesOrderDataJSON(){
    		var prepaidAmount;
    		if($("#edit_payType").val()==1){
    			prepaidAmount=$("#edit_advance_scale").val();
    		}
    		else{
    			prepaidAmount=null;
    		}
    		
    		//销售订单基础的信息
    		 var  salesOrderDataJSON={"id":$("#edit_sales_id").val(),"isSpecimen":$("#edit_is_specimen").val(),"createTimeString":$("#edit_generateDate").val(),"supctoId":$("#edit_supctoId").val(),"endValidityTimeString":$("#effective_date").val(),"deliverGoodsPlace":$("#edit_deliver_goods_place").val(),
    				"consignee":$("#edit_consignee").val(),"fax":$("#edit_fax").val(),"advanceScale":$("#edit_advance_scale").val(),"identifier":$("#edit_identifier").val(),"payment":$("#edit_payType").val(),"shippingModeId":$("#edit_transportationMode").val(),"phone":$("#edit_phone").val(),
    				"receiptGoodsPlace":$("#edit_receipt_goods_place").val(),"orderer":$("#edit_orderer").val(),"advanceScale":prepaidAmount,"summary":$("#edit_summary").val(),"personId":$("#person_id").val(),
    				"salesOrderCommodities":[]}; 
    		//获取销售商品的信息，添加到销售订单的商品信息里
    		$("#edit_goodDiv .salesOrderCommodity").each(function(index, val){
    			var unitPrice=0;
    			var isSpecialOffer=1;
    			$(val).find(".edit_unitPrice").each(function(index, val){
    				if(!$(val).hasClass("hidden")){
    					unitPrice=$(val).val();
    					isSpecialOffer=$(val).attr("attr-flag");
    				}
    			});
    			var salesOrderCommoditiesDataJSON={"id":$(val).find(".edit_sales_commodity_id").val(),"salesOrderId":$("#edit_sales_id").val(),"commoditySpecificationId":$(val).find(".edit_goods_name").val(),"discount":$(val).find(".edit_discount").val(),"taxes":$(val).find(".edit_taxes").val(),
    					"deliverGoodsMoney":$(val).find(".edit_deliverGoodsMoney").val(),"remark":$(val).find(".edit_remark").val(),"deliverGoodsNum":$(val).find(".edit_deliverGoodsNum").val(),"unitPrice":unitPrice,
    					"isSpecialOffer":isSpecialOffer,"taxesMoney":$(val).find(".edit_taxesMoney").val(),"batchNumber":$(val).find(".edit_batch_number").val(),"warehouseId":$(val).find(".edit_warehouse_id").val()};	
    				
    			salesOrderDataJSON.salesOrderCommodities[index]=salesOrderCommoditiesDataJSON;	
    			});
    			
    		
    		return salesOrderDataJSON; 
    	}
    	
    	//商品的合计
      	function countCommodityNumAndPrice(){
      		var commodityNum=0;
      		var commodityTotalPrice=0;
      	//获取销售计划商品的信息，添加到销售计划单的商品信息里
    		$("#edit_goodDiv .salesOrderCommodity").each(function(index, val){
    			commodityNum+=$(val).find(".edit_deliverGoodsNum").val()-0;
    			commodityTotalPrice+=$(val).find(".edit_deliverGoodsMoney").val()-0;
    			});
      		$("#total_commodity_num").val(commodityNum);
      		$("#total_commodity_price").val(commodityTotalPrice.toFixed(2));
      	}
    	
    	/* 商品数量输入框onkeyup事件   计算金额*/
        function onkeyUpBindEach(){
        	$(".salesOrderCommodity").each(function(index, val){
        		
        		var deliverGoodsNumInput=$(val).find(".edit_deliverGoodsNum").val();
            	var unitPrice=0;
            	$(val).find(".edit_unitPrice").each(function(index, v){
    				if(!$(v).hasClass("hidden")){
    					unitPrice=$(v).val();
    				}
    			});
            	if(deliverGoodsNumInput!=""&& deliverGoodsNumInput-0>0){
            		var deliverGoodsNum=deliverGoodsNumInput-0;
            		$(val).find(".edit_deliverGoodsMoney").val((deliverGoodsNum*unitPrice).toFixed(2));
            	}else{
            		$(val).find(".edit_deliverGoodsMoney").val("");
            	}
            	if($("#edit_is_specimen").val()==2){
            		$(val).find(".edit_deliverGoodsMoney").val("0");
        		}
			})

    		
        	getAmountOfTaxEach();
        	countCommodityNumAndPrice();
        }
    	
        /* 获取税额  */
    	function getAmountOfTaxEach(){
    		//税额=发货数量*单价*税率
    		//单价
    		
    		$(".salesOrderCommodity").each(function(index, val){
        			var unitPrice=0;
                	$(val).find(".edit_unitPrice").each(function(index, v){
        				if(!$(v).hasClass("hidden")){
        					unitPrice=$(v).val();
        				}
        			});
            		//税率
            		var taxRateInput=$(val).find(".edit_taxes").val();
            		//发货数量
            		var orderNumInput=$(val).find(".edit_deliverGoodsNum").val();
            		
            		if(unitPrice>0){
            			if(orderNumInput!=""&&orderNumInput>0){
            				var orderNum=orderNumInput-0;
            				if(taxRateInput!=""&&taxRateInput>0){
            					var taxRate=taxRateInput-0;
            					$(val).find(".edit_taxesMoney").val((taxRate*orderNum*unitPrice).toFixed(2));
            					
            				}
            				else{
            					$(val).find(".edit_taxesMoney").val("0");	
            				}
            			}
            			else{
            				$(val).find(".edit_taxesMoney").val("");	
            			}
            		}
            		else{
            			$(val).find(".edit_taxesMoney").val("");	
            		}
            		if($("#edit_is_specimen").val()==2){
                		
                		$(val).find(".edit_taxesMoney").val("0");	
            		}
    			})
    		
    		
    	}
    	
    	/* 商品数量输入框onkeyup事件   计算金额*/
        function onkeyUpBind(e){
    		if($(e).hasClass("edit_unitPrice")){
    			console.log("进来了");
    			pressMoney(e);
    		}
    		else if($(e).hasClass("edit_deliverGoodsNum")){
    			pressInteger(e);
    		}
        	
        	//不是样品单，此时计算
    		if($("#edit_is_specimen").val()==1||$("#edit_is_specimen").val()==-1){
    			var deliverGoodsNumInput=$(e).parents(".salesOrderCommodity").find(".edit_deliverGoodsNum").val();
            	var unitPrice=0;
            	$(e).parents(".salesOrderCommodity").find(".edit_unitPrice").each(function(index, val){
    				if(!$(val).hasClass("hidden")){
    					unitPrice=$(val).val();
    				}
    			});
            	if(deliverGoodsNumInput!=""&& deliverGoodsNumInput-0>0){
            		var deliverGoodsNum=deliverGoodsNumInput-0;
            		$(e).parents(".salesOrderCommodity").find(".edit_deliverGoodsMoney").val((deliverGoodsNum*unitPrice).toFixed(2));
            	}
            	else{
            		$(e).parents(".salesOrderCommodity").find(".edit_deliverGoodsMoney").val("0");
            	}
            	getAmountOfTax($(e).parents(".salesOrderCommodity").find(".edit_taxes")[0]);
    		}
    		else{
    			$(e).parents(".salesOrderCommodity").find(".edit_deliverGoodsMoney").val("0");
    		}
    		countCommodityNumAndPrice();
        }
    	
        /* 获取税额  */
    	function getAmountOfTax(e){
    		pressSmallNumZero(e);
    		//税额=发货数量*单价*税率
    		//单价
    		//不是样品单，此时计算
    		if($("#edit_is_specimen").val()==1||$("#edit_is_specimen").val()==-1){
    			var unitPrice=0;
            	$(e).parents(".salesOrderCommodity").find(".edit_unitPrice").each(function(index, val){
    				if(!$(val).hasClass("hidden")){
    					unitPrice=$(val).val();
    				}
    			});
        		//税率
        		var taxRateInput=$(e).parents(".salesOrderCommodity").find(".edit_taxes").val();
        		//发货数量
        		var orderNumInput=$(e).parents(".salesOrderCommodity").find(".edit_deliverGoodsNum").val();
        		
        		if(unitPrice>0){
        			if(orderNumInput!=""&&orderNumInput>0){
        				var orderNum=orderNumInput-0;
        				if(taxRateInput!=""&&taxRateInput>0){
        					var taxRate=taxRateInput-0;
        					$(e).parents(".salesOrderCommodity").find(".edit_taxesMoney").val((taxRate*orderNum*unitPrice).toFixed(2));
        					
        				}
        				else{
        					$(e).parents(".salesOrderCommodity").find(".edit_taxesMoney").val("0");	
        				}
        			}
        			else{
        				$(e).parents(".salesOrderCommodity").find(".edit_taxesMoney").val("0");	
        			}
        		}
        		else{
        			$(e).parents(".salesOrderCommodity").find(".edit_taxesMoney").val("");	
        		}
        		
    		}
    		else{
    			$(e).parents(".salesOrderCommodity").find(".edit_taxesMoney").val("0");	
    		}
    		
    		
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