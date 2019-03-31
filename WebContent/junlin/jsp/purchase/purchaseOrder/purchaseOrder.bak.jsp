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
<title>采购订单</title>
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

#goodsAddBtn {
	float: right;
	margin-top: 13px;
}

#edit_goodDiv .jl-panel {
	position: relative;
}

.close_span {
	position: absolute;
	top: 8px;
	right: 10px;
	color: #b5b5b5;
}
</style>
</head>

<body class="content" id="purchaseOrder_content">
	<div class="page-content clearfix">
		<div id="Member_Ratings">
			<div class="d_Confirm_Order_style" style="margin-top: 10px;">
				<h4 class="text-title">采购订单</h4>
				<div class="search-div clearfix">
					<div class="clearfix">
						<span class="l_f"> 单号： <input type="text" value=""
							id="query_identifier" maxlength="100" />
						</span> <span class="l_f"> 供应商名称： <input type="text" value="" maxlength="100"
							id="query_supctoId" />
						</span> <span class="l_f"> 货品名称： <input type="text" value="" maxlength="100"
							id="query_goodsName" />
						</span> <span class="r_f"> <input type="button"
							class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
					</div>

				</div>
				<div class="opration-div clearfix">
					<!--<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="purchaseOrderRefresh()" style="margin-right: 0;"><i class="fa fa-refresh"></i>刷新</button>
						</span>-->
					<!--<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="purchaseOrderDel()"><i class="fa fa-trash"></i> 删除</button>
						</span>-->
					<span class="r_f">
						<button type="button" class="btncss jl-btn-defult"
							onclick="purchaseOrderAdd()" style="margin-right: 0;">
							<i class="fa fa-plus"></i>新增
						</button>
					</span> <span class="jl_f_l"> <input type="checkbox" name="id"
						id="checkAll" style="margin: 0 5px 0 0;"
						onclick="checkboxController(this)" />
					</span> <span class="jl_f_l"> <label for="checkAll">全选</label>
					</span>

				</div>
				<div class="table_menu_list">
					<table class="table table-striped table-hover col-xs-12"
						id="datatable">
						<thead class="table-header">
							<tr>
								<th>选择</th>
								<th>单号</th>
								<th>供应商</th>
								<th>货品名称</th>
								<th>业务单价</th>
								<th>订货数量</th>
								<th>价税合计</th>
								<th>日期</th>
								<th>状态</th>
								<th>app订单</th>
								<th width="20%">操作</th>
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
				<span>基本信息</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">日期：</label>
						<div class="col-xs-8" id="look_generateDate">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">供应商：</label>
						<div class="col-xs-8" id="look_supctoId">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">有效期至：</label>
						<div class="col-xs-8" id="look_effectivePeriodEnd">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">合同号：</label>
						<div class="col-xs-8" id="look_contractNumber">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">到货时间：</label>
						<div class="col-xs-8" id="look_goodsArrivalTime">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">到货地址：</label>
						<div class="col-xs-8" id="look_goodsArrivalPlace">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">付款方式：</label>
						<div class="col-xs-8" id="look_payType">123456</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">单号：</label>
						<div class="col-xs-8" id="look_identifier">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">订货人：</label>
						<div class="col-xs-8" id="look_orderer">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">运输方式：</label>
						<div class="col-xs-8" id="look_transportationMode">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">送货人：</label>
						<div class="col-xs-8" id="look_deliveryman">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">传真：</label>
						<div class="col-xs-8" id="look_fax">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">联系电话：</label>
						<div class="col-xs-8" id="look_phone">123456</div>
					</div>
					<div class="form-group" id="look_prepaidAmount_div">
						<label for="" class="col-xs-4 control-label">预付金额：</label>
						<div class="col-xs-8" id="look_prepaidAmount">123456</div>
					</div>
				</div>
			</div>
			<div class="row jl-title">
				<span>合计</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">订货数量：</label>
						<div class="col-xs-8" id="look_total_orderNum">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">税额：</label>
						<div class="col-xs-8" id="look_total_amountOfTax">123456</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">价税合计：</label>
						<div class="col-xs-8" id="look_total_totalTaxPrice">123456</div>
					</div>

				</div>
			</div>
			
			<div class="row jl-title">
				<span>商品</span>
			</div>
			<div id="look_goodDiv"></div>


			
			<div class="row jl-title">
				<span>其他</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">部门：</label>
						<div class="col-xs-8" id="look_departmentId">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">审核人：</label>
						<div class="col-xs-8" id="look_reviewer">123456</div>
					</div>

					<div class="form-group">
						<label for="" class="col-xs-4 control-label">摘要：</label>
						<div class="col-xs-8" id="look_summary">123456</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">制单人：</label>
						<div class="col-xs-8" id="look_originator">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">终止审核人：</label>
						<div class="col-xs-8" id="look_terminator">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">分支机构：</label>
						<div class="col-xs-8" id="look_branch">123456</div>
					</div>
				</div>
			</div>
			<div id="accountShowDiv">
				<div class="row jl-title">
					<span>付款凭证</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-12" id="picContent">
						<%-- <div class="col-xs-6">
							<img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/junlin/img/timg.jpg" src="${pageContext.request.contextPath}/junlin/img/timg.jpg" alt="" />
						</div>
						<div class="col-xs-6">
							<img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/junlin/img/orderpj.jpg" src="${pageContext.request.contextPath}/junlin/img/orderpj.jpg" alt="" />
						</div>
						<div class="col-xs-6">
							<img onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/junlin/img/timg.jpg" src="${pageContext.request.contextPath}/junlin/img/timg.jpg" alt="" />
						</div>
						<div class="col-xs-6">
							<img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/junlin/img/orderpj.jpg" src="${pageContext.request.contextPath}/junlin/img/orderpj.jpg" alt="" />
						</div>
						<div class="col-xs-6">
							<img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/junlin/img/timg.jpg" src="${pageContext.request.contextPath}/junlin/img/timg.jpg" alt="" />
						</div>
						<div class="col-xs-6">
							<img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/junlin/img/orderpj.jpg" src="${pageContext.request.contextPath}/junlin/img/orderpj.jpg" alt="" />
						</div> --%>

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
				<input type="text" class="form-control hidden" id="edit_purchase_id" />
				<div class="col-xs-6">
					<div class="form-group hidden" id="edit_generateDate_div">
						<label for="" class="col-xs-4 control-label">日期</label>
						<div class="col-xs-8">
							<input type="text" class="form-control hidden"
								id="edit_generateDate" disabled="disabled" />
						</div>
					</div>
					<div class="form-group" id="edit_supctoIdDiv">
						<label for="" class="col-xs-4 control-label">供应商</label>
						<div class="col-xs-8">

							<select id="edit_supctoId" class="form-control">

							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">有效期至</label>
						<div class="col-xs-8">
							<input type="text" class="form-control"
								id="edit_effectivePeriodEnd" readonly="readonly"
								placeholder="请选择有效期" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">合同号</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="edit_contractNumber"
								onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">到货时间</label>
						<div class="col-xs-8">
							<input type="text" class="form-control"
								id="edit_goodsArrivalTime" readonly="readonly"
								placeholder="请选择到货时间" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">到货地址</label>
						<div class="col-xs-8">
							<input type="text" class="form-control"
								id="edit_goodsArrivalPlace" onkeyup="cky(this)" maxlength="100"/>
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
				<div class="col-xs-6">
					<div class="form-group hidden" id="edit_identifier_div">
						<label for="" class="col-xs-4 control-label">单号</label>
						<div class="col-xs-8">
							<input type="text" class="form-control hidden"
								id="edit_identifier" disabled="disabled" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">订货人</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="edit_orderer" maxlength="100"
								onkeyup="cky(this)" />
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
							<input type="text" class="form-control" id="edit_deliveryman" maxlength="100"
								onkeyup="cky(this)" />
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
					<div class="form-group hidden" id="edit_prepaidAmount_div">
						<label for="" class="col-xs-4 control-label">预付金额</label>
						<div class="col-xs-8">
							<input type="text" class="form-control hidden"
								id="edit_prepaidAmount" onkeyup="pressMoney(this)"/>
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
						<label for="" class="col-xs-4 control-label">订货数量：</label>
						<div class="col-xs-8" id="add_total_orderNum">0</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">税额：</label>
						<div class="col-xs-8" id="add_total_amountOfTax">0</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">价税合计：</label>
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

			<div class="row jl-title">
				<span>其他</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<!--<div class="form-group">
						<label for="" class="col-xs-4 control-label">部门</label>
						<div class="col-xs-8">
							<select class="form-control" id="edit_departmentId">
								<option value="-1">请选择</option>
								<option value="01">000</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">审核人</label>
						<div class="col-xs-8">
							<input type="text" id="edit_reviewer" value="" class="form-control" />
						</div>
					</div>-->
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">摘要</label>
						<div class="col-xs-8">
							<input type="text" id="edit_summary" value=""
								class="form-control" onkeyup="cky(this)" maxlength="100"/>
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<!--<div class="form-group">
						<label for="" class="col-xs-4 control-label">制单人</label>
						<div class="col-xs-8">
							<input type="text" id="look_originator" value="" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">分支机构</label>
						<div class="col-xs-8">
							<input type="text" id="look_branch" value="" class="form-control" />
						</div>
					</div>-->
				</div>
			</div>

			<div class="text-danger">注：该页面所有字段均为必填</div>
		</form>

	</div>


	<!--终止订单提示框，请于JS配置内容-->
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
	
	var oTable1;
	let goods_index=1;
	
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
							"planOrOrder":2
								
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
													+ data
													+ '" onclick="checkboxClick(\'#checkAll\')"/></td>';
										}
									},
									{
										"mData" : "identifier",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return '<td><span class="look-span" onclick="purchaseOrderDetail('
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
										"sWidth" : "8%",
										"sClass" : "center"

									},
									{
										"mData" : "orderNums",
										"bSortable" : false,
										"sWidth" : "8%",
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
										"mRender" : function(data, type, row) {

											switch (data) {
											case 1:
												return "未送审";
												break;
											case 2:
												return "待审核";
												break;
											case 3:
												return "已通过";
												break;
											case 4:
												return "已驳回";
												break;
											case 5:
												return "待付款";
												break;
											case 6:
												return "已付款";
												break;
											case 7:
												return "已撤销";
												break;
											case 8:
												return "终止审核中";
												break;
											case 9:
												return "终止审核通过";
												break;
											case 10:
												return "终止审核驳回";
												break;
											case 11:
												return "部分入库";
												break;
											case 12:
												return "已全部入库";
												break;
											case 13:
												return "已开单";
												break;
											case 15:
												return "部分入库通知开单";
												break;
											default:
												break;
											}
										}

									},
									{
										"mData" : "isAppOrder",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender": function(data) {
											if(data!="2"){
												return "否";
											}else{
												return "是";
											}
											
										}

									},
									{
										"mData" : "id",
										"bSortable" : false,
										"sWidth" : "20%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											if(row.state==1||row.state==4){
												return '<td><input type="button" class="btncss edit"'
												+ 'onclick="purchaseOrderEdit('
												+ data
												+ ')" value="编辑" />'
												+ '<input type="button" class="btncss edit" onclick=\'purchaseOrderDeliver(' 
												+ JSON.stringify(row) 
												+ ')\'  value="送审" />'
												+'<input type="button" class="btncss edit" onclick=\'purchaseOrderDel(' + JSON.stringify(row) + ')\' value="删除" /></td>'
											}
											else if(row.state==2||row.state==3||row.state==5){
												return '<td><input type="button" class="btncss edit" onclick="purchaseOrderCancle('
												+data
												+')" value="撤销" /><input type="button" class="btncss edit" onclick="exportMsg('
												+ row.id
												+ ')" value="导出" /></td>'
											}
											else if(row.state==6||row.state==11||row.state==10){
												return '<td><input type="button" class="btncss edit" onclick="purchaseOrderStop('
												+data
												+')" value="终止" /><input type="button" class="btncss edit" onclick="exportMsg('
												+ row.id
												+ ')" value="导出" /></td>'

											}
											else if(row.state==7){
												return '<td><input type="button" class="btncss edit" disabled value="已撤销" /></td>'
											}
											else if(row.state==8){
												return '<td><input type="button" class="btncss edit" disabled value="终止审核中" /></td>'
											}
											else if(row.state==9){
												return '<td><input type="button" class="btncss edit" disabled value="已终止" /></td>'
											}
											else if(row.state==12||row.state==13||row.state==15){
												return '<td><input type="button" class="btncss edit" disabled value="已完成" /><input type="button" class="btncss edit" onclick="exportMsg('
												+ row.id
												+ ')" value="导出" /></td>'
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

	
	latdate("#edit_generateDate");
	latdate("#edit_effectivePeriodEnd");
	latdate("#edit_goodsArrivalTime");
	
	/* 获取所有结算方式*/
	getAllSettlementType();
	/* 获取所有运输方式*/
	getAllShippingMode();
	//给添加时需要选择的供货商下拉框赋值
	getSupctoMsgByCustomerOrSupplier();
	
	
	});

	/*送审。*/
	function purchaseOrderDeliver(row) {
		if(row.payType==null||row.payType<=0){
			laywarn("请先完善订单信息");
			return ;
		}
		var ids=[row.id];
		
		publicMessageLayer("将本订单送审", function() {
			$.ajax({
				url :'<%=basePath%>purchase/procuretable/updateStateByIds',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"ids" : ids,
					"state" : 2
					
				},
				
				traditional:true,
				success: function(data) {
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").attr("checked",false);
					} else {
						layfail(data.msg);
					}

				}
			});
		})
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
	}
	
	var commodityMsgList=[];//保存查出来的商品
	var selectedCommodity={};//记录哪一个select选择了哪一个商品规格
	var commodityIsSelected={};//商品规格是否被选择。
	//给添加时需要选择的商品信息下拉框赋值
	function getCommodityMsg(supctoId){
		//清空合计值
		$("#add_total_totalTaxPrice").html(0);
		$("#add_total_orderNum").html(0);
		$("#add_total_amountOfTax").html(0);
		commodityIsSelected={};//还原
		commodityMsgList=[];//还原
		if(supctoId==-1){
			selectedCommodity={};//还原
			$(".edit_commodity_name_div").each(function(index,val){
				$(val).html("");
				var selectparentId =$(val).attr("attr-id");
				var num=selectparentId.substring(8,selectparentId.length)+"";
				$(val).html("<select id='edit_commodity_name"+num+"' class='form-control edit_commodity_name' ><option value='-1' selected>--请先选择供应商--</option></select>");
				
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
	
	/* 获取商品信息   编辑时使用 */
	function getCommodity(){
		$.ajax({
			url: '<%=basePath%>basic/goods/commodity/getAllCommodityByStateAndIsDeleteBySupctoId',
			type: "POST",
			dataType: "json",
			data:{
				"supctoId":$("#edit_supctoId").val()
			},
			async: false,
			cache: false,
			success: function(data) {
				commodityMsgList=[];
				commodityMsgList=data;
			}
		});
	}
	
	
	/* 商品选择框的值改变事件 */
	function selectCommodityMsg(e,selectValId){	
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
							
							$("#"+selectparentId+" .edit_procureCommodity_amountOfTax").val("");
							$("#"+selectparentId+" .edit_procureCommodity_totalTaxPrice").val("");
							
							$("#"+selectparentId+" .edit_procureCommodity_orderNum").val("");
							$("#"+selectparentId+" .edit_procureCommodity_discount").val("");
							$("#"+selectparentId+" .edit_procureCommodity_remarks").val("");
							$("#"+selectparentId+" .edit_procureCommodity_lotNumber").val("");
							
							
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
							$("#"+selectparentId+" .edit_procureCommodity_amountOfTax").val("");
							$("#"+selectparentId+" .edit_procureCommodity_totalTaxPrice").val("");
							$("#"+selectparentId+" .edit_procureCommodity_orderNum").val("");
							$("#"+selectparentId+" .edit_procureCommodity_discount").val("");
							$("#"+selectparentId+" .edit_procureCommodity_remarks").val("");
							$("#"+selectparentId+" .edit_procureCommodity_lotNumber").val("");
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
			$("#"+selectparentId+" .edit_procureCommodity_totalTaxPrice").val("");
			
			$("#"+selectparentId+" .edit_procureCommodity_orderNum").val("");
			$("#"+selectparentId+" .edit_procureCommodity_discount").val("");
			$("#"+selectparentId+" .edit_procureCommodity_remarks").val("");
			$("#"+selectparentId+" .edit_procureCommodity_lotNumber").val("");
		}
		console.log(selectedCommodity);
		console.log(commodityIsSelected);
			
	}
	
	//$(".searchable-select-holder").onchange();
	var updateOrAdd=0;//是编辑还是添加   1是新增，2是编辑
	var updateGoodsDivNum=0; //编辑的商品div数量
	/*修改*/
	function purchaseOrderEdit(id) {
 		var totalTaxPrice=0;
 		var totalAmountOfTax=0;
 		var totalOrderNum=0;
		$.ajax({
			url :'<%=basePath%>/purchase/procuretable/selectById' ,
			type : "POST",
			dataType : "json",
			data: {
				"id" : id
			},
			success : function(data) {
				if(data!=null){
					//页面赋值
					//基本信息
					$("#edit_generateDate_div").removeClass("hidden");
					$("#edit_generateDate").removeClass("hidden");
					$("#edit_identifier_div").removeClass("hidden");
					$("#edit_identifier").removeClass("hidden");	
					$("#edit_purchase_id").val(data.id);
					//是app订单
					if(data.isAppOrder==2){
						
						$("#goodsAddBtn").addClass("hidden");
					}
					
					if(data.generateDate == null || data.generateDate == ""){
						$("#edit_generateDate").val("");
					}else{
						$("#edit_generateDate").val(getSmpFormatDateByLong(data.generateDate, true));
					}
					if(data.supctoId!=null){
						SearchableSelectsetValue("#edit_supctoId",data.supctoId);
						$("#edit_supctoIdDiv").append("<div class='col-xs-8'><input type='text' class='form-control' disabled='disabled' value='"+$(".searchable-select-holder").html()+"'/></div>");
					}
					else{
						SearchableSelectsetValue("#edit_supctoId",-1);
						$("#edit_supctoIdDiv").append("<div class='col-xs-8'><input type='text' class='form-control' disabled='disabled' value='无'/></div>");
					} 
					
					
					$("#edit_supctoId").parent().addClass("hidden");
					$("#edit_supctoId").addClass("hidden");
					getCommodity();
					//$("#edit_supctoId").val(data.supctoId);
					if(data.effectivePeriodEnd == null || data.effectivePeriodEnd == ""){
						$("#edit_effectivePeriodEnd").val("");
					}else{
						$("#edit_effectivePeriodEnd").val(getSmpFormatDateByLong(data.effectivePeriodEnd, false));
					}
					$("#edit_contractNumber").val(data.contractNumber);
					if(data.goodsArrivalTime == null || data.goodsArrivalTime == ""){
						$("#edit_goodsArrivalTime").val("");
					}else{
						$("#edit_goodsArrivalTime").val(getSmpFormatDateByLong(data.goodsArrivalTime, false));
					}
					$("#edit_goodsArrivalPlace").val(data.goodsArrivalPlace);
					$("#edit_orderer").val(data.orderer);
					if(data.transportationMode!=null){
						$("#edit_transportationMode").val(data.transportationMode);	
					}
					else{
						$("#edit_transportationMode").val(-1);
					}
					
					$("#edit_identifier").val(data.identifier);
					$("#edit_deliveryman").val(data.deliveryman);
					$("#edit_fax").val(data.fax);
					$("#edit_phone").val(data.phone);
					if(data.payType==null){
						$("#edit_payType").val(-1);
					}
					else{
						$("#edit_payType").val(data.payType);
					}
					
					if(data.payType==1){
						$("#edit_prepaidAmount_div").removeClass("hidden");
						$("#edit_prepaidAmount").removeClass("hidden");
					}
					
					if(data.prepaidAmount == null){
						$("#edit_prepaidAmount").val("");
					}else{
						$("#edit_prepaidAmount").val(data.prepaidAmount);
					}
					$("#edit_goodDiv").html("");
					console.log("app订单",data.isAppOrder);
					//商品
					for(var i=0;i<data.procureCommoditys.length;i++){
						updateOrAdd=2;
						updateGoodsDivNum=i+1;
						goodsAdd(i+1,2);
						//是app订单
						if(data.isAppOrder==2){
							$("#goodsMsg"+(i+1)+" .close_span").addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_taxRate").parent().parent().addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_taxRate").addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_originalUnitPrice").parent().parent().addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_originalUnitPrice").addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_amountOfTax").parent().parent().addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_amountOfTax").addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_discount").parent().parent().addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_discount").addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_totalTaxPrice").parent().parent().addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_totalTaxPrice").addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_lotNumber").parent().parent().addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_lotNumber").addClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_orderNum").attr("disabled","disabled");
						}
						else{
							if(data.beforeIsPlan==1){
								$("#goodsMsg"+(i+1)+" .close_span").addClass("hidden");
							}
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_taxRate").parent().parent().removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_taxRate").removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_originalUnitPrice").parent().parent().removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_originalUnitPrice").removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_amountOfTax").parent().parent().removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_amountOfTax").removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_discount").parent().parent().removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_discount").removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_totalTaxPrice").parent().parent().removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_totalTaxPrice").removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_lotNumber").parent().parent().removeClass("hidden");
							$("#goodsMsg"+(i+1)+" .edit_procureCommodity_lotNumber").removeClass("hidden");
						}
						if(data.procureCommoditys[i].commoditySpecification!=null){
							
							selectedCommodity[(i+1)+""]=data.procureCommoditys[i].commoditySpecification.id;
							commodityIsSelected[data.procureCommoditys[i].commoditySpecification.id+""]=1;
							console.log(selectedCommodity);
							console.log(commodityIsSelected);
							if(data.beforeIsPlan==1){
								$("#goodsMsg"+(i+1)+" .edit_commodity_nameDiv").append("<div class='col-xs-8'><input type='text' class='form-control' disabled='disabled' value='"+data.procureCommoditys[i].commoditySpecification.commodity.name+"'/></div>");
								
								$("#goodsMsg"+(i+1)+" .edit_commodity_name").parent().addClass("hidden");
								$("#goodsMsg"+(i+1)+" .edit_commodity_name").addClass("hidden");
							}
 							$("#goodsMsg"+(i+1)+" .edit_commodity_specifications_id").val(data.procureCommoditys[i].commoditySpecification.id);
 							//是app订单
 							if(data.isAppOrder!=2){
 								SearchableSelectsetValue("#goodsMsg"+(i+1)+" .edit_commodity_name",data.procureCommoditys[i].commoditySpecification.id);
 							}
							
							console.log("编辑commodityId：",data.procureCommoditys[i].commodityId);
							//$("#goodsMsg"+(i+1)+" .edit_commodity_name").val(data.procureCommoditys[i].commodity.name);
							$("#goodsMsg"+(i+1)+" .edit_commodity_specifications").val(data.procureCommoditys[i].commoditySpecification.specificationName);
							$("#goodsMsg"+(i+1)+" .edit_commodity_unit").val(data.procureCommoditys[i].commoditySpecification.baseUnitName);
							$("#goodsMsg"+(i+1)+" .edit_commodity_identifier").val(data.procureCommoditys[i].commoditySpecification.specificationIdentifier);
							$("#goodsMsg"+(i+1)+" .edit_commodity_brand").val(data.procureCommoditys[i].commoditySpecification.commodity.brand);
						}
						else{
							$("#goodsMsg"+(i+1)+" .edit_commodity_specifications_id").val("");
							SearchableSelectsetValue("#goodsMsg"+(i+1)+" .edit_commodity_name",-1);
							//$("#goodsMsg"+(i+1)+" .edit_commodity_name").val("");
							$("#goodsMsg"+(i+1)+" .edit_commodity_specifications").val("");
							$("#goodsMsg"+(i+1)+" .edit_commodity_unit").val("");
							$("#goodsMsg"+(i+1)+" .edit_commodity_identifier").val("");
							$("#goodsMsg"+(i+1)+" .edit_commodity_brand").val("");
						}
						$("#goodsMsg"+(i+1)+" .edit_purchase_commodity_id").val(data.procureCommoditys[i].id);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_orderNum").val(data.procureCommoditys[i].orderNum);
						
						//$("#goodsMsg"+(i+1)+" .edit_procureCommodity_suspendPrice").val(data.procureCommoditys[i].suspendPrice);
						//$("#goodsMsg"+(i+1)+" .edit_procureCommodity_suspendQuantity").val(data.procureCommoditys[i].suspendQuantity);
						//$("#goodsMsg"+(i+1)+" .edit_procureCommodity_arrivalQuantity").val(data.procureCommoditys[i].arrivalQuantity);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_totalTaxPrice").val(data.procureCommoditys[i].totalTaxPrice);
					
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_containsTaxPrice").val(data.procureCommoditys[i].containsTaxPrice);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_taxRate").val(data.procureCommoditys[i].taxRate);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_paymentForGoods").val(data.procureCommoditys[i].paymentForGoods);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_lotNumber").val(data.procureCommoditys[i].lotNumber);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_remarks").val(data.procureCommoditys[i].remarks);	
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_originalUnitPrice").val(data.procureCommoditys[i].originalUnitPrice);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_discount").val(data.procureCommoditys[i].discount);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_businessUnitPrice").val(data.procureCommoditys[i].businessUnitPrice);
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_amountOfTax").val(data.procureCommoditys[i].amountOfTax);
				
						$("#goodsMsg"+(i+1)+" .edit_procureCommodity_totalPrice").val(data.procureCommoditys[i].totalPrice);
						//$("#goodsMsg"+(i+1)+" .edit_procureCommodity_isLargess").val(data.procureCommoditys[i].isLargess);
						totalTaxPrice+=data.procureCommoditys[i].totalTaxPrice;
						totalOrderNum+=data.procureCommoditys[i].orderNum;
						totalAmountOfTax+=data.procureCommoditys[i].amountOfTax;
						
					}
					
					
					$("#add_total_totalTaxPrice").html(totalTaxPrice);
					$("#add_total_orderNum").html(totalOrderNum);
					$("#add_total_amountOfTax").html(totalAmountOfTax);
					//其他
					$("#edit_summary").val(data.summary);
				}
				else{
					laywarn("该订单已被删除，请重新加载该页面。");
				}
				
				
			}
		});
		layer.open({
			type : 1,
			title : "编辑采购订单",
			closeBtn : 1,
			area : [ '100%', '100%' ],
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
					url: '<%=basePath%>purchase/procuretable/updateOrderByPrimaryKey',
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
							oTable1.fnDraw(false);
							$("#checkAll").removeAttr("checked");
						} else {
							layfail(data.msg);
						}
						layer.close(index);
					}
				});
			},
			end : function(index, layero) {
				$("#edit_generateDate_div").addClass("hidden");
				$("#edit_generateDate").addClass("hidden");
				$("#edit_identifier_div").addClass("hidden");
				$("#edit_identifier").addClass("hidden");
				$("#edit_supctoIdDiv").children().last().remove();
				$("#edit_supctoId").parent().removeClass("hidden");
				clearSearchableSelect('edit_supctoId');
				layer.close(index);
				clearForm("editDiv", "");
				
				goods_index=0;
				$("#edit_goodDiv").html("");
				$("#edit_prepaidAmount_div").addClass("hidden");
				$("#goodsAddBtn").removeClass("hidden");
			}
		});
	}
	/*新增*/
	function purchaseOrderAdd() {
		$("#add_total_totalTaxPrice").html(0);
		$("#add_total_orderNum").html(0);
		$("#add_total_amountOfTax").html(0);
		updateOrAdd=1;
		goodsAdd(1,1);
		/* clearSearchableSelect('edit_supctoId'); */
		layer.open({
			type : 1,
			title : "新增采购订单",
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
					url: '<%=basePath%>purchase/procuretable/addPurchaseOrder?planOrTable='+2,
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
							oTable1.fnDraw(false);
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
				clearSearchableSelect('edit_supctoId');
				goods_index=0;
				$("#edit_goodDiv").html("");
				$("#edit_prepaidAmount_div").addClass("hidden");
			}
		});
	}
	/*详情*/
	function purchaseOrderDetail(id) {
		$.ajax({
			type: "post",
			url: "<%=basePath%>/purchase/procuretable/detailPurchaseOrder",
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
		
		<%-- $.ajax({
			url :'<%=basePath%>/purchase/procuretable/selectById' ,
			type : "POST",
			dataType : "json",
			data: {
				"id" : id
			},
			success : function(data) {
				console.log(data);
				//页面赋值
				//基本信息
				if(data.generateDate == null || data.generateDate == ""){
					$("#look_generateDate").html("");
				}else{
					$("#look_generateDate").html(getSmpFormatDateByLong(data.generateDate, true));
				}
				if(data.supcto == null){
					$("#look_supctoId").html("");
				}else{
					$("#look_supctoId").html(data.supcto.name);
				}
				if(data.effectivePeriodEnd == null || data.effectivePeriodEnd == ""){
					$("#look_effectivePeriodEnd").html("");
				}else{
					$("#look_effectivePeriodEnd").html(getSmpFormatDateByLong(data.effectivePeriodEnd, false));
				}
				$("#look_contractNumber").html(data.contractNumber);
				if(data.goodsArrivalTime == null || data.goodsArrivalTime == ""){
					$("#look_goodsArrivalTime").html("");
				}else{
					$("#look_goodsArrivalTime").html(getSmpFormatDateByLong(data.goodsArrivalTime, false));
				}
				$("#look_goodsArrivalPlace").html(data.goodsArrivalPlace);
				$("#look_orderer").html(data.orderer);
				if(data.supcto == null){
					$("#look_supctoId").html("");
				}else{
					$("#look_supctoId").html(data.supcto.name);
				}
				if(data.shippingMode == null){
					$("#look_transportationMode").html("");
				}else{
					$("#look_transportationMode").html(data.shippingMode.name);
				}
				$("#look_identifier").html(data.identifier);
				$("#look_deliveryman").html(data.deliveryman);
				$("#look_fax").html(data.fax);
				$("#look_phone").html(data.phone);
				if(data.settlementType == null){
					$("#look_payType").html("");
				}else{
					$("#look_payType").html(data.settlementType.name);
				}
				if(data.prepaidAmount == null){
					$("#look_prepaidAmount").html("");
				}else{
					$("#look_prepaidAmount").html(data.prepaidAmount);
				}
				
				if(data.payType==1){
					$("#look_prepaidAmount_div").removeClass("hidden");
					$("#look_prepaidAmount").removeClass("hidden");
					$("#look_prepaidAmount").html(data.prepaidAmount);
				}else{
					$("#look_prepaidAmount_div").addClass("hidden");
					$("#look_prepaidAmount").addClass("hidden");
				}
				
				//商品
				/* 商品 */
				var total_orderNum = 0;
				var total_amountOfTax = 0;
				var total_totalTaxPrice = 0;
				
				for(var i=0;i<data.procureCommoditys.length;i++){
					appendGoodsDiv(i+1);
					
					if(data.procureCommoditys[i].commoditySpecification!=null){
						
						$("#goodsMsg"+(i+1)+" .look_commodity_name").html(data.procureCommoditys[i].commoditySpecification.commodity.name);
						$("#goodsMsg"+(i+1)+" .look_commodity_specifications").html(data.procureCommoditys[i].commoditySpecification.specificationName);
						$("#goodsMsg"+(i+1)+" .look_commodity_unit").html(data.procureCommoditys[i].commoditySpecification.baseUnitName);
						$("#goodsMsg"+(i+1)+" .look_commodity_identifier").html(data.procureCommoditys[i].commoditySpecification.specificationIdentifier);
						$("#goodsMsg"+(i+1)+" .look_commodity_brand").html(data.procureCommoditys[i].commoditySpecification.commodity.brand);
					}
					else{
						
						$("#goodsMsg"+(i+1)+" .look_commodity_name").html("");
						$("#goodsMsg"+(i+1)+" .look_commodity_specifications").html("");
						$("#goodsMsg"+(i+1)+" .look_commodity_unit").html("");
						$("#goodsMsg"+(i+1)+" .look_commodity_identifier").html("");
						$("#goodsMsg"+(i+1)+" .look_commodity_brand").html("");
					}
					
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_orderNum").html(data.procureCommoditys[i].orderNum);
					
					total_orderNum += data.procureCommoditys[i].orderNum;
					
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_suspendPrice").html(data.procureCommoditys[i].suspendPrice);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_suspendQuantity").html(data.procureCommoditys[i].suspendQuantity);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_arrivalQuantity").html(data.procureCommoditys[i].arrivalQuantity);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_totalTaxPrice").html(data.procureCommoditys[i].totalTaxPrice);
					
					total_totalTaxPrice += data.procureCommoditys[i].totalTaxPrice;
					
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_containsTaxPrice").html(data.procureCommoditys[i].containsTaxPrice);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_taxRate").html(data.procureCommoditys[i].taxRate);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_paymentForGoods").html(data.procureCommoditys[i].paymentForGoods);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_lotNumber").html(data.procureCommoditys[i].lotNumber);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_remarks").html(data.procureCommoditys[i].remarks);	
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_originalUnitPrice").html(data.procureCommoditys[i].originalUnitPrice);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_discount").html(data.procureCommoditys[i].discount);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_businessUnitPrice").html(data.procureCommoditys[i].businessUnitPrice);
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_amountOfTax").html(data.procureCommoditys[i].amountOfTax);
					
					total_amountOfTax += data.procureCommoditys[i].amountOfTax;
					
					$("#goodsMsg"+(i+1)+" .look_procureCommodity_totalPrice").html(data.procureCommoditys[i].totalPrice);
					//$("#goodsMsg"+(i+1)+" .look_procureCommodity_isLargess").html(data.procureCommoditys[i].isLargess);
					
				}
				//合计
				$("#look_total_orderNum").html(total_orderNum);
				$("#look_total_amountOfTax").html(total_amountOfTax.toFixed(2));
				$("#look_total_totalTaxPrice").html(total_totalTaxPrice.toFixed(2));
				//其他
				$("#look_departmentId").html(data.departmentName);
				if(data.reviewer==null || data.reviewerName==null){
					$("#look_reviewer").html("");
				}else{
					$("#look_reviewer").html(data.reviewerName+"("+data.reviewer+")");
				}
				if(data.terminator==null || data.terminatorName==null){
					$("#look_terminator").html("");
				}else{
					$("#look_terminator").html(data.terminatorName+"("+data.terminator+")");
				}
				
				$("#look_summary").html(data.summary);
				if(data.originator==null||data.originatorName==null){
					$("#look_originator").html("");
				}else{
					$("#look_originator").html(data.originatorName+"("+data.originator+")");
				}
				
				$("#look_branch").html(data.branch);
				//付款凭证
				if((data.paymentEvidence1==null || data.paymentEvidence1=="")
				 &&(data.paymentEvidence2==null || data.paymentEvidence2=="")
				 &&(data.paymentEvidence3==null || data.paymentEvidence3=="")
				 &&(data.paymentEvidence4==null || data.paymentEvidence4=="")
				 &&(data.paymentEvidence5==null || data.paymentEvidence5=="")
				 &&(data.paymentEvidence6==null || data.paymentEvidence6=="")){
					//没有付款凭证时
					$("#accountShowDiv").addClass("hidden");
				}else{
					$("#accountShowDiv").removeClass("hidden");
					var showDivHtml = "";
					if(data.paymentEvidence1!=null && data.paymentEvidence1!=""){
						showDivHtml += '<div class="col-xs-4"><img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/' + data.paymentEvidence1+'" src="${pageContext.request.contextPath}/' + data.paymentEvidence1+'" alt="" /></div>';
					}
					if(data.paymentEvidence2!=null && data.paymentEvidence2!=""){
						showDivHtml += '<div class="col-xs-4"><img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/' + data.paymentEvidence2+'" src="${pageContext.request.contextPath}/' + data.paymentEvidence2+'" alt="" /></div>';
					}
					if(data.paymentEvidence3!=null && data.paymentEvidence3!=""){
						showDivHtml += '<div class="col-xs-4"><img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/' + data.paymentEvidence3+'" src="${pageContext.request.contextPath}/' + data.paymentEvidence3+'" alt="" /></div>';
					}
					if(data.paymentEvidence4!=null && data.paymentEvidence4!=""){
						showDivHtml += '<div class="col-xs-4"><img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/' + data.paymentEvidence4+'" src="${pageContext.request.contextPath}/' + data.paymentEvidence4+'" alt="" /></div>';
					}
					if(data.paymentEvidence5!=null && data.paymentEvidence5!=""){
						showDivHtml += '<div class="col-xs-4"><img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/' + data.paymentEvidence5+'" src="${pageContext.request.contextPath}/' + data.paymentEvidence5+'" alt="" /></div>';
					}
					if(data.paymentEvidence6!=null && data.paymentEvidence6!=""){
						showDivHtml += '<div class="col-xs-4"><img  onclick="accountDetail(this)" class="img-responsive" layer-src="${pageContext.request.contextPath}/' + data.paymentEvidence6+'" src="${pageContext.request.contextPath}/' + data.paymentEvidence6+'" alt="" /></div>';
					}
					$("#picContent").html(showDivHtml);
				}
			}
		}); --%>
		layer.open({
			type : 1,
			title : "采购订单详情",
			closeBtn : 1,
			area : [ '100%', '100%' ],
			content : $("#lookDiv"),
			btn : [ '关闭' ],
			end: function(index) {
				/* $("#look_goodDiv").html(""); */
				$("#lookDiv").html("");
			}
		});
	}
	
	/*删除*/
	function purchaseOrderDel(row) {
		publicMessageLayer("删除该订单", function() {
			$.ajax({
				url :'<%=basePath%>purchase/procuretable/delByPrimaryKey',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"id" : row.id,
					"identifier" : row.identifier	
				},
				
				traditional:true,
				success: function(data) {
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").attr("checked",false);
					} else {
						layfail(data.msg);
					}

				}
			});
		})
	}
	
	/*撤销*/
	function purchaseOrderCancle(id) {
		var ids=[id];
		publicMessageLayer("撤销该订单", function() {
			$.ajax({
				url :'<%=basePath%>purchase/procuretable/updateStateByIds',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"ids" : ids,
					"state" : 7
					
				},
				
				traditional:true,
				success: function(data) {
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").attr("checked",false);
					} else {
						layfail(data.msg);
					}

				}
			});
		})
	}

	/* 终止 */
	function purchaseOrderStop(id) {
		var ids=[id];
		layerTwoConfrim($("#alertDiv"), "提示框", "确定终止该订单?", function() {
			$.ajax({
				url :'<%=basePath%>purchase/procuretable/updateStateByIds',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"ids" : ids,
					"state" : 8
					
				},
				
				traditional:true,
				success: function(data) {
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").attr("checked",false);
					} else {
						layfail(data.msg);
					}

				}
			});
		});
	}

	/*查看*/
	function lookPic(src) {
		layer
				.open({
					type : 1,
					title : "付款凭证",
					closeBtn : 1,
					area : [ '100%', '100%' ],
					content : "<div class='text-center div-all'><div class='div-middle'><img  src='" + src + "' /></div></div>",
					btn : [ '关闭' ]
				});

	}
	/*导出*/
	function exportMsg(id){
		
		var URL="<%=basePath%>purchase/procuretable/exportExportProcureTableDetail?id="+id+""
		console.log(URL)
		location.href=URL;
		return false;
	}
	/*新增商品*/
	function  goodsAdd(index,addOrUpdate){
		//1是新增，2是编辑
		if(addOrUpdate==1){
			index=goods_index;
			//在编辑页面点击了新增商品按钮
			if(updateOrAdd==2){
				index=updateGoodsDivNum+1;
			}
			
		}
		
		
		let str=`<div class="row jl-panel procureCommodity" id="goodsMsg`+index+`">
			<span class="close_span" onclick="goodsDel(this)"><i class="fa fa-times"></i></span>
				<div class="col-xs-6">
					<input type="text" id="" class="form-control edit_purchase_commodity_id hidden"/>
					<div class="form-group edit_commodity_nameDiv">
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
						<label for="" class="col-xs-4 control-label">订货数量</label>
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
						<label for="" class="col-xs-4 control-label">价税合计</label>
						<div class="col-xs-8">
							<input type="text" id="" value="" class="form-control edit_procureCommodity_totalTaxPrice" disabled="disabled" placeholder="请先填写订货数量、原始单价、税率"/>
						</div>
					</div>
					<!--<div class="form-group">
						<label for="" class="col-xs-4 control-label">中止数量</label>
						<div class="col-xs-8">
							<input type="text" id="" value="" class="form-control edit_procureCommodity_suspendQuantity" onkeyup="pressInteger(this)"/>
						</div>
					</div>-->
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
					
					<!--<div class="form-group">
						<label for="" class="col-xs-4 control-label">到货数量</label>
						<div class="col-xs-8">
							<input type="text" id="" value="" class="form-control edit_procureCommodity_arrivalQuantity" onkeyup="pressInteger(this)"/>
						</div>
					</div>-->
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">业务单价</label>
						<div class="col-xs-8">
							<input type="text" id="" value="" class="form-control edit_procureCommodity_businessUnitPrice" disabled="disabled" placeholder="请先填写原始单价"/>
						</div>
					</div>

					
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">税额</label>
						<div class="col-xs-8">
							<input type="text" id="" value="" class="form-control edit_procureCommodity_amountOfTax" disabled="disabled" placeholder="请先填写订货数量、原始单价、税率"/>
						</div>
					</div>
					

					<div class="form-group">
						<label for="" class="col-xs-4 control-label">批号</label>
						<div class="col-xs-8">
							<input type="text" id="" value="" class="form-control edit_procureCommodity_lotNumber" onkeyup="cky(this)"/>
						</div>
					</div>
					
					<!--<div class="form-group">
						<label for="" class="col-xs-4 control-label">中止金额</label>
						<div class="col-xs-8">
							<input type="text" id="" value="" class="form-control edit_procureCommodity_suspendPrice" onkeyup="pressMoney(this)"/>
						</div>
					</div>-->
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" id="" value="" class="form-control edit_procureCommodity_remarks" onkeyup="cky(this)" maxlength="100"/>
						</div>
					</div>
					
				</div>
			</div>`;
	$("#edit_goodDiv").append(str);
	$("#edit_commodity_name"+goods_index+"").html("");
	if(commodityMsgList.length<=0){
		if($("#edit_supctoId").val()==-1){		
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
	//latdate("#edit_procureCommodity_arrivalDate"+goods_index);
	
	//getCommodityMsg($("#edit_supctoId").val());
    goods_index++;
	}
	
	/* 给商品详情添加div */
	function appendGoodsDiv(index){	
		
		let goodsDiv=`	<div class="row jl-panel" id="goodsMsg`+index+`">
		<div class="col-xs-6">
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">规格编码：</label>
			<div class="col-xs-8 look_commodity_identifier">123456</div>
		</div>
		
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">规格：</label>
			<div class="col-xs-8 look_commodity_specifications">123456</div>
		</div>
		
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">单位：</label>
			<div class="col-xs-8  look_commodity_unit">123456</div>
		</div>
		
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">到货数量：</label>
			<div class="col-xs-8 look_procureCommodity_arrivalQuantity">123456</div>
		</div>
		
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">折扣%：</label>
			<div class="col-xs-8 look_procureCommodity_discount">123456</div>
		</div>
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">税率：</label>
			<div class="col-xs-8 look_procureCommodity_taxRate">123456</div>
		</div>
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">价税合计：</label>
			<div class="col-xs-8 look_procureCommodity_totalTaxPrice">123456</div>
		</div>
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">中止数量：</label>
			<div class="col-xs-8 look_procureCommodity_suspendQuantity">123456</div>
		</div>
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">备注：</label>
			<div class="col-xs-8 look_procureCommodity_remarks">123456</div>
		</div>
		<!-- <div class="form-group">
			<label for="" class="col-xs-4 control-label">赠品：</label>
			<div class="col-xs-8 look_procureCommodity_isLargess">123456</div>
		</div> -->
		<!--<div class="form-group">
			<label for="" class="col-xs-4 control-label">到货日期：</label>
			<div class="col-xs-8 look_procureCommodity_arrivalDate">123456</div>
		</div>-->

	</div>
	<div class="col-xs-6">
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">货品名称：</label>
			<div class="col-xs-8 look_commodity_name">123456</div>
		</div>
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">品牌：</label>
			<div class="col-xs-8 look_commodity_brand">123456</div>
		</div>
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">订货数量：</label>
			<div class="col-xs-8 look_procureCommodity_orderNum">123456</div>
		</div>
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">原始单价：</label>
			<div class="col-xs-8 look_procureCommodity_originalUnitPrice">123456</div>
		</div>
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">业务单价：</label>
			<div class="col-xs-8 look_procureCommodity_businessUnitPrice">123456</div>
		</div>

		
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">税额：</label>
			<div class="col-xs-8 look_procureCommodity_amountOfTax">123456</div>
		</div>
		
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">批号：</label>
			<div class="col-xs-8 look_procureCommodity_lotNumber">123456</div>
		</div>
		
		<div class="form-group">
			<label for="" class="col-xs-4 control-label">中止金额：</label>
			<div class="col-xs-8 look_procureCommodity_suspendPrice">123456</div>
		</div>
		
		
		

	</div>
</div>`
	
	$("#look_goodDiv").append(goodsDiv);
	}
	
	/* 编辑时判断数据有没有填写完整 */
	function decideInputAndSelectHasValue(){
		var inputValue=true;
		var selectValue=true;
		$("#editDiv input[type='text']").each(function(index, val){	
			if(!$(val).hasClass("hidden")){				
				if($(val).val()==""&&$(val).attr("class")!="searchable-select-input"){
				inputValue=false;
				console.log("inputValue",inputValue);
				console.log("$(val)",$(val).attr("id"));
				}	
			}
				
		});	
		$("#editDiv select").each(function(index, val){	
			if(!$(val).hasClass("hidden")){
				if($(val).val()==-1){
					selectValue=false;
					console.log("inputValue",inputValue);
					console.log("$(val)",$(val).attr("id"));
				}
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
	function procureTableDataToJSON(){
		var prepaidAmount;
		if($("#edit_payType").val()==1){
			prepaidAmount=$("#edit_prepaidAmount").val();
		}
		else{
			prepaidAmount=null;
		}
		var supctoId;
		
		if($("#edit_supctoId").val()==null||$("#edit_supctoId").val()-0<=0){
			supctoId=null
		}
		else{
			supctoId=$("#edit_supctoId").val();
		}
		console.log("edit_supctoId",$("#edit_supctoId").val());
		console.log("supctoId",supctoId);
		//采购订单基础的信息
		 var  procureTableDataJSON={"id":$("#edit_purchase_id").val(),"generateDateString":$("#edit_generateDate").val(),"identifier":$("#edit_identifier").val(),"supctoId":supctoId,"orderer":$("#edit_orderer").val(),"effectivePeriodEndString":$("#edit_effectivePeriodEnd").val(),
				"transportationMode":$("#edit_transportationMode").val(),"contractNumber":$("#edit_contractNumber").val(),"deliveryman":$("#edit_deliveryman").val(),"goodsArrivalTimeString":$("#edit_goodsArrivalTime").val(),
				"fax":$("#edit_fax").val(),"goodsArrivalPlace":$("#edit_goodsArrivalPlace").val(),"phone":$("#edit_phone").val(),"payType":$("#edit_payType").val(),"prepaidAmount":prepaidAmount,"summary":$("#edit_summary").val(),
				"procureCommoditys":[]}; 
		//获取采购商品的信息，添加到采购订单的商品信息里
		$("#edit_goodDiv .procureCommodity").each(function(index, val){
				
			var procureCommodityDataJSON={"id":$(val).find(".edit_purchase_commodity_id").val(),"commodityId":$(val).find(".edit_commodity_specifications_id").val(),"procureTableId":$("#edit_purchase_id").val(),"taxRate":$(val).find(".edit_procureCommodity_taxRate").val(),"amountOfTax":$(val).find(".edit_procureCommodity_amountOfTax").val(),"orderNum":$(val).find(".edit_procureCommodity_orderNum").val(),
					"lotNumber":$(val).find(".edit_procureCommodity_lotNumber").val(),"originalUnitPrice":$(val).find(".edit_procureCommodity_originalUnitPrice").val(),"discount":$(val).find(".edit_procureCommodity_discount").val(),"businessUnitPrice":$(val).find(".edit_procureCommodity_businessUnitPrice").val(),
					"remarks":$(val).find(".edit_procureCommodity_remarks").val(),"containsTaxPrice":$(val).find(".edit_procureCommodity_containsTaxPrice").val(),"paymentForGoods":$(val).find(".edit_procureCommodity_paymentForGoods").val(),"totalTaxPrice":$(val).find(".edit_procureCommodity_totalTaxPrice").val()};	
				
			procureTableDataJSON.procureCommoditys[index]=procureCommodityDataJSON;	
			});
			
		
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
			//重新计算合计信息
				var totalTaxPrice=0;
				var totalOrderNum=0;
				var totalAmountOfTax=0;
				$(".edit_procureCommodity_totalTaxPrice").each(function(){
		 			totalTaxPrice+=parseFloat($(this).val());

				});
				$(".edit_procureCommodity_orderNum").each(function(){
					totalOrderNum+=parseFloat($(this).val());

				}); 
				$(".edit_procureCommodity_amountOfTax").each(function(){
					totalAmountOfTax+=parseFloat($(this).val());

				});
				$("#add_total_totalTaxPrice").html(totalTaxPrice);
				$("#add_total_orderNum").html(totalOrderNum);
				$("#add_total_amountOfTax").html(totalAmountOfTax);
			}else{
				layfail("商品不能为空");
			}
			
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
		}
		else{
			$(e).parents(".procureCommodity").find(".edit_procureCommodity_businessUnitPrice").val("");	
		}
		
		getAmountOfTax(e);
	}
	
	/* 获取税额和价税合计  */
	function getAmountOfTax(e){
		//税额=订货数量*业务单价*税率
		//价税合计=订货数量*业务单价*（1+税率）
		
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
				if(taxRateInput!=""&&taxRateInput>0){
					var taxRate=taxRateInput-0;
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_amountOfTax").val((taxRate*orderNum*businessUnitPrice).toFixed(2));
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalTaxPrice").val((orderNum*businessUnitPrice*(1+taxRate)).toFixed(2));	
				}
				else{
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_amountOfTax").val("0");	
					$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalTaxPrice").val((orderNum*businessUnitPrice*(1)).toFixed(2));	
				}
			}
			else{
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_amountOfTax").val("");	
				$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalTaxPrice").val("");	
			}
		}
		else{
			$(e).parents(".procureCommodity").find(".edit_procureCommodity_amountOfTax").val("0");	
			$(e).parents(".procureCommodity").find(".edit_procureCommodity_totalTaxPrice").val("0");	
		}
		var totalTaxPrice=0;
		var totalOrderNum=0;
		var totalAmountOfTax=0;
		$(".edit_procureCommodity_totalTaxPrice").each(function(){
 			totalTaxPrice+=parseFloat($(this).val());

		});
		$(".edit_procureCommodity_orderNum").each(function(){
			totalOrderNum+=parseFloat($(this).val());

		}); 
		$(".edit_procureCommodity_amountOfTax").each(function(){
			totalAmountOfTax+=parseFloat($(this).val());

		});
		$("#add_total_totalTaxPrice").html(totalTaxPrice);
		$("#add_total_orderNum").html(totalOrderNum);
		$("#add_total_amountOfTax").html(totalAmountOfTax);
		 

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