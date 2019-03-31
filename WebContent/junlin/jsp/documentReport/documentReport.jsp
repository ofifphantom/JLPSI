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
		<title>单据报表</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
		<%@include file="/common.jsp"%>
		<script src="<%=basePath%>/junlin/script/table.js" type="text/javascript"></script>
		<script src="<%=basePath%>/junlin/js/jquery-citys/jquery.citys.js" type="text/javascript"></script>
		
		<!-- <script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script> -->
		<style>
			.search-div span {
				display: inline-block;
			}
			
			.col-xs-4.control-label {
				padding: 0;
			}
			
			.form-group>label[class*="col-"] {
				line-height: 34px;
			}
			#billDiv,#tableDiv{
				margin-top: 30px;
				
			}
			.jl-title .r_f{
			margin-top:22px;
			}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">单据报表</h4>
					<div class="search-div clearfix">
						<form action="" method="post">
							<div class="row jl-title">
								<span>报表基础信息</span>
								<i class="r_f"> 
								<button type="reset" class="btncss jl-btn-defult">重置</button>
							</i>
							</div>
							<div class="jl-panel">
								<div class="row">
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">报表类型&nbsp;<span class="text-danger">*</span> </label>
											<div class="col-xs-8">
												<select class="form-control" id="orderType">
													<option value="-1">-请选择报表类型-</option>
													<option value="2">采购订单汇总表</option>
													<option value="3">采购订单明细表</option>
													<option value="4">采购计划汇总表</option>
													<option value="5">采购计划明细表</option>
													<option value="6">采购开单汇总表</option>
													<option value="7">采购开单明细表</option>
													<option value="21">采购开单付款情况一览表</option>
													<option value="13">入库单汇总表</option>
													<option value="14">入库单明细表</option>
													<option value="16">销售订单明细表</option>
													<option value="17">销售计划单明细表</option>
													<option value="18">销售开单汇总表</option>
													<option value="19">销售开单明细表</option>
													<option value="20">销售开单收款情况一览表</option>
													<option value="22">销售毛利汇总表</option>
													<option value="23">销售毛利明细表</option>
													<option value="9">出库单汇总表</option>
													<option value="10">出库单明细表</option>
													<option value="1">报损单汇总表</option>
													<option value="8">拆卸单明细表</option>
													<option value="12">盘点单明细表</option>
													<option value="15">调拨单明细</option>
													<option value="28">组装单明细表</option>
													<option value="29">其他收货单明细表</option>
													<option value="30">其他发货单明细表</option>
													<option value="24">应付账款汇总表</option>
													<option value="25">应收账款汇总表</option>
													<option value="11">货品销售日常报表</option>
													<option value="26">账面库存汇总表</option>
													<option value="27">账面库存明细表</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">单号</label>
											<div class="col-xs-8">
												<input type="text" class="form-control" name="" id="identifier" value="" />
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">订单状态</label>
											<div class="col-xs-8">
												<select class="form-control" id="state">
													<option value="-1">-请选择订单状态-</option>
													<option value="1">待审核</option>
													<option value="2">已审核</option>
													<option value="3">已入库</option>
													<option value="4">已出库</option>
													<option value="5">已开单</option>
													<option value="6">已终止/已作废</option>
													<option value="7">其他</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">时间&nbsp;<span class="text-danger">*</span></label>
											<div class="col-xs-8">
												<input type="text" class="form-control" name="" id="orderTime" value="" readonly="readonly" placeholder="请选择时间区间" />
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">运输方式</label>
											<div class="col-xs-8">
												<select class="form-control" id="shippingModel">
													
												</select>
											</div>
										</div>
									</div>
								</div>

							</div>
						</form>

						<form action="" method="post">
							<div class="row jl-title">
								<span>客户/供应商信息（只针对采购、销售、应收应付部分单据）</span>
								<i class="r_f"> 
								<button type="reset" class="btncss jl-btn-defult" onclick="clearSecondDiv()">重置</button>
							</i>
							</div>
							<div class="jl-panel">
								<div class="row">
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">搜索类型</label>
											<div class="col-xs-8">
												<select class="form-control" id="supctoType">
													<option value="-1">-请选择-</option>
													<option value="1">客户</option>
													<option value="2">供应商</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">所属分类</label>
											<div class="col-xs-8" style="padding-right:0;" id="classificationOneDiv">
												<select class="form-control" onchange="classificationChange(this)" id="query_classification_one_id">
													
												</select>
											</div>
											<div class="col-xs-4" style="padding:0;display: none;" id="classificationTwoDiv">
												<select class="form-control" id="query_classification_two_id">
													
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">名称</label>
											<div class="col-xs-8">
												<input type="text" class="form-control" name="" id="supctoName" value="" />
											</div>
										</div>
									</div>
									<div class="col-md-8 col-xs-12">
										<div class="form-group">
											<label for="" class="col-xs-2 control-label">地址</label>
											<div class="col-xs-10" id="select_location" style="padding: 0 8px;">
												<select id="province" name="province" class="col-xs-4">
													<!--<option value="-1" selected="selected">--请选择--</option>
													<option value="1">河南省</option>-->
												</select>
												<select id="city" name="city" class="col-xs-4" style="border-left: 0;">
													<!--<option value="-1" selected="selected">--请选择--</option>
													<option value="1">洛阳市</option>-->
												</select>
												<select id="area" name="area" class="col-xs-4" style="border-left: 0;">
													<!--<option value="-1" selected="selected">--请选择--</option>
													<option value="1">西工区</option>-->
												</select>
											</div>
										</div>
									</div>
								</div>

							</div>
						</form>

						<form action="" method="post">
							<div class="row jl-title">
								<span>商品信息</span>
								<i class="r_f"> 
								<button type="reset" class="btncss jl-btn-defult">重置</button>
							</i>
							</div>
							<div class="jl-panel">
								<div class="row">
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">商品名称</label>
											<div class="col-xs-8">
												<input type="text" class="form-control" name="" id="commodityName" value="" />
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">商品编号</label>
											<div class="col-xs-8">
												<input type="text" class="form-control" name="" id="commodity_identifier" value="" />
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">品牌</label>
											<div class="col-xs-8">
												<input type="text" class="form-control" name="" id="brand" value="" />
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">库房类型</label>
											<div class="col-xs-8">
												<select class="form-control" id="warehouseMsg">
													
												</select>
											</div>
										</div>
									</div>
									
								</div>

							</div>
						</form>

						<form action="" method="post">
							<div class="row jl-title">
								<span>公司信息</span>
								<i class="r_f"> 
								<button type="reset" class="btncss jl-btn-defult" onclick="clearForthDiv()">重置</button>
							</i>
							</div>
							<div class="jl-panel">
								<div class="row">
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">制单人部门</label>
											<div class="col-xs-8">
												<select class="form-control" id="departmentClassOne">
													
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">制单人</label>
											<div class="col-xs-8">
												<select class="form-control" id="makeOrderPerson">
													
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">审核部门</label>
											<div class="col-xs-8">
												<select class="form-control" id="checkDepartment">
													
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4 col-xs-6">
										<div class="form-group">
											<label for="" class="col-xs-4 control-label">审核人</label>
											<div class="col-xs-8">
												<select class="form-control" id="checkPerson">
													
												</select>
											</div>
										</div>
									</div>

								</div>

							</div>
						</form>
						<div class="row">
							<span class="r_f"> 
								<button type="button" id="send"   class="btncss jl-btn-importent" onclick="toBill()" style="margin-right: 0;">生成报表</button>
								
							</span>
						</div>

					</div>

				</div>
			</div>
		</div>

		<div id="billDiv" style="display: none;">
			<div class="container">
				<div class="row jl-title">
					<span>单据具体信息</span>
					<div class="r_f">
						<button type="button" class="btncss jl-btn-defult" onclick="educe()" style="margin-right: 0;"><i class="fa fa-download"></i> 导出全部报表</button>
					</div>
				</div>
				<div id="tableDiv">
					
					
				</div>
			</div>
			
			
			

					
		</div>

	</body>

	<script>
		$(function() {

			laydate.render({
				elem: '#orderTime',
				range: true
			});

			$('#select_location').citys();

		})
		
		
		/*生成报表*/
		function toBill() {
			
			var orderType=$("#orderType").val();
			
				if($("#orderType").val()==-1){
					layfail("先选择报表类型！")
				}else if($("#orderTime").val()==""){
					layfail("先选择时间区间！")
				}else{
					$.ajax({
						url: '<%=basePath%>basic/documentReport/switchMenu',
						type: "POST",
						dataType: "json",
						data:{
							"orderType": $("#orderType").val(),
							"orderTime":$("#orderTime").val(),
		    				"identifier":$("#identifier").val(),
		    				"state":$("#state").val(),
		    				"shippingModel":$("#shippingModel").val(),
		    				"supctoType":$("#supctoType").val(),
		    				"supctoName":$("#supctoName").val(),
		    				"commodityName":$("#commodityName").val(),
		    				"commodity_identifier":$("#commodity_identifier").val(),
		    				"brand":$("#brand").val(),
		    				"warehouseMsg":$("#warehouseMsg").val(),
		    				"province":$("#province").val(),
		    				"city":$("#city").val(),
		    				"area":$("#area").val(),
		    				"query_classification_one_id":$("#query_classification_one_id").val(),
		    				"query_classification_two_id":$("#query_classification_two_id").val(),
		    				"departmentClassOne":$("#departmentClassOne").val(),
		    				"makeOrderPerson":$("#makeOrderPerson").val(),
		    				"checkDepartment":$("#checkDepartment").val(),
		    				"checkPerson":$("#checkPerson").val(),
		    				"makeIdentifier":$("#makeOrderPerson").find("option:selected").attr("attr-identifier"),
		    				"rewviewIdentifier":$("#checkPerson").find("option:selected").attr("attr-identifier")
							},
						async: false,
						cache: false,
						success: function(data) {
							//console.log(data)
							if(data.table.tbody.length==0){
								laywarn("未搜索到相关信息。");
								return;
							}
							
							let table=new Table(data);
							let $table=table.getTable();
							
							$("#tableDiv").html($table);
							
							layer.open({
								type: 1,
								title: "单据具体信息",
								closeBtn: 1,
								area: ['100%', '100%'],
								content: $("#billDiv"),
								btn: ['关闭',],
								end: function(index, layero) {
									layer.close(index);
								}
							});
							
						}
					});
					
					
					
				}
				
			
			
			
			
			
			
			
		}
		

		/*导出全部*/
		function educe() {
			publicMessageLayer("导出全部全部数据", function() {
				
				var orderType=$("#orderType").val();
				var orderTime=$("#orderTime").val();
				var identifier=$("#identifier").val();
				var state=$("#state").val();
				var shippingModel=$("#shippingModel").val();
				var supctoType=$("#supctoType").val();
				var supctoName=encodeURI(encodeURI($("#supctoName").val()));
				
				var commodityName=encodeURI(encodeURI($("#commodityName").val()));
				var commodity_identifier=$("#commodity_identifier").val();
				var brand=encodeURI(encodeURI($("#brand").val()));
				var warehouseMsg=$("#warehouseMsg").val();
				var province=$("#province").val();
				var city=$("#city").val();
				var area=$("#area").val();
				console.log("pro"+province);
				console.log("city"+city);
				console.log("area"+area);
				var query_classification_one_id=$("#query_classification_one_id").val();
				var query_classification_two_id=$("#query_classification_two_id").val();
				var departmentClassOne=$("#departmentClassOne").val();
				var makeOrderPerson=$("#makeOrderPerson").val();
				var checkDepartment=$("#checkDepartment").val();
				var checkPerson=$("#checkPerson").val();
				var makeIdentifier=$("#makeOrderPerson").find("option:selected").attr("attr-identifier");
				var rewviewIdentifier=$("#checkPerson").find("option:selected").attr("attr-identifier");
				var URL="<%=basePath%>basic/documentExport/switchMenu?city="+city+"&province="+province+"&orderType="+orderType+"&orderTime="+orderTime+"&identifier="+identifier+"&state="+state+"&shippingModel="+shippingModel+"&supctoType="+supctoType+"&supctoName="+supctoName+"&commodityName="+commodityName+"&commodity_identifier="+commodity_identifier+"&brand="+brand+"&warehouseMsg="+warehouseMsg+"&area="+area+"&query_classification_one_id="+query_classification_one_id+"&query_classification_two_id="+query_classification_two_id+"&departmentClassOne="+departmentClassOne+"&makeOrderPerson="+makeOrderPerson+"&checkDepartment="+checkDepartment+"&checkPerson="+checkPerson+"&makeIdentifier="+makeIdentifier+"&rewviewIdentifier="+rewviewIdentifier+""
				console.log(URL)
				location.href=URL;
				return false;	
						
				laysuccess("导出全部");
			})
		}
		
		/*第二个panel清空事件*/
		function clearSecondDiv(){
			$("#city,#area,#classificationTwoDiv").css("display","none");
			$("#classificationOneDiv").removeClass("col-xs-4").addClass("col-xs-8");
			$("#query_classification_one_id").html('<option value="-1" selected="selected">-请先选择搜索类型-</option>');
		}
		/*第四个panel清空事件*/
		function clearForthDiv(){
			$("#makeOrderPerson").html('<option value="-1" selected="selected">-请先选择开单部门-</option>');
			$("#checkPerson").html('<option value="-1" selected="selected">-请先选择审核部门-</option>');
		}
		
		
		/*一级分类change事件*/
		function classificationChange(thisIn){
			if($(thisIn).val()==-1){
				$("#classificationTwoDiv").css("display","none");
				$("#classificationOneDiv").removeClass("col-xs-4").addClass("col-xs-8");
				return;
			}
			$.ajax({
				url :'<%=basePath%>/basic/classification/selectAllTwoClassifityByParentId' ,
				type : "POST",
				dataType : "json",
				data: {
					"parentId" : $("#query_classification_one_id").val()
				},
				success : function(data) {
					$("#query_classification_two_id").html("");
					$("#classificationTwoDiv").css("display","block");
					$("#classificationOneDiv").removeClass("col-xs-8").addClass("col-xs-4");
					
					if(data.length==0){
						$("#query_classification_two_id").html('<option value="-1" selected="selected">-该分类暂无二级分类-</option>');
						
					}else{
						$("#query_classification_two_id").append('<option value="-1" selected="selected">-请选择二级分类-</option>');
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
							$("#query_classification_two_id").append(option);
							
						}
					}
					
				}
			});
			
			/*请在此处添加二级分类的select框值改变事件*/
			
		}
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
					$("#shippingModel").html("");
					if(data.length==0){
						$("#shippingModel").append("<option value='-1' selected>-暂无数据-</option>");					
					}
					else{
						$("#shippingModel").append("<option value='-1' selected>-请选择-</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"' >"
									+data[i].name+"</option>");
							
							$("#shippingModel").append(option);
						}
					}
					
					
				}
			});
			/* 部门一级分类 */
			$.ajax({
				url :'<%=basePath%>basic/department/getAllDepartment',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				traditional:true,
				success: function(data) {
					$("#departmentClassOne").html("");
					if(data.length==0){
						$("#departmentClassOne").append("<option value='-1' selected>-暂无数据-</option>");					
					}
					else{
						$("#departmentClassOne").append("<option value='-1' selected>-请选择部门-</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"' >"
									+data[i].name+"</option>");
							
							$("#departmentClassOne").append(option);
						}
					}
					
					
				}
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
					$("#warehouseMsg").html("");
					if(data.length==0){
						$("#warehouseMsg").append("<option value='' selected>-暂无仓库信息，请去添加-</option>");
						//$("#edit_warehouseId").append("<option value='' selected>-暂无仓库信息，请去添加-</option>");
					}
					else{
						$("#warehouseMsg").append("<option value='' selected>-请选择-</option>");
						//$("#edit_warehouseId").append("<option value='-1' selected>-请选择-</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"' >"
									+data[i].name+"</option>");
							
							$("#warehouseMsg").append(option);
						}
					}
					
					
				}
			});
			/*审核部门下拉框赋值 */
			
			$.ajax({
				url :'<%=basePath%>/basic/department/getAllDepartment' ,
				type : "POST",
				dataType : "json",
				data: {},
				success : function(data) {
					$("#checkDepartment").empty();
					if(data.length==0){
						$("#checkDepartment").append('<option value="-1" selected="selected">-暂无部门信息，请去添加-</option>');
					}
					else{
						$("#checkDepartment").append('<option value="-1" selected="selected">-请选择审核部门-</option>');
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
							$("#checkDepartment").append(option);
							
						}
					}
					
				}
			});
			var supctoType=$("#supctoType").val();
			if(supctoType==-1){
				$("#query_classification_one_id").append("<option  value='-1'>-请先选择搜索类型-</option>");
			}
			/*  开单人*/
			$("#makeOrderPerson").append('<option value="-1" selected="selected">-请先选择开单部门-</option>');
			$("#departmentClassOne").change(function(){
				if($(this).val()==-1){
					$("#makeOrderPerson").html('<option value="-1" selected="selected">-请先选择开单部门-</option>');
					return;
				}
				$.ajax({
					url :'<%=basePath%>/basic/department/getClassTwodepartment' ,
					type : "POST",
					dataType : "json",
					data: {
						"departmentId" : supctoType=$("#departmentClassOne").val()
					},
					success : function(data) {
						if(data[0]==null){
							$("#makeOrderPerson").html('<option value="-1" selected="selected">-该部门暂无开单人信息，请去添加-</option>');
							return;
						}
						$("#makeOrderPerson").empty();
						$("#makeOrderPerson").html("<option  value='-1'>-请选择开单人-</option>");
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].person.id+"' attr-identifier='"+data[i].person.identifier+"'>"+ data[i].person.name +"</option>");
							$("#makeOrderPerson").append(option);
							
						}
					}
				});
			});
			/*  审核人*/
			$("#checkPerson").append('<option value="-1" selected="selected">-请先选择审核部门-</option>');
			$("#checkDepartment").change(function(){
				if($(this).val()==-1){
					$("#checkPerson").html('<option value="-1" selected="selected">-请先选择审核部门-</option>');
					return;
				}
				$.ajax({
					url :'<%=basePath%>/basic/department/getClassTwodepartment' ,
					type : "POST",
					dataType : "json",
					data: {
						"departmentId" : supctoType=$("#checkDepartment").val()
					},
					success : function(data) {
						if(data[0]==null){
							$("#checkPerson").html('<option value="-1" selected="selected">-该部门暂无审核人信息，请去添加-</option>');
							return;
						}
						$("#checkPerson").empty();
						$("#checkPerson").html("<option  value='-1'>-请选择审核人-</option>");
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].person.id+"' attr-identifier='"+data[i].person.identifier+"'>"+ data[i].person.name +"</option>");
							$("#checkPerson").append(option);
							
						}
					}
				});
			});
			$("#supctoType").change(function(){
				var supctoTypeVal=$("#supctoType").val();
				$("#classificationTwoDiv").css("display","none");
				$("#classificationOneDiv").removeClass("col-xs-4").addClass("col-xs-8");
				if(supctoTypeVal==-1){
					$("#query_classification_one_id").html("<option  value='-1'>-请先选择搜索类型-</option>");
					$("#query_classification_two_id").html("<option  value='-1'>-请先选择一级分类-</option>");
					
				}else if(supctoTypeVal==1){
					$.ajax({
						url :'<%=basePath%>/basic/classification/selectAllOneClassifityByType' ,
						type : "POST",
						dataType : "json",
						data: {
							"type" : 1
						},
						success : function(data) {
							$("#query_classification_one_id").empty();
							$("#query_classification_one_id").append("<option  value='-1'>-请选择一级分类-</option>");
							for ( var i = 0; i < data.length; i++) {
								var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
								$("#query_classification_one_id").append(option);
								option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
								$("#classification_one_id").append(option);
							}
						}
					});
				}else if(supctoTypeVal==2){
					$.ajax({
						url :'<%=basePath%>/basic/classification/selectAllOneClassifityByType' ,
						type : "POST",
						dataType : "json",
						data: {
							"type" : 2
						},
						success : function(data) {
							$("#query_classification_one_id").empty();
							$("#query_classification_one_id").append("<option  value='-1'>-请选择一级分类-</option>");
							for ( var i = 0; i < data.length; i++) {
								var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
								$("#query_classification_one_id").append(option);
								option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
								$("#classification_one_id").append(option);
							}
						}
					});
				}
				
			});
			
			});
		$("#query_classification_one_id").change(function(){
			/* 二级分类下拉框赋值 */
			$.ajax({
				url :'<%=basePath%>/basic/classification/selectAllTwoClassifityByParentId' ,
				type : "POST",
				dataType : "json",
				data: {
					"parentId" : $("#query_classification_one_id").val()
				},
				success : function(data) {
					$("#query_classification_two_id").empty();
					$("#query_classification_two_id").append('<option value="-1" selected="selected">-请选择二级分类-</option>');
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#query_classification_two_id").append(option);
						
					}
				}
			});
		});
		$("#department_id").change(function(){
			if($("#department_id").val()==-1){
				$("#person_id").empty();
				$("#person_id").append('<option value="-1" selected="selected">-请先选择部门-</option>');
			}
			else{
				person(0);
			}
			
		});
		
	</script>

</html>