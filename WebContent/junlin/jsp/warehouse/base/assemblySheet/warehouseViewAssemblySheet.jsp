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
		<title>仓库查看组装单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		<script src="${pageContext.request.contextPath}/junlin/script/Bill.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/watermark.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery.PrintArea.js" type="text/javascript"></script>

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
					<h4 class="text-title">仓库查看组装单</h4>
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
							<!-- <span class="l_f">
								状态：
								<select id="search_type">
									<option value="-1" selected="selected">--请选择--</option>
									<option value="1">未送审</option>
									<option value="2">审核中</option>
									<option value="3">审核通过</option>
									<option value="4">审核驳回</option>
									

								</select>
							</span> -->
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
									<th>日期</th>
									<th>仓库</th>
									<th>货品名称</th>
									<th>组装数量</th>
									<th>金额</th>
									<th>状态</th>
									<th>制单人</th>
									<th>操作</th>
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
										<input type="button" class="btncss edit" onclick="orderPrint()" value="打印" />
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
					<div class="row">
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
						<!--<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">部门：</label>
								<div class="col-xs-7">

								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">业务员：</label>
								<div class="col-xs-7">

								</div>
							</div>
						</div>-->
						<div class="col-xs-4">
							<div class="form-group">
								<label for="" class="col-xs-5 control-label">部门：</label>
								<div class="col-xs-7" id="department_name">

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
			
		<div id="printDiv" style="display: none;">
			
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
							"page":3,
							"orderType":1,
							"searchWarehouse":$("#search_warehouse").val(),
							"dateSearch":$("#dateSearch").val(),
							"searchOriginator":$("#search_originator").val()
								
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
											if(row.state==3){
												return '<td><input type="button" class="btncss edit"  onclick=\'orderPrint('+JSON.stringify(row)+')\' value="打印" /></td>'
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
	laydate.render({
        elem: "#dateSearch",
        range:'~'
    });
	/* 查询仓库信息 */
	$(function(){
		ajaxJquery("GET","<%=basePath%>basic/warehouse/selectAllWarehouse",{},function(data){
			
            $("#search_warehouse").html("")
            $("#search_warehouse").html("<select class='form-control'></select>")
            if(data.length==0){
                $("#search_warehouse").append("<option value='-1' selected>--暂无数据，请到仓库页面进行添加。--</option>");
            }
            else{
                $("#search_warehouse").append("<option value='-1' selected>--请选择仓库--</option>");
                for(var i=0;i<data.length;i++){
                    var option = $("<option value='"+data[i].id+"'>" + data[i].name+"</option>");
                    $("#search_warehouse").append(option);
                }

            }
		})
	})
	
		$(function() {
			latdate("#dateSearch");

		})
		
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
				console.log(res)
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
		
		/*打印*/
		function orderPrint(row) {
			/*请修改ur地址以及打印次数*/
			ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/printPackageOrTeardownOrder",{"id":row.id,"orderType":1},function(data){
				console.log(data);
				let bill = new Bill(data);
				let $content = bill.toPrint();
				$("#printDiv").html("");
				$("#printDiv").append($content);
				$("#printDiv .container").append(watermark("打印次数：" + (row.printNum+1) + "次", "#pickingList"));
				$('.watermark>div').fontFlex(80, 100, 10);
			})
		
			layer.open({
				type: 1,
				title:"打印组装单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#printDiv"),
				btn: ['打印', '关闭'],
				yes: function(index) {
					$("#printDiv .container").printArea();
					ajaxJquery("GET","<%=basePath%>warehouse/packageOrTeardownOrder/updatePackageOrTeardownOrderPrintNum",{"id":row.id},function(data){
						layer.close(index);
						oTable1.fnDraw(false);
					});
					
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