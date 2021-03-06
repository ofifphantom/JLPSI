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
		<title>应收款单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		 <%@include file="/common.jsp"%>
		 <link
			href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css"
			rel="stylesheet" type="text/css">
		 <script
			src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/billOrder.js" type="text/javascript"></script>
		
		<style type="text/css">
			#editDiv,#detailDiv {
				padding-top: 20px;
			}
			#bill{
			width: 100%;
			}
			#dateSearch{
			width:190px
			}
			.searchable-select-holder {
			    padding: 6px;
			    background-color: #fff;
			    background-image: none;
			    border: 1px solid #d5d5d5;
			    /* border-radius: 4px; */
			    min-height: 30px;
			    box-sizing: border-box;
			    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
			    box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
			    -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
			    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
			    width: 270px;
			}
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">应收款单</h4>
					<div class="search-div clearfix" >
						<div class="clearfix">
							<span class="l_f"> 
							往来单位：
									<select  id="query_customerSupplierId" >
										<option value="">--请选择往来单位--</option>
									
									</select>
							   <!-- <input type="text" id="query_customerSupplierId" value="" onblur="cky(this)"/> -->
						</span>
							<span class="l_f"> 
							单号： <input type="text" id="query_billsCode" value="" onblur="cky(this)"/>
						</span>
							<span class="l_f"> 
								日期： <input type="text"  value="" id="dateSearch" placeholder="请选择日期" readonly="readonly" />
							</span>
							<span class="r_f"> 
							<input type="button"  class="btncss btn_search" id="btn_search" value="搜索" />
						</span>
						</div>

					</div>
					<div class="opration-div clearfix">

						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="advancesReceivedAdd()"><i class="fa fa-plus"></i> 新增</button>
						</span>

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>单号 </th>
									<th>往来单位</th>
									<th>实际结算</th>
									<th>银行</th>
									<th>银行账户</th>
									<th>制单人</th>
									<th>创建时间</th>
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
			 <input type="text" class="form-control hidden" id="edit_id" />
			
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="jl-panel" id="headEdit">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">往来单位</label>
								
								<div class="col-xs-8" id="edit_supctoIdDiv">
									<select id="intercourseUnit" class="form-control">
									</select>
								</div>
							</div>
								<div class="form-group" style="color: red;">
								<label for="" class="col-xs-4 control-label">预收金额</label>
								<div class="col-xs-8">
									<span id="advanceMoney">0</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row jl-title">
					<span>单据引用</span>
					<i class="r_f"> 
						<button type="button" class="btncss jl-btn-importent" onclick="documentReference()">引用单据</button>
					</i>
					<i class="r_f">
					<select id="bill" disabled="disabled" >
						<option value="-1">--请选择单据--</option>
						<option value="123" attr-date="date" attr-money="1000" attr-alreadyPrice="90">44</option>
					</select>
					</i>
				</div>
				<div class="row">
					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="billTbody">
							<tr>
								<th>单据编号</th>
								<th>单据日期</th>
								<th>开单金额</th>
								<th>已结算金额</th>
								<th>待结算金额</th>
								<th>本次结算</th>
								<th>收款</th>
								<th>实收金额</th>
								<th>备注</th>
								<th>单据类型</th>
								<th>折扣%</th>
								<th>折扣金额</th>
								<th>操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="13">请先选择单据</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="row jl-title">
					<span>收款</span>
				</div>
				<div class="jl-panel" id="middleEdit">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">币种</label>
								<div class="col-xs-8">
									<input type="text" id="currency" class="form-control"  value="人民币" disabled="disabled"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="totalAmount" value=""  disabled="disabled"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">结算方式</label>
								<div class="col-xs-8">
									<select id="payment" class="form-control">
										 
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6" id="payment_money_div">
							<!-- <div class="form-group">
								<label for="" class="col-xs-4 control-label">预付金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="payment_money" value=""/>
								</div>
							</div> -->
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">收款账户</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="account" value="" onblur="cky(this)"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">开户银行</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="bank" value="" onblur="cky(this)"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">银行账号</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="bankAccount" value="" onblur="cky(this)"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">票号</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="ticketNo" value="" onblur="cky(this)"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">备注</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="remark" value="无" onblur="cky(this)"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="jl-panel" id="footerEdit">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门</label>
								<div class="col-xs-8">
										<select id="department_id" class="form-control" name="departmentId" >
									<option value="-1" selected="selected">--请选择--</option>
								
								</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员</label>
							<div class="col-xs-8">
							<select id="person_id" class="form-control" name="personId" >
							 	<option value="-1" selected="selected">--请先选择部门--</option>
								
						 	</select>
						</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="summary" value="无" onblur="cky(this)"/>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">分支机构</label>
								<div class="col-xs-8">
									<select class="form-control">
										<option value="-1">--请选择分支机构--</option>
										<option value="1">总部</option>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="text-danger">注：该页面所有字段均为必填</div>
			</form>

		</div>
		<div id="detailDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label" >日期：</label>
								<div class="col-xs-8" id="de_billsDate">
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label"  >单号：</label>
								<div class="col-xs-8" id="de_billsCode">
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label" >往来单位：</label>
								<div class="col-xs-8" id="de_customerSupplierName">
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">收款类型：</label>
								<div class="col-xs-8">
									应收款
								</div>
							</div>
						</div>
						 <div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label"  >预收金额：</label>
								<div class="col-xs-8" id="de_balance">
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row jl-title">
					<span>单据</span>
				</div>
				<div class="row">
					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="detailTbody">
							<tr>
								<th>单据编号</th>
								<th>单据日期</th>
								<th>开单金额</th>
								<th>已结算金额</th>
								<th>待结算金额</th>
								<th>本次结算</th>
								<th>收款</th>
								<th>实收金额</th>
								<th>备注</th>
								<th>单据类型</th>
								<th>折扣%</th>
								<th>折扣金额</th>
							</tr>
				 
						</tbody>
					</table>
				</div>
				
				<div class="row jl-title">
					<span>收款</span>
				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">币种：</label>
								<div class="col-xs-8">
									人民币
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">金额：</label>
								<div class="col-xs-8" id="de_money">
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">结算方式：</label>
								<div class="col-xs-8" id="de_paymentName" >
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">收款账户：</label>
								<div class="col-xs-8" id="de_account">
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">开户银行：</label>
								<div class="col-xs-8" id="de_bank">
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">银行账号：</label>
								<div class="col-xs-8" id="de_bankAccount">
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">票号：</label>
								<div class="col-xs-8" id="de_ticketNo">
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">备注：</label>
								<div class="col-xs-8" id="de_remark">
									
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门：</label>
								<div class="col-xs-8" id="de_departmentName">
									
								</div>
							</div>
						</div>
 
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员：</label>
								<div class="col-xs-8" id="de_personName">
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">制单人：</label>
								<div class="col-xs-8" id="de_originatorName">
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要：</label>
								<div class="col-xs-8" id="de_summary">
									
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">分支机构：</label>
								<div class="col-xs-8" id="de_branch">
									
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</form>

		</div>

	</body>

	<script>
	laydate.render({
        elem: "#dateSearch",
        range:'~'
    });
		let goodsArr=[];
		$(function(){
				/*加载部门列表 */
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
				
				//加载业务员列表
				$("#department_id").change(function(){
					if($("#department_id").val()==-1){
						$("#person_id").empty();
						$("#person_id").append('<option value="-1" selected="selected">--请先选择部门--</option>');
					}
					else{
						person(0);
					}
		
				})
				getAllSettlementType();
				
				
				$("#payment").on("change",function(){
					if($("#payment").val()==1){
						$("#payment_money_div").html(`<div class="form-group">
								<label for="" class="col-xs-4 control-label">预收金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="payment_money" value="" onkeyup="pressMoney(this)"/>
								</div>
							</div>`);
					}else{
						$("#payment_money_div").html("");
					}
				})
		})
		
		      /* 获取所有结算方式*/
		        function getAllSettlementType(){
		            $.ajax({
		                url: '<%=basePath%>basic/settlementType/getAllSettlementType',
		                type: "POST",
		                dataType: "json",
		                async: false,
		                cache: false,
		                success: function(data) {

		                    if(data.length==0){
		                        $("#payment").append("<option value='-1' selected>--暂无数据，请到结算方式页面进行添加。--</option>");
		                    }
		                    else{
		                        $("#payment").append("<option value='-1' selected>--请选择--</option>");
		                        for(var i=0;i<data.length;i++){
		                            var option = $("<option value='"+data[i].id+"'>"
		                                + data[i].name + "</option>");
		                            $("#payment").append(option);
		                        }
		                    }
		                }
		            });
				}
		
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
		
		/*修改*/
		function advancesReceivedEdit() {
			/*
			 * 请在此处添加页面内容赋值代码
			 */
			
			orderBillEdit("应收款单",function(){
				/*
				 * 请在此处添加点击提交按钮后的代码
				 */
			})
		}
		/*新增*/
		function advancesReceivedAdd() {
			//加载客户消息
			initIntercourseUnitSelect();
			
			//初始化预收金额
 			$("#advanceMoney").html(0);
			//初始化单据select
 			$('#bill').parent().html('<select id="bill"  disabled="disabled"><option value="-1">--请选择往来单位-</option></select>');
			orderBillAdd("应收款单",function(index){
 				var orderType=1;
				$("#billTbody .subData").each(function(index, val){
	    			 
		    		  if($(val).find(".ltypeName").html()=="销售退货"){
		    			  orderType=2;
		    		  }
		    	 
		     });
				
				if(checkInputHaveZero("thisSettlement")){
					layfail("本次结算金额不得为0！");
				}else if(orderType==1&&($("#totalAmount").val()-0)>($("#advanceMoney").html()-0)){
					layfail("预收金额不足");
 				}else{
					/*
					 * 请在此处添加点击提交按钮后的代码
					 */
	 				$.ajax({
						url: '<%=basePath%>receivable/bills/saveBills',
						type: "POST",
						dataType: "json",
						data:{
							"billsJson":JSON.stringify(getDataJSON())
						},
						async: false,
						cache: false,
						success: function(data) {
							if(data.success) {
								laysuccess(data.msg);
								oTable1.fnDraw(false);
								$("#checkAll").removeAttr("checked");
							} else {
								layfail(data.msg);
							}
							layer.close(index);
							laysuccess("应收款单保存成功");
						}
					});
				}  
			
			})
		}
		
		/*详情*/
		function advancesReceivedDetail(row){
			/*
			 * 请在此处添加页面内容赋值代码
			 */
 
			 <%-- $.ajax({
	                url: '<%=basePath%>/receivable/bills/detail',
	                type: "POST",
	                dataType: "json",
	                async: false,
	                cache: false,
	                data:{
 	                	"billsId":row.id
	                },
	                success: function(data) {
	                	
	               	 if(data.success){
	               		var bills=data.bills;
	               		var subList=bills.billsSubs;
	               		
	               		var billsDate= getSmpFormatDateByLong(bills.billsDate,false);
	        			$("#de_billsDate").html(billsDate);
	        			$("#de_billsCode").html(bills.billsCode);
	        			$("#de_customerSupplierName").html(bills.customerSupplierName);
	        			$("#de_money").html(bills.money);
	        			$("#de_paymentName").html(bills.paymentName);
	        			$("#de_account").html(bills.account);
	        			$("#de_bank").html(bills.bank);
	        			$("#de_bankAccount").html(bills.bankAccount);
	        			$("#de_ticketNo").html(bills.ticketNo);
	        			$("#de_remark").html(bills.remark);
	        			$("#de_personName").html(bills.personName);
	        			$("#de_departmentName").html(bills.departmentName);
	        			$("#de_summary").html(bills.summary);
	        			$("#de_branch").html(bills.branch);
	        			$("#de_originatorName").html(bills.originatorName);
	        			$("#de_balance").html(bills.balance);
	        			
	        			//清空旧数据
	        			$("#detailTbody  tr:not(:first)").html("");  
	        			//循环加载新数据
	               		for(var i=0;i<subList.length;i++){
	               			var clearingMoney=0;
	               			if(subList[i].clearingMoney!=null){
	               				clearingMoney=subList[i].clearingMoney;
	               			}
	               			var orderTime=getSmpFormatDateByLong(subList[i].orderTime, true); 
	               			var tr="<tr><td>"+subList[i].identifier+"</td><td>"+orderTime+"</td><td>"+subList[i].orderMoney+"</td><td>"+clearingMoney+"</td><td>"+subList[i].stayMoney+"</td><td>"+subList[i].theMoeny+"</td>"+
	               			"<td>是</td><td>"+subList[i].actualMoney+"</td><td>"+subList[i].remark+"</td><td>销售订单</td><td>"+subList[i].rebate+"</td><td>"+subList[i].rebateMoney+"</td></tr>";
	        			
	               			$("#detailTbody").append(tr);
	                	}
	               	 }else{
	               		layfail("请求异常");
	               	 }
	                }
	            }); --%>
	            $("#detailDiv").html("");
				$.ajax({
					type: "post",
					url: "<%=basePath%>receivable/bills/billsDetail",
					dataType : "json",
					data: {
						"id" : row.id
					},
					success: function(res) {
						let bill = new DetailBill(res,2);
						let $content = bill.toPrint();
						$("#detailDiv").html($content);
					}
				});
			
			orderBillDetail("应收款单");
		}
		
		
		

		
 
		
		
		/*单据引用*/
		function documentReference() {
			let documentNum = $("#bill").val();
			let procureSalesId=$("#bill option:selected").attr("procureSalesId");
			let datetime = $("#bill option:selected").attr("attr-date");
			let price = $("#bill option:selected").attr("attr-money")-0;
			let clearingMoney=$("#bill option:selected").attr("attr-alreadyPrice")-0;
			let type=$("#bill option:selected").attr("attr-type")-0;
			var typeName="";
			var ltypeName="";
			if(type==1){
				typeName="销售开单";
			}else{
				typeName="销售退货";
			}
			
			$("#billTbody .subData").each(function(index, val){
				ltypeName=$(val).find(".ltypeName").html();
	    	 
    			});
 			if($("#intercourseUnit").val()=="-1"){
				layfail("请先选择往来单位!");
			}else if(documentNum == -1) {
				layfail("请先选择单据!");
			}else if(ltypeName!=""&&ltypeName!=typeName){
				layfail("请选择相同单据类型! ");
			
			}else if(!checkRepeat(documentNum,goodsArr)) {
				$(".tipTr").remove();
				goodsArr.push(documentNum);
				if(type==1){
					typeName="销售开单";
				}else{
					typeName="销售退货";
				}
				 
				$("#billTbody").append('<tr class="subData"><td style="display:none" class="subId"></td><td style="display:none" class="procureSalesId">'+procureSalesId+'</td><td class="documentNum">' + documentNum + '</td><td>' + datetime + '</td><td class="price">' + price + 
					'</td><td class="clearingMoney">'+clearingMoney+'</td></td><td class="amountToBeSettled">'+toDecimal2((price-clearingMoney))+'</td>' +
					'<td><input type="text" class="form-control thisSettlement" onkeyup="countThisSettlement(this)" attr-name="本次结算" /></td>' +
					'<td>是</td>' +
					'<td><input type="text" class="form-control amountPayment" disabled="disabled" attr-name="实收金额"/></td>' +
					'<td><input type="text" class="form-control remark" onblur="cky(this)" attr-name="备注" value="无"/></td>' +
					'<td class="ltypeName">'+typeName+'</td>' +
					'<td><input type="text" class="form-control discount" onkeyup="countDiscount(this)" attr-name="折扣" value="100"/></td>' +
					'<td><input type="text" class="form-control discountPrice" disabled="disabled" attr-name="折扣金额" value="0.00"/></td>' +
					'<td><input type="button" class="btncss edit form-control" onclick="billDel(this)" value="删除" /></td></tr>');
			} else {
				layfail("请勿重复选择单据！");
			}
		}

		
		

		/*删除商品*/
		function billDel(thisbtn) {
			let documentNum = $(thisbtn).parents("tr").find(".documentNum").html();
			goodsArr.remove(documentNum);
			$(thisbtn).parents("tr").remove();
			countTotalAmount();
			if($("#billTbody tr").length == 1) {
				$("#billTbody").append('<tr class="tipTr"><td colspan="13">请先选择单据</td></tr>');
			}
		}

		/*查重*/
		function checkRepeat(id,goodsArr) {
			let flag = false;
			for(var i in goodsArr) {
				if(goodsArr[i] == id) {
					flag = true;
				}
			}
			return flag;
		}

		/*清空商品*/
		function clearBill() {
			$("#billTbody").html('<tr><th>单据编号</th><th>单据日期</th><th>开单金额</th><th>已结算金额</th><th>待结算金额</th><th>本次结算</th>'
				+'<th>收款</th><th>实收金额</th><th>备注</th><th>单据类型</th><th>折扣%</th><th>折扣金额</th><th>操作</th></tr>'
				+'<tr class="tipTr"><td colspan="13">请先选择单据</td></tr>');
			goodsArr = [];
			countTotalAmount();
		}
		
		//初始化往来单位
		function initIntercourseUnitSelect() {
			$("#intercourseUnit").parent().html('<select id="intercourseUnit" class="form-control"><option value="-1">--请选择往来单位--</option></select>');

			 $.ajax({
	                url: '<%=basePath%>basic/supctoManager/getSupctoMsgByCustomerOrSupplier',
	                type: "POST",
	                dataType: "json",
	                async: false,
	                cache: false,
	                data:{
	                	"customerOrSupplier":1
	                },
	                success: function(data) {
	                	for(var i=0;i<data.length;i++){
	                		var advanceMoney=data[i].advanceMoney==null?0:data[i].advanceMoney;
		                	$('#intercourseUnit').append('<option data-advanceMoney="'+advanceMoney+'" value="'+data[i].id+'">'+data[i].name+'</option>')
		                	$('#query_customerSupplierId').append('<option  value="'+data[i].id+'">'+data[i].name+'</option>')
	                	}
	                	$("#intercourseUnit").searchableSelect();
	                }
	            });

			
		}
		
		
		/*往来单位change事件*/
		function getCommodityMsg(value){
			clearBill();
			if(value=="-1"){
				$('#bill').parent().html('<select id="bill"  disabled="disabled"><option value="-1">--请选择往来单位--</option></select>');
			}else{
				var advanceMoney= $("#intercourseUnit option:selected").attr("data-advanceMoney");
				$("#advanceMoney").html(toDecimal2(advanceMoney));
				$('#bill').attr("disabled",false);
				$('#bill').parent().html('<select id="bill" ><option value="-1">--请选择单据--</option></select>');
				
				 $.ajax({
		                url: '<%=basePath%>/receivable/bills/returnSales',
		                type: "POST",
		                dataType: "json",
		                async: false,
		                cache: false,
		                data:{
		                	"supctoId":value,
  		                },
		                success: function(data) {
		                	
		               	 if(data.success){
		               		var subList=data.subList;
		               		var returnList=data.returnList;
		               		if(subList.length==0&&subList.length==0){
		               			$('#bill').parent().html('<select id="bill" disabled="disabled"><option value="-1">暂无引用单据</option></select>');
		               			return;
		               		}
		               		for(var i=0;i<subList.length;i++){
		               			var clearingMoney=0;
		               			if(subList[i].clearingMoney!=null){
		               				clearingMoney=toDecimal2(subList[i].clearingMoney);
		               			}
		               			var orderTime=getSmpFormatDateByLong(subList[i].orderTime, true);
 		        				$('#bill').append('<option value="'+subList[i].identifier+'" procureSalesId="'+subList[i].procureSalesId+'"attr-date="'+orderTime+'" attr-money="'+toDecimal2(subList[i].orderMoney)+'" attr-alreadyPrice="'+clearingMoney+'"  attr-type="1" >'+'销售开单'+subList[i].identifier+'</option>')
 		        			}
		               		for(var i=0;i<returnList.length;i++){
		               			var clearingMoney=0;
		               			if(returnList[i].clearingMoney!=null){
		               				clearingMoney=toDecimal2(returnList[i].clearingMoney);
		               			}
		               			var orderTime=getSmpFormatDateByLong(returnList[i].orderTime, true);
 		        				$('#bill').append('<option value="'+returnList[i].identifier+'" procureSalesId="'+returnList[i].procureSalesId+'"attr-date="'+orderTime+'" attr-money="'+toDecimal2(returnList[i].orderMoney)+'" attr-alreadyPrice="'+clearingMoney+'" attr-type="2">'+'销售退货'+returnList[i].identifier+'</option>')
 		        			}
		               		$("#bill").searchableSelect();
		               	 }else{
		               		layfail("请求异常");
		               	 }
		                }
		            });
		 
			}
		}
		/*关于折扣金额的onkeyup事件*/
		function countDiscount(thisInput){
			/*正则*/
			pressIntegersOneHundred(thisInput);
			
			/*计算*/
			let parentTr=$(thisInput).parents("tr");
			
			let discount=$(thisInput).val()-0;
			
			if(parentTr.find(".thisSettlement").val()!=""){
				
				parentTr.find(".amountPayment").val(toDecimal2((parentTr.find(".thisSettlement").val()-0)*discount*0.01));
				parentTr.find(".discountPrice").val(toDecimal2((parentTr.find(".thisSettlement").val()-0)-(parentTr.find(".amountPayment").val()-0)));
			}
			countTotalAmount()
		}
		
		
		/*关于本次结算金额的onkeyup事件*/
		function countThisSettlement(thisInput){
			
			/*正则*/
			pressMoney(thisInput);
			/*计算*/
			let parentTr=$(thisInput).parents("tr");
			
			if($(thisInput).val()!=""){
				let thisSettlement=$(thisInput).val()-0;
				/* if(thisSettlement==0){
					layfail("本次结算金额不能为0！");
					$(thisInput).val("");
					parentTr.find(".discountPrice").val("");
					parentTr.find(".amountPayment").val("");
				}else  */if(thisSettlement>(parentTr.find(".amountToBeSettled").html()-0)){
					layfail("本次结算金额不能大于待结算金额！");
					$(thisInput).val("");
					parentTr.find(".discountPrice").val("");
					parentTr.find(".amountPayment").val("");
				}else{
					if(parentTr.find(".discount").val()!=""){
						let discount=parentTr.find(".discount").val()-0;
						parentTr.find(".amountPayment").val(toDecimal2((parentTr.find(".thisSettlement").val()-0)*discount*0.01));
						parentTr.find(".discountPrice").val(toDecimal2((parentTr.find(".thisSettlement").val()-0)-(parentTr.find(".amountPayment").val()-0)));
					}else{
						
						parentTr.find(".amountPayment").val(parentTr.find(".thisSettlement").val()-0);
					}
				}
			}else{
				parentTr.find(".discountPrice").val("");
				parentTr.find(".amountPayment").val("");
			}
			countTotalAmount()
		}
		
		/*计算总金额*/
		function countTotalAmount(){
			let totalAmount=0;
			$(".amountPayment").each(function(index,obj){
				if($(obj).val()!=""){
					totalAmount+=($(obj).val()-0);
				}
			})
			$("#totalAmount").val(toDecimal2(totalAmount));
		}
		
    	/* 提交或者编辑时 把数据整合成json传入后台 */
    	function getDataJSON(){
     		 var orderType=1;
    		//应收款单
    		 var  billsDataJson={"id":$("#edit_id").val(),"customerSupplierId":$("#intercourseUnit").val(),"billsType":1,"bank":$("#bank").val(),
    				"bankAccount":$("#bankAccount").val(),"payment":$("#payment").val(),"personId":$("#person_id").val(),"ticketNo":$("#ticketNo").val(),"money":$("#totalAmount").val(),
    				"remark":$("#remark").val(),"summary":$("#summary").val(),"account":$("#account").val(),
    				"billsSubs":[]}; 
    		if($("#payment").val()==1){
    			billsDataJson.balance=$("#payment_money").val();
    		}
 
    		//获取应收款单子信息，加入应收款单主信息
    		$("#billTbody .subData").each(function(index, val){
    			 
    		  if($(val).find(".ltypeName").html()=="销售退货"){
    			  orderType=2;
    		  }
    			var billsSubsDataJSON={"procureSalesId":$(val).find(".procureSalesId").html(),"clearingMoney":$(val).find(".clearingMoney").html(),"stayMoney":$(val).find(".amountToBeSettled").html(),
    					"theMoeny":$(val).find(".thisSettlement").val(),"actualMoney":$(val).find(".amountPayment").val(),"rebateMoney":$(val).find(".discountPrice").val(),
    					"rebate":$(val).find(".discount").val(),"remark":$(val).find(".remark").val()};	
    		
    			billsDataJson.billsSubs[index]=billsSubsDataJSON;	
    			});
    		billsDataJson.orderType=orderType;
    		
    		return billsDataJson; 
    	}
    	
    	//分页
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
									//添加额外的参数传给服务器(可以多个)
							"page":1,
							 "billsType":1,
							"billsCode": $("#query_billsCode").val(),
							"customerSupplierId": $("#query_customerSupplierId").val(),
							"dateSearch":$("#dateSearch").val()
						});
					},
					"url": "<%=basePath%>receivable/bills/dataTables"
				},
				"aoColumns": [ 
					
					{
						"mData": "billsCode",
						"bSortable": false,
						"sClass": "center",
						"sWidth": "15%",
						"mRender" : function(data, type, row) {
							return '<td><span class="look-span"    onclick=\'advancesReceivedDetail(' + JSON.stringify(row) + ')\'>'
									+ data
									+ '</span></td>';
						}
					},
					{
						"mData": "customerSupplierName",
						"bSortable": false,
						"sClass": "center",
						"sWidth": "15%",
						
					},
					{
						"mData": "money",
						"bSortable": false,
						"sClass": "center",
						"sWidth": "15%",
						
					},
					{
						"mData": "bank",
						"bSortable": false,
						"sClass": "center",
						"sWidth": "15%",
						
					},
					{
						"mData": "bankAccount",
						"bSortable": false,
						"sClass": "center",
						"sWidth": "15%",
						
					},
					{
						"mData": "originatorName",
						"bSortable": false,
						"sClass": "center",
						"sWidth": "15%",
						
					},
					{
						"mData": "billsDate",
						"bSortable": false,
						"sClass": "center",
						"sWidth": "15%",
						"mRender": function(data) {
								if(data!=null&&data!=""){
								return getSmpFormatDateByLong(data, true);
							}else{
								return "";
								}
							
						}
					},
					
					{
						"mData": "id",
						"bSortable": false,
						"sWidth": "10%",
						"sClass": "center",
						"mRender": function(data, type, row) {

							return '<td><input type="button" class="btncss edit"' +
								'onclick=\'advancesReceivedDetail(' + JSON.stringify(row) + ')\' value="详情" />'
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