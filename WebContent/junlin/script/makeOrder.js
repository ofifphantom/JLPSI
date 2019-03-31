let goodsIndex = 0;
let orderJson = {};

/*新增单据*/
function orderAdd(callfun) {
	goodsAddEdit(); /*新增商品的方法*/
	$("#headEdit").html(panelEditGet("", orderJson.head));
	$("#headEdit>div").children().first().remove();
	$("#headEdit>div").children().first().remove();

	layer.open({
		type: 1,
		title: "新增" + orderJson.title,
		closeBtn: 1,
		area: ['100%', '100%'],
		content: $("#editDiv"),
		btn: ['提交', '取消'],
		yes: function(index) {
			layer.close(index);

			callfun();
		},
		end: function(index, layero) {
			layer.close(index);
			$("#allgoodDivEdit").html("");
			clearForm("editDiv", "");
		}
	});
}

/*编辑单据*/
function OrderEdit(callfunBefore, callfunafter) {
	$("#headEdit").html(panelEditGet("", orderJson.head));
	callfunBefore();
	layer.open({
		type: 1,
		title: "编辑" + orderJson.title,
		closeBtn: 1,
		area: ['100%', '100%'],
		content: $("#editDiv"),
		btn: ['提交', '取消'],
		yes: function(index) {
			layer.close(index);

			callfunafter();
		},
		end: function(index, layero) {
			layer.close(index);
			$("#allgoodDivEdit").html("");
			clearForm("editDiv", "");
		}
	});
}
/*详情*/
function OrderDetail(callfun) {
	goodsAddDetail(callfun);
	layer.open({
		type: 1,
		title: orderJson.title + "详情",
		closeBtn: 1,
		area: ['100%', '100%'],
		content: $("#detailDiv"),
		btn: ['关闭']
	});
}
/*打印*/
function orderPrint(url, count, callfun) {
	$.ajax({
		type: "get",
		url: url,
		async: true,
		success: function(res) {
			let bill = new Bill(res);
			let $content = bill.toPrint();
			$("#printDiv").html("");
			$("#printDiv").append($content);
			$("#printDiv").append(watermark("打印次数：" + count + "次", "#pickingList"));
			$('.watermark>div').fontFlex(80, 100, 10);
		}
	});
	layer.open({
		type: 1,
		title: orderJson.title + "详情",
		closeBtn: 1,
		area: ['100%', '100%'],
		content: $("#printDiv"),
		btn: ['打印', '关闭'],
		yes: function(index) {
			$("#printDiv .container").printArea();
			callfun();
		},
		end: function(index, layero) {
			layer.close(index);
			$("#printDiv").html("");
		}
	});

}
/*新增商品（详情）*/
function goodsAddDetail(callfun) {
	$("#headDetail").html(panelDetailGet("", orderJson.head));
	$("#totalDetail").html(panelDetailGet("", orderJson.total));
	$("#footerDetail").html(panelDetailGet("", orderJson.footer));
	$("#allgoodDivDetail").html("");
	callfun();
}

/*新增商品（新增、修改）*/
function goodsAddEdit() {
	let form = new FormPanel("editGoodsDiv" + goodsIndex, orderJson.goods);
	let $panel = form.toformPrint();
	$panel.append(form.toCloseSpan);
	$("#allgoodDivEdit").append($panel);
	goodsOptionAppend($("#editGoodsDiv" + goodsIndex).find('select').first());
	form.toWork();
	SearchableSelectsetValue($("#editGoodsDiv" + goodsIndex).find('select').first(), "-1");
	goodsIndex++;
}

/*新增模块（新增、修改）*/
function panelDetailGet(id, jsonArr) {
	let form = new FormPanel(id, jsonArr);
	let $obj = form.toDetailPrint();
	return $obj;
}

/*新增模块（新增、修改）*/
function panelEditGet(id, jsonArr) {
	let form = new FormPanel(id, jsonArr);
	let $obj = form.toformPrint();
	return $obj;
}

/*删除商品*/
function delform(thisspan) {
	if($("#allgoodDivEdit>div").length > 1) {
		$(thisspan).parent().remove();
	} else {
		layfail("商品不能为空");
	}

}

/*
 * 作用：为select添加option
 * 参数：$select选择器，json数据
 * json格式：
 * [{
 * 	"id":123,
 * 	"name":"棉花糖"
 * },{
 * 	"id":123,
 * 	"name":"棉花糖"
 * }
 * ];
 * */
function addOption($select, json) {
	for(let i = 0; i < json.length; i++) {
		$select.append('<option value="' + json[i]["id"] + '" selected="selected">' + json[i]["name"] + '</option>');
	}
}

/*作用：赋值  一般的input，select赋值
 * json格式：
 * [
 * {
 * 	"classname":"name":,
 * 	"value":"123"
 * }
 * ]
 */
function setValueForm(parentid,json) {
	for(let i=0;i<json.length;i++){
		$("#"+parentid+" ."+json[i]["classname"]).val(json[i]["value"]);
	}
}

/*赋值 div赋值*/
function setValueDiv(parentid,json) {
	for(let i=0;i<json.length;i++){
		$("#"+parentid+" ."+json[i]["classname"]).html(json[i]["value"]);
	}
}