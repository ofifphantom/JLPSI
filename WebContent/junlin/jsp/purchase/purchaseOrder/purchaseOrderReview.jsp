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
		<title>采购订单审核</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		
		
		<style>
			#editDiv {
				padding-top: 20px;
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
					<h4 class="text-title">采购订单审核</h4>
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
	 					<span class="l_f" style="margin-left:19px"> 
							起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
						</span>
 								<span class="r_f"> 
								<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<!--<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="purchaseOrderRefresh()" style="margin-right: 0;"><i class="fa fa-refresh"></i>刷新</button>
						</span>-->
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="purchaseOrderTimes()"><i class="fa fa-times"></i> 驳回</button>
						</span>
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="purchaseOrderCheck()"><i class="fa fa-check"></i> 通过</button>
						</span>
						
						<span class="jl_f_l">
							<input type="checkbox" id="checkAll" style="margin:0 5px 0 0;" onclick="checkboxController(this)"/>
						</span>
						<span class="jl_f_l">
							<label for="checkAll">全选</label>
						</span>

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
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
								<!-- <tr>
									<td>
										<input type="checkbox" name="id" onclick="checkboxClick('#checkAll')" />
									</td>
									<td>
										<span class="look-span" onclick="purchaseOrderDetail()">PO.2017.09.00054</span>
									</td>
									<td>嘉和</td>
									<td>椒叶黄瓜</td>
									<td>9.8</td>
									<td>300</td>
									<td>2940</td>
									<td>2017.10.02</td>
									<td>未审核</td>
									<td>
										<input type="button" class="btncss edit" onclick="purchaseOrderDetail()" value="详情" />
									</td>
								</tr> -->
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
						<div class="col-xs-8"  id="look_payType">123456</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">单号：</label>
						<div class="col-xs-8" id="look_identifier">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">订货人：</label>
						<div class="col-xs-8"  id="look_orderer">123456</div>
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
			<div id="look_goodDiv">
				
				
			</div>
	<!-- 		<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">货品编码：</label>
						<div class="col-xs-8" id="look_commodity_identifier">123456</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">规格：</label>
						<div class="col-xs-8" id="look_commodity_specifications">123456</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">单位：</label>
						<div class="col-xs-8" id="look_commodity_unit">123456</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">到货数量：</label>
						<div class="col-xs-8" id="look_procureCommodity_arrivalQuantity">123456</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">折扣%：</label>
						<div class="col-xs-8" id="look_procureCommodity_discount">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">税率：</label>
						<div class="col-xs-8" id="look_procureCommodity_taxRate">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">价税合计：</label>
						<div class="col-xs-8" id="look_procureCommodity_totalTaxPrice">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">中止数量：</label>
						<div class="col-xs-8" id="look_procureCommodity_suspendQuantity">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">赠品：</label>
						<div class="col-xs-8" id="look_procureCommodity_isLargess">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">到货日期：</label>
						<div class="col-xs-8" id="look_procureCommodity_arrivalDate">123456</div>
					</div>

				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">货品名称：</label>
						<div class="col-xs-8" id="look_commodity_name">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">品牌：</label>
						<div class="col-xs-8" id="look_commodity_brand">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">订货数量：</label>
						<div class="col-xs-8" id="look_procureCommodity_orderNum">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">原始单价：</label>
						<div class="col-xs-8" id="look_procureCommodity_originalUnitPrice">123456</div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">业务单价：</label>
						<div class="col-xs-8" id="look_procureCommodity_businessUnitPrice">123456</div>
					</div>

					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">税额：</label>
						<div class="col-xs-8" id="look_procureCommodity_amountOfTax">123456</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">批号：</label>
						<div class="col-xs-8" id="look_procureCommodity_lotNumber">123456</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">中止金额：</label>
						<div class="col-xs-8"  id="look_procureCommodity_suspendPrice">123456</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">备注：</label>
						<div class="col-xs-8" id="look_procureCommodity_remarks">123456</div>
					</div>
					

				</div>
			</div> -->


			
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
		
	</body>

	<script>
	
	var oTable1;
	$("#btn_search").click(function() {
		$("#checkAll").removeAttr("checked");
		oTable1.fnDraw();
	});
	jQuery(function($) {
		laydate.render({
			elem: "#query_time",
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
							"page":2,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": $("#query_supctoId").val(),
							"planOrOrder":2,
							"queryTime":$("#query_time").val()
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

									},{
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
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {			
											return '<td><input type="button" class="btncss edit" onclick=\'purchaseOrderDetail(' + data + ')\' value="详情" /></td>';
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
		</div> 
		<div class="form-group">
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
					//页面赋值
					//基本信息
					if(data.generateDate == null || data.generateDate == ""){
						$("#look_entry_time").html("");
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
						if(data.procureCommoditys[i].arrivalDate!=null){
							$("#goodsMsg"+(i+1)+" .look_procureCommodity_arrivalDate").html(getSmpFormatDateByLong(data.procureCommoditys[i].arrivalDate,false));
						}
						else{
							$("#goodsMsg"+(i+1)+" .look_procureCommodity_arrivalDate").html("");
						}
						
					}
					//合计
					$("#look_total_orderNum").html(total_orderNum);
					$("#look_total_amountOfTax").html(total_amountOfTax);
					$("#look_total_totalTaxPrice").html(total_totalTaxPrice);
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
				type: 1,
				title: "采购订单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#lookDiv"),
				btn: ['关闭'],
				/* end: function(index) {
					$("#look_goodDiv").html("");
				} */
				
			});
		}
		
		/*驳回*/
		function purchaseOrderTimes() {
			
			var ids=[];
			var boxes = $("input[name='id']");
			for(var i=0;i<boxes.length;i++){
		        if(boxes[i].checked == true){
		            ids.push(boxes[i].value);
		        }
		    }
			
			if(ids.length<=0){
				laywarn("请选择数据!");
				return;
			}
			
			publicMessageLayer("驳回所选订单的审核", function() {
				$.ajax({
					url :'<%=basePath%>purchase/procuretable/updateStateByIds',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
						"state" : 4
						
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
		/*通过*/
		function purchaseOrderCheck() {
			
			var ids=[];
			var boxes = $("input[name='id']");
			for(var i=0;i<boxes.length;i++){
		        if(boxes[i].checked == true){
		            ids.push(boxes[i].value);
		        }
		    }
			
			if(ids.length<=0){
				laywarn("请选择数据!");
				return;
			}
			
			publicMessageLayer("通过所选订单的审核", function() {
				$.ajax({
					url :'<%=basePath%>purchase/procuretable/updateStateByIds',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
						"state" : 3
						
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
		
		function accountDetail(thisimg){
			layer.photos({
			  photos: '#accountShowDiv .jl-panel>div>div'
			  ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
			});
		}
	</script>
</html>