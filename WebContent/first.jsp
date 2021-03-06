<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	String path = request.getContextPath();
	String basePath = path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>测试用食品后台管理系统</title>
		<link href="${pageContext.request.contextPath}/junlin/css/bootstrap.min.css" rel="stylesheet">

		<link rel="stylesheet" href="${pageContext.request.contextPath}/junlin/css/mine/all.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/junlin/css/mine/public.css" />

		<script src="${pageContext.request.contextPath}/junlin/js/jquery-1.10.2.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/js/bootstrap.min.js" type="text/javascript"></script>

		<script type="text/javascript" src="${pageContext.request.contextPath}/junlin/js/easyui-1.3.6/jquery.min.js"></script>
		<!--引入JQuery EasyUI  核心库 1.3.6版本-->
		<script type="text/javascript" src="${pageContext.request.contextPath}/junlin/js/easyui-1.3.6/jquery.easyui.min.js"></script>
		<!--进入 EasyUI中文提示信息-->
		<script type="text/javascript" src="${pageContext.request.contextPath}/junlin/js/easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery.dataTables.min.js"></script>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery.dataTables.bootstrap.js"></script>
		<style>
			.container {
				margin: 50px auto;
			}
			
			.pageJumpLink {
				cursor: pointer;
			}
			
			.panel-footer {
				background: #fff;
			}
			
			.pager {
				margin: 0;
			}
			.table thead>tr>th{
				border: none;
			}
			
			.l_f {
				float: left;
			}
			
			.r_f {
				float: right;
			}
			.pagination>.active>a{
			    background: #61b747;
    			border-color: #61b747;
			}
			.pagination{
			margin:0;
			}
			.dataTables_paginate.paging_bootstrap{
			text-align: right;
			}
		</style>
	</head>

	<body class="content">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading pageJumpLink" onclick="pageJumpLink(this)" attr-link="sales/salesPlanOrder/list" attr-id="63">
							销售计划单提醒 ：<span class="badge" id="saolesCount">0</span></div>
					</div>
				</div>

				<div class="col-xs-12 col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading pageJumpLink" onclick="pageJumpLink(this)" attr-link="purchase/procuretable/list?page=1" attr-id="32">
						采购计划单到期提醒： <span class="badge" id="procureCount">0</span></div>
					</div>
				</div>

			</div>

			<div class="row">
				<!--<div class="col-xs-12 col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">库存警报提醒： <span class="badge">42</span></div>
						<ul class="list-group panel-body">
							<li class="list-group-item pageJumpLink" attr-link="purchase/purchasePlan/purchasePlan.html">A商品库存剩余10，达到预警数量</li>
							<li class="list-group-item pageJumpLink" attr-link="purchase/purchasePlan/purchasePlan.html">B商品库存剩余20，达到预警数量</li>

						</ul>
						<div class="panel-footer">
							<nav aria-label="...">
								<ul class="pager">
									<li class="previous"><a href="#"><span aria-hidden="true">上一页</span></a></li>
    								<li class="next"><a href="#"><span aria-hidden="true">下一页</span></a></li>
								</ul>
							</nav>
						</div>
					</div>
				</div>-->
				<div class="col-xs-12 col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">待处理流程节点</div>
						<div class="panel-body">
							<div>
								
								<div>
									
									<div id="toBeTreated">
										<table class="table table-condensed" id="datatable">
											<thead>
												<tr>
													<th>待处理事务</th>
													<th>事务类型</th>
													<th>数量</th>
												</tr>
											</thead>
								<tbody>
												<!-- 			<tr>
													<td class="pageJumpLink" attr-link="purchase/purchasePlan/purchasePlan.html">123123</td>
													<td>3</td>
												</tr>
												<tr>
													<td class="pageJumpLink" attr-link="purchase/purchasePlan/purchasePlan.html">123123</td>
													<td>3</td>
												</tr>
												<tr>
													<td class="pageJumpLink" attr-link="purchase/purchasePlan/purchasePlan.html">123123</td>
													<td>3</td>
												</tr> -->
											</tbody>

										</table>

								
									</div>
								</div>

							</div>

						</div>

					</div>
				</div>
			</div>

		</div>

	</body>
	<script type="application/javascript">
/* 	$(function() {
		$(".pageJumpLink").click(function() {
			let link = $(this).attr("attr-link");
			$(".tree-node-selected", window.parent.document).removeClass("tree-node-selected");
			let linkId = $(this).attr("attr-id");
			$("#iframe", window.parent.document).attr(
				"src", link).ready();

		})
	}) */
	function pageJumpLink(span){
		
		let link = $(span).attr("attr-link");
		$(".tree-node-selected", window.parent.document).removeClass("tree-node-selected");
		let linkId = $(span).attr("attr-id");
		$("#iframe", window.parent.document).attr(
			"src", link).ready();
		
	}
	
	
	var oTable1;
 
	jQuery(function($) {
		//datatable赋值
		oTable1 = $('#datatable')
			.dataTable({
				"aaSorting": [
					[0, "asc"]
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
							 	
						});
					},
					"url": "<%=basePath%>basic/index/messages/dataTables"
				},

				"aoColumns": [ {
						"mData": "name",
						"bSortable": false,
						"sWidth": "30%",
						"sClass": "center",
						"mRender": function(data, type, row) {
							return '<td ><span  class="look-span pageJumpLink" onclick="pageJumpLink(this)" attr-link="'+row.url+'">'+row.name+'</span></td>';
						}
					}, {
						"mData": "serviceType",
						"bSortable": false,
						"sWidth": "30%",
						"sClass": "center",
						"mRender": function(data, type, row) {
							//业务类型(1 客户维护，2 供应商维护，3商品维护，4采购订单，5销售订单 )
							var serviceType=data;
							var typeName="";
							switch(serviceType){
							case 1:
								typeName=" 客户维护";
								break;
							case 2:
								typeName=" 供应商维护";
								break;
							case 3:
								typeName=" 商品维护";
								break;
							case 4:
								typeName=" 采购订单";
								break;
							case 5:
								typeName=" 销售订单";
								break;
							}
							return '<td >'+typeName+'</td>';
						}
					}, {
						"mData": "count",
						"bSortable": false,
						"sWidth": "30%",
						"sClass": "center"

					} 

				 
				],
				"oLanguage": {
					// 国际化配置
					"sLengthMenu": "每页显示 _MENU_ 条记录",
					"sZeroRecords": "没有数据记录",
					"sInfo": "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
					"sInfoEmpty": "",
					"sInfoFiltered": "(全部记录数 _MAX_ 条)",
					"oPaginate": {
						"sFirst": "首页",
						"sPrevious": "前一页",
						"sNext": "后一页",
						"sLast": "尾页"
					}
				}
			});
		

	});
		//读取警报数量
	$.ajax({
    	url : "${pageContext.request.contextPath}/basic/index/alert",
    	type : 'post',
    	data : {
    
    	},
    	dataType : "json",
    	success : function(data) {
    		$("#procureCount").html(data.procureCount);
    		$("#saolesCount").html(data.saolesCount);
    		
    	},
		error : function(data){
			
		}        	
    });
 
 	</script>

</html>