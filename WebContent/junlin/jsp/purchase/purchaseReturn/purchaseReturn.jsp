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
<title>采购退货</title>
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

<body class="content">
	<div class="page-content clearfix">
		<div id="Member_Ratings">
			<div class="d_Confirm_Order_style" style="margin-top: 10px;">
				<h4 class="text-title">采购退货</h4>
				<div class="search-div clearfix">
					<div class="clearfix">
						<span class="l_f"> 编号： <input type="text" value="" id="query_identifier"
							onblur="cky()" />
						</span> <span class="l_f"> 日期： <input type="text" value=""
							readonly="readonly" id="dateTime" placeholder="请选择日期" />
						</span> <span class="l_f"> 制单人姓名： <input type="text" value=""
							onblur="cky()" id="query_originator"/>
						</span>
						
								<span class="l_f"> 
							状态：<select id="query_state" name="">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">未送审</option>
								<option value="2" >审核中</option>
								<option value="3">审核通过</option>
								<option value="4" >审核驳回</option>
								<option value="8" >已出库</option>
								<option value="isDelete">已删除</option>	
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
						<button type="button" class="btncss jl-btn-defult"
							onclick="purchaseReturnAdd()">
							<i class="fa fa-plus"></i> 新增
						</button>
					</span>

				</div>
				<div class="table_menu_list">
					<table class="table table-striped table-hover col-xs-12"
						id="datatable">
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
								<td><span class="look-span"
									onclick="purchaseReturnDetail()">PO.2017.09.00054</span></td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td><input type="button" class="btncss edit"
									onclick="purchaseReturnEdit()" value="编辑" /> <input
									type="button" class="btncss edit" onclick="purchaseReturnDel()"
									value="删除" /></td>
							</tr> -->
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!--新增 编辑 -->
	<div id="editDiv" style="display: none;">
		<input type="text" class="hidden" id="edit_purchase_id"/>
		<input type="text" class="hidden" id="supplierId" />
		<input type="text" class="hidden" id="edit_identifier" />
		<form class="container">
			<div class="row jl-title">
				<span>引用生成退货单据</span>

			</div>
			<div id="headEdit" class="jl-panel">
				<div class="row">
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">退货单据</label>
							<div class="col-xs-8">
								<select id="checkBillSelect" class="form-control"
									onchange="billAdd(this)">
									<!--<option value="-1">--请选择退货单据--</option>
									<option value="1" attr-supplierName="111">1</option>
									<option value="2" attr-supplierName="144411">2</option>-->
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">单据类型</label>
							<div class="col-xs-8">
								<input type="text" id="billType" class="form-control"
									value="采购退货" disabled="disabled" />
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">供应商名称</label>
							<div class="col-xs-8">
								<input type="text" id="supplierName" class="form-control"
									value="请先选择退货单据" disabled="disabled" />
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="edit_transportationMode" class="col-xs-4 control-label">运输方式</label>
							<div class="col-xs-8">
								<select name="edit_transportationMode" class="form-control" id="edit_transportationMode" disabled>
									
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">送货地址</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_goodsArrivalPlace" onblur="cky(this)" maxlength="100" value="请先选择退货单据" disabled/>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">送货人</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="edit_deliveryman" onblur="cky(this)" maxlength="100" value="请先选择退货单据" disabled/>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">联系电话</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" onblur="cky(this)" maxlength="11"
									id="phoneNumber" value="请先选择退货单据" disabled/>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">传真</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" onblur="cky(this)"
									id="fax" maxlength="100" value="请先选择退货单据" disabled/>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="row jl-title">
				<span>退货单据</span> <i class="r_f">
					<button type="button" class="btncss jl-btn-importent"
						onclick="goodsAdd()">选择商品</button>
				</i> <i class="r_f"> <select id="goodsSelect" disabled="disabled">
						<option value="-1">--请先选择退货单据--</option><!-- 
						<option value="123" attr-goodsName="date" attr-type="1000"
							attr-unit="袋" attr-unitPrice="100" attr-warehouse="冷库">44</option> -->
				</select>
				</i>
			</div>
			<div class="row">
				<table
					class="table table-bordered table-striped table-hover col-xs-12"
					border="" cellspacing="0" cellpadding="0">
					<tbody id="goodsTbody">
						<tr>
							<th>货品编码</th>
							<th>货品名称</th>
							<th>仓库名称</th>
							<th>规格</th>
							<th>单位</th>
							<th>入库数量</th>
							<th>退货数量</th>
							<th>退货单价</th>
							<th>金额</th>
							<th>操作</th>
						</tr>
						<tr class="tipTr">
							<td colspan="10">请先选择商品</td>
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
								<input type="text" class="form-control" name="" id="totalAmount"
									value="" disabled="disabled" />
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
							<label for="" class="col-xs-4 control-label">摘要</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" name="" id="edit_summary" value="无" maxlength="100"
									onblur="cky(this)" />
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="text-danger">注：该页面所有字段（除去摘要）均为必填</div>
		</form>

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

