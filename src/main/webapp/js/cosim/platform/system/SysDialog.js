/**
 * 组织选择器
 * @param conf
 * 
 * conf 参数
 * 
 * orgId：组织ID
 * orgName:组织名称
 * @returns
 */
function OrgDialog(conf)
{
	var dialogWidth=650;
	var dialogHeight=500;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	
	var url=__ctx + '/platform/system/sysOrg/dialog.ht';
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,"",winArgs);
	
	if(conf.callback)
	{
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.orgId,rtn.orgName);
		}
	}
}


/**
 * 用户选择器 .
 * UserDialog({callback:function(userIds,fullnames,emails,mobiles){},selectUsers:[{id:'',name:''}]})
 */
function UserDialog(conf){
	
	var dialogWidth=650;
	var dialogHeight=500;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	
	if(!conf.isSingle)conf.isSingle=false;
	
	url=__ctx + "/platform/system/sysUser/dialog.ht?isSingle=" + conf.isSingle;
	url=url.getNewUrl();
	

	//重新选择的时候，展现上次数据
	var selectUsers="";
	if(  conf.selectUserIds && conf. selectUserNames){
		selectUsers={
				selectUserIds:conf.selectUserIds ,
				selectUserNames:conf. selectUserNames
		}
	}	
	var rtn=window.showModalDialog(url,selectUsers,winArgs);
	
	if(rtn && conf.callback){
		var userIds=rtn.userIds;
		var fullnames=rtn.fullnames;
		var emails=rtn.emails;
		var mobiles=rtn.mobiles;
		
		conf.callback.call(this,userIds,fullnames,emails,mobiles);
	}
}


/**
 * 这个选择器只用户在流程那里选择人员或部门。
 * 调用方法：
 * 
 * 
 * FlowUserDialog({selectUsers:[{type:'',id:'',name:''}],callback:function(aryType,aryId,aryName){}});
 * selectUsers，表示之前选择的人员，使用json数组来表示。
 * 数据格式:{type:'',id:'',name:''}
 * type:选择的类型。可能的值 user,org,role,pos .
 * id:选择的ID
 * name:显示的名称。
 * 
 * JSON数组：
 * 这个回调函数包括三个参数 ，这三个参数都为数组。
 * objType：返回的类型,可能的值(user,org,role,pos) 。
 * objIds:对象的Id。
 * objNames：对象的名称。
 */
function FlowUserDialog(conf){
	var dialogWidth=650;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	url=__ctx + "/platform/system/sysUser/flowDialog.ht";
	url=url.getNewUrl();
	//重新选择的时候，展现上次数据,必须传入
	var selectUsers="";
	if(  conf.selectUsers!=undefined && conf.selectUsers!=null && conf.selectUsers!=""){
		selectUsers=conf.selectUsers;
	}
	
	var rtn=window.showModalDialog(url,selectUsers,winArgs);
	if(rtn && conf.callback){
		conf.callback.call(this,rtn.objType,rtn.objIds,rtn.objNames);
	}
}

/**
 * 获取流程下一节点执行人
 * 调用方法：
 * 
 * 
 * NextUserDialog({selectUsers:[{type:'',id:'',name:''}],callback:function(aryType,aryId,aryName){}});
 * selectUsers，表示之前选择的人员，使用json数组来表示。
 * 数据格式:{type:'',id:'',name:''}
 * taskId : 流程任务Id
 * defKey : 流程定义Key
 * type:选择的类型。可能的值 user,org,role,pos .
 * id:选择的ID
 * name:显示的名称。
 * 
 * JSON数组：
 * 这个回调函数包括三个参数 ，这三个参数都为数组。
 * objType：返回的类型,可能的值(user,org,role,pos) 。
 * objIds:对象的Id。
 * objNames：对象的名称。
 */
