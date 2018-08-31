/**
 * 流程选择窗口。
 * dialogWidth：窗口宽度，默认值700
 * dialogWidth：窗口宽度，默认值400
 * callback：回调函数
 * 回调参数如下：
 * key:参数key
 * name:参数名称
 * 使用方法如下：
 * 
 * BpmDefinitionDialog({isSingle:true,callback:dlgCallBack}){
 *		//回调函数处理
 *	}});
 * @param conf
 */
function BpmDefinitionDialog(conf)
{
	if(!conf) conf={};
	var url=__ctx +"/platform/bpm/bpmDefinition/dialog.ht?isSingle=" + conf.isSingle;

	var dialogWidth=860;
	var dialogHeight=600;
	$.extend(conf, {dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:1,center:1});
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	if(!conf.isSingle)conf.isSingle=false;
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,conf,winArgs);
	if(rtn!=undefined){
		if(conf.callback){
			var defIds=rtn.defIds;
			var subjects=rtn.subjects;
			if(conf.returnDefKey){
				var defKeys = rtn.defKeys;
				conf.callback.call(this,defIds,subjects,defKeys);
			}else{
				conf.callback.call(this,defIds,subjects);
			}
		}
	}
}