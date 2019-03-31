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
		<title>销售计划单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>
		<link
			href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css"
			rel="stylesheet" type="text/css">
		<script
			src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>
		<script src="${pageContext.request.contextPath}/junlin/script/form.js" type="text/javascript"></script>
		<style>
			#editDiv {
				padding-top: 20px;
			}
			#allgoodDivEdit .jl-panel{
				position:relative;
			}
			
		</style>
</head>
<body class="content">
		<div class="page-content clearfix">
			<div id="Member_Ratings">
				<div class="d_Confirm_Order_style" style="margin-top:10px;">
					<h4 class="text-title">销售计划单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
							<span class="l_f"> 
							单号： <input type="text" value="" id="query_identifier"/>
						</span>
							<span class="l_f"> 
							货品名称： <input type="text" value="" id="query_goodsName"/>
						</span>
							<span class="l_f"> 
							操作人姓名： <input type="text"  value="" id="query_originator"/>
						</span>

							</span>
							<span class="r_f"> 
							<input type="button" id="btn_search" class="btncss btn_search" value="搜索" />
						</span>
						</div>

					</div>
					<div class="opration-div clearfix">
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="salesPlanRefresh()" style="margin-right: 0;"><i class="fa fa-refresh"></i>刷新</button>
						</span>
						<span class="r_f"> 
							<button type="button" class="btncss jl-btn-defult" onclick="salesPlanAdd()"><i class="fa fa-plus"></i> 新增</button>
						</span>
						

					</div>
					<div class="table_menu_list">
						<table class="table table-striped table-hover col-xs-12" id="datatable">
							<thead class="table-header">
								<tr>
									<th>单号</th>
									<th>计划对象</th>
									<th>货品名称</th>
									<th>品牌</th>
									<th>制单人</th>
									<th>日期</th>
									<th>app订单</th>
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

		
		<!--新增 -->
		<div id="editDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">计划对象：</label>
							<div class="col-xs-8" id="edit_supctoId_kehu_Div">
								<select class="form-control" name="" id="edit_supctoId">
									
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">币种：</label>
							<div class="col-xs-8">
								<input type="text" name="" id="" value="人民币" class="form-control" disabled="disabled" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">结束日期：</label>
							<div class="col-xs-8">
								<input type="text" name="" id="orderEndTime" value="" class="form-control" readonly="readonly" placeholder="请选择结束日期" />
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务数量：</label>
							<div class="col-xs-8">
								<input type="text" name="" id="total_commodity_num" value="" class="form-control" disabled="disabled" placeholder="请先选择商品并填写业务数量"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">金额：</label>
							<div class="col-xs-8">
								<input type="text" name="" id="total_commodity_price" value="" class="form-control" disabled="disabled" placeholder="请先选择商品并填写业务数量"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>商品</span>
					<b class="r_f" style="margin-top: 13px;">
						<button type="button" class="btncss jl-btn-importent" onclick="goodsAddEdit()">新增</button>
					</b>
				</div>
				<div id="allgoodDivEdit">
				
				</div>
				
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">部门：</label>
							<div class="col-xs-8">
								<select id="department_id" class="form-control">
									
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">摘要：</label>
							<div class="col-xs-8">
								<input type="text" name="" id="summary" value="" class="form-control" maxlength="100"/>
								
							</div>
						</div>
						
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务员：</label>
							<div class="col-xs-8">
								<select id="person_id" class="form-control">
									<option value="-1" selected="selected">--请先选择部门--</option>
								</select>
							</div>
						</div>
						
					</div>
				</div>
				<div class="text-danger">注：该页面所有字段均为必填</div>

			</form>
		</div>
		
		<!--详情 -->
		<div id="lookDiv" style="display: none;">
			<form class="container">
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">日期：</label>
							<div class="col-xs-8 look_createTime" >
								
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">计划对象：</label>
							<div class="col-xs-8 look_supctoId" >
								
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">币种：</label>
							<div class="col-xs-8 look_currency">
								
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">单号：</label>
							<div class="col-xs-8 look_identifier">
								
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">结束日期：</label>
							<div class="col-xs-8 look_endTime">
								
							</div>
						</div>
					</div>
				</div>
				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务数量：</label>
							<div class="col-xs-8 look_totalNumber">
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">金额：</label>
							<div class="col-xs-8 look_totalMoney">
							</div>
						</div>
					</div>
				</div>
				
				<div class="row jl-title">
					<span>商品</span>
				</div>
				<div id="allgoodDivDetail">
				
				</div>
				
				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div class="row jl-panel">
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">部门：</label>
							<div class="col-xs-8 look_department">
								
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">制单人：</label>
							<div class="col-xs-8 look_originator">
								
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">分支机构：</label>
							<div class="col-xs-8 look_branch">
								
							</div>
						</div>
						
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">业务员：</label>
							<div class="col-xs-8 look_personId">
								
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-xs-4 control-label">摘要：</label>
							<div class="col-xs-8 look_summary">
								
								
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
								"identifier": $("#query_identifier").val(),
								"commodityName": $("#query_goodsName").val(),
								"originator": $("#query_originator").val()
									
							});
						},
						"url": "<%=basePath%>/sales/salesPlanOrder/getSalesPlanOrderMsg"
								},

								"aoColumns" : [{
											"mData" : "identifier",
											"bSortable" : false,
											"sWidth" : "15%",
											"sClass" : "center",
											"mRender" : function(data, type, row) {
												return '<td><span class="look-span" onclick=\'salesPlanDetail('
														+ JSON.stringify(row)
														+ ')\'>'
														+ data
														+ '</span></td>';
											}
										},
										{
											"mData" : "supctoId",
											"bSortable" : false,
											"sWidth" : "10%",
											"sClass" : "center",
											"mRender" : function(data, type, row) {
												if (row.supcto != null) {
													return row.supcto.name;
												} else {
													return "";
												}
											}

										},
										{
											"mData" : "commoditysName",
											"bSortable" : false,
											"sWidth" : "10%",
											"sClass" : "center"
										},
										{
											"mData" : "commoditysBrandName",
											"bSortable" : false,
											"sWidth" : "10%",
											"sClass" : "center"

										},
										{
											"mData" : "originator",
											"bSortable" : false,
											"sWidth" : "10%",
											"sClass" : "center",
											"mRender": function(data,type,row) {
												if(data!=null){
													if(row.originatorName!=null && row.originatorName!=""){
														return data+"("+row.originatorName+")";
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
											"mData" : "createTime",
											"bSortable" : false,
											"sWidth" : "10%",
											"sClass" : "center",
											"mRender": function(data) {
												return getSmpFormatDateByLong(data, true);
											}
										},

										{
											"mData" : "isAppOrder",
											"bSortable" : false,
											"sWidth" : "20%",
											"sClass" : "center",
											"mRender" : function(data, type, row) {
												if(data!=null&&data==2){
													return '<td>是</td>'
												}
												else{
													return '<td>否</td>'
												}	
											}
										},
										{
											"mData" : "id",
											"bSortable" : false,
											"sWidth" : "15%",
											"sClass" : "center",
											"mRender" : function(data, type, row) {
												if(row.state==2 || row.state==3){
													return '<td><input type="button" class="btncss edit" onclick=\'salesPlanDetail('+JSON.stringify(row)+')\' value="详情" /></td>'
												}
									
												else{
													if(row.isAppOrder==2){
														return '<td><input type="button" class="btncss edit" onclick=\'salesPlanDetail('+JSON.stringify(row)+')\' value="详情" /></td>'
													}
													else{
														return '<td><input type="button" class="btncss edit" onclick=\'salesPlanDo(' + JSON.stringify(row) + ')\' value="生成销售订单" /></td>'
													}
													
												}
												

											}
										} ],
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
			//给计划对象下拉框赋值
			 getSupctoMsgByCustomerOrSupplier();
			/*部门下拉框赋值 */
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
			 
			
			
		
		});
		
		
		laydate.render({
				elem: "#orderEndTime",
				type: 'date',
				format: 'yyyy-MM-dd',
				max:14,
				min:2,
				btns: ['clear', 'confirm']
			});			
	
		
		
		let goodsIndex=0;
		let goodsJson=[];
		$(function(){
			ajaxJquery("GET","${pageContext.request.contextPath}/junlin/json/salesPlanGoods.json",{},function(data){
				goodsJson=data;
				
			})
			
		})
		function checkUnitNum(){
			$(".look_goodsNumber").on("keyup",function(){
				//console.log($(this).val());
				//判断输入长度
				/* var num=11;
				var a=$(this).val();
				console.log(a.length)
				if(a.length>num){
				$(this).val($(this).val().substr(0,11));
				}  */
				if($(this).val()==0){
					layfail("数量不能为0")
					$(this).val("");
				}
			})
		}
		
		
		/*刷新页面，查看系统是否有新的计划单生成，如果有，就刷新datetable*/
		function salesPlanRefresh() {
			let index = layer.load(1, {
			  shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			
			
			setTimeout(function(){
				layer.close(index);
				
				oTable1.fnDraw();
			},1000)
			
		}

		/*生成销售订单*/
		function salesPlanDo(row){
			publicMessageLayer("生成销售订单", function(){
				$.ajax({
					url: '<%=basePath%>sales/salesOrder/addSalesOrder?planOrTable='+1,
					type: "POST",
					dataType: "json",
					data:{
						"salesPlanOrderId":row.id
					},
					async: false,
					cache: false,
					success: function(data) {
						if(data.success) {
							laysuccess("已成功生成销售订单！");
							oTable1.fnDraw();
							
						} else {
							layfail("销售订单生成失败！");
						}
						layer.close(index);
					}
				});
			})
		}

		
		/*详情*/
		function salesPlanDetail(data) {
			/* //基本信息
			$(".look_createTime").html(getSmpFormatDateByLong(data.createTime,true));
			if(data.supcto!=null){
				$(".look_supctoId").html(data.supcto.name);
			}
			else{
				$(".look_supctoId").html("");
			}
			
			switch (data.currency) {
			case 1:
				$(".look_currency").html("人民币");
				break;

			default:
				$(".look_currency").html("");
				break;
			}
			$(".look_identifier").html(data.identifier);
			if(data.endTime!=null){
				$(".look_endTime").html(getSmpFormatDateByLong(data.endTime,true));
			}
			else{
				$(".look_endTime").html("");
			}
			
			
			//商品
			goodsAddDetail(data.salesPlanOrderCommodities);
			
			
			//其他
			$(".look_department").html(data.personDepartmentName);
			if(data.originator!=null){
				if(data.originatorName!=null){
					$(".look_originator").html(data.originator+"("+data.originatorName+")");
				}
				else{
					$(".look_originator").html("");
				}
				
			}
			else{
				$(".look_originator").html("");
			}
			
			
			$(".look_branch").html(data.branch);
			$(".look_personId").html(data.personName);
			$(".look_summary").html(data.summary); */
			
			$("#lookDiv").html("");
			$.ajax({
				type: "post",
				url: "<%=basePath%>sales/salesPlanOrder/salesPlanOrderDetail",
				dataType : "json",
				data: {
					"id" : data.id
				},
				success: function(res) {
					let bill = new DetailBill(res);
					let $content = bill.toPrint();
					$("#lookDiv").html($content);
				}
			});
			
			layer.open({
				type: 1,
				title: "销售计划单详情",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#lookDiv"),
				btn: ['关闭']
			});
		}
		/*新增销售计划单*/
		function salesPlanAdd(){
			selectedCommodity={};//记录哪一个select选择了哪一个商品规格
	    	commodityIsSelected={};//商品规格是否被选择。
			goodsAddEdit();
			layer.open({
				type: 1,
				title: "新增销售计划单",
				closeBtn: 1,
				area: ['100%', '100%'],
				content: $("#editDiv"),
				btn: ['提交', '取消'],
				yes: function(index) {
					if(!decideInputAndSelectHasValue()){
						laywarn("表单未填写完整，请完善后再提交");	
						return;
					}
					
					$.ajax({
						url: '<%=basePath%>sales/salesPlanOrder/addSalesPlanOrder',
						type: "POST",
						dataType: "json",
						data:{
							"salesPlanOrder":JSON.stringify(salesPlanOrderDataJSON())
						},
						async: false,
						cache: false,
						success: function(data) {
							if(data.success) {
								laysuccess(data.msg);
								oTable1.fnDraw();
								$("#checkAll").removeAttr("checked");
							} else {
								layfail(data.msg);
							}
							layer.close(index);
						}
					});
				},
				end: function(index, layero) {
					layer.close(index);
					$("#allgoodDivEdit").html("");
					clearForm("editDiv", "");
					clearSearchableSelect("edit_supctoId");
				}
			});
			
		}
		
		/*新增商品*/
		
		function goodsAddEdit(){
			let form=new FormPanel("editGoodsDiv"+goodsIndex,goodsJson);
			let $obj=form.toformPrint();
			$("#allgoodDivEdit").append($obj.append(form.toCloseSpan));
			//商品下拉框赋值
			getAllCommodity("#editGoodsDiv"+goodsIndex+" .look_goodsName");
			form.toWork();
			$(".look_goodsNumber").attr("maxlength","9");
			checkUnitNum();
			onkeyUpBind("#editGoodsDiv"+goodsIndex+" .look_goodsNumber",
					"#editGoodsDiv"+goodsIndex+" .look_goodsUnitPrice",
					"#editGoodsDiv"+goodsIndex+" .look_goodsMoney");
			goodsIndex++;
		}
		
		/*新增商品_详情*/
		function goodsAddDetail(data){
			$("#allgoodDivDetail").html("")
			
			let totalNum = 0;
			let totalMoney = 0;
			for (let i = 0; i < data.length; i++) {
				let formDetail=new FormPanel("detailGoodsDiv"+(i+1),goodsJson);
				let $obj=formDetail.toDetailPrint();
				$("#allgoodDivDetail").append($obj);
				
				$("#detailGoodsDiv"+(i+1)+" .look_goodsName").html(data[i].commoditySpecification.commodity.name);
				$("#detailGoodsDiv"+(i+1)+" .look_goodsSpecificationName").html(data[i].commoditySpecification.specificationName);
				$("#detailGoodsDiv"+(i+1)+" .look_goodsSpecificationIdentifier").html(data[i].commoditySpecification.specificationIdentifier);
				$("#detailGoodsDiv"+(i+1)+" .look_goodsBrand").html(data[i].commoditySpecification.commodity.brand);
				$("#detailGoodsDiv"+(i+1)+" .look_goodsUnit").html(data[i].commoditySpecification.baseUnitName);
				$("#detailGoodsDiv"+(i+1)+" .look_goodsNumber").html(data[i].number);
				totalNum += data[i].number;
				$("#detailGoodsDiv"+(i+1)+" .look_goodsUnitPrice").html(data[i].unitPrice);
				$("#detailGoodsDiv"+(i+1)+" .look_goodsMoney").html(data[i].money);
				totalMoney += data[i].money;
				$("#detailGoodsDiv"+(i+1)+" .look_goodsRemark").html(data[i].remark);
			}
			//合计
			$(".look_totalNumber").html(totalNum);
			$(".look_totalMoney").html(totalMoney.toFixed(2));
			
			
		}
		
		/*删除商品*/
		function delform(thisspan){
			var selectparentId =$(thisspan).parent().attr("id");
    		var num=selectparentId.substring(12,selectparentId.length)+"";
    		
			if($("#allgoodDivEdit>div").length>1){
				commodityIsSelected[selectedCommodity[num]]=0;
				delete(selectedCommodity[num]);
				$(thisspan).parent().remove();
			}else{
				layfail("商品不能为空");
			}
			
		}
		
		

		   //给添加时需要选择的客户下拉框赋值
        function getSupctoMsgByCustomerOrSupplier(){
            $.ajax({
                url: '<%=basePath%>basic/supctoManager/selectAllCustomerByCustomerOrSupplier',
                type: "POST",
                dataType: "json",
                data:{
                    "customerOrSupplier":1
                },
                async: false,
                cache: false,
                success: function(data) {
                    $("#edit_supctoId").html("");
                    if(data.length==0){
                        $("#edit_supctoId").append("<option value='-1' selected>--暂无数据，请到供应商页面进行添加--</option>");
                    }
                    else{
                        $("#edit_supctoId").append("<option value='-1' selected>--请选择--</option>");
                        for(var i=0;i<data.length;i++){
                            var option = $("<option value='"+data[i].id+"'>"
                                + data[i].name + "</option>");
                            $("#edit_supctoId").append(option);
                        }
                    }
                }
            });
            $('#edit_supctoId').searchableSelect();
            $("#edit_supctoId").next().css("z-index","2");
        }
		   
        var commodityMsgList=[];//保存查出来的商品
    	var selectedCommodity={};//记录哪一个select选择了哪一个商品规格
    	var commodityIsSelected={};//商品规格是否被选择。
        /* 获取所有商品信息*/
        function getAllCommodity(idstr){
        	//commodityIsSelected={};//还原
    		commodityMsgList=[];//还原
            $.ajax({
                url: '<%=basePath%>basic/goods/commodity/getHasInventoryCommodityByStateAndIsDeleteBySupctoId',
                type: "POST",
                dataType: "json",
                async: false,
                cache: false,
                data:{
                },
                success: function(data) {
                	commodityMsgList=[];
					commodityMsgList=data;
					 $(idstr).html("")
                   
                    if(data.length==0){
                        $(idstr).append("<option value='-1' selected>--暂无数据，请到商品页面进行添加。--</option>");
                    }
                    else{
                        $(idstr).append("<option value='-1' selected>--请选择商品--</option>");
                        for(var i=0;i<data.length;i++){
                            var option = $("<option value='"+data[i].id+"'>"
                                + data[i].commodity.name+" "+data[i].specificationName + "</option>");
                            $(idstr).append(option);
                        }

                    }
                }
            });
        }
        /* 商品选择框的值改变事件 */
    	function selectCommodityMsg(e,selectValId){	
        	
    		var selectparentId =e.element.parents(".jl-panel").attr("id");
    		var num=selectparentId.substring(12,selectparentId.length)+"";
    		
    		if(selectValId>0){
    			for(var i=0;i<commodityMsgList.length;i++){
    				if(commodityMsgList[i].id==selectValId){
    					
    					//先判断现在选择的商品规格与之前选择的是否是一样的。
    					if(selectedCommodity[num]!=selectValId){
    						
    						//如果不一样，则先判断选择的这个规格是否已经被选择。
    						//1表示被选中，0表示未被选中
    						if(commodityIsSelected[selectValId]==1){
    							//若被选择，则提示不能重复选择。
    							laywarn("该规格已被选中，请勿重复选择。");
    							SearchableSelectsetValue("#editGoodsDiv"+num+" .look_goodsName",-1);
    							if(typeof(selectedCommodity[num]) == "undefined"){
    								//同时修改该select选择的为-1
    								selectedCommodity[num]=-1;
    							}
    							else{
    								if(selectedCommodity[num]!=-1){
    									//把之前选择的规格的状态改为未选中
    									commodityIsSelected[selectedCommodity[num]]=0;
    								}
    								//同时修改该select选择的为-1
    								selectedCommodity[num]=-1;
    							}
    							
    							$("#"+selectparentId+" .look_goodsSpecificationName").val("");
    							$("#"+selectparentId+" .look_goodsSpecificationIdentifier").val("");
    							$("#"+selectparentId+" .look_goodsBrand").val("");
    							$("#"+selectparentId+" .look_goodsUnit").val("");
    							$("#"+selectparentId+" .look_goodsUnitPrice").val("");
    							
    							$("#"+selectparentId+" .look_goodsNumber").attr("disabled","disabled");
    							$("#"+selectparentId+" .look_goodsNumber").val("");
    							$("#"+selectparentId+" .look_goodsMoney").val("");
    							
    						}
    						else{
    							//说明是第一次保存
    							if(typeof(selectedCommodity[num]) == "undefined"){
    								//同时修改该select选择的规格id
    								selectedCommodity[num]=selectValId;
    								if(selectedCommodity[num]!=-1){
    									//把之前选择的规格的状态改为未选中
    									commodityIsSelected[selectedCommodity[num]]=0;
    								}		
    								//则修改现在选择的规格的状态为选中
    								commodityIsSelected[selectValId]=1;
    							}
    							else{
    								//若未被选择 
    								if(selectedCommodity[num]!=-1){
    									//把之前选择的规格的状态改为未选中
    									commodityIsSelected[selectedCommodity[num]]=0;
    								}	
    								//则修改现在选择的规格的状态为选中
    								commodityIsSelected[selectValId]=1;
    								//同时修改该select选择的规格id
    								selectedCommodity[num]=selectValId;
    							}
    							
    							
    							
    							$("#"+selectparentId+" .look_goodsSpecificationName").val(commodityMsgList[i].specificationName);
    							$("#"+selectparentId+" .look_goodsSpecificationIdentifier").val(commodityMsgList[i].specificationIdentifier);
    							$("#"+selectparentId+" .look_goodsBrand").val(commodityMsgList[i].commodity.brand);
    							$("#"+selectparentId+" .look_goodsUnit").val(commodityMsgList[i].baseUnitName);
    							$("#"+selectparentId+" .look_goodsUnitPrice").val(commodityMsgList[i].baseCommonlyPrice);
    							
    							$("#"+selectparentId+" .look_goodsNumber").removeAttr("disabled");
    							$("#"+selectparentId+" .look_goodsNumber").val("");
    							$("#"+selectparentId+" .look_goodsMoney").val("");
    						}
    					}
    				}		
    			}	
    		}
    		else{
    			if(typeof(selectedCommodity[num]) != "undefined"&&selectedCommodity[num]!=-1){
    				//把之前选择的规格的状态改为未选中
    				commodityIsSelected[selectedCommodity[num]]=0;
    			}
    			//同时修改该select选择的为-1
    			selectedCommodity[num]=-1;
    			
    			$("#"+selectparentId+" .look_goodsSpecificationName").val("");
				$("#"+selectparentId+" .look_goodsSpecificationIdentifier").val("");
				$("#"+selectparentId+" .look_goodsBrand").val("");
				$("#"+selectparentId+" .look_goodsUnit").val("");
				$("#"+selectparentId+" .look_goodsUnitPrice").val("");
				
				$("#"+selectparentId+" .look_goodsNumber").attr("disabled","disabled");
				$("#"+selectparentId+" .look_goodsNumber").val("");
				$("#"+selectparentId+" .look_goodsMoney").val("");
    		}
    			
    	}
        
        /* 客户选择框的值改变事件 */
    	function selectSupctoMsg(e,selectValId){	
  
        }
        
        /* 商品数量输入框onkeyup事件   计算金额*/
        function onkeyUpBind(numObj,priceObj,moneyObj){
        	$(numObj).on("keyup",function(){
        		pressInteger(this);
        		let number = $(numObj).val()-0;
        		let price = $(priceObj).val()-0;
        		$(moneyObj).val((number*price).toFixed(2));
        		countCommodityNumAndPrice();
        	})
        }
        /*部门下拉框值改变事件*/
        $("#department_id").change(function(){
			if($("#department_id").val()==-1){
				$("#person_id").empty();
				$("#person_id").append('<option value="-1" selected="selected">--请先选择部门--</option>');
			}
			else{
				person(0);
			}
			
		});
		
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
		
		//商品的合计
      	function countCommodityNumAndPrice(){
      		var commodityNum=0;
      		var commodityTotalPrice=0;
      	//获取销售计划商品的信息，添加到销售计划单的商品信息里
    		$("#allgoodDivEdit .jl-panel").each(function(index, val){
    			if($(val).find(".look_goodsNumber").val()!=""){
    				commodityNum+=$(val).find(".look_goodsNumber").val()-0;
        			commodityTotalPrice+=$(val).find(".look_goodsMoney").val()-0;
    			}
    			
    			});
      		$("#total_commodity_num").val(commodityNum);
      		$("#total_commodity_price").val(commodityTotalPrice.toFixed(2));
      	}
         
		/* 编辑时判断数据有没有填写完整 */
    	function decideInputAndSelectHasValue(){
    		var inputValue=true;
    		var selectValue=true;
    		$("#editDiv input[type='text']").each(function(index, val){	
    			if(!$(val).hasClass("hidden")){				
    				if($(val).val()==""&&$(val).attr("class")!="searchable-select-input"){
    				inputValue=false;
    				}	
    			}
    				
    		});	
    		$("#editDiv select").each(function(index, val){	
    			if($(val).val()==-1){
    				selectValue=false;
    			}		
    		});
    		
    		if(!inputValue||!selectValue){
    			return false;
    		}
    		else{
    			return true;
    		}
    		
    	}
		
      	/* 提交或者编辑时 把数据整合成json传入后台 */
    	function salesPlanOrderDataJSON(){
    		
    		//销售计划单基础的信息
    		 var  salesPlanOrderDataJSON={"supctoId":$("#edit_supctoId").val(),
    				"endTimeString":$("#orderEndTime").val(),
    				"summary":$("#summary").val(),
    				"personId":$("#person_id").val(),
    				"salesPlanOrderCommodities":[]}; 
    		//获取销售计划商品的信息，添加到销售计划单的商品信息里
    		$("#allgoodDivEdit .jl-panel").each(function(index, val){
    			
    			var salesPlanOrderCommoditiesDataJSON={"commoditySpecificationId":$(val).find(".look_goodsName").val(),
    					"number":$(val).find(".look_goodsNumber").val(),
    					"unitPrice":$(val).find(".look_goodsUnitPrice").val(),
    					"money":$(val).find(".look_goodsMoney").val(),
    					"remark":$(val).find(".look_goodsRemark").val()};	
    				
    			salesPlanOrderDataJSON.salesPlanOrderCommodities[index]=salesPlanOrderCommoditiesDataJSON;	
    			});
    			
    		
    		return salesPlanOrderDataJSON; 
    	}
      	
      	
    	
	</script>

</html>