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
		<script 
			src="${pageContext.request.contextPath}/junlin/js/jquery-citys/jquery.citys.js" type="text/javascript"></script>
		<style type="text/css">
			#detailDiv,
			#editDiv {
				margin: 50px auto;
			}
			
			.edit_isSpecialOffer_span {
				background: white;
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
					<h4 class="text-title">销售订单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 单号： <input type="text" value=""
							id="query_identifier" />
							</span>
							<span class="l_f"> 客户名称： <input type="text" value=""
								id="query_supctoId" />
							</span>
							<span class="l_f"> 货品名称： <input type="text" value=""
								id="query_goodsName" />
							</span>
							<span class="l_f"> 是否为样品单： <select id="query_isSpecimen">
									<option value="0">请选择</option>
									<option value="1">否</option>
									<option value="2">是</option>
							</select>
							</span>
							<span class="l_f" > 
								状态：<select id="query_state" >
									<option value="-1" selected="selected">--请选择--</option>
									<option value="1">未送审</option>
									<option value="2">审核中</option>
									<option value="3">审核通过</option>
									<option value="4">审核驳回</option>
									<option value="6">备货中</option>
									<option value="7">已出库</option>
									<option value="8">已删除</option>
									<option value="5">其他</option>
								</select>
							</span>
							<span class="l_f" style="margin-left:9px"> 
								起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
							</span>
							
							<span class="l_f" id="select_location">
								客户所属地区：
								<select id="query_province_code" name="province">
									<option value="-1" selected="selected">--请选择--</option>
								</select>
								<select id="query_city_code" name="city"> 
									<option value="-1" selected="selected">--请选择--</option>
								</select>
								<select id="query_area_code" name="area">
									<option value="-1" selected="selected">--请选择--</option>
								</select>
							</span>
							<span class="l_f"> 
							客户所属分类：<select id="query_classification_one_id">
								<option value="-1" selected="selected">--请选择--</option>
								
							</select>
							<select id="query_classification_two_id">
								<option value="-1" selected="selected">--请先选择一级分类--</option>
								
							</select>
							</span>
							<span class="r_f"> <input type="button" id="btn_search"
								class="btncss btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<span class="r_f">
							<button type="button" class="btncss jl-btn-defult salesOrderAddBtn" style="margin-right: 0;">
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
			<input type="text" class="form-control hidden" id="edit_sales_id" />
				<div class="row jl-title">
					<span>是否为样品单</span>
				</div>
				<div id="topEdit" class="jl-panel">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">是否为样品单</label>
								<div class="col-xs-8">
									<select id="edit_is_specimen" class="form-control edit_is_specimen">
										<option value="-1" selected="selected">--请选择--</option>
										<option value="2">是</option>
										<option value="1">否</option>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div id="headEdit" class="jl-panel">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户</label>
								<div class="col-xs-8">
									<input type="text" id="edit_supctoId_input" class="form-control hidden" disabled="true"/>
								</div>
								<div class="col-xs-8" id="edit_supctoIdDiv">
									<select id="edit_supcto_id" class="form-control">
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户所属地区</label>
								<div class="col-xs-8">
									<input type="text" id="edit_supcto_local" value="客户所属地区" class="form-control" disabled="true"/>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户所属分类</label>
								<div class="col-xs-4" style="padding-right: 0; border-right: 0;">
									<input type="text" id="edit_supcto_classOne" value="客户所属一级分类" class="form-control" disabled="true"/>
								</div>
								<div class="col-xs-4" style="padding-left: 0;">
									<input type="text" id="edit_supcto_classTwe" value="客户所属二级分类" class="form-control" disabled="true"/>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">有效期至</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="effective_date" readonly="readonly" placeholder="请选择有效期" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">发货地点</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_deliver_goods_place" maxlength="100" onkeyup="cky(this)" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">收货人</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" maxlength="100" id="edit_consignee" onkeyup="cky(this)" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">传真</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" maxlength="100" id="edit_fax" onkeyup="cky(this)"  />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">运输方式</label>
								<div class="col-xs-8">
									<select name="" class="form-control" id="edit_transportationMode" >

									</select>
								</div>
							</div>
						</div>

						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">联系电话</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_phone" onkeyup="cky(this)" maxlength="11" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">收货地点</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_receipt_goods_place" maxlength="100" onkeyup="cky(this)" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">订货人</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" maxlength="100" id="edit_orderer" onkeyup="cky(this)" disabled="disabled" />
								</div>
							</div>
						</div>

						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">结算方式</label>
								<div class="col-xs-8">
									<select id="edit_payType" name="" class="form-control">
										<option value="-1" selected="selected">--请选择--</option>
										<option value="1">预付款</option>
										<option value="2">货到付款</option>
										<option value="3">账期</option>
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
								<select id="edit_goods" class="form-control">
									<option value="-1">--请选择商品--</option>
									<option value="1">1</option>
									<option value="2">2</option>

								</select>
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
								<th nowrap="nowrap">单位</th>
								<th nowrap="nowrap">发货数量</th>
								<th nowrap="nowrap">税率</th>
								<th nowrap="nowrap">折扣%</th>
								<th nowrap="nowrap">单价</th>
								<th nowrap="nowrap">金额</th>
								<th nowrap="nowrap">税额</th>
								<th nowrap="nowrap">批号</th>
								<th nowrap="nowrap">备注</th>
								<th nowrap="nowrap">操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="13">请先选择商品</td>
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
								<label for="" class="col-xs-4 control-label">发货数量</label>
								<div class="col-xs-8">
									<input type="text" id="total_commodity_num" value="" class="form-control" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">金额</label>
								<div class="col-xs-8">
									<input type="text" id="total_commodity_price" value="" class="form-control" disabled="disabled" />
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
								<label for="" class="col-xs-4 control-label">部门</label>
								<div class="col-xs-8">
									<select id="department_id" class="form-control" name="departmentId">
										<option value="-1" selected="selected">--请选择--</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input type="text" id="edit_summary" value="无" class="form-control" onkeyup="cky(this)" maxlength="100" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员</label>
								<div class="col-xs-8">
									<select id="person_id" class="form-control" name="personId">
										<option value="-1" selected="selected">--请先选择部门--</option>

									</select>
								</div>
							</div>
						</div>
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
	
		//立即执行函数
		(function(dom) {
			let order = {
				config: { //字段配置，存储变量
					title: "销售订单",
					isSampleSheet: false, //订单是否是样品单 是样品单：true,不是样品单false（默认不是样品单）
					dataTable: {}, //该字段用于存储datadtable
					customerId:-1,//用于记录当前选中的客户
					goodsSelectData: [], //用于存储当前选中的客户的所有商品
					updateOrAdd:0,//用于判断是新增还是编辑，编辑的话需要判断库存
					updateOrderId:0,//用于保存用户编辑时选择的订单id
					goodsTable: {
						head: `<tr>
							<th nowrap="nowrap">货品名称</th>
							<th nowrap="nowrap">规格编码</th>
							<th nowrap="nowrap">规格</th>
							<th nowrap="nowrap">单位</th>
							<th nowrap="nowrap">发货数量</th>
							<th nowrap="nowrap">税率</th>
							<th nowrap="nowrap">折扣%</th>
							<th nowrap="nowrap">单价</th>
							<th nowrap="nowrap">金额</th>
							<th nowrap="nowrap">税额</th>
							<th nowrap="nowrap">批号</th>
							<th nowrap="nowrap">备注</th>
							<th nowrap="nowrap">操作</th>
						</tr>`,
						tipTr: '<tr class="tipTr"><td colspan="13">请先选择商品</td></tr>',
						goodsArr: [] //用于存储添加到table中的商品的id
					},
					editForm: `<div class="col-xs-6 editInfo">
							<div class="form-group">
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
					advanceScaleForm: `<div class="col-xs-6 advanceScaleForm">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">预收金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_advance_scale" onkeyup="pressMoney(this)" />
								</div>
							</div>
						</div>`,

				},
				init: function() { //初始化方法
					this.initDataTable();
					this.initEvent();
					this.initTransportationSelect("#edit_transportationMode");
					latdateNoBefore("#effective_date");
					this.initDepartmentSelect("#department_id");
					this.initPageSupctoOneClassifity();
					
					/*地区三级联动 初始化*/
					$('#select_location').citys();
					/*初始化起止时间*/
					laydate.render({
						elem: "#query_time",
						range:'~'
					});
				},
				initEvent: function() {
					let that = this;
					//事件绑定
					//新增销售订单
					$(".salesOrderAddBtn").on("click", () => {
						this.salesOrderAddEvent();
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
					//页面客户一级选择的值改变事件
					$("#query_classification_one_id").on("change", function() {
						that.supctoOneClassificationChange();
					})
					//付款方式
					$("#edit_payType").on("change", function() {
						if($(this).val() == 1) that.setPrepaidAmountForm();
						else that.clearPrepaidAmountForm();
					})
					//部门下拉框值改变事件
					$("#department_id").on("change", function() {
						that.initPersonSelect($(this).val(), "#person_id");
					})
					//是否是样品单下拉框值改变事件
					$("#edit_is_specimen").on("change", function() {
						that.specimenChange(this);
					})

					/*事件委托 begin*/
					//销售订单 详情
					$("#datatable").delegate(".salesOrderDetailBtn", "click", function() {
						that.salesOrderDetailEvent($(this).attr("attr-tid"));
					})
					//销售订单 编辑
					$("#datatable").delegate(".salesOrderEditBtn", "click", function() {
						console.log($(this).attr("attr-data"))
						that.salesOrderEditEvent($(this).attr("attr-data"));
					})
					//销售订单 删除
					$("#datatable").delegate(".salesOrderDeleteBtn", "click", function() {
						that.salesOrderDeleteEvent($(this).attr("attr-tid"));
					})
					//销售订单 送审
					$("#datatable").delegate(".salesOrderDeliverBtn", "click", function() {
						console.log("data",$(this).attr("attr-data"))
						that.salesOrderDeliverEvent($(this).attr("attr-data"));
					})
					//销售订单 作废
					$("#datatable").delegate(".salesOrderStopBtn", "click", function() {
						//layerTwoConfrim($("#alertDiv"), "提示框", "确定作废该订单?", () => {
							that.salesOrderStopEvent($(this).attr("attr-data"));
						//})
					})

					//删除商品
					$("#goodsTbody").delegate(".goodsDelBtn", "click", function() {
						that.goodsDelEvent(this, $(this).attr("attr-tid"));
					})

					//税率 监听事件
					$("#goodsTbody").delegate(".edit_taxes", "keyup blur", function() {
						pressSmallNumZero(this);
						that.setMoneyInfor(this);
					})
					//发货数量  监听事件
					$("#goodsTbody").delegate(".edit_deliverGoodsNum", "keyup blur", function() {
						pressInteger(this);
						that.setMoneyInfor(this);
					})
					//单价  监听事件
					$("#goodsTbody").delegate(".edit_unitPrice", "blur", function() {
						pressMoney(this);
						that.setGoodsInfor(this);
					})
					//单价 申请特价点击事件
					$("#goodsTbody").delegate(".edit_isSpecialOffer_span", "click", function() {
						that.specialOfferChange(this);
					})
					//折扣  监听事件
					 $("#goodsTbody").delegate(".edit_discount", "blur", function() {
						pressIntegersOneHundred(this);
						that.setGoodsInfor(this);
					}) 
					/*事件委托 end*/
					

				},
				initPageSupctoOneClassifity:function(){
					$.ajax({
						url :'<%=basePath%>/basic/classification/selectAllOneClassifityByType' ,
						type : "POST",
						dataType : "json",
						data: {
							"type" : 1
						},
						success : function(data) {
							if(data.length==0){
								$("#query_classification_one_id").append("<option value='-1' selected>--暂无数据，请到一级分类页面进行添加--</option>");	
							}else{
								for ( var i = 0; i < data.length; i++) {
									var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
									$("#query_classification_one_id").append(option);
									option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
									$("#classification_one_id").append(option);
								}
							}
							
						}
					});
				},
				initSupctoSelect: function() {
					//初始化客户
					$("#edit_supcto_id").parent().html('<select id="edit_supcto_id" class="form-control"></select>');

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
		                    $("#edit_supcto_id").html("");
		                    if(data.length==0){
		                        $("#edit_supcto_id").append("<option value='-1' selected>--暂无数据，请到供应商页面进行添加--</option>");
		                    }
		                    else{
		                        $("#edit_supcto_id").append("<option value='-1' selected>--请选择客户--</option>");
		                        for(var i=0;i<data.length;i++){
		                        	var location="";
		                        	location+=data[i].province;
		                        	if(data[i].city!=null&&data[i].city!="") location+=" "+data[i].city;
		                        	location+=" "+data[i].area;
		                         	var shippingModeId=data[i].shippingModeId==null?-1:data[i].shippingModeId;
		                            var option = $("<option value='"+data[i].id+"' attr-location='"+location+"' attr-classificationOne='"+data[i].classificationOneName+"' attr-classificationTwe='"+data[i].classificationTweName
		                            		+"' attr-fax='"+data[i].fax+"'   attr-shippingModeId='"+shippingModeId+"' attr-phone='"+data[i].phone+"' attr-deliveryAddress='"
		                            		+data[i].deliveryAddress+"' attr-contactPeople='"+data[i].contactPeople+"'>"
		                                + data[i].name + "</option>");
		                            $("#edit_supcto_id").append(option);
		                        }
		                    }
		                }
		            });
					/*
					 * 请在此处为客户下拉框添加option
					 */
					/*$("#edit_supcto_id").html(`<option value="-1">--请选择客户--</option>
										<option value="1">1</option>
										<option value="2">2</option>`);*/

					$("#edit_supcto_id").searchableSelect();
				},
				initGoodsSelect: function() {
					let that=this;
					//初始化商品 
					$("#edit_goods").parent().html('<select id="edit_goods" class="form-control"></select>');
					/*
					 * 请在此处为商品下拉框添加option
					 * 并将查到的商品暂时存储到this.config.goodsSelectData
					 */
					 $.ajax({
		                url: '<%=basePath%>basic/goods/commodity/saleOrderGetHasInventoryCommodityByStateAndIsDelete',
		                type: "POST",
		                dataType: "json",
		                async: false,
		                cache: false,
		                data:{
		                	"updateOrAdd":that.config.updateOrAdd,
		        			"orderId":that.config.updateOrderId
		                },
		                success: function(data) {
		                	that.config.goodsSelectData=[];
							that.config.goodsSelectData=data;
							 $("#edit_goods").html("")
		                    $("#edit_goods").html("<select class='form-control'></select>")
		                    if(data.length==0){
		                        $("#edit_goods").append("<option value='-1' selected>--暂无数据，请到商品页面进行添加。--</option>");
		                    }
		                    else{
		                        $("#edit_goods").append("<option value='-1' selected>--请选择商品--</option>");
		                        for(var i=0;i<data.length;i++){
		                        	var option = $("<option value='"+data[i].id+"' attr-identifier='"+data[i].specificationIdentifier+"' attr-commodityName='"
		                        			+data[i].commodity.name+"'  attr-specName='"+data[i].specificationName +"' attr-brand='"
		                        			+data[i].commodity.brand+"' attr-baseUnit='"+data[i].baseUnitName+"' attr-unitPrice='"
		                        			+data[i].baseCommonlyPrice+"' attr-taxes='"+data[i].commodity.taxes+"' attr-warehouseId='"+data[i].specWarehouseId+"'>"
			                                + data[i].commodity.name+" "+data[i].specificationName + "</option>");
		                            $("#edit_goods").append(option);
		                        }
		
		                    }
		                }
		            });
					/*$("#edit_goods").html(`<option value="-1">--请选择商品--</option>
										<option value="1">1</option>
										<option value="2">2</option>`);*/

					$("#edit_goods").searchableSelect();
				},
				initGoodsSelectDisabled: function() {
					//商品选择框禁用
					$("#edit_goods").parent().html('<input id="edit_goods" class="form-control" value="请先选择客户" disabled />');
				},
				initDepartmentSelect: function(select) {
					//初始化部门下拉框
					$select = $(select);
					//$select.html(`<option value="-1">--请选择部门--</option>`);
					
					/*
					 * 请在此处为部门下拉框添加option
					 */
					$.ajax({
						url :'<%=basePath%>/basic/department/getAllDepartment' ,
						type : "POST",
						dataType : "json",
						data: {},
						success : function(data) {
							$select.empty();
							if(data.length==0){
								$select.append('<option value="-1" selected="selected">--暂无部门信息，请去添加--</option>');
							}
							else{
								$select.append('<option value="-1" selected="selected">--请选择部门--</option>');
								for ( var i = 0; i < data.length; i++) {
									var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
									$select.append(option);
									
								}
							}
							
						}
					});
					//$select.append(`<option value="1">1</option><option value="2">2</option>`);

				},
				initPersonSelect: function(departmentId, select,personId) {
					//初始化业务员下拉框
					personId=personId||-1;
					$select = $(select);
					if(departmentId == -1) {
						$select.html(`<option value="-1" selected="selected">--请先选择部门--</option>`);
						return;
					}
					$select.html(`<option value="-1">--请选择业务员--</option>`);
					/*
					 * 请在此根据部门id处为业务员下拉框添加option
					 */
					$.ajax({
						url :'<%=basePath%>/basic/person/getAllPersonByDepartmentIdAndBusiness' ,
						type : "POST",
						dataType : "json",
						data: {
							"departmentId" : departmentId
						},
						success : function(data) {
							$select.empty();
							if(data.length==0){
								$select.append('<option value="-1" selected="selected">--该部门暂无业务员，请去添加--</option>');
							}
							else{
								$select.append('<option value="-1" selected="selected">--请选择--</option>');
								for ( var i = 0; i < data.length; i++) {
									var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
									$select.append(option);
									
								}
								if(personId>0){
									$select.val(personId);
								}
							}
							
						}
					});
					$select.append(`<option value="1">1</option><option value="2">2</option>`);
					
					if(personId>0){
						$select.val(personId);
					}

				},
				initTransportationSelect: function(transportationSelect) {
					//初始化运输方式  
					let $select = $(transportationSelect);
					/*
					 * 请在此处为运输方式 下拉框添加option
					 */
					$.ajax({
		                url: '<%=basePath%>basic/shippingMode/getAllShippingMode',
		                type: "POST",
		                dataType: "json",
		                async: false,
		                cache: false,
		                success: function(data) {
		                    if(data.length==0){
		                       	$select.append("<option value='-1' selected>--暂无数据，请到运输方式页面进行添加。--</option>");
		                    }
		                    else{
		                        $select.append("<option value='-1' selected>--请选择--</option>");
		                        for(var i=0;i<data.length;i++){
		                            var option = $("<option value='"+data[i].id+"'>"
		                                + data[i].name + "</option>");
		                            $select.append(option);
		                        }
		                    }
		                }
		            });
					/*$select.html(`<option value="-1">--请选择运输方式--</option>
										<option value="1">1</option>
										<option value="2">2</option>`);*/
				},
				initDataTable: function() {
					/*
					 * 请在此处初始化页面datatable 并把datatable赋值给this.config.dataTable
					 */
					this.config.dataTable = $('#datatable')
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
							"isSpecimen":$("#query_isSpecimen").val(),
							"createTime": $("#query_time").val(),
							"state": $("#query_state").val(),
							"classificationId": $("#query_classification_two_id").val(),
							"provinceCode":typeof($("#query_province_code").val()) == "undefined"?-1:$("#query_province_code").val(),
							"cityCode":(!$("#query_city_code").val() && typeof($("#query_city_code").val())!="undefined" && $("#query_city_code").val()!=0)?-1:$("#query_city_code").val(),
							"areaCode":typeof($("#query_area_code").val()) == "undefined"?-1:$("#query_area_code").val()
								
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
												return '<td><span class="look-span salesOrderDetailBtn" attr-tid="'+row.id+'">' + data + '-'+row.breakCode+'</span></td>';
											}
											else{
												return '<td><span class="look-span salesOrderDetailBtn" attr-tid="'+row.id+'">'
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
												if(row.isAppOrder!=null&&row.isAppOrder==2){
													return "APP";
												}
												else{
													return "";
												}
												
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
											case 37:
												return "已删除";
												break;
											default:
												return "";
												break;
											}
										}

									},

									{
										"mData" : "isAppOrder",
										"bSortable" : false,
										"sWidth" : "8%",
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
												return '<td><input type="button" class="btncss edit salesOrderEditBtn"'
												+ 'attr-data="'+data+'" value="编辑" />'
												+ '<input type="button" class="btncss edit salesOrderDeliverBtn" attr-data=\''+JSON.stringify(row)+'\' value="送审" />'
												+'<input type="button" class="btncss edit salesOrderDeleteBtn" attr-tid="'+data+'" value="删除" /></td>'
											}
											else if(row.state==4 || row.state==5 || row.state==9 || row.state==11 ||row.state==25||row.state==35){
												return '<td><input type="button" class="btncss edit salesOrderStopBtn" attr-data=\''+JSON.stringify(row)+'\' value="作废" /></td>'
											}else{
												return '<td><input type="button" class="btncss edit salesOrderDetailBtn" attr-tid="'+data+'" value="详情" /></td>'
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
				initUnitPriceChange: function(SupctoId) {
					let classTwo=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-classificationTwe"));
					let classOne=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-classificationOne"));
					let local=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-location"));
					let fax=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-fax"));
					let shippingModeId=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-shippingModeId"));
					let phone=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-phone"));
					let deliveryAddress=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-deliveryAddress"));
					let contactPeople=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-contactPeople"));
					if($("#edit_supcto_id").val()==-1){
						classTwo="请先选择客户";
						classOne="请先选择客户";
						local="请先选择客户";
						
						fax="请先选择客户";
						phone="请先选择客户";
						deliveryAddress="请先选择客户";
						contactPeople="请先选择客户";
					}
					if(local==null||local==""){
						local="该客户暂无所属地区";
					}
					if(classTwo==null||classTwo==""){
						classTwo="该客户暂无所属分类";
					}
					if(classOne==null||classOne==""){
						classOne="该客户暂无所属分类";
					}
					$("#edit_supcto_classTwe").val(classTwo);
					$("#edit_supcto_classOne").val(classOne);
					$("#edit_supcto_local").val(local);
					  $("#edit_fax").val(fax);	
					  if(shippingModeId!=""){
						  $("#edit_transportationMode").val(shippingModeId);
					  }else{
						  $("#edit_transportationMode").val(-1);
					  }
					  
					  $("#edit_phone").val(phone);
					  $("#edit_orderer").val(contactPeople);
				      $("#edit_receipt_goods_place").val(deliveryAddress);
					//客户下拉框的值改变事件-为单价赋值
					if($(".tipTr").length > 0) return;
					if($("#edit_supcto_id").val()==-1) return;
					
					var that = this;
					$(".edit_unitPrice").each(function(index) {
						that.initOneUnitPrice($(this),index);
					})
		
				
						
				},
				initOneUnitPrice: function($obj,index) {
					//为某一个单价赋值
					var that = this;
					/*
					 * 请在此处执行ajax,获取该供应商的该商品对应单价，并为其赋值
					 * 有销售价格就可以申请特价，否则显示一般销售价格不能申请特价
					 * 请修改if条件,以及第二个值（单价）
					 */
						$.ajax({
				                url: '<%=basePath%>basic/supctoCommodity/selectPriceByCommoditySpIdAndSupId',
				                type: "POST",
				                dataType: "json",
				                async: false,
				                cache: false,
				                data:{
				                	"supctoId":$("#edit_supcto_id").val(),
				                	"commodityId":$obj.parents(".goods_td").find(".edit_specId").html()
				                },
				                success: function(data) {
				                	//客户资料里设置的有该商品的销售价格
					                if(data!=null&&data.price!=null){//有销售价格就可以申请特价
					                	that.initUnitPriceCheck($obj, data.price, $obj.attr("attr-gid"));
					                }
					                //客户资料里设置的没有该商品的销售价格，显示商品建立时填写的一般销售价格
					                else{ //显示一般销售价格不能申请特价
					                	that.initUnitPriceInput($obj, $obj.parents(".goods_td").find(".baseCommodityPrice").html(), $obj.attr("attr-gid"));
					                }
					                that.setGoodsInfor($(".edit_unitPrice").eq(index)[0]);
					                
				                }
				           });	
					
					
				},
				initUnitPriceInput: function($obj, value, goodsId) {
					//一般销售价格的初始化
					$obj.parents("td").html(`
					<input type="text" id="" value="` + value + `" attr-oldPrice="` + value + `" attr-gid="` + goodsId + `" attr-flag="1" class="form-control edit_unitPrice" disabled="disabled" placeholder="请先选择客户" attr-name="单价" attr-flag="1" />
					`);
				},
				initUnitPriceCheck: function($obj, value, goodsId) {
					//申请特价的初始化
					$obj.parents("td").html(`
					<div class="input-group supcto_unitPrice">
						<input type="text" class="form-control edit_unitPrice" aria-label="..." disabled="disabled" attr-flag="1" attr-oldPrice="` + value + `" value="` + value + `" attr-name="单价">
						<span class="input-group-addon edit_isSpecialOffer_span">
							<label for="specialOffer` + goodsId + `" aria-label="...">申请特价</label>
						</span>
					</div>
					`);
				},
				supctoOneClassificationChange:function(){
					var parentId=$("#query_classification_one_id").val()-0;
					
					if(parentId>0){
						/* 二级分类下拉框赋值 */
						$.ajax({
							url :'<%=basePath%>/basic/classification/selectAllTwoClassifityByParentId' ,
							type : "POST",
							dataType : "json",
							data: {
								"parentId" : $("#query_classification_one_id").val()
							},
							success : function(data) {
								$("#query_classification_two_id").empty();
								if(data.length==0){
									$("#query_classification_two_id").append("<option value='-1' selected>--暂无数据，请到二级分类页面进行添加--</option>");	
								}else{
									$("#query_classification_two_id").append('<option value="-1" selected="selected">--请选择--</option>');
									for ( var i = 0; i < data.length; i++) {
										var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
										$("#query_classification_two_id").append(option);
										
									}
								}
							}
						});
					}else{
						$("#query_classification_two_id").html("");
						$("#query_classification_two_id").append("<option value='-1' selected>--请先选择一级分类--</option>");	
					}
				},
				specialOfferChange: function(thisdiv) {
					//申请原价使用特价的btn的change事件
					let $parent = $(thisdiv).parent();
					let $price = $parent.find("input[type='text']");
					let $label = $parent.find("label");

					switch($price.attr("attr-flag")) {
						case "1":
							$price.removeAttr("disabled");
							$label.text("使用原价");
							$price.attr("attr-flag", "2");
							//this.setGoodsInfor(thisdiv);
							break;
						case "2":
							$price.attr("attr-flag", "1");
							$price.attr("disabled", "disabled");
							$label.text("申请特价");
							$price.val($price.attr("attr-oldPrice"));
							this.setGoodsInfor(thisdiv);
							break;
						default:
							break;
					}
					return;
				},
				specimenChange: function(thisSelect) {
					//样品下拉框change事件
					if($(thisSelect).val() == 2) this.config.isSampleSheet = true;
					else this.config.isSampleSheet = false;
					
					var that=this;

					if($(".tipTr").length <= 0) {
						if(this.config.isSampleSheet) { //是样品单
							//若页面中已经添加商品  金额、税额改为0
							$(".edit_deliverGoodsMoney").val("0.00");
							$(".edit_taxesMoney").val("0.00");
							$("#total_commodity_price").val("0.00");
						} else { //不是样品单
							//若页面中已经添加商品  重新计算金额、税额、合计
							$(".edit_deliverGoodsNum").each(function() {
								that.setMoneyInfor(this);
							})
						}
					}
				},
				refreshDataTable: function() {
					this.config.dataTable.fnDraw(false);
				},
				getGoodsTrInfor: function(thisInput) {
					//获取商品表格某一行字段，用于计算
					return {
						"deliverGoodsNum": $(thisInput).parents("tr").find(".edit_deliverGoodsNum").val(),
						"taxes": $(thisInput).parents("tr").find(".edit_taxes").val(),
						"unitPrice": $(thisInput).parents("tr").find(".edit_unitPrice").attr("attr-oldPrice"),
						"discountPrice":$(thisInput).parents("tr").find(".edit_unitPrice").val(),
						"isSpecial":$(thisInput).parents("tr").find(".edit_unitPrice").attr("attr-flag")==1?false:true,//是否特价 true为特价 false为一般价格
						"discount": $(thisInput).parents("tr").find(".edit_discount").val(), 
						"deliverGoodsMoney": $(thisInput).parents("tr").find(".edit_deliverGoodsMoney").val(),
					};
				},
				setGoodsInfor: function(thisInput) {
					//计算业务金额、税额
					if(!this.config.isSampleSheet){
						let gInfo = this.getGoodsTrInfor(thisInput);
						
						if(!gInfo.isSpecial){//不是特价（此处逻辑暂定为 特价不可以使用折扣）
							gInfo.discountPrice=this.countDiscountPriceFun(gInfo.discount,gInfo.unitPrice);
						}else{
							gInfo.discountPrice=this.countDiscountPriceFun(gInfo.discount,gInfo.discountPrice);
						}
						$(thisInput).parents("tr").find(".edit_unitPrice")
							.val(gInfo.discountPrice); //单价(单价与折扣后的单价展示在同一个input框中)
						
						gInfo.deliverGoodsMoney = this.countDeliverGoodsMoneyFun(gInfo.deliverGoodsNum, gInfo.discountPrice);
						$(thisInput).parents("tr").find(".edit_deliverGoodsMoney")
							.val(gInfo.deliverGoodsMoney); //金额
	
						$(thisInput).parents("tr").find(".edit_taxesMoney")
							.val(this.countTaxesMoneyFun(gInfo.taxes, gInfo.deliverGoodsMoney)); //税额
					}
					//合计
					this.countTotalFun();

				},
				setMoneyInfor:function(thisInput){
					//计算业务金额、税额
					if(!this.config.isSampleSheet){
						let gInfo = this.getGoodsTrInfor(thisInput);
						
						gInfo.deliverGoodsMoney = this.countDeliverGoodsMoneyFun(gInfo.deliverGoodsNum, gInfo.discountPrice);
						$(thisInput).parents("tr").find(".edit_deliverGoodsMoney")
							.val(gInfo.deliverGoodsMoney); //金额
	
						$(thisInput).parents("tr").find(".edit_taxesMoney")
							.val(this.countTaxesMoneyFun(gInfo.taxes, gInfo.deliverGoodsMoney)); //税额
					}
					//合计
					this.countTotalFun();
				},
				getSalesOrder: function() {
					let formData = {};
					/*
					 * 请在此处获取form各个字段的值，形成对象
					 * 该方法用于编辑、新增的向后台提交数据，获取数据的方法
					 */
					var prepaidAmount;
		    		if($("#edit_payType").val()==1){
		    			prepaidAmount=$("#edit_advance_scale").val();
		    		}
		    		else{
		    			prepaidAmount=null;
		    		}
		    		
		    		//销售订单基础的信息
		    		formData={"id":$("#edit_sales_id").val(),"isSpecimen":$("#edit_is_specimen").val(),"createTimeString":$("#edit_generateDate").val(),"supctoId":$("#edit_supcto_id").val(),"endValidityTimeString":$("#effective_date").val(),"deliverGoodsPlace":$("#edit_deliver_goods_place").val(),
		    				"consignee":$("#edit_consignee").val(),"fax":$("#edit_fax").val(),"advanceScale":$("#edit_advance_scale").val(),"identifier":$("#edit_identifier").val(),"payment":$("#edit_payType").val(),"shippingModeId":$("#edit_transportationMode").val(),"phone":$("#edit_phone").val(),
		    				"receiptGoodsPlace":$("#edit_receipt_goods_place").val(),"orderer":$("#edit_orderer").val(),"advanceScale":prepaidAmount,"summary":$("#edit_summary").val(),"personId":$("#person_id").val(),
		    				"salesOrderCommodities":[]}; 
		    		//获取销售商品的信息，添加到销售订单的商品信息里
		    		$("#goodsTbody tr").each(function(index, val){
		    			if(index==0) return;
		    			/*var unitPrice=0;
		    			var isSpecialOffer=1;
		    			$(val).find(".edit_unitPrice").each(function(index, val){
		    				if(!$(val).hasClass("hidden")){
		    					unitPrice=$(val).val();
		    					isSpecialOffer=$(val).attr("attr-flag");
		    				}
		    			});*/
		    			//console.log("isSpecialOffer",isSpecialOffer);
		    			var salesOrderCommoditiesDataJSON={"id":$(val).find(".edit_sales_commodity_id").val(),"salesOrderId":$("#edit_sales_id").val(),"commoditySpecificationId":$(val).find(".edit_specId").html(),"discount":$(val).find(".edit_discount").val(),"taxes":$(val).find(".edit_taxes").val(),
		    					"deliverGoodsMoney":$(val).find(".edit_deliverGoodsMoney").val(),"remark":$(val).find(".edit_remark").val(),"deliverGoodsNum":$(val).find(".edit_deliverGoodsNum").val(),"unitPrice":$(val).find(".edit_unitPrice").val(),
		    					"isSpecialOffer":$(val).find(".edit_unitPrice").attr("attr-flag"),"taxesMoney":$(val).find(".edit_taxesMoney").val(),"batchNumber":$(val).find(".edit_batch_number").val(),"warehouseId":$(val).find(".edit_warehouse_id").html()};	
		    				
		    			formData.salesOrderCommodities[index-1]=salesOrderCommoditiesDataJSON;
		    			});
					
					return formData;
				},
				setSalesOrder: function(id) {
					
					let that=this;
					/*
					 * 请在此处解析data为from赋值
					 * 该方法用于编辑框打开前，为框内的内容赋值
					 */
					ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectOrderDetailById",{"id":id},function(data){
						$("#edit_sales_id").val(data.id);
						$("#edit_is_specimen").val(data.isSpecimen);
						if(data.isSpecimen==1){
							that.config.isSampleSheet = false;
						}
						else{
							that.config.isSampleSheet = true;
						}
						$("#edit_generateDate").val(getSmpFormatDateByLong(data.createTime,true));
						if(data.supctoId!=null){
							$("#edit_supctoId_input").addClass("hidden");
							$("#edit_supcto_id").removeClass("hidden");
							SearchableSelectsetValue("#edit_supcto_id",data.supctoId);
							that.config.customerId=data.supctoId;
							var location="";
                        	location+=data.supcto.province;
                        	if(data.supcto.city!=null&&data.supcto.city!="") location+=" "+data.supcto.city;
                        	location+=" "+data.supcto.area;
                        	let classTwo=$.trim(data.supcto.classificationTweName);
        					let classOne=$.trim(data.supcto.classificationOneName);
        					let local=$.trim(location);
         					if($("#edit_supcto_id").val()==-1){
        						classTwo="请先选择客户";
        						classOne="请先选择客户";
        						local="请先选择客户";
        					}
        					if(local==null||local==""){
        						local="该客户暂无所属地区";
        					}
        					if(classTwo==null||classTwo==""){
        						classTwo="该客户暂无所属分类";
        					}
        					if(classOne==null||classOne==""){
        						classOne="该客户暂无所属分类";
        					}
        					$("#edit_supcto_classTwe").val(classTwo);
							$("#edit_supcto_classOne").val(classOne);
							$("#edit_supcto_local").val(local);
						}
						else{
							$("#edit_supctoId_input").removeClass("hidden");
							$("#edit_supcto_id").addClass("hidden");
							$("#edit_supcto_id").parent().addClass("hidden");
							$("#edit_supctoId_input").val("无");
							$("#edit_supcto_classTwe").addClass("hidden");
							$("#edit_supcto_classTwe").parent().addClass("hidden");
							$("#edit_supcto_classOne").addClass("hidden");
							$("#edit_supcto_classOne").parent().addClass("hidden");
							$("#edit_supcto_local").addClass("hidden");
							$("#edit_supcto_local").parent().addClass("hidden");
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
								that.setPrepaidAmountForm()
								$("#edit_advance_scale").val(data.advanceScale);
								break;
							case 2:
								that.clearPrepaidAmountForm()
								break;
							case 3:
								that.clearPrepaidAmountForm()
								break;
							default:
								break;
							}
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
						that.initPersonSelect(data.personDepartmentId, "#person_id",data.personId);
						$(".tipTr").remove();
						let deliverGoodsNum=0;
						let deliverGoodsMoney=0.0;
						let batchNumber="";
						for(var i=0;i<data.salesOrderCommodities.length;i++){	
							that.config.goodsTable.goodsArr.push(data.salesOrderCommodities[i].commoditySpecificationId);
							deliverGoodsNum+=data.salesOrderCommodities[i].deliverGoodsNum;
							deliverGoodsMoney+=data.salesOrderCommodities[i].deliverGoodsMoney;
							if(data.salesOrderCommodities[i].batchNumber!=null) batchNumber=data.salesOrderCommodities[i].batchNumber;
							$("#goodsTbody").append(`<tr class="goods_td">
								<td class="hidden edit_sales_commodity_id">` + data.salesOrderCommodities[i].id + `</td>
								<td class="hidden edit_specId">` + data.salesOrderCommodities[i].commoditySpecificationId + `</td>
								<td class="hidden edit_warehouse_id">` + data.salesOrderCommodities[i].warehouseId + `</td>
								<td>` + data.salesOrderCommodities[i].commoditySpecification.commodity.name + `</td>
								<td>` + data.salesOrderCommodities[i].commoditySpecification.specificationIdentifier + `</td>
								<td>` + data.salesOrderCommodities[i].commoditySpecification.specificationName + `</td>
								<td>` + data.salesOrderCommodities[i].commoditySpecification.baseUnitName + `</td>
								<td class="hidden baseCommodityPrice">` + toDecimal2(data.salesOrderCommodities[i].commoditySpecification.baseCommonlyPrice) + `</td>
								<td><input type="text" id="" value="`+data.salesOrderCommodities[i].deliverGoodsNum+`" class="form-control edit_deliverGoodsNum" attr-name="发货数量"/></td>
								<td><input type="text"  class="form-control edit_taxes" value="` + toDecimal2(data.salesOrderCommodities[i].taxes) + `" attr-name="税率"/></td>
								<td><input type="text" id="" value="`+(data.salesOrderCommodities[i].discount==null?100:data.salesOrderCommodities[i].discount)+`" class="form-control edit_discount" attr-name="折扣"/></td>
								<td><input type="text" id="" value="" attr-gid="` + data.salesOrderCommodities[i].commoditySpecificationId + `" class="form-control edit_unitPrice" disabled="disabled" placeholder="请先选择客户"/></td>
								<td><input type="text" value="` + toDecimal2(data.salesOrderCommodities[i].deliverGoodsMoney) + `" class="form-control edit_deliverGoodsMoney" disabled="disabled" placeholder="请先填写发货数量" /></td>
								<td><input type="text" value="` + toDecimal2(data.salesOrderCommodities[i].taxesMoney) + `" id="" value="" class="form-control edit_taxesMoney"  placeholder="请先填写税率、发货数量" disabled="disabled"/></td>
								<td><input type="text" class="form-control edit_batch_number" onkeyup="cky(this)" value="`+(batchNumber==""?'0000':batchNumber)+`" attr-name="批号"/></td>
								<td><input type="text" id="" class="form-control edit_remark" onkeyup="cky(this)" value="`+data.salesOrderCommodities[i].remark+`" attr-name="备注"/></td>
								<td><input type="button" class="btncss edit goodsDelBtn" attr-tid="` + data.salesOrderCommodities[i].commoditySpecificationId + `" value="删除" /></td>
							</tr>`);
							
							//是从销售计划单生成的销售订单
							if(data.salesPlanOrderId!=null&&data.salesPlanOrderId>0){
								$("#goodsTbody tr:last").find(".edit_deliverGoodsMoney").attr("disabled","disabled");
								$("#goodsTbody tr:last").find(".edit_deliverGoodsNum").attr("disabled","disabled");
								//$("#goodsTbody tr:last").find(".goodsDelBtn").attr("disabled","disabled");
							}else{
								$("#goodsTbody tr:last").find(".edit_deliverGoodsNum").removeAttr("disabled");
								//$("#goodsTbody tr:last").find(".goodsDelBtn").removeAttr("disabled");
							}
							
							let $obj=$("#goodsTbody tr:last").find(".edit_unitPrice");
							//没有申请特价
							if(data.salesOrderCommodities[i].isSpecialOffer==1){
								//没有申请特价，但是客户下有该商品设定的销售价格
								if(data.salesOrderCommodities[i].oldUnitPrice!=null&&data.salesOrderCommodities[i].oldUnitPrice>0){
									that.initUnitPriceCheck($obj, toDecimal2(data.salesOrderCommodities[i].unitPrice), $obj.attr("attr-gid"));
								}
								that.initUnitPriceInput($obj, toDecimal2(data.salesOrderCommodities[i].unitPrice), $obj.attr("attr-gid"));
							}
							//有申请的特价
							else{
								that.initUnitPriceCheck($obj, toDecimal2(data.salesOrderCommodities[i].unitPrice), $obj.attr("attr-gid"));
								$obj=$("#goodsTbody tr:last").find(".edit_unitPrice");
								let $parent=$obj.parent();
								let $label=$parent.find("label");
								let $price = $parent.find("input[type='text']");
								$price.removeAttr("disabled");
								$label.text("使用原价");
								$price.attr("attr-flag", "2");
								$price.attr("attr-oldPrice",data.salesOrderCommodities[i].oldUnitPrice);
							}
						}
						that.setGoodsInfor("#goodsTbody tr:last .edit_unitPrice");
						//that.countTotalFun();//合计
						//$("#total_commodity_num").val(toDecimal2(deliverGoodsNum));
						//$("#total_commodity_price").val(toDecimal2(deliverGoodsMoney));
					})
				},
				salesOrderAddEvent: function() {
					//新增销售订单
					//console.log("新增销售订单");
					$("#edit_summary").val("无");
					$("#edit_is_specimen").val(1);
					$("#edit_deliver_goods_place").val("总部");
					$("#edit_consignee").val("无");
					let that = this;
					//初始化客户
					this.initSupctoSelect();
					//给变量赋值，传入初始化商品时获取商品的接口中
					this.config.updateOrAdd=1;
					//初始化商品
					this.initGoodsSelect();
					layer.open({
						type: 1,
						title: "新增" + that.config.title,
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#editDiv"),
						scrollbar: false,
						btn: ['提交', '取消'],
						yes: index => {
							if(!this.checkFormisFilledLayerFun() || !this.checkFormRuleLayerFun()) return;
							var flag=true;
							$("#goodsTbody tr").each(function(index, val){
		
				    			if($(val).find(".edit_deliverGoodsNum").val()-0==0){
				    				flag = false;
				    			}
				    		});
							if(!flag){
								laywarn("发货数量不能为0。");
								return false;
							}
							/*
							 * 添加销售订单添加成功相关逻辑代码
							 */
							var formdata = this.getSalesOrder(); //获取页面数据的值，用于提交到后台
							$.ajax({
								url: '<%=basePath%>sales/salesOrder/addSalesOrder?planOrTable='+2,
								type: "POST",
								dataType: "json",
								data:{
									"salesOrder":JSON.stringify(formdata)
								},
								async: false,
								cache: false,
								success: function(data) {
									if(data.success) {
										laysuccess(data.msg);
										that.refreshDataTable(); //刷新datatable
									} else {
										layfail(data.msg);
									}
									layer.close(index);
								}
							});
						},
						end: (index, layero) => {
							layer.close(index);
							clearForm("editDiv", "");
							this.clearGoodsEvent();
							this.clearPrepaidAmountForm();
							this.clearIsSampleSheet();
							this.config.customerId=-1;
							
						}
					});
				},
				salesOrderDetailEvent: function(tid) {
					//销售订单 详情
					//console.log("销售订单详情"+tid);
					var that = this;
					$.ajax({
						type: "post",
						url: "<%=basePath%>sales/salesOrder/salesOrderDetail",
						dataType: "json",
						data: {
							"id": tid,
							"type": 1
						},
						success: function(res) {
							let bill = new DetailBill(res);
							let $content = bill.toPrint();
							$("#detailDiv").html($content);
						}
					});
					layer.open({
						type: 1,
						title: that.config.title + "详情",
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#detailDiv"),
						btn: ['关闭']
					});
				},
				salesOrderEditEvent: function(data) {
					let that=this;
					//销售订单 编辑
					//console.log("销售订单 编辑" + data);
					//初始化客户
					this.initSupctoSelect();
					//给变量赋值，传入初始化商品时获取商品的接口中
					this.config.updateOrAdd=2;//修改
					//需要修改的订单id
					this.config.updateOrderId=data;
					//初始化商品
					this.initGoodsSelect();
					$("#headEdit .row").prepend(this.config.editForm);
					this.setSalesOrder(data); //根据data获取单据信息为表单赋值
					layer.open({
						type: 1,
						title: "编辑" + that.config.title,
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#editDiv"),
						scrollbar: false,
						btn: ['提交', '取消'],
						yes: index => {
							if(!this.checkFormisFilledLayerFun()|| !this.checkFormRuleLayerFun()) return;
							var flag=true;
							$("#goodsTbody tr").each(function(index, val){
		
				    			if($(val).find(".edit_deliverGoodsNum").val()-0==0){
				    				flag = false;
				    			}
				    		});
							if(!flag){
								laywarn("发货数量不能为0。");
								return false;
							}
							/*
							 * 请在此处添加其他收货单编辑的相关代码
							 */
							var formdata = this.getSalesOrder(); //获取页面数据的值，用于提交到后台
							$.ajax({
								url: '<%=basePath%>sales/salesOrder/editSalesOrder',
								type: "POST",
								dataType: "json",
								data:{
									"salesOrder":JSON.stringify(formdata)
								},
								async: false,
								cache: false,
								success: function(data) {
									if(data.success) {
										laysuccess(data.msg);
										that.refreshDataTable(); //刷新datatable
									} else {
										layfail(data.msg);
									}
									layer.close(index);
								}
							});
						},
						end: (index, layero) => {
							layer.close(index);
							clearForm("editDiv", "");
							this.clearGoodsEvent();
							this.clearPrepaidAmountForm();
							this.clearIsSampleSheet()
							$(".editInfo").remove();
							this.config.customerId=-1;
						}
					});

				},
				salesOrderDeleteEvent: function(tid) {
					let that=this;
					//销售订单 删除
					//console.log("销售订单 删除" + tid);
					/*
					 * 请在此处添加销售订单删除的相关代码
					 */
					publicMessageLayer("删除该订单", function() {
						
						$.ajax({
							url: '<%=basePath%>sales/salesOrder/deletePurchaseOrder',
							type: "POST",
							dataType: "json",
							data:{
								"id":tid
							},
							async: false,
							cache: false,
							success: function(data) {
								if(data.success) {
									laysuccess(data.msg);
									//刷新datatable
									that.refreshDataTable();
								} else {
									layfail(data.msg);
								}
								layer.close(index);
							}
						});
					})

				},
				salesOrderDeliverEvent: function(data) {
					let that=this;
					let row=$.parseJSON(data);
					//销售订单 送审
					//console.log("销售订单 送审" + row.payment);
					/*
					 * 请在此处添加销售订单送审的相关代码
					 */
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
												//刷新datatable
												that.refreshDataTable();
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
														//刷新datatable
														that.refreshDataTable();
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
				
					
				},
				salesOrderStopEvent: function(data) {
					let that=this;
					let row=$.parseJSON(data);
					//销售订单 作废
					//console.log("销售订单 作废" + row.id);
					/*
					 * 请在此处添加销售订单终止的相关代码
					 */
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
									//刷新datatable
									that.refreshDataTable();
								} else {
									layfail(data.msg);
								}
								layer.close(index);
							}
						});
					});

					
				},
				goodsAddEvent: function() {
					//新增商品
					//console.log("新增商品事件");

					let goodsId = $("#edit_goods").val();
					let goodsNum = $("#edit_goods").find("option:selected").attr("attr-identifier"); //编码
					let data = this.config.goodsSelectData;
					let goodsName = $("#edit_goods").find("option:selected").attr("attr-commodityName"); //名称
					let goodsType = $("#edit_goods").find("option:selected").attr("attr-specName"); //规格
					let goodsLogo =  $("#edit_goods").find("option:selected").attr("attr-brand"); //品牌
					let goodsUnit = $("#edit_goods").find("option:selected").attr("attr-baseUnit"); //单位
					let goodsUnitPrices =  $("#edit_goods").find("option:selected").attr("attr-unitPrice"); //业务单价
					let goodsTax = $("#edit_goods").find("option:selected").attr("attr-taxes"); //税率
					let warehouseId=$("#edit_goods").find("option:selected").attr("attr-warehouseId"); //所属仓库id

					/*
					 * 请根据之前存储到this.config.goodsSelectData进行循环
					 * 找到对应编码商品为名称、规格、单位、税率赋值
					 */

					let deliverGoodsMoney = ""; //金额
					let taxesMoney = ""; //税额
					if(this.config.isSampleSheet) {
						deliverGoodsMoney = "0.00";
						taxesMoney = "0.00";
					}

					if(goodsId == -1) {
						layfail("请先选择商品!");
					} else if(!this.checkRepeatFun(this.config.goodsTable.goodsArr, goodsId)) {
						$(".tipTr").remove();
						this.config.goodsTable.goodsArr.push(goodsId);
						$("#goodsTbody").append(`<tr class="goods_td">
							<td class="hidden edit_specId">` + goodsId + `</td>
							<td class="hidden edit_warehouse_id">` + warehouseId + `</td>
							<td>` + goodsName + `</td>
							<td>` + goodsNum + `</td>
							<td>` + goodsType + `</td>
							<td>` + goodsUnit + `</td>
							<td class="hidden baseCommodityPrice">` + goodsUnitPrices + `</td>
							<td><input type="text" id="" value="" class="form-control edit_deliverGoodsNum" attr-name="发货数量" /></td>
							<td><input type="text"  class="form-control edit_taxes" value="` + goodsTax + `" attr-name="税率" /></td>
							<td><input type="text" id="" value="100" class="form-control edit_discount" attr-name="折扣" /></td>
							<td><input type="text" id="" value="" attr-gid="` + goodsId + `" class="form-control edit_unitPrice" disabled="disabled" placeholder="请先选择客户" attr-name="单价" /></td>
							<td><input type="text" value="` + deliverGoodsMoney + `" class="form-control edit_deliverGoodsMoney" disabled="disabled" placeholder="请先填写发货数量" /></td>
							<td><input type="text" value="` + taxesMoney + `" id="" value="" class="form-control edit_taxesMoney"  placeholder="请先填写税率、发货数量" disabled="disabled"/></td>
							<td><input type="text" value="0000" class="form-control edit_batch_number" onkeyup="cky(this)" attr-name="批号" /></td>
							<td><input type="text" id="" value="无" class="form-control edit_remark" onkeyup="cky(this)" attr-name="备注" /></td>
							<td><input type="button" class="btncss edit goodsDelBtn" attr-tid="` + goodsId + `" value="删除" /></td>
						</tr>`);
						//初始化单价
						if($("#edit_supcto_id").val()==-1) return;
						this.initOneUnitPrice($("#goodsTbody tr:last").find(".edit_unitPrice"));
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
					this.config.goodsSelectData = [];
				},
				setPrepaidAmountForm: function() {
					//添加预付金额
					if($(".advanceScaleForm").length == 0) $("#headEdit .row").append(this.config.advanceScaleForm);
				},
				clearPrepaidAmountForm: function() {
					//删除预付金额
					$(".advanceScaleForm").remove();
				},
				clearIsSampleSheet: function() {
					this.config.isSampleSheet = false; //重置是否是样品单字段
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
					if($("#edit_is_specimen").val()==-1){
						layfail("请选择是否为样品单");
						res = false;
					}
					if(!res) return res;
					$("#headEdit input").each(function(index, val) {
						if($(val).hasClass("searchable-select-input")&& that.config.customerId==-1&&res){
							that.checkInputEmptyLayer(val);
							res = false;
						}else if($(val).val() == ""&&(!$(val).hasClass("searchable-select-input"))&&(!$(val).hasClass("hidden"))&&res){
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
					if(!res) return res;
					$("#footerEdit select").each(function(index, val) {
						if($(val).val() == "-1"&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#footerEdit input").each(function(index, val) {
						if($(val).val() == ""&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					return res;
				},
				checkFormisFilledLayerFun: function() {
					let res = this.checkFormisFilledFun();
					//if(!res) layfail("表单未填写完整，请完善后提交");
					return res;
				},
				countDiscountPriceFun:function(discount,unitPrice){
					//计算 折扣单价=折扣*单价
					discount=discount||100;
					if(!unitPrice) return;
					return toDecimal2((discount - 0) * (unitPrice - 0)*0.01);
				},
				countDeliverGoodsMoneyFun: function(deliverGoodsNum, unitPrice) {
					//计算 金额=发货数量*单价
					if(!deliverGoodsNum || !unitPrice) return "";
					return toDecimal2((deliverGoodsNum - 0) * (unitPrice - 0));
				},
				countTaxesMoneyFun: function(taxes, deliverGoodsMoney) {
					//计算 税额=税率*金额
					if(!taxes || !deliverGoodsMoney) return "";
					return toDecimal2((taxes - 0) * (deliverGoodsMoney - 0));
				},
				countTotalFun: function() {
					//计算合计
					$("#total_commodity_num").val(parseInt(this.countOneTotalFun(".edit_deliverGoodsNum"))); //发货数量
					$("#total_commodity_price").val(this.countOneTotalFun(".edit_deliverGoodsMoney")); //金额

				},
				clearTotalFun: function() {
					$("#total_commodity_num").val(""); //订货数量
					$("#total_commodity_price").val(""); //税额

				},
				countOneTotalFun: function(input) {
					//计算
					$input = $(input);
					let total = 0;
					$.each($input, function(index, obj) {
						total += ($(obj).val() - 0);
					});
					return toDecimal2(total);
				}
			}
			order.init();

			//客户下拉框的onchange事件
			window.getCommodityMsg = value => {
				order.initUnitPriceChange(value);
				order.config.customerId=value;

			}
			//商品下拉框的onchang事件
			window.selectCommodityMsg = (thisSelect, value) => {

			}

		})(document);
	</script>

</html>