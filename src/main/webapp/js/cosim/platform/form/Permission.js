/**
 * 表单权限。
 * @returns {Permission}
 */
Permission=function(){
	{
		this.FieldsPermission=[];
		this.SubTablePermission=[];
		this.Opinion=[];
	};
	/**
	 * 获取默认权限对象。
	 */
	this.getDefaultPermission=function(name,memo){
		var permission={"title":name,"memo":memo,"read": {"type":"everyone","id":"", "fullname":""},"write":{"type":"everyone","id":"", "fullname":""}};
		return permission;
	};
	
	
	/**
	 * 从数据库加载权限，并初始化html表格状态。
	 * 需要传入tableId，formDefId。
	 * 如果是新建表单，权限根据表获取。
	 * 如果是更新表单，权限从表单权限获取。
	 */
	this.loadPermission=function(tableId,formKey){
		var params={tableId:tableId,formKey:formKey};
		this.load("getPermissionByTableFormKey.ht", params);
	};
		
	/**
	 * 从数据库加载权限，并初始化html表格状态。
	 */
	this.loadByNode=function(actDefId, nodeId,formKey){
		var params={actDefId:actDefId,nodeId:nodeId,formKey:formKey};
		this.load("getPermissionByFormNode.ht", params);
	};
	
	this.load=function(url,params){
		
		var _self=this;
		$.ligerDialog.waitting("正在加载表单权限,请稍后...");
		$.post(url, params,function(data){
			$.ligerDialog.closeWaitting();
			var fields =data["field"];
			var tables =data["table"];
			var opinions =data["opinion"];
			
			//字段权限。
			if(fields!=undefined && fields!=''){
				_self.FieldsPermission=fields;
				var fieldHtml=_self.getPermission(_self.FieldsPermission,"field");
				$("#fieldPermission").empty();
				$("#fieldPermission").append(fieldHtml);
				_self.initStatus("fieldPermission");
			}
			
			//子表权限
			if(tables!=undefined && tables!=''){
				_self.SubTablePermission=tables;
				var tableHtml=_self.getPermission(_self.SubTablePermission,"subtable");
				$("#tablePermission").empty();
				$("#tablePermission").append(tableHtml);
				_self.initStatus("tablePermission");
			}else{
				$("#tablePermission").closest( 'table' ).hide();
			}
			
			//意见权限。
			if(opinions!=undefined && opinions!=''){
				_self.Opinion=opinions;
				var opinionHtml=_self.getPermission(_self.Opinion,"opinion");
				$("#opinionPermission").empty();
				$("#opinionPermission").append(opinionHtml);
				_self.initStatus("opinionPermission");
			}else{
				$("#opinionPermission").closest( 'table' ).hide();
			}

		});
		_self.handChange();
		_self.handClick();
	};
	
	/**
	 * 加载完权限表格后，修改控件的状态。
	 */
	this.initStatus=function(id){
		var _self=this;
		$("#" +id).children("tr").each(function(){
			var trObj=$(this);
			//取得下拉框
			var selReadObj=$("select.r_select",trObj);
			var selWriteObj=$("select.w_select",trObj);
			//值为user,everyone,none,role,orgMgr,pos等。
			//查看下拉框
			var rPermissonType=selReadObj.attr("permissonType");
			var wPermissonType=selWriteObj.attr("permissonType");
			
			//初始化下拉框选中。
			selReadObj.val(rPermissonType);
			selWriteObj.val(wPermissonType);
			
			//是否显示选中的人员或岗位等信息。
			var spanReadObj=$("span[name='r_span']",trObj);
			var spanWriteObj=$("span[name='w_span']",trObj);
			//初始化是否显示选择人员
			_self.showSpan(rPermissonType,spanReadObj);
			_self.showSpan(wPermissonType,spanWriteObj);
		});
	};
	
	/**
	 * 处理下拉框change事件。
	 */
	this.handChange=function(){
		var _self=this;
		$("#fieldPermission,#tablePermission,#opinionPermission").delegate("select.r_select,select.w_select","change",function(){
			var obj=$(this);
			var spanObj=obj.next();
			//当用户权限类型修改时，同时修改span的显示。
			_self.showSpan(obj.val(), spanObj);
			
			var trObj=obj.parents("tr");
			var tbodyObj=obj.parents("tbody");
			//read,write
			var mode=(obj.attr("class")=="r_select")?"read":"write";
			//获取行在表格中的索引
			var idx=tbodyObj.children().index(trObj);
			//权限类型（field,subtable,opinion)
			var permissionType=trObj.attr("type");
			var selType=obj.val();
			_self.changePermission(permissionType,idx,mode,selType,"","");
			var txtObj=$("input:text",spanObj);
			var idObj=$("input:hidden",spanObj);
			txtObj.val("");
			idObj.val("");
		});
	};
	
	/**
	 * 修改对应行的权限数据。
	 * permissionType:权限类型
	 * field:字段类型
	 * subtable:子表
	 * opinion:意见
	 * 
	 * idx:行数
	 * mode:read,write
	 * type:
	 * everyone,none,user,role,org,orgMgr,pos
	 */
	this.changePermission=function(permissionType,idx,mode,type,ids,names){
		if(idx==-1) return;
		var aryPermission=[];
		switch(permissionType){
			case "field":
				aryPermission=this.FieldsPermission;
				break;
			case "subtable":
				aryPermission=this.SubTablePermission;
				break;
			case "opinion":
				aryPermission=this.Opinion;
				break;
		}
		var objPermssion=aryPermission[idx];
		
		
		//alert(permissionType +"," + idx + "," + mode + "," + type +","+ ids);
		
		objPermssion[mode]["type"]=type;
		objPermssion[mode]["id"]=ids;
		objPermssion[mode]["fullname"]=names;
	};
	
	/**
	 * 处理选择人员，岗位，组织，角色点击事件。
	 */
	this.handClick=function(){
		var _self=this;
		$("#fieldPermission,#tablePermission,#opinionPermission").delegate("a.link-get","click",function(){
			var obj=$(this);
			
			var txtObj=obj.prev();
			var idObj=txtObj.prev();
			var selObj=obj.parent().prev();
			var selType=selObj.val();
			
			var callback = function(ids, names) {
				var trObj=obj.parents("tr");
				var tbodyObj=obj.parents("tbody");
				//read,write
				var mode=obj.attr("mode");
				var idx=tbodyObj.children().index(trObj);
				var permissionType=trObj.attr("type");
				
				_self.changePermission(permissionType,idx,mode,selType,ids,names);
				txtObj.val(names);
				idObj.val(ids);
			};
			
			switch(selType){
				case "user":
					UserDialog({callback : callback});
					break;
				case "role":
					RoleDialog({callback : callback});
					break;
				case "org":
				case "orgMgr":
					OrgDialog({callback : callback});
					break;
				case "pos":
					PosDialog({callback : callback});
					break;
			}
		});
	};
	
	/**
	 * 是否显示选择框
	 */
	this.showSpan=function(permissionType,spanObj){
		switch(permissionType){
			case "user":
			case "role":
			case "org":
			case "orgMgr":
			case "pos":
				spanObj.show();
				break;
			case "everyone":
			case "none":
				spanObj.hide();
				break;
		}
	};
	
	/**
	 * 根据权限集合和权限类型获取权限的html，代码。
	 */
	this.getPermission=function(aryPermission,type){
		var sb=new StringBuffer();
		
		for(var i=0;i<aryPermission.length;i++){
			var objPermission=aryPermission[i];
			var str=this.getHtml(objPermission, type);
			sb.append(str);
		}
		return sb.toString();
	};
	
	
	/**
	 * 根据权限对象和权限类型（字段，子表，意见）获取一行的显示。
	 */
	this.getHtml=function(permission,type){
		
		var aryTr = ['<tr type="#permissionType">'
			, '<td>#desc</td>'
			//只读
			,this.getHtmlTd('r','read')
			//编辑
			,this.getHtmlTd('w','write')
			, '</tr>'];
		
			permissionTr=aryTr.join("");
			var tmp=permissionTr.replaceAll('#name', permission.title)
			.replaceAll('#desc', permission.memo)
			.replaceAll('#r_type', permission.read.type)
			.replaceAll('#w_type', permission.write.type)
			.replaceAll('#R_ID', permission.read.id)
			.replaceAll('#W_ID', permission.write.id)
			.replaceAll('#R_FullName', permission.read.fullname)
			.replaceAll('#W_FullName', permission.write.fullname)
			.replaceAll('#permissionType', type);
			return tmp;
	};
	
	/**
	 *设置每行的显示
	 *@param v 权限简称
	 *@param full 权限全称
	 */
	this.getHtmlTd=function(v,full){
		var  uv = v.toUpperCase();
		var aryTd = ['<td>'
			, '<select class="',v,'_select"  permissonType="#',v,'_type" name="#name"  >'
			, '<option value="user">用户</option>'
			, '<option value="role">角色</option>'
			, '<option value="org">组织</option>'
			, '<option value="orgMgr">组织负责人</option>'
			, '<option value="pos">岗位</option>'
			, '<option value="everyone">所有人</option>'
			, '<option value="none">无</option>'
			, '</select>'
			, '<span name="',v,'_span">'
			, '<input  type="hidden"  value="#',uv,'_ID"/>'
			, '<input  type="text"  readonly value="#',uv,'_FullName"/>'
			, '<a href="#" class="link-get" mode="',full,'" ><span class="link-btn ">选择</span></a>'
			, '</span>'
			, '</td>'];
		return aryTd.join('');
	};
	
	/**
	 * 获取权限的json字符串。
	 */
	this.getPermissionJson=function(){
		var fieldJson={field:this.FieldsPermission,subtable:this.SubTablePermission,opinion:this.Opinion};
		var jsonStr=JSON.stringify(fieldJson);
		return jsonStr;
	};
	
	/**
	 * 添加权限。
	 */
	this.addPermission=function(name,memo,aryPermission){
		var rtn=this.isPermissionExist(name, aryPermission);
		if(!rtn)
		{
			var obj=this.getDefaultPermission(name, memo);
			aryPermission.push(obj);
			return true;
		}
		return false;
	};
	
	/**
	 * 判断权限在集合中已经存在。
	 */
	this.isPermissionExist=function(name,aryPermission){
		for(var i=0;i<aryPermission.length;i++){
			var obj=aryPermission[i];
			var tmp=obj.title.toLocaleLowerCase();
			name=name.toLocaleLowerCase();
			if(tmp==name){
				return true;
			}
		}
		return false;
	};
	
	/**
	 * 根据名称获取权限。
	 */
	this.getPermissionByName=function(name,aryPermission){
		for(var i=0;i<aryPermission.length;i++){
			var obj=aryPermission[i];
			var tmp=obj.title.toLocaleLowerCase();
			name=name.toLocaleLowerCase();
			if(tmp==name){
				return obj;
			}
		}
		return null;
	};
	
	/**
	 * 添加意见权限。
	 */
	this.addOpinion=function(formName,name){
		formName=formName.replace(/opinion:/g,'');
		var rtn=this.addPermission(formName,name, this.Opinion);
		//意见权限。
		var opinionHtml=this.getPermission(this.Opinion,"opinion");
		$("#opinionPermission").empty().append(opinionHtml);
		this.initStatus("opinionPermission");
		return rtn;
	};
	
	/**
	 * 替换意见权限。
	 * title:"",memo:""
	 */
	this.replaceOpinion=function(originName,curName,curMemo){
		var obj=this.getPermissionByName(originName,this.Opinion);
		obj["title"]=curName;
		obj["memo"]=curMemo;
		var opinionHtml=this.getPermission(this.Opinion,"opinion");
		$("#opinionPermission").empty().append(opinionHtml);
		this.initStatus("opinionPermission");
	};
	
	/**
	 * 同步意见列表
	 * arry意见列表
	 */
	this.syncOpinion=function(arry){
		if(arry.length==0){
			this.Opinion=[];
		}
		else{
			for(var i=0;i<this.Opinion.length;i++){
				var tmp=0,title=this.Opinion[i].title.toLocaleLowerCase();	
				for(var j=0;j<arry.length;j++){
					var name=$(arry[j]).attr("name").toLocaleLowerCase().replace(/opinion:/g,'');
					if(title!=name){					
						this.addOpinion(name,$(arry[j]).attr("opinionname"));
					}else{
						tmp=1;
						arry.splice(j, 1);
					}
				}
				if(tmp==0){
					this.Opinion.splice(i,1);
				}
			}
		}
		if(this.Opinion.length!=0){
			var opinionHtml=this.getPermission(this.Opinion,"opinion");
			$("#opinionPermission").empty().append(opinionHtml);
			$("#opinionPermission").closest('table').show();
			this.initStatus("opinionPermission");
		}
	};	
	/**
	 * 重新设置权限。
	 */
	this.setAllPermission=function(){
		this.readPermission("#fieldPermission",this.FieldsPermission);
		this.readPermission("#tablePermission",this.SubTablePermission);
		this.readPermission("#opinionPermission",this.Opinion);
	};
	//分段读取权限
	this.readPermission=function(scope,aryPermission){
		var objScope=$(scope);
		//var permission={"title":name,"memo":memo,"read": {"type":"everyone","id":"", "fullname":""},"write":{"type":"everyone","id":"", "fullname":""}};
		$("tr",objScope).each(function(index){
			var trObj=$(this);
			var memo=trObj.children().first().text();
			
			var rSelectObj=$(".r_select",trObj);
			var rSpanObj=$("[name=r_span]",trObj);
			var rId=$("input:hidden",rSpanObj).val();
			var rFullName=$("input:text",rSpanObj).val();
			
			var wSelectObj=$(".w_select",trObj);
			var wSpanObj=$("[name=w_span]",trObj);
			var wId=$("input:hidden",wSpanObj).val();
			var wFullName=$("input:text",wSpanObj).val();
			
			var fieldName=rSelectObj.attr("name");
			
			var permission={"title":fieldName,"memo":memo,
					"read": {"type": rSelectObj.val() ,"id":rId, "fullname":rFullName},
					"write":{"type":wSelectObj.val(),"id":wId, "fullname":wFullName}};
			
			aryPermission[index]=permission;
			
		});
	};
};