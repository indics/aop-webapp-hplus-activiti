/**
 * 附件管理。
 * @returns {AttachMent}
 */
if (typeof AttachMent == 'undefined') {
	AttachMent = {};
}

/**
 * 添加附件数据。
 * @param obj 按钮。
 * @param fieldName 字段名称
 */
AttachMent.addFile=function(obj){	
	var inputObj=$(obj);
	var fieldName=inputObj.attr("field");
	var parent=inputObj.parent();

	var rights="w";
	var divName="div.attachement";
	var inputName="input[name='" +fieldName +"'],textarea[name='" +fieldName +"']";
	//获取div对象。
	var divObj=$(divName,parent);
	var inputJson=$(inputName,parent);
	
	var aryJson=AttachMent.getFileJsonArray(divObj);
	//文件选择器
	FlexUploadDialog({isSingle:false,callback:function (fileIds,fileNames,filePaths,extPaths){
		if(fileIds==undefined || fileIds=="") return ;
		var aryFileId=fileIds.split(",");
		var aryName=fileNames.split(",");
		var aryPath=filePaths.split(",");
		var aryExtPath=extPaths.split(",");
	
		for(var i=0;i<aryFileId.length;i++){
			var name=aryName[i] +"." +aryExtPath[i];
			AttachMent.addJson(aryFileId[i],name,aryPath[i]  ,aryJson);
		}
		//获取json
		var json=JSON.stringify(aryJson);		
		var html=AttachMent.getHtml(aryJson,rights);
		divObj.empty();
		divObj.append($(html));
		window.parent._callback(fileIds);
		inputJson.val(json);
	}});
};

/**
 * WQ：根据协同研发流程，扩展添加附件数据。
 * @param obj 按钮。
 * @param fieldName 字段名称
 */
AttachMent.addFile1=function(obj){	
	var inputObj=$(obj);
	var fieldName=inputObj.attr("field");
	var parent=inputObj.parent();
	
	var rights="w";
	var divName="div.attachement";
	var inputName="input[name='" +fieldName +"'],textarea[name='" +fieldName +"']";
	//获取div对象。
	var divObj=$(divName,parent);
	var inputJson=$(inputName,parent);
	
	var aryJson=AttachMent.getFileJsonArray(divObj);
	//文件选择器
	FlexUploadDialog({isSingle:true,callback:function (fileIds,fileNames,filePaths,extPaths){
		if(fileIds==undefined || fileIds=="") return ;
		var aryFileId=fileIds.split(",");
		var aryName=fileNames.split(",");
		var aryPath=filePaths.split(",");
		var aryExtPath=extPaths.split(",");
		
		for(var i=0;i<aryFileId.length;i++){
			var name=aryName[i] +"." +aryExtPath[i];
			AttachMent.addJson(aryFileId[i],name,aryPath[i]  ,aryJson);
		}
		//获取json
		var json=JSON.stringify(aryJson);		
		var html=AttachMent.getHtml(aryJson,rights);
		divObj.empty();
		divObj.append($(html));
		window._fileCallback(fileIds,fileNames,filePaths);
		inputJson.val(json);
	}});
};
/**
 * WQ：根据协同研发流程，扩展添加附件数据。
 * @param obj 按钮。
 * @param fieldName 字段名称
 */
AttachMent.addFile2=function(obj){	
	var inputObj=$(obj);
	var fieldName=inputObj.attr("field");
	var parent=inputObj.parent();
	
	var rights="w";
	var divName="div.attachement";
	var inputName="input[name='" +fieldName +"'],textarea[name='" +fieldName +"']";
	//获取div对象。
	var divObj=$(divName,parent);
	var inputJson=$(inputName,parent);
	
	var aryJson=AttachMent.getFileJsonArray(divObj);
	//文件选择器
	FlexUploadDialog({isSingle:true,callback:function (fileIds,fileNames,filePaths,extPaths){
		if(fileIds==undefined || fileIds=="") return ;
		var aryFileId=fileIds.split(",");
		var aryName=fileNames.split(",");
		var aryPath=filePaths.split(",");
		var aryExtPath=extPaths.split(",");
		
		for(var i=0;i<aryFileId.length;i++){
			var name=aryName[i] +"." +aryExtPath[i];
			AttachMent.addJson(aryFileId[i],name,aryPath[i]  ,aryJson);
		}
		//获取json
		var json=JSON.stringify(aryJson);		
		var html=AttachMent.getHtml(aryJson,rights);
		divObj.empty();
		divObj.append($(html));
		window._fileCallback2(fileIds,fileNames,filePaths);
		inputJson.val(json);
	}});
};

/**
 * 删除附件
 * @param obj 删除按钮。
 */
AttachMent.delFile=function(obj){
	var inputObj=$(obj);
	var parent=inputObj.parent();
	var divObj=parent.parent();
	var spanObj=$("span[name='attach']",parent);
	var divContainer=divObj.parent();
	var fileId=spanObj.attr("fileId");
	var aryJson=AttachMent.getFileJsonArray(divObj);
	AttachMent.delJson(fileId,aryJson);
	var json=JSON.stringify(aryJson);
	var inputJsonObj=$("textarea",divContainer);
	//设置json
	inputJsonObj.val(json);
	//删除span
	parent.remove();
};

