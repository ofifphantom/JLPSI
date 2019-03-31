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
		<title>总经理审批报损单</title>
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
			.col-xs-5{
				text-align: left !important; 
			}
			#query_breakageDate{
			width:190px;
			}
		</style>

	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">总经理审批报损单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							仓库： <select class="warehouse" id="query_warehouseId">
								
							</select>
							</span>
							<span class="l_f"> 
								日期： <input type="text"  value="" id="query_breakageDate" placeholder="请选择日期" readonly="readonly" />
							</span>
							<span class="l_f"> 
								制单人姓名： <input type="text"  value="" id="query_originator" onblur="cky(this)" />
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
				<h3 class="print-title">报损单</h3>
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
							<label for="" class="col-xs-5 control-label">日期：</label>
							<div class="col-xs-7" id="look_breakageDate">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">仓库：</label>
							<div class="col-xs-7" id="look_warehouseName">

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
								<th>单位</th>
								<th>报损数量</th>
								<th>单价</th>
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
							<label for="" class="col-xs-5 control-label">审核人：</label>
							<div class="col-xs-7" id="look_reviewer"> 

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">分支机构：</label>
							<div class="col-xs-7" id="look_reviewer"> 
							总部
							</div>
						</div>
					</div>
				</div>

			</form>

				
			</div>
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
							"page": 3,
							"warehouseId": $("#query_warehouseId").val(),
							"breakageDate": $("#query_breakageDate").val(),
							"originator": $("#query_originator").val()
								
						});
					},
					"url": "<%=basePath%>warehouse/base/breakageOrder/dataTables"
							},

							"aoColumns" : [{
										"mData" : "identifier",
										"bSortable" : false,
										"sWidth" : "15%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return '<td><span class="look-span" onclick=\'breakageOrderDetail('
													+ row.id
													+ ')\'>'
													+ data
													+ '</span></td>';
										}
									},
									{
										"mData" : "breakageDate",
										"bSortable" : false,
										"sWidth" : "10%",
										"sClass" : "center",
										"mRender" : function(data, type, row) {
											return getSmpFormatDateByLong(data, true);
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
												return "未发送至财务";
												break;
											case 2:
												return "未送审";
												break;
											case 3:
												return "待审核";
												break;
											case 4:
												return "已驳回";
												break;
											case 5:
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
											return '<td><input type="button" class="btncss edit" onclick="approval('
											+ data
											+')" value="通过" />'
											+ '<input type="button" class="btncss edit" onclick="dismissal('
											+ data
											+ ')" value="驳回" /></td>'
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
            elem: "#query_breakageDate",
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
			latdate("#query_breakageDate");
		})
	
		/*详情*/
		function breakageOrderDetail(id) {
			<%-- $.ajax({
				url :'<%=basePath%>warehouse/base/breakageOrder/selectBreakageOrderDetailById',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"id" : id,
				},
				
				traditional:true,
				success: function(data) {
					console.log("data:",data);
					let emptyTbody = `
						<tr>
							<th>货品编码</th>
							<th>货品名称</th>
							<th>规格</th>
							<th>品牌</th>
							<th>条形码</th>
							<th>单位</th>
							<th>报损数量</th>
							<th>单价</th>
							<th>金额</th>
							<th>产品批号</th>
							<th>生产日期</th>
							<th>有效期至</th>
						</tr>`;
					$("#look_goods").html(emptyTbody);
					$("#look_warehouseName").html(data.warehouseName);
					$("#look_breakageDate").html(getSmpFormatDateByLong(data.breakageDate,false));
					$("#look_identifier").html(data.identifier);
					var total_num=0;
					var total_money=0.0;
					for (var i = 0; i < data.breakageOrderCommodities.length; i++) {
						let commoditie = data.breakageOrderCommodities[i];
						let commodityName=commoditie.commoditySpecification.commodity.name;
						let specificationidentifier=commoditie.commoditySpecification.specificationIdentifier;
						let specificationname=commoditie.commoditySpecification.specificationName;
						let baseunitname=commoditie.commoditySpecification.baseUnitName;
						let number=commoditie.number;
						let unitPrice=commoditie.unitPrice;
						let money=commoditie.money;
						let bar_code=commoditie.commoditySpecification.barCode;
						let brand=commoditie.commoditySpecification.commodity.brand;
						total_num+=number;
						total_money+=money;
						let goodsTr = "<tr><td>"+
						specificationidentifier+"</td><td>"+
						commodityName+"</td><td>"+
						specificationname+"</td><td>"+
						brand+"</td><td>"+
						bar_code+"</td><td>"+
						baseunitname+"</td><td>"+
						number+"</td><td>"+
						unitPrice+"</td><td>"+
						money+"</td><td></td><td></td><td></td></tr>";
						$("#look_goods").append(goodsTr);
					 
					 }
					$("#look_goods").append('<tr><td>合计</td><td></td><td></td><td></td><td></td><td></td><td>'+total_num+'</td><td></td><td>'+total_money+'</td><td></td><td></td><td></td></tr>');
					
					$("#look_departmentName").html(data.departmentName);
					$("#look_person").html(data.personName+"("+data.personIdentifier+")");
					$("#look_originator").html(data.originatorName+"("+data.originator+")");
					$("#look_summary").html(data.summary);
					if(data.reviewer==null || data.reviewer==''){
						$("#look_reviewer").html("");
					}else{
						$("#look_reviewer").html(data.reviewerName+"("+data.reviewer+")"); 
					}
					
				}
			}); --%>
			$("#detailDiv").html("");
			$.ajax({
				type: "post",
				url: "<%=basePath%>warehouse/base/breakageOrder/breakageOrderDetail",
				dataType : "json",
				data: {
					"id" : id
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
				title: "报损单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#detailDiv"),
				btn: ['关闭']
			});
		}
		
		

		/*通过*/
		function approval(id) {
			publicMessageLayer("通过该单据", function() {
				let ids = [id];
				$.ajax({
					url :'<%=basePath%>warehouse/base/breakageOrder/updateStateByIds',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
						"state" : 5,
						"isCheck" : 1,
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
		function dismissal(id) {
			publicMessageLayer("驳回该单据", function() {
				let ids = [id];
				$.ajax({
					url :'<%=basePath%>warehouse/base/breakageOrder/updateStateByIds',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
						"state" : 4,
						"isCheck" : 1,
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
		
		
	</script>

</html>