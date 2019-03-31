<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = path + "/";
%>
<!DOCTYPE html>
<html lang="en">
	<%--844  744--%>

	<head>
		<meta charset="utf-8" />
		<title>其他收货单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>

		<link href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>

		<style type="text/css">
			#detailDiv,
			#editDiv {
				margin: 50px auto;
			}
			
			#query_time {
				width: 190px
			}
		</style>

	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">其他收货单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 单号： <input type="text" value=""
                                                          id="query_identifier" maxlength="100" />
							</span> <span class="l_f"> 货品名称： <input type="text" value="" maxlength="100"
                                                                    id="query_goodsName" />
							</span><span class="l_f"> 制单人名称： <input type="text" value="" maxlength="100"
                                                                    id="query_originator" />
							</span>

							<span class="l_f"> 
							状态：<select id="query_state" name="">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">未送审</option>
								<option value="2" >审核中</option>
								<option value="3">审核通过</option>
								<option value="4" >审核驳回</option>
								<option value="5" >待收货</option>
								<option value="6" >已开单</option>
							 	<option value="isDelete">已删除</option>
								<option value="7" >其他</option>
							</select>
						</span>
							<span class="l_f" style="margin-left:19px"> 
							起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
						</span>

							<span class="r_f"> <input type="button"
                                                              class="btncss btn_search" id="btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<span class="r_f">
							<button type="button" class="btncss jl-btn-defult otherReceiptsAddBtn" style="margin-right: 0;">
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
										<th>制单人</th>
										<th width="20%">操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><span class="look-span otherReceiptsDetailBtn" attr-tid="0">1321</span></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>
											<input type="button" class="btncss edit otherReceiptsEditBtn" attr-data="{id:4,data:5}" value="编辑" />
											<input type="button" class="btncss edit otherReceiptsDeleteBtn" attr-tid="0" value="删除" />
											<input type="button" class="btncss edit otherReceiptsDeliverBtn" attr-tid="0" value="送审" />
										</td>
									</tr>
									<tr>
										<td><span class="look-span otherReceiptsDetailBtn" attr-tid="0">1321</span></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>
											<input type="button" class="btncss edit otherReceiptsCancleBtn" attr-tid="0" value="撤销" />
											<input type="button" class="btncss edit otherReceiptsExportMsgBtn" attr-tid="0" value="导出" />
										</td>
									</tr>
									<tr>
										<td><span class="look-span otherReceiptsDetailBtn" attr-tid="0">1321</span></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>
											<input type="button" class="btncss edit otherReceiptsStopBtn" attr-tid="0" value="终止" />
											<input type="button" class="btncss edit otherReceiptsExportMsgBtn" attr-tid="0" value="导出" />
										</td>
									</tr>
									<tr>
										<td><span class="look-span otherReceiptsDetailBtn" attr-tid="0">1321</span></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>
											<input type="button" class="btncss edit" disabled value="已完成" />
											<input type="button" class="btncss edit otherReceiptsExportMsgBtn" attr-tid="0" value="导出" />
										</td>
									</tr>
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
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_supcto_id" disabled="disabled" value="其他" />
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
								<select id="edit_goods" class="form-control"></select>
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
								<th nowrap="nowrap">价税合计</th>
								<th nowrap="nowrap">批号</th>
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
				<div class="text-danger">注：该页面所有字段（除去摘要）均为必填</div>
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
					title: "其他收货单",
					dataTable: {}, //该字段用于存储datadtable
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
							<th nowrap="nowrap">价税合计</th>
							<th nowrap="nowrap">批号</th>
							<th nowrap="nowrap">备注</th>
							<th nowrap="nowrap">操作</th>
						</tr>`,
						tipTr: '<tr class="tipTr"><td colspan="17">请先选择商品</td></tr>',
						goodsArr: [] //用于存储添加到table中的商品的id
					},
					editForm: `<input type="text" class="form-control editInfo hidden" id="edit_purchase_id" value=""/>
                        <div class="col-xs-6 editInfo">
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
					goodsSelectMsg: {}

				},
				init: function() { //初始化方法
					this.initDataTable();
					this.initEvent();
				},
				initEvent: function() {
					let that = this;
					//事件绑定
					//新增其他收货单
					$(".otherReceiptsAddBtn").on("click", () => {
						this.otherReceiptsAddEvent();
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

					/*事件委托 begin*/
					//其他收货单 详情
					$("#datatable").delegate(".otherReceiptsDetailBtn", "click", function() {
						that.otherReceiptsDetailEvent($(this).attr("attr-tid"));
					})
					//其他收货单 编辑
					$("#datatable").delegate(".otherReceiptsEditBtn", "click", function() {
						console.log($(this).attr("attr-data"))
						that.otherReceiptsEditEvent($(this).attr("attr-data"));
					})
					//其他收货单 删除
					$("#datatable").delegate(".otherReceiptsDeleteBtn", "click", function() {
						that.otherReceiptsDeleteEvent($(this).attr("attr-tid"));
					})
					//其他收货单 送审
					$("#datatable").delegate(".otherReceiptsDeliverBtn", "click", function() {
						that.otherReceiptsDeliverEvent($(this).attr("attr-tid"));
					})
					//其他收货单 撤销
					$("#datatable").delegate(".otherReceiptsCancleBtn", "click", function() {
						that.otherReceiptsCancleEvent($(this).attr("attr-tid"));
					})
					//其他收货单 终止
					$("#datatable").delegate(".otherReceiptsStopBtn", "click", function() {
						layerTwoConfrim($("#alertDiv"), "提示框", "确定终止该订单?", () => {
							that.otherReceiptsStopEvent($(this).attr("attr-tid"));
						})
					})
					//其他收货单 导出
					$("#datatable").delegate(".otherReceiptsExportMsgBtn", "click", function() {
						that.otherReceiptsExportMsgEvent($(this).attr("attr-tid"));
					})

					//删除商品
					$("#goodsTbody").delegate(".goodsDelBtn", "click", function() {
						that.goodsDelEvent(this, $(this).attr("attr-tid"));
					})
					//税率 监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_taxRate", "keyup blur", function() {
						pressSmallNumZero(this);

					})
					//原始单价  监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_originalUnitPrice", "keyup blur", function() {
						pressMoney(this);
						that.setGoodsInfor(this);
					})
					//业务数量  监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_orderNum", "keyup blur", function() {
						pressInteger(this);
						$("#edit_total_orderNum").val(parseInt(that.countOneTotalFun(".edit_procureCommodity_orderNum"))); //业务数量

					})
					//折扣  监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_discount", "keyup blur", function() {
						pressIntegersOneHundred(this);
						that.setGoodsInfor(this);
					})
					//税额  监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_amountOfTax", "keyup blur", function() {
						pressMoney(this);
						$("#edit_total_amountOfTax").val(that.countOneTotalFun(".edit_procureCommodity_amountOfTax")); //税额

					})
					//价税合计  监听事件
					$("#goodsTbody").delegate(".edit_procureCommodity_totalTaxPrice", "keyup blur", function() {
						pressMoney(this);
						$("#edit_total_totalTaxPrice").val(that.countOneTotalFun(".edit_procureCommodity_totalTaxPrice")); //价税合计
					})

					/*事件委托 end*/

					/*初始化起止时间*/
					laydate.render({
						elem: "#query_time",
						range: '~'
					});

				},
				initGoodsSelect: function() {
					//初始化商品
					$("#edit_goods").parent().html('<select id="edit_goods" class="form-control"></select>');
					/*
					 * 请在此处为商品下拉框添加option
					 */
					$.ajax({
						url: '<%=basePath%>basic/goods/commodity/getAllCommodityByStateAndIsDeleteBySupctoId',
						type: "POST",
						dataType: "json",
						data: {
							"supctoId": 0
						},
						async: false,
						cache: false,
						success: (data) => {
							this.config.goodsSelectMsg = data;
							if(data.length == 0) {
								$("#edit_goods").append("<option value='-1' selected>--暂无数据，请到商品页面进行添加--</option>");
							} else {
								$("#edit_goods").append("<option value='-1' selected>--请选择商品--</option>");
								for(var i = 0; i < data.length; i++) {

									var option = $("<option value='" + data[i].id + "'>" + data[i].commodity.name + " " + data[i].specificationName + "</option>");
									$("#edit_goods").append(option);
								}
							}

						}
					});

					$("#edit_goods").searchableSelect();
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
										"page": 20,
										"identifier": $("#query_identifier").val(),
										"commodityName": $("#query_goodsName").val(),
										"originator": $("#query_originator").val(),
										"planOrOrder": 6,
										"queryTime": $("#query_time").val(),
										"state": $("#query_state").val()

									});
								},
								"url": "<%=basePath%>purchase/procuretable/getProcureTableMsg"
							},

							"aoColumns": [{
									"mData": "identifier",
									"bSortable": false,
									"sWidth": "15%",
									"sClass": "center",
									"mRender": function(data, type, row) {
										return '<td><span class="look-span otherReceiptsDetailBtn" attr-tid="' + row.id + '" >' +
											data +
											'</span></td>';
									}
								},
								{
									"mData": "supctoId",
									"bSortable": false,
									"sWidth": "10%",
									"sClass": "center",
									"mRender": function(data, type, row) {
										return "其他";
									}

								},
								{
									"mData": "commoditysName",
									"bSortable": false,
									"sWidth": "10%",
									"sClass": "center"
								},
								{
									"mData": "businessUnitPrices",
									"bSortable": false,
									"sWidth": "8%",
									"sClass": "center"

								},
								{
									"mData": "orderNums",
									"bSortable": false,
									"sWidth": "8%",
									"sClass": "center"

								},
								{
									"mData": "totalTaxPrices",
									"bSortable": false,
									"sWidth": "10%",
									"sClass": "center",
									"mRender": function(data) {
										if(data != "null") {
											return data;
										} else {
											return 0;
										}
									}

								},
								{
									"mData": "generateDate",
									"bSortable": false,
									"sWidth": "10%",
									"sClass": "center",
									"mRender": function(data) {
										return getSmpFormatDateByLong(data, true);
									}
								},
								{
									"mData": "state",
									"bSortable": false,
									"sWidth": "8%",
									"sClass": "center",
									"mRender": function(data, type, row) {
										   if(row.isDelete==1){
	                                        	 return "已删除";
	                                         }
										switch(data) {
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
											case 16:
												return "领导审核中";
												break;
											case 17:
												return "领导审核驳回";
												break;
											case 18:
												return "财务审核中";
												break;
											case 19:
												return "财务审核驳回";
												break;
											case 20:
												return "待收货";
												break;
											default:
												return "";
												break;
										}
									}

								},
								{
									"mData": "originator",
									"bSortable": false,
									"sWidth": "10%",
									"sClass": "center",
									"mRender": function(data, type, row) {
										if(row.originatorName != null) {
											return data + "(" + row.originatorName + ")";
										} else {
											return data;
										}

									}
								},
								{
									"mData": "id",
									"bSortable": false,
									"sWidth": "20%",
									"sClass": "center",
									"mRender": function(data, type, row) {
										if(row.isDelete==0){
											if(row.state == 1 || row.state == 4 || row.state == 17 || row.state == 19) {
												return '<td><input type="button" class="btncss otherReceiptsEditBtn" value="编辑" attr-data=\'' + JSON.stringify(row) + '\'/>' +
													'<input type="button" class="btncss otherReceiptsDeliverBtn" attr-tid="' + data + '"  value="送审" />' +
													'<input type="button" class="btncss otherReceiptsDeleteBtn" attr-tid=\'' + JSON.stringify(row) + '\' value="删除" /></td>'
											} else if(row.state == 2 || row.state == 3 || row.state == 5 || row.state == 16 || row.state == 18) {
												return '<td><input type="button" class="btncss otherReceiptsCancleBtn" attr-tid="' + data + '" value="撤销" />' +
													'<input type="button" class="btncss otherReceiptsExportMsgBtn" attr-tid="' + data + '" value="导出" /></td>'
											} else if(row.state == 6 || row.state == 11 || row.state == 10 || row.state == 20) {
												return '<td><input type="button" class="btncss otherReceiptsStopBtn" attr-tid="' + data + '" value="终止" /><input type="button" class="btncss otherReceiptsExportMsgBtn" attr-tid="' + data + '" value="导出" /></td>'
	
											} else if(row.state == 7) {
												return '<td><input type="button" class="btncss edit" disabled value="已撤销" /></td>'
											} else if(row.state == 8) {
												return '<td><input type="button" class="btncss edit" disabled value="终止审核中" /></td>'
											} else if(row.state == 9) {
												return '<td><input type="button" class="btncss edit" disabled value="已终止" /></td>'
											} else if(row.state == 12 || row.state == 13 || row.state == 15) {
												return '<td><input type="button" class="btncss edit" disabled value="已完成" /><input type="button" class="btncss edit" attr-tid="' + data + '" value="导出" /></td>'
											}
										}else{
											return '<td><input type="button" class="btncss edit otherReceiptsDetailBtn" attr-tid=\''+row.id+'\' value="详情" /></td>';
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

				},
				refreshDataTable: function() {
					this.config.dataTable.fnDraw(false);
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

					/*$(thisInput).parents("tr").find(".edit_procureCommodity_amountOfTax")
					    .val(this.countAmountOfTaxFun(gInfo.orderNum, gInfo.businessUnitPrice, gInfo.taxRate)); //税额

					gInfo.containsTaxPrice = this.countContainsTaxPriceFun(gInfo.businessUnitPrice, gInfo.taxRate);
					$(thisInput).parents("tr").find(".edit_procureCommodity_containsTaxPrice")
					    .val(gInfo.containsTaxPrice); //含税价

					$(thisInput).parents("tr").find(".edit_procureCommodity_paymentForGoods")
					    .val(this.countPaymentForGoodsFun(gInfo.containsTaxPrice, gInfo.orderNum)); //货款

					$(thisInput).parents("tr").find(".edit_procureCommodity_totalPrice")
					    .val(this.countTotalPriceFun(gInfo.containsTaxPrice, gInfo.orderNum)); //金额

					//合计
					this.countTotalFun();*/

				},
				setSupcto: function() {
					$("#edit_supcto_id").val("其他");
				},
				setOtherReceipts: function(data) {
					/*
					 * 请在此处解析data为from赋值
					 * 该方法用于编辑框打开前，为框内的内容赋值
					 */
					//alert(data.procureCommoditys[0].commoditySpecification.commodity.name)
					$.ajax({
						url: '<%=basePath%>/purchase/procuretable/selectById',
						type: "POST",
						dataType: "json",
						data: {
							"id": data.id
						},
						success: (data) => {

							$("#edit_purchase_id").val(data.id);
							if(data.generateDate == null || data.generateDate == "") {
								$("#edit_generateDate").val("");
							} else {
								$("#edit_generateDate").val(getSmpFormatDateByLong(data.generateDate, true));
							}
							$("#edit_identifier").val(data.identifier);
							if(data.summary != null && data.summary != "") {
								$("#edit_summary").val(data.summary);
							} else {
								$("#edit_summary").val("");
							}
							for(var i = 0; i < data.procureCommoditys.length; i++) {
								let goodsId = data.procureCommoditys[i].commoditySpecification.id;

								$(".tipTr").remove();
								this.config.goodsTable.goodsArr.push(goodsId);

								$("#goodsTbody").append(`<tr>
                            <td class="edit_purchase_commodity_id hidden">` + data.procureCommoditys[i].id + `</td>
                            <td class="goodsId hidden">` + goodsId + `</td>
							<td id="goodsName">` + data.procureCommoditys[i].commoditySpecification.commodity.name + `</td>
							<td id="goodsSpecification">` + data.procureCommoditys[i].commoditySpecification.specificationIdentifier + `</td>
							<td id="goodsType">` + data.procureCommoditys[i].commoditySpecification.specificationName + `</td>
							<td id="goodsLogo">` + data.procureCommoditys[i].commoditySpecification.commodity.brand + `</td>
							<td id="goodsUnit">` + data.procureCommoditys[i].commoditySpecification.baseUnitName + `</td>
							<td><input type="text" id=""  class="form-control edit_procureCommodity_taxRate"  value="` + data.procureCommoditys[i].taxRate + `" attr-name="税率"/></td>
							<td><input type="text" id=""  class="form-control edit_procureCommodity_originalUnitPrice"  value="` + data.procureCommoditys[i].originalUnitPrice + `" attr-name="原始单价"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_businessUnitPrice" placeholder="先填写原始单价" disabled="disabled" value="` + data.procureCommoditys[i].businessUnitPrice + `"/></td>
							<td><input type="text" id=""  class="form-control edit_procureCommodity_orderNum"  maxlength="9"  value="` + data.procureCommoditys[i].orderNum + `" attr-name="订货数量"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_amountOfTax" maxlength="9" value="` + data.procureCommoditys[i].amountOfTax + `" attr-name="税额"/></td>
							<td><input type="text" id=""  class="form-control edit_procureCommodity_discount"  maxlength="9"  value="` + data.procureCommoditys[i].discount + `" attr-name="折扣"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_totalTaxPrice" maxlength="9" value="` + data.procureCommoditys[i].totalTaxPrice + `" attr-name="价税合计"/></td>
							<td><input type="text" id=""  class="form-control edit_procureCommodity_lotNumber" onkeyup="cky(this)" value="` + data.procureCommoditys[i].lotNumber + `" attr-name="批号"/></td>
							<td><input type="text" id=""  class="form-control edit_procureCommodity_remarks" onkeyup="cky(this)" value="` + data.procureCommoditys[i].remarks + `" attr-name="备注"/></td>
							<td><input type="button" class="btncss edit goodsDelBtn" attr-tid="` + data.procureCommoditys[i].commoditySpecification.id + `" value="删除" /></td>
						</tr>`);

							}
							this.countTotalFun();
						}

					});

				},
				getOtherReceipts: function() {
					let formData = {};
					/*
					 * 请在此处获取form各个字段的值，形成对象
					 * 该方法用于编辑、新增的向后台提交数据，获取数据的方法
					 */
					//采购订单基础的信息
					formData = {
						"id": $("#edit_purchase_id").val(),
						"generateDateString": $("#edit_generateDate").val(),
						"identifier": $("#edit_identifier").val(),
						"summary": $("#edit_summary").val(),
						"planOrOrder": 6,
						"procureCommoditys": []
					};
					//获取采购商品的信息，添加到采购订单的商品信息里
					$("#goodsTbody tr").each(function(index, val) {

						var procureCommodityDataJSON = {
							"id": $(val).find(".edit_purchase_commodity_id").html(),
							"commodityId": $(val).find(".goodsId").html(),
							"procureTableId": $("#edit_purchase_id").val(),
							"taxRate": $(val).find(".edit_procureCommodity_taxRate").val(),
							"amountOfTax": $(val).find(".edit_procureCommodity_amountOfTax").val(),
							"orderNum": $(val).find(".edit_procureCommodity_orderNum").val(),
							"lotNumber": $(val).find(".edit_procureCommodity_lotNumber").val(),
							"originalUnitPrice": $(val).find(".edit_procureCommodity_originalUnitPrice").val(),
							"discount": $(val).find(".edit_procureCommodity_discount").val(),
							"businessUnitPrice": $(val).find(".edit_procureCommodity_businessUnitPrice").val(),
							"remarks": $(val).find(".edit_procureCommodity_remarks").val(),
							"totalTaxPrice": $(val).find(".edit_procureCommodity_totalTaxPrice").val()
						};

						if(index != 0) formData.procureCommoditys[index - 1] = procureCommodityDataJSON;
					});

					console.log("formData", formData);
					return formData;
				},
				otherReceiptsAddEvent: function() {
					//新增其他收货单
					//console.log("新增其他收货单");
					$("#edit_summary").val("无");
					let that = this;
					this.setSupcto();
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
							if(!this.checkFormisFilledFun()) return;

							/*
							 * 添加其他收货单添加成功相关逻辑代码
							 */
							//console.log(this.getOtherReceipts())
							var formdata = this.getOtherReceipts(); //获取页面数据的值，用于提交到后台
							//console.log(formdata)
							$.ajax({
								url: '<%=basePath%>purchase/procuretable/addPurchaseOrder?planOrTable=' + 6,
								type: "POST",
								dataType: "json",
								data: {
									"procureTable": JSON.stringify(formdata)
								},
								async: false,
								cache: false,
								success: function(data) {
									if(data.success) {
										layer.close(index);
										laysuccess(data.msg);
									} else {
										layer.close(index);
										layfail(data.msg);
									}

								}
							});

							//layer.close(index);
							this.refreshDataTable(); //刷新datatable
							//laysuccess("新增成功");
						},
						end: (index, layero) => {
							layer.close(index);
							clearForm("editDiv", "");
							this.clearGoodsEvent();
							
						}
					});
				},
				otherReceiptsDetailEvent: function(tid) {
					//其他收货单详情
					//console.log("其他收货单详情"+tid);

					var that = this;
					$.ajax({
						type: "post",
						url: "<%=basePath%>/purchase/procuretable/detailOtherReceiptsOrder",
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
						title: that.config.title + "详情",
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#detailDiv"),
						btn: ['关闭']
					});
				},
				otherReceiptsEditEvent: function(data) {
					//其他收货单 编辑
					//console.log(data);

					data = JSON.parse(data);
					//console.log("id"+data.id);
					this.setSupcto();
					this.initGoodsSelect();
					$("#headEdit .row").prepend(this.config.editForm);
					this.setOtherReceipts(data); //根据data获取单据信息为表单赋值

					var that = this;
					layer.open({
						type: 1,
						title: "编辑" + that.config.title,
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#editDiv"),
						scrollbar: false,
						btn: ['提交', '取消'],
						yes: index => {
							if(!this.checkFormisFilledFun()) return;

							/*
							 * 请在此处添加其他收货单编辑的相关代码
							 */
							var formdata = this.getOtherReceipts(); //获取页面数据的值，用于提交到后台

							$.ajax({
								url: '<%=basePath%>purchase/procuretable/updateOrderByPrimaryKey',
								type: "POST",
								dataType: "json",
								data: {
									"procureTable": JSON.stringify(formdata)
								},
								async: false,
								cache: false,
								success: (data) => {
									if(data.success) {
										laysuccess(data.msg);
										layer.close(index);
										//刷新datatable
										this.refreshDataTable();
									} else {
										layfail(data.msg);
									}

								}
							});

						},
						end: (index, layero) => {
							layer.close(index);
							clearForm("editDiv", "");
							this.clearGoodsEvent();
							$(".editInfo").remove();
						}
					});
				},
				otherReceiptsDeleteEvent: function(tid) {
					//其他收货单 删除
					data = JSON.parse(tid);
					//console.log("其他收货单删除" + data.id);
					/*
					 * 请在此处添加其他收货单送审的相关代码
					 */
					publicMessageLayer("删除该订单", () => {
						$.ajax({
							url: '<%=basePath%>purchase/procuretable/delByPrimaryKey',
							type: "POST",
							dataType: "json",
							async: false,
							cache: false,
							data: {
								"id": data.id,
								"identifier": data.identifier
							},

							traditional: true,
							success: (data) => {
								if(data.success) {
									laysuccess(data.msg);
									//刷新datatable
									this.refreshDataTable();
								} else {
									layfail(data.msg);
									//刷新datatable
									this.refreshDataTable();
								}

							}
						});
					})

				},
				otherReceiptsDeliverEvent: function(tid) {
					//其他收货单 送审
					//console.log("其他收货单送审" + tid);
					/*
					 * 请在此处添加其他收货单送审的相关代码
					 */
					var ids = [tid];
					publicMessageLayer("将本订单送审", () => {
						$.ajax({
							url: '<%=basePath%>purchase/procuretable/updateStateByIds',
							type: "POST",
							dataType: "json",
							async: false,
							cache: false,
							data: {
								"ids": ids,
								"state": 16

							},

							traditional: true,
							success: (data) => {
								if(data.success) {
									laysuccess(data.msg);
									//刷新datatable
									this.refreshDataTable();
								} else {
									layfail(data.msg);
									//刷新datatable
									this.refreshDataTable();
								}

							}
						});
					})

				},
				otherReceiptsCancleEvent: function(tid) {
					//其他收货单 撤销
					var ids = [tid];
					//console.log("其他收货单撤销" + tid);
					/*
					 * 请在此处添加其他收货单撤销的相关代码
					 */
					publicMessageLayer("撤销该订单", () => {
						$.ajax({
							url: '<%=basePath%>purchase/procuretable/updateStateByIds',
							type: "POST",
							dataType: "json",
							async: false,
							cache: false,
							data: {
								"ids": ids,
								"state": 7

							},

							traditional: true,
							success: (data) => {
								if(data.success) {

									laysuccess(data.msg);
									//刷新datatable
									this.refreshDataTable();
								} else {
									layfail(data.msg);
									//刷新datatable
									this.refreshDataTable();
								}

							}
						});
					})

				},
				otherReceiptsStopEvent: function(tid) {
					//其他收货单 终止
					//console.log("其他收货单终止" + tid);
					/*
					 * 请在此处添加其他收货单终止的相关代码
					 */
					var ids = [tid];

					$.ajax({
						url: '<%=basePath%>purchase/procuretable/updateStateByIds',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data: {
							"ids": ids,
							"state": 21

						},

						traditional: true,
						success: function(data) {
							if(data.success) {
								laysuccess(data.msg);

							} else {
								layfail(data.msg);
							}

						}
					});

					//刷新datatable
					this.refreshDataTable();
				},
				otherReceiptsExportMsgEvent: function(tid) {
					//其他收货单 导出
					//console.log("其他收货单导出" + tid);
					/*
					 * 请在此处添加其他收货单终止的相关代码
					 */
					var URL = "<%=basePath%>purchase/procuretable/exportExportOtherReceiptsDetail?id=" + tid + ""
					//console.log(URL)
					location.href = URL;
					return false;
				},
				goodsAddEvent: function() {
					//新增商品
					//console.log("新增商品事件");

					let data = this.config.goodsSelectMsg;

					console.log(data)
					let goodsId = $("#edit_goods").val(); //规格id
					let goodsName = "名称"; //名称
					let goodsSpecification = "规格编码" //编码
					let goodsType = "规格"; //规格
					let goodsLogo = "品牌"; //品牌
					let goodsUnit = "单位"; //单位
					let goodsTax = 0; //税率
					let originalUnitPrice = 0; //原始单价
					for(var i = 0; i < data.length; i++) {

						if(data[i].id == goodsId) {

							if(data[i].specOriginalUnitPrice != null && data[i].specOriginalUnitPrice > 0) {
								originalUnitPrice = data[i].specOriginalUnitPrice;
							} else {
								originalUnitPrice = `\'' +  + '\'`;
							}

							goodsTax = data[i].commodity.taxes;
							goodsSpecification = data[i].commodity.identifier;
							goodsName = data[i].commodity.name;
							goodsType = data[i].specificationName;
							goodsLogo = data[i].commodity.brand;
							goodsUnit = data[i].baseUnitName;
						}

					}
					/*
					 * 请在此处获取该商品对应的名称、规格、品牌、单位
					 */

					if(goodsId == -1) {
						layfail("请先选择商品!");
					} else if(!this.checkRepeatFun(this.config.goodsTable.goodsArr, goodsId)) {
						$(".tipTr").remove();
						this.config.goodsTable.goodsArr.push(goodsId);

						$("#goodsTbody").append(`<tr>
                            <td class="edit_purchase_commodity_id hidden"></td>
                            <td class="goodsId hidden">` + goodsId + `</td>
							<td id="goodsName">` + goodsName + `</td>
							<td id="goodsSpecification">` + goodsSpecification + `</td>
							<td id="goodsType">` + goodsType + `</td>
							<td id="goodsLogo">` + goodsLogo + `</td>
							<td id="goodsUnit">` + goodsUnit + `</td>
							<td><input type="text" id="" value=` + goodsTax + ` class="form-control edit_procureCommodity_taxRate" attr-name="税率" /></td>
							<td><input type="text" id="" value=` + originalUnitPrice + ` class="form-control edit_procureCommodity_originalUnitPrice"  attr-name="原始单价"/></td>
							<td><input type="text"  value=` + originalUnitPrice + ` class="form-control edit_procureCommodity_businessUnitPrice" placeholder="先填写原始单价" disabled="disabled"  /></td>
							<td><input type="text" id="" value="" class="form-control edit_procureCommodity_orderNum"  maxlength="9" attr-name="订货数量"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_amountOfTax" maxlength="9" attr-name="税额"/></td>
							<td><input type="text" id="" value="100" class="form-control edit_procureCommodity_discount"  maxlength="9" attr-name="折扣"/></td>
							<td><input type="text" class="form-control edit_procureCommodity_totalTaxPrice" maxlength="9" attr-name="价税合计"/></td>
							<td><input type="text" id="" value="0000" class="form-control edit_procureCommodity_lotNumber" onkeyup="cky(this)" attr-name="批号"/></td>
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
				checkInputEmptyLayer: function(thisInput) {
					//判断footer或者header中Input框为空时弹出layer
					var $input = $(thisInput);
					var name = $input.parents(".form-group").find(".control-label").text();
					layfail(name + "不能为空");
				},
				checkTableInputEmptyLayer: function(thisInput) {
					//判断table中Input框为空时弹出layer
					var $input = $(thisInput);
					var name = $input.attr("attr-name");
					layfail(name + "不能为空");
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
				checkFormisFilledFun: function() {
					//判断表单是否填写完整 填写完整返回true,相反返回false
					var res = true;
					var that = this;
					if(!res) return res;
					if($(".tipTr").length > 0) {
						res = false;
						layfail("商品不能为空");
					}
					if(!res) return res;
					$("#goodsTbody input").each(function(index, val) {
						if($(val).val() == "" && (!$(val).prop("disabled")) && res) {
							that.checkTableInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#goodsTbody select").each(function(index, val) {
						if($(val).val() == "-1" && res) {
							that.checkTableInputEmptyLayer(val);
							res = false;
						}
					});
					/* if(!res) return res;
					$("#footerEdit input").each(function(index, val) {
						var text=$(val).parents(".form-group").find(".control-label").text();

						if(text!="摘要"&&$(val).val() == "" && res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#footerEdit select").each(function(index, val) {
						if($(val).val() == "-1" && res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					}); */
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
				countTotalFun: function() {
					//计算合计
					$("#edit_total_orderNum").val(parseInt(this.countOneTotalFun(".edit_procureCommodity_orderNum"))); //业务数量
					$("#edit_total_amountOfTax").val(this.countOneTotalFun(".edit_procureCommodity_amountOfTax")); //税额
					$("#edit_total_totalTaxPrice").val(this.countOneTotalFun(".edit_procureCommodity_totalTaxPrice")); //价税合计
				},
				clearTotalFun: function() {
					$("#edit_total_orderNum").val(""); //业务数量
					$("#edit_total_amountOfTax").val(""); //税额
					$("#edit_total_paymentForGoods").val(""); //货款

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

			//商品下拉框的onchang事件
			window.selectCommodityMsg = (thisSelect, value) => {

			}

		})(document);
	</script>

</html>