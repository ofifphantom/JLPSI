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
		<title>仓库填写盘点单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>

		<script src="${pageContext.request.contextPath}/junlin/script/Bill.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/watermark.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery.PrintArea.js"></script>

		<style type="text/css">
			.col-xs-5 {
				text-align: left !important;
			}
			#query_takeStockDate{
			width:190px;
			}
		</style>

	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">仓库填写盘点单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							仓库： <select class="warehouse" id="query_warehouseId">
								
							</select>
							</span>
							<span class="l_f"> 
								日期： <input type="text"  value="" id="query_takeStockDate" placeholder="请选择日期" readonly="readonly" />
							</span>
							<span class="l_f"> 
								制单人姓名： <input type="text"  value="" id="query_originator" onblur="cky(this)" />
							</span>
							<span class="l_f">
								状态：
								<select id="search_type">
									<option value="-1" selected="selected">--请选择--</option>
									
									<option value="2">仓库盘点中</option>
									<option value="3">审核中</option>
									<option value="4">审核驳回</option>
									<option value="5">已完成</option>
									

								</select>
							</span>
							<span class="r_f"> 
								<input type="button" id="btn_search" class="btncss btn_search" value="搜索" />
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
									<th>日期</th>
									<th>仓库</th>
									<th>摘要</th>
									<th>制单人</th>
									<th>状态</th>
									<th width="25%">操作</th>
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
			<div class="print-content">
				
			<form class="container">
				<h3 class="print-title">盘点单</h3>
				<div class="row">
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">仓库：</label>
							<div class="col-xs-7" id="look_warehouseName">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">日期：</label>
							<div class="col-xs-7" id="look_takeStockDate">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">单号：</label>
							<div class="col-xs-7" id="look_identifier">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">出库类型：</label>
							<div class="col-xs-7" id="look_identifier">

							</div>
						</div>
					</div>
				</div>
				<div id="allgoodDivDetail">
					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="look_goods">
							<tr>
								<th>货品编码</th>
								<th>货品名称</th>
								<th>规格</th>
								<th>品牌</th>
								<th>条形码</th>
								<th>单位</th>
								<th>账面数量</th>
								<th>实盘数量</th>
								<th>盈亏数量</th>
								<th>业务单价</th>
								<th>金额</th>
								<th>产品批号</th>
								<th>生产日期</th>
								<th>有效期至</th>
								
							</tr>
						</tbody>
					</table>

				</div>
				<div class="row">
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">部门：</label>
							<div class="col-xs-7" id="look_departmentName">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">业务员：</label>
							<div class="col-xs-7" id="look_person">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">制单人：</label>
							<div class="col-xs-7" id="look_originator">

							</div>
						</div>
					</div>
				</div>
				<div class="row">	
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">摘要：</label>
							<div class="col-xs-7" id="look_summary">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">财务审核人：</label>
							<div class="col-xs-7" id="look_financeReviewer">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">总经理审核人：</label>
							<div class="col-xs-7" id="look_managerReviewer">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">分支机构：</label>
							<div class="col-xs-7" id="look_managerReviewer">
							总部
							</div>
						</div>
					</div>
				</div>

			</form>

				
			</div>
		</div>
		<!--编辑  -->
		<div id="editDiv" style="display: none;">
			<div class="print-content">

				<form class="container">
					<h3 class="print-title">盘点单</h3>
					<div class="row">
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">仓库：</label>
								<div class="col-xs-7" id="edit_warehouseName">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">日期：</label>
								<div class="col-xs-7" id="edit_takeStockDate">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">单号：</label>
								<div class="col-xs-7" id="edit_identifier">

								</div>
							</div>
						</div>
					</div>

					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="goodsTbody">
							<tr>
								<th>货品编码</th>
								<th>货品名称</th>
								<th>规格</th>
								<th>单位</th>
								<th>账面数量</th>
								<th>实盘数量</th>
								<th>盈亏数量</th>
								<th>业务单价</th>
								<th>金额</th>
							</tr>

						</tbody>
					</table>
					<div class="row">
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">部门：</label>
								<div class="col-xs-7" id="edit_departmentName">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">业务员：</label>
								<div class="col-xs-7" id="edit_person">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">制单人：</label>
								<div class="col-xs-7" id="edit_originator">

								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">摘要：</label>
								<div class="col-xs-7" id="edit_summary">

								</div>
							</div>
						</div>
					</div>
					<div class="text-danger">注：该页面所有字段均为必填</div>
				</form>
			</div>
		</div>

		<!--打印-->
		<div id="printDiv" style="display: none;">
		</div>

	</body>

	<script>
	var oTable1;
	$("#btn_search").click(function() {
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
							"page": 2,
							"warehouseId": $("#query_warehouseId").val(),
							"takeStockDate": $("#query_takeStockDate").val(),
							"originator": $("#query_originator").val(),
                            "searchType":$("#search_type").val()
								
						});
					},
					"url": "<%=basePath%>warehouse/base/takeStockOrder/dataTables"
							},

							"aoColumns" : [{
										"mData" : "identifier",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return '<td><span class="look-span" onclick=\'takeStockOrderDetail('
													+ row.id
													+ ')\'>'
													+ data
													+ '</span></td>';
										}
									},
									{
										"mData" : "takeStockDate",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return getSmpFormatDateByLong(data, false);
										}

									},
									{
										"mData" : "warehouseName",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center"
									},
									{
										"mData" : "summary",
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
										"mData" : "state",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender": function(data) {
											switch (data) {
											case 1:
												return "未发送至仓库";
												break;
											case 2:
												return "仓库盘点中";
												break;
											case 3:
												return "待财务审批";
												break;
											case 4:
												return "财务审批驳回";
												break;
											case 5:
												return "待总经理审批";
												break;
											case 6:
												return "总经理审批驳回";
												break;
											case 7:
												return "已完成";
												break;
											default:
												return "";
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
											if(row.state == 2||row.state == 4||row.state == 6){
												return '<td><input type="button" class="btncss edit" onclick="takeStockOrderModify('
												+ data
												+')" value="编辑" />'
												+ '<input type="button" class="btncss edit" onclick="takeStockOrderDetail('
												+ data
												+ ')" value="详情" /></td>'
											}else if(row.state == 7){
												return '<td><input type="button" class="btncss edit" onclick=\'orderPrint(' + JSON.stringify(row) + ')\' value="打印" /></td>'
											}else{
												return '<td><input type="button" class="btncss edit" onclick="takeStockOrderDetail(' + data + ')" value="详情" /></td>'
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
		laydate.render({
            elem: "#query_takeStockDate",
            range:'~'
        });
		//给仓库下拉框赋值
		$.ajax({
			url :'<%=basePath%>basic/warehouse/selectAllWarehouse',
			type: "POST",
			dataType: "json",
			async: false,
			cache: false,
			traditional:true,
			success: function(data) {
				$("#query_warehouseId").html("");
				if(data.length==0){
					$("#query_warehouseId").append("<option value='' selected>--暂无仓库信息，请去添加--</option>");
				}
				else{
					$("#query_warehouseId").append("<option value='' selected>--请选择--</option>");
					for(var i=0;i<data.length;i++){							
						var option = $("<option value='"+data[i].id+"' >"
								+data[i].name+"</option>");
						$("#query_warehouseId").append(option);
					}
				}
				
				
			}
		});
		
	});
		
	$(function() {
		latdate("#query_takeStockDate");
		laydate.render({
			elem: "#dateOrder",
			type: 'date',
			format: 'yyyy-MM-dd',
			min: 0
		});
		

	})

		/*编辑*/
		function takeStockOrderModify(id) {
		var identifier;
		$.ajax({
			url :'<%=basePath%>warehouse/base/takeStockOrder/selectTakeStockOrderDetailById',
			type: "POST",
			dataType: "json",
			async: false,
			cache: false,
			data: {
				"id" : id,
			},
			
			traditional:true,
			success: function(data) {
				identifier = data.identifier
				let emptyTbody = `
					<tr>
						<th>货品编码</th>
						<th>货品名称</th>
						<th>规格</th>
						<th>单位</th>
						<th>账面数量</th>
						<th>实盘数量</th>
						<th>盈亏数量</th>
						<th>业务单价</th>
						<th>金额</th>
					</tr>`;
				$("#goodsTbody").html(emptyTbody);
				$("#edit_warehouseName").html(data.warehouseName);
				$("#edit_takeStockDate").html(getSmpFormatDateByLong(data.takeStockDate,false));
				$("#edit_identifier").html(data.identifier);
				
				for (var i = 0; i < data.takeStockOrderCommodities.length; i++) {
					let commoditie = data.takeStockOrderCommodities[i];
					let salesOrderCommodityId = commoditie.id;
					let commodityName=commoditie.commoditySpecification.commodity.name;
					let specificationidentifier=commoditie.commoditySpecification.specificationIdentifier;
					let specificationname=commoditie.commoditySpecification.specificationName;
					let baseunitname=commoditie.commoditySpecification.baseUnitName;
					let inventorynum=commoditie.inventoryNum;
					let movingaverageprice=commoditie.unitPrice;
					
					let realnum=commoditie.realNum==null?'':commoditie.realNum;
					let profitOrLossNum=commoditie.profitOrLossNum==null?'':commoditie.profitOrLossNum;
					let money=commoditie.money==null?'':commoditie.money;
					
					let realnumInput = '<input type="text" class="form-control realNumber" value="'+realnum+'" onkeyup="realNumberOnKeyUp(this)" maxlength="9">';
					let profitOrLossNumInput = '<input type="text" disabled="disabled" value="'+profitOrLossNum+'" class="form-control amountNumber">';
					let moneyInput = '<input type="text" disabled="disabled" value="'+money+'" class="form-control amountMoney">';
					
					let goodsTr = "<tr class='goodsTr'><td class='salesOrderCommodityId' style='display:none'>"+
					salesOrderCommodityId+"</td><td>"+
					specificationidentifier+"</td><td>"+
					commodityName+"</td><td>"+
					specificationname+"</td><td>"+
					baseunitname+"</td><td class='bookNumber'>"+
					inventorynum+"</td><td>"+
					realnumInput+"</td><td>"+
					profitOrLossNumInput+"</td><td class='businessPrice'>"+
					movingaverageprice+"</td><td>"+
					moneyInput+"</td></tr>";
					$("#goodsTbody").append(goodsTr);
				 
				 }
				
				$("#edit_departmentName").html(data.departmentName);
				$("#edit_person").html(data.personName+"("+data.personIdentifier+")");
				$("#edit_originator").html(data.originatorName+"("+data.originator+")");
				$("#edit_summary").html(data.summary);
			}
		});
			layer.open({
				type: 1,
				title: "编辑盘点单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交并送审', '取消'],
				yes: function(index) {
					if(!checkFill())return;
					$.ajax({
						url: '<%=basePath%>warehouse/base/takeStockOrder/editTakeStockOrderCommodity',
						type: "POST",
						dataType: "json",
						data:{
							"id":id,
							"identifier":identifier,
							"commodity":JSON.stringify(takeStockOrderCommodityDataJSON())
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
							layer.close(index);
						}
					});
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "");
				}
			});
		}

		/*值改变事件*/
		function realNumberOnKeyUp(thisinput) {
			pressInteger(thisinput);
			let realNumber = $(thisinput).val() - 0;
			let parentTr = $(thisinput).parents("tr");
			let bookNumber = parentTr.find(".bookNumber").html() - 0;
			let businessPrice = parentTr.find(".businessPrice").html() - 0;
			
			parentTr.find(".amountNumber").val("");
			parentTr.find(".amountMoney").val("");
			
			if(isnotEmpty($(thisinput).val())){
				parentTr.find(".amountNumber").val(realNumber - bookNumber);
				let amountNumber = parentTr.find(".amountNumber").val() - 0;
				parentTr.find(".amountMoney").val((businessPrice * amountNumber).toFixed(2));
			}
			
		}

		/*详情*/
		function takeStockOrderDetail(id) {
			<%-- $.ajax({
				url :'<%=basePath%>warehouse/base/takeStockOrder/selectTakeStockOrderDetailById',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"id" : id,
				},
				
				traditional:true,
				success: function(data) {
					let emptyTbody = `
						<tr>
							<th>货品编码</th>
							<th>货品名称</th>
							<th>规格</th>
							<th>品牌</th>
							<th>条形码</th>
							<th>单位</th>
							<th>账面数量</th>
							<th>实盘数量</th>
							<th>盈亏数量</th>
							<th>业务单价</th>
							<th>金额</th>
							<th>产品批号</th>
							<th>生产日期</th>
							<th>有效期至</th>
							
						</tr>`;
					$("#look_goods").html(emptyTbody);
					$("#look_warehouseName").html(data.warehouseName);
					$("#look_takeStockDate").html(getSmpFormatDateByLong(data.takeStockDate,false));
					$("#look_identifier").html(data.identifier);
					var zm_num=0;
					var sp_num=0;
					var yk_num=0;
					var total_money=0.0;
					for (var i = 0; i < data.takeStockOrderCommodities.length; i++) {
						let commoditie = data.takeStockOrderCommodities[i];
						let commodityName=commoditie.commoditySpecification.commodity.name;
						let specificationidentifier=commoditie.commoditySpecification.specificationIdentifier;
						let specificationname=commoditie.commoditySpecification.specificationName;
						let baseunitname=commoditie.commoditySpecification.baseUnitName;
						let inventorynum=commoditie.inventoryNum;
						let movingaverageprice=commoditie.unitPrice;
						let realnum=commoditie.realNum;
						let barCode=commoditie.commoditySpecification.barCode;
						let brand=commoditie.commoditySpecification.commodity.brand;
						if(realnum == null){
							realnum =0;
						}
						let profitOrLossNum=commoditie.profitOrLossNum;
						if(profitOrLossNum == null){
							profitOrLossNum =0;
						}
						let money=commoditie.money;
						if(money == null){
							money =0.0;
						}
						zm_num+=inventorynum;
						sp_num+=realnum;
						yk_num+=profitOrLossNum;
						total_money+=money;
						let goodsTr = "<tr><td>"+
						specificationidentifier+"</td><td>"+
						commodityName+"</td><td>"+
						specificationname+"</td><td>"+
						brand+"</td><td>"+
						barCode+"</td><td>"+
						baseunitname+"</td><td>"+
						inventorynum+"</td><td>"+
						realnum+"</td><td>"+
						profitOrLossNum+"</td><td>"+
						movingaverageprice+"</td><td>"+
						money+"</td><td></td><td></td><td></td></tr>";
						
						$("#look_goods").append(goodsTr);
					 
					 }
					
					$("#look_goods").append('<tr><td>合计</td><td></td><td></td><td></td><td></td><td></td><td>'+zm_num+'</td><td></td><td>'+yk_num+'</td><td></td><td>'+total_money+'</td><td></td><td></td><td></td></tr>');
					$("#look_departmentName").html(data.departmentName);
					$("#look_person").html(data.personName+"("+data.personIdentifier+")");
					$("#look_originator").html(data.originatorName+"("+data.originator+")");
					$("#look_summary").html(data.summary);
					if(data.financeReviewer==null || data.financeReviewer==''){
						$("#look_financeReviewer").html("");
					}else{
						$("#look_financeReviewer").html(data.financeReviewerName+"("+data.financeReviewer+")"); 
					}
					if(data.managerReviewer==null || data.managerReviewer==''){
						$("#look_managerReviewer").html("");
					}else{
						$("#look_managerReviewer").html(data.managerReviewerName+"("+data.managerReviewer+")"); 
					}
					
					
					
					
				}
			}); --%>
			 $("#detailDiv").html("");
				$.ajax({
					type: "get",
					url: "<%=basePath%>warehouse/base/takeStockOrder/takeStockOrderDetail",
					dataType : "json",
					data: {
						"id" : id,
						"orderType":1
					},
					success: function(res) {
						console.log(res)
						let bill = new DetailBill(res);
						let $content = bill.toPrint();
						$("#detailDiv").html($content);
					}
				});
			layer.open({
				type: 1,
				title: "盘点单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#detailDiv"),
				btn: ['关闭']
			});
		}

		

		/*打印*/
		function orderPrint(row) {
			ajaxJquery("GET","<%=basePath%>warehouse/base/takeStockOrder/printTakeStockOrder",{"id":row.id},function(data){
				
				let bill=new Bill(data);
				let $content=bill.toPrint();
				$("#printDiv").html("");
				$("#printDiv").append($content);
				$("#printDiv .container").append(watermark("打印次数："+(row.printNum+1)+"次","#printDiv"));
				$('.watermark>div').fontFlex(80,100,10);
				
			})
			layer.open({
				type: 1,
				title:"打印盘点单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#printDiv"),
				btn: ['打印', '关闭'],
				yes: function(index) {
					$.ajax({
						url :'<%=basePath%>warehouse/base/takeStockOrder/updateTakeStockOrderPrintNum' ,
						type : "POST",
						dataType : "json",
						data: {
							"id" : row.id
						},
						success : function(data) {
							$("#printDiv .container").printArea();
							layer.close(index);
							oTable1.fnDraw(false);
						}
					});
					
				},
				end: function(index, layero) {
					oTable1.fnDraw(false);
					layer.close(index);
					$("#printDiv").html("");
				}
			});

		}
		
		/* 提交时判空 */
		function checkFill(){
			let result1=true;
			$("#editDiv input").each(function(index, val){
				if($(val).val()==""&&result1){
					layfail("实盘数量不能为空")
					result1 = false;
				}		
	    	});
			return result1;
		}
		
		/* 提交或者编辑时 把数据整合成json传入后台 */
    	function takeStockOrderCommodityDataJSON(){
    		var takeStockOrderCommodities=[];
    		//获取盘点商品信息，添加到盘点单的商品信息里
    		$("#goodsTbody .goodsTr").each(function(index, val){
    			var salesOrderCommoditiesDataJSON={
    					"id":$(val).find(".salesOrderCommodityId").html(),
    					"realNum":$(val).find(".realNumber").val(),
    					"profitOrLossNum":$(val).find(".amountNumber").val(),
    					"money":$(val).find(".amountMoney").val()
    				};	
    				
    			takeStockOrderCommodities[index]=salesOrderCommoditiesDataJSON;	
    		});
    			
    		
    		return takeStockOrderCommodities; 
    	}
	</script>

</html>