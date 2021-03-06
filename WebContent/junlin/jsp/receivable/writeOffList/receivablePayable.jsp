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
		<title>核销单(应收冲应付)</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<%@include file="/common.jsp"%>
		<link
			href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css"
			rel="stylesheet" type="text/css">
		 <script
			src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
		
		<style>
			#editDiv,
			#detailDiv {
				padding-top: 20px;
			}
			 #customerBill{
			width: 100%;
			}	
			 #supplierBill{
			width: 100%;
			}			
			#dateSearch{
			width:190px
			}
			#edit_supctoId_kehu_Div,#edit_supctoIdDiv{
			z-index:3;
			}
			#customerBillDiv .searchable-select	{
			z-index:2;
			}	
		</style>
	</head>

	<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">核销单(应收冲应付)</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
								<span class="l_f"> 
							应收单位：
									<select  id="query_companyOne" >
										<option value="">--请选择往来单位--</option>
									
									</select>
 						</span>
							<span class="l_f"> 
							应付单位：
									<select  id="query_companyTwo" >
										<option value="">--请选择往来单位--</option>
									
									</select>
 						</span>
				
							<span class="l_f"> 
							单号： <input type="text" id="query_writeoffCode" value="" onblur="cky(this)"/>
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
							<button type="button" class="btncss jl-btn-defult" onclick="prepaidBillAdd()"><i class="fa fa-plus"></i> 新增</button>
						</span>

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>单号 </th>
									<th>应收单位</th>
									<th>应付单位</th>
									<th>结算金额</th>
									<th>制单人</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
					<!-- 			<tr>
									<td>
										<span class="look-span" onclick="billDetail()">PO.2017.09.00054</span>
									</td>
									<td>预收冲应收</td>
									<td>1111</td>
									<td>#####</td>
									<td>#####</td>
									<td>#####</td>
									<td>#####</td>
									<td>#####</td>
									<td>
										<input type="button" class="btncss edit" onclick="billDetail()" value="详情" />
									</td>
								</tr> -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		
		<!--新增 (核销方式：应收冲应付，应付冲应收) -->
		<div id="editDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="jl-panel" id="headEdit">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">核销方式</label>
								<div class="col-xs-8">
									<select class="form-control" disabled="disabled" id="verificationMethod_add56">
										<option value="-1">--请选择核销方式--</option>
										<option value="1">预收冲应收</option>
										<option value="2">预付冲应付</option>
										<option value="3">应付转应付 </option>
										<option value="4">应收转应收</option>
										<option value="5">应收冲应付</option>
										<option value="6">应付冲应收</option>
										<option value="7">预收转预收</option>
										<option value="8">预付转预付</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户</label>
								<div class="col-xs-8" id="edit_supctoId_kehu_Div">
									<select class="form-control" id="customer">
										<option value="-1">--请选择客户--</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">供应商</label>
								<div class="col-xs-8" id="edit_supctoIdDiv">
									<select class="form-control" id="supplier">
										<option value="-1">--请选择供应商--</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">凭证号</label>
								<div class="col-xs-8">
									<input type="text" id="voucherNo" class="form-control" onblur="cky(this)" />
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row jl-title">
					<span>客户单据引用</span>
					<i class="r_f"> 
						<button type="button" class="btncss jl-btn-importent" onclick="documentReference('customer')">引用单据</button>
					</i>
					<i class="r_f" id="customerBillDiv">
					<select id="customerBill" disabled="disabled"  style="width: 100%">
						<option value="-1">--请选择单据--</option>
						<option value="123" attr-date="date" attr-money="1000" attr-alreadyPrice="100">44</option>
					</select>
					</i>
				</div>
				<div class="row">
					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="customerBillTbody">
							<tr>
								<th>单据编号</th>
								<th>单据日期</th>
								<th>总金额</th>
								<th>已结算金额</th>
								<th>未结算金额</th>
								<th>本次核销</th>
								<th>核销</th>
								<th>备注</th>
								<th>操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="9">请先选择单据</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="row jl-title">
					<span>供应商单据引用</span>
					<i class="r_f"> 
						<button type="button" class="btncss jl-btn-importent" onclick="documentReference('supplier')">引用单据</button>
					</i>
					<i class="r_f">
					<select id="supplierBill" disabled="disabled"  style="width: 100%">
						<option value="-1">--请选择单据--</option>
						<option value="123" attr-date="date" attr-money="1000" attr-alreadyPrice="100">44</option>
					</select>
					</i>
				</div>
				<div class="row">
					<table class="table table-bordered table-striped table-hover col-xs-12" border="" cellspacing="0" cellpadding="0">
						<tbody id="supplierBillTbody">
							<tr>
								<th>单据编号</th>
								<th>单据日期</th>
								<th>总金额</th>
								<th>已结算金额</th>
								<th>未结算金额</th>
								<th>本次核销</th>
								<th>核销</th>
								<th>备注</th>
								<th>操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="9">请先选择单据</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户核销总金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="customerTotalAmount" value="" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">供应商核销总金额</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="" id="supplierTotalAmount" value="" disabled="disabled" />
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
									<select class="form-control" id="branch">
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
		
			
		
		<!--详情 (核销方式：应收冲应付，应付冲应收) -->
		<div id="detailDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">日期：</label>
								<div class="col-xs-8" id="de_createDate">
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单号：</label>
								<div class="col-xs-8" id="de_writeoffCode">
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">核销方式：</label>
								<div class="col-xs-8">
								应收冲应付
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label intercourseUnit1">应收客户：</label>
								<div class="col-xs-8" id="de_companyOneName">
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label intercourseUnit2">应付供应商：</label>
								<div class="col-xs-8" id="de_companyTwoName">
								</div>
							</div>
						</div>
		 
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
								<label for="" class="col-xs-4 control-label">汇率：</label>
								<div class="col-xs-8">
									1
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">凭证号：</label>
								<div class="col-xs-8" id="de_voucherNo">
									
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row jl-title">
					<span>客户单据引用</span>
					
				</div>
				<div class="row">
					<table class="table  table-bordered table-striped table-hover col-xs-12"  id="customerDetail" border="" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<th>单据编号</th>
								<th>单据日期</th>
								<th>总金额</th>
								<th>已结算金额</th>
								<th>未结算金额</th>
								<th>本次核销</th>
								<th>核销</th>
								<th>备注</th>
 							</tr>
