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
		<title>操作日志</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp" %>
		<style>
		#search_operatorTime{
		width:190px;
		}
		.secondOt{
		padding-left:50px
		}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">操作日志</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							操作人姓名： <input type="text" value="" id="search_operatorIdentifier" onkeyup="cky(this)"/>
						</span>
						<span class="l_f"> 
							操作人部门： <select id="search_operatorDepartment"></select>
						</span>
							<span class="l_f"> 
							创建时间： <input type="text"  value="" id="search_operatorTime" placeholder="请选择时间" readonly=""  />
						</span>
							<span class="l_f"> 
							操作类型： 
 							<select id="search_type">
								<option value="-1" selected="selected">--请选择--</option>
								<optgroup label="基础资料">
									<option value="1">客户维护</option>
									<option value="2">供应商维护</option>
									<option value="0">商品维护</option>
									<option value="5">结算方式维护</option>
									<option value="7">部门维护</option>
									<option value="8">仓库维护</option>
									<option value="6">员工维护</option>
									<option value="9">运输方式维护</option>
								</optgroup>
								<option value="10">采购管理</option>
								<option value="12">销售管理</option>
								<optgroup label="采购销售审核">
									<option value="4">审核配置</option>
								</optgroup>
								<!-- <option value="11">打印配置</option> -->
							</select>
						</span>
						
						
							<span class="r_f"> 
							<input type="button"  class="btncss btn_search" value="搜索"  id="btn_search"/>
						</span>

						</div>

					</div>
					<div class="opration-div clearfix">

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>序号</th>
									<th>操作类型</th>
									<th>操作对象</th>
									<th>操作人</th>
									<th>创建时间</th>
								</tr>

							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

	</body>
	<script type="text/javascript">
	var oTable1;
	$("#btn_search").click(function() {

		oTable1.fnDraw();
	});
	jQuery(function($) {
		oTable1 = $('#datatable').dataTable({
			"aaSorting": [
				[4, "desc"]
			], //默认第几个排序
			"bStateSave": false, //状态保存
			"bLengthChange": false, //改变每页显示数据数量
			"bFilter": false, //列搜索
			"iDisplayLength": 20, //默认每页显示的记录数
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
						"operatorIdentifier": $("#search_operatorIdentifier").val(),
						"operatorType": $("#search_type").val(),
						"operatorTime": $("#search_operatorTime").val(),
						"operatorDepartment":$("#search_operatorDepartment").val()

					});
				},
				"url": "<%=basePath%>backgroundManagement/background/LogManager/getLogMsg"
			},
			"aoColumns": [{
				"mData": "",
				"bSortable": false,
				"sDefaultContent": "",
				"sClass": "center",
				"sWidth": "5%"
			}, {
				"mData": "operateType",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				"mRender": function(data) {
					switch (data) {
					case 0:
						return '商品配置';
						break;
					case 1:
						return '客户配置 ';
						break;
					case 2:
						return '供应商配置';
						break;
					case 3:
						return '用户管理';
						break;
					case 4:
						return '审核';
						break;
					case 5:
						return '结算方式配置';
						break;
					case 6:
						return '员工配置';
						break;
					case 7:
						return '部门配置';
						break;
					case 8:
						return '仓库配置';
						break;
					case 9:
						return '运输方式配置';
						break;
					case 10:
						return '采购配置';
						break;
					case 11:
						return '打印';
						break;
					case 12:
						return '销售配置';
						break;
					case 13:
						return '订单';
						break;
					default:
						return '';
						break;
					}
				}
			}, {
				"mData": "operateObject",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "30%"
			}, {
				"mData": "operatorIdentifier",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "15%",
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
				"mData": "operateTime",
				"bSortable": false,
				"sClass": "center",
				"sWidth": "10%",
				"mRender": function(data,type,row) {
					return getSmpFormatDateByLong(data, true);
				}
			}],
			drawCallback: function(settings) {
				/**
				 *生成索引值 
				 **/
				n = this.api().page.info().start;
				this.api().column(0).nodes().each(function(cell, i) {
					cell.innerHTML = i + 1;
				});
			},
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
		getDepartment();
	});
	
	
	laydate.render({
		elem: "#search_operatorTime",
		range:'~'
	});
	
	function getDepartment(){
		/*部门下拉框赋值 */
		$.ajax({
			url :'<%=basePath%>/basic/department/getAllDepartment' ,
			type : "POST",
			dataType : "json",
			data: {},
			success : function(data) {
				if(data.length<=0){
					$("#search_operatorDepartment").append("<option  value='-1'>--暂无部门,请去添加。--</option>");
				}
				else{
					$("#search_operatorDepartment").append("<option  value='-1'>--请选择部门--</option>");
				}
				for ( var i = 0; i < data.length; i++) {
					var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
					$("#search_operatorDepartment").append(option);
					
				}
			}
		});
	}
	</script>
</html>