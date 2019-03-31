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
		<title>仓库商品查询</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery.PrintArea.js"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/watermark.js" type="text/javascript"></script>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">仓库商品查询</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							仓库：<select name="" id="selectWarehouse" onchange="getWarehouseName()">
						
							</select>
						</span>
						<span class="l_f"> 
							品牌： <input type="text"  value=""  id="query_brand"/>
						</span>
						<span class="l_f"> 
							名称： <input type="text" value=""  id="query_name"/>
						</span>
						<span class="l_f" style="margin-left: 38px;"> 
							分类：
							<select name="" id="searchClassificationOneId" onchange="getDataToTwoClassification()">
							</select>
							<select name="" id="searchClassificationTwoId">
							</select>
						</span>
							<span class="r_f"> 
							<input type="button"  class="btncss btn_search"  id="btn_search" value="搜索" />
						</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="print()" style="margin-right: 0;"><i class="fa fa-print"></i> 打印</button>
						</span>
					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>商品编号</th>
									<th>商品名称</th>
									<th>品牌</th>
									<th>类别</th>
									<th>规格</th>
									<th>单位</th>
									<th>数量</th>
									<th>仓库</th>
									<th>产品保质日期</th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		<div id="print"  style="display:none;">
			<div class="container">
			<div class="print-content" id="printMsg">
			
			<div class="row jl-title">
					<span>商品</span>
			</div>
			<table class="table table-bordered table-hover col-xs-12" id="datatable2">
							<thead class="table-header">
								<tr>
									<th>商品编号</th>
									<th>商品名称</th>
									<th>品牌</th>
									<th>类别</th>
									<th>规格</th>
									<th>单位</th>
									<th>数量</th>
									<th>仓库</th>
									<th>产品保质日期</th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
			
			</div>
			</div>
			
		
		</div>

		
		
	<script>
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
							"brand": $("#query_brand").val(),
							"commodityName": $("#query_name").val(),
							"warehouseId": $("#selectWarehouse").val(),
							"classficationId": $("#searchClassificationTwoId").val()
						});
					},
					"url": "<%=basePath%>basic/warehousevindicate/getWarehouseMsg"
							},

							"aoColumns" : [
								
								{
									"mData" : "commodity.identifier",
									"bSortable" : false,
									"sWidth" : "15%",
									"sClass" : "center",
									
								},
								{
									"mData" : "commodity.name",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									

								},{
									"mData" : "commodity.brand",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center"
								},
								{
									"mData" : "commodity.classification.name",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									
								},
								{
									"mData" : "specificationName",
									"bSortable" : false,
									"sWidth" : "15%",
									"sClass" : "center",
									

								},
								{
									"mData" : "units[0].name",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									

								},{
									"mData": "inventories[0].inventory",
									"bSortable": false,
									"sWidth": "10%",
									"sClass": "center",
									
								},{
									"mData" : "inventories[0].warehouse.name",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									
								},
								{
									"mData" : "qualityPeriod",
									"bSortable" : false,
									"sWidth" : "10%",
									"sClass" : "center",
									"mRender": function(data,type,row) {
											return row.qualityPeriod+" "+row.qualityPeriodUnit;
									
									
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
		$("#btn_search").click(function() {
			$("#checkAll").removeAttr("checked");
			oTable1.fnDraw();
		});
		getDataToOneClassification();
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
				$("#selectWarehouse").html("");
				if(data.length==0){
					$("#selectWarehouse").append("<option value='' selected>暂无数据</option>");					
				}
				else{
					$("#selectWarehouse").append("<option value='' selected>请选择</option>");
					for(var i=0;i<data.length;i++){							
						var option = $("<option value='"+data[i].id+"' >"
								+data[i].name+"</option>");
						
						$("#selectWarehouse").append(option);
					}
				}
				
				
			}
		});
		});
	/*给一二级菜单赋值*/
	function getDataToOneClassification(){
		
		$.ajax({
			url: '<%=basePath%>basic/classification/selectAllOneClassifityByType',
			type: "POST",
			dataType: "json",
			data:{
				"type":3
			},
			async: false,
			cache: false,
			success: function(data) {
				//修改或者添加页面的分类下拉菜单
				
					$("#searchClassificationOneId").html("");
					$("#searchClassificationTwoId").html("");
					
					$("#searchClassificationTwoId").append("<option value='' selected>--请先选择一级分类--</option>");
					if(data.length==0){
						$("#searchClassificationOneId").append("<option value='' selected>--暂无数据，请到一级分类页面进行添加--</option>");	
					}
					else{
						$("#searchClassificationOneId").append("<option value='0' selected>--请选择--</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"'>"
									+ data[i].name + "</option>");
							$("#searchClassificationOneId").append(option);
						}
					}
			}
		}); 
	}
	//给页面里或者添加时需要选择的二级分类下拉框赋值
	function getDataToTwoClassification(){
			parentId=$("#searchClassificationOneId").val()-0;
			
			if($("#searchClassificationOneId").val()==0){
				$("#searchClassificationTwoId").html("");
				$("#searchClassificationTwoId").append("<option value='' selected>--请先选择一级分类--</option>");
			} 
		if(parentId>0){
			$.ajax({
				url: '<%=basePath%>basic/classification/selectAllTwoClassifityByParentId',
				type: "POST",
				dataType: "json",
				data:{
					"parentId":parentId
				},
				async: false,
				cache: false,
				success: function(data) {
					//页面里的分类下拉菜单
					
						$("#searchClassificationTwoId").html("");
						
						if(data.length==0){
							$("#searchClassificationTwoId").append("<option value='' selected>--请先选择一级分类--</option>");					
						}
						else{
							$("#searchClassificationTwoId").append("<option value='' selected>--请选择--</option>");
							for(var i=0;i<data.length;i++){							
								var option = $("<option value='"+data[i].id+"'>"
										+ data[i].name + "</option>");
								$("#searchClassificationTwoId").append(option);
							}
						}
					
					
				}
			});
		}
		/* else{
			if(pageOrUpdateAndAdd==2){
				$("#edit_classification_id").html("");
				$("#edit_classification_id").append("<option value='-1' selected>--请先选择一级分类--</option>");
			}
			else{
				$("#searchClassificationTwoId").html("");
				$("#searchClassificationTwoId").append("<option value='-1' selected>--请先选择一级分类--</option>");	
			}
		} */
	}
	 latdate("#produationDate") 
	
	
	/*打印*/
	 function print(){
		 $.ajax({
				url: '<%=basePath%>basic/warehousevindicate/getAll',
				type: "POST",
				dataType: "json",
				data:{
					//往后台传输的参数
					"brand": $("#query_brand").val(),
					"commodityName": $("#query_name").val(),
					"warehouseId": $("#selectWarehouse").val(),
					"classficationId": $("#searchClassificationTwoId").val()
				},
				async: false,
				cache: false,
				success: function(data) {
					console.log("仓库商品"+data[0].inventories[0].inventory)
					$('#datatable2 tr:gt(0)').remove();
					var s;
					for (var i = 0; i < data.length; i++) {
						var warehouse_name="";
						if(data[i].inventories[0].warehouse.name!=null||data[i].inventories[0].warehouse.name!=""){
							warehouse_name=data[i].inventories[0].warehouse.name;
						}
						console.log(i+"  "+data[i].commodity.identifier)
						s='<tr><td>'+data[i].commodity.identifier+'</td><td>'
						+data[i].commodity.name+'</td><td>'
						+data[i].commodity.brand+'</td><td>'
						+data[i].commodity.classification.name+'</td><td>'
						+data[i].specificationName+'</td><td>'
						+data[i].units[0].name+'</td><td>'
						+data[i].inventories[0].inventory+'</td><td>'
						+warehouse_name+'</td><td>'
						+data[i].qualityPeriod+' '+data[i].qualityPeriodUnit+'</td></tr>'
						$('#datatable2').append(s);
					}
					
					
				}
			});
		 layer.open({
				type: 1,
				title: "打印",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#print"),
				btn: ['打印','关闭'],
				yes:function(){
					
					 MessageLayer("您确定要打印该单据吗？", function() {
						 $("#print").printArea();
						 layer.closeAll();
						 oTable1.fnDraw(false);
					}); 
				}
			});
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
	</script>

		 
	
		
</html>