</body>

<script>
	
var order={
	supctoId:-1//用于记录当前选中的供应商
};

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
						"page":16,
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
									       if(row.isDelete==1){
	                                        	 return "已删除";
	                                         }
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
										if(row.isDelete==0){
											if(row.state==1||row.state==4){
												return '<td><input type="button" class="btncss edit"'
												+ 'onclick="purchaseReturnEdit('
												+ data
												+ ')" value="编辑" />'
												+ '<input type="button" class="btncss edit" onclick="purchaseReturnDeliver('
												+ data
												+ ')" value="送审" />'
												+'<input type="button" class="btncss edit" onclick="purchaseReturnDel(' + data + ')" value="删除" /></td>'
											}
											else if(row.state==2){
												return '<td><input type="button" class="btncss edit" disabled value="审核中" /></td>'
											}
											else if(row.state==3){
												return '<td><input type="button" class="btncss edit" disabled value="待出库" /></td>'
											}
											else{
												return '<td><input type="button" class="btncss edit" disabled value="已出库" /></td>'
											}
										}else{
											return '<td><input type="button" class="btncss edit" onclick="purchaseReturnDetail('
											+ row.id
											+ ')" value="详情" /></td>';

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
	var goodsArr = [];
	$(function() {

		latdate("#dateTime");
		getPurchaseTableIndentifier();
		getAllShippingMode();
	})
	
	/* 获取采购退货单可以引用的采购订单信息 */
	function getPurchaseTableIndentifier(){
		ajaxJquery("GET","<%=basePath%>purchase/procuretable/getPurchaseTableToReturnedPurchase",{},function(data){
			$("#checkBillSelect").empty();
			if(data.length==0){
				$("#checkBillSelect").append('<option value="-1" selected="selected">--暂无可引用的采购订单--</option>');
			}
			else{
				$("#checkBillSelect").append('<option value="-1" selected="selected">--请选择--</option>');
				for ( var i = 0; i < data.length; i++) {
					var supctoName="";
					var supctoId="";
					if(data[i].supcto!=null){
						supctoName=data[i].supcto.name;
						supctoId=data[i].supctoId;
					}
					var phone=data[i].phone;
					var fax=data[i].fax;
					
					var option = $("<option  value='"+data[i].id+"' attr-supplierName='"+supctoName+"' attr-supplierId='"+supctoId+"' attr-phone='"+phone+"' attr-fax='"+fax+"' attr-transportationMode='"+data[i].transportationMode+"' attr-goodsArrivalPlace='"+data[i].goodsArrivalPlace+"' attr-deliveryman='"+data[i].deliveryman+"'>"+ data[i].identifier +"</option>");
					$("#checkBillSelect").append(option);
					
				}
			}
		})
	}
	
	/* 获取所有运输方式*/
	function getAllShippingMode(){
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
	}
	
	/*新增*/
	function purchaseReturnAdd() {
		$("#goodsSelect").parent().html('<select id="goodsSelect" disabled="disabled"><option value="-1">--请先选择退货单据--</option></select>');
		$("#billType").val("采购退货");
		openLayer("editDiv", "新增采购退货", function(openLayerIndex) {
			if (checkFormFormat()) {
				ajaxJquery("POST","<%=basePath%>purchase/procuretable/createReturnedPurchase",{"procureTable" : JSON.stringify(procureTableDataToJSON())},function(data){
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
					} else {
						layfail(data.msg);
					}
				})
				layer.close(openLayerIndex);
			}
		})
	}
	
	/*修改*/
	function purchaseReturnEdit(id) {
	
		
		$("#billType").val("采购退货");
		ajaxJquery("POST","<%=basePath%>purchase/procuretable/selectById",{"id" : id},function(data){
			if(data!=null){
				$("#edit_purchase_id").val(data.id);
				$("#supplierId").val(data.supctoId);
				$("#edit_identifier").val(data.identifier);
				$("#checkBillSelect").val(data.parentId);
				if(data.supcto!=null){
					$("#supplierName").val(data.supcto.name);
				}
				else{
					$("#supplierName").val("");
				}
				$("#edit_transportationMode").val(data.transportationMode);
				$("#edit_goodsArrivalPlace").val(data.goodsArrivalPlace);
				$("#edit_deliveryman").val(data.deliveryman);
				$("#phoneNumber").val(data.phone);
				$("#fax").val(data.fax);
				$("#edit_summary").val(data.summary);
				var allMoney=0;
				$("#goodsSelect")
				.parent()
				.html(
						'<select id="goodsSelect"><option value="-1">--请选择商品--</option></select>');			
				/*
				 * 请在此处添加添加商品的select的option
				 */
				ajaxJquery("GET","<%=basePath%>purchase/procuretable/selectById",{"id" : $("#checkBillSelect").val()},function(data){
					
					for(var i=0;i<data.procureCommoditys.length;i++){
						$("#goodsSelect").append('<option value="'+data.procureCommoditys[i].commodityId+'" attr-goodsIdentifier="'+data.procureCommoditys[i].commoditySpecification.specificationIdentifier+'" attr-goodsName="'+data.procureCommoditys[i].commoditySpecification.commodity.name+'" attr-type="'+data.procureCommoditys[i].commoditySpecification.specificationName+'" attr-unit="'+data.procureCommoditys[i].commoditySpecification.baseUnitName+'" attr-warehouse="'+data.procureCommoditys[i].commoditySpecification.specWarehouseName+'"  attr-warehouseId="'+data.procureCommoditys[i].commoditySpecification.specWarehouseId+'" attr-arrivalQuantity="'+data.procureCommoditys[i].arrivalQuantity+'">'+data.procureCommoditys[i].commoditySpecification.commodity.name+'('+data.procureCommoditys[i].commoditySpecification.specificationName+')'+'</option>');
					 }
					
				})
				//商品
				for(var i=0;i<data.procureCommoditys.length;i++){
					$("#goodsTbody .tipTr").remove();
					goodsArr=[];
					goodsArr.push(data.procureCommoditys[i].commodityId);
					$("#goodsTbody")
							.append(
									'<tr class="procureCommodity"><td class="edit_purchase_commodity_id hidden">'+data.procureCommoditys[i].id+'</td><td class="edit_specWarehouseId hidden">'+data.procureCommoditys[i].commoditySpecification.specWarehouseId+'</td>'
											+'<td class="goodsNum hidden">'
											+ data.procureCommoditys[i].commodityId
											+ '</td><td>'
											+ data.procureCommoditys[i].commoditySpecification.specificationIdentifier
											+ '</td><td>'
											+ data.procureCommoditys[i].commoditySpecification.specWarehouseName
											+ '</td><td>'
											+ data.procureCommoditys[i].commoditySpecification.commodity.name
											+ '</td><td>'
											+ data.procureCommoditys[i].commoditySpecification.specificationName
											+ '</td><td>'
											+ data.procureCommoditys[i].commoditySpecification.baseUnitName
											+ '</td><td>'
											+ data.procureCommoditys[i].surplusNum
											+ '</td>'
											+ '<td><input type="text" class="form-control count" onkeyup="countKeyUp(this)" value='+data.procureCommoditys[i].arrivalQuantity+' attr-name="退货数量" /></td>'
											+ '<td><input type="text" class="form-control unitPrice" onkeyup="unitPriceKeyUp(this)" value='+data.procureCommoditys[i].businessUnitPrice+' attr-name="退货单价" /></td>'
											+ '<td><input type="text" class="form-control amountMoney" disabled="disabled" value='+data.procureCommoditys[i].totalPrice+'  attr-name=""/></td>'
											+ '<td><input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
					allMoney+=data.procureCommoditys[i].totalPrice;
					
					//$("#goodsSelect").append('<option value="'+data.procureCommoditys[i].commodityId+'" attr-goodsIdentifier="'+data.procureCommoditys[i].commoditySpecification.specificationIdentifier+'" attr-goodsName="'+data.procureCommoditys[i].commoditySpecification.commodity.name+'" attr-type="'+data.procureCommoditys[i].commoditySpecification.specificationName+'" attr-unit="'+data.procureCommoditys[i].commoditySpecification.baseUnitName+'" attr-warehouse="'+data.procureCommoditys[i].commoditySpecification.specWarehouseName+'">'+data.procureCommoditys[i].commoditySpecification.commodity.name+'('+data.procureCommoditys[i].commoditySpecification.specificationName+')'+'</option>');
				}
				$("#totalAmount").val(allMoney);
			}else{
				laywarn("该订单不存在，请重新加载该页面。");
			}
		})
		openLayer("editDiv", "修改采购退货", function(openLayerIndex) {
			if (checkFormFormat()) {
				procureTableDataToJSON();
				ajaxJquery("POST","<%=basePath%>purchase/procuretable/updateReturnedPurchase",{"procureTable" : JSON.stringify(procureTableDataToJSON())},function(data){
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
					} else {
						layfail(data.msg);
					}
				})
				layer.close(openLayerIndex);
			}
		})

	}

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
			type : 1,
			title : "查看采购退货详情",
			closeBtn : 1,
			area : [ '100%', '100%' ],
			content : $("#detailDiv"),
			btn : [ '关闭' ],
		});
	}
	
	/*送审*/
	function purchaseReturnDeliver(id) {
		publicMessageLayer("送审采购退货单", function() {
			ajaxJquery("POST","<%=basePath%>purchase/procuretable/updateReturnedPurchaseState",{"id" : id,"state":2},function(data){
				if(data.success) {
					laysuccess(data.msg);
					oTable1.fnDraw(false);
				} else {
					layfail(data.msg);
				}
			})
		})

	}
	
	/*删除*/
	function purchaseReturnDel(id) {
		publicMessageLayer("删除采购退货单", function() {
			ajaxJquery("POST","<%=basePath%>purchase/procuretable/deleteReturnedPurchase",{"id" : id},function(data){
				if(data.success) {
					laysuccess(data.msg);
					oTable1.fnDraw(false);
				} else {
					layfail(data.msg);
				}
			})
		})
	}

	/*
	 * 选择单据的onchange事件
	 * 该方法用于改变客户编码一级客户名称
	 * */
	function billAdd(thisselect) {
		let
		$selectedOption = $(thisselect).find("option:selected");
		let supplierId=0;
		if($selectedOption.attr("attr-supplierId")==null||$selectedOption.attr("attr-supplierId")==""){
			supplierId = 0;
		}
		else{
			supplierId = $selectedOption.attr("attr-supplierId");
		}
		
		let supplierName = $selectedOption.attr("attr-supplierName")==null?"":$selectedOption.attr("attr-supplierName");
		let fax = $selectedOption.attr("attr-fax")==null?"":$selectedOption.attr("attr-fax");
		let phone = $selectedOption.attr("attr-phone")==null?"":$selectedOption.attr("attr-phone");
		let transportationMode=$selectedOption.attr("attr-transportationMode")==null?"-1":$selectedOption.attr("attr-transportationMode");
		let goodsArrivalPlace=$selectedOption.attr("attr-goodsArrivalPlace")==null?"":$selectedOption.attr("attr-goodsArrivalPlace");
		let deliveryman=$selectedOption.attr("attr-deliveryman")==null?"":$selectedOption.attr("attr-deliveryman");
		
		
		
		if ($(thisselect).val() == "-1") {
			$("#goodsSelect").parent().html('<select id="goodsSelect" disabled="disabled"><option value="-1">--请先选择退货单据--</option></select>');
			//$("#supplierCode").val(supplierCode);
			$("#supplierName").val("请先选择退货单据");
			$("#supplierId").val("");
			$("#phoneNumber").val("请先选择退货单据");
			$("#fax").val("请先选择退货单据");
			$("#edit_transportationMode").val("-1");
			$("#edit_goodsArrivalPlace").val("请先选择退货单据");
			$("#edit_deliveryman").val("请先选择退货单据");
		} else {
			
			$("#goodsSelect")
					.parent()
					.html(
							'<select id="goodsSelect"><option value="-1">--请选择商品--</option></select>');

			/*
			 * 请在此处添加添加商品的select的option
			 */
			ajaxJquery("GET","<%=basePath%>purchase/procuretable/selectById",{"id" : $(thisselect).val()},function(data){
				
				for(var i=0;i<data.procureCommoditys.length;i++){
					$("#goodsSelect").append('<option value="'+data.procureCommoditys[i].commodityId+'" attr-goodsIdentifier="'+data.procureCommoditys[i].commoditySpecification.specificationIdentifier+'" attr-goodsName="'+data.procureCommoditys[i].commoditySpecification.commodity.name+'" attr-type="'+data.procureCommoditys[i].commoditySpecification.specificationName+'" attr-unit="'+data.procureCommoditys[i].commoditySpecification.baseUnitName+'" attr-warehouse="'+data.procureCommoditys[i].commoditySpecification.specWarehouseName+'"  attr-warehouseId="'+data.procureCommoditys[i].commoditySpecification.specWarehouseId+'" attr-arrivalQuantity="'+data.procureCommoditys[i].arrivalQuantity+'">'+data.procureCommoditys[i].commoditySpecification.commodity.name+'('+data.procureCommoditys[i].commoditySpecification.specificationName+')'+'</option>');
				 }
				
			})
			//$("#supplierCode").val(supplierCode);
			$("#supplierName").val(supplierName);
			$("#supplierId").val(supplierId);
			$("#phoneNumber").val(phone);
			$("#fax").val(fax);
			$("#edit_transportationMode").val(transportationMode);
			$("#edit_goodsArrivalPlace").val(goodsArrivalPlace);
			$("#edit_deliveryman").val(deliveryman);
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
		let
		goodsNum = $("#goodsSelect").val();
		let goodsIdentifier=$("#goodsSelect option:selected").attr("attr-goodsIdentifier");
		let
		goodsName = $("#goodsSelect option:selected").attr("attr-goodsName");
		let
		type = $("#goodsSelect option:selected").attr("attr-type");
		let
		unit = $("#goodsSelect option:selected").attr("attr-unit");
		//let unitPrice = $("#goodsSelect option:selected").attr("attr-unitPrice");
		let
		warehouse = $("#goodsSelect option:selected").attr("attr-warehouse");
		let
		specWarehouseId = $("#goodsSelect option:selected").attr("attr-warehouseId");
		let arrivalQuantity=$("#goodsSelect option:selected").attr("attr-arrivalQuantity")==null?"0":$("#goodsSelect option:selected").attr("attr-arrivalQuantity");
		/*判断并添加到table*/
		if ($("#checkBillSelect").val() == "-1") {
			layfail("请先选择退货单据!");
		} else if (goodsNum == "-1") {
			layfail("请先选择商品!");
		} else if (!checkRepeat(goodsNum, goodsArr)) {
			$("#goodsTbody .tipTr").remove();
			goodsArr.push(goodsNum);
			$("#goodsTbody")
					.append(
							'<tr class="procureCommodity"><td class="edit_purchase_commodity_id hidden"></td><td class="edit_specWarehouseId hidden">'+specWarehouseId+'</td>'
										
									+'<td class="goodsNum hidden">'
									+ goodsNum
									+ '</td><td>'
									+ goodsIdentifier
									+ '</td><td>'
									+ warehouse
									+ '</td><td>'
									+ goodsName
									+ '</td><td>'
									+ type
									+ '</td><td>'
									+ unit
									+ '</td>'
									+'<td class="edit_arrivalQuantity" disabled>'+arrivalQuantity+'</td>'	
									+ '<td><input type="text" class="form-control count" onkeyup="countKeyUp(this)" attr-name="退货数量"/></td>'
									+ '<td><input type="text" class="form-control unitPrice" onkeyup="unitPriceKeyUp(this)" attr-name="退货单价"/></td>'
									+ '<td><input type="text" class="form-control amountMoney" disabled="disabled" /></td>'
									+ '<td><input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
		} else {
			layfail("请勿重复选择商品！");
		}
	}

	/*
	 * 删除商品
	 */
	function goodsDel(thisbtn) {
		let
		$tbody = $(thisbtn).parents("tbody");
		let
		goodsNum = $(thisbtn).parents("tr").find(".goodsNum").html();
		goodsArr.remove(goodsNum);
		$(thisbtn).parents("tr").remove();
		if ($tbody.find("tr").length == 1) {
			$tbody.append('<tr class="tipTr"><td colspan="10">请先选择商品</td></tr>');
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
		var arrivalNN=$(thisInput).parent().prev().html();
		if($(thisInput).val()-0>arrivalNN-0){
			$(thisInput).val("");
			layfail("退货数量不能大于入库数量");
		}
		pressInteger(thisInput);
		let parentTr = $(thisInput).parents("tr");
		if($(thisInput).val() != "") {
			let count = $(thisInput).val() - 0;
			let unitPrice = parentTr.find(".unitPrice").val();
			if(count == 0) {
				layfail("退货数量不能为0！");
				$(thisInput).val("");
				parentTr.find(".amountMoney").val("");
			} else if(count > 0||(count > 0&&unitPrice!="")){
				var orderArrivalQuantity = parentTr.find(".edit_arrivalQuantity").html();

				console.log("edit_arrivalQuantity",orderArrivalQuantity);
				if(orderArrivalQuantity!=""){
					if(count>orderArrivalQuantity-0){
						layfail("退货数量不能大于到货数量！");
						$(thisInput).val("");
						parentTr.find(".amountMoney").val("");
					}
					else{
						parentTr.find(".amountMoney").val((unitPrice-0) * count);
					}
					
				}
				else{
					parentTr.find(".amountMoney").val((unitPrice-0) * count);
				}	
			}
			
		} else {
			parentTr.find(".amountMoney").val("");
		}
		countTotalAmount();
	}

	/*计算总金额*/
	function countTotalAmount() {
		let
		totalAmount = 0;
		$("#goodsTbody .amountMoney").each(function(index, obj) {
			if ($(obj).val() != "") {
				totalAmount += ($(obj).val() - 0);
			}
		})
		$("#totalAmount").val(totalAmount);
	}

	/*创建一个通用的打开新增核销单的layer的方法*/
	function openLayer(layerId, title, callFun) {
		layer.open({
			type : 1,
			title : title,
			closeBtn : 1,
			area : [ '100%', '100%' ],
			content : $("#" + layerId + ""),
			btn : [ '提交', '取消' ],
			yes : function(openLayerIndex) {
				if (checkFormHaveEmpty()) {
					callFun(openLayerIndex);
				}
			},
			end : function(index, layero) {
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
		/* if(!res) return res;
		$("#footerEdit input").each(function(index, val) {
			if($(val).val() == "" && res) {
				checkInputEmptyLayer(val);
				res = false;
			}
		});
		if(!res) return res;
		$("#footerEdit select").each(function(index, val) {
			if($(val).val() == "-1" && res) {
				checkInputEmptyLayer(val);
				res = false;
			}
		}); */
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
	function checkFormFormat() {
		if(!checkMobilePhone($("#phoneNumber").val())) {
			layfail("联系电话格式不正确！")
			return false;
		} else if(!checkFax($("#fax").val())) {
			layfail("传真格式不正确！")
			return false;
		} else {
			return true;
		}
	}
	/*清空单据*/
	function clearBill() {
		$("#goodsTbody")
				.html(
						'<tr><th>货品编码</th><th>仓库名称</th><th>货品名称</th><th>规格</th><th>单位</th><th>入库数量</th><th>退货数量</th><th>退货单价</th><th>金额</th><th>操作</th></tr>'
								+ '<tr class="tipTr"><td colspan="10">请先选择商品</td></tr>');
		goodsArr = [];
	}
	/*单据查重*/
	function checkRepeat(id, goodsArr) {
		let
		flag = false;
		for ( var i in goodsArr) {
			if (goodsArr[i] == id) {
				flag = true;
			}
		}
		return flag;
	}
	
	/* 提交或者编辑时 把数据整合成json传入后台 */
	function procureTableDataToJSON(){
		var supplierId=0;
		if($("#supplierId").val()!=null){
			supplierId=$("#supplierId").val();
		}
		//采购退货基础的信息
		 var  procureTableDataJSON={"id":$("#edit_purchase_id").val(),"identifier":$("#edit_identifier").val(),"transportationMode":$("#edit_transportationMode").val(),"supctoId":supplierId,"deliveryman":$("#edit_deliveryman").val(),
				"fax":$("#fax").val(),"goodsArrivalPlace":$("#edit_goodsArrivalPlace").val(),"phone":$("#phoneNumber").val(),"summary":$("#edit_summary").val(),"parentId":$("#checkBillSelect").val(),
				"procureCommoditys":[]}; 
		//获取采购商品的信息，添加到采购订单的商品信息里
		$("#editDiv .procureCommodity").each(function(index, val){
				
			var procureCommodityDataJSON={"id":$(val).find(".edit_purchase_commodity_id").html(),"commodityId":$(val).find(".goodsNum").html(),"procureTableId":$("#edit_purchase_id").val(),
					"businessUnitPrice":$(val).find(".unitPrice").val(),"arrivalQuantity":$(val).find(".count").val(),"totalPrice":$(val).find(".amountMoney").val(),"specWarehouseId":$(val).find(".edit_specWarehouseId").html()};	
				
			procureTableDataJSON.procureCommoditys[index]=procureCommodityDataJSON;	
			});
			
		console.log("procureTableDataJSON",procureTableDataJSON);
		return procureTableDataJSON; 
	}
</script>
</html>