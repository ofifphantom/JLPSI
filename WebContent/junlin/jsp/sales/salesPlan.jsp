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
		<title>销售计划单</title>
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
					<h4 class="text-title">销售计划单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
								单号： <input type="text" value="" id="query_identifier"/>
							</span>
								<span class="l_f"> 
								货品名称： <input type="text" value="" id="query_goodsName"/>
							</span>
								<span class="l_f"> 
								操作人姓名： <input type="text"  value="" id="query_originator"/>
							</span>
							<span class="l_f"> 
								状态：<select id="query_state" >
									<option value="-1" selected="selected">--请选择--</option>
									<option value="1">未生成订单</option>
									<option value="2">已生成订单</option>
									<option value="3">已失效</option>
									<option value="4">已删除</option>
								</select>
							</span>
							<span class="l_f" style="margin-left:19px"> 
								起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
							</span>
								<span class="r_f"> 
								<input type="button" id="btn_search" class="btncss btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<span class="r_f">
							<button type="button" class="btncss jl-btn-defult salesPlanAddBtn" style="margin-right: 0;">
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
										<th>计划对象</th>
										<th>货品名称</th>
										<th>品牌</th>
										<th>制单人</th>
										<th>日期</th>
										<th>app订单</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- <tr>
										<td><span class="look-span salesPlanDetailBtn" attr-tid="0">1321</span></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>
											<input type="button" class="btncss edit toSalesOrderBtn" attr-tid="0" value="生成销售订单" />
											<input type="button" class="btncss edit salesPlanDetailBtn" attr-tid="0" value="详情" />
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
								<label for="" class="col-xs-4 control-label">计划对象</label>
								<div class="col-xs-8" id="edit_supctoIdDiv">
									<select id="edit_supcto_id" class="form-control">
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">结束日期</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="orderEndTime" readonly="readonly" placeholder="请选择结束日期" />
								</div>
							</div>
						</div>
						
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">币种</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" value="人民币" class="form-control" id="edit_currency" disabled="disabled" />
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
								<input id="edit_goods" class="form-control" value="请先选择计划对象" disabled />
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
								<!--<th nowrap="nowrap">折扣</th>-->
								<th nowrap="nowrap">业务单价</th>
								<th nowrap="nowrap">业务数量</th>
								<th nowrap="nowrap">金额</th>
								<th nowrap="nowrap">备注</th>
								<th nowrap="nowrap">操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="11">请先选择商品</td>
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
									<input type="text" id="summary" value="无" class="form-control" onkeyup="cky(this)" maxlength="100" />
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
	</body>

	<script>
	
		//立即执行函数
		(function(dom) {
			let order = {
				config: { //字段配置，存储变量
					title: "销售计划单",
					dataTable: {}, //该字段用于存储datadtable
					customerId:-1,//用于记录当前选中的客户
					goodsSelectData: [], //用于存储当前选中的计划对象的所有商品
					goodsTable: {
						head: `<tr>
							<th nowrap="nowrap">货品名称</th>
							<th nowrap="nowrap">规格编码</th>
							<th nowrap="nowrap">规格</th>
							<th nowrap="nowrap">品牌</th>
							<th nowrap="nowrap">单位</th>
							<th nowrap="nowrap">业务单价</th>
							<th nowrap="nowrap">业务数量</th>
							<th nowrap="nowrap">金额</th>
							<th nowrap="nowrap">备注</th>
							<th nowrap="nowrap">操作</th>
						</tr>`,
						tipTr: '<tr class="tipTr"><td colspan="11">请先选择商品</td></tr>',
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
					latdateNoBefore("#orderEndTime");
					this.initDepartmentSelect("#department_id");
				},
				initEvent: function() {
					let that = this;
					//事件绑定
					//新增销售计划单
					$(".salesPlanAddBtn").on("click", () => {
						this.salesPlanAddEvent();
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
					//部门下拉框值改变事件
					$("#department_id").on("change", function() {
						that.initPersonSelect($(this).val(), "#person_id");
					})

					/*事件委托 begin*/
					//销售计划单 详情
					$("#datatable").delegate(".salesPlanDetailBtn", "click", function() {
						that.salesPlanDetailEvent($(this).attr("attr-tid"));
					})
					//销售计划单 生成销售订单
					$("#datatable").delegate(".toSalesOrderBtn", "click", function() {
						that.toSalesOrderEvent($(this).attr("attr-tid"));
					})
					//销售计划单 删除销售计划单
					$("#datatable").delegate(".salesPlanDelBtn", "click", function() {
						that.salesPlanDelEvent($(this).attr("attr-data"));
					})

					//删除商品
					$("#goodsTbody").delegate(".goodsDelBtn", "click", function() {
						that.goodsDelEvent(this, $(this).attr("attr-tid"));
					})
					
					//业务数量  监听事件
					$("#goodsTbody").delegate(".edit_goodsNumber", "keyup blur", function() {
						pressInteger(this);
						that.setGoodsInfor(this);
					})
					
					//折扣  监听事件
					/* $("#goodsTbody").delegate(".edit_discount", "keyup blur", function() {
						pressIntegersOneHundred(this);
						that.setGoodsInfor(this);
					}) */
					/*事件委托 end*/
					
					
					
					/*初始化起止时间*/
					laydate.render({
						elem: "#query_time",
						range:'~'
					});

				},
				initSupctoSelect: function() {
					//初始化计划对象
					$("#edit_supcto_id").parent().html('<select id="edit_supcto_id" class="form-control"></select>');
					/*
					 * 请在此处为计划对象下拉框添加option
					 */
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
			                        $("#edit_supcto_id").append("<option value='-1' selected>--请选择--</option>");
			                        for(var i=0;i<data.length;i++){
			                        	var shippingModeId=data[i].shippingModeId==null?-1:data[i].shippingModeId;
			                            var option = $("<option   attr-fax='"+data[i].fax+"'   attr-shippingModeId='"+shippingModeId+"' attr-phone='"+data[i].phone+"' attr-deliveryAddress='"
			                            		+data[i].deliveryAddress+"' attr-contactPeople='"+data[i].contactPeople+"'       value='"+data[i].id+"' >"
			                                + data[i].name + "</option>");
			                            $("#edit_supcto_id").append(option);
			                        }
			                    }
			                }
			            });
					
					/* $("#edit_supcto_id").html(`<option value="-1">--请选择计划对象--</option>
										<option value="1">1</option>
										<option value="2">2</option>`); */

					$("#edit_supcto_id").searchableSelect();
				},
				initGoodsSelect: function() {
					let that = this;
					//初始化商品 
					$("#edit_goods").parent().html('<select id="edit_goods" class="form-control"></select>');
					/*
					 * 请在此处为商品下拉框添加option
					 * 并将查到的商品暂时存储到this.config.goodsSelectData
					 */
					 $.ajax({
		                url: '<%=basePath%>basic/goods/commodity/getHasInventoryCommodityByStateAndIsDeleteBySupctoId',
		                type: "POST",
		                dataType: "json",
		                async: false,
		                cache: false,
		                data:{
		                },
		                success: function(data) {
		                	that.config.goodsSelectData=[];
							that.config.goodsSelectData=data;
							 $("#edit_goods").html("")
		                   
		                    if(data.length==0){
		                        $("#edit_goods").append("<option value='-1' selected>--暂无数据，请到商品页面进行添加。--</option>");
		                    }
		                    else{
		                        $("#edit_goods").append("<option value='-1' selected>--请选择商品--</option>");
		                        for(var i=0;i<data.length;i++){
		                            var option = $("<option value='"+data[i].id+"' attr-identifier='"+data[i].specificationIdentifier+"' attr-commodityName='"+data[i].commodity.name+"'  attr-specName='"+data[i].specificationName +"' attr-brand='"+data[i].commodity.brand+"' attr-baseUnit='"+data[i].baseUnitName+"' attr-unitPrice='"+data[i].baseCommonlyPrice+"'>"
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
								$select.append('<option value="-1" selected="selected">--请选择--</option>');
								for ( var i = 0; i < data.length; i++) {
									var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
									$select.append(option);			
								}
							}
											
						}
					});
					//$select.append(`<option value="1">1</option><option value="2">2</option>`);

				},
				initPersonSelect: function(departmentId, select) {
					//初始化业务员下拉框
					$select = $(select);
					if(departmentId == -1) {
						$select.html(`<option value="-1" selected="selected">--请先选择部门--</option>`);
						return;
					}
					//$select.html(`<option value="-1">--请选择业务员--</option>`);
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
								$select.append('<option value="-1" selected="selected">--请选择业务员--</option>');
								for ( var i = 0; i < data.length; i++) {
									var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
									$select.append(option);		
								}
								/*if(personId>0){
									$select.val(personId);
								}*/
							}
							
						}
					});
					//$select.append(`<option value="1">1</option><option value="2">2</option>`);

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
									"identifier": $("#query_identifier").val(),
									"commodityName": $("#query_goodsName").val(),
									"originator": $("#query_originator").val(),
									"createTime": $("#query_time").val(),
									"state":$("#query_state").val()
								});
							},
							"url": "<%=basePath%>/sales/salesPlanOrder/getSalesPlanOrderMsg"
									},

									"aoColumns" : [{
												"mData" : "identifier",
												"bSortable" : false,
												"sWidth" : "15%",
												"sClass" : "center",
												"mRender" : function(data, type, row) {
													return '<td><span class="look-span salesPlanDetailBtn" attr-tid="'+row.id+'">'
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
														if(row.isAppOrder!=null&&row.isAppOrder==2){
															return "APP";
														}
														else{
															return "";
														}
														
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
												"mData" : "commoditysBrandName",
												"bSortable" : false,
												"sWidth" : "10%",
												"sClass" : "center"

											},
											{
												"mData" : "originator",
												"bSortable" : false,
												"sWidth" : "10%",
												"sClass" : "center",
												"mRender": function(data,type,row) {
													if(data!=null){
														if(row.originatorName!=null && row.originatorName!=""){
															return data+"("+row.originatorName+")";
														}
														else{
															return data;
														}
													}
													else{
														return "";
													}
													
												}

											},
											{
												"mData" : "createTime",
												"bSortable" : false,
												"sWidth" : "10%",
												"sClass" : "center",
												"mRender": function(data) {
													return getSmpFormatDateByLong(data, true);
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
												"mData" : "state",
												"bSortable" : false,
												"sWidth" : "8%",
												"sClass" : "center",
												"mRender" : function(data, type, row) {
													switch (data) {
													case 1:
														return '未生成订单';
														break;
													case 2:
														return '已生成订单';
														break;
													case 3:
														return '已失效';
														break;
													case 4:
														return '已删除';
														break;
													default:
														return '';
														break;
													}
												}
											},
											{
												"mData" : "id",
												"bSortable" : false,
												"sWidth" : "15%",
												"sClass" : "center",
												"mRender" : function(data, type, row) {
													if(row.state==2){
														return '<td><input type="button" class="btncss edit salesPlanDetailBtn" attr-tid="'+data+'" value="详情" /></td>'
													}
													else if(row.state==3){
														return '<td><input type="button" class="btncss edit salesPlanDetailBtn" attr-tid="'+data+'" value="详情" />'
														+'<input type="button" class="btncss edit salesPlanDelBtn" attr-data=\''+JSON.stringify(row)+'\' value="删除" /></td>'
													}
													else if(row.state==4){
														return '<td><input type="button" class="btncss edit salesPlanDetailBtn" attr-tid="'+data+'" value="详情" /></td>'
													}
													else{
														if(row.isAppOrder==2){
															return '<td><input type="button" class="btncss edit salesPlanDetailBtn" attr-tid="'+data+'" value="详情" /></td>'
														}
														else{
															return '<td><input type="button" class="btncss edit toSalesOrderBtn" attr-tid="'+data+'" value="生成销售订单" />'
															+'<input type="button" class="btncss edit salesPlanDelBtn" attr-data=\''+JSON.stringify(row)+'\' value="删除" /></td>'
														}
														
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
				getSalesPlan: function() {
					let formData = {};
					/*
					 * 请在此处获取form各个字段的值，形成对象
					 * 该方法用于编辑、新增的向后台提交数据，获取数据的方法
					 */
					//销售计划单基础的信息
					let fax=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-fax"));
					let shippingModeId=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-shippingModeId"));
					let phone=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-phone"));
					let deliveryAddress=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-deliveryAddress"));
					let contactPeople=$.trim($("#edit_supcto_id").find("option:selected").attr("attr-contactPeople"));
					
 		    		formData={"supctoId":$("#edit_supcto_id").val(),
		    				"endTimeString":$("#orderEndTime").val(),
		    				"summary":$("#summary").val(),
		    				"personId":$("#person_id").val(),
		    				"fax":fax,"shippingModeId":shippingModeId,"phone":phone,"deliveryAddress":deliveryAddress,"contactPeople":contactPeople,
 
		    				"salesPlanOrderCommodities":[]}; 
		    		//获取销售计划商品的信息，添加到销售计划单的商品信息里
		    		$("#goodsTbody tr").each(function(index, val){
		    			if(index==0) return;
		    			var salesPlanOrderCommoditiesDataJSON={"commoditySpecificationId":$(val).find(".edit_specId").html(),
		    					"number":$(val).find(".edit_goodsNumber").val(),
		    					"unitPrice":$(val).find(".edit_goodsUnitPrice").val(),
		    					"money":$(val).find(".edit_goodsMoney").val(),
		    					"remark":$(val).find(".edit_remark").val()};	
		    				
		    			formData.salesPlanOrderCommodities[index-1]=salesPlanOrderCommoditiesDataJSON;	
		    			});
					//console.log("formData",formData);
					return formData;
				},
				getGoodsTrInfor: function(thisInput) {
					//获取商品表格某一行字段，用于计算
					return {
						"unitPrice": $(thisInput).parents("tr").find(".edit_goodsUnitPrice").val(),
//						"discountPrice":$(thisInput).parents("tr").find(".edit_goodsUnitPrice").val(),
//						"discount": $(thisInput).parents("tr").find(".edit_discount").val(), 
						"goodsMoney": $(thisInput).parents("tr").find(".edit_goodsMoney").val(),
						"goodsNumber": $(thisInput).parents("tr").find(".edit_goodsNumber").val()
					};
				},
				setGoodsInfor: function(thisInput) {
					//计算金额
					let gInfo = this.getGoodsTrInfor(thisInput);
					
					/*gInfo.discountPrice=this.countDiscountPriceFun(gInfo.discount,gInfo.unitPrice);
							$(thisInput).parents("tr").find(".edit_goodsUnitPrice")
								.val(gInfo.discountPrice); //单价(单价与折扣后的单价展示在同一个input框中)*/

					gInfo.goodsMoney = this.countTotalPriceFun(gInfo.goodsNumber, gInfo.unitPrice);
					$(thisInput).parents("tr").find(".edit_goodsMoney")
						.val(gInfo.goodsMoney); //金额

					//合计
					this.countTotalFun();

				},
				salesPlanAddEvent: function() {
					//新增销售计划单
					//console.log("新增销售计划单");
					$("#summary").val("无");
					let that = this;
					//初始化计划对象
					this.initSupctoSelect();
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
							
							if(!this.checkFormisFilledLayerFun()) return;

							/*
							 * 添加销售计划单添加成功相关逻辑代码
							 */
							var formdata = this.getSalesPlan(); //获取页面数据的值，用于提交到后台
							$.ajax({
								url: '<%=basePath%>sales/salesPlanOrder/addSalesPlanOrder',
								type: "POST",
								dataType: "json",
								data:{
									"salesPlanOrder":JSON.stringify(formdata)
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
							$("#edit_currency").val("人民币");
							this.clearGoodsEvent();
							this.config.customerId=-1;
						}
					});
				},
				salesPlanDetailEvent: function(tid) {
					//销售计划单 详情
					//console.log("销售计划单详情"+tid);
					var that = this;
					$.ajax({
						type: "post",
						url: "<%=basePath%>sales/salesPlanOrder/salesPlanOrderDetail",
						dataType : "json",
						data: {
							"id" : tid
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
				toSalesOrderEvent: function(tid) {
					var that = this;
					//销售计划单 生成销售订单
					//console.log("销售计划单 生成销售订单" + tid);
					/*
					 * 请在此处添加销售计划单 生成销售订单的相关代码
					 */
					 publicMessageLayer("生成销售订单", function(){
						 $.ajax({
								url: '<%=basePath%>sales/salesOrder/addSalesOrder?planOrTable='+1,
								type: "POST",
								dataType: "json",
								data:{
									"salesPlanOrderId":tid
								},
								async: false,
								cache: false,
								success: function(data) {
									if(data.success) {
										laysuccess("已成功生成销售订单！");
										//刷新datatable
										that.refreshDataTable();
										
									} else {
										layfail("销售订单生成失败！");
									}
									layer.close(index);
								}
							});
					 })
					
				},
				salesPlanDelEvent: function(data) {
					var that = this;
					let row=$.parseJSON(data);
					//销售计划单 删除销售计划单
					//console.log("销售计划单 删除销售计划单" + tid);
					/*
					 * 请在此处添加销售计划单 删除销售计划单的相关代码
					 */ 
					 let type=0;//0:不需要清库存，1：需要清库存
					//判断订单是否有结束时间，若有，则为人为生成
					 if(row.endTime!=null&&row.endTime!=""){
						//若为人为生成，则需判断是否已失效，若失效，则不需要修改库存的占用信息.
						 if(row.state==3){
							 type=0;
						 }
						//若未失效，则需修改库存的占用信息。
						 else{
							 type=1;
						 }
					 }
					//若没有，就是系统自动生成
					 else{
						 type=0;
					 }
					 publicMessageLayer("删除销售计划单", function(){
					 $.ajax({
						url: '<%=basePath%>sales/salesPlanOrder/deleteSalesPlanOrder',
						type: "POST",
						dataType: "json",
						data:{
							"id":row.id,
							"type":type,
							"identifier":row.identifier
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
				goodsAddEvent: function() {
					//新增商品
					//console.log("新增商品事件");

					let goodsId = $("#edit_goods").val(); //id
					let data = this.config.goodsSelectData;
					let goodsIdentifier = $("#edit_goods").find("option:selected").attr("attr-identifier"); //编码
					let goodsName =  $("#edit_goods").find("option:selected").attr("attr-commodityName"); //名称
					let goodsType =  $("#edit_goods").find("option:selected").attr("attr-specName"); //规格
					let goodsLogo =  $("#edit_goods").find("option:selected").attr("attr-brand"); //品牌
					let goodsUnit =  $("#edit_goods").find("option:selected").attr("attr-baseUnit"); //单位
					let goodsUnitPrices =  $("#edit_goods").find("option:selected").attr("attr-unitPrice"); //业务单价

					/*
					 * 请根据之前存储到this.config.goodsSelectData进行循环
					 * 找到对应编码商品为名称、品牌、规格、单位、单价、业务单价赋值
					 */

					if(goodsId == -1) {
						layfail("请先选择商品!");
					} else if(!this.checkRepeatFun(this.config.goodsTable.goodsArr, goodsId)) {
						$(".tipTr").remove();
						this.config.goodsTable.goodsArr.push(goodsId);
						$("#goodsTbody").append(`<tr>
							<td class="hidden edit_specId">` + goodsId + `</td>
							<td>` + goodsName + `</td>
							<td>` + goodsIdentifier + `</td>
							<td>` + goodsType + `</td>
							<td>` + goodsLogo + `</td>
							<td>` + goodsUnit + `</td>
							<td><input type="text" id="" value="` + goodsUnitPrices + `" class="form-control edit_goodsUnitPrice" disabled="disabled" /></td>
							<td><input type="text" id="" value="" class="form-control edit_goodsNumber" attr-name="业务数量" /></td>
							<td><input type="text" id="" value="" class="form-control edit_goodsMoney"  placeholder="请输入业务数量" disabled="disabled"/></td>
							<td><input type="text" id="" value="无" class="form-control edit_remark" onkeyup="cky(this)" attr-name="备注"/></td>
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
					this.config.goodsSelectData = [];
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
						if($(val).hasClass("searchable-select-input")&&that.config.customerId==-1&&res){
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
				checkFormisFilledLayerFun:function() {
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
				countTotalPriceFun: function(goodsNum,goodsUnitPrice) {
					//计算 金额=业务数量*业务单价
					if(!goodsNum || !goodsUnitPrice) return "";
					return toDecimal2((goodsNum - 0) * (goodsUnitPrice - 0));
				},
				countTotalFun: function() {
					//计算合计
					$("#total_commodity_num").val(parseInt(this.countOneTotalFun(".edit_goodsNumber"))); //业务数量
					$("#total_commodity_price").val(this.countOneTotalFun(".edit_goodsMoney")); //金额

				},
				clearTotalFun: function() {
					$("#total_commodity_num").val(""); //业务数量
					$("#total_commodity_price").val(""); //金额

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

			//计划对象下拉框的onchange事件
			window.getCommodityMsg = value => {
				order.config.customerId=value;
			}
			//商品下拉框的onchang事件
			window.selectCommodityMsg = (thisSelect, value) => {

			}

		})(document);
	</script>
</html>