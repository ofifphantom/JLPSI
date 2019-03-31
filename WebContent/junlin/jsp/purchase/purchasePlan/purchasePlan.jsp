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

		<style type="text/css">
			#detailDiv,
			#editDiv {
				margin: 50px auto;
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
					<h4 class="text-title">采购计划单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
								单号： <input  type="text" value="" id="query_identifier"  maxlength="100"/>
							</span>
							<span class="l_f"> 
								供应商名称： <input type="text" value="" id="query_supctoId"  maxlength="100"/>
							</span>
							<span class="l_f"> 
								货品名称： <input type="text"  value="" id="query_goodsName"  maxlength="100"/>
							</span>
							
							是否生成订单：<select id=isPlan name="">
								<option value="" selected="selected">--请选择--</option>
								<option value="1">未生成</option>
								<option value="2" >已生成</option>	 
							</select>
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
						<span class="r_f">
							<button type="button" class="btncss jl-btn-defult purchasePlanAddBtn" style="margin-right: 0;">
								<i class="fa fa-plus"></i>新增
							</button>
						</span>
					</div>
					<div class="table_menu_list">
						<form id="datatable_form">
							<table class="table table-striped table-hover col-xs-12" id="datatable">
								<thead class="table-header">
									<tr>
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
					<!-- 				<tr>
										<td><span class="look-span purchasePlanDetailBtn" attr-tid="0">1321</span></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>
											<input type="button" class="btncss edit purchasePlanDetailBtn" attr-tid="0" value="详情" />
											<input type="button" class="btncss edit toPurchaseOrderBtn" attr-tid="0" value="生成采购订单" />
										</td>
									</tr> -->
									
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!--详情 -->
		<div id="detailDiv" style="display: none;">

		</div>
		<!--新增 编辑-->
		<div id="editDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div id="headEdit" class="jl-panel">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">供应商</label>
								<div class="col-xs-8" id="edit_supctoIdDiv">
									<select id="edit_supcto_id" class="form-control">
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">有效期至</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_effectivePeriodEnd" readonly="readonly" placeholder="请选择有效期" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">到货时间</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_goodsArrivalTime" readonly="readonly" placeholder="请选择到货时间" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">到货地址</label>
								<div class="col-xs-8">
									<!-- <input type="text" class="form-control" id="edit_goodsArrivalPlace" onkeyup="cky(this)" maxlength="100" /> -->
									<select id="edit_goodsArrivalPlace" class="form-control">
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">订货人</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_orderer" onkeyup="cky(this)" maxlength="100" />
								</div>
							</div>
						</div>

						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">运输方式</label>
								<div class="col-xs-8">
									<select id="edit_transportationMode" class="form-control">
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">联系人</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_deliveryman" onkeyup="cky(this)" maxlength="100" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">传真</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_fax" onkeyup="cky(this)" maxlength="100" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">联系电话</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_phone" onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="11" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">付款方式</label>
								<div class="col-xs-8">
									<select class="form-control" id="edit_payType">
									</select>
								</div>
							</div>
						</div>
					</div>

				</div>

				<div class="row">
					<div class="jl-title l_f" style="text-align: left;">
						<span>商品</span>
					</div>
					<div class="r_f">
						<button type="button" class="btncss jl-btn-importent goodsAddBtn">新增</button>
					</div>
					<div class="r_f">
						<div class="form-group">
							<div class="col-xs-12" id="edit_goodDiv">
								<input id="edit_goods" class="form-control" value="请先选择供应商" disabled />
							</div>
						</div>
					</div>

				</div>
				<div class="nonowrap-table-div">
					<table class="table table-bordered table-striped table-hover" border="" cellspacing="0" cellpadding="0">
						<tbody id="goodsTbody">
							<tr>
								<th nowrap="nowrap">货品名称</th>
								<th nowrap="nowrap">规格编码</th>
								<th nowrap="nowrap">规格</th>
								<th nowrap="nowrap">品牌</th>
								<th nowrap="nowrap">单位</th>
								<th nowrap="nowrap">税率</th>
								<th nowrap="nowrap">原始单价</th>
								<th nowrap="nowrap">业务单价</th>
								<th nowrap="nowrap">业务数量</th>
								<th nowrap="nowrap">税额</th>
								<th nowrap="nowrap">折扣%</th>
								<th nowrap="nowrap">批号</th>
								<th nowrap="nowrap">含税价</th>
								<th nowrap="nowrap">货款</th>
								<th nowrap="nowrap">金额</th>
								<th nowrap="nowrap">备注</th>
								<th nowrap="nowrap">操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="17">请先选择商品</td>
							</tr>
						</tbody>
					</table>

				</div>
				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div id="countEdit" class="jl-panel">
					<div class="row">

						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务数量</label>
								<div class="col-xs-8">
									<input type="text" id="edit_total_orderNum" value="" class="form-control" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">税额</label>
								<div class="col-xs-8">
									<input type="text" id="edit_total_amountOfTax" value="" class="form-control" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">货款</label>
								<div class="col-xs-8">
									<input type="text" id="edit_total_paymentForGoods" value="" class="form-control" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">金额</label>
								<div class="col-xs-8">
									<input type="text" id="edit_total_totalPrice" value="" class="form-control" disabled="disabled" />
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div id="footerEdit" class="jl-panel">
					<div class="row">

						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input type="text" id="edit_summary" value="无" class="form-control" onkeyup="cky(this)" maxlength="100" />
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="text-danger">注：该页面所有字段（除去摘要）均为必填</div>
			</form>
		</div>

	</body>

	<script>
		//立即执行函数
		(function(dom) {
			
			let order = {
				config: { //字段配置，存储变量
					title:"采购计划单",
					dataTable: {}, //该字段用于存储datadtable
					supctoId:-1,//用于记录当前选中的供应商
					goodsSelectData:[],//用于存储当前选中的供应商的所有商品
					goodsTable: {
						head: `<tr>
							<th nowrap="nowrap">货品名称</th>
							<th nowrap="nowrap">规格编码</th>
							<th nowrap="nowrap">规格</th>
							<th nowrap="nowrap">品牌</th>
							<th nowrap="nowrap">单位</th>
							<th nowrap="nowrap">税率</th>
							<th nowrap="nowrap">原始单价</th>
							<th nowrap="nowrap">业务单价</th>
							<th nowrap="nowrap">业务数量</th>
							<th nowrap="nowrap">税额</th>
							<th nowrap="nowrap">折扣%</th>
							<th nowrap="nowrap">批号</th>
							<th nowrap="nowrap">含税价</th>
							<th nowrap="nowrap">货款</th>
							<th nowrap="nowrap">金额</th>
							<th nowrap="nowrap">备注</th>
							<th nowrap="nowrap">操作</th>
						</tr>`,
						tipTr: '<tr class="tipTr"><td colspan="17">请先选择商品</td></tr>',
						goodsArr: [] //用于存储添加到table中的商品的id
					},
					prepaidAmountForm:`<div class="col-xs-6 prepaidAmountForm">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">预付金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_prepaidAmount" onkeyup="pressMoney(this)" />
								</div>
							</div>
						</div>`

				},
				init: function() { //初始化方法
					this.initDataTable();
					this.initEvent();
					this.initTransportationSelect("#edit_transportationMode");
					this.initPayTypeSelect("#edit_payType");
					this.initWarehouseSelect("#edit_goodsArrivalPlace");
					latdateNoBefore("#edit_effectivePeriodEnd");
					latdateNoBefore("#edit_goodsArrivalTime");
				},
				initEvent: function() {
					let that = this;
					//事件绑定
					//新增采购计划单
					$(".purchasePlanAddBtn").on("click", () => {
						this.purchasePlanAddEvent();
					})
					//新增商品
					$(".goodsAddBtn").on("click", () => {
						this.goodsAddEvent();
					})
					//搜索 刷新datatable
					$("#btn_search").on("click", () => {
						//this.refreshDataTable();
						this.config.dataTable.fnDraw();
					})
					//付款方式
					$("#edit_payType").on("change",function(){
						if($(this).val()==1)that.setPrepaidAmountForm();
						else that.clearPrepaidAmountForm();
					})

					/*事件委托 begin*/
					//详情采购计划单
					$("#datatable").delegate(".purchasePlanDetailBtn", "click", function() {
						that.purchasePlanDetailEvent($(this).attr("attr-tid"));
					})
					//生成采购订单
					$("#datatable").delegate(".toPurchaseOrderBtn", "click", function() {
						that.toPurchaseOrderEvent($(this).attr("attr-data"));
					})
					//删除商品
					$("#goodsTbody").delegate(".goodsDelBtn", "click", function() {
						that.goodsDelEvent(this, $(this).attr("attr-tid"));
					})
					//税率 监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_taxRate", "keyup blur", function() {
						pressSmallNumZero(this);
						that.setGoodsInfor(this);
					})
					//原始单价  监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_originalUnitPrice", "keyup blur", function() {
						pressMoney(this);
						that.setGoodsInfor(this);
					})
					//业务数量  监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_orderNum", "keyup blur", function() {
						pressInteger(this);
						that.setGoodsInfor(this);
					})
					//折扣  监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_discount", "keyup blur", function() {
						pressIntegersOneHundred(this);
						that.setGoodsInfor(this);
					})
					/*事件委托 end*/
					
					/*初始化起止时间*/
					laydate.render({
						elem: "#query_time",
						range:'~'
					});

				},
				initSupctoSelect: function() {
					//初始化供应商
					$("#edit_supcto_id").parent().html('<select id="edit_supcto_id" class="form-control"></select>');
					 
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
									$("#edit_supcto_id").append("<option value='-1' selected>--请选择供应商--</option>");
									for(var i=0;i<data.length;i++){							
										var option = $("<option value='"+data[i].id+"' attr-fax='"+data[i].fax+"' attr-commonPhone='"+data[i].commonPhone+"' attr-settlementTypeId='"+data[i].settlementTypeId+"' attr-contactPeople='"+data[i].contactPeople+"'>"
												+ data[i].name + "</option>");
										$("#edit_supcto_id").append(option);
									}
								}
								$("#edit_supcto_id").searchableSelect();
							}
						});
				},
				initGoodsSelect: function(supctoId) {
					let that = this;
					if(supctoId == -1) {
						this.initGoodsSelectDisabled();
						return;
					}
					
					//初始化商品 
					$("#edit_goods").parent().html('<select id="edit_goods" class="form-control"></select>');
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
								
								var options='<option value="-1">--请选择商品--</option>';
								for(var i=0;i<data.length;i++){
									options+='<option value="'+data[i].id+'">'+data[i].commodity.name + " "+data[i].specificationName+'</option>';
								}
								$("#edit_goods").html(options);
								$("#edit_goods").searchableSelect();
								
								that.config.goodsSelectData=data;
							}
						});
				},
				initGoodsSelectDisabled: function() {
					//商品选择框禁用
					$("#edit_goods").parent().html('<input id="edit_goods" class="form-control" value="请先选择供应商" disabled />');
				},
				initTransportationSelect: function(transportationSelect) {
					//初始化运输方式  
					let $select = $(transportationSelect);
					$.ajax({
						url: '<%=basePath%>basic/shippingMode/getAllShippingMode',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						success: function(data) {
					 	var options='<option value="-1">--请选择运输方式--</option>';
						 
 								for(var i=0;i<data.length;i++){							
									  options+='<option value="'+data[i].id+'">'+data[i].name+'</option>';
								}
 								$select.html(options);
						}
					});
				},
				initPayTypeSelect: function(payTypeSelect) {
					//初始化付款方式 
					let $select = $(payTypeSelect);
					$.ajax({
						url: '<%=basePath%>basic/settlementType/getAllSettlementType',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						success: function(data) {
							var options='<option value="-1">--请选择付款方式--</option>';
 							 
								for(var i=0;i<data.length;i++){							
								  options+='<option value="'+data[i].id+'">'+data[i].name+'</option>';
							}
								$select.html(options);
						}
					});
				},
				initWarehouseSelect: function(warehouseSelect){
					//初始到货地址---仓库信息 
					let $select = $(warehouseSelect);
					$.ajax({
						url: '<%=basePath%>basic/warehouse/selectAllWarehouse',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						success: function(data) {
							$select.html("");
							if(data.length==0){
								$select.append("<option value='-1' selected>--暂无数据，请到仓库页面进行添加--</option>");
							}
							else{
								$select.append("<option value='-1' selected>--请选择到货仓库--</option>");
								for(var i=0;i<data.length;i++){							
									var option = $("<option value='"+data[i].name+"'>"
											+ data[i].name + "</option>");
									$select.append(option);
								}
							}
						}
					});
				},
				initDataTable: function() {
 
					 this.config.dataTable= $('#datatable')
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
									"planOrOrder":1,
									"queryTime":$("#query_time").val(),
									"isPlan":$("#isPlan").val()
										
								});
							},
							"url": "<%=basePath%>purchase/procuretable/getProcureTableMsg"
									},

									"aoColumns" : [
 
											{
												"mData" : "identifier",
												"bSortable" : false,
												"sWidth" : "15%",
												"sClass" : "center",
												"mRender" : function(data, type, row) {
 													return '<td><span class="look-span purchasePlanDetailBtn" attr-tid="'+row.id+'">'+data+' </span></td>';
													
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
														return '<td><input type="button" class="btncss edit purchasePlanDetailBtn" attr-tid=\''+row.id+'\'   value="详情" /></td>'
													}
													else{
														return '<td><input type="button" class="btncss edit toPurchaseOrderBtn" attr-data=\''+JSON.stringify(row)+'\'  value="生成采购订单" /></td>'
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
					
					//console.log(this.config.dataTable);
				},
				refreshDataTable: function() {
					this.config.dataTable.fnDraw(this);
				},
				getPurchasePlan: function() {
					let formData = {};
 					 var prepaidAmount;
	 					if($("#edit_payType").val()==1){
							prepaidAmount=$("#edit_prepaidAmount").val();
						}
						else{
							prepaidAmount=null;
						}
						var supctoId=$("#edit_supcto_id").val();
				 
						   formData={"id":$("#edit_procure_table_id").val(),"identifier":$("#edit_identifier").val(),"supctoId":$("#edit_supcto_id").val(),"effectivePeriodEndString":$("#edit_effectivePeriodEnd").val(),"goodsArrivalTimeString":$("#edit_goodsArrivalTime").val(),"goodsArrivalPlace":$("#edit_goodsArrivalPlace").val(),"transportationMode":$("#edit_transportationMode").val(),
									"deliveryman":$("#edit_deliveryman").val(),"fax":$("#edit_fax").val(),
									"phone":$("#edit_phone").val(),"orderer":$("#edit_orderer").val(),"prepaidAmount":prepaidAmount,"summary":$("#edit_summary").val(),"payType":$("#edit_payType").val(),
									"procureCommoditys":[]};
							//获取采购商品的信息，添加到采购订单的商品信息里
							$("#goodsTbody tr").each(function(index, val){
								
								if(index==0){
									return;
								}
 		   						var procureCommodityDataJSON={"id":$(val).find(".edit_purchase_commodity_id").val(),"commodityId":$(val).find(".goodsDelBtn").attr("attr-tid"),"procureTableId":$("#edit_purchase_id").val(),"taxRate":$(val).find(".edit_procureCommodity_taxRate").val(),"amountOfTax":$(val).find(".edit_procureCommodity_amountOfTax").val(),"orderNum":$(val).find(".edit_procureCommodity_orderNum").val(),
										"lotNumber":$(val).find(".edit_procureCommodity_lotNumber").val(),"originalUnitPrice":$(val).find(".edit_procureCommodity_originalUnitPrice").val(),"discount":$(val).find(".edit_procureCommodity_discount").val(),"businessUnitPrice":$(val).find(".edit_procureCommodity_businessUnitPrice").val(),
										"remarks":$(val).find(".edit_procureCommodity_remarks").val(),"containsTaxPrice":$(val).find(".edit_procureCommodity_containsTaxPrice").val(),"paymentForGoods":$(val).find(".edit_procureCommodity_paymentForGoods").val(),"totalPrice":$(val).find(".edit_procureCommodity_totalPrice").val()
										};	
									
								formData.procureCommoditys.push(procureCommodityDataJSON);	
								});  
					return formData;
				},
				getGoodsTrInfor: function(thisInput) {
					//获取商品表格某一行字段，用于计算
					return {
						"taxRate": $(thisInput).parents("tr").find(".edit_procureCommodity_taxRate").val(),
						"originalUnitPrice": $(thisInput).parents("tr").find(".edit_procureCommodity_originalUnitPrice").val(),
						"orderNum": $(thisInput).parents("tr").find(".edit_procureCommodity_orderNum").val(),
						"discount": $(thisInput).parents("tr").find(".edit_procureCommodity_discount").val(),
						"businessUnitPrice": $(thisInput).parents("tr").find(".edit_procureCommodity_businessUnitPrice").val(),
						"containsTaxPrice": $(thisInput).parents("tr").find(".edit_procureCommodity_containsTaxPrice").val(),
					};
				},
				setGoodsInfor: function(thisInput) {
					//计算业务单价、税额、含税价、货款、金额
					let gInfo = this.getGoodsTrInfor(thisInput);

					gInfo.businessUnitPrice = this.countBusinessUnitPriceFun(gInfo.originalUnitPrice, gInfo.discount);
					$(thisInput).parents("tr").find(".edit_procureCommodity_businessUnitPrice")
						.val(gInfo.businessUnitPrice); //业务单价

					$(thisInput).parents("tr").find(".edit_procureCommodity_amountOfTax")
						.val(this.countAmountOfTaxFun(gInfo.orderNum, gInfo.businessUnitPrice, gInfo.taxRate)); //税额

					gInfo.containsTaxPrice = this.countContainsTaxPriceFun(gInfo.businessUnitPrice, gInfo.taxRate);
					$(thisInput).parents("tr").find(".edit_procureCommodity_containsTaxPrice")
						.val(gInfo.containsTaxPrice); //含税价

					$(thisInput).parents("tr").find(".edit_procureCommodity_paymentForGoods")
						.val(this.countPaymentForGoodsFun(gInfo.containsTaxPrice, gInfo.orderNum)); //货款

					$(thisInput).parents("tr").find(".edit_procureCommodity_totalPrice")
						.val(this.countTotalPriceFun(gInfo.containsTaxPrice, gInfo.orderNum)); //金额
					//合计
					this.countTotalFun();

				},
				purchasePlanAddEvent: function() {
					//新增采购计划单
					//console.log("新增采购计划单");
					$("#edit_summary").val("无");
					let that=this;
					//初始化供应商
					this.initSupctoSelect();
					$("#edit_orderer").val('<%=session.getAttribute("userName")%>');
					layer.open({
						type: 1,
						title: "新增"+that.config.title,
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#editDiv"),
						scrollbar: false,
						btn: ['提交', '取消'],
						yes: index => {
							if(!this.checkFormisFilledLayerFun() || !this.checkFormRuleLayerFun()) return;
 
							var formdata = this.getPurchasePlan(); //获取页面数据的值，用于提交到后台
							$.ajax({
								url: '<%=basePath%>purchase/procuretable/addPurchaseOrder?planOrTable='+1,
								type: "POST",
								dataType: "json",
								data:{
									"procureTable":JSON.stringify(formdata)
								},
								async: false,
								cache: false,
								success: function(data) {
									layer.close(index);
									that.refreshDataTable(); //刷新datatable
									laysuccess("新增成功");
								}
							});
							
						},
						end: (index, layero) => {
							layer.close(index);
							clearForm("editDiv", "");
							this.config.supctoId=-1;
							this.clearGoodsEvent();
							this.initGoodsSelectDisabled();
							this.clearPrepaidAmountForm();
							
						}
					});
				},
				purchasePlanDetailEvent: function(tid) {
					//采购计划单详情
					//console.log("采购计划单详情"+tid);
					var that=this;
					$.ajax({
						type: "post",
						url: "<%=basePath%>/purchase/procuretable/detailPurchasePlanOrder",
						dataType: "json",
						data: {
							"id": tid
						},
						success: function(res) {
							let bill = new DetailBill(res);
							let $content = bill.toPrint();
							$("#detailDiv").html($content);
						}
					});
					layer.open({
						type: 1,
						title: that.config.title+"详情",
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#detailDiv"),
						btn: ['关闭']
					});
				},
				toPurchaseOrderEvent: function(row) {
					row=$.parseJSON(row);
					var that=this;
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
 									laysuccess("已生成采购订单，请至采购订单管理页面查看相应订单");
 									that.refreshDataTable();
							 
							}
						});
					})
					
				},
				goodsAddEvent: function() {
					//新增商品
					//console.log("新增商品事件");
					
					let goodsId = $("#edit_goods").val(); //编码
					let goodsName = "名称"; //名称
					let goodsNum = "名称"; //规格编码
					let goodsType = "规格"; //规格
					let goodsLogo = "品牌"; //品牌
					let goodsUnit = "单位"; //单位
					let goodsTax = 0; //税率
					let unitPrice="";//原始单价
					let data=this.config.goodsSelectData;
					/*
					 * 请根据之前存储到this.config.goodsSelectData进行循环
					 * 找到对应编码商品为名称、规格、品牌、单位赋值
					 */
					 for(var i=0;i<data.length;i++){
						 //console.log("data============",data);
						if(data[i].id==goodsId){
							goodsName=data[i].commodity.name;
							goodsNum=data[i].specificationIdentifier;
							goodsType=data[i].specificationName;
							goodsLogo=data[i].commodity.brand;
							goodsUnit=data[i].baseUnitName;
							goodsTax=data[i].commodity.taxes;
							if(data[i].specOriginalUnitPrice!=null&&data[i].specOriginalUnitPrice>0){
								unitPrice=data[i].specOriginalUnitPrice;
							}
							break;
						}
						
					}
					
						if(goodsId=="请先选择供应商"){
							layfail("请先选择供应商!");
						}
						else if(goodsId == -1) {
						layfail("请先选择商品!");
					} else if(!this.checkRepeatFun(this.config.goodsTable.goodsArr, goodsId)) {
						$(".tipTr").remove();
						this.config.goodsTable.goodsArr.push(goodsId);
						$("#goodsTbody").append(`<tr>
							<td>` + goodsName + `</td>
							<td>` + goodsNum + `</td>
							<td>` + goodsType + `</td>
							<td>` + goodsLogo + `</td>
							<td>` + goodsUnit + `</td>
							<td><input type="text" id="" value="`+goodsTax+`" class="form-control edit_procureCommodity_taxRate" attr-name="税率" /></td>
							<td><input type="text" id="" value="` +unitPrice+ `" class="form-control edit_procureCommodity_originalUnitPrice" attr-name="原始单价"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_businessUnitPrice" value="` +unitPrice+ `"  placeholder="先填写原始单价" disabled="disabled" /></td>
							<td><input type="text" id="" value="" class="form-control edit_procureCommodity_orderNum"  maxlength="9" attr-name="业务数量"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_amountOfTax" placeholder="先填写税率、原始单价、业务数量" disabled="disabled" /></td>
							<td><input type="text" id="" value="" class="form-control edit_procureCommodity_discount"  maxlength="9" attr-name="折扣"/></td>
							<td><input type="text" id="" value="0000" class="form-control edit_procureCommodity_lotNumber" onkeyup="cky(this)" attr-name="批号"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_containsTaxPrice" placeholder="请先填写税率、原始单价" disabled="disabled" /></td>
							<td><input type="text" class="form-control edit_procureCommodity_paymentForGoods" placeholder="请先填写税率、原始单价、业务数量" disabled="disabled" /></td>
							<td><input type="text" class="form-control edit_procureCommodity_totalPrice" placeholder="先填写税率、原始单价、业务数量" disabled="disabled" /></td>
							<td><input type="text" id="" value="无" class="form-control edit_procureCommodity_remarks" onkeyup="cky(this)" attr-name="备注"/></td>
							<td><input type="button" class="btncss edit goodsDelBtn" attr-tid="` + goodsId + `" value="删除" /></td>
						</tr>`);
					} else {
						layfail("请勿重复选择商品！");
					}
				},
				goodsDelEvent: function(thisbtn, id) {
					//删除商品
					this.config.goodsTable.goodsArr.remove(id);
					$(thisbtn).parents("tr").remove();
					if($("#goodsTbody tr").length == 1) {
						$("#goodsTbody").append(this.config.goodsTable.tipTr);
					}
					this.countTotalFun();
					
				},
				clearGoodsEvent: function() {
					//清空商品
					$("#goodsTbody").html(this.config.goodsTable.head + this.config.goodsTable.tipTr);
					this.config.goodsTable.goodsArr = [];
					this.config.goodsSelectData=[];
				},
				setPrepaidAmountForm:function(){
					if($(".prepaidAmountForm").length==0) $("#headEdit .row").append(this.config.prepaidAmountForm);
				},
				clearPrepaidAmountForm:function(){
					$(".prepaidAmountForm").remove();
				},
				checkRepeatFun: function(arr, id) {
					//查重
					let flag = false;
					for(var i in arr) {
						if(arr[i] == id) {
							flag = true;
						}
					}
					return flag;
				},
				checkFormRuleLayerFun: function() {
					//检查手机号和传真格式是否正确，正确返回true，相反返回false
					if(!checkFax($("#edit_fax").val())) {
						layfail("请输入正确的传真");
						return false;
					} else if(!checkMobilePhone($("#edit_phone").val())) {
						layfail("请输入正确的联系电话");
						return false;
					}
					return true;
				},
				checkInputEmptyLayer:function(thisInput){
					//判断footer或者header中Input框为空时弹出layer
					var $input=$(thisInput);
					var name=$input.parents(".form-group").find(".control-label").text();
					layfail(name+"不能为空");
				},
				checkTableInputEmptyLayer:function(thisInput){
					//判断table中Input框为空时弹出layer
					var $input=$(thisInput);
					var name=$input.attr("attr-name");
					layfail(name+"不能为空");
				},
				checkFormisFilledFun: function() {
					//判断表单是否填写完整 填写完整返回true,相反返回false
					var res = true;
					var that=this;
					$("#headEdit input").each(function(index, val) {
						if($(val).val() == "" && (!$(val).hasClass("searchable-select-input"))&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
						if($(val).hasClass("searchable-select-input")&&that.config.supctoId==-1&&res){
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#headEdit select").each(function(index, val) {
						if($(val).val() == "-1"&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					if($(".tipTr").length > 0) {
						res = false;
						layfail("商品不能为空");
					}
					if(!res) return res;
					$("#goodsTbody input").each(function(index, val) {
						if($(val).val() == ""&&(!$(val).prop("disabled"))&&res) {
							that.checkTableInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#goodsTbody select").each(function(index, val) {
						if($(val).val() == "-1"&&res) {
							that.checkTableInputEmptyLayer(val);
							res = false;
						}
					});
					/* if(!res) return res;
					$("#footerEdit input").each(function(index, val) {
						if($(val).val() == ""&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#footerEdit select").each(function(index, val) {
						if($(val).val() == "-1"&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					}); */
					return res;
				},
				checkFormisFilledLayerFun: function() {
					let res = this.checkFormisFilledFun();
					//if(!res) layfail("表单未填写完整，请完善后提交");
					if(res){
						$("#goodsTbody input").each(function(index, val) {
							if($(val).hasClass("edit_procureCommodity_totalPrice")&&$(val).val()==0) {
								layfail("金额不能为0")
 								res = false;
 								return;
							}
						});
					}
					
					return res;
				},
				countBusinessUnitPriceFun: function(originalUnitPrice, discount) {
					//计算  业务单价=原始单价*折扣率
					if(!originalUnitPrice) return "";
					discount = discount || 100;
					return toDecimal2((originalUnitPrice - 0) * (discount - 0) * 0.01);
				},
				countAmountOfTaxFun: function(orderNum, businessUnitPrice, taxRate) {
					//计算 税额=业务数量*业务单价*税率
					if(!orderNum || !businessUnitPrice || !taxRate) return "";
					return toDecimal2((orderNum - 0) * (businessUnitPrice - 0) * (taxRate - 0));
				},
				countContainsTaxPriceFun: function(businessUnitPrice, taxRate) {
					//计算 含税价=业务单价*（1+税率）
					if(!businessUnitPrice || !taxRate) return "";
					return toDecimal2((businessUnitPrice - 0) * (1 + (taxRate - 0)));
				},
				countPaymentForGoodsFun: function(containsTaxPrice, orderNum) {
					//计算 货款=金额=含税价*数量
					if(!containsTaxPrice || !orderNum) return "";
					return toDecimal2((containsTaxPrice - 0) * (orderNum - 0));
				},
				countTotalPriceFun: function(containsTaxPrice, orderNum) {
					//计算 金额=货款=含税价*数量
					if(!containsTaxPrice || !orderNum) return "";
					return toDecimal2((containsTaxPrice - 0) * (orderNum - 0));
				},
				countTotalFun:function(){
					//计算合计
					$("#edit_total_orderNum").val(parseInt(this.countOneTotalFun(".edit_procureCommodity_orderNum")));//业务数量
					$("#edit_total_amountOfTax").val(this.countOneTotalFun(".edit_procureCommodity_amountOfTax"));//税额
					$("#edit_total_paymentForGoods").val(this.countOneTotalFun(".edit_procureCommodity_paymentForGoods"));//货款
					$("#edit_total_totalPrice").val(this.countOneTotalFun(".edit_procureCommodity_totalPrice"));//金额
					
				},
				clearTotalFun:function(){
					$("#edit_total_orderNum").val("");//业务数量
					$("#edit_total_amountOfTax").val("");//税额
					$("#edit_total_paymentForGoods").val("");//货款
					$("#edit_total_totalPrice").val("");//金额
					
				},
				countOneTotalFun:function(input){
					//计算
					$input=$(input);
					let total=0;
					$.each($input, function(index,obj) {
						total+=($(obj).val()-0);
					});
					return toDecimal2(total);
				},
				refurbishInput:function(supctoId){
					//更新传真和联系电话
					<%-- $.ajax({
						url: '<%=basePath%>/basic/supctoManager/getSupcto',
						type: "POST",
						dataType: "json",
						data:{
							"id":supctoId
						},
						async: false,
						cache: false,
						success: function(data) {
							$("#edit_fax").val(data.fax);
							$("#edit_phone").val(data.phone);
						}
					}); --%>
					if(supctoId!=-1){
						$("#edit_fax").val($("#edit_supcto_id").find("option:selected").attr("attr-fax"));
						$("#edit_phone").val($("#edit_supcto_id").find("option:selected").attr("attr-commonPhone"));
						$("#edit_deliveryman").val($("#edit_supcto_id").find("option:selected").attr("attr-contactPeople"));
						$("#edit_payType").val($("#edit_supcto_id").find("option:selected").attr("attr-settlementTypeId"));
						if($("#edit_payType").val()==1)this.setPrepaidAmountForm();
						else this.clearPrepaidAmountForm();
					}
					else{
						$("#edit_fax").val("请先选择供应商");
						$("#edit_phone").val("请先选择供应商");
						$("#edit_deliveryman").val("请先选择供应商");
						$("#edit_payType").val(-1);
						this.clearPrepaidAmountForm();
					}
				}
			}
			order.init();

			//供应商下拉框的onchange事件
			window.getCommodityMsg = value => {
				order.config.supctoId=value;
				order.clearGoodsEvent();
				order.clearTotalFun();
				order.initGoodsSelect(value);
				order.refurbishInput(value);
			}
			//商品下拉框的onchang事件
			window.selectCommodityMsg = (thisSelect, value) => {

			}

		})(document);
	</script>

</html>