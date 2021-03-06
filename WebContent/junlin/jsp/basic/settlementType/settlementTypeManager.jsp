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
		<title>结算方式</title>
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
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">结算方式维护</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							结算编号： <input type="text" value="" id="query_identifier" onblur="cky(this)" />
						</span>
							<span class="l_f"> 
							结算名称： <input type="text" value="" id="query_name"  onblur="cky(this)"/>
						</span>
							<span class="l_f"> 
							操作人姓名： <input type="text"  value="" id="query_operatorIdentifier" onblur="cky(this)"/>
						</span>
						<span class="l_f"> 
							起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
						</span>
						<span class="r_f"> 
							<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<!-- <span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="classifitionEduce()" style="margin-right: 0;"><i class="fa fa-download"></i> 导出全部</button>
							
						</span> -->
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="classifitionDel()"><i class="fa fa-trash"></i> 删除</button>
						</span>
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="classifitionAdd()"><i class="fa fa-plus"></i> 新增</button>
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
									<th>编号</th>
									<th>名称</th>
									<th>操作人</th>
									<th>操作时间</th>
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

		<!--新增 编辑 -->
		<div id="editDiv" style="display: none;">
			<form class="container">

				<div class="form-group">
					<div class="col-xs-2"></div>
					<label for="name" class="col-xs-2 control-label">名称&nbsp;<span class="text-danger">*</span></label>
					<div class="col-xs-4">
						<input type="text" class="form-control" id="name"  onblur="cky(this)" maxlength="100"/>
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
	laydate.render({
		elem: "#query_time",
		range:'~'
	});
	var oTable1;
	$("#btn_search").click(function() {

		oTable1.fnDraw();
	});
	jQuery(function($) {
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
						"identifier": $("#query_identifier").val(),
						"name": $("#query_name").val(),
						"operatorIdentifier": $("#query_operatorIdentifier").val(),
						"operatorTime": $("#query_time").val()
					});
				},
				"url": "<%=basePath%>basic/settlementType/dataTables"
			},
			"aoColumns": [{
				"mData": "id",
				"bSortable": false,
				"sDefaultContent": "",
				"sClass": "center",
				"sWidth": "5%",
				"mRender": function(data, type, row) {
					if(data == 1 || data == 2){
						return "";
					}
					return '<td><input type="checkbox" name="id" value="' + row.id + '" onclick="checkboxClick(\'#checkAll\')"/></td>';
				}
			}, {
				"mData": "identifier",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "15%",
				
			}, {
				"mData": "name",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "20%"
			}, {
				"mData": "operatorIdentifier",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "20%",
				"mRender": function(data,type,row) {
					if(data!=null){
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
				"sClass": "center",
				"sWidth": "20%",
				"mRender": function(data,type,row) {
					return getSmpFormatDateByLong(data, true);
				}
			},{
				"mData": "id",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "20%",
				"mRender": function(data,type,row) {
					if(data == 1 || data == 2){
						return "";
					}else{
						if(row.isDelete == 1){
							return '<td><input type="button" class="btncss edit" value="已删除" disabled/>'
						}else{
							return '<td><input type="button" class="btncss edit" onclick=\'classifitionEdit(' + JSON.stringify(row) + ')\' value="编辑" />';
						}
					}
				    
				}
			}],
			
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
		})
	});
		
		/*修改*/
		function classifitionEdit(rowData) {
			$("#name").val(rowData.name);
			
			layer.open({
				type: 1,
				title: "编辑结算方式",
				closeBtn: 1,
				area: ['800px', ''],
				content: $("#editDiv"),
				btn: ['提交','取消'],
				yes:function(index){
					
					if($("#name").val() == "") {
						laywarn("名称不能为空!");
						return false;
					}
					$.ajax({
						url :'<%=basePath%>/basic/settlementType/checkIsRepeat' ,
						type : "POST",
						dataType : "json",
						data: {
							"id" : rowData.id,
							"name" : $("#name").val()
						},
						success : function(data) {
							if(data.success) {
								$.ajax({
									url :'<%=basePath%>/basic/settlementType/updateSettlementTypeById' ,
									type : "POST",
									dataType : "json",
									data: {
										"id" : rowData.id,
										"name" : $("#name").val()
									},
									success : function(data) {
										if(data.success) {
											laysuccess(data.msg);
										} else {
											layfail(data.msg);
										}
											
										oTable1.fnDraw(false);
										$("#checkAll").attr("checked",false);
										layer.close(index);

									}
								});
							} else {
								laywarn(data.msg);
							}
						}
					});
					
					
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "");
				}
			});
		}
		/*新增*/
		function classifitionAdd() {
			layer.open({
				type: 1,
				title: "新增结算方式",
				closeBtn: 1,
				area: ['800px', ''],
				content: $("#editDiv"),
				btn: ['提交','取消'],
				yes:function(index){
					
					if($("#name").val() == "") {
						laywarn("名称不能为空!");
						return false;
					}
					$.ajax({
						url :'<%=basePath%>/basic/settlementType/checkIsRepeat' ,
						type : "POST",
						dataType : "json",
						data: {
							"name" : $("#name").val()
						},
						success : function(data) {
							if(data.success) {
								$.ajax({
									url :'<%=basePath%>/basic/settlementType/addSettlementType' ,
									type : "POST",
									dataType : "json",
									data: {
										"name" : $("#name").val()
									},
									success : function(data) {
										if(data.success) {
											laysuccess(data.msg);
										} else {
											layfail(data.msg);
										}
											
										oTable1.fnDraw(false);
										$("#checkAll").attr("checked",false);
										layer.close(index);

									}
								});
							} else {
								laywarn(data.msg);
							}
						}
					});
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "");
				}
			});
		}
		/*删除*/
		function classifitionDel() {
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
			
			publicMessageLayer("删除选中数据", function() {
				$.ajax({
					url :'<%=basePath%>basic/settlementType/deleteSettlementTypeByIds',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
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
		
		/*导出全部*/
		function classifitionEduce(){
			publicMessageLayer("导出全部下列显示的数据", function() {
				var name = encodeURI(encodeURI($("#query_name").val())); 
				var identifier = encodeURI(encodeURI($("#query_identifier").val()));
				var operatorIdentifier = encodeURI(encodeURI($("#query_operatorIdentifier").val()));
				
				var URL="<%=basePath%>basic/settlementType/exportSettlement?identifier="+identifier+"&name="+name+"&operatorIdentifier="+operatorIdentifier;	
				    location.href=URL;
					return false;			
			})
		}
	</script>

</html>