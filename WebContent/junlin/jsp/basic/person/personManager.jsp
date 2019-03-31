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
		<title>员工管理</title>
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
			#query_time{
			width:190px
			}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">员工管理</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							员工编号： <input type="text" value="" id="query_identifier" onblur="cky(this)" />
						</span>
							<span class="l_f"> 
							员工名称： <input type="text" value="" id="query_name" onblur="cky(this)" />
						</span>
							<span class="l_f"> 
							操作人姓名： <input type="text"  value="" id="query_operatorIdentifier" onblur="cky(this)"/>
						</span>
							<span class="l_f"> 
						所属地： 	<select id="query_area" >
									<option value="" selected="selected">--请选择--</option>
									<option value="西安">西安</option>
									<option value="上海">上海</option>
									<option value="天津">天津</option>
									<option value="石家庄">石家庄</option>
									<option value="张家口">张家口</option>
								</select>
							
						</span>
							<span class="l_f"> 
								部门： 	
								<select id="query_department_id">
									<option value="" selected="selected">--请选择--</option>
									
								</select>
							
						</span>
					 	<span class="l_f" style="margin-left: 10px;"> 
							起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
						</span>
						<span class="r_f"> 
							<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<!-- <span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="personEduce()" style="margin-right: 0;"><i class="fa fa-download"></i> 导出全部</button>
							
						</span> -->
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="personDel()"><i class="fa fa-trash"></i> 删除</button>
						</span>
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="personAdd()"><i class="fa fa-plus"></i> 新增</button>
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
									<th>部门</th>
									<th>入职日期</th>
									<th>职务</th>
									<th>是否为业务员</th>
									<th>是否离职</th>
									<th>操作人</th>
									<th>所属地</th>
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
			<form class="container" id="editDivForm">
				<div class="jl-title"><span>基本信息</span></div>
				<div class="jl-panel">
				
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="name" class="col-xs-4 control-label">员工名称&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="name" name="name" onblur="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="place" class="col-xs-4 control-label">所属地&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<select id="place" name="place" class="form-control">
									<option value="-1" selected="selected">--请选择--</option>
									<option value="西安">西安</option>
									<option value="上海">上海</option>
									<option value="天津">天津</option>
									<option value="石家庄">石家庄</option>
									<option value="张家口">张家口</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="type" class="col-xs-4 control-label">类型名称</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="type"  name="type" onblur="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="department_id" class="col-xs-4 control-label">部门名称&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<select id="department_id" name="departmentId" class="form-control">
									<option value="-1" selected="selected">--请选择--</option>
									
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="entry_time" class="col-xs-4 control-label">入职日期</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="entry_time" name="entryTimeStr" placeholder="请选择入职日期" readonly=""/>
							</div>
						</div>
						<div class="form-group">
							<label for="duties" class="col-xs-4 control-label">职务&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="duties" name="duties" onblur="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="education" class="col-xs-4 control-label">学历&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="education" name="education" onblur="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="birth_time" class="col-xs-4 control-label">出生日期</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="birth_time" name="birthTimeStr" placeholder="请选择出生日期" readonly=""/>
							</div>
						</div>
						<div class="form-group">
							<label for="quite" class="col-xs-4 control-label">是否离职&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<select id="quite" name="quite" class="form-control" onchange="quiteVlaueChange(this)">
									<option value="-1" selected="selected">--请选择--</option>
									<option value="0">否</option>
									<option value="1">是</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="id_number" class="col-xs-4 control-label">身份证号&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="id_number" name="idNumber" onblur="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="native_place" class="col-xs-4 control-label">籍贯</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="native_place" name="nativePlace" onblur="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="remark" class="col-xs-4 control-label">备注</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="remark" value="无"  name="remark" onblur="cky(this)" maxlength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="phone" class="col-xs-4 control-label">联系手机号&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="phone"  name="phone" onblur="cky(this)"/>
							</div>
						</div>
						<div class="form-group">
							<label for="home_phone" class="col-xs-4 control-label">家庭电话</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="home_phone" name="homePhone" onblur="cky(this)" />
							</div>
						</div>
						<div class="form-group">
							<label for="reserve_phone" class="col-xs-4 control-label">常用电话</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="common_phone"  name="commonPhone" onblur="cky(this)"/>
							</div>
						</div>
						<div class="form-group">
							<label for="reserve_phone" class="col-xs-4 control-label">备用电话</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="reserve_phone"  name="reservePhone" onblur="cky(this)"/>
							</div>
						</div>
						<div class="form-group">
							<label for="postcode" class="col-xs-4 control-label">邮编</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="postcode" name="postcode" onblur="cky(this)"/>
							</div>
						</div>
						<div class="form-group">
							<label for="home_address" class="col-xs-4 control-label">住址</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="home_address" name="homeAddress" onblur="cky(this)" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
							<label for="mailbox" class="col-xs-4 control-label">邮箱</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="mailbox" name="mailbox" onblur="cky(this)"/>
							</div>
						</div>
						<div class="form-group">
							<label for="quit_time" class="col-xs-4 control-label">离职日期&nbsp;<span class="text-danger" id="quit_time_danger">*</span></label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="quit_time" name="quitTimeStr" placeholder="请选择离职日期" readonly=""/>
							</div>
						</div>
						<div class="form-group">
							<label for="business" class="col-xs-4 control-label">是否为业务员&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<select id="business" name="business" class="form-control">
									<option value="-1" selected="selected">--请选择--</option>
									<option value="0">否</option>
									<option value="1">是</option>
								</select>
							</div>
						</div>
					
						<div class="form-group">
							<label for="sex" class="col-xs-4 control-label">性别&nbsp;<span class="text-danger">*</span></label>
							<div class="col-xs-8">
								<select id="sex" name="sex" class="form-control">
									<option value="-1" selected="selected">--请选择--</option>
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="warehouseId" class="col-xs-4 control-label">所属仓库</label>
							<div class="col-xs-8">
								<select id="warehouseId" name="warehouseId" class="form-control">
								</select>
							</div>
					</div>
					</div>
					
				</div>
				</div>
				<div class="jl-title"><span>登录信息与权限</span></div>
				<div class="jl-panel">
				<div class="form-group">
					<div class="col-xs-2"></div>
					<label for="loginName" class="col-xs-2 control-label">登录名&nbsp;<span class="text-danger">*</span></label>
					<div class="col-xs-4">
						<input type="text" class="form-control" id="loginName" name="loginName" onblur="cky(this)" maxlength="25"/>
					</div>
				</div>
				<div class="form-group" id="passwordDiv">
					<div class="col-xs-2"></div>
					<label for="password" class="col-xs-2 control-label">密码&nbsp;<span class="text-danger">*</span></label>
					<div class="col-xs-4">
						<input type="password" class="form-control" id="password" name="password" onblur="cky(this)" maxlength="25"/>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-2"></div>
					<label class="col-xs-2 control-label">权限&nbsp;<span class="text-danger">*</span></label>
					<div class="col-xs-4">
						<ul id="choosetree"></ul>
						<input class="hidden" type="text" id="limits" name="resIds" />
					</div>

				</div>
				
				</div>
				
				
			</form>

		</div>
		
		<!--详情-->
		<div id="lookDiv"  style="display: none;">
			<form class="container">
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label  class="col-xs-4 control-label">员工编号：</label>
							<div class="col-xs-8" id="look_identifier">
							</div>
						</div>
						
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
						<div class="form-group">
							<label  class="col-xs-4 control-label">所属地：</label>
							<div class="col-xs-8" id="look_place">
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label  class="col-xs-4 control-label">操作时间：</label>
							<div class="col-xs-8" id="look_operatorTime">
							</div>
						</div>
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
	laydate.render({
		elem: "#query_time",
		range:'~'
	});
	//是否离职下拉框的只改变事件
	function quiteVlaueChange(e){
		//选择的是没有离职，则离职时间不是必填项
		if($(e).val()=="1"){//离职
			$("#quit_time_danger").removeClass("hidden");
		}
		else{//没有离职
			$("#quit_time_danger").addClass("hidden");
			$("#quit_time").val("");
		}
	}
	
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
				
				for ( var i = 0; i < data.length; i++) {
					var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
					$("#department_id").append(option);
					option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
					$("#query_department_id").append(option);
					
				}
			}
		});
		
		
		
		
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
						"area":$("#query_area").val(),
						"departmentId":$("#query_department_id").val(),
						"operatorTime": $("#query_time").val()
					});
				},
				"url": "<%=basePath%>basic/person/dataTables"
			},
			"aoColumns": [{
				"mData": "id",
				"bSortable": false,
				"sDefaultContent": "",
				"sClass": "center",
				"sWidth": "5%",
				"mRender": function(data, type, row) {
					if(data!=1){
						return '<td><input type="checkbox" name="id" value="' + row.id + '" onclick="checkboxClick(\'#checkAll\')"/></td>';
					}
					
				}
			}, {
				"mData": "identifier",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				
			}, {
				"mData": "name",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%"
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
				"sWidth": "5%",
				
			}, {
				"mData": "business",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "5%",
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
			},
			{
				"mData": "place",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "5%",
				
			},
			{
				"mData": "operatorTime",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				"mRender": function(data,type,row) {
					if(data == null || data == ""){
						return "";
					}
					return getSmpFormatDateByLong(data, true);
				}
				
			},
			
			{
				"mData": "id",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				"mRender": function(data,type,row) {
					if(row.isDelete == 1){
						return '<td><input type="button" class="btncss edit" onclick=\'personlook(' + JSON.stringify(row) + ')\' value="详情"/>'+
					     '<input type="button" class="btncss edit" value="已删除" disabled/><td/>';
						
					}else{
					     return '<td><input type="button" class="btncss edit" onclick=\'personlook(' + JSON.stringify(row) + ')\' value="详情"/>'+
					     '<input type="button" class="btncss edit" onclick=\'personEdit(' + JSON.stringify(row) + ')\' value="编辑" /><td/>';
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
	
	
		
	
		window.onload=function(){
			
			latdate("#entry_time");
			latdate("#quit_time");
			laydate.render({
				elem: "#birth_time",
				type: 'date',
				format: 'yyyy-MM-dd',
				max:0
			});
			getAllWarehouseMsg();
		}
		
		//给添加时需要选择的仓库下拉框赋值
		function getAllWarehouseMsg(){
			$.ajax({
				url: '<%=basePath%>basic/warehouse/selectAllWarehouse',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				success: function(data) {
					$("#warehouseId").html("");
					if(data.length==0){
						isHasWarehouseMsg=false;
						$("#warehouseId").append("<option value='-1' selected>--暂无数据，请到仓库页面进行添加--</option>");	
						$("#warehouseId").html("");
					}
					else{
						isHasWarehouseMsg=true;
						$("#warehouseId").append("<option value='-1' selected>--请选择--</option>");
						for(var i=0;i<data.length;i++){							
							var option = $("<option value='"+data[i].id+"'>"
									+ data[i].name + "</option>");
							$("#warehouseId").append(option);
						}
					}
				}
			});
		}
		
		/*详情*/
		function personlook(rowData){
			$("#look_identifier").html(rowData.identifier);
			if(rowData.operatorTime == null || rowData.operatorTime == ""){
				$("#look_operatorTime").html("");
			}else{
				$("#look_operatorTime").html(getSmpFormatDateByLong(rowData.operatorTime, true));
			}
			
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
			$("#look_place").html(rowData.place);
			
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
		
		
		var checkednodes = [];
		
		/*修改*/
		function personEdit(rowData) {
			$("#name").val(rowData.name);
			$("#type").val(rowData.type);
			$("#department_id").val(rowData.departmentId);
			if(rowData.entryTime == null || rowData.entryTime == ""){
				$("#entry_time").val("");
			}else{
				$("#entry_time").val(getSmpFormatDateByLong(rowData.entryTime, false));
			}
			
			$("#duties").val(rowData.duties);
			$("#education").val(rowData.education);
			$("#sex").val(rowData.sex);
			if(rowData.birthTime == null || rowData.birthTime == ""){
				$("#birth_time").val("");
			}else{
				$("#birth_time").val(getSmpFormatDateByLong(rowData.birthTime, false));
			}
			
			$("#native_place").val(rowData.nativePlace);
			$("#phone").val(rowData.phone);
			$("#home_phone").val(rowData.homePhone);
			$("#common_phone").val(rowData.commonPhone);
			$("#reserve_phone").val(rowData.reservePhone);
			$("#postcode").val(rowData.postcode);
			$("#home_address").val(rowData.homeAddress);
			$("#mailbox").val(rowData.mailbox);
			$("#place").val(rowData.place);
			if(rowData.quite == 1 && rowData.quitTime!=null && rowData.quitTime!=""){
				$("#quit_time").val(getSmpFormatDateByLong(rowData.quitTime, false));
			}
			$("#quite").val(rowData.quite);
			//选择的是没有离职，则离职时间不是必填项
			if($("#quite").val()=="1"){
				$("#quit_time_danger").removeClass("hidden");
			}
			else{
				$("#quit_time_danger").addClass("hidden");
			}
			$("#business").val(rowData.business);
			$("#remark").val(rowData.remark);
			$("#id_number").val(rowData.idNumber);
			$("#loginName").val(rowData.loginName);
			$("#warehouseId").val(rowData.warehouseId);
			$("#passwordDiv").addClass("hidden");
			
			/*tree begin  */
			url="<%=request.getContextPath() %>/basic/person/selectAllMenu?id=";
			url+=rowData.id;
			var elem = document.getElementById("choosetree");  
			elem.innerHTML = "";  
			$("#choosetree").tree({
				url: url, //获取远程数据URL
				/* data: [{
						"id": 2,
						"text": "后台配置",
						"children": [{
							"id": 6,
							"text": "分类配置",
							"children": [{
								"id": 4,
								"text": "一级分类",
								"iconCls": "icon-no"
							}, {
								"id": 5,
								"text": "二级分类",
								"iconCls": "icon-no"
							}]
						}, {
							"id": 7,
							"text": "商品配置",
							"iconCls": "icon-no"

						}, {
							"id": 8,
							"text": "活动配置",
							"iconCls": "icon-no",
							"children": [{
								"id": 9,
								"text": "优惠券",
								"iconCls": "icon-no"
							}, {
								"id": 10,
								"text": "活动列表",
								"iconCls": "icon-no"
							}, {
								"id": 11,
								"text": "活动审核",
								"iconCls": "icon-no"
							}]
						}, {
							"id": 12,
							"text": "广告配置",
							"iconCls": "icon-no"
						}]
					}, {
						"id": 3,
						"text": "VIP管理",
						"children": [{
							"id": 13,
							"text": "VIP管理",
							"iconCls": "icon-no"
						}, {
							"id": 14,
							"text": "待添加列表",
							"iconCls": "icon-no"
						}]
					}, {
						"id": 15,
						"text": "订单管理",
						"children": [{
							"id": 16,
							"text": "订单管理",
							"iconCls": "icon-no"
						}, {
							"id": 17,
							"text": "发票审核",
							"iconCls": "icon-no"
						}]
					}, {
						"id": 18,
						"text": "后台管理",
						"children": [{
							"id": 19,
							"text": "后台管理",
							"children": [{
								"id": 20,
								"text": "用户",
								"iconCls": "icon-no"
							}, {
								"id": 21,
								"text": "操作日志",
								"iconCls": "icon-no"
							}]
						}]
					}, {
						"id": 24,
						"text": "报表系统",
						"children": [{
							"id": 25,
							"text": "综合检测",
							"iconCls": "icon-no"
						}, {
							"id": 26,
							"text": "订单报表",
							"iconCls": "icon-no"
						}, {
							"id": 27,
							"text": "商品销量报表",
							"iconCls": "icon-no",
						}]
					}

				], //节点数据加载 */
				lines: true,
				checkbox: true,
				onlyLeafCheck: false, //定义是否只在末节点之前显示复选框
				dnd: false, //定义是否启动拖拽功能
				onCheck: function() {
					checkednodes = $('#choosetree').tree('getChecked');
					
					
				},
				onLoadError: function(arguments) {
					
				}
			})
			
			/*tree end*/
			
			
			layer.open({
				type: 1,
				title: "编辑员工",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes:function(index){
					checkednodes = $('#choosetree').tree('getChecked');
					/*将选中的节点获取ID变成字符串，赋值到id为limits的input框中*/
					getId(checkednodes);
					
					
					if($("#name").val() == "") {
						laywarn("员工名称不能为空!");
						return false;
					}else if($("#department_id").val() == -1) {
						laywarn("部门名称不能为空!");
						return false;
					}else if($("#duties").val() == "") {
						laywarn("职务不能为空!");
						return false;
					}else if($("#education").val() == "") {
						laywarn("学历不能为空!");
						return false;
					} else if($("#quite").val() == -1) {
						laywarn("请选择员工是否离职!");
						return false;
					}else if(!isnotEmpty($("#id_number").val())){
						laywarn("身份证号不能为空!");
						return false;
					}else if(isnotEmpty($("#id_number").val())&&!checkIDcard($("#id_number").val())){
						laywarn("请输入正确的身份证号!");
						return false;
					}else if(!isnotEmpty($("#phone").val())){
						laywarn("联系手机号不能为空!");
						return false;
					}else if(isnotEmpty($("#phone").val())&&!checkMobilePhone($("#phone").val())){
						laywarn("请输入正确的联系手机号!");
						return false;
					}else if($("#quite").val() == 1 && $("#quit_time").val() == "" ) {
						laywarn("请选择离职日期!");
						return false;
					}else if($("#business").val() == -1) {
						laywarn("请选择员工是否为业务员!");
						return false;
					}else if($("#sex").val() == "-1") {
						laywarn("请选择性别!");
						return false;
					}else if($("#loginName").val()=="") {
						laywarn("登录名不能为空!");
						return false;
					}else if($("#limits").val()=="") {
						laywarn("权限不能为空!");
						return false;
					}else if(isnotEmpty($("#home_phone").val())&&!checkPhone($("#home_phone").val())){
						laywarn("请输入正确的家庭电话!");
						return false;
					}else if(isnotEmpty($("#common_phone").val())&&!checkMobilePhone($("#common_phone").val())){
						laywarn("请输入正确的常用电话!");
						return false;
					}else if(isnotEmpty($("#reserve_phone").val())&&!checkMobilePhone($("#reserve_phone").val())){
						laywarn("请输入正确的备用电话!");
						return false;
					}else if(isnotEmpty($("#postcode").val())&&!checkPost($("#postcode").val())){
						laywarn("请输入正确的邮编!");
						return false;
					}else if(isnotEmpty($("#mailbox").val())&&!checkEmail($("#mailbox").val())){
						laywarn("请输入正确的邮箱!");
						return false;
					}
					else if($("#place").val()==""){
						laywarn("所属地不能为空!");
						return false;
					}
					var formData = new FormData($("#editDivForm")[0]);
					
					$.ajax({
						url: '<%=basePath%>basic/person/selectAdminByLoginNameAndId',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data: {
							"id": rowData.id,
							"loginName": $("#loginName").val()
						},

						success: function(data) {
							if(data.success) {
					
							 $.ajax({
								url :'<%=basePath%>/basic/person/updatePersonById?id='+rowData.id ,
								type : "POST",
								dataType : "json",
								async: false,
								cache: false,
								data :formData,
								contentType : false,
								processData : false,//processData的默认值是true。用于对data参数进行序列化处理
								success : function(data) {
									if(data.success) {
										laysuccess(data.msg);
										if(rowData.id=='<%=session.getAttribute("userId")%>'){
											setTimeout(function (){parent.location.reload()},500);
										}
									} else {
										layfail(data.msg);
									}
										
									oTable1.fnDraw(false);
									$("#checkAll").attr("checked",false);
									layer.close(index);
		
								}
							});
					 } else {
						layfail(data.msg);
					}

				}
			});
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "","", $("#choosetree"));
				}
			}); 
		}
		/*新增*/
		function personAdd() {
			$("#remark").val("无");
			$("#passwordDiv").removeClass("hidden");
			/*tree begin  */
			url="<%=request.getContextPath() %>/basic/person/selectAllMenu?id=";
			var elem = document.getElementById("choosetree");  
			elem.innerHTML = "";  
			$("#choosetree").tree({
				url: url, //获取远程数据URL
				/* data: [{
						"id": 2,
						"text": "后台配置",
						"children": [{
							"id": 6,
							"text": "分类配置",
							"children": [{
								"id": 4,
								"text": "一级分类",
								"iconCls": "icon-no"
							}, {
								"id": 5,
								"text": "二级分类",
								"iconCls": "icon-no"
							}]
						}, {
							"id": 7,
							"text": "商品配置",
							"iconCls": "icon-no"

						}, {
							"id": 8,
							"text": "活动配置",
							"iconCls": "icon-no",
							"children": [{
								"id": 9,
								"text": "优惠券",
								"iconCls": "icon-no"
							}, {
								"id": 10,
								"text": "活动列表",
								"iconCls": "icon-no"
							}, {
								"id": 11,
								"text": "活动审核",
								"iconCls": "icon-no"
							}]
						}, {
							"id": 12,
							"text": "广告配置",
							"iconCls": "icon-no"
						}]
					}, {
						"id": 3,
						"text": "VIP管理",
						"children": [{
							"id": 13,
							"text": "VIP管理",
							"iconCls": "icon-no"
						}, {
							"id": 14,
							"text": "待添加列表",
							"iconCls": "icon-no"
						}]
					}, {
						"id": 15,
						"text": "订单管理",
						"children": [{
							"id": 16,
							"text": "订单管理",
							"iconCls": "icon-no"
						}, {
							"id": 17,
							"text": "发票审核",
							"iconCls": "icon-no"
						}]
					}, {
						"id": 18,
						"text": "后台管理",
						"children": [{
							"id": 19,
							"text": "后台管理",
							"children": [{
								"id": 20,
								"text": "用户",
								"iconCls": "icon-no"
							}, {
								"id": 21,
								"text": "操作日志",
								"iconCls": "icon-no"
							}]
						}]
					}, {
						"id": 24,
						"text": "报表系统",
						"children": [{
							"id": 25,
							"text": "综合检测",
							"iconCls": "icon-no"
						}, {
							"id": 26,
							"text": "订单报表",
							"iconCls": "icon-no"
						}, {
							"id": 27,
							"text": "商品销量报表",
							"iconCls": "icon-no",
						}]
					}

				], //节点数据加载 */
				lines: true,
				checkbox: true,
				onlyLeafCheck: false, //定义是否只在末节点之前显示复选框
				dnd: false, //定义是否启动拖拽功能
				onCheck: function() {
					checkednodes = $('#choosetree').tree('getChecked');

				},
				onLoadError: function(arguments) {
					
				}
			})
			/*tree end  */
	
			layer.open({
				type: 1,
				title: "新增员工",
				closeBtn: 1,
				area: ['100%', ''],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					
					/*将选中的节点获取ID变成字符串，赋值到id为limits的input框中*/
					getId(checkednodes);
					
					
					
					if($("#name").val() == "") {
						laywarn("员工名称不能为空!");
						return false;
					}else if($("#department_id").val() == -1) {
						laywarn("部门名称不能为空!");
						return false;
					}else if($("#duties").val() == "") {
						laywarn("职务不能为空!");
						return false;
					}else if($("#education").val() == "") {
						laywarn("学历不能为空!");
						return false;
					} else if($("#quite").val() == -1) {
						laywarn("请选择员工是否离职!");
						return false;
					}else if(!isnotEmpty($("#id_number").val())){
						laywarn("身份证号不能为空!");
						return false;
					}else if(isnotEmpty($("#id_number").val())&&!checkIDcard($("#id_number").val())){
						laywarn("请输入正确的身份证号!");
						return false;
					}else if(!isnotEmpty($("#phone").val())){
						laywarn("联系手机号不能为空!");
						return false;
					}else if(isnotEmpty($("#phone").val())&&!checkMobilePhone($("#phone").val())){
						laywarn("请输入正确的联系手机号!");
						return false;
					}else if($("#quite").val() == 1 && $("#quit_time").val() == "" ) {
						laywarn("请选择离职日期!");
						return false;
					}else if($("#business").val() == -1) {
						laywarn("请选择员工是否为业务员!");
						return false;
					}else if($("#sex").val() == "-1") {
						laywarn("请选择性别!");
						return false;
					}else if($("#loginName").val()=="") {
						laywarn("登录名不能为空!");
						return false;
					}else if($("#limits").val()=="") {
						laywarn("权限不能为空!");
						return false;
					}else if(isnotEmpty($("#home_phone").val())&&!checkPhone($("#home_phone").val())){
						laywarn("请输入正确的家庭电话!");
						return false;
					}else if(isnotEmpty($("#common_phone").val())&&!checkMobilePhone($("#common_phone").val())){
						laywarn("请输入正确的常用电话!");
						return false;
					}else if(isnotEmpty($("#reserve_phone").val())&&!checkMobilePhone($("#reserve_phone").val())){
						laywarn("请输入正确的备用电话!");
						return false;
					}else if(isnotEmpty($("#postcode").val())&&!checkPost($("#postcode").val())){
						laywarn("请输入正确的邮编!");
						return false;
					}else if(isnotEmpty($("#mailbox").val())&&!checkEmail($("#mailbox").val())){
						laywarn("请输入正确的邮箱!");
						return false;
					}else if($("#place").val()==""){
						laywarn("所属地不能为空!");
						return false;
					}
					
					var formData = new FormData($("#editDivForm")[0]);
					$.ajax({
						url: '<%=basePath%>basic/person/selectAdminByLoginName',
						type: "POST",
						dataType: "json",
						async: false,
						cache: false,
						data: {
							"loginName": $("#loginName").val()
						},
						success: function(data) {
							if(data.success) {
								$.ajax({
									url :'<%=basePath%>/basic/person/addPerson',
									type : "POST",
									dataType : "json",
									async: false,
									cache: false,
									data :formData,
									contentType : false,
									processData : false,//processData的默认值是true。用于对data参数进行序列化处理
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
								layfail(data.msg);
							}

						}
					});
					<%-- $.ajax({
						url :'<%=basePath%>/basic/person/addPerson' ,
						type : "POST",
						dataType : "json",
						async: false,
						cache: false,
						data :formData,
						contentType : false,
						processData : false,//processData的默认值是true。用于对data参数进行序列化处理
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
					}); --%>
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "", "", $("#choosetree"));
				}
			}); 
		}
		/*删除*/
		function personDel() {
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
					url :'<%=basePath%>basic/person/deletePersonByIds',
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
		function personEduce() {
			publicMessageLayer("导出全部下列显示的数据", function() {
				var name = encodeURI(encodeURI($("#query_name").val())); 
				var identifier = encodeURI(encodeURI($("#query_identifier").val()));
				var operatorIdentifier = encodeURI(encodeURI($("#query_operatorIdentifier").val()));
				var area=encodeURI(encodeURI($("#query_area").val()));
				
				var URL="<%=basePath%>basic/person/exportPerson?identifier="+identifier+"&name="+name+"&operatorIdentifier="+operatorIdentifier+"&area="+area;	
				    location.href=URL;
					return false;			
			})
		}

		
		/*将选中的节点获取ID变成字符串，赋值到id为limits的input框中*/
		function getId(obj) {
			checkedStr = "";
			$(obj).each(function(i, dom) {
				checkedStr = checkedStr + dom["id"] + ","
			});
			checkedStr = checkedStr.substring(0, checkedStr.length - 1);
			$("#limits").val(checkedStr);
			
		}
		
	</script>

</html>