function NextUserDialog(conf){
	var dialogWidth=650;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	url=__ctx + "/platform/system/sysUser/flowNextUserDialog.ht";
	
	if(conf.taskId!=null){
		url += "?taskId=" + conf.taskId;
	}
	if(conf.defKey!=null){
		url += "?defKey=" + conf.defKey;
	}
	
	url=url.getNewUrl();
	
	//重新选择的时候，展现上次数据,必须传入
	var selectUsers="";
	if(  conf.selectUsers!=undefined && conf.selectUsers!=null && conf.selectUsers!=""){
		selectUsers=conf.selectUsers;
	}
	
	var rtn=window.showModalDialog(url,selectUsers,winArgs);
	if(rtn && conf.callback){
		conf.callback.call(this,rtn.objType,rtn.objIds,rtn.objNames);
	}
}

/**
 * 角色选择器 
 */
function RoleDialog(conf){
	var dialogWidth=conf.dialogWidth || 695;
	var dialogHeight=conf.dialogHeight || 500;
	
	var dialogLeft = conf.dialogLeft || 50;
	var dialogTop = conf.dialogTop || 50;
	
	conf=$.extend({},{dialogLeft:dialogLeft, dialogTop:dialogTop, dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	
	var url = conf.url || __ctx + '/platform/system/sysRole/dialog.ht';
	/**
	 * 增加url传参功能,zouping,2014-07-23
	 */
	var param='';
	if(conf.param){
		param = '?1=1';
		for(var key in conf.param){       
			param += '&' + key + '=' + conf.param[key];
	    }
	}
	url += param;
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,"",winArgs);
	
	if(conf.callback)
	{
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.roleId,rtn.roleName);
		}
	}
}


/**
 * 岗位选择器
 * @param conf
 * 
 * dialogWidth：对话框高度 650
 * dialogHeight：对话框高度 500
 * 
 * conf.callback
 * 参数：
 * 		posId：岗位ID
 * 		posName:岗位名称
 * @returns
 */
function PosDialog(conf)
{
	var dialogWidth=680;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/platform/system/position/dialog.ht';
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,"",winArgs);
	if(conf.callback){
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.posId,rtn.posName);
		}
	}
}

/**
 * 用户选择器 
 */
function UserParamDialog(conf){
	var dialogWidth=650;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var args={cmpIds:conf.cmpIds,cmpNames:conf.cmpNames};
	var url=__ctx + '/platform/system/sysUserParam/dialog.ht?nodeUserId='+conf.nodeUserId;
	
	var rtn=window.showModalDialog(url,args,winArgs);
	if(conf.callback){
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.paramValue1,rtn.paramValue2);
		}
	}
}


/**
 * 用户选择器 
 */
function OrgParamDialog(conf){
	var dialogWidth=650;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var args={cmpIds:conf.cmpIds,cmpNames:conf.cmpNames};
	var url=__ctx + '/platform/system/sysOrgParam/dialog.ht?nodeUserId='+conf.nodeUserId;
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,args,winArgs);
	if(conf.callback){
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.paramValue1,rtn.paramValue2);
		}
	}
}


/**
 * 上下级选择器 
 */

function UplowDialog(conf){
	var dialogWidth=650;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/platform/bpm/bpmNodeUserUplow/dialog.ht';
	url=url.getNewUrl();
	if(conf.securityLevel){
		url += '?securityLevel=' + conf.securityLevel;
	}
	var rtn=window.showModalDialog(url,"",winArgs);
	if(conf.callback){
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.json,rtn.show);
		}
	}
}

/**
 *上级部门类型选择器
 */

function typeSetDialog(conf){
	var dialogWidth=500;
	var dialogHeight=360;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var args={cmpIds:conf.cmpIds,cmpNames:conf.cmpNames};
	var url=__ctx + '/platform/bpm/bpmDefinition/typeSetDialog.ht';
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,args,winArgs);
	if(conf.callback){
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.json,rtn.show);
		}
	}
}

/**
 * 图片上传器
 * @param conf
 */
