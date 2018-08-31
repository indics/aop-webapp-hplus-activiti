if (typeof FormUtil == 'undefined') {
	FormUtil = {};
}

/**
 * 初始化表单tab。
 */
FormUtil.initTab=function(){
	var amount=$("#formTab").length;
	if(amount>0){
		$("#formTab").ligerTab();
	}
};

/**
 * 初始化日历控件。
 */
FormUtil.initCalendar=function(){
	
	$("body").delegate("input.Wdate", "click",function(){
		var fmt=$(this).attr("dateFmt");
		WdatePicker({el:this,dateFmt:fmt});
	});
};



/**
 * 绑定对话框。 按钮或者文本框定义如下：
 * dialog="{name:'globalType',fields:[{src:'TYPENAME',target:'m:mainTable:name'},{src:'TYPEID',target:'m:mainTable:address'}]}"
 * 
 * name:对话框的别名 fields：为字段映射，可以有多个映射。 src：对话框返回的字段。 target：需要映射的控件名称。
 */
FormUtil.initCommonDialog=function(){
	$("body").delegate("[dialog]", "click", function(){
		var obj=$(this);
		var dialogJson=obj.attr("dialog");
		var json=eval("("+dialogJson+")" );
		var name=json.name;

		var fields=json.fields;
		var parentObj=obj.closest("[formtype]");
		var isGlobal=parentObj.length==0;
		
		CommonDialog(name,function(data){
			var len=data.length;
			for(var i=0;i<fields.length;i++){
				var json=fields[i];
				var src=json.src;
				var targets=json.target.split(','),target;
				while(target=targets.pop()){
					if(!target)return;
					var filter="[name$='"+target+"']";
					//在子表中选择
					var targetObj=isGlobal?$(filter):$(filter,parentObj);
					
					//单选
					if(len==undefined){
						targetObj.val(data[src]);
					}
					//多选
					else{
						for(var k=0;k<len;k++){
							var dataJson=data[k];
							if(json.data){
								json.data.push(dataJson[src]);
							}
							else{
								var tmp=[];
								tmp.push(dataJson[src]);
								json.data=tmp;
							}
						}
						targetObj.val(json.data.join(","));
					}
				}				
			}
		});
	});
};

/**
 * 显示选择器对话框。
 * obj 按钮控件
 * fieldName 字段名称
 * type :选择器类型。
 * 1.单用户选择器。2.角色选择器。3.组织选择器.4.岗位选择器。5.人员选择器(多选)
 */
FormUtil.handSelector=function(){
	$("body").delegate("a.link.user", "click",function(){
		var obj=$(this);
		FormUtil.Selector(obj,1);
	});
	
	$("body").delegate("a.link.role", "click",function(){
		var obj=$(this);
		FormUtil.Selector(obj,2);
	});
	
	$("body").delegate("a.link.org", "click",function(){
		var obj=$(this);
		FormUtil.Selector(obj,3);
	});
	
	$("body").delegate("a.link.position", "click",function(){
		var obj=$(this);
		FormUtil.Selector(obj,4);
	});
	
	$("body").delegate("a.link.users", "click",function(){
		var obj=$(this);
		FormUtil.Selector(obj,5);
	});
};

FormUtil.Selector=function(obj,type){
	var fieldName=obj.attr("name");
	var parent=obj.parent();
	var idFilter="input[name='"+fieldName+"ID']";
	var nameFilter="input[name='"+fieldName+"']";
	var inputId=$(idFilter,parent);
	var inputName=$(nameFilter,parent);
	switch(type){
		//单用户选择器
		case 1:
			UserDialog({isSingle:true,callback :function(ids, names){
				if(inputId.length>0){
					inputId.val(ids);
				}
				inputName.val(names);}});
			break;
		//角色选择器
		case 2:
			RoleDialog({callback :function(ids, names){
				if(inputId.length>0){
					inputId.val(ids);
				};
				inputName.val(names);}});
			break;
		//组织选择器
		case 3:
			OrgDialog({callback :function(ids, names){
				if(inputId.length>0){
					inputId.val(ids);
				};
				inputName.val(names);}});
			break;
		//岗位选择器
		case 4:
			PosDialog({callback :function(ids, names){if(inputId.length>0){
				inputId.val(ids);
			};
			inputName.val(names);}});
			break;
		//人员选择器(多选)
		case 5:
			UserDialog({callback :function(ids, names){if(inputId.length>0){
				inputId.val(ids);
			};
			inputName.val(names);}});
			break;
	}
};

/**
 * 初始化统计函数事件绑定
 */
FormUtil.InitMathfunction = function() {
	$(".math-function-input").each(function() {
		var jsonStr = $(this).attr("funcexp");
		if (!jsonStr)
			return;
		var me = this, 
			jsonObj = eval("(" + jsonStr + ")"), 
			target = [];
		
		if(!FormData.FunctionType)
			return;
		if(jsonObj.label){
			me=$.tagName(me,"span");
		}
		for ( var i = 0, c; c = FormData.FunctionType[i++];) {
			if (c.name == jsonObj.type) {
				jsonObj.handle = c.handle;
			}
		}
		for ( var i = 0, c; c = jsonObj.target[i++];) {
			var targetObj = $("input[name='"+c.name+"']");
			if(targetObj.length>1)
				target=$.merge(target,targetObj);
			else
				target.push(targetObj);
		}
		for ( var i = 0, c; c = jsonObj.target[i++];) {
			$("input[name='"+c.name+"']").blur(function() {
				jsonObj.handle(me, target,function(self,val){
					if(jsonObj.capital){//转换为大写人民币
						var v=$.convertCurrency(val);
						$(self).val(v);
					}
				});
			});
			jsonObj.handle(me, target,function(self,val){
				if(jsonObj.capital){//转换为大写人民币
					var v=$.convertCurrency(val);
					$(self).val(v);
				}
			});
		}
	});
};

$(function(){
	//初始化表单tab
	FormUtil.initTab();
	//初始化日期控件。
	FormUtil.initCalendar();
	//附件初始化
	AttachMent.init();
	//子表权限初始化
	SubtablePermission.init();
	FormUtil.handSelector();
	
	FormUtil.InitMathfunction();
	//绑定对话框。
	FormUtil.initCommonDialog();
});


$(window).bind("load",function(){
	
	//Office控件初始化。
	OfficePlugin.init();
});