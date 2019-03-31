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
<title>销售退货单</title>
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
				<h4 class="text-title">销售退货单</h4>
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
						<span class="l_f"> 
								状态：<select id="query_state" >
									<option value="-1" selected="selected">--请选择--</option>
									<option value="1">未送审</option>
									<option value="2">审核中</option>
									<option value="3">审核通过</option>
									<option value="4">审核驳回</option>
									<option value="5">已退货入库</option>
									<option value="8">已删除</option>
								</select>
						</span>
						<span class="r_f"> <input type="button" id="btn_search"
							class="btncss btn_search" value="搜索" />
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

		<!--新增 编辑 -->
		<div id="editDiv" style="display: none;">
			<form class="container">
			<input type="text" class="form-control hidden" id="edit_salesOrderId" />
			<input type="text" class="form-control hidden" id="edit_salesOrderIdentifier" />
			<input type="text" class="form-control hidden" id="edit_supctoId" />
				<div class="row jl-title">
					<span>引用退货单据</span>

				</div>
				<div id="headEdit" class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">退货单据</label>
								<div class="col-xs-8">
									<select id="checkBillSelect" class="form-control" onchange="billAdd(this)">
									
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户编码</label>
								<div class="col-xs-8">
									<input type="text" id="customerCode" class="form-control" value="请先选择退货单据" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户名称</label>
								<div class="col-xs-8">
									<input type="text" id="customerName" class="form-control" value="请先选择退货单据" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">有效期至</label>
								<div class="col-xs-8">
									<input type="text"   class="form-control" readonly="readonly" id="PeriodValidityTo" value="请先选择退货单据" disabled="disabled"/>
								</div>
							</div>
						</div>
						
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">发货地点</label>
								<div class="col-xs-8">
									<input type="text"  class="form-control" onblur="cky(this)" id="edit_deliverGoodsPlace" value="请先选择退货单据" maxlength="100" disabled="disabled"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">运输方式</label>
								<div class="col-xs-8">
									<select name="" class="form-control" id="edit_transportationMode" value="请先选择退货单据" disabled="disabled">
										
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">收货人</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" onblur="cky(this)" id="edit_consignee" maxlength="100" value="请先选择退货单据" disabled="disabled"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">联系电话</label>
								<div class="col-xs-8">
									<input type="text" disabled="disabled" id="phoneNumber" class="form-control" onblur="cky(this)" value="请先选择退货单据" maxlength="11" />
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">传真</label>
								<div class="col-xs-8">
									<input type="text" id="fax" class="form-control" onblur="cky(this)" id="edit_fax" maxlength="100" disabled="disabled" value="请先选择退货单据"/>
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
						<option value="123" attr-goodsName="date" attr-type="1000" attr-unit="袋" attr-unitPrice="100">44</option>
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
								<th>金额</th>
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
				<div id="footerEdit" class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门</label>
								<div class="col-xs-8">
									<select class="form-control" id="department_id">
										
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员</label>
								<div class="col-xs-8">
									<select class="form-control" id="person_id">
										<option value="-1" selected="selected">--请先选择部门--</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="edit_summary" value="无" onblur="cky(this)" maxlength="100"/>
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="text-danger">注：该页面所有字段均为必填</div>

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
								<label for="" class="col-xs-4 control-label">审核人：</label>
								<div class="col-xs-8"  id="look_reviewer">

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
							"page":15,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": $("#query_supctoId").val(),
							"isSpecimen":0	,
							"createTime": $("#query_time").val(),
							"state": $("#query_state").val()
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
											case 37:
												return "已删除";
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
											switch (row.state) {
											case 27:
												return '<td><input type="button" class="btncss edit" onclick="salesReturnEdit('
												+ data
												+')" value="编辑" />'
												+ '<input type="button" class="btncss edit" onclick="sendTo('
												+ data
												+ ')" value="送审" />'
												+ '<input type="button" class="btncss edit" onclick="salesReturnDel('
												+ data
												+ ')" value="删除" /></td>';
												break;
											case 28:
												return '<td><input type="button" class="btncss edit" onclick="salesReturnDetail('
												+data
												+')" value="详情" /></td>';
												break;
											case 29:
												return '<td><input type="button" class="btncss edit" onclick="salesReturnEdit('
												+ data
												+')" value="编辑" />'
												+ '<input type="button" class="btncss edit" onclick="sendTo('
												+ data
												+ ')" value="送审" />'
												+ '<input type="button" class="btncss edit" onclick="salesReturnDel('
												+ data
												+ ')" value="删除" /></td>';
												break;
											case 30:
												return '<td><input type="button" class="btncss edit" onclick="salesReturnDetail('
												+data
												+')" value="详情" /></td>';
												break;
											case 31:
												return '<td><input type="button" class="btncss edit" onclick="salesReturnDetail('
												+data
												+')" value="详情" /></td>';
												break;
											case 37:
												return '<td><input type="button" class="btncss edit" onclick="salesReturnDetail('
												+data
												+')" value="详情" /></td>';
												break;
											default:
												break;
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
		//销售订单下拉框赋值
		$.ajax({
			url :'<%=basePath%>/sales/salesOrder/getAllSalesOrderCanReturn' ,
			type : "POST",
			dataType : "json",
			data: {},
			success : function(data) {
				$("#checkBillSelect").empty();
				if(data.length==0){
					$("#checkBillSelect").append('<option value="-1" selected="selected">--暂无可退货的销售订单--</option>');
				}
				else{
					$("#checkBillSelect").append('<option value="-1" selected="selected">--请选择--</option>');
					for ( var i = 0; i < data.length; i++) {
						
						if(data[i].breakCode!=null&&data[i].breakCode>0){  
							var option = $("<option  value='"+data[i].id+"' attr-supctoId='"+data[i].supctoId+"' attr-customerName='"
									+data[i].supcto.name+"' \attr-customerCode='"+data[i].supcto.identifier+ 
									+"' attr-endValidityTime='"+getSmpFormatDateByLong(data[i].endValidityTime, false)+"' attr-deliverGoodsPlace='"+data[i].deliverGoodsPlace+"' attr-shippingModeId='"+data[i].shippingModeId+"' attr-consignee='"+data[i].consignee
									+"'  attr-phone='"+data[i].phone+"'  attr-fax='"+data[i].fax+"'>"+ data[i].identifier+"-"+ data[i].breakCode +"</option>")
						}else{
 							var option = $("<option  value='"+data[i].id+"' attr-supctoId='"+data[i].supctoId+"' attr-customerName='"+data[i].supcto.name+"' attr-customerCode='"+data[i].supcto.identifier
									+"' attr-endValidityTime='"+getSmpFormatDateByLong(data[i].endValidityTime, false)+"' attr-deliverGoodsPlace='"+data[i].deliverGoodsPlace+"' attr-shippingModeId='"+data[i].shippingModeId+"' attr-consignee='"+data[i].consignee
									+"'  attr-phone='"+data[i].phone+"'  attr-fax='"+data[i].fax+"'>"+ data[i].identifier +"</option>");
						}
						$("#checkBillSelect").append(option);
						
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
				$("#department_id").empty();
				if(data.length==0){
					$("#department_id").append('<option value="-1" selected="selected">--暂无部门信息，请去添加--</option>');
				}
				else{
					$("#department_id").append('<option value="-1" selected="selected">--请选择--</option>');
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#department_id").append(option);
						
					}
				}
				
			}
		});
		$.ajax({
            url: '<%=basePath%>basic/shippingMode/getAllShippingMode',
            type: "POST",
            dataType: "json",
            async: false,
            cache: false,
            success: function(data) {
                if(data.length==0){
                    $("#edit_transportationMode").append("<option value='-1' selected>--暂无数据，请到运输方式页面进行添加。--</option>");
                }
                else{
                    $("#edit_transportationMode").append("<option value='-1' selected>--请先选择退货单据--</option>");
                    for(var i=0;i<data.length;i++){
                        var option = $("<option value='"+data[i].id+"'>"
                            + data[i].name + "</option>");
                        $("#edit_transportationMode").append(option);
                    }
                }
            }
        });
	});

	$("#department_id").change(function(){
		if($("#department_id").val()==-1){
			$("#person_id").empty();
			$("#person_id").append('<option value="-1" selected="selected">--请先选择部门--</option>');
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
				"departmentId" : $("#department_id").val()
			},
			success : function(data) {
				$("#person_id").empty();
				if(data.length==0){
					$("#person_id").append('<option value="-1" selected="selected">--该部门暂无业务员，请去添加--</option>');
				}
				else{
					$("#person_id").append('<option value="-1" selected="selected">--请选择--</option>');
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#person_id").append(option);
						
					}
					if(personId>0){
						$("#person_id").val(personId);
					}
				}
				
			}
		});
	}
		var goodsArr = [];
		$(function() {

			latdateNoBefore("#PeriodValidityTo");

		})
		/*新增*/
		function salesReturnAdd() {
			billAdd("#checkBillSelect");
			$("#goodsSelect").parent().html('<select id="goodsSelect" disabled="disabled"><option value="-1">--请选择商品--</option></select>');
			
			openLayer("editDiv", "新增销售退货单", function(openLayerIndex) {
				
				if(checkFormFormat()){
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
				}
			})
		}
		/*修改*/
		function salesReturnEdit(id) {
			
			 ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectOrderDetailById",{"id":id},function(data){
				$("#edit_salesOrderId").val(id);
				$("#edit_salesOrderIdentifier").val(data.identifier);
				$("#checkBillSelect").val(data.parentId);
				billAdd("#checkBillSelect");
				$("#PeriodValidityTo").val(getSmpFormatDateByLong(data.endValidityTime, false));
				$("#edit_deliverGoodsPlace").val(data.deliverGoodsPlace);
				$("#edit_transportationMode").val(data.shippingModeId);
				$("#edit_consignee").val(data.consignee);
				$("#phoneNumber").val(data.phone);
				$("#fax").val(data.fax);
				$("#edit_summary").val(data.summary);
				$("#department_id").val(data.personDepartmentId);
				person(data.personId);
				
		 		$(".tipTr").remove();
				for (var i = 0; i < data.salesOrderCommodities.length; i++) {
					let commoditie = data.salesOrderCommodities[i];
					let goodsId = commoditie.commoditySpecificationId;
					goodsArr.push(goodsId);
					let goodsName=commoditie.commoditySpecification.commodity.name;
					let identifier=commoditie.commoditySpecification.specificationIdentifier;
					let type=commoditie.commoditySpecification.specificationName;
					let unit=commoditie.commoditySpecification.baseUnitName;
					let deliverGoodsNum = commoditie.deliverGoodsNum;
					let number=commoditie.returnGoodsNum;
					let unitPrice=commoditie.unitPrice;
					let money=number * unitPrice;
				
					$("#goodsTbody").append('<tr class="goodsTr"><td class="commoditySpecificationId" style="display:none">'+goodsId+'</td><td class="">' + identifier + '</td><td>' + goodsName + '</td><td>' + type +
							'</td><td>' + unit + '</td><td class="deliverGoodsNum">' + deliverGoodsNum + '</td>'+
							'<td><input type="text" class="form-control count" onkeyup="countKeyUp(this)" value="'+number+'" attr-name="退货数量"/></td>' +
							'<td><input type="text" class="form-control unitPrice" onkeyup="unitPriceKeyUp(this)" value="'+unitPrice+'" attr-name="单价"/></td>' +
							'<td><input type="text" class="form-control amountMoney" disabled="disabled" value="'+money+'" /></td>' +
							'<td><input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
					
				 } 
				countTotalAmount();
				
			}); 
			openLayer("editDiv", "修改销售退货单", function(openLayerIndex) {
				if(checkFormFormat()){
					$.ajax({
						url: '<%=basePath%>sales/salesOrder/editReturnOrder',
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
				}
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
					if(data.reviewerIdentifier!=null && data.reviewerName!=null){
						$("#look_reviewer").html(data.reviewerIdentifier+"("+data.reviewerName+")");
					}else{
						$("#look_reviewer").html("");
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
				
				$("#lookDiv").html("");
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
		/*删除*/
		function salesReturnDel(id) {
			publicMessageLayer("删除该销售退货单", function() {
				$.ajax({
					url :'<%=basePath%>sales/salesOrder/deleteReturnOrder',
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
		
		/*送审*/
		function sendTo(id) {
			publicMessageLayer("送审该单据", function() {
				let ids = [id];
				$.ajax({
					url :'<%=basePath%>sales/salesOrder/updateStateByIds',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
						"state" : 28,
						"isCheck" : 0,
						"reviewerType":0,
						"msg" : "操作成功，已送审！",
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

		/*
		 * 选择单据的onchange事件
		 * 该方法用于改变客户编码一级客户名称
		 * */
		function billAdd(thisselect) {
			let $selectedOption = $(thisselect).find("option:selected");
			let customerCode = $selectedOption.attr("attr-customerCode");
			let customerName = $selectedOption.attr("attr-customerName");
			let supctoId = $selectedOption.attr("attr-supctoId");
			let endValidityTime = $selectedOption.attr("attr-endValidityTime");
			let deliverGoodsPlace = $selectedOption.attr("attr-deliverGoodsPlace");
			let shippingModeId = $selectedOption.attr("attr-shippingModeId");
 			let consignee = $selectedOption.attr("attr-consignee");
 			let phone = $selectedOption.attr("attr-phone");
 			let fax = $selectedOption.attr("attr-fax");

          
			
			

			if($(thisselect).val() == "-1") {
				$("#goodsSelect").parent().html('<select id="goodsSelect" disabled="disabled"><option value="-1">--请选择商品--</option></select>');
				$("#PeriodValidityTo").val("请先选择退货单据");
 				$("#edit_deliverGoodsPlace").val("请先选择退货单据");
				$("#edit_transportationMode").val(-1);
				$("#edit_consignee").val("请先选择退货单据");
				$("#phoneNumber").val("请先选择退货单据");
				$("#fax").val("请先选择退货单据");
				$("#customerCode").val("请先选择退货单据");
				$("#customerName").val("请先选择退货单据");
				$("#edit_supctoId").val("请先选择退货单据");
			} else {
				$("#PeriodValidityTo").val(endValidityTime);
				$("#edit_deliverGoodsPlace").val(deliverGoodsPlace);
				$("#edit_transportationMode").val(shippingModeId);
				$("#edit_consignee").val(consignee);
				$("#phoneNumber").val(phone);
				$("#fax").val(fax);
				$("#customerCode").val(customerCode);
				$("#customerName").val(customerName);
				$("#edit_supctoId").val(supctoId);
				$("#goodsSelect").parent().html('<select id="goodsSelect"><option value="-1">--请选择商品--</option></select>');

				 $.ajax({
						url :'<%=basePath%>/sales/salesOrder/getSalesOrderCommodityBySalesOrderId' ,
						type : "POST",
						dataType : "json",
						data: {"salesOrderId":$(thisselect).val()},
						success : function(data) {
//							console.log("data:",data);
							
							$("#goodsSelect").empty();
							if(data.length==0){
								$("#goodsSelect").append('<option value="-1" selected="selected">--暂无可退货的商品--</option>');
							}
							else{
								$("#goodsSelect").append('<option value="-1" selected="selected">--请选择商品--</option>');
							
								for ( var i = 0; i < data.length; i++) {
									
									var option = $("<option  value='"+data[i].commoditySpecification.id+"'"
											+ " data-specificationIdentifier='"+data[i].commoditySpecification.specificationIdentifier+"'"
											+ " data-commodityName='"+data[i].commoditySpecification.commodity.name+"'"
											+ " data-specificationName='"+data[i].commoditySpecification.specificationName+"'"
											+ " data-baseUnitName='"+data[i].commoditySpecification.baseUnitName+"'"
											+ " data-deliverGoodsNum='"+data[i].deliverGoodsNum+"'"
											+">"
											+data[i].commoditySpecification.commodity.name + "(" + data[i].commoditySpecification.specificationName + ")</option>");
									$("#goodsSelect").append(option);
									
								}
							}
							
						}
					});
				//$("#goodsSelect").append('<option value="123" attr-goodsName="date" attr-type="1000" attr-unit="袋" attr-unitPrice="100">44</option>');
			}
			
			clearBill();
			countTotalAmount();
		}

		/*
		 * 该方法用于选择商品的 onclick事件
		 * 用于添加table的退货商品
		 */
		function goodsAdd() {
			/*获取订单相关值*/
			let goodsId = $("#goodsSelect").val();
			let goodsName = $("#goodsSelect option:selected").attr("data-commodityName");
			let type = $("#goodsSelect option:selected").attr("data-specificationName");
			let unit = $("#goodsSelect option:selected").attr("data-baseUnitName");
			let identifier = $("#goodsSelect option:selected").attr("data-specificationIdentifier");
			let deliverGoodsNum = $("#goodsSelect option:selected").attr("data-deliverGoodsNum");
			let unitPrice = 1;

			/*判断并添加到table*/
			if($("#checkBillSelect").val() == "-1") {
				layfail("请先选择退货单据!");
			} else if(goodsId == "-1") {
				layfail("请先选择商品!");
			} else if(!checkRepeat(goodsId, goodsArr)) {
				$("#goodsTbody .tipTr").remove();
				goodsArr.push(goodsId);
				$("#goodsTbody").append('<tr class="goodsTr"><td class="commoditySpecificationId" style="display:none">'+goodsId+'</td><td class="">' + identifier + '</td><td>' + goodsName + '</td><td>' + type +
					'</td><td>' + unit + '</td><td class="deliverGoodsNum">' + deliverGoodsNum + '</td>' +
					'<td><input type="text" class="form-control count" onkeyup="countKeyUp(this)" attr-name="退货数量"/></td>' +
					'<td><input type="text" class="form-control unitPrice" onkeyup="unitPriceKeyUp(this)" attr-name="单价"/></td>' +
					'<td><input type="text" class="form-control amountMoney" disabled="disabled" /></td>' +
					'<td><input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
			} else {
				layfail("请勿重复选择商品！");
			}
		}

		/*
		 * 删除商品
		 */
		function goodsDel(thisbtn) {
			let $tbody = $(thisbtn).parents("tbody");
			let goodsId = $(thisbtn).parents("tr").find(".commoditySpecificationId").html();
			goodsArr.remove(goodsId);
			$(thisbtn).parents("tr").remove();
			if($tbody.find("tr").length == 1) {
				$tbody.append('<tr class="tipTr"><td colspan="9">请先选择商品</td></tr>');
			}
			countTotalAmount();
		}
		/*单价 onkeyup事件*/
		function unitPriceKeyUp(thisInput){
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
			
		}
		
		/*退货数量的 onkeyUp事件*/
		function countKeyUp(thisInput) {
			pressInteger(thisInput);
			let parentTr = $(thisInput).parents("tr");
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
					parentTr.find(".amountMoney").val(((unitPrice-0) * count).toFixed(2));
				}
			} else {
				parentTr.find(".amountMoney").val("");
			}
			countTotalAmount();
		}

		/*计算总金额*/
		function countTotalAmount() {
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
		}else if(!checkFax($("#fax").val())){
			layfail("传真格式不正确！")
			return false;
		}else{
			return true;
		}
		}
		/*清空单据*/
		function clearBill() {
			$("#goodsTbody").html('<tr><th>货品编码</th><th>货品名称</th><th>规格</th><th>单位</th><th>发货数量</th><th>退货数量</th><th>单价</th><th>金额</th><th>操作</th></tr>' +
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
	   				"id":$("#edit_salesOrderId").val(),
	   				"identifier":$("#edit_salesOrderIdentifier").val(),
	   				"parentId":$("#checkBillSelect").val(),
	   				"supctoId":$("#edit_supctoId").val(),
	   				"shippingModeId":$("#edit_transportationMode").val(),
	   				"endValidityTimeString":$("#PeriodValidityTo").val(),
	   				"deliverGoodsPlace":$("#edit_deliverGoodsPlace").val(),
	   				"consignee":$("#edit_consignee").val(),
	   				"phone":$("#phoneNumber").val(),
	   				"fax":$("#fax").val(),
	   				"personId":$("#person_id").val(),
	   				"summary":$("#edit_summary").val(),
	   				"salesOrderCommodities":[]
	   			   }; 
	   		//获取退货商品信息，添加到退货单的商品信息里
	   		$("#goodsTbody .goodsTr").each(function(index, val){
	   			var salesOrderCommoditiesDataJSON={
	   					"commoditySpecificationId":$(val).find(".commoditySpecificationId").html(),
	   					"deliverGoodsNum":$(val).find(".deliverGoodsNum").html(),
	   					"returnGoodsNum":$(val).find(".count").val(),
	   					"unitPrice":$(val).find(".unitPrice").val()
	   				};	
	   				
	   			salesOrderDataJSON.salesOrderCommodities[index]=salesOrderCommoditiesDataJSON;	
	   		});
	    	return salesOrderDataJSON; 
    	}
	</script>

</html>