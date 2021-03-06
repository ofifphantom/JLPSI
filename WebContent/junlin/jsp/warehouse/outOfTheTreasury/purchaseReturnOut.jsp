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
		<title>采购退货出库</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		
		
		<script src="${pageContext.request.contextPath}/junlin/script/Bill.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/watermark.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery.PrintArea.js" type="text/javascript"></script>
		
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
					<h4 class="text-title">采购退货出库</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 编号： <input type="text" value="" id="query_identifier"
								onblur="cky()" />
							</span> <span class="l_f"> 日期： <input type="text" value=""
								readonly="readonly" id="dateTime" placeholder="请选择日期" />
							</span> <span class="l_f"> 制单人姓名： <input type="text" value=""
								onblur="cky()" id="query_originator"/>
							</span> 
							
								<span class="l_f" style="margin-left:19px"> 
							起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
						</span>
						<span class="l_f"> 
							状态：<select id="query_state" name="">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="6" >已通过</option>
								<option value="8">已出库</option>	
							 
							</select>
						</span>
							<span class="r_f"> <input type="button"
								class="btncss btn_search" id="btn_search" value="搜索" />
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
									<th>订单单号</th>
									<th>供应商名称</th>
									<th>制单人</th>
									<th>日期</th>
									<th>状态</th>
									<th>操作</th>
								</tr>

							</thead>
							<tbody>
								<!-- <tr>
									<td>
										<span class="look-span" onclick="purchaseReturnDetail()">PO.2017.09.00054</span>
									</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>
										<input type="button" class="btncss edit" onclick="purchaseReturnOut()" value="出库" />
										<input type="button" class="btncss edit" onclick="purchaseReturnPrint()" value="打印" />
									</td>
								</tr> -->
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
				<span>引用退货单据</span>

			</div>
			<div class="jl-panel">
				<div class="row">
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">单据编号：</label>
							<div class="col-xs-8" id="look_identifier"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">单据日期：</label>
							<div class="col-xs-8" id="look_generate_date"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">单据类型：</label>
							<div class="col-xs-8">采购退货</div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">采购订单编号：</label>
							<div class="col-xs-8" id="look_purchase_identifier"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">供应商名称：</label>
							<div class="col-xs-8" id="look_supcto_name"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">运输方式：</label>
							<div class="col-xs-8" id="look_transportationMode"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">送货地址：</label>
							<div class="col-xs-8" id="look_goodsArrivalPlace"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">送货人：</label>
							<div class="col-xs-8" id="look_deliveryman"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">联系电话：</label>
							<div class="col-xs-8" id="look_phone"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">传真：</label>
							<div class="col-xs-8" id="look_fax"></div>
						</div>
					</div>
				</div>
			</div>

			<div class="row jl-title">
				<span>退货单据</span>
			</div>
			<div class="row">
				<table
					class="table table-bordered table-striped table-hover col-xs-12"
					border="" cellspacing="0" cellpadding="0">
					<tbody id="look_goodsTbody">
						<tr>
							<th>货品编码</th>
							<th>货品名称</th>
							<th>仓库名称</th>
							<th>规格</th>
							<th>单位</th>
							<th>退货数量</th>
							<th>退货单价</th>
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
							<div class="col-xs-8" id="look_totalAmount"></div>
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
							<label for="" class="col-xs-4 control-label">制单人：</label>
							<div class="col-xs-8" id="look_originator"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">审核人：</label>
							<div class="col-xs-8" id="look_reviewer"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">摘要：</label>
							<div class="col-xs-8" id="look_summary"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">分支机构：</label>
							<div class="col-xs-8">总部</div>
						</div>
					</div>


				</div>
			</div>

		</form>


		</div>
		<div id="printDiv" style="display: none;">
			
		</div>

	</body>

	<script>
	
	$("#btn_search").click(function() {
		oTable1.fnDraw();
	});

	var oTable1;

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
							"page":18,
							"identifier": $("#query_identifier").val(),
							"generateDate": $("#dateTime").val(),
							"originator": $("#query_originator").val(),
							"planOrOrder":5,
							"queryTime":$("#query_time").val(),
							"state":$("#query_state").val()
								
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
											return '<td><span class="look-span" onclick="purchaseReturnDetail('
													+ row.id
													+ ')">'
													+ data
													+ '</span></td>';
										}
									},
									{
										"mData" : "procureTableIdentifier",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"

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
										"mData" : "originator",
										"bSortable" : false,
										"sWidth" : "8%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											if (row.originatorName != null) {
												return data+"("+row.originatorName+")"
											} else {
												return data;
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
											case 14:
												return "已出库";
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
											if(row.state==14){
													return '<td><input type="button" class="btncss edit" onclick=\'purchaseReturnPrint(' + JSON.stringify(row) + ')\' value="打印" /></td>'			
											}
											else{
												return '<td><input type="button" class="btncss edit" onclick="purchaseReturnOut('+data+')" value="出库" />'
												+'<input type="button" class="btncss edit" onclick=\'purchaseReturnPrint(' + JSON.stringify(row) + ')\' value="打印" /></td>'
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
	});
	
		$(function() {

			latdate("#dateTime");

		})

		/*详情*/
		function purchaseReturnDetail(id) {
			<%-- ajaxJquery("POST","<%=basePath%>purchase/procuretable/selectById",{"id" : id},function(data){
				if(data!=null){
					$("#look_identifier").html(data.identifier);
					$("#look_generate_date").html(getSmpFormatDateByLong(data.generateDate, true));
					$("#look_purchase_identifier").html(data.procureTableIdentifier);
					if(data.supcto!=null){
						$("#look_supcto_name").html(data.supcto.name);
					}
					else{
						$("#look_supcto_name").html("");
					}
					if(data.shippingMode!=null){
						$("#look_transportationMode").html(data.shippingMode.name);
					}else{
						$("#look_transportationMode").html("");
					}
					
					$("#look_goodsArrivalPlace").html(data.goodsArrivalPlace);
					$("#look_deliveryman").html(data.deliveryman);
					$("#look_phone").html(data.phone);
					$("#look_fax").html(data.fax);
					$("#look_summary").html(data.summary);
					if(data.originatorName!=null){
						$("#look_originator").html(data.originator+"("+data.originatorName+")");
					}
					else{
						$("#look_originator").html(data.originator);
					}
					if(data.reviewerName!=null){
						$("#look_reviewer").html(data.reviewer+"("+data.reviewerName+")");
					}
					else{
						$("#look_reviewer").html(data.reviewer);
					}
					
					var allMoney=0;			
					//商品
					$("#look_goodsTbody").html("");
					$("#look_goodsTbody")
					.append(
							'<tr">'
									+ '<th>货品编码</th>'
									+'<th>货品名称</th>'
									+'<th>仓库名称</th>'
									+'<th>规格</th>'
									+'<th>单位</th>'
									+'<th>退货数量</th>'
									+'<th>退货单价</th>'
									+'<th>金额</th>');
					
					for(var i=0;i<data.procureCommoditys.length;i++){
						$("#look_goodsTbody")
								.append(
										'<tr">'
												+ '<td>'
												+ data.procureCommoditys[i].commoditySpecification.specificationIdentifier
												+ '</td><td>'
												+ data.procureCommoditys[i].commoditySpecification.specWarehouseName
												+ '</td><td>'
												+ data.procureCommoditys[i].commoditySpecification.commodity.name
												+ '</td><td>'
												+ data.procureCommoditys[i].commoditySpecification.specificationName
												+ '</td><td>'
												+ data.procureCommoditys[i].commoditySpecification.baseUnitName
												+ '</td>'
												+ '<td>'+data.procureCommoditys[i].arrivalQuantity+'</td>'
												+ '<td>'+data.procureCommoditys[i].businessUnitPrice+'</td>'
												+ '<td>'+data.procureCommoditys[i].totalPrice+'</td>'
												+ '</tr>');
						allMoney+=data.procureCommoditys[i].totalPrice;				
					}
					$("#look_totalAmount").html(allMoney);
				}else{
					laywarn("该订单不存在，请重新加载该页面。");
				}
			}) --%>
			$("#detailDiv").html("");
			$.ajax({
				type: "post",
				url: "<%=basePath%>purchase/procuretable/detailPurchaseReturnOrder",
				dataType : "json",
				data: {
					"id" : id
				},
				success: function(res) {
					let bill = new DetailBill(res);
					let $content = bill.toPrint();
					$("#detailDiv").html($content);
				}
			});
			layer.open({
				type: 1,
				title: "采购退货详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#detailDiv"),
				btn: ['关闭'],
			});
		}
		/*出库*/
		function purchaseReturnOut(id) {
			publicMessageLayer("出库", function() {
				ajaxJquery("POST","<%=basePath%>purchase/procuretable/updateReturnedPurchaseState",{"id" : id,"state":14},function(data){
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
					} else {
						layfail(data.msg);
					}
				})
			})
		}
		/*打印*/
		function purchaseReturnPrint(row) {
			$.ajax({
				type: "get",
				url: "<%=basePath%>purchase/procuretable/printReturnedPurchase",
				async: true,
				data:{
					"id":row.id
				},
				success: function(res) {
					let bill = new Bill(res);
					let $content = bill.toPrint();
					let count=1;
					
					$("#printDiv").html("");
					$("#printDiv").append($content);
					$("#printDiv .container").append(watermark("打印次数：" + (row.printNum+1) + "次", "#pickingList"));
					$('.watermark>div').fontFlex(80, 100, 10);
				}
			});
			layer.open({
				type: 1,
				title: "采购退货单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#printDiv"),
				btn: ['打印', '关闭'],
				yes: function(index) {
					$("#printDiv .container").printArea();
					ajaxJquery("GET","<%=basePath%>purchase/procuretable/updateProcurePrintNum",{"id" : row.id},function(data){
						layer.close(index);
						oTable1.fnDraw(false);
					})
				},
				end: function(index, layero) {
					layer.close(index);
					oTable1.fnDraw(false);
					$("#printDiv").html("");
				}
			});
		}
	</script>

</html>