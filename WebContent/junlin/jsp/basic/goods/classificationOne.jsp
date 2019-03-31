<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<title>商品管理一级分类</title>
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
				<h4 class="text-title">商品一级分类</h4>
				<div class="search-div clearfix">
					<div class="clearfix">
						<span class="l_f"> 分类编号： <input type="text" value=""
							id="searchIdentifier" />
						</span> <span class="l_f"> 分类名称： <input type="text" value=""
							id="searchName" />
						</span> <span class="l_f"> 操作人姓名： <input type="text" value=""
							id="searchOperatorName" />
						</span> <span class="l_f"> 
							起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
						</span> <span class="r_f"> <input type="button"
							class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
					</div>

				</div>
				<div class="opration-div clearfix">
					<!-- <span class="r_f">
						<button type="button" class="btncss jl-btn-defult"
							onclick="classifitionEduce()" style="margin-right: 0;">
							<i class="fa fa-download"></i> 导出全部
						</button>

					</span> --> <span class="r_f">
						<button type="button" class="btncss jl-btn-defult"
							onclick="classifitionDel()">
							<i class="fa fa-trash"></i> 删除
						</button>
					</span> <span class="r_f">
						<button type="button" class="btncss jl-btn-defult"
							onclick="classifitionAdd()">
							<i class="fa fa-plus"></i> 新增
						</button>
					</span> <span class="jl_f_l"> <input type="checkbox" name="id"
						id="checkAll" style="margin: 0 5px 0 0;"
						onclick="checkboxController(this)" />
					</span> <span class="jl_f_l"> <label for="checkAll">全选</label>
					</span>

				</div>
				<div class="table_menu_list">
					<form id="datatable_form">
						<table class="table table-striped table-hover col-xs-12"
							id="datatable">
							<thead class="table-header">
								<tr>
									<th>选择</th>
									<th>编号</th>
									<th>名称</th>
									<th>所属分类</th>
									<th>关键词</th>
									<th>操作人</th>
									<th>操作时间</th>
									<th>操作</th>
								</tr>

							</thead>
							<tbody>

							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!--新增 编辑 -->
	<div id="editDiv" style="display: none;">
		<form class="container">

			<div class="form-group">
				<div class="col-xs-2"></div>
				<label for="name" class="col-xs-2 control-label">名称&nbsp;<span class="text-danger">*</span></label>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="name" maxlength="100"/>
				</div>
			</div>
			<div class="form-group">
				<div class="col-xs-2"></div>
				<label for="key_word" class="col-xs-2 control-label">关键词&nbsp;<span class="text-danger">*</span></label>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="key_word" maxlength="20"/>
				</div>
			</div>
			<!--<div class="form-group">
					<div class="col-xs-12 text-center">
						<button type="button" class="btncss jl-btn-importent class-add">提交</button>
						<button type="button" class="btncss jl-btn-defult">取消</button>
					</div>
				</div>-->
		</form>

	</div>

</body>

