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
		<title>密码重置</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		<!--引入JQuery EasyUI  核心UI 文件 CSS-->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/junlin/js/easyui-1.3.6/themes/default/easyui.css">
		<!--引入EasyUI图标文件-->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/junlin/js/easyui-1.3.6/themes/icon.css">
		<!--引入JQuery EasyUI  核心库 1.3.6版本-->
		<script type="text/javascript" src="${pageContext.request.contextPath}/junlin/js/easyui-1.3.6/jquery.easyui.min.js"></script>
		<!--进入 EasyUI中文提示信息-->
		<script type="text/javascript" src="${pageContext.request.contextPath}/junlin/js/easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
		
		<style>
			#editDiv {
				padding-top: 20px;
			}
			#choosetree {
				overflow-y: hidden;
				border: 1px solid #ccc;
				color: #555555;
				padding: 20px 10px;
			}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">密码重置</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							员工编号： <input type="text" value="" id="query_identifier" onblur="cky(this)" />
						</span>
							<span class="l_f"> 
							员工姓名： <input type="text" value="" id="query_name" onblur="cky(this)" />
						</span>
							<span class="l_f"> 
							操作人姓名： <input type="text"  value="" id="query_operatorIdentifier" onblur="cky(this)"/>
						</span>
						<span class="l_f"> 
							员工所属部门： <select id="department_id">
											<option value="">--请选择部门--</option>
										</select>
						</span>	
						</span>
							<span class="r_f"> 
							<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
						</div>

					</div>
					
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									
									<th>编号</th>
									<th>名称</th>
									<th>部门</th>
									<th>入职日期</th>
									<th>职务</th>
									<th>是否为业务员</th>
									<th>是否离职</th>
									<th>操作人</th>
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
		
		<!--详情-->
		<div id="lookDiv"  style="display: none;">
			<form class="container">
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label  class="col-xs-4 control-label">员工名称：</label>
							<div class="col-xs-8" id="look_name">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">类型名称：</label>
							<div class="col-xs-8" id="look_type">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">部门名称：</label>
							<div class="col-xs-8" id="look_department_id">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">入职日期：</label>
							<div class="col-xs-8" id="look_entry_time">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">职务：</label>
							<div class="col-xs-8" id="look_duties">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">学历：</label>
							<div class="col-xs-8" id="look_education">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">出生日期：</label>
							<div class="col-xs-8" id="look_birth_time">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">是否离职：</label>
							<div class="col-xs-8" id="look_quite">
								
							</div>
						</div>
						
						
						<div class="form-group">
							<label  class="col-xs-4 control-label">身份证号：</label>
							<div class="col-xs-8" id="look_id_number">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">籍贯：</label>
							<div class="col-xs-8" id="look_native_place">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">备注：</label>
							<div class="col-xs-8" id="look_remark">
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label  class="col-xs-4 control-label">联系手机号：</label>
							<div class="col-xs-8" id="look_phone">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">家庭电话：</label>
							<div class="col-xs-8" id="look_home_phone">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">常用电话：</label>
							<div class="col-xs-8" id="look_common_phone">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">备用电话：</label>
							<div class="col-xs-8" id="look_reserve_phone">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">邮编：</label>
							<div class="col-xs-8" id="look_postcode">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">住址：</label>
							<div class="col-xs-8" id="look_home_address">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">邮箱：</label>
							<div class="col-xs-8" id="look_mailbox">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">离职日期：</label>
							<div class="col-xs-8" id="look_quit_time">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">是否为业务员：</label>
							<div class="col-xs-8" id="look_business">
								
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">性别：</label>
							<div class="col-xs-8" id="look_sex">
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 control-label">所属仓库：</label>
							<div class="col-xs-8" id="look_warehouseId">
							</div>
						</div>
					</div>
					
				</div>
				
				
				
			</form>

		</div>

	</body>

	<script>
	
	
	var oTable1;
	$("#btn_search").click(function() {

		oTable1.fnDraw();
	});
	jQuery(function($) {
		/*部门下拉框赋值 */
		$.ajax({
			url :'<%=basePath%>/basic/department/getAllDepartment' ,
			type : "POST",
			dataType : "json",
			data: {},
			success : function(data) {
				$("#department_id").empty();
				if(data.length==0){
					$("#department_id").append('<option value="" selected="selected">--暂无部门信息，请去添加--</option>');
				}
				else{
					$("#department_id").append('<option value="" selected="selected">--请选择--</option>');
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#department_id").append(option);
						
					}
				}
				
			}
		});
		
		//dataTable赋值
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
						"departmentId": $("#department_id").val()

					});
				},
				"url": "<%=basePath%>basic/person/dataTables"
			},
			"aoColumns": [ {
				"mData": "identifier",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "15%",
				
			}, {
				"mData": "name",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "5%"
			},{
				"mData": "department.name",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "5%"
			}, {
				"mData": "entryTime",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				"mRender": function(data,type,row) {
					if(data == null || data == ""){
						return "";
					}
					return getSmpFormatDateByLong(data, false);
				}
			}, {
				"mData": "duties",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				
			}, {
				"mData": "business",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				"mRender": function(data,type,row) {
					if(data==0){
						return "否";
					}else{
						return "是";
					}
				}
				
			},{
				"mData": "quite",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				"mRender": function(data,type,row) {
					if(data==0){
						return "否";
					}else{
						return "是";
					}
				}
				
			},{
				"mData": "operatorIdentifier",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "15%",
				"mRender": function(data,type,row) {
					if(data!=null){
						if(row.user!=null){
							return data+"("+row.user.name+")";
						}
						else{
							return data;
						}
					}
					else{
						return "";
					}
					
				}
			},{
				"mData": "id",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "15%",
				"mRender": function(data,type,row) {
				     return '<td><input type="button" class="btncss edit" onclick=\'personlook(' + JSON.stringify(row) + ')\' value="详情"/>'+
				     '<input type="button" class="btncss edit" onclick=\'resetPwd(' + JSON.stringify(row) + ')\' value="重置密码" /><td/>';
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
	
		/*重置密码*/
		function resetPwd(rowData){
			layer.confirm('确认要重置该员工的密码吗？', {
				  btn: ['确定','取消'],//按钮
				  closeBtn: 1,
				  title :'提示'
				}, function(){
					$.ajax({
						url: '<%=basePath%>basic/person/updatePwdById',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data:{
							"password":"11111111",
							"id":rowData.id
						},
						success: function(data) {
							if(data.success) {
								console.log("data:",data)
								console.log("data.logout:",data.logout)
								if(data.logout){
									layer.confirm('密码重置成功，新密码为:11111111,请重新登录。', {
										  btn: ['确定'],//按钮
										  closeBtn: 0,
										  title :'提示'
										}, function(){
											top.location.href="<%=request.getContextPath()%>/login";	
										}		
									);
								}else{
									layer.confirm('密码重置成功，新密码为:11111111', {
										  btn: ['确定'],//按钮
										  closeBtn: 0,
										  title :'提示'
										}	
									);
								}
								
								
							} else {
								layfail(data.msg);
							}
						}
					});	
				}		
			);
		
		}
		
		/*详情*/
		function personlook(rowData){
			
			$("#look_name").html(rowData.name);
			$("#look_type").html(rowData.type);
			$("#look_department_id").html(rowData.department.name);
			if(rowData.entryTime == null || rowData.entryTime == ""){
				$("#look_entry_time").html("");
			}else{
				$("#look_entry_time").html(getSmpFormatDateByLong(rowData.entryTime, false));
			}
			
			$("#look_duties").html(rowData.duties);
			$("#look_education").html(rowData.education);
			$("#look_sex").html(rowData.sex);
			if(rowData.birthTime == null || rowData.birthTime == ""){
				$("#look_birth_time").html("");
			}else{
				$("#look_birth_time").html(getSmpFormatDateByLong(rowData.birthTime, false));
			}
			
			$("#look_native_place").html(rowData.nativePlace);
			$("#look_phone").html(rowData.phone);
			$("#look_home_phone").html(rowData.homePhone);
			$("#look_common_phone").html(rowData.commonPhone);
			$("#look_reserve_phone").html(rowData.reservePhone);
			$("#look_postcode").html(rowData.postcode);
			$("#look_home_address").html(rowData.homeAddress);
			$("#look_mailbox").html(rowData.mailbox);
			if(rowData.quite == 1 && rowData.quitTime!=null && rowData.quitTime!=""){
				$("#look_quit_time").html(getSmpFormatDateByLong(rowData.quitTime, false));
			}else{
				$("#look_quit_time").html("");
			}
			
			
			$("#look_remark").html(rowData.remark);
			$("#look_id_number").html(rowData.idNumber);
			$("#look_warehouseId").html(rowData.warehouseName);
			
			switch (rowData.quite) {
			case 0:
				$("#look_quite").html("否");
				break;
			case 1:
				$("#look_quite").html("是");
				break;
			
			default:
				$("#look_quite").html("");
				break;
			}
			switch (rowData.business) {
			case 0:
				$("#look_business").html("否");
				break;
			case 1:
				$("#look_business").html("是");
				break;
			
			default:
				$("#look_business").html("");
				break;
			}
			layer.open({
				type: 1,
				title: "员工详情",
				closeBtn: 1,
				area: ['80%', ''],
				content: $("#lookDiv"),
				btn: ['关闭']
			});
		}

	</script>

</html>