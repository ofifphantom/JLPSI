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
		<title>App销售退货单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>		
		<link href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
	    <script src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
		<style>
			#editDiv {
				padding-top: 20px;
			}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">App销售退货单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							编号： <input type="text" value="" id="query_identifier" onblur="cky()" />
						</span>
							<span class="l_f"> 
							日期： <input type="text" value="" readonly="readonly"  id="dateTime" placeholder="请选择日期"/>
						</span>
							<span class="l_f"> 
							订货姓名： <input type="text"  value="" id="query_name"  onblur="cky()"/>
						</span>
						<span class="l_f"> 
							订货人电话： <input type="text"  value="" id="phone"  onblur="cky()"/>
						</span>
						

							<span class="r_f"> 
							<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
						</div>

					</div>
					<div class="opration-div clearfix">

						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="salesReturnAdd()"><i class="fa fa-plus"></i> 新增</button>
						</span>

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>单号</th>
									<th>app订单编号</th>
									<th>退货商品</th>
									<th>订货人姓名</th>
									<th>订货人联系方式</th>
									<th>日期</th>
									<th>制单人</th>
									<th>状态</th>
								</tr>

							</thead>
							<tbody>
								<!--<tr>
									<td>
										<span class="look-span" onclick="salesReturnDetail()">PO.2017.09.00054</span>
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
										<input type="button" class="btncss edit" onclick="salesReturnEdit()" value="编辑" />
										<input type="button" class="btncss edit" onclick="salesReturnDel()" value="删除" />
									</td>
								</tr>-->
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<!--新增 编辑 -->
		<div id="editDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>引用退货单据</span>

				</div>
				<div class="jl-panel" id="headEdit">
					<div class="row">
						<div class="col-md-12 col-xs-12">
							<div class="form-group">
								<label for="" class="col-xs-2 control-label">退货单据</label>
								<div class="col-xs-10" style="padding-left: 7px;" id="checkBillSelectDiv">
									<select id="checkBillSelect" class="form-control">
										<!-- <option value="-1">--请选择退货单据--</option>
										<option value="1" attr-appOrderNum="123" attr-customerName="111">1</option>
										<option value="2" attr-appOrderNum="333" attr-customerName="144411">2</option> -->
									</select>
								</div>
							</div>
						</div>
						<span id="misOrderId" class="hidden"></span>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">APP订单编号</label>
								<div class="col-xs-8">
									<input type="text" id="appOrderNum" class="form-control" placeholder="请先选择需退货的单据" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">订货人名称</label>
								<div class="col-xs-8">
									<input type="text" id="customerName" class="form-control" placeholder="请先选择需退货的单据" disabled="disabled" />
								</div>
							</div>
						</div>
						
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">订货人联系电话</label>
								<div class="col-xs-8">
									<input type="text" id="phoneNumber" class="form-control" placeholder="请先选择需退货的单据" disabled="disabled" />
								</div>
							</div>
						</div>
						
					</div>
				</div>

				<div class="row jl-title">
					<span>退货单据</span>
					<i class="r_f"> 
						<button type="button" class="btncss jl-btn-importent" onclick="goodsAdd()">选择商品</button>
					</i>
					<i class="r_f">
					<select id="goodsSelect" disabled="disabled">
						<option value="-1">--请选择商品--</option>
						<option value="123" attr-goodsName="date" attr-type="1000" attr-unit="袋" >44</option>
					</select>
					</i>
				</div>
				<div class="row">
					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="goodsTbody">
							<tr>
								<th>货品编码</th>
								<th>货品名称</th>
								<th>规格</th>
								<th>单位</th>
								<th>发货数量</th>
								<th>退货数量</th>
								<th>单价</th>
								<th>退货金额</th>
								<th>操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="9">请先选择商品</td>
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
								<label for="" class="col-xs-4 control-label">本次退货总金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="totalAmount" value="" disabled="disabled" />
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="jl-panel" id="footerEdit">
					<div class="row">
						<!-- <div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门</label>
								<div class="col-xs-8">
									<select class="form-control">
										<option value="-1">--请选择部门--</option>
										<option value="1">部门</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员</label>
								<div class="col-xs-8">
									<select class="form-control">
										<option value="-1">--请选择部门--</option>
										<option value="1">部门</option>
									</select>
								</div>
							</div>
						</div> -->
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="edit_summary" value="无" onblur="cky(this)" />
								</div>
							</div>
						</div>

					</div>
				</div>

			</form>

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
								<label for="" class="col-xs-4 control-label">APP订单编号：</label>
								<div class="col-xs-8" id="look_app_identifier">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">订货人名称：</label>
								<div class="col-xs-8" id="look_orderer">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">订货人联系电话：</label>
								<div class="col-xs-8" id="look_phone">

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
								<th>发货数量</th>
								<th>退货数量</th>
								<th>单价</th>
								<th>退货金额</th>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
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
								<div class="col-xs-8" id="look_allMoney">

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
						<!--<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门：</label>
								<div class="col-xs-8">

								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员：</label>
								<div class="col-xs-8">

								</div>
							</div>
						</div>-->
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">制单人：</label>
								<div class="col-xs-8" id="look_originator">

								</div>
							</div>
						</div>
						<!--<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">审核人：</label>
								<div class="col-xs-8">

								</div>
							</div>
						</div>-->
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要：</label>
								<div class="col-xs-8" id="look_summary">

								</div>
							</div>
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
							"page":20,
							"identifier": $("#query_identifier").val(),
							"date": $("#dateTime").val(),
							"orderer": $("#query_name").val(),
							"phone": $("#phone").val(),
							"isAppOrder":2,
							"isSpecimen":0,
							"createTime": "",
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
										
										return '<td><span class="look-span" onclick="salesReturnDetail('
										+ row.id
										+ ')">'
										+ data
										+ '</span></td>';
										
									}
								},{
									"mData" : "appOrderIdentifier",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center"
								},{
										"mData" : "commoditysName",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"
									},{
										"mData" : "orderer",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center"

									},{
										"mData" : "phone",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"
									},{
										"mData" : "createTime",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender": function(data) {
											return getSmpFormatDateByLong(data, true);
										}

									},{
										"mData": "originator",
										"bSortable": false,
										"sWidth": "10%",
										"sClass": "center",
										"mRender": function(data,type,row) {
											if(row.person!=null){
												if(row.person.name!=null){
													return data+"("+row.person.name+")";
												}else{
													return data;
												}	
											}
											else{
												return data;
											}
											
										}
									},{
										"mData" : "state",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											switch (data) {
											case 30:
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
														return "待退货入库";
													}
												}
												else{
													return "待退货入库";
												}
												break;
											case 31:
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
														return "已退货入库";
													}
												}
												else{
													return "已退货入库";
												}
												break;
											default:
												return "";
												break;
											}
										}

									}],
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
	
	var appReturnGoodsSalesOrderMsg=[];//保存查出来的app需要退货的销售订单信息
	
	function getAppReturnSalesOrder(){
		//销售订单下拉框赋值
		$.ajax({
			url :'<%=basePath%>/sales/salesOrder/selectAppRturnGoodsSalesOrderMsg' ,
			type : "POST",
			dataType : "json",
			success : function(data) {
				appReturnGoodsSalesOrderMsg=[];
				appReturnGoodsSalesOrderMsg=data;
				setCheckBillSelect(data);
				if(data.length==0){
					$("#checkBillSelect").append('<option value="-1" selected="selected">--暂无可退货的APP销售订单--</option>');
				}
				else{
					$("#checkBillSelect").append('<option value="-1" selected="selected">--请选择需要退货的app销售订单--</option>');
					for ( var i = 0; i < data.length; i++) {
						
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].identifier +" APP订单编号："+data[i].appOrderIdentifier+"</option>");
						
						$("#checkBillSelect").append(option);	
					}
				}
				$("#checkBillSelect").searchableSelect();
			}
		});
	}
	
	/*为退货单据赋值*/
	function setCheckBillSelect(data){
		$("#checkBillSelectDiv").html("");
		$("#checkBillSelectDiv").html(`<select id="checkBillSelect" class="form-control"></select>`);
		
	}
	
		var goodsArr = [];
		$(function() {
			latdate("#dateTime");
		})
		
		/*新增*/
		function salesReturnAdd() {
			getAppReturnSalesOrder();
			openLayer("editDiv", "新增APP销售退货单", function(openLayerIndex) {
				JSON.stringify(salesOrderDataJSON());
				$.ajax({
					url: '<%=basePath%>sales/salesOrder/addReturnOrder',
					type: "GET",
					dataType: "json",
					data:{
						"salesOrder":JSON.stringify(salesOrderDataJSON())
						},
					async: false,
					cache: false,
					success: function(data) {
						if(data.success) {
							laysuccess(data.msg);
							oTable1.fnDraw(false);
						} else {
							layfail(data.msg);
						}
						layer.close(openLayerIndex);
					}
				});
				
				/* if(checkFormFormat()){
					
					layer.close(openLayerIndex);
				} */
			})
		}
		/*修改*/
		/* function salesReturnEdit() {
			openLayer("editDiv", "修改销售退货单", function(openLayerIndex) {
				if(checkFormFormat()){
					
					layer.close(openLayerIndex);
				}
			})

		} */

		/*详情*/
		function salesReturnDetail(id) {
			<%-- let emptyTbody = `
				<tr>
					<th>货品编码</th>
					<th>货品名称</th>
					<th>规格</th>
					<th>单位</th>
					<th>发货数量</th>
					<th>退货数量</th>
					<th>单价</th>
					<th>退货金额</th>
				</tr>`;
			$("#look_goodsTbody").html(emptyTbody);
			 ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectOrderDetailById",{"id":id},function(data){
					$("#look_identifier").html(data.identifier);
					$("#look_createTime").html(getSmpFormatDateByLong(data.createTime, true));
					$("#look_parentId").html(data.parentIdentifier);
					$("#look_app_identifier").html(data.appOrderIdentifier);
					$("#look_orderer").html(data.orderer);
					$("#look_phone").html(data.phone);
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
						let deliverGoodsNum=commoditie.deliverGoodsNum;
						let number=commoditie.returnGoodsNum;
						let unitPrice=commoditie.unitPrice;
						let money=commoditie.appAmountMoney;
						allMoney+=money;
						$("#look_goodsTbody").append('<tr><td class="">' + identifier + '</td><td>' + goodsName + '</td><td>' + type +
								'</td><td>' + unit + '</td>' +
								'<td>'+deliverGoodsNum+'</td>' +
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
						"type":6
					},
					success: function(res) {
						let bill = new DetailBill(res);
						let $content = bill.toPrint();
						$("#detailDiv").html($content);
					}
				});
			layer.open({
				type: 1,
				title: "App销售退货单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#detailDiv"),
				btn: ['关闭'],
			});
		}
		/*删除*/
		/* function salesReturnDel() {
			publicMessageLayer("删除销售退货单", function() {

				laysuccess("删除");
			})
		} */
		
		
		
		

		/*
		 * 选择单据的onchange事件
		 * 该方法用于取到App订单编号、客户名称
		 * */
		function checkBillSelect(thisselect,val) {
			let $selectedOption = $(thisselect).find("option:selected");
			
			if(val=="-1"){
				$("#appOrderNum").val("");
				$("#customerName").val("");
				$("#phoneNumber").val("");
				$("#misOrderId").val("");
			}
			else{
				/*请在此处取到 App订单编号、客户名称，并为其赋值*/
				for(var i=0;i<appReturnGoodsSalesOrderMsg.length;i++){
					if(appReturnGoodsSalesOrderMsg[i].id==val){
						$("#appOrderNum").val(appReturnGoodsSalesOrderMsg[i].appOrderIdentifier);
						$("#customerName").val(appReturnGoodsSalesOrderMsg[i].consignee);
						$("#phoneNumber").val(appReturnGoodsSalesOrderMsg[i].phone);
						console.log("misOrderId",appReturnGoodsSalesOrderMsg[i].missOrderId);
						$("#misOrderId").html(appReturnGoodsSalesOrderMsg[i].missOrderId);
					}
				}
			}
			
			

			if(val== "-1") {
				$("#goodsSelect").parent().html('<select id="goodsSelect" disabled="disabled"><option value="-1">--请先选择退货单据--</option></select>');
			} else {
				$("#goodsSelect").parent().html('<select id="goodsSelect"><option value="-1">--请选择商品--</option></select>');

				/*
				 * 请在此处添加添加商品的select的option
				 */
				 $.ajax({
						url :'<%=basePath%>/sales/salesOrder/getSalesOrderCommodityBySalesOrderId' ,
						type : "POST",
						dataType : "json",
						data: {"salesOrderId":val},
						success : function(data) {
							console.log("data:",data);
							
							$("#goodsSelect").empty();
							if(data.length==0){
								$("#goodsSelect").append('<option value="-1" selected="selected">--暂无可退货的商品--</option>');
							}
							else{
								$("#goodsSelect").append('<option value="-1" selected="selected">--请选择商品--</option>');
							
								for ( var i = 0; i < data.length; i++) {
									console.log("warehouseId",data[i].warehouseId);
									var option = $("<option  value='"+data[i].commoditySpecification.id+"'"
											+ " data-specificationIdentifier='"+data[i].commoditySpecification.specificationIdentifier+"'"
											+ " data-commodityName='"+data[i].commoditySpecification.commodity.name+"'"
											+ " data-specificationName='"+data[i].commoditySpecification.specificationName+"'"
											+ " data-baseUnitName='"+data[i].commoditySpecification.baseUnitName+"'"
											+ " data-deliverGoodsNum='"+data[i].deliverGoodsNum+"'"
											+ " data-warehouseId='"+data[i].warehouseId+"'"
											+" data-baseCommonlyPrice='"+data[i].commoditySpecification.baseCommonlyPrice+"'>"
											+data[i].commoditySpecification.commodity.name + "(" + data[i].commoditySpecification.specificationName + ")</option>");
									$("#goodsSelect").append(option);
									
								}
							}
							
						}
					});
				/* $("#goodsSelect").append('<option value="44" attr-goodsName="date" attr-type="1000" attr-unit="袋" >44</option>');
				$("#goodsSelect").append('<option value="33" attr-goodsName="date" attr-type="1000" attr-unit="袋" >33</option>'); */
			}
			clearBill();
		}

		/*
		 * 该方法用于选择商品的 onclick事件
		 * 用于添加table的退货商品
		 */
		function goodsAdd() {
			/*获取订单相关值*/
			let goodsNum = $("#goodsSelect").val();
			let goodsspecificationIdentifier=$("#goodsSelect option:selected").attr("data-specificationIdentifier");
			let goodsName = $("#goodsSelect option:selected").attr("data-commodityName");
			let type = $("#goodsSelect option:selected").attr("data-specificationName");
			let unit = $("#goodsSelect option:selected").attr("data-baseUnitName");
			let receivingGoodsNum = $("#goodsSelect option:selected").attr("data-deliverGoodsNum");
			let baseCommonlyPrice = $("#goodsSelect option:selected").attr("data-baseCommonlyPrice");
			let warehouseId = $("#goodsSelect option:selected").attr("data-warehouseId");
			console.log("let warehouseId",warehouseId);
			/*判断并添加到table*/
			if($("#checkBillSelect").val() == "-1") {
				layfail("请先选择退货单据!");
			} else if(goodsNum == "-1") {
				layfail("请先选择商品!");
			} else if(!checkRepeat(goodsNum, goodsArr)) {
				$("#goodsTbody .tipTr").remove();
				goodsArr.push(goodsNum);
				$("#goodsTbody").append('<tr class="goodsTr"><td class="goodsNum hidden">' + goodsNum + '</td><td class="warehouseId hidden">' + warehouseId + '</td>'+
					'<td class="specificationIdentifier">' + goodsspecificationIdentifier + '</td><td>' + goodsName + '</td><td>' + type +
					'</td><td>' + unit + '</td><td class="deliverGoodsNum">' + receivingGoodsNum + '</td>' +
					'<td><input type="text" class="form-control count" onkeyup="countKeyUp(this)" attr-name="退货数量"/></td>' +
					'<td><input type="text" class="form-control unitPrice" disabled="disabled" value='+baseCommonlyPrice+'  /></td>' +
					'<td><input type="text" class="form-control amountMoney" onkeyup="countTotalAmount(this)" attr-name="退货金额"/></td>' +
					'<td><input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
			} else {
				layfail("请勿重复选择商品！");
			}
		}
		
		/*退货数量的 onkeyUp事件*/
		function countKeyUp(thisInput) {
			pressInteger(thisInput);
			let parentTr = $(thisInput).parents("tr");
			console.log("val",$(thisInput).val());
			if($(thisInput).val() != "") {
				let count = $(thisInput).val() - 0;
				let unitPrice = parentTr.find(".unitPrice").val();
				let maxnum = parentTr.find(".deliverGoodsNum").html();
				if(count-0>maxnum-0){
					layfail("退货数量不能大于发货数量！");
					$(thisInput).val("");
					parentTr.find(".amountMoney").val("");
				}else if(count == 0) {
					layfail("退货数量不能为0！");
					$(thisInput).val("");
					parentTr.find(".amountMoney").val("");
				} else if(count > 0&&unitPrice!=""){
					//parentTr.find(".amountMoney").val(((unitPrice-0) * count).toFixed(2));
				}
			} else {
				//parentTr.find(".amountMoney").val("");
			}
			/* countTotalAmount(); */
		}


		/*
		 * 删除商品
		 */
		function goodsDel(thisbtn) {
			let $tbody = $(thisbtn).parents("tbody");
			let goodsNum = $(thisbtn).parents("tr").find(".goodsNum").html();
			goodsArr.remove(goodsNum);
			$(thisbtn).parents("tr").remove();
			if($tbody.find("tr").length == 1) {
				$tbody.append('<tr class="tipTr"><td colspan="9">请先选择商品</td></tr>');
			}
			countTotalAmount();
		}
		
		/*单价 onkeyup事件*/
		/* function unitPriceKeyUp(thisInput){
			pressMoney(thisInput);
			let parentTr = $(thisInput).parents("tr");
			if($(thisInput).val() != "") {
				let  unitPrice= $(thisInput).val() - 0;
				let count = parentTr.find(".count").val();
				if(count!=""){
					parentTr.find(".amountMoney").val(unitPrice * (count-0));
				} 
			} else {
				parentTr.find(".amountMoney").val("");
			}
			countTotalAmount();
			
		} */
		
		/*退货数量的 onkeyUp事件*/
		/* function countKeyUp(thisInput) {
			pressInteger(thisInput);
			let parentTr = $(thisInput).parents("tr");
			if($(thisInput).val() != "") {
				let count = $(thisInput).val() - 0;
				let unitPrice = parentTr.find(".unitPrice").val();
				if(count == 0) {
					layfail("退货数量不能为0！");
					$(thisInput).val("");
					parentTr.find(".amountMoney").val("");
				} else if(count > 0&&unitPrice!=""){
					parentTr.find(".amountMoney").val((unitPrice-0) * count);
				}
			} else {
				parentTr.find(".amountMoney").val("");
			}
			countTotalAmount();
		}
 */
		/*计算总金额*/
		function countTotalAmount(thisinput) {
	 		pressMoney(thisinput);
			let totalAmount = 0;
			$("#goodsTbody .amountMoney").each(function(index, obj) {
				if($(obj).val() != "") {
					totalAmount += ($(obj).val() - 0);
				}
			})
			$("#totalAmount").val(totalAmount);
		}

		/*创建一个通用的打开新增核销单的layer的方法*/
		function openLayer(layerId, title, callFun) {
			layer.open({
				type: 1,
				title: title,
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#" + layerId + ""),
				btn: ['提交', '取消'],
				yes: function(openLayerIndex) {
					if(checkFormHaveEmpty(layerId)) {
						callFun(openLayerIndex);
					}
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm(layerId, "");
					clearBill();
					$("#edit_summary").val("无");
				}
			});
		}
		/*判断单据是否为空*/
		function checkFormHaveEmpty(DivId) {
		//判断表单是否填写完整 填写完整返回true,相反返回false
		var res = true;
		$("#headEdit select").each(function(index, val) {
			if($(val).val() == "-1" && res) {
				checkInputEmptyLayer(val);
				res = false;
			}
			
		});
		if(!res) return res;
		$("#headEdit input").each(function(index, val) {
			if($(val).val() == "" && (!$(val).hasClass("searchable-select-input")) && res) {
				checkInputEmptyLayer(val);
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
			if($(val).val() == "" && (!$(val).prop("disabled")) && res) {
				checkTableInputEmptyLayer(val);
				res = false;
			}
		});
		if(!res) return res;
		$("#goodsTbody select").each(function(index, val) {
			if($(val).val() == "-1" && res) {
				checkTableInputEmptyLayer(val);
				res = false;
			}
		});
		if(!res) return res;
		$("#footerEdit select").each(function(index, val) {
			if($(val).val() == "-1" && res) {
				checkInputEmptyLayer(val);
				res = false;
			}
		});
		if(!res) return res;
		$("#footerEdit input").each(function(index, val) {
			if($(val).val() == "" && res) {
				checkInputEmptyLayer(val);
				res = false;
			}
		});
		return res;
	}
		function checkInputEmptyLayer(thisInput) {
		//判断footer或者header中Input框为空时弹出layer
		var $input = $(thisInput);
		var name = $input.parents(".form-group").find(".control-label").text();
		layfail(name + "不能为空");
	}
	
	function checkTableInputEmptyLayer(thisInput) {
		//判断table中Input框为空时弹出layer
		var $input = $(thisInput);
		var name = $input.attr("attr-name");
		layfail(name + "不能为空");
	}
		/*判断单据内容格式*/
		function checkFormFormat(){
		if(!checkMobilePhone($("#phoneNumber").val())){
			layfail("联系电话格式不正确！")
			return false;
		}else{
			return true;
		}
		}
		/*清空单据*/
		function clearBill() {
			$("#goodsTbody").html('<tr><th>货品编码</th><th>货品名称</th><th>规格</th><th>单位</th><th>发货数量</th><th>退货数量</th><th>单价</th><th>退货金额</th><th>操作</th></tr>' +
				'<tr class="tipTr"><td colspan="9">请先选择商品</td></tr>');
			goodsArr = [];
		}
		/*单据查重*/
		function checkRepeat(id, goodsArr) {
			let flag = false;
			for(var i in goodsArr) {
				if(goodsArr[i] == id) {
					flag = true;
				}
			}
			return flag;
		}
		
		/* 提交或者编辑时 把数据整合成json传入后台 */
    	function salesOrderDataJSON(){
	    	//退货单基础的信息
	   		var  salesOrderDataJSON={
	    			"missOrderId":$("#misOrderId").html(),
	   				"appOrderIdentifier":$("#appOrderNum").val(),
	   				"parentId":$("#checkBillSelect").val(),
	   				"orderer":$("#customerName").val(),
	   				"phone":$("#phoneNumber").val(),
	   				"summary":$("#edit_summary").val(),
	   				"isAppOrder":2,
	   				"salesOrderCommodities":[]
	   			   }; 
	   		//获取退货商品信息，添加到退货单的商品信息里
	   		$("#goodsTbody .goodsTr").each(function(index, val){
	   			var salesOrderCommoditiesDataJSON={
	   					"commoditySpecificationId":$(val).find(".goodsNum").html(),
	   					"deliverGoodsNum":$(val).find(".deliverGoodsNum").html(),
	   					"returnGoodsNum":$(val).find(".count").val(),
	   					"unitPrice":$(val).find(".unitPrice").val(),
	   					"appAmountMoney":$(val).find(".amountMoney").val(),
	   					"warehouseId":$(val).find(".warehouseId").html()
	   				};	
	   			console.log("salesOrderCommoditiesDataJSON",salesOrderCommoditiesDataJSON);
	   			salesOrderDataJSON.salesOrderCommodities[index]=salesOrderCommoditiesDataJSON;	
	   		});
	   		console.log("salesOrderDataJSON",salesOrderDataJSON);
	    	return salesOrderDataJSON; 
    	}
	</script>
</html>