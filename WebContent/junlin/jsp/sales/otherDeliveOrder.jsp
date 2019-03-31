<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = path + "/";
%>

<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8" />
		<title>其他发货单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@include file="/common.jsp"%>


		<link
				href="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.css"
				rel="stylesheet" type="text/css">
		<script
				src="${pageContext.request.contextPath}/junlin/js/jQuery-searchableSelect/jquery.searchableSelect.js"></script>


		<style type="text/css">
			#detailDiv,
			#editDiv {
				margin: 50px auto;
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
					<h4 class="text-title">其他发货单</h4>
					<div class="search-div clearfix">
						<div class="clearfix">
						<span class="l_f"> 单号： <input type="text" value=""
							id="query_identifier" />
						</span> <span class="l_f"> 货品名称： <input type="text" value=""
							id="query_goodsName" />
						</span> 
						<span class="l_f" style="margin-left:19px"> 
								起止时间： <input type="text"  value="" id="query_time" placeholder="请选择时间" readonly=""  />
							</span>
							<span class="l_f"> 
								状态：<select id="query_state" >
									<option value="-1" selected="selected">--请选择--</option>
									<option value="1">未送审</option>
									<option value="2">审核中</option>
									<option value="3">审核通过</option>
									<option value="4">审核驳回</option>
									<option value="8">已删除</option>
									<option value="5">其他</option>
								</select>
							</span>
						<span class="r_f"> <input type="button" id="btn_search"
							class="btncss btn_search" value="搜索" />
						</span>
					</div>

					</div>
					<div class="opration-div clearfix">
						<span class="r_f">
							<button type="button" class="btncss jl-btn-defult otherShippingAddBtn" style="margin-right: 0;">
								<i class="fa fa-plus"></i>新增
							</button>
						</span>
					</div>
					<div class="table_menu_list">
						<form id="datatable_form">
							<table class="table table-striped table-hover col-xs-12" id="datatable">
								<thead class="table-header">
									<tr>
										<th>单号</th>
										<th>客户</th>
										<th>货品名称</th>
										<th>日期</th>
										<th>制单人</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><span class="look-span otherShippingDetailBtn" attr-tid="0">1321</span></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>
											<input type="button" class="btncss edit otherShippingEditBtn" attr-data="{id:4,data:5}" value="编辑" />
											<input type="button" class="btncss edit otherShippingDeleteBtn" attr-tid="0" value="删除" />
											<input type="button" class="btncss edit otherShippingDeliverBtn" attr-tid="0" value="送审" />
										</td>
									</tr>
									<tr>
										<td><span class="look-span otherShippingDetailBtn" attr-tid="0">1321</span></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>
											<input type="button" class="btncss edit otherShippingStopBtn" attr-tid="0" value="作废" />
											<input type="button" class="btncss edit otherShippingDetailBtn" attr-tid="0" value="详情" />
										</td>
									</tr>
									
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!--详情 -->
		<div id="detailDiv" style="display: none;">

		</div>
		<!--新增 编辑-->
		<div id="editDiv" style="display: none;">
			<form class="container">
			<input type="text" class="form-control hidden" id="edit_sales_id" />
				<div class="row jl-title">
					<span>基本信息</span>
				</div>
				<div id="headEdit" class="jl-panel">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">客户</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_supcto_id" disabled="disabled" value="其他" />
								</div>
							</div>
						</div>

					</div>
				</div>

				<div class="row">
					<div class="jl-title l_f" style="text-align: left;">
						<span>商品</span>
					</div>
					<div class="r_f">
						<button type="button" class="btncss jl-btn-importent goodsAddBtn">新增</button>
					</div>
					<div class="r_f">
						<div class="form-group">
							<div class="col-xs-12" id="edit_goodDiv">
								<select id="edit_goods" class="form-control"></select>
							</div>
						</div>
					</div>

				</div>
				<div class="nonowrap-table-div">
					<table class="table table-bordered table-striped table-hover" border="" cellspacing="0" cellpadding="0">
						<tbody id="goodsTbody">
							<tr>
								<th nowrap="nowrap">货品名称</th>
								<th nowrap="nowrap">规格编码</th>
								<th nowrap="nowrap">规格</th>
								<th nowrap="nowrap">单位</th>
								<th nowrap="nowrap">单价</th>
								<th nowrap="nowrap">发货数量</th>
								<th nowrap="nowrap">税率</th>
								<th nowrap="nowrap">税额</th>
								<th nowrap="nowrap">金额</th>
								<th nowrap="nowrap">批号</th>
								<th nowrap="nowrap">备注</th>
								<th nowrap="nowrap">操作</th>
							</tr>
							<tr class="tipTr">
								<td colspan="12">请先选择商品</td>
							</tr>
						</tbody>
					</table>

				</div>
				<div class="row jl-title">
					<span>合计</span>
				</div>
				<div id="countEdit" class="jl-panel">
					<div class="row">

						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">发货数量</label>
								<div class="col-xs-8">
									<input type="text" id="total_commodity_num" value="" class="form-control" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">金额</label>
								<div class="col-xs-8">
									<input type="text" id="total_commodity_price" value="" class="form-control" disabled="disabled" />
								</div>
							</div>
						</div>
						

					</div>
				</div>

				<div class="row jl-title">
					<span>其他</span>
				</div>
				<div id="footerEdit" class="jl-panel">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">部门</label>
								<div class="col-xs-8">
									<select id="department_id" class="form-control" name="departmentId" >
										<option value="-1" selected="selected">--请选择--</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">摘要</label>
								<div class="col-xs-8">
									<input type="text" id="edit_summary" value="无" class="form-control" onkeyup="cky(this)" maxlength="100" />
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">业务员</label>
								<div class="col-xs-8">
									<select id="person_id" class="form-control" name="personId" >
									 	<option value="-1" selected="selected">--请先选择部门--</option>
										
								 	</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="text-danger">注：该页面所有字段均为必填</div>
			</form>
		</div>
		<!--终止订单提示框，请于JS配置内容-->
		<div id="alertDiv" style="display: none;">
			<div class="container">
				<article class="text-center" style="line-height: 65px;"> </article>
				<div class="form-group">
					<div class="col-xs-12 text-center">
						<button type="button" class="btncss jl-btn-importent">确定(3s)</button>
						<button type="button" class="btncss jl-btn-defult">取消</button>
					</div>
				</div>
			</div>
		</div>

	</body>

	<script>
	laydate.render({
		elem: "#query_time",
		range:'~'
	});
		//立即执行函数
		(function(dom) {
			let order = {
				config: { //字段配置，存储变量
					title: "其他发货单",
					dataTable: {}, //该字段用于存储datadtable
					goodsSelectData:[],//用于存储当前选中的供应商的所有商品
					goodsTable: {
						head: `<tr>
							<th nowrap="nowrap">货品名称</th>
							<th nowrap="nowrap">规格编码</th>
							<th nowrap="nowrap">规格</th>
							<th nowrap="nowrap">单位</th>
							<th nowrap="nowrap">单价</th>
							<th nowrap="nowrap">发货数量</th>
							<th nowrap="nowrap">税率</th>
							<th nowrap="nowrap">税额</th>
							<th nowrap="nowrap">金额</th>
							<th nowrap="nowrap">批号</th>
							<th nowrap="nowrap">备注</th>
							<th nowrap="nowrap">操作</th>
						</tr>`,
						tipTr: '<tr class="tipTr"><td colspan="12">请先选择商品</td></tr>',
						goodsArr: [] ,//用于存储添加到table中的商品的id,
                        updateOrAdd: 0,
                        updateOrderId:0,
					},
					editForm: `<div class="col-xs-6 editInfo">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">日期</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_generateDate" disabled="disabled" />
								</div>
							</div>
						</div>
						<div class="col-xs-6 editInfo">
							<div class="form-group">
								<label for="" class="col-xs-4 control-label">单号</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="edit_identifier" disabled="disabled"   />
								</div>
							</div>
						</div>`,

				},
				init: function() { //初始化方法
					this.initDataTable();
					this.initEvent();
					this.initDepartmentSelect("#department_id");
				},
				initEvent: function() {
					let that = this;
					//事件绑定
					//新增其他发货单
					$(".otherShippingAddBtn").on("click", () => {
						this.otherShippingAddEvent();
					})
					//新增商品
					$(".goodsAddBtn").on("click", () => {
						this.goodsAddEvent();
					})
					//搜索 刷新datatable
					$("#btn_search").on("click", () => {
						//this.refreshDataTable();
						this.config.dataTable.fnDraw();
					})
					//部门下拉框值改变事件
					$("#department_id").on("change",function(){
						that.initPersonSelect($(this).val(),"#person_id");
					})

					/*事件委托 begin*/
					//其他发货单 详情
					$("#datatable").delegate(".otherShippingDetailBtn", "click", function() {
						that.otherShippingDetailEvent($(this).attr("attr-tid"));
					})
					//其他发货单 编辑
					$("#datatable").delegate(".otherShippingEditBtn", "click", function() {
						console.log($(this).attr("attr-data"))
						that.otherShippingEditEvent($(this).attr("attr-data"));
					})
					//其他发货单 删除
					$("#datatable").delegate(".otherShippingDeleteBtn", "click", function() {
						that.otherShippingDeleteEvent($(this).attr("attr-tid"));
					})
					//其他发货单 送审
					$("#datatable").delegate(".otherShippingDeliverBtn", "click", function() {
						that.otherShippingDeliverEvent($(this).attr("attr-tid"));
					})
					//其他发货单作废
					$("#datatable").delegate(".otherShippingStopBtn", "click", function() {
						layerTwoConfrim($("#alertDiv"), "提示框", "确定作废该订单?", ()=> {
							that.otherShippingStopEvent($(this).attr("attr-tid"));
						})
					})
					
					//删除商品
					$("#goodsTbody").delegate(".goodsDelBtn", "click", function() {
						that.goodsDelEvent(this, $(this).attr("attr-tid"));
					})
					
					//发货数量  监听事件
					$("#goodsTbody").delegate(".edit_deliverGoodsNum", "keyup blur", function() {
						pressInteger(this);
						$("#total_commodity_num").val(parseInt(that.countOneTotalFun(".edit_deliverGoodsNum"))); //业务数量

					})
					//税率 监听事件
					$("#goodsTbody").delegate(".edit_taxes", "keyup blur", function() {
						pressSmallNumZero(this);

					})
					//税额 监听事件
					$("#goodsTbody").delegate(".edit_taxesMoney", "keyup blur", function() {
						pressMoney(this);

					})
					//金额  监听事件
					$("#goodsTbody").delegate(".edit_deliverGoodsMoney", "keyup blur", function() {
						pressMoney(this);
						$("#total_commodity_price").val(that.countOneTotalFun(".edit_deliverGoodsMoney")); //税额

					})
					

					/*事件委托 end*/

				},
				initGoodsSelect: function() {
					
                    //初始化商品
                    $.ajax({
                        url: '<%=basePath%>basic/goods/commodity/saleOrderGetHasInventoryCommodityByStateAndIsDelete',
                        type: "POST",
                        dataType: "json",
                        async: false,
                        cache: false,
                        data:{
                            "updateOrAdd":this.config.goodsTable.updateOrAdd,
                            "orderId":this.config.goodsTable.updateOrderId
                        },
                        success: (data)=> {
                        	 this.config.goodsSelectData=data;
                            $("#edit_goods").parent().html('<select id="edit_goods" class="form-control"></select>');
                            if(data.length==0){
                                $("#edit_goods").append("<option value='-1' selected>--暂无数据，请到商品页面进行添加。--</option>");
                            }
                            else{
                                $("#edit_goods").html(`<option value="-1">--请选择商品--</option>`);
                                for(var i=0;i<data.length;i++){
                                    var option = $("<option value='"+data[i].id+"'>"
                                        + data[i].commodity.name+" "+data[i].specificationName + "</option>");
                                    $("#edit_goods").append(option);
                                }

                            }
                        }
                    });




					$("#edit_goods").searchableSelect();
				},
				initDepartmentSelect:function(select){
                    //初始化部门下拉框

                    $select=$(select);
                    $.ajax({
                        url :'<%=basePath%>basic/department/getAllDepartment' ,
                        type : "POST",
                        dataType : "json",
                        data: {},
                        success : function(data) {
                            //$("#department_id").empty();

                            if(data.length==0){
                                $select.append('<option value="-1" selected="selected">--暂无部门信息，请去添加--</option>');
                            }
                            else{
                                //$select.append('<option value="-1" selected="selected">--请选择--</option>');
                                for ( var i = 0; i < data.length; i++) {
                                    var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
                                    $select.append(option);

                                }
                            }

                        }
                    });



					// $select.html(`<option value="-1">--请选择部门--</option>`);
					// /*
					//  * 请在此处为部门下拉框添加option
					//  */
					//
					// $select.append(`<option value="1">1</option><option value="2">2</option>`);
					
				},
				initPersonSelect:function(departmentId,select,personId){
					//初始化业务员下拉框
					$select=$(select);
					personId=personId||0;
                    $.ajax({
                        url :'<%=basePath%>basic/person/getAllPersonByDepartmentIdAndBusiness' ,
                        type : "POST",
                        dataType : "json",
                        data: {
                            "departmentId" : departmentId
                        },
                        success : function(data) {
                            $("#person_id").empty();
                            if(data.length==0){
                                $select.append('<option value="-1" selected="selected">--该部门暂无业务员，请去添加--</option>');
                            }
                            else{
                                $select.append('<option value="-1" selected="selected">--请选择--</option>');
                                for ( var i = 0; i < data.length; i++) {
                                    var option = $("<option  value='"+data[i].id+"'>"+ data[i].name +"</option>");
                                    $select.append(option);

                                }
                                if(personId>0){
                                	$select.val(personId);
                                }
                               
                            }

                        }
                    });


					if(departmentId==-1){
						$select.html(`<option value="-1" selected="selected">--请先选择部门--</option>`);
								 	return;
					}
					$select.html(`<option value="-1">--请选择业务员--</option>`);
					/*
					 * 请在此根据部门id处为业务员下拉框添加option
					 */
					$select.append(`<option value="1">1</option><option value="2">2</option>`);
					
					
				},
				initDataTable: function() {
					/*
					 * 请在此处初始化页面datatable 并把datatable赋值给this.config.dataTable
					 */
					this.config.dataTable = $('#datatable')
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
                                        "page":21,
                                        "identifier": $("#query_identifier").val(),
                                        "commodityName": $("#query_goodsName").val(),
                                        "supctoName": "",
                                        "isSpecimen":0,
            							"createTime": $("#query_time").val(),
            							"state": $("#query_state").val()

                                    });
                                },
                                "url": "<%=basePath%>sales/salesOrder/getSalesOrderMsg"
                            },

                            "aoColumns" : [

                                {
                                    "mData" : "identifier",
                                    "bSortable" : false,
                                    "sWidth" : "15%",
                                    "sClass" : "center",
                                    "mRender" : function(data, type, row) {
                                        if(row.breakCode!=null&&row.breakCode>0){
                                            return '<td><span class="look-span otherShippingDetailBtn"   attr-tid="'+row.id+'">' + data + '-'+row.breakCode+'</span></td>';
                                        }
                                        else{
                                            return '<td><span class="look-span otherShippingDetailBtn" attr-tid="'+row.id+'" >'
                                                + data
                                                + '</span></td>';
                                        }

                                    }
                                },
                                {
                                    "mData" : "supctoId",
                                    "bSortable" : false,
                                    "sWidth" : "10%",
                                    "sClass" : "center",
                                    "mRender" : function(data, type, row) {
                                        return "其他";
                                    }

                                },{
                                    "mData" : "commoditysName",
                                    "bSortable" : false,
                                    "sWidth" : "15%",
                                    "sClass" : "center"
                                },{
                                    "mData" : "createTime",
                                    "bSortable" : false,
                                    "sWidth" : "15%",
                                    "sClass" : "center",
                                    "mRender": function(data) {
                                        return getSmpFormatDateByLong(data, true);
                                    }

                                },{
                                    "mData": "person.name",
                                    "bSortable": false,
                                    "sWidth": "15%",
                                    "sClass": "center",
                                    "mRender": function(data,type,row) {
                                        if(data!=null&&data!=""){
                                            if(row.person!=null){
                                                return row.originator+"("+data+")";
                                            }else{
                                                return data;
                                            }

                                        }
                                        else{
                                            return "";
                                        }

                                    }
                                },{
                                    "mData" : "state",
                                    "bSortable" : false,
                                    "sWidth" : "10%",
                                    "sClass" : "center",
                                    "mRender" : function(data, type, row) {

                                        switch (data) {
                                            case 1:
                                                return "未送审";
                                                break;
                                            case 2:
                                                return "订单待领导审核";
                                                break;
                                            case 3:
                                                return "订单审核驳回";
                                                break;
                                            case 4:
                                                return "待收预付款";
                                                break;
                                            case 5:
                                            	if(row.orderType==8){
    												return "待打印出库单";
    											}
    											else{
    												return "待打印备货单";
    											}
                                                break;
                                            case 6:
                                                return "作废审核中";
                                                break;
                                            case 7:
                                                return "作废审核中";
                                                break;
                                            case 8:
                                                return "作废审核中";
                                                break;
                                            case 9:
                                                return "作废审核驳回";
                                                break;
                                            case 10:
                                                return "已作废";
                                                break;
                                            case 11:
                                                return "备货中";
                                                break;
                                            case 12:
                                                return "已出库";
                                                break;
                                            case 13:
                                                return "销售开单待审核";
                                                break;
                                            case 14:
                                                return "销售开单驳回";
                                                break;
                                            case 15:
                                                return "已开单";
                                                break;
                                            case 16:
                                                return "申请修改待审核";
                                                break;
                                            case 17:
                                                return "申请修改审核驳回";
                                                break;
                                            case 18:
                                                return "申请修改审核通过";
                                                break;
                                            case 19:
                                                return "折损单待审核";
                                                break;
                                            case 20:
                                                return "折损单审核驳回";
                                                break;
                                            case 21:
                                                return "折损单审核通过";
                                                break;
                                            case 22:
                                                return "折损单待审核";
                                                break;
                                            case 23:
                                                return "折损单审核驳回";
                                                break;
                                            case 24:
                                                return "可开单";
                                                break;
                                            case 25:
                                                return "作废审核驳回";
                                                break;
                                            case 26:
                                                return "已开返货单";
                                                break;
                                            case 32:
                                                return "未出库";
                                                break;
                                            case 33:
                                                //是app订单
                                                if(row.isAppOrder!=null&&row.isAppOrder==2){
                                                    if(row.isReturnGoods==1){
                                                        return "申请退货中";
                                                    }
                                                    else if(row.isReturnGoods==2){
                                                        return "待退货入库";
                                                    }
                                                    else if(row.isReturnGoods==3){
                                                        return "已退货入库";
                                                    }
                                                    else{
                                                        return "已出库";
                                                    }
                                                }
                                                else{
                                                    return "已出库";
                                                }


                                                break;
                                            case 34:
                                                return "作废审核中";
                                                break;
                                            case 35:
                                                return "待备货";
                                                break;
                                            case 36:
                                                return "订单待财务审核";
                                                break;
                                            case 37:
												return "已删除";
												break;
                                            default:
                                                break;
                                        }
                                    }

                                },{
                                    "mData" : "id",
                                    "bSortable" : false,
                                    "sWidth" : "20%",
                                    "sClass" : "center",
                                    "mRender" : function(data, type, row) {
                                        if(row.state==1||row.state==3){
                                            return '<td><input type="button" class="btncss otherShippingEditBtn"  attr-data="'+data+'" value="编辑" />'
                                                + '<input type="button" class="btncss otherShippingDeliverBtn" attr-tid=\''+JSON.stringify(row)+'\' value="送审" />'
                                                +'<input type="button" class="btncss otherShippingDeleteBtn" attr-tid="'+data+'" value="删除" /></td>'
                                        }
                                        else if(row.state==5 || row.state==9 || row.state==11 ||row.state==25){
                                            return '<td><input type="button" class="btncss otherShippingStopBtn" attr-tid=\''+JSON.stringify(row)+'\' value="作废" /></td>'
                                        }else{
                                            return '<td><input type="button" class="btncss otherShippingDetailBtn" attr-tid="'+data+'" value="详情" /></td>'
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

					
				},
				refreshDataTable: function() {
					this.config.dataTable.fnDraw(false);
				},
				setSupcto: function() {
					$("#edit_supcto_id").val("其他");
				},
				setOtherShipping: function(data) {
					
					this.config.goodsTable.updateOrAdd = 2;
					this.config.goodsTable.updateOrderId = data
					/*
					 * 请在此处解析data为from赋值
					 * 该方法用于编辑框打开前，为框内的内容赋值
					 */
					
						
					 $.ajax({
			            url: '<%=basePath%>sales/salesOrder/selectOrderDetailById',
			            type: "GET",
			            dataType: "json",
			            data: {
			               "id": data
			            },
			            success:  (data)=> {
							$("#edit_sales_id").val(data.id);
							$("#edit_is_specimen").val(data.isSpecimen);
							$("#edit_generateDate").removeClass("hidden");
							$("#edit_generateDate_div").removeClass("hidden");
							$("#edit_generateDate").val(getSmpFormatDateByLong(data.createTime,true));
							
							$("#edit_supctoId_input").removeClass("hidden");
							$("#edit_supctoId").addClass("hidden");
							$("#edit_supctoId").parent().addClass("hidden");
							$("#edit_supctoId_input").val("其他");
							
							
							$("#effective_date").val(getSmpFormatDateByLong(data.endValidityTime,false));
							$("#edit_deliver_goods_place").val(data.deliverGoodsPlace);
							$("#edit_receipt_goods_place").val(data.receiptGoodsPlace);
							$("#edit_consignee").val(data.consignee);
							if(data.payment==null){
								$("#edit_payType").val(-1);
							}else{
								$("#edit_payType").val(data.payment);
							}
							
							switch (data.payment) {
							case 1:
								$("#edit_advance_scale_div").removeClass("hidden");
								$("#edit_advance_scale").removeClass("hidden");
								$("#edit_advance_scale").val(data.advanceScale);
								break;
							case 2:
								
								$("#edit_advance_scale_div").addClass("hidden");
								$("#edit_advance_scale").addClass("hidden");
								break;
							case 3:
								
								$("#edit_advance_scale_div").addClass("hidden");
								$("#edit_advance_scale").addClass("hidden");
								break;
							default:
								break;
							}
							$("#edit_identifier").removeClass("hidden");
							$("#edit_identifier_div").removeClass("hidden");
							$("#edit_identifier").val(data.identifier);
							if(data.shippingModeId == null){
								$("#edit_transportationMode").val(-1);
							}else{
								$("#edit_transportationMode").val(data.shippingModeId);
							}
							
							
							$("#edit_phone").val(data.phone);
							$("#edit_orderer").val(data.orderer);
							$("#edit_fax").val(data.fax);			
							$("#department_id").val(data.personDepartmentId);	
							
							$("#edit_summary").val(data.summary);
							
							this.initPersonSelect(data.personDepartmentId,"#person_id",data.personId);
						
							
							var deliverGoodsNum=0;
							var deliverGoodsMoney=0.0;
							for(var i=0;i<data.salesOrderCommodities.length;i++){
								let goodsId = data.salesOrderCommodities[i].commoditySpecification.id;
								$(".tipTr").remove();
								this.config.goodsTable.goodsArr.push(goodsId);
								
								$("#goodsTbody").append(`<tr>
									<td class="edit_sales_commodity_id hidden">`+data.salesOrderCommodities[i].id+`</td>
				                    <td class="edit_warehouse_id hidden">` + data.salesOrderCommodities[i].warehouseId + `</td>
				                    <td class="goodsId hidden">` + goodsId + `</td>
				                    <td class="edit_goods_name">` + data.salesOrderCommodities[i].commoditySpecification.commodity.name + `</td>
									<td class="edit_commodity_identifier">` + data.salesOrderCommodities[i].commoditySpecification.specificationIdentifier + `</td>
									<td class="edit_commodity_specifications_id">` + data.salesOrderCommodities[i].commoditySpecification.specificationName + `</td>
									<td class="edit_commodity_unit">` + data.salesOrderCommodities[i].commoditySpecification.baseUnitName + `</td>
									<td class="edit_unitPrice" >` + data.salesOrderCommodities[i].unitPrice + `</td>
									<td><input type="text" id="" value="`+data.salesOrderCommodities[i].deliverGoodsNum+`" class="form-control edit_deliverGoodsNum" maxlength="9" attr-name="发货数量"/></td>
									<td><input type="text" id="" value="`+data.salesOrderCommodities[i].taxes+`" class="form-control edit_taxes" attr-name="税率"/></td>
									<td><input type="text" value="`+data.salesOrderCommodities[i].taxesMoney+`" class="form-control edit_taxesMoney" attr-name="税额"/></td>
									<td><input type="text" id="" value="`+data.salesOrderCommodities[i].deliverGoodsMoney+`" class="form-control edit_deliverGoodsMoney" attr-name="金额"/></td>
									<td><input type="text" value="`+data.salesOrderCommodities[i].batchNumber+`" class="form-control edit_batch_number" attr-name="批号"/></td>
									<td><input type="text" id="" value="`+data.salesOrderCommodities[i].remark+`" class="form-control edit_remark" onkeyup="cky(this)" attr-name="备注"/></td>
									<td><input type="button" class="btncss edit goodsDelBtn" attr-tid="` + goodsId + `" value="删除" /></td>
								</tr>`);
							} 
							this.countTotalFun();
			            }
					});


				},
				getOtherShipping: function() {
					let formData = {};
					/*
					 * 请在此处获取form各个字段的值，形成对象
					 * 该方法用于编辑、新增的向后台提交数据，获取数据的方法
					 */
					//销售订单基础的信息
		    		 formData={"id":$("#edit_sales_id").val(),
		    				"identifier":$("#edit_identifier").val(),
		    				"createTimeString":$("#edit_generateDate").val(),
		    				"summary":$("#edit_summary").val(),
		    				"personId":$("#person_id").val(),
		    				"salesOrderCommodities":[]}; 
		    		//获取销售商品的信息，添加到销售订单的商品信息里
		    		$("#goodsTbody tr").each(function(index, val){
		    			var unitPrice=0;
		    			$(val).find(".edit_unitPrice").each(function(index, val){
		    					unitPrice=$(val).html();
		    			});
		    			var salesOrderCommoditiesDataJSON={"id":$(val).find(".edit_sales_commodity_id").html(),"salesOrderId":$("#edit_sales_id").val(),"commoditySpecificationId":$(val).find(".goodsId").html(),"taxes":$(val).find(".edit_taxes").val(),
		    					"deliverGoodsMoney":$(val).find(".edit_deliverGoodsMoney").val(),"remark":$(val).find(".edit_remark").val(),"deliverGoodsNum":$(val).find(".edit_deliverGoodsNum").val(),"unitPrice":unitPrice,
		    					"taxesMoney":$(val).find(".edit_taxesMoney").val(),"batchNumber":$(val).find(".edit_batch_number").val(),"warehouseId":$(val).find(".edit_warehouse_id").html()};	
		    				
		    			
		    			if(index!=0) formData.salesOrderCommodities[index-1]=salesOrderCommoditiesDataJSON;	
		    			});
		    		 console.log("formData",formData);
					return formData;
				},
				otherShippingAddEvent: function() {
					//新增其他发货单
					//console.log("新增其他发货单");
					$("#edit_summary").val("无");
					this.config.goodsTable.updateOrAdd=1;
					let that = this;
					this.setSupcto();
					this.initGoodsSelect();
					layer.open({
						type: 1,
						title: "新增" + that.config.title,
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#editDiv"),
						scrollbar: false,
						btn: ['提交', '取消'],
						yes: index => {
							if(!this.checkFormisFilledLayerFun()) return;
							/*
							 * 添加其他发货单添加成功相关逻辑代码
							 */
							var flag=true;
							$("#goodsTbody tr").each(function(index, val){

				    			if($(val).find(".edit_deliverGoodsNum").val()-0==0){
				    				flag = false;
				    			}
				    		});
							if(!flag){
								laywarn("发货数量不能为0。");
								return false;
							}
							var formdata = this.getOtherShipping(); //获取页面数据的值，用于提交到后台
							$.ajax({
								url: '<%=basePath%>sales/salesOrder/addOtherDeliveOrder',
								type: "POST",
								dataType: "json",
								data:{
									"salesOrder":JSON.stringify(formdata)
								},
								async: false,
								cache: false,
								success: (data)=> {
									if(data.success) {
										layer.close(index);
										laysuccess(data.msg);
										this.refreshDataTable();//刷新datatable
									} else {
										layer.close(index);
										layfail(data.msg);
									}
									
								}
							});
							
						},
						end: (index, layero) => {
							layer.close(index);
							clearForm("editDiv", "");
							this.clearGoodsEvent();
							this.clearPerson();
							
						}
					});
				},
				otherShippingDetailEvent: function(tid) {
					//其他发货单详情
					//console.log("其他发货单详情"+tid);
					var that = this;
					$.ajax({
						type: "post",
						url: "<%=basePath%>sales/salesOrder/salesOrderDetail",
						dataType: "json",
						data: {
							"id" : tid,
							"type":5
						},
						success: function(res) {
							let bill = new DetailBill(res);
							let $content = bill.toPrint();
							$("#detailDiv").html($content);
						}
					});
					layer.open({
						type: 1,
						title: that.config.title + "详情",
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#detailDiv"),
						btn: ['关闭']
					});
				},
				otherShippingEditEvent: function(data) {
					//其他发货单 编辑
					console.log("其他发货单编辑" + data);
					this.setSupcto();
					
					$("#headEdit .row").prepend(this.config.editForm);
					this.setOtherShipping(data); //根据data获取单据信息为表单赋值
					this.initGoodsSelect();
					var that = this;
					layer.open({
						type: 1,
						title: "编辑" + that.config.title,
						closeBtn: 1,
						area: ['100%', '100%'],
						content: $("#editDiv"),
						scrollbar: false,
						btn: ['提交', '取消'],
						yes: index => {
							if(!this.checkFormisFilledLayerFun()) return;
							/*
							 * 请在此处添加其他发货单编辑的相关代码
							 */
							var flag=true;
							$("#goodsTbody tr").each(function(index, val){

				    			if($(val).find(".edit_deliverGoodsNum").val()-0==0){
				    				flag = false;
				    			}
				    		});
							if(!flag){
								laywarn("发货数量不能为0。");
								return false;
							}
							var formdata = this.getOtherShipping(); //获取页面数据的值，用于提交到后台
							$.ajax({
								url: '<%=basePath%>sales/salesOrder/editSalesOrder',
								type: "POST",
								dataType: "json",
								data:{
									"salesOrder":JSON.stringify(formdata)
								},
								async: false,
								cache: false,
								success: (data)=> {
									if(data.success) {
										layer.close(index);
										laysuccess(data.msg);
										this.refreshDataTable();//刷新datatable
									} else {
										layer.close(index);
										layfail(data.msg);
									}
									
								}
							});
							
						},
						end: (index, layero) => {
							layer.close(index);
							clearForm("editDiv", "");
							this.clearGoodsEvent();
							this.clearPerson();
							$(".editInfo").remove();
						}
					});
				},
				otherShippingDeleteEvent: function(tid) {
					//其他发货单 删除
					
					console.log("其他发货单删除" + tid);
					
					/*
					 * 请在此处添加其他发货单删除的相关代码
					 */
					 publicMessageLayer("删除该订单", ()=> {
							$.ajax({
								url: '<%=basePath%>sales/salesOrder/deletePurchaseOrder',
								type: "POST",
								dataType: "json",
								data:{
									"id":tid
								},
								async: false,
								cache: false,
								success: (data)=> {
									if(data.success) {
										laysuccess(data.msg);
										//刷新datatable
										this.refreshDataTable();
									} else {
										layfail(data.msg);
									}
								}
							});
						})

					
				},
				otherShippingDeliverEvent: function(row) {
					//其他发货单 送审
					
					row=JSON.parse(row);
					console.log("其他发货单送审" + row.id);
					/*
					 * 请在此处添加其他发货单送审的相关代码
					 */
						publicMessageLayer("将本订单送审", ()=> {
							$.ajax({
								url: '<%=basePath%>sales/salesOrder/judgeIsSplitOrder',
								type: "POST",
								dataType: "json",
								data:{
									"salesOrderId":row.id
								},
								async: false,
								cache: false,
								success: (data)=> {
									//不需要进行分单
									if(data.success) {
										$.ajax({
											url: '<%=basePath%>sales/salesOrder/submitSalesOrder',
											type: "POST",
											dataType: "json",
											data:{
												"salesOrderId":row.id,
												"identifier":row.identifier,
												"flag":2
											},
											async: false,
											cache: false,
											success: (data)=> {
												if(data.success) {
													laysuccess(data.msg);
													//刷新datatable
													this.refreshDataTable();
												} else {
													layfail(data.msg);
												}
												
											}
										});
									}
									//需要进行分单
									else {
										layer.open({
											type: 1,
											title: "提示",
											closeBtn: 1,
											area: ['400px', '150px'],
											content: "<div class='text-center' style='height: 50px;line-height: 67px;'>" + data.msg + "</div>",
											btn: ['确认', '取消'],
											yes: (index)=> {
												$.ajax({
													url: '<%=basePath%>sales/salesOrder/submitSalesOrder',
													type: "POST",
													dataType: "json",
													data:{
														"salesOrderId":row.id,
														"identifier":row.identifier,
														"flag":2
													},
													async: false,
													cache: false,
													success: (data)=> {
														if(data.success) {
															laysuccess(data.msg);
															//刷新datatable
															this.refreshDataTable();
															
														} else {
															layfail(data.msg);
														}
														layer.close(index);
													}
												});
											}
										});
										
									}
									
								}
							});
							
						})
				},
				otherShippingStopEvent: function(row) {
					//其他发货单 作废
					row=JSON.parse(row);
					console.log("其他发货单作废" + row.id);
					
					/*
					 * 请在此处添加其他发货单终止的相关代码
					 */

					var state=0;
					if(row.state==11||row.state==25){
						state=-4;
					}else{
						state=-3;
					}
					
						var ids=[row.id+""];
						
						/*这是一个回调函数，请在此处书写点击作废的确定后需要执行的代码*/
						$.ajax({
							url: '<%=basePath%>sales/salesOrder/updateStateByIds',
							type: "POST",
							dataType: "json",
							data:{
								"ids":ids,
								"state":state,
								"isCheck":0,
								"reviewerType":0,
								"msg":"操作成功，已送审"
							},
							async: false,
							cache: false,
							traditional:true,
							success: (data)=> {
								if(data.success) {
									laysuccess(data.msg);
									//刷新datatable
									this.refreshDataTable();
								} else {
									layfail(data.msg);
								}
								
							}
						});
					
				},
				goodsAddEvent: function() {
					//新增商品
					//console.log("新增商品事件");
					

					let goodsId = $("#edit_goods").val(); //id
					let goodsIdentifier = "编码"; //编码
					let goodsName = "名称"; //名称
					let goodsType = "规格"; //规格
					let goodsUnit = "单位"; //单位
					let goodsPrice = "单价"; //单价
					let goodsTax = "0"; //税率
					let data=this.config.goodsSelectData;
					let warehouseId = -1; //税率
					/*
					 * 请根据之前存储到this.config.goodsSelectData进行循环
					 * 找到对应编码商品为名称、规格、品牌、单位赋值
					 */
					  for(var i=0;i<data.length;i++){

		                    if(data[i].id==goodsId){
		                        goodsTax=data[i].commodity.taxes;
		                        goodsIdentifier=data[i].specificationIdentifier;
		                        goodsName=data[i].commodity.name;
		                        goodsType=data[i].specificationName;
		                        goodsPrice=data[i].baseCommonlyPrice;
		                        goodsUnit=data[i].baseUnitName;
		                        warehouseId=data[i].specWarehouseId
		                    }

		              }
					 

					if(goodsId == -1) {
						layfail("请先选择商品!");
					} else if(!this.checkRepeatFun(this.config.goodsTable.goodsArr, goodsId)) {
						$(".tipTr").remove();
						this.config.goodsTable.goodsArr.push(goodsId);
						$("#goodsTbody").append(`<tr>
							<td class="edit_sales_commodity_id hidden"></td>
			                <td class="edit_warehouse_id hidden">` + warehouseId + `</td>
			                <td class="goodsId hidden">` + goodsId + `</td>	
							<td class="edit_goods_name">` + goodsName + `</td>
							<td class="edit_commodity_identifier">` + goodsIdentifier + `</td>
							<td class="edit_commodity_specifications_id">` + goodsType + `</td>
							<td class="edit_commodity_unit">` + goodsUnit + `</td>
							<td class="edit_unitPrice">` + goodsPrice + `</td>
							<td><input type="text" id="" value="" class="form-control edit_deliverGoodsNum" maxlength="9" attr-name="发货数量"/></td>
							<td><input type="text" id="" value="`+goodsTax+`" class="form-control edit_taxes" attr-name="税率"/></td>
							<td><input type="text" class="form-control edit_taxesMoney" attr-name="税额"/></td>
							<td><input type="text" id="" value="" class="form-control edit_deliverGoodsMoney" attr-name="金额"/></td>
							<td><input type="text" class="form-control edit_batch_number" attr-name="批号"/></td>
							<td><input type="text" id="" value="无" class="form-control edit_remark" onkeyup="cky(this)" attr-name="备注"/></td>
							<td><input type="button" class="btncss edit goodsDelBtn" attr-tid="` + goodsId + `" value="删除" /></td>
						</tr>`);
					} else {
						layfail("请勿重复选择商品！");
					}
				},
				goodsDelEvent: function(thisbtn, id) {
					//删除商品
					this.config.goodsTable.goodsArr.remove(id);
					$(thisbtn).parents("tr").remove();
					if($("#goodsTbody tr").length == 1) {
						$("#goodsTbody").append(this.config.goodsTable.tipTr);
					}
					this.countTotalFun();
				},
				clearGoodsEvent: function() {
					//清空商品
					$("#goodsTbody").html(this.config.goodsTable.head + this.config.goodsTable.tipTr);
					this.config.goodsTable.goodsArr = [];
				},
				clearPerson:function(){
					//还原业务员下拉框
					$("#person_id").html(`<option value="-1" selected="selected">--请先选择部门--</option>`);
				},
				checkRepeatFun: function(arr, id) {
					//查重
					let flag = false;
					for(var i in arr) {
						if(arr[i] == id) {
							flag = true;
						}
					}
					return flag;
				},
				checkFormRuleLayerFun: function() {
					//检查手机号和传真格式是否正确，正确返回true，相反返回false
					if(!checkFax($("#edit_fax").val())) {
						layfail("请输入正确的传真");
						return false;
					} else if(!checkMobilePhone($("#edit_phone").val())) {
						layfail("请输入正确的联系电话");
						return false;
					}
					return true;
				},
				checkInputEmptyLayer:function(thisInput){
					//判断footer或者header中Input框为空时弹出layer
					var $input=$(thisInput);
					var name=$input.parents(".form-group").find(".control-label").text();
					layfail(name+"不能为空");
				},
				checkTableInputEmptyLayer:function(thisInput){
					//判断table中Input框为空时弹出layer
					var $input=$(thisInput);
					var name=$input.attr("attr-name");
					layfail(name+"不能为空");
				},
				checkFormisFilledFun: function() {
					//判断表单是否填写完整 填写完整返回true,相反返回false
					var res = true;
					var that=this;
					/*$("#headEdit input").each(function(index, val) {
						if($(val).val() == "" && (!$(val).hasClass("searchable-select-input"))&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
						if($(val).hasClass("searchable-select-input")&&that.config.customerId==-1&&res){
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#headEdit select").each(function(index, val) {
						if($(val).val() == "-1"&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;*/
					if($(".tipTr").length > 0) {
						res = false;
						layfail("商品不能为空");
					}
					if(!res) return res;
					$("#goodsTbody input").each(function(index, val) {
						if($(val).val() == ""&&(!$(val).prop("disabled"))&&res) {
							that.checkTableInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#goodsTbody select").each(function(index, val) {
						if($(val).val() == "-1"&&res) {
							that.checkTableInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#footerEdit select").each(function(index, val) {
						if($(val).val() == "-1"&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					if(!res) return res;
					$("#footerEdit input").each(function(index, val) {
						if($(val).val() == ""&&res) {
							that.checkInputEmptyLayer(val);
							res = false;
						}
					});
					return res;
				},
				checkFormisFilledLayerFun() {
					let res = this.checkFormisFilledFun();
//					if(!res) layfail("表单未填写完整，请完善后提交");
					return res;
				},
				countOneTotalFun: function(input) {
					//计算合计
					$input = $(input);
					let total = 0;
					$.each($input, function(index, obj) {
						total += ($(obj).val() - 0);
					});
					return toDecimal2(total);
				},
				countTotalFun:function(){
					$("#total_commodity_num").val(parseInt(this.countOneTotalFun(".edit_deliverGoodsNum"))); //业务数量
					$("#total_commodity_price").val(this.countOneTotalFun(".edit_deliverGoodsMoney")); //税额
					
				}
			}
			order.init();

			//商品下拉框的onchang事件
			window.selectCommodityMsg = (thisSelect, value) => {

			}

		})(document);
	</script>

</html>