<!-- 							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr> -->
						</tbody>
					</table>
				</div>

				<div class="row jl-title">
					<span>供应商单据引用</span>
					
				</div>
				<div class="row">
					<table class="table table-bordered table-striped table-hover col-xs-12"  id="supplierDetail" border="" cellspacing="0" cellpadding="0">
						<tbody >
							<tr>
								<th>单据编号</th>
								<th>单据日期</th>
								<th>总金额</th>
								<th>已结算金额</th>
								<th>未结算金额</th>
								<th>本次核销</th>
								<th>核销</th>
								<th>备注</th>
 							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="jl-panel">
					<div class="row">
						<div class="col-md-6 col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label"  >核销总金额：</label>
								<div class="col-xs-8" id="de_money">
									
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
		var billsArr = [];
		$(function() {
			/*请在此处添加页面内下拉框的option添加事件*/
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
				//搜索框加载
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
	  		                	//搜索框加载
			                	$('#query_companyOne').append('<option  value="'+data[i].id+'">'+data[i].name+'</option>')
		                	}
		                }
	      	});
				//搜索框加载
				 $.ajax({
		                url: '<%=basePath%>basic/supctoManager/getSupctoMsgByCustomerOrSupplier',
		                type: "POST",
		                dataType: "json",
		                async: false,
		                cache: false,
		                data:{
		                	"customerOrSupplier":2
		                },
		                success: function(data) {
		                	for(var i=0;i<data.length;i++){
	  		                	//搜索框加载
	                         $('#query_companyTwo').append('<option  value="'+data[i].id+'">'+data[i].name+'</option>')
		                	}
		                }
	      	});
		})
