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
		<title>销售订单审核</title>
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
			#editDiv .jl-panel{
				position: relative;
			}
			#query_time{
			width:190px
			}
		</style>
	</head>

	<body class="content" id="salesOrder_content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">订单审核</h4>
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
						<span class="l_f"> 
							是否为样品单： <select id="query_isSpecimen">
								<option value="0">请选择</option>
								<option value="1">否</option>
								<option value="2">是</option>
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
							<button type="button" class="btncss jl-btn-defult" onclick="salesOrderTimes()"><i class="fa fa-times"></i> 驳回</button>
						</span>
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="salesOrderCheck()"><i class="fa fa-check"></i> 通过</button>
						</span>
						
						<span class="jl_f_l">
							<input type="checkbox" name="checkAll" id="checkAll" style="margin:0 5px 0 0;" onclick="checkboxController(this)"/>
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
						<!--<div class="form-group">
							<label for="" class="col-xs-4 control-label">签收数量:</label>
							<div class="col-xs-8">
							</div>
						</div>-->
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">金额:</label>
							<div class="col-xs-8 look_all_deliver_goods_money" >
							</div>
						</div>
						<!--<div class="form-group">
							<label for="" class="col-xs-4 control-label">签收金额:</label>
							<div class="col-xs-8">
							</div>
						</div>-->
					</div>
					<div class="col-xs-6">
						<!--<div class="form-group">
							<label for="" class="col-xs-4 control-label">返货数量:</label>
							<div class="col-xs-8">
							</div>
						</div>-->
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">税额:</label>
							<div class="col-xs-8 look_all_taxes_money">
							</div>
						</div>
						<!--<div class="form-group">
							<label for="" class="col-xs-4 control-label">折损数量:</label>
							<div class="col-xs-8">
							</div>
						</div>-->
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
						<!-- <div class="form-group">
							<label for="" class="col-xs-4 control-label">审核人:</label>
							<div class="col-xs-8 look_reviewer_id">
							</div>
						</div> -->
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
							<label for="" class="col-xs-4 control-label">制单人:</label>
							<div class="col-xs-8 look_originator">
							</div>
						</div>
						
					</div>
				</div>

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
							"page":2,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": $("#query_supctoId").val(),
							"isSpecimen":$("#query_isSpecimen").val(),
							"createTime": $("#query_time").val(),
							"state": -1		
								
						});
					},
					"url": "<%=basePath%>sales/salesOrder/getSalesOrderMsg"
							},

							"aoColumns" : [
								
								{
									"mData" : "id",
									"bSortable" : false,
									"sWidth" : "5%",
									"sClass" : "center",
									"mRender" : function(data, type, row) {
										return '<td><input type="checkbox" name="id" value="'
												+ row.id
												+ '" onclick="checkboxClick(\'#checkAll\')"/></td>';
									}
								},{
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
											
											return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail('
												+data
												+')" value="详情" /></td>'
											
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
				//$(".look_reviewer_id").html(data.reviewerName);
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
				} 
				$(".look_all_deliver_goods_num").html(allDeliverGoodsNum);
				$(".look_all_deliver_goods_money").html(allDeliverGoodsMoney);
				$(".look_all_taxes_money").html(allTaxesMoney);
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
		/*驳回*/
		function salesOrderTimes() {
			//判断有无选择并记录id
			var str = "";
			var ids=[];
			
			$("input:checkbox[name='id']:checked").each(function() {
				
				if($(this).attr("id")!="checkAll"){
					str += $(this).val() + ",";
					ids.push($(this).val());
				}
				
			})
			if(str == "") {
				laywarn("请选择数据!");
				return;
			}
			publicMessageLayer("驳回所选订单的审核", function() {
				layer.open({
					type: 1,
					title: "提示",
					closeBtn: 1,
					area: ['400px', '150px'],
					content: "<div class='text-center' style='height: 50px;line-height: 67px;'>若驳回的单据为经过分仓的，驳回一条则表示全部驳回。</div>",
					btn: ['确认', '取消'],
					yes: function(index) {
						ajaxJquery("GET","<%=basePath%>sales/salesOrder/orderApproveReject",{"ids":ids,"flag":1},function(data){
							if(data.success) {
								laysuccess(data.msg);
								oTable1.fnDraw(false);
								$("#checkAll").removeAttr("checked");
							} else {
								layfail(data.msg);
							}
						})
						layer.close(index);
					}
				
				
				});
				
			})
		}
		/*通过*/
		function salesOrderCheck() {
			//判断有无选择并记录id
			var str = "";
			var ids=[];
			
			$("input:checkbox[name='id']:checked").each(function() {
				
				if($(this).attr("id")!="checkAll"){
					str += $(this).val() + ",";
					ids.push($(this).val());
				}
				
			})
			if(str == "") {
				laywarn("请选择数据!");
				return;
			}
			publicMessageLayer("通过所选订单的审核", function() {

				ajaxJquery("POST","<%=basePath%>sales/salesOrder/orderApprovePass",{"ids":ids,"flag":1},function(data){
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").removeAttr("checked");
					} else {
						layfail(data.msg);
					}
				})
			})
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
					<label for="" class="col-xs-4 control-label">备注:</label>
					<div class="col-xs-8 look_remark">
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

				<!--<div class="form-group">
					<label for="" class="col-xs-4 control-label">折损金额:</label>
					<div class="col-xs-8">
					</div>
				</div>-->

			</div>
		</div>`;
		
		$("#allGoodsDiv_look").append(goodsDiv);
		}
	</script>

</html>
	