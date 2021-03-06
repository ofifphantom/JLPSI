<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>调拨单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		<link href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/Bill.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/watermark.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery.PrintArea.js"></script>
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
			#search_operatorTime{
			width:190px;
			}
		</style>

	</head>

<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">调拨单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							仓库类型： <select class="warehouse"  id="type">
								<option value="-1">请选择</option>
								<option value="1">调入仓库</option>
								<option value="2">调出仓库</option>
							</select>
							</span>
							<span class="l_f">
							创建时间： <input type="text"  value="" id="search_operatorTime" placeholder="请选择时间" readonly=""  />
							</span>
							<span class="l_f"> 
								制单人姓名： <input type="text"  value="" onblur="cky(this)" id="query_originator"/>
							</span>
							<span class="r_f"> 
								<input type="button"   id="btn_search" class="btncss btn_search" value="搜索" />
							</span>
						</div>

					</div>
					<div class="opration-div clearfix">

						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="allocationListAdd()"><i class="fa fa-plus"></i> 新增</button>
						</span>

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>单号</th>
									<th>日期</th>
									<th>调出仓库</th>
									<th>调入仓库</th>
									<th>运输方式</th>
									<th>摘要</th>
									<th>制单人</th>
									<th>操作</th>
								</tr>

							</thead>
							<tbody>
								<!-- <tr>
									<td>
										<span class="look-span" onclick="allocationListDetail()">PO.2017.09.00054</span>
									</td>
									<td>2017.10.02</td>
									<td>冷库</td>
									<td>AAA</td>
									<td>212454878</td>
									<td>212454878</td>
									<td>212454878</td>
									<td>
										<input type="button" class="btncss edit" onclick="orderPrint()" value="打印" />
									</td>
								</tr>  -->
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
				<h3 class="print-title">调拨单</h3>
				<div class="row">
					
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">单号：</label>
							<div class="col-xs-7 out_identifier" >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">日期：</label>
							<div class="col-xs-7  out_date"  >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">单据类型：</label>
							<div class="col-xs-7"  >
							调拨单
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">调出仓库：</label>
							<div class="col-xs-7 out_exportName"  >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">调入仓库：</label>
							<div class="col-xs-7 out_importName"  >

							</div>
						</div>
					</div>
					
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">运输方式：</label>
							<div class="col-xs-7  out_shipping"  >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">调入机构：</label>
							<div class="col-xs-7 out_importBranch"  >
								总部
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">调出机构：</label>
							<div class="col-xs-7 out_importBranch"  >
								总部
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">调整科目：</label>
							<div class="col-xs-7  out_adjustSubject"  >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">送货地址：</label>
							<div class="col-xs-7  out_sendGoodsPlace"  >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">收货地址：</label>
							<div class="col-xs-7  out_receiveGoodsPlace"  >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">发货地址：</label>
							<div class="col-xs-7  out_exportGoodsPlace"  >

							</div>
						</div>
					</div>
				</div>
				<div id="allgoodDivDetail">
					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="detailTable">
							<tr>
								<th>货品编码</th>
								<th>货品名称</th>
								<th>规格</th>
								<th>品牌</th>
								<th>条形码</th>
								<th>单位</th>
								<th>数量</th>
								<th>调入单价</th>
								<th>调出单价</th>
								<th>调入金额</th>
								<th>产品批次</th>
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
							<div class="col-xs-7"  id="out_department">

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">业务员：</label>
							<div class="col-xs-7"  id="out_person" >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">制单人：</label>
							<div class="col-xs-7"  id="out_makerPerson">

							</div>
						</div>
					</div>
				</div>
				<div class="row">	
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">摘要：</label>
							<div class="col-xs-7"  id="out_summary" >

							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label for="" class="col-xs-5 control-label">分支机构：</label>
							<div class="col-xs-7"  id="out_summary" >
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
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div id="headEdit" class="jl-panel">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">调出仓库</label>
								<div class="col-xs-8">
									<select id="outOfTheWarehouse" class="form-control warehouse" onchange="onWarehouseChange(this)">
									
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">调入仓库</label>
								<div class="col-xs-8">
									<select   id="importOfTheWarehouse" class="form-control warehouse" onchange="checkOutWarehouse(this)">
										
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">运输方式</label>
								<div class="col-xs-8">
									<select id="getAllShippingModel"  class="form-control">
										
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">调入机构</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" value="总部" disabled="disabled" id="importDepartment"/>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">调整科目</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" onblur="cky(this)" id="changeType"/>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">送货地址</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" onblur="cky(this)" id="sendAddress" placeholder="请先选择调入仓库"  disabled  />
								</div>
							</div>
						</div>
					</div>

				</div>

				<div class="row">
					<div class="jl-title l_f" style="text-align: left;">
						<span>货品</span>
					</div>
					<div class="r_f" style="margin-top: 15px;">
						<button type="button" class="btncss jl-btn-importent" onclick="goodsAddEdit()">新增</button>
					</div>
					<div class="r_f" style="margin-top: 14px;">
						<div class="form-group">
							<div class="">
								<select id="edit_goods" class="form-control" disabled="disabled">
									<option value="-1">--请先选择调出仓库--</option>
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
							<th>数量</th>
							<th>调入单价</th>
							<th>调出单价</th>
							<th>调入金额</th>
							<th>操作</th>
						</tr>
						<tr class="tipTr"  id="commoditys">
							<td colspan="9">请先选择商品</td>
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
									<select class="form-control" id="department_id">
										<option value="-1">--请选择部门--</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员</label>
								<div class="col-xs-8">
									<select class="form-control" id="person_id">
										<option value="-1">--请选择业务员--</option>
									</select>
								</div>
							</div>
						</div>
						<!-- <div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">制单人</label>
								<div class="col-xs-8">
									<input class="form-control" type="text" onblur="cky(this)" id="makePerson"/>
								</div>
							</div>
						</div> -->
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input class="form-control" type="text" onblur="cky(this)" id="description" value="无"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="text-danger">注：该页面所有字段均为必填</div>
			</form>
		</div>

		<!--打印-->
		<div id="printDiv" style="display: none;">
		</div>

	</body>

	<script>
		let goodsArr = [];
		// $(function() {
		// 	latdate("#dateSearch");
		// 	laydate.render({
		// 		elem: "#dateOrder",
		// 		type: 'date',
		// 		format: 'yyyy-MM-dd',
		// 		min: 0
		// 	});
		//
        //
		// })

		var oTable1;
		$("#btn_search").click(function() {
			oTable1.fnDraw();
		});
		
		jQuery(function($) {

		//datatable赋值
		oTable1 = $('#datatable').dataTable({
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
							"type": $("#type").val(),
							"alloteDate": $("#search_operatorTime").val(),
							"originator": $("#query_originator").val()
							
						});
					},
					"url": "<%=basePath%>warehouse/base/allocationOrder/getAllocationOrderMsg"
							},

							"aoColumns" : [
								
								{
									"mData" : "identifier",
									"bSortable" : false,
									"sWidth" : "15%",
									"sClass" : "center",
									"mRender" : function(data, type, row) {										
										return '<td><span class="look-span" onclick=\'allocationListDetail(' + JSON.stringify(row) + ')\'>'
										+ data
										+ '</span></td>';
										
								}
									
								},
								{
									"mData" : "allotDate",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									"mRender" : function(data, type, row) {
										return getSmpFormatDateByLong(data, true);
									}

								},{
									"mData" : "exportName",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center"
								},
								{
									"mData" : "importName",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									
								},
								{
									"mData" : "shippingMode.name",
									"bSortable" : false,
									"sWidth" : "15%",
									"sClass" : "center",
									

								},
								{
									"mData" : "summary",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									

								},{
									"mData": "person.name",
									"bSortable": false,
									"sWidth": "10%",
									"sClass": "center",
									"mRender" : function(data, type, row) {
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
									"mData" : "inventories[0].warehouse.name",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									"mRender" : function(data, type, row) {
										return '<td><input type="button" class="btncss edit" onclick=\'orderPrint(' + JSON.stringify(row) + ')\' value="打印" /></td>'
								}
									
								}],
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
			//给仓库下拉框赋值
			<%-- $.ajax({
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
						//$("#edit_warehouseId").append("<option value='' selected>--暂无仓库信息，请去添加--</option>");
					}
					else{
						$("#query_warehouseId").append("<option value='' selected>--请选择--</option>");
						//$("#edit_warehouseId").append("<option value='-1' selected>--请选择--</option>");
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
			}); --%>
		});
        laydate.render({
            elem: "#search_operatorTime",
            range:'~'
        });
		/*给仓库下拉框赋值*/
	jQuery(function($) {
		$.ajax({
			url :'<%=basePath%>basic/warehouse/selectAllWarehouse',
			type: "POST",
			dataType: "json",
			async: false,
			cache: false,
			traditional:true,
			success: function(data) {
				$("#outOfTheWarehouse").html("");
				if(data.length==0){
					$("#outOfTheWarehouse").append("<option value='-1' selected>暂无数据</option>");					
				}
				else{
					$("#outOfTheWarehouse").append("<option value='-1' selected>请选择</option>");
					for(var i=0;i<data.length;i++){							
						var option = $("<option value='"+data[i].id+"' >"
								+data[i].name+"</option>");
						
						$("#outOfTheWarehouse").append(option);
					}
				}
	
				$("#importOfTheWarehouse").html("");
				if(data.length==0){
					$("#importOfTheWarehouse").append("<option value='-1' selected>暂无数据</option>");					
				}
				else{
					$("#importOfTheWarehouse").append("<option value='-1' selected>请选择</option>");
					for(var i=0;i<data.length;i++){							
						var option = $("<option value='"+data[i].id+"' attr-position='"+data[i].position+"'>"
								+data[i].name+"</option>");
						
						$("#importOfTheWarehouse").append(option);
					}
				}
			}
		});
		});
		
		jQuery(function($) {
			/* 获取运输方式 */
			$.ajax({
				url :'<%=basePath%>basic/shippingMode/getAllShippingMode',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				traditional:true,
				success: function(data) {
					$("#getAllShippingModel").html("");
					if(data.length==0){
						$("#getAllShippingModel").append("<option value='' selected>暂无数据</option>");					
					}
					else{
						$("#getAllShippingModel").append("<option value='-1' selected>请选择</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"' >"
									+data[i].name+"</option>");
							
							$("#getAllShippingModel").append(option);
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
			if($(val).val() == "" && res) {
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
		
		/*function checkTableInputEmptyLayer(thisInput) {
			//判断table中Input框为空时弹出layer
			var $input = $(thisInput);
			var name = $input.attr("attr-name");
			layfail(name + "不能为空");
		}*/
		
		/*新增*/
		function allocationListAdd() {
			$("#description").val("无");
			layer.open({
				type: 1,
				title: "新增调拨单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					if(!checkFill())return;
					//console.log(JSON.stringify(allocationOrderDataJSON()));
					$.ajax({
						url: '<%=basePath%>warehouse/base/allocationOrder/addAlloteOrder',
						type: "POST",
						dataType: "json",
						data:{
							"alloteOrder":JSON.stringify(allocationOrderDataJSON())
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
					
					layer.close(index);
					//laysuccess("新增");
					clearForm("editDiv", "");
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "");
					clearGoods();
					$("#importDepartment").val("总部");
					
				}
			});
		}

		/*详情*/
		function allocationListDetail(row) {
			<%-- console.log(row.id);
			 $.ajax({
				url :'<%=basePath%>warehouse/base/allocationOrder/getAllocationOrderMsgById' ,
				type : "get",
				dataType : "json",
				data: {
					"id" : row.id
				},
				success : function(data) {
					let emptyTbody = `
						<tr>
						<th>货品编码</th>
						<th>货品名称</th>
						<th>规格</th>
						<th>品牌</th>
						<th>条形码</th>
						<th>单位</th>
						<th>数量</th>
						<th>调入单价</th>
						<th>调出单价</th>
						<th>调入金额</th>
						<th>产品批次</th>
						<th>生产日期</th>
						<th>有效期至</th>
						</tr>`;
					$("#detailTable").html(emptyTbody);
					
					$(".out_identifier").html(data.identifier);
					$(".out_date").html(getSmpFormatDateByLong(data.allotDate,false));
					$(".out_exportName").html(data.exportName);	
					$(".out_importName").html(data.importName); 
					
					$(".out_shipping").html(data.shippingMode.name);
					$(".out_importBranch").html(data.importBranch);		
					$(".out_adjustSubject").html(data.adjustSubject);
					$(".out_sendGoodsPlace").html(data.sendGoodsPlace);
					$("#out_person").html(data.person.name);
					$("#out_makerPerson").html(data.originator);
					$("#out_summary").html(data.summary);
				
					$("#out_department").html(data.person.department.name);
					$(".out_receiveGoodsPlace").html(data.importPlace);
					$(".out_exportGoodsPlace").html(data.exportPlace);
					var total_num=0;
					var total_money=0.0;
					
					for(var i=0;i<data.allotOrderCommodities.length;i++){
						console.log(data.allotOrderCommodities);
						//let csId=$("#edit_goods option:selected").attr("attr-id");
						let goodsId =data.allotOrderCommodities[i].commoditySpecification.specificationIdentifier;
						let name =data.allotOrderCommodities[i].commoditySpecification.commodity.name;
						let type =data.allotOrderCommodities[i].commoditySpecification.specificationName;
						let unit =data.allotOrderCommodities[i].commoditySpecification.units[0].name;
						let count =data.allotOrderCommodities[i].number;
						let inPrice =data.allotOrderCommodities[i].importUnitPrice;
						let outPrice =data.allotOrderCommodities[i].exportUnitPrice;
						let money =data.allotOrderCommodities[i].importMoney;
						let barCode=data.allotOrderCommodities[i].commoditySpecification.barCode;
						let brand=data.allotOrderCommodities[i].commoditySpecification.commodity.brand;
						total_num+=count;
						total_money+=money;
				
						$("#detailTable").append('<tr><td>' + goodsId + '</td><td>' + name + '</td><td>' 
								+ type + '</td><td>' + brand +  '</td><td>' + barCode + '</td><td>' + unit + '</td><td>' + count + '</td><td>' + inPrice + '</td><td>' 
								+ outPrice + '</td><td>' + money + '</td><td></td><td></td><td></td></tr>');	
						//$("#look_goods").append(goodsTr);
					}
					$("#detailTable").append('<tr><td>合计</td><td></td><td></td><td></td><td></td><td></td><td>'+total_num+'</td><td></td><td></td><td>'+total_money+'</td><td></td><td></td><td></td></tr>');	
					
				}
			});  --%>
			$("#detailDiv").html("");
			$.ajax({
				type: "get",
				url: "<%=basePath%>warehouse/base/allocationOrder/alloteOrderDetal",
				dataType : "json",
				data: {
					"id" : row.id
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
				title: "调拨单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#detailDiv"),
				btn: ['关闭']
			});
		}

		
		
		/*添加商品*/
		function goodsAddEdit() {
			let csId=$("#edit_goods option:selected").attr("attr-id");
			let goodsId = $("#edit_goods option:selected").attr("attr-identifier");
			let name = $("#edit_goods option:selected").attr("attr-name");
			let type = $("#edit_goods option:selected").attr("attr-type");
			let unit = $("#edit_goods option:selected").attr("attr-unit");
			let count = $("#edit_goods option:selected").attr("attr-count");
			let inPrice = $("#edit_goods option:selected").attr("attr-inPrice");
			let outPrice = $("#edit_goods option:selected").attr("attr-outPrice");
			let money = $("#edit_goods option:selected").attr("attr-money");
			
			//console.log("csId",csId);
			if($("#outOfTheWarehouse").val()=="-1"){
				layfail("请先选择调出仓库!");
			}else if($("#edit_goods option:selected").val() == "-1") {
				layfail("请先选择商品!");
			} else if(!checkRepeat(csId)) {
				$(".tipTr").remove();
				goodsArr.push(csId);
				//console.log("goodsArr",goodsArr);
				$("#goodsTbody").append('<tr class="goodsTr"><td class="look_csId" style="display:none">' + csId + '</td><td class="look_goods_identifier">' + goodsId + '</td><td class="look_name">' + name + '</td><td class="look_type">' 
				+ type + '</td><td class="look_unit">' + unit + '</td><td class="look_count">' + count + '</td><td class="look_inPrice">' + inPrice + '</td><td class="look_outPrice">' 
				+ outPrice + '</td><td class="look_money">' + money + '</td><td>' +
					'<input type="button" class="btncss edit" onclick="goodsDel(this)" value="删除" /></td></tr>');
			} else {
				layfail("请勿重复选择商品！");
			}
		}

		/*删除商品*/
		function goodsDel(thisbtn) {
			let goodsId = $(thisbtn).parents("tr").find(".look_csId").html();
			goodsArr.remove(goodsId);
			$(thisbtn).parents("tr").remove();
			if($("#goodsTbody tr").length == 1) {
				$("#goodsTbody").append('<tr class="tipTr"><td colspan="9">请先选择商品</td></tr>');
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
			$("#goodsTbody").html('<tr><th>货品编码</th><th>货品名称</th><th>规格</th><th>单位</th><th>数量</th><th>调入单价</th><th>调出单价</th><th>调入金额</th><th>操作</th></tr>' +
				'<tr class="tipTr"><td colspan="9">请先选择商品</td></tr>');
			goodsArr = [];
		}
		
		/*仓库change值改变事件*/
		function onWarehouseChange(thisSelect){
			if($(thisSelect).val()==$("#importOfTheWarehouse").val()){
				$("#outOfTheWarehouse").val("-1");
				layfail("不能与调入仓库相同");
			}
			
			clearGoods();
			if($(thisSelect).val()==-1){
				$('#edit_goods').parent().html('<select id="edit_goods" class="form-control" disabled="disabled"><option value="-1">--请先选择调出仓库--</option></select>');
			}else{
				$('#edit_goods').parent().html('<select id="edit_goods" class="form-control"><option value="-1">--请选择商品--</option></select>');
				$.ajax({
					url :'<%=basePath%>warehouse/base/allocationOrder/getWarehouseCommodity',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data:{
						//往后台传输的参数
						"warehouseId": $(thisSelect).val()
					},
					traditional:true,
					success: function(data) {
						//$("#getAllShippingModel").html("");
						
						if(data.length==0){
							$("#edit_goods").html("");
							$("#edit_goods").append("<option value='-1' selected>暂无数据</option>");					
						}
						else{
							//$("#edit_goods").append("<option value='-1' selected>请选择</option>");
							//$('#edit_goods').append('<option value="44" attr-name="name" attr-type="type" attr-unit="unit" attr-count="10" attr-inPrice="10" attr-outPrice="10" attr-money="20">44</option>')
							//console.log(data[0].commodity.name);
							for(var i=0;i<data.length;i++){							
								var option = 
									$("<option value='"+data[i].id+"' attr-id='"+data[i].id+"' attr-identifier='"+data[i].commodity.identifier+"' attr-name='"+data[i].commodity.name+"' attr-type='"+data[i].specificationName+"' attr-unit='"+data[i].units[0].name+"' attr-count='"+data[i].inventories[0].inventory+"' attr-inPrice='"+data[i].units[0].miniPrice+"' attr-outPrice='"+data[i].units[0].miniPrice+"' attr-money='"+(data[i].units[0].miniPrice)*(data[i].inventories[0].inventory)+"'>"
										+data[i].commodity.name+" ("+data[i].specificationName+")</option>");
								
								$("#edit_goods").append(option);
							} 
						}
						
						
					}
				});
				/*请在此处为商品下拉框赋值*/
				
				//$('#edit_goods').append('<option value="44" attr-name="name" attr-type="type" attr-unit="unit" attr-count="10" attr-inPrice="10" attr-outPrice="10" attr-money="20">44</option>')
				
				$('#edit_goods').searchableSelect();
			}
		}
		function checkOutWarehouse(thisSelect){
			
			if($(thisSelect).val()==$("#outOfTheWarehouse").val()){
				$("#importOfTheWarehouse").val("-1");
				layfail("不能与调出仓库相同");
			}
			/* 送货地址赋值 */
			let position=$("#importOfTheWarehouse option:selected").attr("attr-position");
			$("#sendAddress").val(position);
		}
		/*打印*/
		function orderPrint(row) {
			
			ajaxJquery("GET","<%=basePath%>warehouse/base/allocationOrder/printAlloteOrder",{"id":row.id},function(data){
				//console.log(data);
				let bill=new Bill(data);
				let $content=bill.toPrint();
				$("#printDiv").html("");
				$("#printDiv").append($content);
				$("#printDiv .container").append(watermark("打印次数："+(row.printNum+1)+"次","#printDiv"));
				$('.watermark>div').fontFlex(80,100,10);
				
			})
			
			layer.open({
				type: 1,
				title:"打印调拨单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#printDiv"),
				btn: ['打印', '关闭'],
				yes: function(index) {
					$.ajax({
						url :'<%=basePath%>warehouse/base/allocationOrder/updateAllotOrderPrintNum' ,
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
		
		/* 提交或者编辑时 把数据整合成json传入后台 */
    	function allocationOrderDataJSON(){
    		
    		//调拨单基础的信息
    		 var  allocationOrderDataJSON={"exportWarehouseId":$("#outOfTheWarehouse").val(),
    				"importWarehouseId":$("#importOfTheWarehouse").val(),
    				"shippingModeId":$("#getAllShippingModel").val(),
    				"importBranch":$("#importDepartment").val(),
    				"adjustSubject":$("#changeType").val(),
    				"sendGoodsPlace":$("#sendAddress").val(),
    				"personId":$("#person_id").val(),
    				"makePerson":$("#makePerson").val(),
    				"summary":$("#description").val(),
    				"allotOrderCommodities":[]
    			}; 
    		//获取调拨商品的信息，添加到销商品信息里
    		$("#goodsTbody .goodsTr").each(function(index, val){
    			
    			var allocationOrderCommoditiesDataJSON={"commoditySpecificationId":$(val).find(".look_csId").html(),
    					/* "commodityName":$(val).find(".look_name").html(),
    					"commoditySpecificationName":$(val).find(".look_type").html(),
    					"unitName":$(val).find(".look_unit").html(), */
    					"number":$(val).find(".look_count").html(),
    					"importUnitPrice":$(val).find(".look_inPrice").html(),
    					"exportUnitPrice":$(val).find(".look_outPrice").html(),
    					"importMoney":$(val).find(".look_money").html()
    					};	
    				
    			allocationOrderDataJSON.allotOrderCommodities[index]=allocationOrderCommoditiesDataJSON;
    			});
    		return allocationOrderDataJSON; 
    	}
	</script>

</html>