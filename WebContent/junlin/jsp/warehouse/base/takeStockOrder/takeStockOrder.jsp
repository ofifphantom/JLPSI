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
		<title>财务发起盘点单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>

		<link href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>

		<style type="text/css">
			#allgoodDivEdit .jl-panel {
				position: relative;
			}
			
			#detailDiv,
			#editDiv {
				margin: 50px auto;
			}
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
					<h4 class="text-title">盘点单</h4>
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
									<option value="1">未发送至仓库</option>
									<option value="2">仓库盘点中</option>
									<option value="3">审核中</option>
									<option value="4">审核驳回</option>
									<option value="5">已完成</option>
									<option value="isDelete">已删除</option>
								</select>
							</span>

							<%--<span class="l_f">--%>
								<%--状态：--%>
								<%--<select id="search_type">--%>
									<%--<option value="-1" selected="selected">--请选择--</option>--%>
									<%--<option value="1">未发送至仓库</option>--%>
									<%--<option value="2">仓库盘点中</option>--%>
									<%--<option value="3">待财务审批</option>--%>
									<%--<option value="4">财务审批驳回</option>--%>
									<%--<option value="5">待总经理审批</option>--%>
									<%--<option value="6">总经理审批驳回</option>--%>
									<%--<option value="7">已完成</option>--%>
								<%--</select>--%>
							<%--</span>--%>
							<span class="r_f"> 
								<input type="button" id="btn_search" class="btncss btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">

						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="otherInvoiceAdd()"><i class="fa fa-plus"></i> 新增</button>
						</span>

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

		<div id="editDiv" style="display: none;">
			<form class="container">
			<input type="text" class="form-control hidden" id="edit_takeStockOrderId" />
			<input type="text" class="form-control hidden" id="edit_takeStockOrderIdentifier" />
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div id="headEdit" class="jl-panel">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">仓库</label>
								<div class="col-xs-8">
									<select id="edit_warehouseId" class="form-control warehouse" onchange="onWarehouseChange(this)">
										
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">日期</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="dateOrder" placeholder="请选择日期" readonly="readonly" />
								</div>
							</div>
						</div>
					</div>

				</div>

				<div class="row">
					<div class="jl-title l_f" style="text-align: left;">
						<span>货品</span>
					</div>
					<div class="r_f" style="margin-top:17px">
						<button type="button" class="btncss jl-btn-importent" onclick="goodsAddEdit()">新增</button>
					</div>
					<div class="r_f" style="margin-top:14px">
						<div class="form-group">
							<div >
								<select id="edit_goods" class="form-control" disabled="disabled">
									<option>--请先选择仓库--</option>
								</select>
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
							<th>业务单价</th>
							<th>操作</th>
						</tr>
						<tr class="tipTr">
							<td colspan="7">请先选择商品</td>
						</tr>
					</tbody>
				</table>
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div id="footerEdit" class="jl-panel">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门</label>
								<div class="col-xs-8">
									<select id="edit_departmentId" class="form-control">
										
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员</label>
								<div class="col-xs-8">
									<select id="edit_personId" class="form-control">
										<option value="-1" selected="selected">--请先选择部门--</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input id="edit_summary" class="form-control" type="text" onblur="cky(this)" value="无" />
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
	var oTable1;
	var selectWareHouseGoods=[];//用于存储选中仓库的所有商品；
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
							"page": 1,
							"warehouseId": $("#query_warehouseId").val(),
							"takeStockDate": $("#query_takeStockDate").val(),
							"originator": $("#query_originator").val(),
                            "searchType":$("#search_type").val()
								
						});
					},
					"url": "<%=basePath%>/warehouse/base/takeStockOrder/dataTables"
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
										"mRender": function(data, type, row) {
										    if(row.isDelete==1){
	                                        	 return "已删除";
	                                         }
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
											if(row.isDelete==0){
												if(row.state == 1){
													return '<td><input type="button" class="btncss edit" onclick="takeStockOrderModify('
													+ data
													+')" value="编辑" />'
													+ '<input type="button" class="btncss edit" onclick="takeStockOrderDel('
													+ data
													+ ')" value="删除" />'
													+ '<input type="button" class="btncss edit" onclick="sendTo('
													+ data
													+ ')" value="发送至仓库" /></td>'
												}
												else{
													return '<td><input type="button" class="btncss edit" onclick="takeStockOrderDetail(' + data + ')" value="详情" /></td>'
												}
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
					$("#edit_warehouseId").append("<option value='' selected>--暂无仓库信息，请去添加--</option>");
				}
				else{
					$("#query_warehouseId").append("<option value='' selected>--请选择--</option>");
					$("#edit_warehouseId").append("<option value='-1' selected>--请选择--</option>");
					for(var i=0;i<data.length;i++){							
						var option = $("<option value='"+data[i].id+"' >"
								+data[i].name+"</option>");
						$("#query_warehouseId").append(option);
						
						option = $("<option value='"+data[i].id+"' >"
								+data[i].name+"</option>");
						$("#edit_warehouseId").append(option);
					}
				}
				
				
			}
		});
		/*部门下拉框赋值 */
		$.ajax({
			url :'<%=basePath%>/basic/department/getAllDepartment' ,
			type : "POST",
			dataType : "json",
			data: {},
			success : function(data) {
				$("#edit_departmentId").empty();
				if(data.length==0){
					$("#edit_departmentId").append('<option value="-1" selected="selected">--暂无部门信息，请去添加--</option>');
				}
				else{
					$("#edit_departmentId").append('<option value="-1" selected="selected">--请选择--</option>');
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#edit_departmentId").append(option);			
					}
				}
					
			}
		});
	});
	
		let goodsArr = [];
		$(function() {
			latdate("#query_takeStockDate");
			laydate.render({
				elem: "#dateOrder",
				type: 'date',
				format: 'yyyy-MM-dd',
				min: 0
			});
			

		})
		/*新增*/
		function otherInvoiceAdd() {
			$("#edit_summary").val("无");
			layer.open({
				type: 1,
				title: "新增盘点单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					if(!checkFill())return;
					$.ajax({
						url: '<%=basePath%>warehouse/base/takeStockOrder/addTakeStockOrder',
						type: "POST",
						dataType: "json",
						data:{
							"takeStockOrder":JSON.stringify(takeStockOrderDataJSON())
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
					clearGoods();
					$("#edit_goods").parent().html('<select id="edit_goods" class="form-control" disabled="disabled"><option>--请先选择仓库--</option></select>');
					
					clearSearchableSelect("edit_goods");
					
				}
			});
		}

		/*编辑*/
		function takeStockOrderModify(id) {
			ajaxJquery("GET","<%=basePath%>warehouse/base/takeStockOrder/selectTakeStockOrderDetailById",{"id":id},function(data){
				$("#edit_takeStockOrderId").val(id);
				$("#edit_takeStockOrderIdentifier").val(data.identifier);
				$("#dateOrder").val(getSmpFormatDateByLong(data.takeStockDate,false));
				$("#edit_warehouseId").val(data.warehouseId);
				onWarehouseChange("#edit_warehouseId");
				$("#edit_summary").val(data.summary);
				$("#edit_departmentId").val(data.departmentId);
				person(data.personId);
				$(".tipTr").remove();
				for (var i = 0; i < data.takeStockOrderCommodities.length; i++) {
					let commoditie = data.takeStockOrderCommodities[i];
					let goodsId = commoditie.commoditySpecificationId;
					goodsArr.push(goodsId);
					let commodityName=commoditie.commoditySpecification.commodity.name;
					let specificationidentifier=commoditie.commoditySpecification.specificationIdentifier;
					let specificationname=commoditie.commoditySpecification.specificationName;
					let baseunitname=commoditie.commoditySpecification.baseUnitName;
					let inventorynum=commoditie.inventoryNum;
					let movingaverageprice=commoditie.unitPrice;
					
					$("#goodsTbody").append('<tr class="goodsTr"><td class="commoditySpecificationId" style="display:none">'+goodsId+'</td><td class="specificationidentifier">' + 
							specificationidentifier + '</td><td class="commodityName">' +
							commodityName + '</td><td class="specificationname">' +
							specificationname + '</td><td class="baseunitname">' +
							baseunitname + '</td><td class="inventorynum">' +
							inventorynum + '</td><td class="movingaverageprice">' +
							movingaverageprice + '</td><td>' +
						'<input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
				 
				 }
				
			});
	
			layer.open({
				type: 1,
				title: "编辑盘点单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					if(!checkFill())return;
					$.ajax({
						url: '<%=basePath%>warehouse/base/takeStockOrder/editTakeStockOrder',
						type: "POST",
						dataType: "json",
						data:{
							"takeStockOrder":JSON.stringify(takeStockOrderDataJSON())
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
					clearGoods();
					$("#edit_goods").parent().html('<select id="edit_goods" class="form-control" disabled="disabled"><option>--请先选择仓库--</option></select>');
					clearSearchableSelect("edit_goods");
				}
			});
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

		/*删除*/

		function takeStockOrderDel(id) {
			publicMessageLayer("删除该单据", function() {
				$.ajax({
					url :'<%=basePath%>warehouse/base/takeStockOrder/deleteTakeStockOrder',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"id" : id,
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

		/*发送到仓库*/
		function sendTo(id) {
			publicMessageLayer("将该单据发送至仓库", function() {
				let ids = [id];
				$.ajax({
					url :'<%=basePath%>warehouse/base/takeStockOrder/updateStateByIds',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
						"state" : 2,
						"isCheck" : 0,
						"reviewerType" : 0,
						"msg" : "操作成功！",
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

		/*添加商品*/
		function goodsAddEdit() {
			let goodsId = $("#edit_goods").val();
			
			if($("#edit_warehouseId").val()==-1){
				layfail("请先选择仓库!");
			} else if(goodsId == -1) {
				layfail("请先选择商品!");
			}else if(goodsId == "allGoods") {
				clearGoods();
				$(".tipTr").remove();
				let data=selectWareHouseGoods;
				
				for ( var i = 0; i < data.length; i++) {
					goodsArr.push(data[i].id);
					$("#goodsTbody").append('<tr class="goodsTr"><td class="commoditySpecificationId" style="display:none">'+data[i].id+'</td><td class="specificationidentifier">' + 
							data[i].specificationIdentifier + '</td><td class="commodityName">' +
							data[i].commodity.name + '</td><td class="specificationname">' +
							data[i].specificationName + '</td><td class="baseunitname">' +
							data[i].baseUnitName + '</td><td class="inventorynum">' +
							data[i].inventoryNum + '</td><td class="movingaverageprice">' +
							data[i].movingAveragePrice + '</td><td>' +
						'<input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
					
				}
			
				
			} else if(!checkRepeat(goodsId)) {
				$(".tipTr").remove();
				goodsArr.push(goodsId);
				let commodityName=$("#edit_goods option:selected").attr("data-commodityName");
				let specificationidentifier=$("#edit_goods option:selected").attr("data-specificationidentifier");
				let specificationname=$("#edit_goods option:selected").attr("data-specificationname");
				let baseunitname=$("#edit_goods option:selected").attr("data-baseunitname");
				let inventorynum=$("#edit_goods option:selected").attr("data-inventorynum");
				let movingaverageprice=$("#edit_goods option:selected").attr("data-movingaverageprice");
				
				$("#goodsTbody").append('<tr class="goodsTr"><td class="commoditySpecificationId" style="display:none">'+goodsId+'</td><td class="specificationidentifier">' + 
						specificationidentifier + '</td><td class="commodityName">' +
						commodityName + '</td><td class="specificationname">' +
						specificationname + '</td><td class="baseunitname">' +
						baseunitname + '</td><td class="inventorynum">' +
						inventorynum + '</td><td class="movingaverageprice">' +
						movingaverageprice + '</td><td>' +
					'<input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
			} else {
				layfail("请勿重复选择商品！");
			}
		}

		/*删除商品*/
		function goodsDel(thisbtn) {
			let goodsId = $(thisbtn).parents("tr").find(".commoditySpecificationId").html();
			goodsArr.remove(goodsId);
			$(thisbtn).parents("tr").remove();
			if($("#goodsTbody tr").length == 1) {
				$("#goodsTbody").append('<tr class="tipTr"><td colspan="7">请先选择商品</td></tr>');
			}
		}

		/*查重*/
		function checkRepeat(id) {
			let flag = false;
			for(var i in goodsArr) {
				if(goodsArr[i] == id) {
					flag = true;
				}
			}
			return flag;
		}

		/*清空商品*/
		function clearGoods() {
			$("#goodsTbody").html('<tr><th>货品编码</th><th>货品名称</th><th>货品规格</th><th>货品单位</th><th>账面数量</th><th>业务单价</th><th>操作</th></tr>' +
				'<tr class="tipTr"><td colspan="7">请先选择商品</td></tr>');
			goodsArr = [];
		}
		/* 新增 仓库值改变事件 */
		function onWarehouseChange(thisInput){
			clearGoods();
			if($(thisInput).val()==-1){
				$("#edit_goods").parent().html('<select id="edit_goods" class="form-control" disabled="disabled"><option>--请先选择仓库--</option></select>');
			}else{
				//商品下拉框赋值
				$.ajax({
				url :'<%=basePath%>/basic/goods/commodity/getHasInventoryCommodityByStateAndIsDeleteAndWarehouseId' ,
				type : "POST",
				dataType : "json",
				data: {
					"warehouseId" : $("#edit_warehouseId").val()
				},
				success : function(data) {
					$("#edit_goods").parent().html('<select id="edit_goods" class="form-control" ></select>');
					
					if(data.length==0){
						$("#edit_goods").append('<option value="-1" selected="selected">--该仓库暂无商品，请去添加--</option>');
						selectWareHouseGoods=[];
					}
					else{
						selectWareHouseGoods=data;
						$("#edit_goods").append('<option value="-1" selected="selected">--请选择商品--</option>');
						$("#edit_goods").append(`<option value="allGoods" >全部</option>`);
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].id+"'"
									+ " data-specificationIdentifier='"+data[i].specificationIdentifier+"'"
									+ " data-commodityName='"+data[i].commodity.name+"'"
									+ " data-specificationName='"+data[i].specificationName+"'"
									+ " data-baseUnitName='"+data[i].baseUnitName+"'"
									+ " data-inventoryNum='"+data[i].inventoryNum+"'"
									+ " data-movingAveragePrice='"+data[i].movingAveragePrice+"'"
									+">"
									+data[i].commodity.name + "(" + data[i].specificationName + ")</option>");
							$("#edit_goods").append(option);
							
						}
						$('#edit_goods').searchableSelect();
					}
					
				}
			});
				
			}
		}
		
		/* 新增 部门值改变事件 */
		$("#edit_departmentId").change(function(){
			if($("#edit_departmentId").val()==-1){
				$("#edit_personId").empty();
				$("#edit_personId").append('<option value="-1" selected="selected">--请先选择部门--</option>');
			}
			else{
				person(0);
			}
			
		});
		
		function person(personId){
			/* 业务员下拉框赋值 */
			$.ajax({
				url :'<%=basePath%>/basic/person/getAllPersonByDepartmentIdAndBusiness' ,
				type : "POST",
				dataType : "json",
				data: {
					"departmentId" : $("#edit_departmentId").val()
				},
				success : function(data) {
					$("#edit_personId").empty();
					if(data.length==0){
						$("#edit_personId").append('<option value="-1" selected="selected">--该部门暂无业务员，请去添加--</option>');
					}
					else{
						$("#edit_personId").append('<option value="-1" selected="selected">--请选择--</option>');
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
							$("#edit_personId").append(option);
							
						}
						if(personId>0){
							$("#edit_personId").val(personId);
						}
					}
					
				}
			});
		}
		
		/* 提交时判空 */
		function checkFill(){
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
		/*$("#goodsTbody input").each(function(index, val) {
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
		if(!res) return res;*/
		
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
		/* 提交或者编辑时 把数据整合成json传入后台 */
    	function takeStockOrderDataJSON(){
    		//盘点单基础的信息
    		 var  takeStockOrderDataJSON={
    				"id":$("#edit_takeStockOrderId").val(),
    				"identifier":$("#edit_takeStockOrderIdentifier").val(),
    				"takeStockDateString":$("#dateOrder").val(),
    				"warehouseId":$("#edit_warehouseId").val(),
    				"personId":$("#edit_personId").val(),
    				"summary":$("#edit_summary").val(),
    				"takeStockOrderCommodities":[]
    			   }; 
    		//获取盘点商品信息，添加到盘点单的商品信息里
    		$("#goodsTbody .goodsTr").each(function(index, val){
    			var takeStockOrderCommoditiesDataJSON={
    					"commoditySpecificationId":$(val).find(".commoditySpecificationId").html(),
    					"inventoryNum":$(val).find(".inventorynum").html(),
    					"unitPrice":$(val).find(".movingaverageprice").html()
    				};	
    				
    			takeStockOrderDataJSON.takeStockOrderCommodities[index]=takeStockOrderCommoditiesDataJSON;	
    		});
    			
    		
    		return takeStockOrderDataJSON; 
    	}
	</script>

</html>