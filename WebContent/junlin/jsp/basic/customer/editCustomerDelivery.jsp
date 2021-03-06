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
		<title>客户修改审核</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		<script src="${pageContext.request.contextPath}/junlin/js/jquery-citys/jquery.citys.js" type="text/javascript"></script>
		<!-- <script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script> -->
			<style>
			#editDiv {
				padding-top: 20px;
			}
			#goods-list ul li{
				width: 40%;
				margin-right: 9%;
				display: inline-block;
				cursor: default;
				text-decoration: underline;
			
			}
			.delli-div {
				display: inline-block;
				color: #ff7e7e;
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
					<h4 class="text-title">客户修改审核</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"  style="width:423px;"> 
							分类：<select id="query_classification_one_id">
								<option value="-1" selected="selected">--请选择--</option>
								
							</select>
						
							<select id="query_classification_two_id">
								<option value="-1" selected="selected">--请先选择一级分类--</option>
								
							</select>
							</span>
							<span class="l_f" id="select_location0" style="margin-left: 38px;">
							地区：
							<select id="query_province_code" name="province">
								<option value="-1" selected="selected">--请选择--</option>
							</select>
							<select id="query_city_code" name="city"> 
								<option value="-1" selected="selected">--请选择--</option>
							</select>
							<select id="query_area_code" name="area">
								<option value="-1" selected="selected">--请选择--</option>
							</select>
						</span>
							<span class="l_f"> 
							单位名称： <input type="text" id="query_name" onblur="cky(this)"/>
						</span>
							<span class="l_f"> 
							操作人姓名： <input type="text" id="query_operatorIdentifier" onblur="cky(this)"/>
						</span>
						<span class="l_f" style="margin-left:19px"> 
							起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
						</span>
							
							<span class="r_f"> 
							<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
						</div>
					</div>
					<div class="opration-div clearfix">
						<!--<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="customerEduce()" style="margin-right: 0;"><i class="fa fa-download"></i> 导出全部</button>
							
						</span>-->
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="customerTimes()"  style="margin-right: 0;"><i class="fa fa-times"></i> 驳回</button>
						</span>
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="customerCheck()"><i class="fa fa-check"></i> 通过</button>
						</span>
						<span class="jl_f_l">
							<input type="checkbox" name=""  id="checkAll" style="margin:0 5px 0 0;" onclick="checkboxController(this)"/>
						</span>
						<span class="jl_f_l">
							<label for="checkAll" >全选</label>
						</span>

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>选择</th>
									<th>编号</th>
									<th>单位名称</th>
									<th>分类</th>
									<th>等级</th>
									<th>联系电话</th>
									<th>联系人</th>
									<th>地区</th>
									<th>状态</th>
									<th>操作人</th>
									<th width="20%">操作</th>
								</tr>
							</thead>
							<tbody>
								

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="lookDiv" style="display: none;">
			<form class="container">
				<div class="col-xs-6">
				
					<div class="form-group">
						<label  class="col-xs-4 control-label">是否停用：</label>
						<div class="col-xs-8" id="look_useable">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">编号：</label>
						<div class="col-xs-8" id="look_identifier">
							123456
						</div>
					</div>
					
					<div class="form-group">
						<label  class="col-xs-4 control-label">状态：</label>
						<div class="col-xs-8" id="look_state">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">客户名称：</label>
						<div class="col-xs-8" id="look_name">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label"> 客户编码：</label>
						<div class="col-xs-8" id="look_mnemonicCode">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">所属分类：</label>
						<div class="col-xs-8" style="padding-right: 0;" id="look_classification">
							123456
						</div>
					</div>

					<div class="form-group">
						<label  class="col-xs-4 control-label">全称：</label>
						<div class="col-xs-8" id="look_fullName">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">客户等级：</label>
						<div class="col-xs-8" id="look_frade">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">往来类型：</label>
						<div class="col-xs-8" id="look_fromType">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">结算方式：</label>
						<div class="col-xs-8" id="look_settlementType">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">运输方式：</label>
						<div class="col-xs-8" id="look_transportMode">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">联系人：</label>
						<div class="col-xs-8" id="look_contactPeople">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">联系手机：</label>
						<div class="col-xs-8" id="look_phone">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">邮编：</label>
						<div class="col-xs-8" id="look_postcode">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">送货地址：</label>
						<div class="col-xs-8" id="look_deliveryAddress">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">通讯地址：</label>
						<div class="col-xs-8" id="look_communicationAddress">
							123456
						</div>
					</div>
					
					<div class="form-group">
						<label  class="col-xs-4 control-label">默认税率：</label>
						<div class="col-xs-8" id="look_taxes">
							123456
						</div>
					</div>
					
					<div class="form-group">
						<label  class="col-xs-4 control-label">网址：</label>
						<div class="col-xs-8" id="look_website">
							123456
						</div>
					</div>

				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label  class="col-xs-4 control-label">操作人：</label>
						<div class="col-xs-8" id="look_operator">
							AAA
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">操作时间：</label>
						<div class="col-xs-8" id="look_operatorTime">
							2018.02.14
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">地区：</label>
						<div class="col-xs-8" id="look_province">
							123456
						</div>
					</div>
					
					<div class="form-group">
						<label  class="col-xs-4 control-label">部门：</label>
						<div class="col-xs-8" id="look_department">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">业务员：</label>
						<div class="col-xs-8" id="look_person">
							123456
						</div>
					</div>

					<div class="form-group">
						<label  class="col-xs-4 control-label">开户银行：</label>
						<div class="col-xs-8" id="look_bank">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">银行账号：</label>
						<div class="col-xs-8" id="look_bankAccount">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">纳税识别编号：</label>
						<div class="col-xs-8" id="look_ratepaying">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">信用天数：</label>
						<div class="col-xs-8" id="look_creditDays">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">信用金额：</label>
						<div class="col-xs-8" id="look_creditMoney">
							123456
						</div>
					</div>

					<div class="form-group">
						<label  class="col-xs-4 control-label">邮箱：</label>
						<div class="col-xs-8" id="look_mailbox">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">备注：</label>
						<div class="col-xs-8" id="look_remark">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">币种：</label>
						<div class="col-xs-8" id="look_currency">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">发票类型：</label>
						<div class="col-xs-8" id="look_invoiceType">
							123456
						</div>
					</div>

					<div class="form-group">
						<label  class="col-xs-4 control-label">常用电话：</label>
						<div class="col-xs-8" id="look_commonPhone">
							123456
						</div>
					</div>
					<div class="form-group">
						<label  class="col-xs-4 control-label">备用电话：</label>
						<div class="col-xs-8" id="look_reservePhone">
							123456
						</div>
					</div>

					<div class="form-group">
						<label  class="col-xs-4 control-label">传真：</label>
						<div class="col-xs-8" id="look_fax">
							123456
						</div>
					</div>
				</div>
				
				<div id="product_box_parent">
					<div class="row">
						<div class="col-xs-12">
							<div class="form-group">
								<label class="col-xs-2 control-label"><b>往来产品</b></label>
								<div class="col-xs-10" id="">
								</div>
							</div>
						</div>
					</div>
					<div id="product_box" class="row nonowrap-table-div">
										<table class="table table-bordered table-striped table-hover" border="" cellspacing="0" cellpadding="0">
											<tbody id="goodsTbodyDetail">
												<tr>
													<th nowrap="nowrap">货品名称</th>
													<th nowrap="nowrap">规格编码</th>
													<th nowrap="nowrap">规格</th>
													<th nowrap="nowrap">单位</th>
													<th nowrap="nowrap">移动平均价</th>
													<th nowrap="nowrap">默认税率</th>
													<th nowrap="nowrap">销售单价</th>
												</tr>
											</tbody>
										</table>
						
					</div>
				</div>

			</form>


		</div>

		
	</body>

	<script>
		  $('#select_location0').citys();
		  
		  /*详情*/
			function customerDetail(rowData) {
				//获取往来产品信息
				$.ajax({
					url :'<%=basePath%>/basic/supctoCommodity/selectSupctoCommodityBySupctoId' ,
					type : "POST",
					dataType : "json",
					data: {
						"supctoId" : rowData.id,
						"flag" : 1
					},
					success : function(data) {
						if(data.length==0){
							$("#product_box_parent").css("display","none");
						}else{
							$("#product_box_parent").css("display","block");
							$("#goodsTbodyDetail").html(`<tr>
									<th nowrap="nowrap">货品名称</th>
									<th nowrap="nowrap">规格编码</th>
									<th nowrap="nowrap">规格</th>
									<th nowrap="nowrap">单位</th>
									<th nowrap="nowrap">移动平均价</th>
									<th nowrap="nowrap">默认税率</th>
									<th nowrap="nowrap">销售单价</th>
								</tr>`)
						}
						
						for ( var i= 0; i< data.length; i++) {
							let specifications = data[i].commoditySpecification.specificationName;
							let baseUnit = data[i].unit.name;
							let name = data[i].commodity.name;
							
							let identifier = data[i].commoditySpecification.specificationIdentifier;
							let baseMiniPrice = data[i].commoditySpecification.baseMiniPrice;
							let taxes = data[i].commodity.taxes;
							
							let price = data[i].price;
					
							let $goods=`<tr><td>` + name + `</td>
										<td>` + identifier + `</td>
										<td>` + specifications + `</td>
										<td>` + baseUnit + `</td>
										<td>` + baseMiniPrice + `</td>
										<td>` + taxes + `</td>
										<td>` + price + `</td>
									</tr>`; 
							
							$("#goodsTbodyDetail").append($goods);
							
							
						}
					}
				});
				switch (rowData.useable) {
				case 1:
					$("#look_useable").html("未停用");
					break;
				case 2:
					$("#look_useable").html("已停用");
					break;
				
				default:
					$("#look_useable").html("");
					break;
				}
				
				$("#look_identifier").html(rowData.identifier);
				
				switch (rowData.state) {
				case 1:
					$("#look_state").html("未送审");
					break;
				case 2:
					$("#look_state").html("待审核");
					break;
				case 3:
					$("#look_state").html("已通过");
					break;
				case 4:
					$("#look_state").html("已驳回");
					break;
				case 5:
					$("#look_state").html("停用待审核");
					break;
				case 6:
					$("#look_state").html("停用审核驳回");
					break;
				case 7:
					$("#look_state").html("已停用");
					break;
				case 8:
					$("#look_state").html("已恢复使用");
					break;
				case 9:
					$("#look_state").html("修改待审核");
					break;
				case 10:
					$("#look_state").html("修改审核驳回");
					break;
				case 11:
					$("#look_state").html("已删除");
					break;
				default:
					$("#look_state").html("");
					break;
				}
				$("#look_name").html(rowData.name);
				//$("#look_information").html(rowData.information);
				if(rowData.classification!=null){
					$("#look_classification").html(rowData.classification.name);
				}else{
					$("#look_classification").html("");
				}
				
				$("#look_fullName").html(rowData.fullName);
				
				switch (rowData.frade) {
				case 1:
					$("#look_frade").html("一级");
					break;
				case 2:
					$("#look_frade").html("二级");
					break;
				case 3:
					$("#look_frade").html("三级");
					break;
				default:
					$("#look_frade").html("");
					break;
				}
				
				
				switch (rowData.fromType) {
				case 1:
					$("#look_fromType").html("账期");
					break;
				case 2:
					$("#look_fromType").html("现金");
					break;
				
				default:
					$("#look_fromType").html("");
					break;
				}
				
				$("#look_settlementType").html(rowData.settlementType.name);
				
				/* switch (rowData.shippingModeId) {
				case 1:
					$("#look_transportMode").html("自提");
					break;
				case 2:
					$("#look_transportMode").html("到库");
					break;
				
				default:
					$("#look_transportMode").html("");
					break;
				} */
				if(rowData.shippingMode!=null){
					$("#look_transportMode").html(rowData.shippingMode.name);
				}else{
					$("#look_transportMode").html("");
				}
				
				$("#look_contactPeople").html(rowData.contactPeople);
				$("#look_phone").html(rowData.phone);
				$("#look_postcode").html(rowData.postcode);
				$("#look_deliveryAddress").html(rowData.deliveryAddress);
				$("#look_communicationAddress").html(rowData.communicationAddress);
				$("#look_mnemonicCode").html(rowData.memoryCode);
				$("#look_taxes").html(rowData.taxes);
				//$("#look_member").html(rowData.member);
				$("#look_website").html(rowData.website);
				
				$("#look_operator").html(rowData.user.name);
				$("#look_operatorTime").html(getSmpFormatDateByLong(rowData.operatorTime, true));
				
				$("#look_province").html(rowData.province+rowData.city+rowData.area);
				//$("#look_otherInformation").html(rowData.otherInformation);
				if(rowData.department!=null){
					$("#look_department").html(rowData.department.name);
				}else{
					$("#look_department").html("");
				}
				
				if(rowData.person!=null){
					$("#look_person").html(rowData.person.name);
				}else{
					$("#look_person").html("");
				}
				
				
				$("#look_bank").html(rowData.bank);
				$("#look_bankAccount").html(rowData.bankAccount);
				$("#look_ratepaying").html(rowData.ratepaying);
				if(rowData.creditDays!=null){
					$("#look_creditDays").html(rowData.creditDays+"天");
				}else{
					$("#look_creditDays").html("");
				}
				if(rowData.creditMoney!=null){
					$("#look_creditMoney").html(rowData.creditMoney+"元");
				}else{
					$("#look_creditMoney").html("");
				}
				
				
				$("#look_mailbox").html(rowData.mailbox);
				$("#look_remark").html(rowData.remark);
				
				switch (rowData.currency) {
				case 1:
					$("#look_currency").html("人民币");
					break;
				default:
					$("#look_currency").html("");
					break;
				}
				
				switch (rowData.invoiceType) {
				case 1:
					$("#look_invoiceType").html("增票");
					break;
				case 2:
					$("#look_invoiceType").html("普票");
					break;
				
				default:
					$("#look_invoiceType").html("");
					break;
				}
				$("#look_commonPhone").html(rowData.commonPhone);
				$("#look_reservePhone").html(rowData.reservePhone);
				$("#look_fax").html(rowData.fax);
				
				layer.open({
					type: 1,
					title: "客户详情",
					closeBtn: 1,
					area: ['100%', '100%'],
					content: $("#lookDiv"),
					btn: ['关闭'],
					end: function(index, layero) {
						layer.close(index);
						
					}
				});
			}
		/*通过*/
		function customerCheck() {
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
			
			publicMessageLayer("通过选中的客户的审核", function() {
				$.ajax({
					url :'<%=basePath%>basic/supctoManager/editPass',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
						"customerOrSupplier":1
						
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
		/*驳回*/
		function customerTimes() {
			
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
			publicMessageLayer("驳回选中的客户的审核", function() {
				$.ajax({
					url :'<%=basePath%>basic/supctoManager/editReject',
					type: "POST",
					dataType: "json",
					async: false,
					cache: false,
					data: {
						"ids" : ids,
						"customerOrSupplier":1
						
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
			
			/* 一级分类下拉框赋值 */
			$.ajax({
				url :'<%=basePath%>/basic/classification/selectAllOneClassifityByType' ,
				type : "POST",
				dataType : "json",
				data: {
					"type" : 1
				},
				success : function(data) {
					if(data.length==0){
						$("#query_classification_one_id").append("<option value='-1' selected>--暂无数据，请到一级分类页面进行添加--</option>");	
					}else{
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
							$("#query_classification_one_id").append(option);
							option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
							$("#classification_one_id").append(option);
						}
					}
					
				}
			});
			$("#query_classification_one_id").change(function(){
				var parentId=$("#query_classification_one_id").val()-0;
				
				if(parentId>0){
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
							if(data.length==0){
								$("#query_classification_two_id").append("<option value='-1' selected>--暂无数据，请到二级分类页面进行添加--</option>");	
							}else{
								$("#query_classification_two_id").append('<option value="-1" selected="selected">--请选择--</option>');
								for ( var i = 0; i < data.length; i++) {
									var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
									$("#query_classification_two_id").append(option);
									
								}
							}
						}
					});
				}else{
					$("#query_classification_two_id").html("");
					$("#query_classification_two_id").append("<option value='-1' selected>--请先选择一级分类--</option>");	
				}
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
								"flag":6,
								"customerOrSupplier":1,
								//添加额外的参数传给服务器(可以多个)
								"classificationId": $("#query_classification_two_id").val(),
								"name": $("#query_name").val(),
								"operatorIdentifier": $("#query_operatorIdentifier").val(),
								"provinceCode":typeof($("#query_province_code").val()) == "undefined"?-1:$("#query_province_code").val(),
								"cityCode":(!$("#query_city_code").val() && typeof($("#query_city_code").val())!="undefined" && $("#query_city_code").val()!=0)?-1:$("#query_city_code").val(),
								"areaCode":typeof($("#query_area_code").val()) == "undefined"?-1:$("#query_area_code").val(),
								"operatorTime": $("#query_time").val()
							});
						},
						"url": "<%=basePath%>basic/supctoManager/dataTables"
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
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								return '<td><span class="look-span" onclick=\'customerDetail(' + JSON.stringify(row) + ')\'>'+data+'</span></td>';
							}
								
						}, {
							"mData": "name",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center"
						}, {
							"mData": "classification.name",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								if(data!=null) return data;
								return '';
							}

						}, {
							"mData": "frade",
							"bSortable": false,
							"sWidth": "7%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								switch (data) {
								case 1:
									return '一级';
									break;
								case 2:
									return '二级';
									break;
								case 3:
									return '三级';
									break;
								
								default:
									return '';
									break;
								}
							}
							
						},{
							"mData": "phone",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center",
						},{
							"mData": "contactPeople",
							"bSortable": false,
							"sWidth": "7%",
							"sClass": "center",
						},{
							"mData": "province",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								if (data!=null && data!="") return data+row.city+row.area;
								return "";
							}
						}, {
							"mData": "state",
							"bSortable": false,
							"sWidth": "5%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								switch (data) {
								case 1:
									return '未送审';
									break;
								case 2:
									return '待审核';
									break;
								case 3:
									return '已通过';
									break;
								case 4:
									return '已驳回';
									break;
								case 5:
									return '停用待审核';
									break;
								case 6:
									return '停用审核驳回';
									break;
								case 7:
									return '已停用';
									break;
								case 8:
									return '已恢复使用';
									break;
								case 9:
									return '修改待审核';
									break;
								case 10:
									return '修改审核驳回';
									break;
								case 11:
									return '已删除';
									break;
								default:
									break;
								}
							}
						},{
							"mData": "user.name",
							"bSortable": false,
							"sWidth": "10%",
							"sClass": "center",
							"mRender": function(data,type,row) {
								if(data!=null&&data!=""){
									if(row.user!=null){
										return row.operatorIdentifier+"("+data+")";
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
							"mData": "state",
							"bSortable": false,
							"sWidth": "20%",
							"sClass": "center",
							"mRender": function(data, type, row) {
								return '<td><input type="button" class="btncss edit" onclick=\'customerDetail(' + JSON.stringify(row) + ')\' value="详情" /></td>';
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
		
		
		
		
			
			
			

		
		
	</script>

</html>