/* 业务员下拉框赋值 */
				function person(personId){
			
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
		/*新增*/
		function prepaidBillAdd() {
			$("#verificationMethod_add56").val(5);

			/*请在后台查找到有未核销销售订单的客户，并在此处向customer添加option*/
			$("#customer").parent().html('<select class="form-control" id="customer"><option value="-1">--请选择客户--</option></select>');
			
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
 						$('#customer').append('<option  value="'+data[i].id+'">'+data[i].name+'</option>')
					
					}
					$("#customer").searchableSelect();
				}
			});
		
			/*请在后台查找到有未核销采购订单的供应商，并在此处向supplier添加option*/
			$("#supplier").parent().html('<select class="form-control" id="supplier"><option value="-1">--请选择供应商--</option></select>');
					$.ajax({
				url: '<%=basePath%>basic/supctoManager/getSupctoMsgByCustomerOrSupplier',
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				data:{
					 "customerOrSupplier":2
				},
				success: function(data) {
					for(var i=0;i<data.length;i++){
 						$('#supplier').append('<option  value="'+data[i].id+'">'+data[i].name+'</option>')
					
					}
					$("#supplier").searchableSelect();
				}
			});
			openLayer("editDiv", function(openLayerIndex) {
				if(amountAllowableCustomerSupplier()) {
					$.ajax({
						url: '<%=basePath%>receivable/writeoff/saveWriteOff',
						type: "POST",
						dataType: "json",
						data:{
							"writeOffJson":JSON.stringify(getDataJSON())
						},
						async: false,
						cache: false,
						success: function(data) {
							if(data.success) {
								layer.close(openLayerIndex);
								laysuccess("核销单提交成功")
 								$("#checkAll").removeAttr("checked");
							} else {
								layfail("核销异常");
							}
						 
						}
					});
				}
			})
		
		}
    	/* 提交或者编辑时 把数据整合成json传入后台 */
    	function getDataJSON(){
     		var companyOne=$("#customer").val(); 
     		var companyTwo=$("#supplier").val();
     		var money=$("#supplierTotalAmount").val();
     		var personId=$("#person_id").val();
     		var summary=$("#summary").val();
     		var voucherNo=$("#voucherNo").val();
     		var branch=$("#branch").val();
    		//应收款单
    		 var  dataJson={"type":5,"companyOne":companyOne,"companyTwo":companyTwo,"money":money,
    				"personId":personId,"summary":summary,"voucherNo":voucherNo,"branch":branch,
    				"writeOffSubs":[]}; 
    		//获取客户应收款单子信息，加入应收款单主信息   
    		 
    		$("#customerBillTbody .subData").each(function(index,val){
     					var procureSalesId=$(val).find(".procureSalesId").html();
    					var clearMoney=$(val).find(".alreadyPrice").html();
    					var stayMoney=$(val).find(".unsettledAmount").html();
    					var theMoney=$(val).find(".amountPayment").val();
    					var isWriteoff=$(val).find(".isWriteoff").val();
    					var remark=$(val).find(".remark").val();
    					 
    			var subsDataJSON={"procureSalesId":procureSalesId,"clearMoney":clearMoney,"stayMoney":stayMoney,
    					"theMoney":theMoney,"isWriteoff":isWriteoff,"remark":remark,"isProcureSales":1};
    					 	
    				
    					dataJson.writeOffSubs.push(subsDataJSON);	
    			});
    		//获取供应商应收款单子信息，加入应收款单主信息   
    		$("#supplierBillTbody .subData").each(function(index,val){
     					var procureSalesId=$(val).find(".procureSalesId").html();
    					var clearMoney=$(val).find(".alreadyPrice").html();
    					var stayMoney=$(val).find(".unsettledAmount").html();
    					var theMoney=$(val).find(".amountPayment").val();
    					var isWriteoff=$(val).find(".isWriteoff").val();
    					var remark=$(val).find(".remark").val();
    					 
    				var subsDataJSON={"procureSalesId":procureSalesId,"clearMoney":clearMoney,"stayMoney":stayMoney,
    					"theMoney":theMoney,"isWriteoff":isWriteoff,"remark":remark,"isProcureSales":2};
    					 	
    				
    				dataJson.writeOffSubs.push(subsDataJSON);	
    			});
    		
    		return dataJson; 
    	}
		/*详情(类型：5应收冲应付、6应付冲应收)*/
		function billDetail(row) {
			/*
			 * 请在此处添加详情的赋值代码
			 */
			<%--  $.ajax({
	                url: '<%=basePath%>receivable/writeoff/detail',
	                type: "POST",
	                dataType: "json",
	                async: false,
	                cache: false,
	                data:{
	                	"writeoffId":row.id
	                },
	                success: function(data) {
	                	
	               	 if(data.success){
	               		var writeOff=data.writeOff;
	               		var subList=writeOff.writeOffSubs;
	               		
	               		var createDate= getSmpFormatDateByLong(writeOff.createDate,false);
	        			$("#de_createDate").html(createDate);
	        			$("#de_writeoffCode").html(writeOff.writeoffCode);
	        			$("#de_companyOneName").html(writeOff.companyOneName);
	        			$("#de_companyTwoName").html(writeOff.companyTwoName);
	        			$("#de_money").html(writeOff.money);
	        			$("#de_voucherNo").html(writeOff.voucherNo);
	        			$("#de_branch").html(writeOff.branch);
	        			$("#de_originatorName").html(writeOff.originatorName);
	        			$("#de_departmentName").html(writeOff.departmentName);
	        			$("#de_summary").html(writeOff.summary);
	        			
	        			
	        			//清空旧数据
	        			$("#customerDetail  tr:not(:first)").html("");
	        			$("#supplierDetail  tr:not(:first)").html("");
	        			//循环加载新数据
	               		for(var i=0;i<subList.length;i++){
	               			var identifier=subList[i].identifier;
	               			var orderTime=getSmpFormatDateByLong(subList[i].orderTime, true); 
	               			var orderMoney=subList[i].orderMoney;
	               			var clearMoney=subList[i].clearMoney;
	               			var stayMoney=subList[i].stayMoney;
	               			var theMoney=subList[i].theMoney;
	               			var isWriteoff=subList[i].isWriteoff==0?"未核销":"已核销";
	               			var remark=subList[i].remark;
	               			var isProcureSales=subList[i].isProcureSales;
	               			var tr='<tr ><td>'+ identifier +'</td><td>' + orderTime + '</td><td>'+orderMoney+'</td>'+
	               			'<td>'+clearMoney+'</td><td>'+stayMoney+'</td><td>'+theMoney+'</td><td>'+isWriteoff+'</td><td>'+remark+'</td>'
	               			if(isProcureSales==1){
	               				$("#customerDetail").append(tr);
	               			}else{
	               				$("#supplierDetail").append(tr);
	               			}
	                	}
	               	 }else{
	               		layfail("请求异常");
	               	 }
	                }
	            }); --%>
	            $("#detailDiv").html("");
				$.ajax({
					type: "post",
					url: "<%=basePath%>receivable/writeoff/writeOffDetail",
					dataType : "json",
					data: {
						"id" : row.id
					},
					success: function(res) {
						let bill = new DetailBill(res,3);
						let $content = bill.toPrint();
						$("#detailDiv").html($content);
					}
				});
			layer.open({
				type: 1,
				title: "核销单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#detailDiv"),
				btn: ['关闭'],
			});
			
		}

		/*
		 * 计算金额是否允许提交（type:5,6）
		 * 采购和销售相等*/
		function amountAllowableCustomerSupplier() {
			
			var customerTotalAmount = $("#customerTotalAmount").val() - 0;
			var supplierTotalAmount = $("#supplierTotalAmount").val() - 0;
			//console.log("supplierTotalAmount"+supplierTotalAmount+"customerTotalAmount"+customerTotalAmount);
			if(customerTotalAmount != supplierTotalAmount) {
				layfail("客户核销金额与供应商核销金额不相等！");
				return false;
			} else {
				return true;
			}
		}
		/*创建一个通用的打开新增核销单的layer的方法*/
		function openLayer(layerId, callFun) {
			$("#summary").val("无");
			layer.open({
				type: 1,
				title: "新增核销单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#" + layerId + ""),
				btn: ['提交', '取消'],
				yes: function(openLayerIndex) {
					if(checkFormFilled()) {
						if(checkInputHaveZero("amountPayment")){
							layfail("本次核销金额不得为0！");
						}else{
							callFun(openLayerIndex);
						}
						
					}
				},
				end: function(index, layero) {
 					layer.close(index);
					clearForm(layerId, "");
					clearBill("customerBillTbody");
					clearBill("supplierBillTbody");
					oTable1.fnDraw(false);
 					$('#customerBill').parent().html('<select id="customerBill"  disabled="disabled"><option value="-1">--请选择客户--</option></select>');
					$('#supplierBill').parent().html('<select id="supplierBill"  disabled="disabled"><option value="-1">--请选择供应商--</option></select>');
 				}
			});
		}
		/*判断金额是否为空  */
		function checkInputHaveZero(className){
			var res=false;
			$("#editDiv ."+className).each(function(index, val){
				if($(val).val()=="0"){
					res=true;
				}		
			});
			return res;
		}

		/*判断单据是否为空*/
		function checkFormFilled(DivId) {
			//判断表单是否填写完整 填写完整返回true,相反返回false
			var res = true;
			$("#headEdit select").each(function(index, val) {
				if($(val).val() == "-1" && res) {
					checkInputEmptyLayer(val);
					res = false;
				}
				
			});
			if(!res) return res;
			$("#headEdit input").each(function(index, val) {
				if($(val).val() == "" && (!$(val).hasClass("searchable-select-input")) && res) {
					checkInputEmptyLayer(val);
					res = false;
				}
				
			});
			if(!res) return res;
			if($("#customerBillTbody .tipTr").length > 0) {
				res = false;
				layfail("客户单据不能为空");
			}
			if(!res) return res;
			$("#customerBillTbody input").each(function(index, val) {
				if($(val).val() == "" && (!$(val).prop("disabled")) && res) {
					checkTableInputEmptyLayer(val);
					res = false;
				}
			});
			if(!res) return res;
			$("#customerBillTbody select").each(function(index, val) {
				if($(val).val() == "-1" && res) {
					checkTableInputEmptyLayer(val);
					res = false;
				}
			});
			if(!res) return res;
			if($("#supplierBillTbody .tipTr").length > 0) {
				res = false;
				layfail("供应商单据不能为空");
			}
			if(!res) return res;
			$("#supplierBillTbody input").each(function(index, val) {
				if($(val).val() == "" && (!$(val).prop("disabled")) && res) {
					checkTableInputEmptyLayer(val);
					res = false;
				}
			});
			if(!res) return res;
			$("#supplierBillTbody select").each(function(index, val) {
				if($(val).val() == "-1" && res) {
					checkTableInputEmptyLayer(val);
					res = false;
				}
			});
			if(!res) return res;
			$("#footerEdit select").each(function(index, val) {
				if($(val).val() == "-1" && res) {
					checkInputEmptyLayer(val);
					res = false;
				}
			});
			if(!res) return res;
			$("#footerEdit input").each(function(index, val) {
				if($(val).val() == "" && res) {
					checkInputEmptyLayer(val);
					res = false;
				}
			});
			
			
			return res;
		}
		
		function checkInputEmptyLayer(thisInput) {
			//判断footer或者header中Input框为空时弹出layer
			var $input = $(thisInput);
			var name = $input.parents(".form-group").find(".control-label").text();
			layfail(name + "不能为空");
		}
		
		function checkTableInputEmptyLayer(thisInput) {
			//判断table中Input框为空时弹出layer
			var $input = $(thisInput);
			var name = $input.attr("attr-name");
			layfail(name + "不能为空");
		}

		/*单据引用*/
		function documentReference(AdvanceIntercourseUnitId) {
			/*确定下拉菜单*/
			let selectid;
			let tbody ;
			let totalAmountId;
			if(AdvanceIntercourseUnitId == "customer") {
				selectid = "customerBill";
				tbody = "customerBillTbody";
				totalAmountId="customerTotalAmount";
			} else if(AdvanceIntercourseUnitId == "supplier") {
				selectid = "supplierBill";
				tbody = "supplierBillTbody";
				totalAmountId="supplierTotalAmount";
			}
			
			/*获取订单相关值*/
			let documentNum = $("#"+selectid).val();
			let datetime = $("#"+selectid+" option:selected").attr("attr-date");
			let price = $("#"+selectid+" option:selected").attr("attr-money");
			let alreadyPrice = $("#"+selectid+" option:selected").attr("attr-alreadyPrice");
			let procureSalesId=$("#"+selectid+" option:selected").attr("procureSalesId");
			/*判断并添加到table*/
			if($("#" + AdvanceIntercourseUnitId).val() == "-1") {
				if(AdvanceIntercourseUnitId == "customer") {
					layfail("请先选择客户!");
				} else if(AdvanceIntercourseUnitId == "supplier") {
					layfail("请先选择供应商!");
				}
			} else if(documentNum == -1) {
				layfail("请先选择单据!");
			} else if(!checkRepeat(documentNum, billsArr)) {
				$("#"+tbody+" .tipTr").remove();
				billsArr.push(documentNum);
				$("#"+tbody).append('<tr class="subData" ><td class="documentNum">' + documentNum + '</td><td style="display:none" class="procureSalesId">' + procureSalesId + '</td><td>' + datetime + '</td><td>' + price +
					'</td><td class="alreadyPrice">' + alreadyPrice + '</td><td class="unsettledAmount">' + toDecimal2((price - alreadyPrice)) + '</td>' +
					'<td><input type="text" class="form-control amountPayment" attr-name="本次核销" onkeyup="amountPaymentOnKeyUp(this,\''+totalAmountId+'\')" /></td>' +
					'<td><select class="form-control isWriteoff" attr-name="是否核销"><option value="-1">是否核销</option><option value="1">是</option><option value="0">否</option></select></td>' +
					'<td><input type="text" class="form-control remark" onblur="cky(this)" value="无" attr-name="备注"/></td>' +
					'<td><input type="button" class="btncss edit" onclick="billDel(this)" value="删除" /></td></tr>');
			} else {
				layfail("请勿重复选择单据！");
			}
		}

		/*删除单据*/
		function billDel(thisbtn) {
			let $tbody=$(thisbtn).parents("tbody");
			let documentNum = $(thisbtn).parents("tr").find(".documentNum").html();
			billsArr.remove(documentNum);
			$(thisbtn).parents("tr").remove();
			if($tbody.find("tr").length == 1) {
				$tbody.append('<tr class="tipTr"><td colspan="9">请先选择单据</td></tr>');
			}
			let totalAmountId;
			if($tbody.attr("id") == "customerBillTbody") {
				totalAmountId="customerTotalAmount";
			} else if($tbody.attr("id") == "supplierBillTbody") {
				totalAmountId="supplierTotalAmount";
			}
			countTotalAmount(totalAmountId);
		}

		/*单据查重*/
		function checkRepeat(id, billsArr) {
			let flag = false;
			for(var i in billsArr) {
				if(billsArr[i] == id) {
					flag = true;
				}
			}
			return flag;
		}
		

		/*清空单据*/
		function clearBill(id) {
			$("#"+id).html('<tr><th>单据编号</th><th>单据日期</th><th>总金额</th><th>已结算金额</th><th>未结算金额</th><th>本次核销</th><th>核销</th><th>备注</th><th>操作</th></tr>' +
				'<tr class="tipTr"><td colspan="9">请先选择单据</td></tr>');
			billsArr = [];
		}
		
		/*客户的值改变事件  #customer的值改变事件*/
		function selectSupctoMsg(thisSelect,value){
			orderChange(value,'customerBill');
		}
		/*供应商的值改变事件  #supplier的值改变事件*/
		function getCommodityMsg(value){
			orderChange(value,'supplierBill');
		}

		/*应收客户/供应商的change事件(类型：1，2)*/
		function orderChange(thisSelectValue, billId) {
			if(thisSelectValue == "-1") {
				var billType=(billId=="customerBill"?"客户":"供应商");
				$('#' + billId + '').parent().html('<select id="' + billId + '"  disabled="disabled"><option value="-1">--请选择'+billType+'--</option></select>');
			} else {
				$('#' + billId + '').attr("disabled", false);
				$('#' + billId + '').parent().html('<select id="' + billId + '" ><option value="-1">--请选择单据--</option></select>');
				
				var supctoType=billId=="customerBill"?1:2;
				$.ajax({
		                url: '<%=basePath%>receivable/writeoff/subList',
		                type: "POST",
		                dataType: "json",
		                async: false,
		                cache: false,
		                data:{
		                	"supctoId":thisSelectValue,
		                	"type":5,
		                	"supctoType":supctoType
		                },
		                success: function(data) {
		                	
		               	 if(data.success){
		               		var subList=data.subList;
		            		if(subList.length==0){
		            			if(supctoType==1){
			            			$('#customerBill').parent().html('<select id="customerBill"  disabled="disabled"><option value="-1">暂无引用单据</option></select>');
		            			}else{
			    					$('#supplierBill').parent().html('<select id="supplierBill"  disabled="disabled"><option value="-1">暂无引用单据</option></select>');
		            			} 
 		               			return;
		               		}
		               		for(var i=0;i<subList.length;i++){
		               			var clearMoney=0;
		               			if(subList[i].clearMoney!=null){
		               				clearMoney=toDecimal2(subList[i].clearMoney);
		               			}
		               			var orderTime=getSmpFormatDateByLong(subList[i].orderTime, true);
		        				//$('#bill').append('<option value="'+subList[i].identifier+'" procureSalesId="'+subList[i].procureSalesId+'"attr-date="'+orderTime+'" attr-money="'+subList[i].orderMoney+'" attr-alreadyPrice="'+clearingMoney+'">'+subList[i].identifier+'</option>')
		        				$('#' + billId + '').append('<option value="'+subList[i].identifier+'"procureSalesId="'+subList[i].procureSalesId+'" attr-date="'+orderTime+'" attr-money="'+toDecimal2(subList[i].orderMoney)+'" attr-alreadyPrice="'+clearMoney+'">'+subList[i].identifier+'</option>')
		                	}
		               		$('#' + billId + '').searchableSelect();
		               	 }else{
		               		layfail("请求异常");
		               	 }
		               }
		           });
				/*请在此处为单据下拉框赋值*/
				//$('#' + billId + '').append('<option value="44" attr-date="date" attr-money="1000" attr-alreadyPrice="100">44</option>')
				//$('#' + billId + '').append('<option value="22" attr-date="date" attr-money="10000" attr-alreadyPrice="1000">22</option>')
			}
			
			if(billId == "customerBill") {
				totalAmountId = "customerTotalAmount";
				clearBill("customerBillTbody");
			} else if(billId == "supplierBill") {
				totalAmountId = "supplierTotalAmount";
				clearBill("supplierBillTbody");
			}
			countTotalAmount(totalAmountId);
		}

		/*本次核销的onkeyup事件*/
		function amountPaymentOnKeyUp(thisInput,totalAmountId) {
			pressMoney(thisInput);

			if($(thisInput).val() != "") {
				let parentTr = $(thisInput).parents("tr");
				let unsettledAmount = parentTr.find(".unsettledAmount").html() - 0;
				let amountPayment = $(thisInput).val() - 0;
				/* if(amountPayment == 0) {
					layfail("本次核销金额不能为0！");
					$(thisInput).val("");
				} else  */if(unsettledAmount < amountPayment) {
					layfail("本次核销金额不能大于未结算金额！");
					$(thisInput).val("");
				}
			}
			countTotalAmount(totalAmountId);

		}

		/*计算总金额*/
		function countTotalAmount(totalAmountId) {
			let tbody ;
			if(totalAmountId == "customerTotalAmount") {
				tbody = "customerBillTbody";
			} else if(totalAmountId == "supplierTotalAmount") {
				tbody = "supplierBillTbody";
			}
			let totalAmount = 0;
			$("#"+tbody+" .amountPayment").each(function(index, obj) {
				if($(obj).val() != "") {
					totalAmount += ($(obj).val() - 0);
				}
			})
			let $totalAmountInput=$("#"+totalAmountId);
			$totalAmountInput.val(totalAmount);
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
						"page":1,
						 "type":5,
						"writeoffCode": $("#query_writeoffCode").val(),
						"companyOne": $("#query_companyOne").val(),
						"companyTwo": $("#query_companyTwo").val(),
						"dateSearch":$("#dateSearch").val()		 		
					});
				},
				"url": "<%=basePath%>receivable/writeoff/dataTables"
			},
			"aoColumns": [ 
				
				{
					"mData": "writeoffCode",
					"bSortable": false,
					"sClass": "center",
					"sWidth": "15%",
					"mRender" : function(data, type, row) {
						return '<td><span class="look-span"    onclick=\'billDetail(' + JSON.stringify(row) + ')\'>'
								+ data
								+ '</span></td>';
					}
				},
				{
					"mData": "companyOneName",
					"bSortable": false,
					"sClass": "center",
					"sWidth": "15%",
					
				},
				{
					"mData": "companyTwoName",
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
					"mData": "originatorName",
					"bSortable": false,
					"sClass": "center",
					"sWidth": "15%",
					
				},
				 
				{
					"mData": "createDate",
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
							'onclick=\'billDetail(' + JSON.stringify(row) + ')\' value="详情" />'
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