function ImageUploadDialog(conf)
{
	var dialogWidth=550;
	var dialogHeight=540;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/pub/image/toUpload.ht';
	url=url.getNewUrl();
	if(conf.securityLevel){
		url += '&securityLevel=' + conf.securityLevel;
	}
	var rtn=window.showModalDialog(url,"",winArgs);
	
	if(conf.callback)
	{
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.picPath,rtn.picName);
		}
	}
}

/**
 * 图片上传器
 * @param conf
 */
function TerminalSellImageUploadDialog(conf, fixno, picindex)
{
	var dialogWidth=550;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:1,center:1},conf);
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center +";resizable=yes";
	var url=__ctx + '/cloud/pub/terminalSell/image/toUpload.ht?fixno='+fixno+'&picindex='+picindex;
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,"",winArgs);
	
	if(conf.callback)
	{
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.picPath,rtn.picName);
		}
	}
}

/**
 * 文件上传器
 * @param conf
 */
function FileUploadDialog(conf)
{
	var dialogWidth=550;
	var dialogHeight=200;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/pub/toUpload.ht';
	url=url.getNewUrl();
	if(conf.securityLevel){
		url += '&securityLevel=' + conf.securityLevel;
	}
	if(navigator.userAgent.indexOf("Chrome") >0 ){
		alert('Chrome浏览器暂不支持弹出框');
		return;
	}
	var	rtn=window.showModalDialog(url,conf,winArgs);
	
	if(conf.callback)
	{
		if(rtn!=undefined){
			conf.callback.call(this,rtn.filePath, rtn.fileName, rtn.fileSize);
		}
	}
}

/**
 * 打开弹出框
 * @param conf
 */
function OpenDialog(conf)
{
	var dialogWidth=550;
	var dialogHeight=500;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + conf.url;
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,"",winArgs);
	
	if(conf.callback)
	{
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.picSrc);
		}
	}
}

/**
 * 设备选择器
 * @param conf
 */
function ProductDialog(conf){
	var dialogWidth = 850;
	var dialogHeight = 500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	//窗口参数
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/b2b/system/product/product/commonSelector.ht';
	url = url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}


/**
 * 物品选择器，带单价，仓库（物料会重复）
 * @param conf
 */