<script>
	
	var oTable1;
	$("#btn_search").click(function() {
		$("#checkAll").removeAttr("checked");
		oTable1.fnDraw();
	});
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
							"identifier": $("#searchIdentifier").val(),
							"name": $("#searchName").val(),
							"operatorName": $("#searchOperatorName").val(),
							"queryTime":$("#query_time").val()		
						});
					},
					"url": "<%=basePath%>basic/classification/getClassificationMsg?type=3&oneOrTwo=1"
				},

				"aoColumns": [{
						"mData": "id",
						"bSortable": true,
						"sWidth": "5%",
						"sClass": "center",
						"mRender": function(data, type, row) {
							return '<td><input type="checkbox" name="id" value="' + row.id + '" onclick="checkboxClick(\'#checkAll\')"/></td>';
						}
					}, {
						"mData": "identifier",
						"bSortable": false,
						"sWidth": "15%",
						"sClass": "center"
					}, {
						"mData": "name",
						"bSortable": false,
						"sWidth": "15%",
						"sClass": "center"
					}, {
						"mData": "parentId",
						"bSortable": false,
						"sWidth": "15%",
						"sClass": "center",
						"bVisible": false
					}, {
						"mData": "keyWord",
						"bSortable": false,
						"sWidth": "10%",
						"sClass": "center"

					}, {
						"mData": "operatorIdentifier",
						"bSortable": false,
						"sWidth": "15%",
						"sClass": "center",
						"mRender": function(data,type,row) {
							if(data!=null&&data!=""){
								if(row.person!=null){
									return data+"("+row.person.name+")";
								}
								else{
									return data;
								}
								
							}
							else{
								return "";
							}
							
						}
					}, {
						"mData": "operatorTime",
						"bSortable": false,
						"sWidth": "15%",
						"sClass": "center",
						"mRender": function(data) {
							return getSmpFormatDateByLong(data, true);
						}
					},

					{
						"mData": "id",
						"bSortable": false,
						"sWidth": "10%",
						"sClass": "center",
						"mRender": function(data, type, row) {
							if(row.isDelete == 1){
								return '<td><input type="button" class="btncss edit" value="已删除" disabled/>'
							}else{
								return '<td><input type="button" class="btncss edit"' +
									'onclick=\'classifitionEdit(' + JSON.stringify(row) + ')\' value="编辑" />'
							}
						}
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
		
		/*修改*/
		function classifitionEdit(classificationMsg) {
			//获取数据显示在界面中
			$.ajax({
				url: '<%=basePath%>basic/classification/selectById',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: {
					"id": classificationMsg.id
				},
				success: function(data) {
					$("#name").val(data.name);
					$("#key_word").val(data.keyWord);
				}
			});
				
			layer.open({
				type: 1,
				title: "编辑商品一级分类",
				closeBtn: 1,
				area: ['800px', ''],
				content: $("#editDiv"),
				btn: ['提交','取消'],
				yes:function(index){
					if($("#name").val() == "") {
						laywarn("分类名称不能为空!");
						return false;
					} else if($("#key_word").val() == "") {
						laywarn("关键词不能为空!");
						return false;
					}
					//添加时先判断该分类名称是否存在
					$.ajax({
						url: '<%=basePath%>basic/classification/selectClassifityNamePreventRepeatEdit',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data: {
							"name":$("#name").val(),
							"parentId":0,
							"id":classificationMsg.id,
							"type":3
						},

						success: function(data) {
							if(data.success) {
								$.ajax({
									url: '<%=basePath%>basic/classification/updateOnePrimaryKey',
									type: "POST",
									dataType: "json",
									async: false,
									cache: false,
									data:{
										"name":$("#name").val(),
										"keyWord":$("#key_word").val(),
										"id":classificationMsg.id,
										"identifier":classificationMsg.identifier,
										"type":3
									},
									success: function(data) {
										if(data.success) {
											laysuccess(data.msg);
											oTable1.fnDraw(false);
											$("#checkAll").removeAttr("checked");
										} else {
											layfail(data.msg);
										}

									}
								});
								layer.close(index);
							} else {
								laywarn(data.msg);
							}

						}
					});
				},
				end: function(index, layero){
					layer.close(index);
					clearForm("editDiv","");
  				}
			});
		}
		/*新增*/
		function classifitionAdd() {
			layer.open({
				type: 1,
				title: "新增商品一级分类",
				closeBtn: 1,
				area: ['800px', ''],
				content: $("#editDiv"),
				btn: ['提交','取消'],
				yes:function(index){
					if($("#name").val() == "") {
						laywarn("分类名称不能为空!");
						return false;
					} else if($("#key_word").val() == "") {
						laywarn("关键词不能为空!");
						return false;
					}
					//添加时先判断该分类名称是否存在
					$.ajax({
						url: '<%=basePath%>basic/classification/selectClassifityNamePreventRepeatAdd',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data: {
							"name":$("#name").val(),
							"parentId":0,
							"type":3
						},
						success: function(data) {
							if(data.success) {
								$.ajax({
									url: '<%=basePath%>basic/classification/addOneClassificationMsg',
									type: "POST",
									dataType: "json",
									async: false,
									cache: false,
									data:{
										"name":$("#name").val(),
										"keyWord":$("#key_word").val(),
										"type":3
									},
									success: function(data) {
										if(data.success) {
											laysuccess(data.msg);
											oTable1.fnDraw(false);
											$("#checkAll").removeAttr("checked");
										} else {
											layfail(data.msg);
										}
									}
								});	
								layer.close(index);
							} else {
								laywarn(data.msg);
							}

						}
					});
					
				},
				end: function(index, layero){
					layer.close(index);
					clearForm("editDiv","");
  				}
			});
		}
		
		
		/*删除*/
		function classifitionDel() {
			//判断有无选择
			var str = "";
			$("input:checkbox[name='id']:checked").each(function() {
				if($(this).attr("id")!="checkAll"){
					str += $(this).val() + ",";
				}
			})
			if(str == "") {
				laywarn("请选择数据!");
				return;
			}
			
			//删除一级分类时需确认该分类下有无包含二级分类
			$.ajax({
				url: '<%=basePath%>basic/classification/selectTwoByOneClassificationId',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data: $("#datatable_form").serialize(),
				success: function(data) {
					if(data.success) {
					   publicMessageLayer("删除选中数据", function() {
							$.ajax({
								url: '<%=basePath%>basic/classification/delBatchByPrimaryKey',
								type: "POST",
								dataType: "json",
								async: false,
								cache: false,
								data: $("#datatable_form").serialize(),
								success: function(data) {
									if(data.success) {
										laysuccess(data.msg);
										oTable1.fnDraw(false);
										$("#checkAll").removeAttr("checked");
									} else {
										layfail(data.msg);
									}
								}
							});

						})
					} else {
						layer.msg(data.msg, {
							icon: 0,
							time: 2500
						});
					}
				}
			});
		}
		
		/*导出全部*/
		function classifitionEduce(){
			var export_identifier=encodeURI(encodeURI($("#searchIdentifier").val()));
			var export_oneOrTwo=encodeURI(encodeURI(1));
			var export_searchName=encodeURI(encodeURI($("#searchName").val()));
			var export_operatorName=encodeURI(encodeURI($("#searchOperatorName").val()));
			var export_type=encodeURI(encodeURI(3));
			
			publicMessageLayer("导出全部下列显示的数据", function() {
					var URL="<%=basePath%>basic/classification/exportClassification?oneOrTwo="+export_oneOrTwo+"&type="+export_type+"&searchIdentifier="+export_identifier+"&searchName="+export_searchName+"&searchOperatorName="+export_operatorName;
				    location.href=URL;
					return false;			
			})
		}
	</script>
</html>