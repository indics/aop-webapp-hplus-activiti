function ColumnDialog(conf)
{
	if(!conf) conf={};
	var url=__ctx + '/platform/form/bpmFormTable/columnDialog.ht?isAdd=' ;
	url+=conf.isAdd?"1":"0";
	url+="&isMain="+conf.isMain;
	
	var dialogWidth=700;
	var dialogHeight=540;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth:"+conf.dialogWidth+"px;dialogHeight:"+conf.dialogHeight
		+"px;help:" + conf.help +";status:" + conf.status +";scroll:" + conf.scroll +";center:" +conf.center;
	
	
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,conf,winArgs);
	
}