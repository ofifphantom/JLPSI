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
					<h4 class="text-title">采购订单</h4>
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
						
							<span class="l_f"> 
							状态：<select id="query_state" name="">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">未送审</option>
								<option value="2" >审核中</option>
								<option value="4" >审核驳回</option>
								<option value="5">待付款</option>	
								<option value="6">待收货</option>	
								<option value="12">部分入库</option>		
								<option value="7">已开单</option>		
								<option value="3">终止审核通过</option>
							    <option value="isDelete">已删除</option>		
								<option value="9" >其他</option>
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
							<button type="button" class="btncss jl-btn-defult purchaseOrderAddBtn" style="margin-right: 0;">
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
								<label for="" class="col-xs-4 control-label">合同号</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_contractNumber" onblur="cky(this)" maxlength="100" />
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
								<th nowrap="nowrap">订货数量</th>
								<th nowrap="nowrap">税额</th>
								<th nowrap="nowrap">折扣%</th>
								<th nowrap="nowrap">批号</th>
								<th nowrap="nowrap">价税合计</th>
								<th nowrap="nowrap">备注</th>
 								<th nowrap="nowrap">操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="15">请先选择商品</td>
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
								<label for="" class="col-xs-4 control-label">订货数量</label>
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
								<label for="" class="col-xs-4 control-label">价税合计</label>
								<div class="col-xs-8">
									<input type="text" id="edit_total_totalTaxPrice" value="" class="form-control" disabled="disabled" />
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
				<div class="text-danger">注：该页面所有字段（除去合同号、摘要）均为必填</div>
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
		//立即执行函数
		(function(dom) {
			
			let order = {
				config: { //字段配置，存储变量
					title:"采购订单",
					supctoId:-1,//用于记录当前选中的供应商
					dataTable: {}, //该字段用于存储datadtable
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
							<th nowrap="nowrap">订货数量</th>
							<th nowrap="nowrap">税额</th>
							<th nowrap="nowrap">折扣%</th>
							<th nowrap="nowrap">批号</th>
							<th nowrap="nowrap">价税合计</th>
							<th nowrap="nowrap">备注</th>
							<th nowrap="nowrap">操作</th>
						</tr>`,
						tipTr: '<tr class="tipTr"><td colspan="15">请先选择商品</td></tr>',
						appHead: `<tr>
							<th nowrap="nowrap">货品名称</th>
							<th nowrap="nowrap">规格编码</th>
							<th nowrap="nowrap">规格</th>
							<th nowrap="nowrap">品牌</th>
							<th nowrap="nowrap">单位</th>
							<th nowrap="nowrap">业务单价</th>
							<th nowrap="nowrap">订货数量</th>
							<th nowrap="nowrap">备注</th>
						</tr>`,
						goodsArr: [] //用于存储添加到table中的商品的id
					},
					editForm: `<div class="col-xs-6 editInfo">
							<div class="form-group">
							  <input type="hidden" class="form-control" id="edit_purchase_id"   />
								<label for="" class="col-xs-4 control-label">日期</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_generateDate" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6 editInfo">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单号</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_identifier" disabled="disabled"   />
								</div>
							</div>
						</div>`,
					prepaidAmountForm:`<div class="col-xs-6 prepaidAmountForm">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">预付金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_prepaidAmount" onkeyup="pressMoney(this)" />
								</div>
							</div>
						</div>`,
					

				},
				init: function() { //初始化方法
					this.initDataTable();
					this.initEvent();
					this.initTransportationSelect("#edit_transportationMode");
					this.initPayTypeSelect("#edit_payType",1);
					this.initWarehouseSelect("#edit_goodsArrivalPlace");
					latdateNoBefore("#edit_effectivePeriodEnd");
					latdateNoBefore("#edit_goodsArrivalTime");
				},
				initEvent: function() {
					let that = this;
					//事件绑定
					//新增采购订单
					$(".purchaseOrderAddBtn").on("click", () => {
						this.purchaseOrderAddEvent();
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
					//采购订单 详情
					$("#datatable").delegate(".purchaseOrderDetailBtn", "click", function() {
						that.purchaseOrderDetailEvent($(this).attr("attr-tid"));
					})
					//采购订单 编辑
					$("#datatable").delegate(".purchaseOrderEditBtn", "click", function() {
						that.purchaseOrderEditEvent($(this).attr("attr-data"));
					})
					//采购订单 删除
					$("#datatable").delegate(".purchaseOrderDeleteBtn", "click", function() {
						that.purchaseOrderDeleteEvent($(this).attr("attr-data"));
					})
					//采购订单 送审
					$("#datatable").delegate(".purchaseOrderDeliverBtn", "click", function() {
						that.purchaseOrderDeliverEvent($(this).attr("attr-data"));
					})
					//采购订单 撤销
					$("#datatable").delegate(".purchaseOrderCancleBtn", "click", function() {
						that.purchaseOrderCancleEvent($(this).attr("attr-tid"));
					})
					//采购订单 终止
					$("#datatable").delegate(".purchaseOrderStopBtn", "click", function() {
						//layerTwoConfrim($("#alertDiv"), "提示框", "确定终止该订单?", ()=> {
							that.purchaseOrderStopEvent($(this).attr("attr-tid"));
						//})
					})
					//采购订单 导出
					$("#datatable").delegate(".purchaseOrderExportMsgBtn", "click", function() {
						that.purchaseOrderExportMsgEvent($(this).attr("attr-tid"));
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
					//订货数量  监听事件
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
					
					/*初始化 起止时间*/
					laydate.render({
						elem: "#query_time",
						range:'~'
					});

				},
				initSupctoSelect: function(isApp) {
					if(isApp!=1){
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
					}else{
						$("#edit_supcto_id").parent().html('<select id="edit_supcto_id" class="form-control" ><option value="" selected>无</option></select>');
					}
				
					
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
				initPayTypeSelect: function(payTypeSelect,isAppOrder) {
					//初始化付款方式 
					let $select = $(payTypeSelect);
					$.ajax({
						url: '<%=basePath%>basic/settlementType/getAllSettlementType',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						success: function(data) {
							//不是app订单
							if(isAppOrder==1){
								var options='<option value="-1">--请先选择供应商--</option>';
	 							 
								for(var i=0;i<data.length;i++){							
								  options+='<option value="'+data[i].id+'">'+data[i].name+'</option>';
								}
							}
							else{
								var options='<option value="-1">--请选择付款方式--</option>';
	 							 
								for(var i=0;i<data.length;i++){							
								  options+='<option value="'+data[i].id+'">'+data[i].name+'</option>';
							}
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
									"planOrOrder":2,
									"queryTime":$("#query_time").val(),
									"state":$("#query_state").val(),
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
													return '<td><span class="look-span purchaseOrderDetailBtn" attr-tid="'+row.id+'">'+data+' </span></td>';
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
			                                         if(row.isDelete==1){
			                                        	 return "已删除";
			                                         }
													switch (data) {
													case 1:
														return "未送审";
														break;
													case 2:
														return "待审核";
														break;
													case 3:
														return "待收货";
														break;
													case 4:
														return "已驳回";
														break;
													case 5:
														return "待付款";
														break;
													case 6:
														return "待收货";
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
													if(row.isDelete==0){
														if(row.state==1||row.state==4){
	 														return '<td><input type="button" class="btncss edit purchaseOrderEditBtn" attr-data=\''+JSON.stringify(row)+'\' value="编辑" /></td>'+
															'<input type="button" class="btncss edit purchaseOrderDeliverBtn" attr-data=\''+JSON.stringify(row)+'\' value="送审" />'+
															'<input type="button" class="btncss edit purchaseOrderDeleteBtn" attr-data=\''+JSON.stringify(row)+'\' value="删除" />';
														}
														else if(row.state==2||row.state==3||row.state==5){
															return '<td>'+
															'<input type="button" class="btncss edit purchaseOrderCancleBtn" attr-tid=\''+row.id+'\' value="撤销" />'+
															'<input type="button" class="btncss edit purchaseOrderExportMsgBtn" attr-tid=\''+row.id+'\' value="导出" />'+
															'</td>';
														}
														else if(row.state==6||row.state==11||row.state==10){
															return '<td>'+
															'<input type="button" class="btncss edit purchaseOrderStopBtn" attr-tid=\''+row.id+'\' value="终止" />'+
															'<input type="button" class="btncss edit purchaseOrderExportMsgBtn" attr-tid=\''+row.id+'\' value="导出" />'+
															'</td>';

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
															return '<td><input type="button" class="btncss edit" disabled value="已完成" /><input type="button" class="btncss edit purchaseOrderExportMsgBtn" attr-tid=\''+row.id+'\' value="导出" /></td>'
														}
													}else{
														return '<td><input type="button" class="btncss edit purchaseOrderDetailBtn" attr-tid=\''+row.id+'\' value="详情" /></td>';
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
					this.config.dataTable.fnDraw(false);
				},
				getPurchaseOrder: function() {
					let formData = {};
					 var prepaidAmount;
 					if($("#edit_payType").val()==1){
						prepaidAmount=$("#edit_prepaidAmount").val();
					}
					else{
						prepaidAmount=null;
					}
					var supctoId;
					
					if($("#edit_supcto_id").val()==null||$("#edit_supcto_id").val()-0<=0){
						supctoId=null
					}
					else{
						supctoId=$("#edit_supcto_id").val();
					}
					//console.log("edit_supcto_id",$("#edit_supcto_id").val());
					//console.log("supctoId",supctoId);
					//采购订单基础的信息
					   formData={"id":$("#edit_purchase_id").val(),"generateDateString":$("#edit_generateDate").val(),"identifier":$("#edit_identifier").val(),"supctoId":supctoId,"orderer":$("#edit_orderer").val(),"effectivePeriodEndString":$("#edit_effectivePeriodEnd").val(),
							"transportationMode":$("#edit_transportationMode").val(),"contractNumber":$("#edit_contractNumber").val(),"deliveryman":$("#edit_deliveryman").val(),"goodsArrivalTimeString":$("#edit_goodsArrivalTime").val(),
							"fax":$("#edit_fax").val(),"goodsArrivalPlace":$("#edit_goodsArrivalPlace").val(),"phone":$("#edit_phone").val(),"payType":$("#edit_payType").val(),"prepaidAmount":prepaidAmount,"summary":$("#edit_summary").val(),
							"procureCommoditys":[]}; 
					//获取采购商品的信息，添加到采购订单的商品信息里
					$("#goodsTbody tr").each(function(index, val){
						
						if(index==0){
							return;
						}
   						var procureCommodityDataJSON={"id":$(val).find(".edit_purchase_commodity_id").val(),"commodityId":$(val).find(".goodsDelBtn").attr("attr-tid"),"procureTableId":$("#edit_purchase_id").val(),"taxRate":$(val).find(".edit_procureCommodity_taxRate").val(),"amountOfTax":$(val).find(".edit_procureCommodity_amountOfTax").val(),"orderNum":$(val).find(".edit_procureCommodity_orderNum").val(),
								"lotNumber":$(val).find(".edit_procureCommodity_lotNumber").val(),"originalUnitPrice":$(val).find(".edit_procureCommodity_originalUnitPrice").val(),"discount":$(val).find(".edit_procureCommodity_discount").val(),"businessUnitPrice":$(val).find(".edit_procureCommodity_businessUnitPrice").val(),
								"remarks":$(val).find(".edit_procureCommodity_remarks").val(),"containsTaxPrice":$(val).find(".edit_procureCommodity_containsTaxPrice").val(),"paymentForGoods":$(val).find(".edit_procureCommodity_paymentForGoods").val(),"totalTaxPrice":$(val).find(".edit_procureCommodity_totalTaxPrice").val()
								};	
							
						formData.procureCommoditys.push(procureCommodityDataJSON);	
						});  
					console.log("formData",formData);
  					return formData;
				},
				setPurchaseOrder:function(id){
					$(".tipTr").remove();
					let that=this;
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
 	
								if(data.generateDate == null || data.generateDate == ""){
									$("#edit_generateDate").val("");
								}else{
									$("#edit_generateDate").val(getSmpFormatDateByLong(data.generateDate, true));
								}
							 
								if(data.supctoId!=null){
									that.config.supctoId=data.supctoId;
									SearchableSelectsetValue("#edit_supcto_id",data.supctoId);
								}
								
			 
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
								if(data.goodsArrivalPlace!=null){
									$("#edit_goodsArrivalPlace").val(data.goodsArrivalPlace);
								}
								else{
									$("#edit_goodsArrivalPlace").val(-1);
								}
								
								if(data.orderer!=null&&data.orderer!=""){
									$("#edit_orderer").val(data.orderer);
								}else{
									$("#edit_orderer").val('<%=session.getAttribute("userName")%>');

								}
								
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
									
									if(data.payType==1){
										that.setPrepaidAmountForm();
										if(data.prepaidAmount == null){
											$("#edit_prepaidAmount").val("");
										}else{
											$("#edit_prepaidAmount").val(data.prepaidAmount);
										} 
									}
								}
								
								
								
							
								//console.log("app订单",data.isAppOrder);
								//商品
								var totalOrderNum=0;
								var totalAmountOfTax=0.0;
								var totalTotalTaxPrice=0.0;
  								$("#edit_purchase_id").val(id);
								for(var i=0;i<data.procureCommoditys.length;i++){
									
 									that.config.goodsTable.goodsArr.push(data.procureCommoditys[i].commoditySpecification.id);
 									if(data.isAppOrder!=null&data.isAppOrder==2){
 										var remarks=data.procureCommoditys[i].remarks==null?"无":data.procureCommoditys[i].remarks;
 										$("#goodsTbody").append(`<tr>
 												<td>` + data.procureCommoditys[i].commoditySpecification.commodity.name + `</td>
 												<td class="edit_commodity_specifications_id">` + data.procureCommoditys[i].commoditySpecification.specificationIdentifier + `</td>
 												<td>` + data.procureCommoditys[i].commoditySpecification.specificationName + `</td>
 												<td>` + data.procureCommoditys[i].commoditySpecification.commodity.brand + `</td>
 												<td>` + data.procureCommoditys[i].commoditySpecification.baseUnitName + `</td>
 												<td><input type="text" value="`+data.procureCommoditys[i].businessUnitPrice+`" class="form-control edit_procureCommodity_businessUnitPrice" disabled="disabled" /></td>
 												<td><input type="text" id="" value="`+data.procureCommoditys[i].orderNum+`" class="form-control edit_procureCommodity_orderNum"  maxlength="9" disabled="disabled"/></td>
 												<td><input type="text" id="" value="`+remarks+`" class="form-control edit_procureCommodity_remarks" onkeyup="cky(this)" attr-name="备注"/></td>
 												<td class="hidden"><input type="text" value="`+data.procureCommoditys[i].totalPrice+`" class="form-control edit_procureCommodity_totalTaxPrice hidden" /></td>
 												<td class="hidden"><input type="button" class="btncss edit goodsDelBtn hidden" attr-tid="` +data.procureCommoditys[i].commodityId + `"  value="删除"   /></td>
 											</tr>`);
 										totalTotalTaxPrice+=data.procureCommoditys[i].totalPrice;
 									}else{
  										$("#goodsTbody").append(`<tr>
 												<td>` + data.procureCommoditys[i].commoditySpecification.commodity.name + `</td>
 												<td class="edit_commodity_specifications_id">` + data.procureCommoditys[i].commoditySpecification.specificationIdentifier + `</td>
 												<td>` + data.procureCommoditys[i].commoditySpecification.specificationName + `</td>
 												<td>` + data.procureCommoditys[i].commoditySpecification.commodity.brand + `</td>
 												<td>` + data.procureCommoditys[i].commoditySpecification.baseUnitName + `</td>
 												<td><input type="text" id="" value="` + data.procureCommoditys[i].taxRate + `" class="form-control edit_procureCommodity_taxRate" attr-name="税率" /></td>
 												<td><input type="text" id="" value="` +data.procureCommoditys[i].originalUnitPrice+ `" class="form-control edit_procureCommodity_originalUnitPrice" attr-name="原始单价"/></td>
 												<td><input type="text" value="`+data.procureCommoditys[i].businessUnitPrice+`" class="form-control edit_procureCommodity_businessUnitPrice" placeholder="先填写原始单价" disabled="disabled" /></td>
 												<td><input type="text" id="" value="`+data.procureCommoditys[i].orderNum+`" class="form-control edit_procureCommodity_orderNum"  maxlength="9" attr-name="订货数量"/></td>
 												<td><input type="text" value="`+data.procureCommoditys[i].amountOfTax+`"  class="form-control edit_procureCommodity_amountOfTax" placeholder="先填写原始单价、订货数量、税率" disabled="disabled" /></td>
 												<td><input type="text" id="" value="`+data.procureCommoditys[i].discount+`" class="form-control edit_procureCommodity_discount"  maxlength="9" attr-name="折扣"/></td>
 												<td><input type="text" id="" value="`+data.procureCommoditys[i].lotNumber+`" class="form-control edit_procureCommodity_lotNumber" onkeyup="cky(this)" attr-name="批号"/></td>
 												<td><input type="text" value="`+data.procureCommoditys[i].totalTaxPrice+`" class="form-control edit_procureCommodity_totalTaxPrice" placeholder="请先填写原始单价、订货数量、税率" disabled="disabled" /></td>
 												<td><input type="text" id="" value="`+data.procureCommoditys[i].remarks+`" class="form-control edit_procureCommodity_remarks" onkeyup="cky(this)" attr-name="备注"/></td>
 												<td><input type="button" class="btncss edit goodsDelBtn" attr-tid="` +data.procureCommoditys[i].commodityId + `"  value="删除"   /></td>
 											</tr>`); 
 										
 									
 										totalAmountOfTax+=data.procureCommoditys[i].amountOfTax;
 										totalTotalTaxPrice+=data.procureCommoditys[i].totalTaxPrice;
 									}
 									totalOrderNum+=data.procureCommoditys[i].orderNum;
									
							
									
							
									
								}
								
								$("#edit_total_orderNum").val(totalOrderNum);//订货数量
								$("#edit_total_amountOfTax").val(toDecimal2(totalAmountOfTax));//税额
								$("#edit_total_totalTaxPrice").val(toDecimal2(totalTotalTaxPrice));//价税合计
				 
								//其他
								if(data.isAppOrder!=null&data.isAppOrder==2){
									$("#edit_summary").val(data.summary!=null?data.summary:"无");
								}else{
									$("#edit_summary").val(data.summary);
								}
								
							}
							else{
								laywarn("该订单已被删除，请重新加载该页面。");
							}
							
							
						}
					});
					
					/*
					 * 请在此处解析data为from赋值
					 * 该方法用于编辑框打开前，为框内的内容赋值
					 */
				},
				getGoodsTrInfor: function(thisInput) {
					//获取商品表格某一行字段，用于计算
					return {
						"taxRate": $(thisInput).parents("tr").find(".edit_procureCommodity_taxRate").val(),
						"originalUnitPrice": $(thisInput).parents("tr").find(".edit_procureCommodity_originalUnitPrice").val(),
						"orderNum": $(thisInput).parents("tr").find(".edit_procureCommodity_orderNum").val(),
						"discount": $(thisInput).parents("tr").find(".edit_procureCommodity_discount").val(),
						"totalTaxPrice": $(thisInput).parents("tr").find(".edit_procureCommodity_totalTaxPrice").val(),
					};
				},
				setGoodsInfor: function(thisInput) {
					//计算业务单价、税额、价税合计
					let gInfo = this.getGoodsTrInfor(thisInput);

					gInfo.businessUnitPrice = this.countBusinessUnitPriceFun(gInfo.originalUnitPrice, gInfo.discount);
					$(thisInput).parents("tr").find(".edit_procureCommodity_businessUnitPrice")
						.val(gInfo.businessUnitPrice); //业务单价

					$(thisInput).parents("tr").find(".edit_procureCommodity_amountOfTax")
						.val(this.countAmountOfTaxFun(gInfo.orderNum, gInfo.businessUnitPrice, gInfo.taxRate)); //税额

					gInfo.totalTaxPrice = this.countTotalTaxPriceFun(gInfo.orderNum, gInfo.businessUnitPrice, gInfo.taxRate);
					$(thisInput).parents("tr").find(".edit_procureCommodity_totalTaxPrice")
						.val(gInfo.totalTaxPrice); //价税合计

					//合计
					this.countTotalFun();

				},
				purchaseOrderAddEvent: function() {
					//新增采购订单
					//console.log("新增采购订单");
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

							/*
							 * 添加采购订单添加成功相关逻辑代码
							 */
							var formdata = this.getPurchaseOrder(); //获取页面数据的值，用于提交到后台
							$.ajax({
								url: '<%=basePath%>purchase/procuretable/addPurchaseOrder?planOrTable='+2,
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
							this.clearGoodsEvent();
							this.initGoodsSelectDisabled();
							this.clearPrepaidAmountForm();
							this.config.supctoId=-1;
							
						}
					});
				},
				purchaseOrderDetailEvent: function(tid) {
					//采购订单 详情
					//console.log("采购订单详情"+tid);
					var that=this;
					$.ajax({
						type: "post",
						url: "<%=basePath%>/purchase/procuretable/detailPurchaseOrder",
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
				purchaseOrderEditEvent: function(row) {
					var that = this;
 					row=$.parseJSON(row);
					//采购订单 编辑
					//console.log("采购订单 编辑" + row);
					
					//初始化供应商
					if(row.isAppOrder!=null&&row.isAppOrder==2){
						that.initSupctoSelect(1);
						$("#goodsTbody").html(that.config.goodsTable.appHead + that.config.goodsTable.tipTr);
						$("#edit_goods").addClass("hidden");
						$(".goodsAddBtn").addClass("hidden");
						that.initPayTypeSelect("#edit_payType",2);
						$("#edit_payType").removeAttr("disabled");
 					}else{
						that.initSupctoSelect();
						that.initGoodsSelect(row.supctoId);
						$("#edit_payType").attr("disabled","disabled");
					}
				 
					
					$("#headEdit .row").prepend(this.config.editForm);
 					this.setPurchaseOrder(row.id); //根据data获取单据信息为表单赋值
 				
					layer.open({
						type: 1,
						title: "编辑" + that.config.title,
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#editDiv"),
						scrollbar: false,
						btn: ['提交', '取消'],
						yes: index => {
							if(!this.checkFormisFilledLayerFun() || !this.checkFormRuleLayerFun()) return;

							var formdata = this.getPurchaseOrder(); //获取页面数据的值，用于提交到后台
							$.ajax({
								url: '<%=basePath%>purchase/procuretable/updateOrderByPrimaryKey',
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
									laysuccess("编辑成功");
								}
							});
							
						},
						end: (index, layero) => {
							layer.close(index);
							clearForm("editDiv", "");
							this.clearGoodsEvent();
							this.initGoodsSelectDisabled();
							this.clearPrepaidAmountForm();
							$(".editInfo").remove();
							$(".goodsAddBtn").removeClass("hidden");
							this.config.supctoId=-1;

						}
					});
					
					
				},
				purchaseOrderDeleteEvent: function(row) {
 					row=$.parseJSON(row);
					//采购订单 删除
					//console.log("采购订单 删除" + row.id);
					var that=this;
					publicMessageLayer("删除该订单", function() {
					$.ajax({
						url :'<%=basePath%>purchase/procuretable/delByPrimaryKey',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data: {
							"id" : row.id,
							"identifier" :row.identifier	
						},
						
						traditional:true,
						success: function(data) {
							that.refreshDataTable();

						}
					});
					});
				},
				purchaseOrderDeliverEvent: function(row) {
					
					row=$.parseJSON(row);
					if(row.payType==null||row.payType<=0||row.deliveryman==null||row.deliveryman==""){
						laywarn("请先完善订单信息");
						return ;
					}
					var that=this;
					//采购订单 送审
					publicMessageLayer("将本订单送审", function() {
					//console.log("采购订单 送审" + row);
					var ids=[row.id];
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
								//刷新datatable
								that.refreshDataTable();

							}
						});
					})
					
				},
				purchaseOrderCancleEvent: function(tid) {
					//采购订单 撤销
					var that=this;
					publicMessageLayer("撤销该订单", function() {
					//console.log("采购订单 撤销" + tid);
					var ids=new Array(tid);
					
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
							that.refreshDataTable();
						}
						});
					});
				},
				purchaseOrderStopEvent: function(tid) {
					//采购订单 终止
					var that=this;
					layerTwoConfrim($("#alertDiv"), "提示框", "确定终止该订单?", function() {
					//console.log("采购订单 终止" + tid);
					var ids=new Array(tid);
					
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
							//刷新datatable
							that.refreshDataTable();

						}
					});
					});
				},
			
				purchaseOrderExportMsgEvent:function(tid){
				//导出 
						var URL="<%=basePath%>purchase/procuretable/exportExportProcureTableDetail?id="+tid+""
						//console.log(URL)
						location.href=URL;
						return false;
			 
				},
				goodsAddEvent: function() {
					//新增商品
					//console.log("新增商品事件");
					
					let goodsId = $("#edit_goods").val(); 
 					let data=this.config.goodsSelectData;
					
					let goodsName = "名称"; //名称
					let goodsType = "规格"; //规格
					let goodsLogo = "品牌"; //品牌
					let goodsUnit = "单位"; //单位
					let taxRate = "税率"; //单位
					let goodsNum="编码";//编码
					let unitPrice="";//原始单价
					
					/*
					 * 请根据之前存储到this.config.goodsSelectData进行循环
					 * 找到对应编码商品为名称、规格、品牌、单位赋值
					 */
					 for(var i=0;i<data.length;i++){
						 //console.log("data============",data);
						if(data[i].id==goodsId){
							goodsName=data[i].commodity.name;
							goodsType=data[i].specificationName;
							goodsLogo=data[i].commodity.brand;
							goodsUnit=data[i].baseUnitName;
							taxRate=data[i].commodity.taxes;
							goodsNum=data[i].specificationIdentifier;
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
							<td class="edit_commodity_specifications_id">` + goodsNum + `</td>
							<td>` + goodsType + `</td>
							<td>` + goodsLogo + `</td>
							<td>` + goodsUnit + `</td>
							<td><input type="text" id="" value="` + taxRate + `" class="form-control edit_procureCommodity_taxRate" attr-name="税率" /></td>
							<td><input type="text" id="" value="` +unitPrice+ `" class="form-control edit_procureCommodity_originalUnitPrice" attr-name="原始单价"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_businessUnitPrice" value="` +unitPrice+ `" placeholder="先填写原始单价" disabled="disabled" /></td>
							<td><input type="text" id="" value="" class="form-control edit_procureCommodity_orderNum"  maxlength="9" attr-name="订货数量"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_amountOfTax" placeholder="先填写原始单价、订货数量、税率" disabled="disabled" /></td>
							<td><input type="text" id="" value="100" class="form-control edit_procureCommodity_discount"  maxlength="9" attr-name="折扣"/></td>
							<td><input type="text" id="" value="0000" class="form-control edit_procureCommodity_lotNumber" onkeyup="cky(this)" attr-name="批号"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_totalTaxPrice" placeholder="请先填写原始单价、订货数量、税率" disabled="disabled" /></td>
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
					//添加预付金额
					if($(".prepaidAmountForm").length==0) $("#headEdit .row").append(this.config.prepaidAmountForm);
				},
				clearPrepaidAmountForm:function(){
					//删除预付金额
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
 						var text=$(val).parents(".form-group").find(".control-label").text();
						if(text!="合同号"&&$(val).val() == "" && (!$(val).hasClass("searchable-select-input"))&&res) {
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
						var text=$(val).parents(".form-group").find(".control-label").text();
						if(text!="摘要"&&$(val).val() == ""&&res) {
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
				checkFormisFilledLayerFun() {
					let res = this.checkFormisFilledFun();
					//if(!res) layfail("表单未填写完整，请完善后提交");
					if(res){
						$("#goodsTbody input").each(function(index, val) {
							if($(val).hasClass("edit_procureCommodity_totalTaxPrice")&&$(val).val()==0) {
								layfail("价税合计不能为0")
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
					//计算 税额=订货数量*业务单价*税率
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
				countTotalTaxPriceFun: function(orderNum, businessUnitPrice, taxRate) {
					//计算 价税合计=订货数量*业务单价*（1+税率）
					if(!orderNum || !businessUnitPrice || !taxRate) return "";
					return toDecimal2((orderNum - 0) * (businessUnitPrice - 0) * (1+(taxRate - 0)));
				},
				countTotalFun:function(){
					//计算合计
					$("#edit_total_orderNum").val(parseInt(this.countOneTotalFun(".edit_procureCommodity_orderNum")));//订货数量
					$("#edit_total_amountOfTax").val(this.countOneTotalFun(".edit_procureCommodity_amountOfTax"));//税额
					$("#edit_total_totalTaxPrice").val(this.countOneTotalFun(".edit_procureCommodity_totalTaxPrice"));//价税合计
					
				},
				clearTotalFun:function(){
					$("#edit_total_orderNum").val("");//订货数量
					$("#edit_total_amountOfTax").val("");//税额
					$("#edit_total_totalTaxPrice").val("");//价税合计
					
				},
				countOneTotalFun:function(input){
					//计算
					$input=$(input);
					let total=0;
					$.each($input, function(index,obj) {
						total+=($(obj).val()-0);
					});
					return toDecimal2(total);
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