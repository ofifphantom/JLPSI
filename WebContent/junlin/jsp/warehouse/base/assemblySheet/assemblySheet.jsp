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
		<title>组装单</title>
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
			#dateSearch{
			width:190px;
			}
		</style>

	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">组装单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							仓库： <select class="warehouse" id="search_warehouse">
								<option value="-1">--全部仓库--</option>
							</select>
							</span>
							<span class="l_f"> 
								日期： <input type="text"  value="" id="dateSearch" placeholder="请选择日期" readonly="readonly" />
							</span>
							<span class="l_f"> 
								制单人姓名： <input type="text"  value="" id="search_originator" onblur="cky(this)" />
							</span>
							<span class="l_f">
								状态：
								<select id="search_type">
									<option value="-1" selected="selected">--请选择--</option>
									<option value="1">未送审</option>
									<option value="2">审核中</option>
									<option value="3">审核通过</option>
									<option value="4">审核驳回</option>
									<option value="isDelete">已删除</option>

								</select>
							</span>
							<span class="r_f"> 
								<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">

						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="assemblySheetAdd()"><i class="fa fa-plus"></i> 新增</button>
						</span>

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>单号</th>
									<th>日期</th>
									<th>仓库</th>
									<th>货品名称</th>
									<th>组装数量</th>
									<th>金额</th>
									<th>状态</th>
									<th>制单人</th>
									<th width="15%">操作</th>
								</tr>

							</thead>
							<tbody>
								<!-- <tr>
									<td>
										<span class="look-span" onclick="assemblySheetDetail()">PO.2017.09.00054</span>
									</td>
									<td>冷库</td>
									<td>AAA</td>
									<td>212454878</td>
									<td>212454878</td>
									<td>212454878</td>
									<td>2017.10.02</td>
									<td>
										<input type="button" class="btncss edit" onclick="assemblySheetModify()" value="编辑" />
										<input type="button" class="btncss edit" onclick="assemblySheetDel()" value="删除" />
										<input type="button" class="btncss edit" onclick="sendTo()" value="送审" />
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
			<div class="print-content">

				<form class="container">
					<h3 class="print-title">组装单</h3>
					<div class="row" >
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">单号：</label>
								<div class="col-xs-7" id="look_identifier">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">生成日期：</label>
								<div class="col-xs-7" id="look_package_or_teardown_date">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">仓库：</label>
								<div class="col-xs-7" id="look_warehouse_id">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">货品编码：</label>
								<div class="col-xs-7" id="look_commodity_spec_identifier">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">货品名称：</label>
								<div class="col-xs-7" id="look_commodity_name">
 
								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">规格：</label>
								<div class="col-xs-7" id="look_commodity_spec_name">

								</div>
							</div>
						</div>
						
						<div id="unit_num">
						</div>
						
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">单位：</label>
								<div class="col-xs-7" id="look_commodity_base_unit">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">单价：</label>
								<div class="col-xs-7" id="look_unit_price">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">组装数量：</label>
								<div class="col-xs-7" id="look_package_or_teardown_num">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">金额：</label>
								<div class="col-xs-7" id="look_total_money">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">批号：</label>
								<div class="col-xs-7">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">到期日：</label>
								<div class="col-xs-7">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">生产日期：</label>
								<div class="col-xs-7">

								</div>
							</div>
						</div>
					</div>
					<div id="allgoodDivDetail">
						<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
							<tbody>
								<tr>
									<th>货品编码</th>
									<th>货品名称</th>
									<th>规格</th>
									<th>品牌</th>
									<th>条形码</th>
									<th>单位</th>
									<th>数量</th>
									<th>单价</th>
									<th>金额</th>
									<th>产品批号</th>
									<th>生产日期</th>
									<th>有效期至</th>
								</tr>
								<!--<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>-->
							</tbody>
						</table>

					</div>
					<div class="row">
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">部门：</label>
								<div class="col-xs-7" id="department_name">

								</div>
							</div>
						</div>
						<!--<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">业务员：</label>
								<div class="col-xs-7">

								</div>
							</div>
						</div>-->
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">制单人：</label>
								<div class="col-xs-7" id="look_originator">

								</div>
							</div>
						</div>
					
						
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">审核人：</label>
								<div class="col-xs-7" id="look_reviewer">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">摘要：</label>
								<div class="col-xs-7" id="look_summary">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">分支机构：</label>
								<div class="col-xs-7" id="look_summary">
								总部
								</div>
							</div>
						</div>
					</div>
				</form>

			</div>
		</div>
		<!-- 新增或编辑 -->
		<div id="editDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>组装商品信息</span>
				</div>
				<div id="headEdit" class="jl-panel">
					<div class="row">	
					<input type="text" class="hidden" value="" id="packageOrTeardownOrderId" />
						<div class="col-xs-6 hidden" id="identifier_div">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单据编号</label>
								<div class="col-xs-8">
									<input type="text" class="form-control hidden" id="poo_identifier" placeholder="请先选择货品" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6 hidden" id="date_div">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单据生成日期</label>
								<div class="col-xs-8">
									<input type="text" class="form-control hidden" id="package_or_teardown_date" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group" id="edit_goodDiv">
								<label for="" class="col-xs-4 control-label">货品名称</label>
								<div class="col-xs-8">
									<select class="form-control" id="edit_giftBox">
										<option value="-1">--请选择货品--</option>
										<option value="A">A货品</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">货品编码</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="commodity_spec_identifier" placeholder="请先选择货品" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">规格</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="commodity_spec_name" placeholder="请先选择货品" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单位</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="unit_name" placeholder="请先选择货品" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单价</label>
								<div class="col-xs-8">
									<input type="text" id="unitPrice" class="form-control" placeholder="请先选择货品" disabled="disabled" value="10" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">组装数量</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="package_or_teardown_num" onkeyup="countMoney(this)" maxlength="9"/>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">金额</label>
								<div class="col-xs-8">
									<input type="text" id="amountMoney" class="form-control" placeholder="请先填写组装数量" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">仓库</label>
								<div class="col-xs-8">
									<select class="form-control" id="ware_house_id">
									<!--	<option value="-1">--请选择仓库--</option>
										<option value="A">A仓库</option>-->
									</select>
								</div>
							</div>
						</div>
					</div>

				</div>

				<div class="row">
					<div class="jl-title l_f" style="text-align: left;">
						<span>货品</span>
					</div>
					<div class="r_f">
						<button type="button" class="btncss jl-btn-importent" onclick="goodsAddEdit()">新增</button>
					</div>
					<div class="r_f">
						<div class="form-group" id="edit_goodDiv"> 
							<div class="col-xs-8">
								<select id="edit_goods" class="form-control">
									<!--<option value="-1">--请选择货品--</option>
									<option value="44" attr-name="name" attr-type="type" attr-unit="unit" attr-price="10">44</option>
									<option value="11" attr-name="name" attr-type="type" attr-unit="unit" attr-price="10">11</option>
									<option value="33" attr-name="name" attr-type="type" attr-unit="unit" attr-price="10">33</option>-->
								</select>
							</div>
						</div>
					</div>

				</div>
				<table class="table table-bordered table-striped table-hover col-xs-12" border="" id="package_or_teardown_order_commodity" cellspacing="0" cellpadding="0">
					<tbody id="goodsTbody">
						<tr>
							<th>货品编码</th>
							<th>货品名称</th>
							<th>规格</th>
							<th>单位</th>
							<th>数量</th>
							<th>单价</th>
							<th>金额</th>
							<th>操作</th>
						</tr>
						<tr class="tipTr">
							<td colspan="8">请先选择商品</td>
						</tr>
					</tbody>
				</table>
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div id="footerEdit" class="jl-panel">
					<div class="row">
						<!-- <div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门</label>
								<div class="col-xs-8">
									<select class="form-control">
										<option value="-1">--请选择部门--</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员</label>
								<div class="col-xs-8">
									<select class="form-control">
										<option value="-1">--请选择业务员--</option>
									</select>
								</div>
							</div>
						</div> -->
						<!-- <div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">制单人</label>
								<div class="col-xs-8">
									<input class="form-control" type="text" onblur="cky(this)" />
								</div>
							</div>
						</div> -->
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input class="form-control" id="summary" type="text" onblur="cky(this)" value="无" />
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
	$("#btn_search").click(function() {
		
		oTable1.fnDraw();
	});
	var oTable1;
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
							"page":1,
							"orderType":1,
							"searchWarehouse":$("#search_warehouse").val(),
							"dateSearch":$("#dateSearch").val(),
							"searchOriginator":$("#search_originator").val(),
                            "searchType":$("#search_type").val()
								
						});
					},
					"url": "<%=basePath%>warehouse/packageOrTeardownOrder/getDataTablesMsg"
							},

							"aoColumns" : [
									
									{
										"mData" : "identifier",
										"bSortable" : false,
										"sWidth" : "12%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return '<td><span class="look-span" onclick="assemblySheetDetail('
													+ row.id
													+ ')">'
													+ data
													+ '</span></td>';
										}
									},
									{
										"mData" : "packageOrTeardownDate",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return getSmpFormatDateByLong(data, true);
										}

									},
									{
										"mData" : "warehouseId",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return row.warehouseName;
										}
									},
									{
										"mData" : "commoditySpecificationId",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return row.commodityName+"("+row.commoditySpecName+")"
										}

									},
									{
										"mData" : "packageOrTeardownNum",
										"bSortable" : false,
										"sWidth" : "8%",
										"sClass" : "center"

									},
									{
										"mData" : "totalMoney",
										"bSortable" : false,
										"sWidth" : "8%",
										"sClass" : "center"

									},
									{
										"mData" : "state",
										"bSortable" : false,
										"sWidth" : "5%",
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
											default:
												break;
											}
										}

									},
									{
										"mData" : "originator",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											if(row.originatorName!=null){
												return data+"("+row.originatorName+")";
											}
											else{
												return data;
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
													return '<td><input type="button" class="btncss edit" onclick="assemblySheetModify('+data+')" value="编辑" />'
													+'<input type="button" class="btncss edit" onclick=\'assemblySheetDel('+JSON.stringify(row)+')\' value="删除" />'
													+'<input type="button" class="btncss edit" onclick=\'sendTo('+JSON.stringify(row)+')\' value="送审" /></td>'
												}
												else if(row.state==2){
													return '<td><input type="button" class="btncss edit" disabled value="审核中" /></td>'
												}
												else{
													return '<td><input type="button" class="btncss edit" disabled value="审批通过" /></td>'
												}
											}else{
												return '<input type="button" class="btncss edit" onclick=\'assemblySheetDetail('+row.id+')\' value="详情" /></td>'
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
		getAllCommodity();
		getHasInventoryCommodity();
	});
	
	laydate.render({
        elem: "#dateSearch",
        range:'~'
    });
	/* 查询仓库信息 */
	$(function(){
		/*请通过ajax获得仓库数据[{ "id": 123, "name": "A仓库" }]*/	
		ajaxJquery("GET","<%=basePath%>basic/warehouse/selectAllWarehouse",{},function(data){
			$("#ware_house_id").html("")
            $("#ware_house_id").html("<select class='form-control'></select>")
            $("#search_warehouse").html("")
            $("#search_warehouse").html("<select class='form-control'></select>")
            if(data.length==0){
                $("#ware_house_id").append("<option value='-1' selected>--暂无数据，请到仓库页面进行添加。--</option>");
                $("#search_warehouse").append("<option value='-1' selected>--暂无数据，请到仓库页面进行添加。--</option>");
            }
            else{
                $("#ware_house_id").append("<option value='-1' selected>--请选择仓库--</option>");
                $("#search_warehouse").append("<option value='-1' selected>--请选择仓库--</option>");
                for(var i=0;i<data.length;i++){
                    var option = $("<option value='"+data[i].id+"'>" + data[i].name+"</option>");
                    $("#ware_house_id").append(option);
                    option = $("<option value='"+data[i].id+"'>" + data[i].name+"</option>");
                    $("#search_warehouse").append(option);
                }

            }
		})
	})
	
	/* 获取商品信息   供选择要组装成的商品信息*/
	function getAllCommodity(){
		allCommodityMsgList=[];
        $.ajax({
            url: '<%=basePath%>basic/goods/commodity/getAllCommodityByStateAndIsDeleteBySupctoId',
            type: "POST",
            dataType: "json",
            async: false,
            cache: false,
            data:{
            	"supctoId":0
            },
            success: function(data) {
				$("#edit_giftBox").html("")
                $("#edit_giftBox").html("<select class='form-control'></select>")
                if(data.length==0){
                    $("#edit_giftBox").append("<option value='-1' selected>--暂无数据，请到商品页面进行添加。--</option>");
                }
                else{
                    $("#edit_giftBox").append("<option value='-1' selected>--请选择商品--</option>");
                    for(var i=0;i<data.length;i++){
                        var option = $("<option value='"+data[i].id+"' attr-identifier='"+data[i].specificationIdentifier+"' attr-specname='"+data[i].specificationName+"' attr-baseunit='"+data[i].baseUnitName+"' attr-unitprice='"+data[i].baseMiniPrice+"' attr-warehouse='"+data[i].specWarehouseId+"'>"
                            + data[i].commodity.name+" "+data[i].specificationName + "</option>");
                        $("#edit_giftBox").append(option);
                    }

                }
            }
        });
    }
	
	/* 获取有库存的商品信息   供选择组装商品信息*/
	function getHasInventoryCommodity(){
        $.ajax({
            url: '<%=basePath%>basic/goods/commodity/getHasInventoryCommodityByStateAndIsDeleteBySupctoId',
            type: "POST",
            dataType: "json",
            async: false,
            cache: false,
            data:{
            },
            success: function(data) {   
				$("#edit_goods").html("")
                $("#edit_goods").html("<select class='form-control'></select>")
                if(data.length==0){
                    $("#edit_goods").append("<option value='-1' selected>--暂无数据，请到商品页面进行添加。--</option>");
                }
                else{
                    $("#edit_goods").append("<option value='-1' selected>--请选择商品--</option>");
                    for(var i=0;i<data.length;i++){
                    	let price=0;
                    	if(data[i].movingAveragePrice==null||data[i].movingAveragePrice<=0){
                    		price=data[i].baseMiniPrice;
                    	}
                    	else{
                    		price=data[i].movingAveragePrice;
                    	}
                        var option = $("<option value='"+data[i].id+"' attr-identifier='"+data[i].specificationIdentifier+"' attr-name='"+data[i].commodity.name+"' attr-type='"+data[i].specificationName+"' attr-unit='"+data[i].baseUnitName+"' attr-price='"+price+"' attr-specWarehouseId='"+data[i].specWarehouseId+"'>"
                            + data[i].commodity.name+" "+data[i].specificationName + "</option>");
                        $("#edit_goods").append(option);
                    }

                }
            }
        });
    }
	
	let isHasWarehouse=false;//保存之前是否有仓库
	/* 商品选择框的值改变事件 */
	function selectCommodityMsg(e,selectValId){	
		
		var selectId =e.element.attr("id");
		if(selectId=="edit_giftBox"){
			clearGoods();
			if(selectValId!=-1){
				$("#commodity_spec_identifier").val($("#edit_giftBox option:selected").attr("attr-identifier"));
				$("#commodity_spec_name").val($("#edit_giftBox option:selected").attr("attr-specname"));
				$("#unit_name").val($("#edit_giftBox option:selected").attr("attr-baseunit"));
				$("#unitPrice").val($("#edit_giftBox option:selected").attr("attr-unitprice"));
				$("#package_or_teardown_num").val("");
				$("#amountMoney").val("");
				if($("#edit_giftBox option:selected").attr("attr-warehouse")!=null&&$("#edit_giftBox option:selected").attr("attr-warehouse")>0){
					$("#ware_house_id").val($("#edit_giftBox option:selected").attr("attr-warehouse"));
					$("#ware_house_id").attr("disabled","disabled");
					isHasWarehouse=true;
				}
				else{
					$("#ware_house_id").val("-1");
					$("#ware_house_id").removeAttr("disabled");
					isHasWarehouse=false;
				}
			}
			else{
				$("#commodity_spec_identifier").val("");
				$("#commodity_spec_name").val("");
				$("#unit_name").val("");
				$("#unitPrice").val("");
				$("#package_or_teardown_num").val("");
				$("#amountMoney").val("");
				$("#ware_house_id").val("-1");
				$("#ware_house_id").removeAttr("disabled");
				isHasWarehouse=false;
			}
		}
			
	}
	
	
		let goodsArr = [];
		$(function() {
			latdate("#dateSearch");

			$('#edit_goods').searchableSelect();
			$('#edit_giftBox').searchableSelect();

		})
		/*新增*/
		function assemblySheetAdd() {
			$("#summary").val("无");
			$("#package_or_teardown_date").addClass("hidden");
			$("#poo_identifier").addClass("hidden");
			$("#date_div").addClass("hidden");
			$("#identifier_div").addClass("hidden");
			layer.open({
				type: 1,
				title: "新增组装单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					if(!decideInputAndSelectHasValue())return;
					packageOrTeardownOrderCommodityMsg();
					ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/decideCommodtyInventory",{"ids":ids,"commodityNums":commodityNums,"orderType":1},function(data){
						if(data.success){
							ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/createOrder",{"orderType":1,"isHasWarehouse":isHasWarehouse,"PackageOrTeardownOrder":JSON.stringify(packageOrTeardownOrderDataToJSON())},function(data){
								if(data.success) {
									laysuccess(data.msg);
									oTable1.fnDraw(false);
									$("#checkAll").removeAttr("checked");
								} else {
									layfail(data.msg);
								}
								layer.close(index);
							})
						}
						else{
							layfail(data.msg);
						}
					})
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "");
					clearGoods();
					clearSearchableSelect("edit_goods");
					clearSearchableSelect("edit_giftBox");
					
				}
			});
		}

		/*编辑*/
		function assemblySheetModify(id) {
			ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/getPackageOrTeardownOrderDetailById",{"id":id},function(data){
				if(data!=null){
					//console.log("data",data);
					$("#ware_house_id").attr("disabled","disabled")
					$("#packageOrTeardownOrderId").val(data.id);
					$("#package_or_teardown_date").val(getSmpFormatDateByLong(data.packageOrTeardownDate, true));
					$("#poo_identifier").val(data.identifier);
					$("#package_or_teardown_date").removeClass("hidden");
					$("#poo_identifier").removeClass("hidden");
					$("#date_div").removeClass("hidden");
					$("#identifier_div").removeClass("hidden");
					SearchableSelectsetValue("#edit_giftBox",data.commoditySpecificationId);
					$("#ware_house_id").val(data.warehouseId);
					$("#commodity_spec_identifier").val(data.commoditySpecIdentifier);
					$("#commodity_spec_name").val(data.commoditySpecName);
					$("#unit_name").val(data.baseUnit);
					$("#unitPrice").val(data.unitPrice);
					$("#package_or_teardown_num").val(data.packageOrTeardownNum);
					$("#amountMoney").val(data.totalMoney);
					$("#summary").val(data.summary);
					goodsArr=[];
					if(data.packageOrTeardownOrderCommodities.length>0){
						for(var i=0;i<data.packageOrTeardownOrderCommodities.length;i++){
							goodsArr.push(data.packageOrTeardownOrderCommodities[i].commoditySpecificationId+"");
							$(".tipTr").remove();
							//console.log("goodsArr",goodsArr);
							$("#goodsTbody").append('<tr class="package_or_teardown_order_commodity_tr"><td class="poocId hidden">'+data.packageOrTeardownOrderCommodities[i].id+'</td><td class="goodsId hidden">' + data.packageOrTeardownOrderCommodities[i].commoditySpecificationId + '</td><td class="specWarehouseId hidden">' + data.packageOrTeardownOrderCommodities[i].specWarehouseId + '</td>'+
								'<td class="identifier">' + data.packageOrTeardownOrderCommodities[i].poocCommoditySpecIdentifier + '</td><td>' + data.packageOrTeardownOrderCommodities[i].poocCommName + '</td><td>' + data.packageOrTeardownOrderCommodities[i].poocSpecName + '</td><td>' + data.packageOrTeardownOrderCommodities[i].poocBaseUnit + '</td>' +
								'<td><input type="text" class="form-control number" onkeyup="countGoodsMoney(this)" value="'+data.packageOrTeardownOrderCommodities[i].number+'" maxlength="9" attr-name="数量"/></td><td class="goodsUnitPrice">' + data.packageOrTeardownOrderCommodities[i].unitPrice + '</td>' +
								'<td><input type="text" class="goodsAllPrice form-control" placeholder="请先填写数量" disabled="disabled" value="'+data.packageOrTeardownOrderCommodities[i].money+'"/></td>' +
								'<td><input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
						}
					}
				}
			})
			
			layer.open({
				type: 1,
				title: "编辑组装单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					if(!decideInputAndSelectHasValue())return;
					packageOrTeardownOrderCommodityMsg();
					ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/decideCommodtyInventory",{"ids":ids,"commodityNums":commodityNums,"orderType":1},function(data){
						if(data.success){
							ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/updateOrder",{"orderType":1,"PackageOrTeardownOrder":JSON.stringify(packageOrTeardownOrderDataToJSON())},function(data){
								if(data.success) {
									laysuccess(data.msg);
									oTable1.fnDraw(false);
									$("#checkAll").removeAttr("checked");
								} else {
									layfail(data.msg);
								}
								layer.close(index);
							})
						}
						else{
							layfail(data.msg);
						}
					})
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "");
					clearGoods();
					
					$("#ware_house_id").attr("disabled",false);
					
					clearSearchableSelect("edit_goods");
					clearSearchableSelect("edit_giftBox");
				}
			});
		}

		/*详情*/
		function assemblySheetDetail(id) {
			<%-- $("#unit_num").html("");
			ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/getPackageOrTeardownOrderDetailById",{"id":id},function(data){
				if(data!=null){
					
					$("#look_identifier").html(data.identifier);
					$("#look_package_or_teardown_date").html(getSmpFormatDateByLong(data.packageOrTeardownDate, true));
					$("#look_warehouse_id").html(data.warehouseName);
					$("#look_commodity_spec_identifier").html(data.commoditySpecIdentifier);
					$("#look_commodity_name").html(data.commodityName);
					$("#look_commodity_spec_name").html(data.commoditySpecName);
					$("#look_commodity_base_unit").html(data.baseUnit);
					$("#look_unit_price").html(data.unitPrice);
					$("#look_package_or_teardown_num").html(data.packageOrTeardownNum);
					$("#look_total_money").html(data.totalMoney);
					$("#department_name").html(data.departmentName);
					if(data.originator!=null){
						if(data.originatorName!=null){
							$("#look_originator").html(data.originator+"("+data.originatorName+")");
						}
						else{
							$("#look_originator").html(data.originator);
						}
					}
					else{
						$("#look_originator").html("");
					}
					
					if(data.reviewer!=null){
						if(data.reviewerName!=null){
							$("#look_reviewer").html(data.reviewer+"("+data.reviewerName+")");
						}
						else{
							$("#look_reviewer").html(data.reviewer);
						}
					}
					else{
						$("#look_reviewer").html("");
					}
					var total_num=0;
					var total_money=0.0;
					$("#look_summary").html(data.summary);
					$("#allgoodDivDetail table tbody").html("<tr><th>货品编码</th><th>货品名称</th><th>规格</th><th>品牌</th><th>条形码</th><th>单位</th><th>数量</th><th>单价</th><th>金额</th><th>产品批号</th><th>生产日期</th><th>有效期至</th></tr>");
					if(data.packageOrTeardownOrderCommodities.length>0){
						for(var i=0,j=1;i<data.packageOrTeardownOrderCommodities.length;i++,j++){
							total_num+=data.packageOrTeardownOrderCommodities[i].number;
							total_money+=data.packageOrTeardownOrderCommodities[i].money;
							
							$("#unit_num").append('<div class="col-xs-4"><div class="form-group"><label for="" class="col-xs-5 control-label">数量/单位'+j+'：</label><div class="col-xs-7" id="look_commodity_spec_name">'+data.packageOrTeardownOrderCommodities[i].number+' '+data.packageOrTeardownOrderCommodities[i].poocBaseUnit+'</div></div></div><div>')
							$("#allgoodDivDetail table tbody").append("<tr><td>"+data.packageOrTeardownOrderCommodities[i].poocCommoditySpecIdentifier+"</td><td>"+data.packageOrTeardownOrderCommodities[i].poocCommName+"</td>"
									+"<td>"+data.packageOrTeardownOrderCommodities[i].poocSpecName+"</td><td>"+data.packageOrTeardownOrderCommodities[i].commoditySpecification.commodity.brand+"</td><td>"+data.packageOrTeardownOrderCommodities[i].commoditySpecification.barCode+"</td><td>"+data.packageOrTeardownOrderCommodities[i].poocBaseUnit+"</td><td>"+data.packageOrTeardownOrderCommodities[i].number+"</td>"
									+"<td>"+data.packageOrTeardownOrderCommodities[i].unitPrice+"</td><td>"+data.packageOrTeardownOrderCommodities[i].money+"</td><td></td><td></td><td></td></tr>");
						}
					}
					$("#allgoodDivDetail table tbody").append('<tr><td>合计</td><td></td><td></td><td></td><td></td><td></td><td>'+total_num+'</td><td></td><td>'+total_money+'</td><td></td><td></td><td></td></tr>');
					
				}
			}) --%>
			$("#detailDiv").html("");
			$.ajax({
				type: "get",
				url: "<%=basePath%>warehouse/packageOrTeardownOrder/getPackageOrTeardownOrderDetailByIdToJson",
				dataType : "json",
				data: {
					"id" : id,
					"orderType":1
				},
				success: function(res) {
					//console.log(res)
					let bill = new DetailBill(res);
					let $content = bill.toPrint();
					$("#detailDiv").html($content);
				}
			});
			layer.open({
				type: 1,
				title: "组装单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#detailDiv"),
				btn: ['关闭']
			});
		}
		

		function assemblySheetDel(row) {
			publicMessageLayer("删除所选单据", function() {
				ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/deleteOrderById",{"orderId":row.id,"orderIdentifier":row.identifier,"orderType":1},function(data){
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").removeAttr("checked");
					} else {
						layfail(data.msg);
					}
					layer.close(index);
				})
				
			})
		}

		/*送审*/
		function sendTo(row) {
			publicMessageLayer("送审", function() {
				ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/updateOrderState",{"orderId":row.id,"orderIdentifier":row.identifier,"state":2,"orderType":1},function(data){
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").removeAttr("checked");
					} else {
						layfail(data.msg);
					}
					layer.close(index);
				})
			})
		}

		/*添加商品*/
		function goodsAddEdit() {
			let goodsId = $("#edit_goods").val();
			let identifier = $("#edit_goods option:selected").attr("attr-identifier");
			let name = $("#edit_goods option:selected").attr("attr-name");
			let type = $("#edit_goods option:selected").attr("attr-type");
			let unit = $("#edit_goods option:selected").attr("attr-unit");
			let price = $("#edit_goods option:selected").attr("attr-price");
			let warehouseId = $("#edit_goods option:selected").attr("attr-specWarehouseId");
			if(goodsId == -1) {
				layfail("请先选择商品!");
			} else if(!checkRepeat(goodsId)) {
				$(".tipTr").remove();
				goodsArr.push(goodsId);
				$("#goodsTbody").append('<tr class="package_or_teardown_order_commodity_tr"><td class="poocId hidden"></td><td class="goodsId hidden">' + goodsId + '</td><td class="specWarehouseId hidden">' + warehouseId + '</td>'+
					'<td class="identifier">' + identifier + '</td><td>' + name + '</td><td>' + type + '</td><td>' + unit + '</td>' +
					'<td><input type="text" class="form-control number" onkeyup="countGoodsMoney(this)" maxlength="9" attr-name="数量"/></td><td class="goodsUnitPrice">' + price + '</td>' +
					'<td><input type="text" class="goodsAllPrice form-control" placeholder="请先填写数量" disabled="disabled"/></td>' +
					'<td><input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
			} else {
				layfail("请勿重复选择商品！");
			}
		}

		/*删除商品*/
		function goodsDel(thisbtn) {
			let goodsId = $(thisbtn).parents("tr").find(".goodsId").html();
			goodsArr.remove(goodsId);
			$(thisbtn).parents("tr").remove();
			if($("#goodsTbody tr").length == 1) {
				$("#goodsTbody").append('<tr class="tipTr"><td colspan="8">请先选择商品</td></tr>');
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
			$("#goodsTbody").html('<tr><th>货品编码</th><th>货品名称</th><th>规格</th><th>单位</th><th>数量</th><th>单价</th><th>金额</th><th>操作</th></tr>' +
				'<tr class="tipTr"><td colspan="8">请先选择商品</td></tr>');
			goodsArr = [];
		}

		/*计算总金额*/
		function countMoney(thisInput) {
			
			if(isnotEmpty($(thisInput).val())){
				pressInteger(thisInput);
				$("#amountMoney").val(($("#unitPrice").val() - 0) * ($(thisInput).val() - 0));
			}else{
				$("#amountMoney").val("");
			}
			
		}

		/*计算商品金额*/
		function countGoodsMoney(thisInput) {
			if(isnotEmpty($(thisInput).val())){
				pressInteger(thisInput);
				let count = $(thisInput).val();
				let unitPrice = $(thisInput).parents("tr").find(".goodsUnitPrice").html();
				$(thisInput).parents("tr").find(".goodsAllPrice").val((count * unitPrice).toFixed(2));
			}else{
				$(thisInput).parents("tr").find(".goodsAllPrice").val("");
			}
		}
		
		/* 编辑时判断数据有没有填写完整 */
		function decideInputAndSelectHasValue(){
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
			if($(val).val() == "" && (!$(val).hasClass("searchable-select-input"))&& (!$(val).hasClass("hidden")) && res) {
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
		function packageOrTeardownOrderDataToJSON(){
			
			//采购订单基础的信息
			 var  packageOrTeardownOrderDataJSON={"id":$("#packageOrTeardownOrderId").val(),"identifier":$("#poo_identifier").val(),"warehouseId":$("#ware_house_id").val(),"commoditySpecificationId":$("#edit_giftBox").val(),
					"packageOrTeardownNum":$("#package_or_teardown_num").val(),"unitPrice":$("#unitPrice").val(),"totalMoney":$("#amountMoney").val(),"summary":$("#summary").val(),
					"packageOrTeardownOrderCommodities":[]}; 
			//获取采购商品的信息，添加到采购订单的商品信息里
			$(".package_or_teardown_order_commodity_tr").each(function(index, val){
					
				var packageOrTeardownOrderCommodityDataJSON={"id":$(val).find(".poocId").html(),"packageOrTeardownOrderId":$("#packageOrTeardownOrderId").val(),"commoditySpecificationId":$(val).find(".goodsId").html(),
						"number":$(val).find(".number").val(),"unitPrice":$(val).find(".goodsUnitPrice").html(),"money":$(val).find(".goodsAllPrice").val(),"specWarehouseId":$(val).find(".specWarehouseId").html()};	
				
				packageOrTeardownOrderDataJSON.packageOrTeardownOrderCommodities.push(packageOrTeardownOrderCommodityDataJSON);	
				});
				
			//console.log("packageOrTeardownOrderDataJSON",packageOrTeardownOrderDataJSON);
			return packageOrTeardownOrderDataJSON; 
		}
		
		
		let ids=[];
		let commodityNums=[];
		/* 获取组装单商品的id以及需要组装的个数，传入后台判断库存是否满足 */
		function packageOrTeardownOrderCommodityMsg(){
			ids=[];
			commodityNums=[];
			//获取采购商品的信息，添加到采购订单的商品信息里
			$(".package_or_teardown_order_commodity_tr").each(function(index, val){
				ids.push($(val).find(".goodsId").html());
				commodityNums.push($(val).find(".number").val());
			});
				
			
		}
	</script>
</html>