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
<title>销售退货单审核</title>
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

<body class="content" id="salesOrder_content">
	<div class="page-content clearfix">
		<div id="Member_Ratings">
			<div class="d_Confirm_Order_style" style="margin-top: 10px;">
				<h4 class="text-title">销售退货单审核</h4>
				<div class="search-div clearfix">
					<div class="clearfix">
						<span class="l_f"> 单号： <input type="text" value=""
							id="query_identifier" />
						</span> <span class="l_f"> 客户名称： <input type="text" value=""
							id="query_supctoId" />
						</span> <span class="l_f"> 货品名称： <input type="text" value=""
							id="query_goodsName" />
						
						</span>
						 <span class="l_f" style="margin-left:19px"> 
								起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
						</span>
						 <span class="r_f"> <input type="button" id="btn_search"
							class="btncss btn_search" value="搜索" />
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
									<th>日期</th>
									<th>有效期至</th>
									<th>制单人</th>
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
		<div id="detailDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>退货信息</span>

				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单据编号：</label>
								<div class="col-xs-8" id="look_identifier">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单据日期：</label>
								<div class="col-xs-8" id="look_createTime">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">退货销售订单编号：</label>
								<div class="col-xs-8" id="look_parentId">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户编码：</label>
								<div class="col-xs-8" id="look_supctoIdentifier">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户名称：</label>
								<div class="col-xs-8" id="look_supctoName">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">有效期至：</label>
								<div class="col-xs-8" id="look_endValidityTime">

								</div>
							</div>
						</div>
						
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">发货地点：</label>
								<div class="col-xs-8" id="look_deliverGoodsPlace">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">运输方式：</label>
								<div class="col-xs-8" id="look_shippingModeId">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">收货人：</label>
								<div class="col-xs-8" id="look_consignee">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">联系电话：</label>
								<div class="col-xs-8" id="look_phone">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">传真：</label>
								<div class="col-xs-8" id="look_fax">

								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row jl-title">
					<span>退货商品</span>
				</div>
				<div class="row">
					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="look_goodsTbody">
							<tr>
								<th>货品编码</th>
								<th>货品名称</th>
								<th>规格</th>
								<th>单位</th>
								<th>退货数量</th>
								<th>单价</th>
								<th>金额</th>
							</tr>
							

						</tbody>
					</table>
				</div>

				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">本次退货总金额：</label>
								<div class="col-xs-8"  id="look_allMoney">

								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门：</label>
								<div class="col-xs-8"  id="look_personDepartmentName">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员：</label>
								<div class="col-xs-8"  id="look_personId">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">制单人：</label>
								<div class="col-xs-8"  id="look_originator">

								</div>
							</div>
						</div>
						
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要：</label>
								<div class="col-xs-8"  id="look_summary">

								</div>
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
							"page":16,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": $("#query_supctoId").val(),
							"isSpecimen":0	,
							"createTime": $("#query_time").val(),
							"state": -1		
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
											return '<td><span class="look-span" onclick="salesReturnDetail('
											+ row.id
											+ ')">' + data + '-'+row.breakCode+'</span></td>';
										}
										else{
											return '<td><span class="look-span" onclick="salesReturnDetail('
											+ row.id
											+ ')">'
											+ data
											+ '</span></td>';
										}
									}
								},{
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
									},{
										"mData" : "createTime",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender": function(data) {
											return getSmpFormatDateByLong(data, true);
										}

									},{
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
										"mData" : "state",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											switch (data) {
											case 27:
												return "退货单未送审";
												break;
											case 28:
												return "退货单待审核";
												break;
											case 29:
												return "退货单审核驳回";
												break;
											case 30:
												return "退货单审核通过";
												break;
											case 31:
												return "已退货入库";
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
											
											return '<td><input type="button" class="btncss edit" onclick="salesReturnPass('
												+ data
												+')" value="通过" />'
												+ '<input type="button" class="btncss edit" onclick="salesReturnReject('
												+ data
												+ ')" value="驳回" /></td>';
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

	/*通过*/
	function salesReturnPass(id) {
		publicMessageLayer("通过该销售退货的审批", function() {
			let ids = [id];
			$.ajax({
				url :'<%=basePath%>sales/salesOrder/updateStateByIds',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"ids" : ids,
					"state" : 30,
					"isCheck" : 1,
					"reviewerType":1,
					"msg" : "操作成功，已通过！",
				},
				
				traditional:true,
				success: function(data) {
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
					} else {
						layfail(data.msg);
					}

				}
			}); 
		})
	}
	/*驳回*/
	function salesReturnReject(id) {
		publicMessageLayer("驳回该销售退货的审批", function() {
			let ids = [id];
			$.ajax({
				url :'<%=basePath%>sales/salesOrder/updateStateByIds',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"ids" : ids,
					"state" : 29,
					"isCheck" : 1,
					"reviewerType":1,
					"msg" : "操作成功，已驳回！",
				},
				
				traditional:true,
				success: function(data) {
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
					} else {
						layfail(data.msg);
					}

				}
			}); 
		})
	}
	/*详情*/
	function salesReturnDetail(id) {
		<%-- let emptyTbody = `
			<tr>
				<th>货品编码</th>
				<th>货品名称</th>
				<th>规格</th>
				<th>单位</th>
				<th>退货数量</th>
				<th>单价</th>
				<th>金额</th>
			</tr>`;
		$("#look_goodsTbody").html(emptyTbody);
		 ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectOrderDetailById",{"id":id},function(data){
				$("#look_identifier").html(data.identifier);
				$("#look_createTime").html(getSmpFormatDateByLong(data.createTime, true));
				$("#look_parentId").html(data.parentIdentifier);
				$("#look_supctoIdentifier").html(data.supcto.identifier);
				$("#look_supctoName").html(data.supcto.name);
				$("#look_endValidityTime").html(getSmpFormatDateByLong(data.endValidityTime, false));
				$("#look_deliverGoodsPlace").html(data.deliverGoodsPlace);
				$("#look_shippingModeId").html(data.shippingMode.name);
				$("#look_consignee").html(data.consignee);
				$("#look_phone").html(data.phone);
				$("#look_fax").html(data.fax);
				$("#look_personDepartmentName").html(data.personDepartmentName);
				$("#look_personId").html(data.personName);
				if(data.person!=null){
					$("#look_originator").html(data.originator+"("+data.person.name+")");
				}
				else{
					$("#look_originator").html(data.originator);
				}
				
				$("#look_summary").html(data.summary);
				let allMoney = 0;
				for (var i = 0; i < data.salesOrderCommodities.length; i++) {
					let commoditie = data.salesOrderCommodities[i];
				
					let goodsName=commoditie.commoditySpecification.commodity.name;
					let identifier=commoditie.commoditySpecification.specificationIdentifier;
					let type=commoditie.commoditySpecification.specificationName;
					let unit=commoditie.commoditySpecification.baseUnitName;
					let number=commoditie.returnGoodsNum;
					let unitPrice=commoditie.unitPrice;
					let money=number * unitPrice;
					allMoney+=money;
					$("#look_goodsTbody").append('<tr><td class="">' + identifier + '</td><td>' + goodsName + '</td><td>' + type +
							'</td><td>' + unit + '</td>' +
							'<td>'+number+'</td>' +
							'<td>'+unitPrice+'</td>' +
							'<td>'+money+'</td></tr>');
					
				 }  
				$("#look_allMoney").html(allMoney);
				
			}); --%>
			$("#detailDiv").html("");
			$.ajax({
				type: "post",
				url: "<%=basePath%>sales/salesOrder/salesOrderDetail",
				dataType : "json",
				data: {
					"id" : id,
					"type":3
				},
				success: function(res) {
					let bill = new DetailBill(res);
					let $content = bill.toPrint();
					$("#detailDiv").html($content);
				}
			});
		layer.open({
			type: 1,
			title: "销售退货单详情",
			closeBtn: 1,
			area: ['100%', '100%'],
			content: $("#detailDiv"),
			btn: ['关闭'],
		});
	}
	</script>

</html>