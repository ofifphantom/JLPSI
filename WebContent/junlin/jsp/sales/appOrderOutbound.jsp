<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String path = request.getContextPath();
	String basePath = path + "/";
	String ipPath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String MISPath=request.getScheme()+"://"+request.getServerName()+":"+"8080";
    //String userIdentifier=(String) request.getSession().getAttribute("userName");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>app订单出库</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
	<script src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
	<script src="${pageContext.request.contextPath}/junlin/script/watermark.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/junlin/script/Bill.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/junlin/script/watermark.js" type="text/javascript"></script>
<%@include file="/common.jsp"%>
		<style>
			#sendOut label {
				line-height: 32px;
			}
		</style>
</head>

<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">app订单出库</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							单号： <input type="text" value=""  id="query_identifier"/>
						</span>
							<span class="l_f"> 
							用户姓名： <input type="text" value="" id="query_name"/>
						</span>
							<span class="l_f"> 
							电话： <input type="text"  value=""  id="phone"/>
						</span>
						<span class="l_f"> 
								日期： <input type="text"  value="" id="dateSearch" placeholder="请选择日期" readonly="readonly" />
						</span>
						<span class="l_f"> 
							仓库类型： <select class="warehouse"  id="type">
								<option value="-1">请选择</option>
								<option value="32">未发货</option>
								<option value="33">已发货</option>
							</select>
						</span>
							
							<span class="r_f"> 
							<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
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
									<th>商品名称</th>
									<th>数量</th>
									
									<th>用户姓名</th>
									<th>电话</th>
									<th>下单时间</th>
									<th>订单状态</th>
									<th width="20%">操作</th>
								</tr>

							</thead>
							<tbody>
								<!-- <tr>
									<td>
										<span class="look-span" onclick="salesOrderDetail()">PO.2017.09.00054</span>
									</td>
									<td>AAAA</td>
									<td>配送</td>
									<td>XXXXXXXXXXXXXXXXXXXXX</td>
									<td>海鲜饺子</td>
									<td>2017.10.02</td>
									<td>XX部</td>
									
									<td>未审核</td>
									<td>
										<input type="button" class="btncss edit" onclick="salesOrderDetail()" value="详情" />
										<input type="button" class="btncss edit" onclick="orderSendOut()" value="发货" />
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
							<label for="" class="col-xs-4 control-label">订单日期:</label>
							<div class="col-xs-8  look_create_time">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">收货人:</label>
							<div class="col-xs-8 look_receiveName">
							</div>
						</div>
						<!-- <div class="form-group">
							<label for="" class="col-xs-4 control-label">实付款:</label>
							<div class="col-xs-8 look_advanceScale">
							</div>
						</div> -->
					</div>
					<div class="col-xs-6">
						
						
						
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">收货地点:</label>
							<div class="col-xs-8 look_receivePlaces">
							</div>
						</div>
						

						<div class="form-group">
							<label for="" class="col-xs-4 control-label">联系电话:</label>
							<div class="col-xs-8 look_receivePhone">
							</div>
						</div>
						
						
						
					</div>
				</div>
				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">合计金额:</label>
							<div class="col-xs-8 look_totalMoney">
							</div>
						</div>
						
					</div>
				</div>
				
				<div class="row jl-title">
					<span>商品</span>

				</div>
				<div id="allGoodsDiv_look"></div>
				

			</form>

		</div>

		<!--出库单-->
		<div id="pickingList" style="display: none;">
		</div>

		<!--发货-->
		<div id="sendOut" style="display: none;padding-top: 50px;padding-left: 17%;">
			<div class="form-group">
				<label class="col-xs-2 control-label">车牌号：</label>
				<div class="col-xs-7">
					<input type="text" class="form-control" id="carID" data-provide="typeahead" placeholder="输入车牌号可自动进行检索近期使用过的车牌号" onkeyup="cky(this)"  maxlength="100"/>
				</div>
			</div>
		</div>
	</body>

	<script>
	
	$(function() {
		/* 车牌号的自动搜索功能 */
	     $('#carID').typeahead({
	      source:function(query, process) {
	    return $.ajax({
	     url: '<%= MISPath%>/JLMIS/orderManagement/order/order/selectTenCarId',
	     type: 'post',
	     data: {
	      carId: query
	     },
	     success: function(result) {
	      var resultList = [];
	      console.log(result.length);
	      for(var i = 0; i < result.length; i++) {
	       var aItem = result[i];
	       resultList.push(aItem);
	      }
	      return process(resultList);
	     },
	    });

	   },
	   updater: function(obj) {
	    return obj;
	   }
	     });
		latdate("#dateSearch");
		laydate.render({
			elem: "#dateOrder",
			type: 'date',
			format: 'yyyy-MM-dd',
			min: 0
		});
		

	})
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
							"page":19,
							"date":$("#dateSearch").val(),
							"type":$("#type").val(),
							"identifier": $("#query_identifier").val(),
							"name": $("#query_name").val(),
							"phone": $("#phone").val(),
							"isSpecimen": 0,
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
										"mData" : "commoditysName",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"
									},
									
									{
										"mData" : "salesOrderCommodities[0].deliverGoodsNum",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center"

									},
									
									{
										"mData" : "consignee",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center"

									},
									{
										"mData" : "phone",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center"

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
												return "未发货";
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
														return "已发货";
													}
												}
												else{
													return "已发货";
												}
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
											if(row.state==32){
												return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail('
												+data
												+')" value="详情" /></td><td><input type="button" class="btncss edit" onclick=\'orderSendOut('+JSON.stringify(row)+')\' value="发货" /></td>'
											
											}else{
												return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail('
												+data
												+')" value="详情" /></td>'
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
	
		

		/*详情*/
		function salesOrderDetail(id) {
			<%-- $("#allGoodsDiv_look").html("");
			/*请在此处为销售订单详情赋值*/
			ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectOrderDetailById",{"id":id},function(data){
				$(".look_create_time").html(getSmpFormatDateByLong(data.createTime,false));
				$(".look_receivePlaces").html(data.deliverGoodsPlace);
				
				/* $(".look_advanceScale").html(data.advanceScale); */
				$(".look_receiveName").html(data.consignee);
				$(".look_receivePhone").html(data.phone);
				var allDeliverGoodsMoney=0;//总金额
				for(var i=0;i<data.salesOrderCommodities.length;i++){
					goodsAdd_look(i+1);
					$("#look_goodDiv"+(i+1)+" .look_commodityName").html(data.salesOrderCommodities[i].commoditySpecification.commodity.name);
					$("#look_goodDiv"+(i+1)+" .look_commodityPrice").html(data.salesOrderCommodities[i].unitPrice);
					$("#look_goodDiv"+(i+1)+" .look_commodityNum").html(data.salesOrderCommodities[i].deliverGoodsNum);
					$("#look_goodDiv"+(i+1)+" .look_commodityMoney").html((data.salesOrderCommodities[i].deliverGoodsNum)*(data.salesOrderCommodities[i].unitPrice));
					allDeliverGoodsMoney+=(data.salesOrderCommodities[i].deliverGoodsNum)*(data.salesOrderCommodities[i].unitPrice);
				}
				$(".look_totalMoney").html(allDeliverGoodsMoney);
				
				
				
				
			}); --%>
			$("#lookDiv").html("");
			$.ajax({
				type: "post",
				url: "<%=basePath%>sales/salesOrder/salesOrderDetail",
				dataType : "json",
				data: {
					"id" : id,
					"type":7
				},
				success: function(res) {
					let bill = new DetailBill(res);
					let $content = bill.toPrint();
					$("#lookDiv").html($content);
				}
			});
			layer.open({
				type: 1,
				title: "APP销售发货单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#lookDiv"),
				btn: ['关闭']
			});
		}
		/* 查看详情时的商品添加 */
		function goodsAdd_look(index){
			let goodsDiv=`<div class="row jl-panel" id="look_goodDiv`+index+`">
			<div class="col-xs-6">
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">货品名称:</label>
				<div class="col-xs-8 look_commodityName">

				</div>
			</div>

			
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">价格:</label>
				<div class="col-xs-8 look_commodityPrice">
				</div>
			</div>
			</div>
			<div class="col-xs-6">
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">数量:</label>
				<div class="col-xs-8 look_commodityNum">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="col-xs-4 control-label">金额:</label>
				<div class="col-xs-8 look_commodityMoney">
				</div>
			</div>
			</div>
		</div>`;
		
		$("#allGoodsDiv_look").append(goodsDiv);
		}
		/*发货*/
		function orderSendOut(row) {
			
			layer.open({
				type: 1,
				title: "订单发货",
				closeBtn: 1,
				area: ['800px', '300px'],
				content: $("#sendOut"),
				btn: ['提交'],
				yes: function(index) {
					if($("#carID").val() == null || $("#carID").val() == "") {
						laywarn("车牌号不能为空!");
						return;
					}
					if(!isVehicleNumber($("#carID").val())){
						laywarn("请输入正确的车牌号!");
						return;
					}
					
					/*请在此处添加发货操作*/
					$.ajax({
						url: '<%=basePath%>/sales/salesOrder/updateAppOrderState',
						type: 'post',
						data: {
							"saleOrderId": row.id,
							"misId": row.missOrderId,
							"parentId": row.parentId,
							"identifier": row.identifier
						},
						success: function(data) {
							if(data.success){
								$.ajax({
									url :'<%= MISPath%>/JLMIS/orderManagement/order/order/shippingGoods' ,
									type : "POST",
									dataType : "json",
									data: {
										 "oId": row.missOrderId,
										 "carId": $("#carID").val()
									},
									success : function(data) {
										if(data.success){
											laysuccess(data.msg);
											layer.close(index);
											oTable1.fnDraw(false);
										}else{
											layfail(data.msg);
											layer.close(index);
										}
									}
								});
								
							}else{
								layfail(data.msg);
								layer.close(index);
							}
						},
					});
					

				},
				end: function() {
					clearForm("sendOut");
				}
			});
		}
		
		
		function isVehicleNumber(vehicleNumber) {
		      var result = false;
		      var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
		      result = express.test(vehicleNumber);
		      return result;
		  }
	</script>

</html>