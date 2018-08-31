if (typeof FlowUtil == 'undefined') {
	FlowUtil = {};
}

/**
 * 启动流程。
 * @param defId 流程定义ID。
 */
FlowUtil.startFlow=function(defId,actDefId){
	var url= __ctx +"/platform/bpm/bpmDefinition/getCanDirectStart.ht";
	var params={defId:defId};
	$.post(url,params,function(data){
		if(data){
			var callBack=function(rtn){
				if(!rtn) return;
				var flowUrl= __ctx +"/platform/bpm/task/startFlow.ht";
				var parameters={actDefId:actDefId};
				$.post(flowUrl,parameters,function(responseText){
					var obj=new com.cosim.form.ResultMessage(responseText);
					if(obj.isSuccess()){//成功
						$.ligerMessageBox.success('提示信息',"启动流程成功!");
					}
					else{
						$.ligerMessageBox.error('出错了',"启动流程失败!");
					}
				});
			};
			$.ligerMessageBox.confirm('提示信息',"需要启动流程吗?",callBack);
		}else{
			var url=__ctx +"/platform/bpm/task/startFlowForm.ht?defId="+defId;
			jQuery.openFullWindow(url);
		}
	});
};