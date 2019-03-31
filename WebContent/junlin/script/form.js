/*
 *生成表单
 * 版本：1.0
 * */
class FormPanel{
	constructor(divId,json){
		this.id=divId;
		this.jsonArrdata = json;
	}
	toDiv(){
		return $('<div class="row"></div>');
	}
	toPanel(){
		return this.toDiv().addClass("row jl-panel");
	}
	toColSix(){
		return this.toDiv().addClass("col-xs-6");
	}
	toColEight(){
		return this.toDiv().addClass("col-xs-8");
	}
	toFormGroup(){
		return this.toDiv().addClass("form-group");
	}
	toLabel(str){
		return $('<label for="" class="col-xs-4 control-label">'+str+'：</label>');
	}
	toText(classname,val){
		return this.toColEight().addClass(classname).append(val);
	}
	toInput(classname,val){
		let $input=$('<input type="text" name="" id="" value="" class="form-control '+classname+'" onblur="cky(this)"/>');
		if(val!=""){
			return $input.val(val);
		}else{
			return $input;
		}
	}
	toSelect(classname,val){
		let $select=$('<select class="form-control '+classname+'"><option value="-1" selected="selected">--请选择--</option></select>');
		return $select;
		/*if(val!=""){
			return $select.val(val);
		}else{
			return $select;
		}*/
	}
	toDate(classname,val){
		let $date=this.toDisable(this.toInput(classname,val));
		return $date;
	}
	toSearchSelect(classname,val){
		return this.toSelect(classname,val);
	}
	toTypeahead(classname,val){
		return this.toSelect(classname,val);
	}
	toDisable($obj){
		return $obj.attr("disabled","disabled");
	}
	toPlaceholder($obj,str){
		return $obj.attr("placeholder",str);
	}
	
	toform(jsonarr){
		let $panel=this.toPanel();
		for(let i=0;i<jsonarr.length;i++) {
			let res = jsonarr[i];
			let $reObj;
			let $changeObj;
			switch(res.type){
				case "text":
				$changeObj=this.toText(res.class,res.value);
				break;
				
				case "input":
				$changeObj=this.toInput(res.class,res.value);
				break;
				
				case "inputDisable":
				$changeObj=this.toDisable(this.toInput(res.class,res.value));
				break;
				
				case "date":
				$changeObj=this.toDate(res.class,res.value,res.placeholder);
				break;
				
				case "select":
				$changeObj=this.toSelect(res.class,res.value);
				break;
				
				case "selectDisable":
				$changeObj=this.toDisable(this.toSelect(res.class,res.value));
				break;
				
				case "searchSelect":
				$changeObj=this.toSearchSelect(res.class,res.value);
				break;
				
				case "typeahead":
				$changeObj=this.toTypeahead(res.class,res.value);
				break;
			}
			if(res.type!="text"){
				if(res.placeholder!=""){
					$changeObj=this.toPlaceholder($changeObj,res.placeholder);
				}
				$changeObj=this.toColEight().append($changeObj);
			}
			
			$reObj=this.toColSix().append(this.toFormGroup().append(this.toLabel(res.name)).append($changeObj));
			
			$panel.append($reObj);
		}
		return $panel;
		
	}
	toCloseSpan(){
		return $('<span class="close_span" onclick="delform(this)"><i class="fa fa-times"></i></span>');
	}
	toWork(){
		
		for(let i=0;i<this.jsonArrdata.length;i++) {
			let res=this.jsonArrdata[i];
			switch(res.type){
				case "date":
				latdate('#'+this.id+" ."+res.class);
				break;
				
				case "searchSelect":
				$('#'+this.id+" ."+res.class).searchableSelect();
				break;
				
				case "typeahead":
				
				break;
			}
			
			
		}
	}
	toformPrint(){
		return this.toform(this.jsonArrdata).attr('id',this.id);
	}
	toDetailPrint(){
		let jsonarr=this.jsonArrdata;
		let $panel=this.toPanel();
		for(let i=0;i<jsonarr.length;i++) {
			let res = jsonarr[i];
			let $reObj;
			let $changeObj=this.toText(res.class,res.value);
			$reObj=this.toColSix().append(this.toFormGroup().append(this.toLabel(res.name)).append($changeObj));
			$panel.append($reObj);
		}
		return $panel.attr('id',this.id);
		
	}
}
