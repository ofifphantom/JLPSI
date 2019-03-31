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
		<title>其他发货单作废仓库审核</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		
		
		<link
			href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css"
			rel="stylesheet" type="text/css">
		<script
			src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
		
	<style>
			#editDiv {
				padding-top: 20px;
			}
			#editDiv .jl-panel{
				position: relative;
			}
			#query_time{
			width:190px
			}
		</style>
	</head>

	<body class="content" id="salesOrder_content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">其他发货单作废仓库审核</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 单号： <input type="text" value=""
								id="query_identifier" />
							</span> <span class="l_f"> 货品名称： <input type="text" value=""
								id="query_goodsName" />
							</span> 
							<span class="l_f" style="margin-left:19px"> 
								起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
							</span>
							<span class="r_f"> <input type="button" id="btn_search"
								class="btncss btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="salesOrderTimes()"><i class="fa fa-times"></i> 驳回</button>
						</span>
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="salesOrderCheck()"><i class="fa fa-check"></i> 通过</button>
						</span>
						
						<span class="jl_f_l">
							<input type="checkbox"  id="checkAll" style="margin:0 5px 0 0;" onclick="checkboxController(this)"/>
						</span>
						<span class="jl_f_l">
							<label for="checkAll">全选</label>
						</span>
					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>选择</th>
									<th>单号</th>
									<th>客户</th>
									<th>货品名称</th>
									<th>日期</th>
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

			<!--详情 -->
	<div id="lookDiv" style="display: none;">
		<form class="container">
			
			<div class="row jl-title">
				<span>基本信息</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">生成时间:</label>
						<div class="col-xs-8 look_create_time"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">客户:</label>
						<div class="col-xs-8 look_supcto_id">其他</div>
					</div>
					
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">单号:</label>
						<div class="col-xs-8 look_identifier"></div>
					</div>

					
				</div>
			</div>
			<div class="row jl-title">
				<span>合计</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">发货数量:</label>
						<div class="col-xs-8 look_all_deliver_goods_num"></div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">金额:</label>
						<div class="col-xs-8 look_all_deliver_goods_money" ></div>
					</div>
					
				</div>
				<div class="col-xs-6">
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">税额:</label>
						<div class="col-xs-8 look_all_taxes_money"></div>
					</div>
					
				</div>
			</div>
			
			<div class="row jl-title">
				<span>商品</span>

			</div>
			<div id="allGoodsDiv_look"></div>
			
			<div class="row jl-title">
				<span>其他</span>
			</div>
			<div class="row jl-panel">
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">业务员:</label>
						<div class="col-xs-8 look_person_id"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">制单人:</label>
						<div class="col-xs-8 look_originator"></div>
					</div>
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">分支机构:</label>
						<div class="col-xs-8 look_branch"></div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">部门:</label>
						<div class="col-xs-8 look_department_id"></div>

					</div>
					
					<div class="form-group">
						<label for="" class="col-xs-4 control-label">摘要:</label>
						<div class="col-xs-8 look_summary"></div>
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
							"page":28,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": "",
							"isSpecimen":0,
							"createTime": $("#query_time").val(),
							"state": -1	
								
						});
					},
					"url": "<%=basePath%>sales/salesOrder/getSalesOrderMsg"
							},

							"aoColumns" : [
								
								{
									"mData" : "id",
									"bSortable" : false,
									"sWidth" : "5%",
									"sClass" : "center",
									"mRender" : function(data, type, row) {
										return '<td><input type="checkbox" name="id" value="'
												+ row.id
												+ '" onclick="checkboxClick(\'#checkAll\')"/></td>';
									}
								},{
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
									"mData" : "supctoId",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									"mRender" : function(data, type, row) {
											return "其他";
									}

								},{
									"mData" : "commoditysName",
									"bSortable" : false,
									"sWidth" : "15%",
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
									"mData": "person.name",
									"bSortable": false,
									"sWidth": "15%",
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
										return "作废审核中";
									}

								},{
									"mData" : "id",
									"bSortable" : false,
									"sWidth" : "20%",
									"sClass" : "center",
									"mRender" : function(data, type, row) {
										return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail(' + data + ')" value="详情" /></td>'
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
		ajaxJquery("GET","<%=basePath%>sales/salesOrder/selectOrderDetailById",{"id":id},function(data){
			
			
			$(".look_create_time").html(getSmpFormatDateByLong(data.createTime,false));
			
			
			$(".look_identifier").html(data.identifier);
				
			$(".look_person_id").html(data.personName);
			
			$(".look_branch").html(data.branch);
			$(".look_department_id").html(data.personDepartmentName);
			if(data.person!=null){
				$(".look_originator").html(data.originator+"("+data.person.name+")");
			}
			else{
				$(".look_originator").html(data.originator);
			}
			
			$(".look_summary").html(data.summary);
			
			var allDeliverGoodsNum=0;//总发货数量
			var allDeliverGoodsMoney=0;//总金额
			var allTaxesMoney=0;//总税额
			for(var i=0;i<data.salesOrderCommodities.length;i++){
				
				goodsAdd(i+1);
				$("#look_goodDiv"+(i+1)+" .look_commodity_name").html(data.salesOrderCommodities[i].commoditySpecification.commodity.name);
				$("#look_goodDiv"+(i+1)+" .look_base_unit").html(data.salesOrderCommodities[i].commoditySpecification.baseUnitName);
				$("#look_goodDiv"+(i+1)+" .look_commodity_specification_name").html(data.salesOrderCommodities[i].commoditySpecification.specificationName);
				$("#look_goodDiv"+(i+1)+" .look_commodity_specification_iden").html(data.salesOrderCommodities[i].commoditySpecification.specificationIdentifier);
				$("#look_goodDiv"+(i+1)+" .look_discount").html(data.salesOrderCommodities[i].discount);
				$("#look_goodDiv"+(i+1)+" .look_taxes").html(data.salesOrderCommodities[i].taxes);
				$("#look_goodDiv"+(i+1)+" .look_deliver_goods_money").html(data.salesOrderCommodities[i].deliverGoodsMoney);
				allDeliverGoodsMoney+=data.salesOrderCommodities[i].deliverGoodsMoney;
				$("#look_goodDiv"+(i+1)+" .look_remark").html(data.salesOrderCommodities[i].remark);
				$("#look_goodDiv"+(i+1)+" .look_deliver_goods_num").html(data.salesOrderCommodities[i].deliverGoodsNum);
				allDeliverGoodsNum+=data.salesOrderCommodities[i].deliverGoodsNum;
				$("#look_goodDiv"+(i+1)+" .look_unit_price").html(data.salesOrderCommodities[i].unitPrice);
				$("#look_goodDiv"+(i+1)+" .look_batch_number").html(data.salesOrderCommodities[i].batchNumber);
				$("#look_goodDiv"+(i+1)+" .look_taxes_money").html(data.salesOrderCommodities[i].taxesMoney);
				allTaxesMoney+=data.salesOrderCommodities[i].taxesMoney;
			} 
			$(".look_all_deliver_goods_num").html(allDeliverGoodsNum);
			$(".look_all_deliver_goods_money").html(allDeliverGoodsMoney);
			$(".look_all_taxes_money").html(allTaxesMoney);
		}) --%>
		$("#lookDiv").html("");
			$.ajax({
				type: "post",
				url: "<%=basePath%>sales/salesOrder/salesOrderDetail",
				dataType : "json",
				data: {
					"id" : id,
					"type":5
				},
				success: function(res) {
					let bill = new DetailBill(res);
					let $content = bill.toPrint();
					$("#lookDiv").html($content);
				}
			});
			layer.open({
				type: 1,
				title: "其他发货单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#lookDiv"),
				btn: ['关闭']
			});
		}
	
	/*驳回*/
	function salesOrderTimes() {
		var ids=[];
		var boxes = $("input[name='id']");
		for(var i=0;i<boxes.length;i++){
	        if(boxes[i].checked == true){
	            ids.push(boxes[i].value);
	        }
	    }
		
		if(ids.length<=0){
			laywarn("请选择数据!");
			return;
		}

		publicMessageLayer("驳回所选订单的作废", function() {
			$.ajax({
				url :'<%=basePath%>sales/salesOrder/updateStateByIds',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"ids" : ids,
					"state" : -5,
					"isCheck" : 1,
					"reviewerType" : 3, 
					"msg" : "操作成功，已驳回!"
					
				},
				
				traditional:true,
				success: function(data) {
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").attr("checked",false);
					} else {
						layfail(data.msg);
					}

				}
			});
		})
	}
	/*通过*/
	function salesOrderCheck() {
		var ids=[];
		var boxes = $("input[name='id']");
		for(var i=0;i<boxes.length;i++){
	        if(boxes[i].checked == true){
	            ids.push(boxes[i].value);
	        }
	    }
		
		if(ids.length<=0){
			laywarn("请选择数据!");
			return;
		}
		publicMessageLayer("通过所选订单的作废", function() {
			$.ajax({
				url :'<%=basePath%>sales/salesOrder/updateStateByIds',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"ids" : ids,
					"state" : -6,
					"isCheck" : 1,
					"reviewerType" : 3, 
					"msg" : "操作成功，已通过!"
					
				},
				
				traditional:true,
				success: function(data) {
					if(data.success) {
						laysuccess(data.msg);
						oTable1.fnDraw(false);
						$("#checkAll").attr("checked",false);
					} else {
						layfail(data.msg);
					}

				}
			});
		})
	}
		
		/* 查看详情时的商品添加 */
		function goodsAdd(index){
			let goodsDiv=`<div class="row jl-panel" id="look_goodDiv`+index+`">
				<div class="col-xs-6">
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">货品名称:</label>
					<div class="col-xs-8 look_commodity_name">
 
					</div>
				</div>

				<div class="form-group">
					<label for="" class="col-xs-4 control-label">单位:</label>
					<div class="col-xs-8 look_base_unit">
					</div>
				</div>

				<div class="form-group">
					<label for="" class="col-xs-4 control-label">税率:</label>
					<div class="col-xs-8 look_taxes">
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">金额:</label>
					<div class="col-xs-8 look_deliver_goods_money">
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">备注:</label>
					<div class="col-xs-8 look_remark">
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">规格:</label>
					<div class="col-xs-8 look_commodity_specification_name">
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">规格编号:</label>
					<div class="col-xs-8 look_commodity_specification_iden">
					</div>
				</div>
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">发货数量:</label>
					<div class="col-xs-8 look_deliver_goods_num">
					</div>
				</div>
				
				<div class="form-group">
					<label for="" class="col-xs-4 control-label">单价:</label>
					<div class="col-xs-8 look_unit_price">
					</div>
				</div>

				<div class="form-group">
					<label for="" class="col-xs-4 control-label">税额:</label>
					<div class="col-xs-8 look_taxes_money">
					</div>
				</div>
			</div>
		</div>`;
		
		$("#allGoodsDiv_look").append(goodsDiv);
		}
		
	</script>

</html>
	