function ItemDialog(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/config/material/itemSelector.ht';
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 纯物品选择器，不带任何单价、仓库的
 * @param conf
 */
function ItemDialog1(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/config/material/itemSelector1.ht';
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 物品选择器,带库存的,从库存表里面读取
 * @param conf
 */
function ItemAccountDialog(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var warehouseId = conf.warehouseId || 0;
	var url=__ctx + '/cloud/config/material/itemAccountSelector.ht?warehouseId=' + warehouseId;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}


/**
 * 商场选择器
 * @param conf
 */
function ItemMarketDialog(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var catalogId = conf.catalogId || 0;
	var url=__ctx + '/cloud/custom/market/itemMarketSelector.ht?catalogId=' + catalogId;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 商友选择器
 * @param conf
 */
function FriendsDialog(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var groupid = conf.groupid || 0;
	var url=__ctx + '/cloud/console/businessAreaGroup/itemSelector.ht?groupid=' + groupid;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

function PurOrderDialog(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/warehouse/jinlan/jLWarehouseIn/frame.ht';
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

function WareHouseOutProductDialog(conf,warehouseId)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/warehouse/jinlan/jLWarehouseAccounts/materialByWarehouseIframe.ht?warehouseId='+warehouseId;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

function wasterProductDialog(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/warehouse/jinlan/jLWarehouseAccountsWaste/iframe.ht';
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

function warehouseInDialog(conf,type)
{
	var dialogWidth=650;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/warehouse/jinlan/jLWarehouseIn/retrunIframe.ht?type='+type;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

function warehouseOutDialog(conf,type)
{
	var dialogWidth=650;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/warehouse/jinlan/jLWarehouseOut/retrunIframe.ht?type='+type;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 用户选择器,从指定该企业选择人员
 * UserDialog({companyId:0, callback:function(userIds,fullnames,emails,mobiles){},selectUsers:[{id:'',name:''}]})
 */
function CompanyUserDialog(conf){
	
	var dialogWidth=650;
	var dialogHeight=500;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1, companyId:0},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	
	if(!conf.isSingle)conf.isSingle=false;
	
	url=__ctx + "/cloud/system/auth/user/dialog.ht?isSingle=" + conf.isSingle + "&companyId=" + conf.companyId;
	url=url.getNewUrl();
	

	//重新选择的时候，展现上次数据
	var selectUsers="";
	if(  conf.selectUserIds && conf. selectUserNames){
		selectUsers={
				selectUserIds:conf.selectUserIds ,
				selectUserNames:conf. selectUserNames
		}
	}	
	var rtn=window.showModalDialog(url,selectUsers,winArgs);
	
	if(rtn && conf.callback){
		var userIds=rtn.userIds;
		var fullnames=rtn.fullnames;
		var emails=rtn.emails;
		var mobiles=rtn.mobiles;
		
		conf.callback.call(this,userIds,fullnames,emails,mobiles);
	}
}

/**
 * 组织选择器
 * @param conf
 */
function CompanyOrgDialog(conf)
{
	var dialogWidth=650;
	var dialogHeight=500;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	
	if(!conf.isSingle)conf.isSingle=false;
	
	var url=__ctx + '/cloud/config/enterprise/org/dialog.ht?isSingle=' + conf.isSingle;
	url=url.getNewUrl();
	var rtn=window.showModalDialog(url,"",winArgs);
	
	if(conf.callback)
	{
		if(rtn!=undefined){
			 conf.callback.call(this,rtn.orgId,rtn.orgName);
		}
	}
}

function materialAccountItemDialog(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/cloud/config/material/accountItemSelector.ht';
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 目标能力选择器
 * @param conf
 */
function abilityDialog(conf)
{
	var dialogWidth=850;
	var dialogHeight=500;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var groupid = conf.groupid || 0;
	var url=__ctx + '/b2b/base/inquiry/inquiry/selAbility.ht?groupid=' + groupid;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}


/**
 * 省市选择器
 * @param conf
 */
function provinceDialog(conf,areaName)
{
	var dialogWidth=640;
	var dialogHeight=480;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/b2b/base/inquiry/inquiry/selProvince.ht?areaName=' + areaName;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 人员选择器
 * @param conf
 */
function checkUserDialog(conf,type)
{
	var dialogWidth=640;
	var dialogHeight=480;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/b2b/base/inquiry/inquiry/selUser.ht?type=' + type;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 服务方选择器
 * @param conf
 */
function serverDialog(conf,provinceName,history)
{
	var dialogWidth=850;
	var dialogHeight=480;
	provinceName = encodeURI(encodeURI(provinceName));
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/b2b/base/inquiry/inquiry/selServer.ht?provinceName=' + provinceName+"&history=" + history;
	url=url.getNewUrl();
	
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 企业选择器
 * @param conf
 */
function SysOrgInfoDialog(conf)
{
	var dialogWidth=750;
	var dialogHeight=500;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	
	if(!conf.isSingle)conf.isSingle=false;
	
	var url=__ctx + '/platform/system/sysOrg/listTenant.ht?isSingle=' + conf.isSingle;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 中标企业选择器
 * @param conf
 */
function quoteEntDialog(conf,inquiryId)
{
	var dialogWidth=640;
	var dialogHeight=480;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/b2b/base/quote/quote/getQuoteEnt.ht?id=' + inquiryId;
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 分类选择器
 * @param conf
 */
function checkTypeDialog(conf)
{
	var dialogWidth=640;
	var dialogHeight=480;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/b2b/b2bMaterialClass/b2bMaterialClass/selType.ht';
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}

/**
 * 物料选择器
 * @param conf
 */
function selCodeDialog(conf)
{
	var dialogWidth=640;
	var dialogHeight=480;
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
	
	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	var url=__ctx + '/b2b/b2bMaterialCode/b2bMaterialCode/selType.ht';
	url=url.getNewUrl();
	window.showModalDialog(url,conf,winArgs);
}