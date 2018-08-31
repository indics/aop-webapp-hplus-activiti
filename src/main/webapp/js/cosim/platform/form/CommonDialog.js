/**
 * 通用对话框。
 * @param alias		对话框别名。
 * @param callBack	回调函数。
 * 调用示例：
 * CommonDialog("role",function(data){
 * 
 * });
 * data:为json数组或者为json对象。
 */
function CommonDialog(alias,callBack){
	window.__resultData__=0;
	if(alias==null || alias==undefined){
		$.ligerMessageBox.warn('提示信息',"别名为空！");
		return;
	}
	var url=__ctx + "/platform/form/bpmFormDialog/dialogObj.ht?alias=" +alias;
	url=url.getNewUrl();
	$.post(url,{"alias":alias},function(data){
		if(data.success==0){
			$.ligerMessageBox.warn('提示信息',"输入别名不正确！");
			return;
		}
		var obj=data.bpmFormDialog;
		var width=obj.width;
		var name=obj.name;
		var height=obj.height;
		var displayList=obj.displayfield.trim();
		var resultfield=obj.resultfield.trim();
		
		if( displayList==""){
			$.ligerMessageBox.warn('提示信息',"没有设置显示字段！");
			return;
		}
		if( resultfield==""){
			$.ligerMessageBox.warn('提示信息',"没有设置结果字段！");
			return;
		}
		var urlShow=__ctx + "/platform/form/bpmFormDialog/show.ht?dialog_alias_=" +alias;
		urlShow=urlShow.getNewUrl();
		$.ligerDialog.open({ url:urlShow, height: height,width: width, title :name,name:"frameDialog_",
			buttons: [ { text: '确定', onclick: function (item, dialog) { 
					if(__resultData__==-1 || __resultData__==0){
						alert("还没有选择数据项！");
						return;
					}
					if(callBack){
						callBack(__resultData__);
					}
					dialog.close();
			} }, 
			{ text: '取消', onclick: function (item, dialog) { dialog.close(); } } ] });
	});
};
/**
 * 调用通用表单查询
 * @param alias 查询别名
 * @param callback 回调函数
 */
function CommonQuery(alias){
	window.__queryData__ = [];
	if(alias==null || alias==undefined){
		$.ligerMessageBox.warn('提示信息',"别名为空！");
		return;
	}
	var url=__ctx + "/platform/bpm/bpmFormQuery/queryObj.ht?alias=" +alias;
	url=url.getNewUrl();
	$.post(url,{"alias":alias},function(data){
		if(data.success==0){
			$.ligerMessageBox.warn('提示信息',"输入别名不正确！");
			return;
		}
		var obj=data.bpmFormQuery;
		var name=obj.name;
		var conditionfield=obj.conditionfield.trim();
		var resultfield=obj.resultfield.trim();
		
		if( conditionfield==""){
			$.ligerMessageBox.warn('提示信息',"没有设置条件字段！");
			return;
		}
		if( resultfield==""){
			$.ligerMessageBox.warn('提示信息',"没有设置结果字段！");
			return;
		}
		
		var urlShow=__ctx + "/platform/bpm/bpmFormQuery/get.ht?query_alias_=" +alias;
		urlShow=urlShow.getNewUrl();
		$.ligerDialog.open({ url:urlShow, height: 380,width: 600, title :name,name:"frameQuery_",
			buttons: [{ text: '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
	});
};

/**
 * 执行查询
 * @param alias 查询别名
 * @param condition 查询条件
 * @param callback 查询完成后的回调
 */
function DoQuery(condition,callback){
	var url = __ctx + "/platform/bpm/bpmFormQuery/doQuery.ht";
	$.post(url,condition,function(data){
		if(callback)
			callback(data);
	});	
};