/**
 * 初始化表单的附件字段数据。
 */
AttachMent.init=function(subRights,parent){
	if(	$.isEmpty(parent))
		parent = $("div[name='div_attachment_container']");
	parent.each(function(){
		var me=$(this),
			rights=me.attr("right");
		//如果没有权限属性，可能是子表中的附件
		if(!rights){
			rights=me.closest("[type='subtable']").attr("right");
		}
		//对于弹出框的处理
		if(!$.isEmpty(subRights))
			rights = subRights;	
		if(rights){
			rights=rights.toLowerCase();
		}
		if(rights!="w" && rights!="r"){
			me.remove();
		}		
		else{
			if(rights=="r"){
				$("a.attachement").remove();
			}
			//var jsonStr=$(".selectFile",me).val();
			var atta =$("textarea[controltype='attachment']",me);
			var jsonStr = atta.val();
			if(!$.isEmpty(jsonStr)){
				jsonStr = jsonStr.replaceAll("￥@@￥","\"");
				atta.val(jsonStr);
			}
			var divAttachment=$("div.attachement",me);
			//json数据为空。
			AttachMent.insertHtml(divAttachment,jsonStr,rights);
		}
	});
};

/**
 *  附件插入显示
 * @param {} div
 * @param {} jsonStr 
 * @param {} rights 权限 如果不传，默认是r
 */
AttachMent.insertHtml= function(div,jsonStr,rights){
	if($.isEmpty(jsonStr)) return ;
	if($.isEmpty(rights)) rights ='r';
	var jsonObj=[];
	try {
		jsonStr = jsonStr.replaceAll("￥@@￥","\"");
		jsonObj =	jQuery.parseJSON(jsonStr);
	} catch (e) {
	}
	var html=AttachMent.getHtml(jsonObj,rights);
	div.empty();
	div.append($(html));
};

/**
 * 获取文件的html。
 * @param aryJson
 * @returns {String}
 */
AttachMent.getHtml=function(aryJson,rights){	
	var str="";
	var template="";
	var templateW="<span class='attachement-span'><span fileId='#fileId#' name='attach' file='#file#'><a class='attachment' target='_blank' href='#path#'>#name#</a></span><a href='javascript:;' onclick='AttachMent.delFile(this);' class='cancel'></a></span>";
	var templateR="<span class='attachement-span'><span fileId='#fileId#' name='attach' file='#file#'><a class='attachment' target='_blank' href='#path#'>#name#</a></span>&nbsp;</span>";
	
	if(rights=="w"){
		template=templateW;
	}
	else{
		template=templateR;
	}
	for(var i=0;i<aryJson.length;i++){
		var obj=aryJson[i];
		var id=obj.id;
		var name=obj.name;
		var path = obj.path;
		if(!(/^\/.*/g.test(obj.path)))
			path=__ctx +"/"+ obj.path;
		var file=id +"," + name +"," + path;
		var tmp=template.replace("#file#",file).replace("#path#",path).replace("#name#", name).replace("#fileId#", id);
		//附件如果是图片就显示到后面
		if (/\w+.(png|gif|jpg)/gi.test(path)){
			ImageQtip.drawImg(id,path,{maxWidth:400,name:name},function(tag,img,option){
				setTimeout(function(){				
					var t = $("span[fileid='"+tag+"']").parent().parent();
					img.title=option.name;
					t.append("<br /><br />");
					t.append(img.outerHTML);
					t.append("<br />"+option.name);
				},100);			
			});
		}
		str+=tmp;
	}
	return str;
};

/**
 * 添加json。
 * @param fileId
 * @param name
 * @param path
 * @param aryJson
 */
AttachMent.addJson=function(fileId,name,path,aryJson){
	var rtn=AttachMent.isFileExist(aryJson,fileId);
	if(!rtn){
		var obj={id:fileId,name:name,path:path};
		aryJson.push(obj);
	}
};

/**
 * 删除json。
 * @param fileId 文件ID。
 * @param aryJson 文件的JSON。
 */
AttachMent.delJson=function(fileId,aryJson){
	for(var i=aryJson.length-1;i>=0;i--){
		var obj=aryJson[i];
		if(obj.id==fileId){
			aryJson.splice(i,1);
		}
	}
};

/**
 * 判断文件是否存在。
 * @param aryJson
 * @param fileId
 * @returns {Boolean}
 */
AttachMent.isFileExist=function(aryJson,fileId){
	
	for(var i=0;i<aryJson.length;i++){
		var obj=aryJson[i];
		if(obj.id==fileId){
			return true;
		}
	}
	return false;
};

/**
 * 取得文件json数组。
 * @param divObj
 * @returns {Array}
 */
AttachMent.getFileJsonArray=function(divObj){
	var aryJson=[];
	var arySpan=$("span[name='attach']",divObj);
	arySpan.each(function(i){
		var obj=$(this);
		var file=obj.attr("file");
		var aryFile=file.split(",");
		var obj={id:aryFile[0],name:aryFile[1],path:aryFile[2]};
		aryJson.push(obj);
	});
	return aryJson;
};

