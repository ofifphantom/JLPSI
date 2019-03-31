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
		<title>其他发货单引用</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		
		
		<script src="${pageContext.request.contextPath}/junlin/script/Bill.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/watermark.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery.PrintArea.js"></script>
		<style>
			#query_time{
			width:190px
			}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">其他发货单引用</h4>
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
							<span class="l_f"> 
								状态：<select id="query_state" >
									<option value="-1" selected="selected">--请选择--</option>
									<option value="1">待打印出库单</option>
									<option value="2">作废审核驳回</option>
									
								</select>
							</span>
						<span class="r_f"> <input type="button" id="btn_search"
							class="btncss btn_search" value="搜索" />
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

		<!--出库单-->
		<div id="pickingList" style="display: none;">
			
			
		
			
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
							"page":24,
							"identifier": $("#query_identifier").val(),
							"commodityName": $("#query_goodsName").val(),
							"supctoName": "",
							"isSpecimen":0,
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

										switch (data) {
										
										case 5:
											return "待打印出库单";
											break;
									
										case 9:
											return "作废审核驳回";
											break;
									
										default:
											break;
										}
									}

								},{
									"mData" : "id",
									"bSortable" : false,
									"sWidth" : "20%",
									"sClass" : "center",
									"mRender" : function(data, type, row) {
										return '<td><input type="button" class="btncss edit" onclick="salesOrderDetail(' + data + ')" value="详情" />'
										+'<input type="button" class="btncss edit" onclick=\'printOutLibraryList(' + JSON.stringify(row) + ')\' value="打印生成出库单" /></td>'
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
			$("#btn_search").click(function() {
				$("#checkAll").removeAttr("checked");
				oTable1.fnDraw();
			});
		});
	
		
	/*详情*/
	function salesOrderDetail(id) {
		$("#allGoodsDiv_look").html("");
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
		})
		layer.open({
			type: 1,
			title: "其他发货单详情",
			closeBtn: 1,
			area: ['100%', '100%'],
			content: $("#lookDiv"),
			btn: ['关闭']
		});
	}

		/*打印生成出库单*/
		function printOutLibraryList(row) {
			
			let json={"id":row.id};
			let outBoundOrderId=0;
			ajaxJquery("GET","<%=basePath%>sales/salesOrder/createOtherOutboundOrder",{"id":row.id},function(data){
				
				if(data.success){
					outBoundOrderId=data.id;
					let bill=new Bill(data.outboundOrderJSON);
					let $content=bill.toPrint();
					$("#pickingList").html("");
					$("#pickingList").append($content);
					$("#pickingList  .container").append(watermark("打印次数："+(row.printNum+1)+"次","#pickingList"));
					$('.watermark>div').fontFlex(80,100,10);
				}
				else{
					layfail(data.msg);
				}
				
			}) 
			if(outBoundOrderId>0){
				layer.open({
					type: 1,
					title: "出库单详情",
					closeBtn: 1,
					area: ['100%', '100%'],
					content: $("#pickingList"),
					btn: ['打印'],
					yes:function(index){
						 $.ajax({
							url :'<%=basePath%>/sales/salesOrder/updateSalesOrderPrintNum' ,
							type : "POST",
							dataType : "json",
							data: {
								"id" : outBoundOrderId
							},
							success : function(data) {
								$("#pickingList .container").printArea();
								layer.close(index);
								oTable1.fnDraw(false);
							}
						});
						
					},
					end: function(index, layero){
						oTable1.fnDraw(false);
						layer.close(index);
	  				}
				}); 
			}
			
			
		}
		
		/*打印配置  start*/
		var hkey_root,hkey_path,hkey_key
		hkey_root="HKEY_CURRENT_USER"
		hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"
		//设置网页打印的页眉页脚为空
		try{
			var RegWsh = new ActiveXObject("WScript.Shell")
			hkey_key="header" 
			RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
			hkey_key="footer"
			RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
			}catch(e){}
		/*打印配置 end*/
			
		/* 查看详情时的商品添加 */
		function goodsAdd(index){
			$("#goodsDiv").html("");
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
					<label for="" class="col-xs-4 control-label">批号:</label>
					<div class="col-xs-8 look_batch_number">
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