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
		<title>修改供应商信息</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		<link href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
	    <script src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
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
			
			#product_box{
				border-top: 1px solid #DEDEDE;
			}
			.product-unit{
				border: 1px solid #DEDEDE;
				border-top: none;
				padding-top: 15px;
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
					<h4 class="text-title">修改供应商信息</h4>
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
					<!-- 		<span class="l_f" id="select_location0" style="margin-left: 38px;">
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
						</span> -->
							<span class="l_f"> 
							单位名称： <input type="text"  id="query_name" onblur="cky(this)"/>
						</span>
							<span class="l_f"> 
							往来类型：
							<select id="query_from_type" >
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">账期</option>
								<option value="2">现金</option>
							</select>
						</span>
						<span class="l_f"> 
							状态：<select id="query_state" name="">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="3">已通过</option>
								<option value="6" >停用审核驳回</option>
								<option value="9" >修改待审核</option>
								<option value="10" >修改审核驳回</option>
								<option value="8" >已恢复使用</option>
							</select>
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
						

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>编号</th>
									<th>单位名称</th>
									<th>分类</th>
									<th>等级</th>
									<th>联系电话</th>
									<th>联系人</th>
									
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
				<div class="row">
					<div class="col-xs-6">
		
						<div class="form-group">
							<label class="col-xs-4 control-label">是否停用：</label>
							<div class="col-xs-8" id="look_useable">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">编号：</label>
							<div class="col-xs-8" id="look_identifier">
								123456
							</div>
						</div>
		
						<div class="form-group">
							<label class="col-xs-4 control-label">状态：</label>
							<div class="col-xs-8" id="look_state">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">供应商名称：</label>
							<div class="col-xs-8" id="look_name">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label"> 供应商编码：</label>
							<div class="col-xs-8" id="look_mnemonicCode">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">所属分类：</label>
							<div class="col-xs-8" style="padding-right: 0;" id="look_classification">
								123456
							</div>
						</div>
		
						<div class="form-group">
							<label class="col-xs-4 control-label">全称：</label>
							<div class="col-xs-8" id="look_fullName">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">供应商等级：</label>
							<div class="col-xs-8" id="look_frade">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">往来类型：</label>
							<div class="col-xs-8" id="look_fromType">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">结算方式：</label>
							<div class="col-xs-8" id="look_settlementType">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">运输方式：</label>
							<div class="col-xs-8" id="look_transportMode">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">联系人：</label>
							<div class="col-xs-8" id="look_contactPeople">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">联系手机：</label>
							<div class="col-xs-8" id="look_phone">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">邮编：</label>
							<div class="col-xs-8" id="look_postcode">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">供应商地址：</label>
							<div class="col-xs-8" id="look_deliveryAddress">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">通讯地址：</label>
							<div class="col-xs-8" id="look_communicationAddress">
								123456
							</div>
						</div>
		
						<div class="form-group">
							<label class="col-xs-4 control-label">默认税率：</label>
							<div class="col-xs-8" id="look_taxes">
								123456
							</div>
						</div>
		
						
		
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="col-xs-4 control-label">操作人：</label>
							<div class="col-xs-8" id="look_operator">
								AAA
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">操作时间：</label>
							<div class="col-xs-8" id="look_operatorTime">
								2018.02.14
							</div>
						</div>
					<!-- 	<div class="form-group">
							<label class="col-xs-4 control-label">地区：</label>
							<div class="col-xs-8" id="look_province">
								123456
							</div>
						</div> -->
		
						<div class="form-group">
							<label class="col-xs-4 control-label">部门：</label>
							<div class="col-xs-8" id="look_department">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">业务员：</label>
							<div class="col-xs-8" id="look_person">
								123456
							</div>
						</div>
		
						<div class="form-group">
							<label class="col-xs-4 control-label">开户银行：</label>
							<div class="col-xs-8" id="look_bank">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">银行账号：</label>
							<div class="col-xs-8" id="look_bankAccount">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">纳税识别编号：</label>
							<div class="col-xs-8" id="look_ratepaying">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">信用天数：</label>
							<div class="col-xs-8" id="look_creditDays">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">信用金额：</label>
							<div class="col-xs-8" id="look_creditMoney">
								123456
							</div>
						</div>
		
						<div class="form-group">
							<label class="col-xs-4 control-label">邮箱：</label>
							<div class="col-xs-8" id="look_mailbox">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">备注：</label>
							<div class="col-xs-8" id="look_remark">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">币种：</label>
							<div class="col-xs-8" id="look_currency">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">发票类型：</label>
							<div class="col-xs-8" id="look_invoiceType">
								123456
							</div>
						</div>
		
						<div class="form-group">
							<label class="col-xs-4 control-label">常用电话：</label>
							<div class="col-xs-8" id="look_commonPhone">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">备用电话：</label>
							<div class="col-xs-8" id="look_reservePhone">
								123456
							</div>
						</div>
		
						<div class="form-group">
							<label class="col-xs-4 control-label">传真：</label>
							<div class="col-xs-8" id="look_fax">
								123456
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-4 control-label">网址：</label>
							<div class="col-xs-8" id="look_website">
								123456
							</div>
						</div>
					</div>
		
				</div>
	
		
			</form>
		
		</div>

		<!--新增 编辑 -->
		<div id="editDiv" style="display: none;">
			<form class="col-xs-11" id="editDivForm">
				<div class="col-xs-6">
					<div class="form-group" style="display: none;">
						<label for="customer_or_supplier" class="col-xs-4 control-label">供应商</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="customer_or_supplier"  name="customerOrSupplier" value="2" />
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-xs-4 control-label"><span class="asterisk">*</span> 供应商名称</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="name" name="name" onblur="cky(this)" maxlength="100" disabled="true"/>
						</div>
					</div>
					<div class="form-group">
						<label for="mnemonic_code" class="col-xs-4 control-label"><span class="asterisk">*</span> 供应商编码</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="mnemonic_code"  name="memoryCode" onblur="cky(this)" maxlength="100" disabled="true"/>
						</div>
					</div>
					<div class="form-group">
						<label for="chooseOne" class="col-xs-4 control-label">所属分类</label>
						<div class="col-xs-4" style="padding-right: 0;">
							<select id="classification_one_id" class="form-control" style="border-right: 0;">
								<option value="-1" selected="selected">--请选择--</option>
								
							</select>
						</div>
						<div class="col-xs-4" style="padding-left: 0;">
							<select id="classification_two_id" class="form-control" name="classificationId">
								<option value="-1" selected="selected">--请先选择一级分类--</option>
								
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="full_name" class="col-xs-4 control-label">全称</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="full_name" name="fullName" onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="frade" class="col-xs-4 control-label">供应商等级</label>
						<div class="col-xs-8">
							<select id="frade" class="form-control" name="frade">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">一级</option>
								<option value="2">二级</option>
								<option value="3">三级</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="from_type" class="col-xs-4 control-label">往来类型</label>
						<div class="col-xs-8">
							<select id="from_type" class="form-control" name="fromType">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">账期</option>
								<option value="2">现金</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="settlement_type_id" class="col-xs-4 control-label"><span class="asterisk">*</span> 结算方式</label>
						<div class="col-xs-8">
							<select id="settlement_type_id" class="form-control" name="settlementTypeId" disabled="true">
								<option value="-1" selected="selected">--请选择--</option>
								
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="transport_mode" class="col-xs-4 control-label">运输方式</label>
						<div class="col-xs-8">
							<select id="transport_mode" class="form-control" name="shippingModeId">
								<option value="-1" selected="selected">--请选择--</option>
								<!-- <option value="1">自提</option>
								<option value="2">到库</option> -->
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="contact_people" class="col-xs-4 control-label"><span class="asterisk">*</span> 联系人</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="contact_people" name="contactPeople" onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="phone" class="col-xs-4 control-label"><span class="asterisk">*</span> 联系方式</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="phone" name="phone" onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="phone" class="col-xs-4 control-label">邮编</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="postcode" name="postcode" onblur="cky(this)"/>
						</div>
					</div>
					<div class="form-group">
						<label for="delivery_address" class="col-xs-4 control-label"><span class="asterisk">*</span> 供应商地址</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="delivery_address" name="deliveryAddress" onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="communication_address" class="col-xs-4 control-label">通讯地址</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="communication_address" name="communicationAddress"  onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					
					<div class="form-group">
						<label for="taxes" class="col-xs-4 control-label">默认税率</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="taxes" name="taxes" onblur="cky(this)" onkeyup="pressSmallNumZero(this)" placeholder="请填写小数 (如：税率10%  请填写0.1)"/>
						</div>
					</div>
					
						<div class="form-group">
						<label for="website" class="col-xs-4 control-label">网址</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="website" name="website"  onblur="cky(this)" maxlength="100"/>
						</div>
					</div>

				</div>
				<div class="col-xs-6">
				<!-- 	<div class="form-group">
						<label for="province" class="col-xs-4 control-label">地区</label>
						<div class="col-xs-8" id="select_location">
							<select id="province" name="province" class="col-xs-4">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">河南省</option>
							</select>
							<select id="city" name="city" class="col-xs-4" style="border-left: 0;">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">洛阳市</option>
							</select>
							<select id="area" name="area" class="col-xs-4" style="border-left: 0;">
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">西工区</option>
							</select>
						</div>
						<div class="form-group" style="display: none;">
							<input type="text" class="form-control" id="province_code"  name="provinceCode" value=""/>
							<input type="text" class="form-control" id="city_code"  name="cityCode" value=""/>
							<input type="text" class="form-control" id="area_code"  name="areaCode" value=""/>
						</div>
					</div> -->
					
					<div class="form-group">
						<label for="department_id" class="col-xs-4 control-label">部门</label>
						<div class="col-xs-8">
							<select id="department_id" class="form-control" name="departmentId" >
								<option value="-1" selected="selected">--请选择--</option>
								
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="person_id" class="col-xs-4 control-label">业务员</label>
						<div class="col-xs-8">
							<select id="person_id" class="form-control" name="personId" >
								<option value="-1" selected="selected">--请先选择部门--</option>
								
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="bank" class="col-xs-4 control-label">开户银行</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="bank"  name="bank"  onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="bank_account" class="col-xs-4 control-label">银行账号</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="bank_account" name="bankAccount"   onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="ratepaying" class="col-xs-4 control-label"><span class="asterisk">*</span> 纳税识别编号</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="ratepaying"  name="ratepaying"  onblur="cky(this)" maxlength="100" disabled="true"/>
						</div>
					</div>
					<div class="form-group">
						<label for="credit_days" class="col-xs-4 control-label">信用天数</label>
						<div class="col-xs-7">
							<input type="text" class="form-control" id="credit_days"  name="creditDays"  onblur="cky(this)" onkeyup="pressInteger(this)" maxlength="9"/>
						</div>
						<div class="col-xs-1">天</div>
					</div>
					<div class="form-group">
						<label for="credit_money" class="col-xs-4 control-label">信用金额</label>
						<div class="col-xs-7">
							<input type="text" class="form-control" id="credit_money"  name="creditMoney"  onblur="cky(this)" onkeyup="pressMoney(this)"/>
						</div>
						<div class="col-xs-1">元</div>
					</div>

					<div class="form-group">
						<label for="mailbox" class="col-xs-4 control-label">邮箱</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="mailbox"  name="mailbox"  onblur="cky(this)"/>
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-4 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="remark"  name="remark" onblur="cky(this)" maxlength="100"/>
						</div>
					</div>
					<div class="form-group">
						<label for="currency" class="col-xs-4 control-label">币种</label>
						<div class="col-xs-8">
							<select id="currency" class="form-control"  name="currency" >
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">人民币</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="invoice_type" class="col-xs-4 control-label"><span class="text-danger">*</span> 发票类型</label>
						<div class="col-xs-8">
							<select id="invoice_type" class="form-control"  name="invoiceType" >
								<option value="-1" selected="selected">--请选择--</option>
								<option value="1">增票</option>
								<option value="2">普票</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="common_phone" class="col-xs-4 control-label">常用电话</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="common_phone"  name="commonPhone"  onblur="cky(this)"/>
						</div>
					</div>
					<div class="form-group">
						<label for="reserve_phone" class="col-xs-4 control-label">备用电话</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="reserve_phone" name="reservePhone" onblur="cky(this)" />
						</div>
					</div>

					<div class="form-group">
						<label for="fax" class="col-xs-4 control-label">传真</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="fax" name="fax" onblur="cky(this)" />
						</div>
					</div>
				
				</div>
				
				

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
		
		
		/* 一级分类下拉框赋值 */
		$.ajax({
			url :'<%=basePath%>/basic/classification/selectAllOneClassifityByType' ,
			type : "POST",
			dataType : "json",
			data: {
				"type" : 2
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
		
		/*部门下拉框赋值 */
		$.ajax({
			url :'<%=basePath%>/basic/department/getAllDepartment' ,
			type : "POST",
			dataType : "json",
			data: {},
			success : function(data) {
				if(data.length==0){
					$("#department_id").append("<option value='-1' selected>--暂无数据，请到部门维护页面进行添加--</option>");	
				}else{
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#department_id").append(option);
						
					}
				}
			}
		});
		$("#department_id").change(function(){
			var parentId=$("#department_id").val()-0;
			
			if(parentId>0){
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
							$("#person_id").append("<option value='-1' selected>--暂无数据，请到员工维护页面进行添加--</option>");	
						}else{
							$("#person_id").append('<option value="-1" selected="selected">--请选择--</option>');
							for ( var i = 0; i < data.length; i++) {
								var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
								$("#person_id").append(option);
							}
						}
					}
				});
			}else{
				$("#person_id").html("");
				$("#person_id").append("<option value='-1' selected>--请先选择部门--</option>");	
			}
		});
		
		
		/* 结算方式下拉框赋值 */
		$.ajax({
			url :'<%=basePath%>/basic/settlementType/getAllSettlementType' ,
			type : "POST",
			dataType : "json",
			data: {
				
			},
			success : function(data) {
				if(data.length==0){
					$("#settlement_type_id").append("<option value='-1' selected>--暂无数据，请到结算方式维护页面进行添加--</option>");	
				}else{
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#settlement_type_id").append(option);
					}
				}
			}
		});
		
		/* 运输方式下拉框赋值 */
		$.ajax({
			url :'<%=basePath%>/basic/shippingMode/getAllShippingMode' ,
			type : "POST",
			dataType : "json",
			data: {
				
			},
			success : function(data) {
				if(data.length==0){
					$("#transport_mode").append("<option value='-1' selected>--暂无数据，请到运输方式维护页面进行添加--</option>");	
				}else{
					for ( var i = 0; i < data.length; i++) {
						var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
						$("#transport_mode").append(option);	
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
		
		$("#classification_one_id").change(function(){
			var parentId=$("#classification_one_id").val()-0;
			
			if(parentId>0){
				/* 二级分类下拉框赋值 */
				$.ajax({
					url :'<%=basePath%>/basic/classification/selectAllTwoClassifityByParentId' ,
					type : "POST",
					dataType : "json",
					data: {
						"parentId" : $("#classification_one_id").val()
					},
					success : function(data) {
						$("#classification_two_id").empty();
						if(data.length==0){
							$("#classification_two_id").append("<option value='-1' selected>--暂无数据，请到二级分类页面进行添加--</option>");	
						}else{
							$("#classification_two_id").append('<option value="-1" selected="selected">--请选择--</option>');
							for ( var i = 0; i < data.length; i++) {
								var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
								$("#classification_two_id").append(option);
								
							}
						}
					}
				});
			}else{
				$("#classification_two_id").html("");
				$("#classification_two_id").append("<option value='-1' selected>--请先选择一级分类--</option>");	
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
							"flag":5,
							"customerOrSupplier":2,
							//添加额外的参数传给服务器(可以多个)
							
							"classificationId": $("#query_classification_two_id").val(),
							"name": $("#query_name").val(),
							"fromType": $("#query_from_type").val(),
							"state": $("#query_state").val(),
							"operatorTime": $("#query_time").val()
							/* "provinceCode":typeof($("#query_province_code").val()) == "undefined"?-1:$("#query_province_code").val(),
							"cityCode":(!$("#query_city_code").val() && typeof($("#query_city_code").val())!="undefined" && $("#query_city_code").val()!=0)?-1:$("#query_city_code").val(),
							"areaCode":typeof($("#query_area_code").val()) == "undefined"?-1:$("#query_area_code").val(), */
						});
					},
					"url": "<%=basePath%>basic/supctoManager/dataTables"
				},

				"aoColumns": [{
						"mData": "identifier",
						"bSortable": true,
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
							if(data == 9){
								return '<td><input type="button" class="btncss edit" onclick=\'customerDetail(' + JSON.stringify(row) + ')\' value="详情" /></td>';
							}else{
								return '<td><input type="button" class="btncss edit" onclick=\'customerEdit(' + JSON.stringify(row) + ')\' value="编辑" /></td>';
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
	
	
		/*详情*/
	function customerDetail(rowData) {
				
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
				
				//$("#look_province").html(rowData.province+rowData.city+rowData.area);
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
					title: "供应商详情",
					closeBtn: 1,
					area: ['100%', '100%'],
					content: $("#lookDiv"),
					btn: ['关闭']
				});
			}

		/*修改*/
		function customerEdit(rowData) {
			//console.log(rowData);
			if(rowData.classificationId!=null && rowData.classificationId!=-1){
				$.ajax({
					url :'<%=basePath%>/basic/classification/selectAllTwoClassifityByParentId' ,
					type : "POST",
					dataType : "json",
					data: {
						"parentId" : rowData.classification.parentId
					},
					success : function(data) {
						$("#classification_two_id").empty();
						$("#classification_two_id").append('<option value="-1" selected="selected">--请选择二级分类--</option>');
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
							$("#classification_two_id").append(option);
							
						}
						$("#classification_two_id").val(rowData.classificationId);
					}
				});
			}
			
			if(rowData.departmentId!=null && rowData.departmentId!=-1){
				$.ajax({
					url :'<%=basePath%>/basic/person/getAllPersonByDepartmentIdAndBusiness' ,
					type : "POST",
					dataType : "json",
					data: {
						"departmentId" : rowData.departmentId
					},
					success : function(data) {
						$("#person_id").empty();
						$("#person_id").append('<option value="-1" selected="selected">--请选择--</option>');
						for ( var i = 0; i < data.length; i++) {
							var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
							$("#person_id").append(option);
							
						}
						$("#person_id").val(rowData.personId);
					}
				});
			}
			
			$("#customer_or_supplier").val("2");
			$("#identifier").val(rowData.identifier);
			
			//$("#province").val(rowData.provinceCode);
			//$("#city").val(rowData.cityCode);
			//$("#area").val(rowData.areaCode);
			
			$("#select_location").citys({province:rowData.province,city:rowData.city,area:rowData.areaCode});
			
			
			$("#state").val(rowData.state);
			$("#name").val(rowData.name);
			//$("#information").val(rowData.information);
			
			if(rowData.classification!=null){
				$("#classification_one_id").val(rowData.classification.parentId);
			}
			
			$("#full_name").val(rowData.fullName);
			$("#frade").val(rowData.frade==null?"-1":rowData.frade);
			$("#from_type").val(rowData.fromType==null?"-1":rowData.fromType);
			
			
			$("#settlement_type_id").val(rowData.settlementTypeId);
			//$("#transport_mode").val(rowData.shippingModeId);
			if(rowData.shippingModeId!=null){
				$("#transport_mode").val(rowData.shippingModeId);
			}
			
			$("#contact_people").val(rowData.contactPeople);
			$("#phone").val(rowData.phone);
			$("#postcode").val(rowData.postcode);
			$("#delivery_address").val(rowData.deliveryAddress);
			$("#communication_address").val(rowData.communicationAddress);
			$("#mnemonic_code").val(rowData.memoryCode);
			$("#taxes").val(rowData.taxes);
			//$("#member").val(rowData.member);
			$("#website").val(rowData.website);
			
			
			//$("#other_information").val(rowData.otherInformation);
			
			if(rowData.departmentId!=null && rowData.departmentId!=-1){
				$("#department_id").val(rowData.departmentId);
			}
			$("#bank").val(rowData.bank);
			$("#bank_account").val(rowData.bankAccount);
			$("#ratepaying").val(rowData.ratepaying);
			$("#credit_days").val(rowData.creditDays);
			$("#credit_money").val(rowData.creditMoney);
			$("#mailbox").val(rowData.mailbox);
			$("#remark").val(rowData.remark);
			$("#currency").val(rowData.currency==null?"-1":rowData.currency);
			$("#invoice_type").val(rowData.invoiceType==null?"-1":rowData.invoiceType);
	
			$("#common_phone").val(rowData.commonPhone);
			$("#reserve_phone").val(rowData.reservePhone);
			$("#fax").val(rowData.fax);
			
			
			layer.open({
				type: 1,
				title: "编辑供应商",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					
					
					 if($("#name").val() == "") {
						laywarn("供应商名称不能为空!");
						return false;
					} else if($("#mnemonic_code").val() == "") {
						laywarn("供应商 编码不能为空!");
						return false;
					}else if($("#settlement_type_id").val() == -1 ) {
						laywarn("请选择结算方式!");
						return false;
					} else if($("#contact_people").val() == "") {
						laywarn("联系人不能为空!");
						return false;
					}else if($("#ratepaying").val() == "") {
						laywarn("纳税识别编号不能为空!");
						return false;
					}else if($("#phone").val() == "") {
						laywarn("联系方式不能为空!");
						return false;
					}else if(isnotEmpty($("#phone").val())&&!checkMobilePhone($("#phone").val())){
						laywarn("请输入正确的联系方式!");
						return false;
					}else if($("#delivery_address").val() == "") {
						laywarn("供应商地址不能为空!");
						return false;
					}else if($("#invoice_type").val() == "-1") {
						laywarn("请选择发票类型!");
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
					}else if(isnotEmpty($("#website").val())&&!checkWebsite($("#website").val())){
						laywarn("请输入正确的网址!");
						return false;
					}else if(isnotEmpty($("#fax").val())&&!checkFax($("#fax").val())){
						laywarn("请输入正确的传真!");
						return false;
					}
					 
					
						
						
						
		 
					var formData = new FormData($("#editDivForm")[0]);
					
					$.ajax({
						url :'<%=basePath%>/basic/supctoManager/editSupctoById?id='+rowData.id,
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
				},
				end: function(index, layero) {
					layer.close(index);
					clearForm("editDiv", "");
				}
			});
		}
		
		
	</script>

</html>