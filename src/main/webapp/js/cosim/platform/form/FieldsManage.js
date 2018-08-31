/**
 * 字段管理。
 * @returns {FieldsManage}
 */
FieldsManage=function(){
	{
		this.Fields=[];
	}
	
	/**
	 * 设置字段
	 */
	this.setFields=function(aryFields){
		this.Fields=aryFields;
	};
		
	/**
	 * 添加字段。
	 */
	this.addField=function(field){
		var rtn=this.isFieldExist(field.fieldName);
		if(rtn) return ;
		this.Fields.push(field);
	};
	
	
	this.delField=function(fieldName){
		for(var i=this.Fields.length-1;i>=0;i--){
			var field=this.Fields[i];
			if(field.fieldName.toLowerCase()==fieldName.toLowerCase()){
				this.Fields.splice(i, 1);
			}
		}
	};
	
	/**
	 * 更新字段。
	 */
	this.updField=function(field){
		for(var i=this.Fields.length-1;i>=0;i--){
			var tmp=this.Fields[i];
			if(tmp.fieldName.toLowerCase()==field.fieldName.toLowerCase()){
				var defaults=this.Fields[i];
				field= $.extend({}, defaults, field);
				this.Fields[i]=field;
			}
		}
	};
	
	/**
	 * 替换列字段。
	 * oldFieldName:原来字段名称。
	 * 代替的字段对象。
	 */
	this.replaceByFieldName=function(oldFieldName,field){
		for(var i=0;i<this.Fields.length;i++){
			var tmpField=this.Fields[i];
			if(tmpField.fieldName.toLowerCase()==oldFieldName.toLowerCase()){
				var defaults=this.Fields[i];
				field= $.extend({}, defaults, field);
				this.Fields[i]=field;
			};
		};
	};
	
	/**
	 * 判断字段是否存在。
	 */
	this.isFieldExist=function(name){
		for(var i=0;i<this.Fields.length;i++){
			var field=this.Fields[i];
			var fieldName=field.fieldName.toLowerCase();
			name=name.toLowerCase();
			//判断选择控件。（用户，组织，岗位，角色)
			if(field.controlType==4 || field.controlType==5 || field.controlType==6 ||  field.controlType==7 ||  field.controlType==8){
				var fieldId=fieldName +"id";
				if(fieldName==name || fieldId==name){
					return true;
				}
			}
			else{
				if(fieldName==name){
					return true;
				}
			}
		}
		return false;
	};
	
	/**
	 * 将字段向上或向下移动。
	 */
	this.moveField=function(fieldName,isUp){
		//获取索引
		var idx=this.getFieldIndex(fieldName);
		
		if(idx==-1)
			return false;
		var next=0;
		var canMove=false;
		if(isUp){
			if(idx>0){
				next=idx-1;
				canMove=true;
			}
		}
		else{
			if(idx<this.Fields.length-1){
				next=idx+1;
				canMove=true;
			}
		}
		//交换位置。
		if(	canMove){
			var temp=this.Fields[idx];
			this.Fields[idx]=this.Fields[next];
			this.Fields[next]=temp;
		}
		return canMove;
	};
	/**
	 * 根据字段名获取索引。
	 */
	this.getFieldIndex=function(fieldName){
		for(var i=0;i<this.Fields.length;i++){
			var field=this.Fields[i];
			if(field.fieldName.toLowerCase()==fieldName.toLowerCase()){
				return i;
			}
		}
		return -1;
	};
	
	/**
	 * 根据字段名称取得字段。
	 */
	this.getFieldByName=function(fieldName){
		for(var i=0;i<this.Fields.length;i++){
			var field=this.Fields[i];
			if(field.fieldName.toLowerCase()==fieldName.toLowerCase()){
				return field;
			}
		}
		return null;
	};
	
	/**
	 * 根据索引取得字段。
	 */
	this.getFieldByIndex=function(idx){
		idx=parseInt(idx);
		if(idx>=0 && idx<this.Fields.length){
			return this.Fields[idx];
		}
		return null;
	};
	
	/**
	 * 取得复选框。
	 */
	this.getCheckBox=function(field,optionType){
		return "<input type='checkbox' name='"+optionType+"'  "+((field[optionType]==1)?"checked":"")+"/>";
	};
	
	/**
	 * 取得字段类型。
	 */
	this.getFieldType=function(field){
		var fieldType=field.fieldType;
		if(fieldType=="varchar"){
			fieldType=  fieldType + "(" + field.charLen +")";
		}
		else if(fieldType=="number"){
			var intLen=field.intLen;
			var decimalLen=field.decimalLen;
			if(decimalLen==0){
				fieldType=  fieldType + "(" + intLen +")";
			}
			else{
				fieldType=  fieldType + "(" + intLen +"," + decimalLen+")";
			}
			
		}
		return fieldType;
	};

	/**
	 * 获取html
	 */
	this.getHtml=function(){
		var sb=new StringBuffer();
		for(var i=0;i<this.Fields.length;i++){
			var clsName=(i%2==0)?"odd":"even";
			var field=this.Fields[i];
			var fieldType=this.getFieldType(field);
			//隐藏字段不显示
			if(field.isHidden==1) continue;
			var del=(field.isDeleted==0)?"":"√";
			sb.append("<tr fieldName='"+field.fieldName+"' class='");
			sb.append(clsName);
			sb.append("'>");
			sb.append("<td class='editField' name='fieldName'>"+field.fieldName+"</td>");
			sb.append("<td class='editField' name='fieldDesc'>"+field.fieldDesc+"</td>");
			sb.append("<td>"+fieldType+"</td>");
			sb.append("<td style='text-align:center;'>"+this.getCheckBox(field,"isRequired")  +"</td>");
			sb.append("<td style='text-align:center;'>"+this.getCheckBox(field,"isList")+"</td>");
			sb.append("<td style='text-align:center;'>"+this.getCheckBox(field,"isFlowVar") +"</td>");
			sb.append("<td style='text-align:center;'>"+this.getCheckBox(field,"isAllowMobile") +"</td>");
			sb.append("<td style='text-align:center;'>"+del+"</td>");
			sb.append("<td style='text-align:center;'>" +((field.isDeleted==0)?"<a href='#' name='editColumn'  >编辑</a>":"")+"</td>");
			sb.append("</tr>");
		}
		return sb.toString();
	};
	
};


var isEdited = false;

/**
 * 表的行操作
 */
if (typeof TableRow == 'undefined') {
	TableRow = {};
}

/**
 * 设置列管理对象。
 * @param fieldManage
 */
TableRow.setFieldManage=function(fieldManage){
	TableRow.fieldManage=fieldManage;
};

/**
 * 设置字段名是否允许编辑
 * @param allowEditColName
 */
TableRow.setAllowEditColName=function(allowEditColName){
	TableRow.allowEditColName=allowEditColName;
};

/**
 * 删除行
 */
TableRow.del=function(){
	var objTr=$("#tableColumnItem>tbody .over");
	if(objTr.length==0) {
		$.ligerMessageBox.warn('提示信息',"还没有选中列!");
		return;
	};
	var fieldName=objTr.attr("fieldName");
	var field=TableRow.fieldManage.getFieldByName(fieldName);
	if(field.isRequired){
		$.ligerMessageBox.warn('提示信息',"该列为必填列,不能删除!");
		return;
	}
	TableRow.fieldManage.delField(fieldName);
	objTr.remove();
};

/**
 * 移动行
 */
TableRow.move=function(direct){
	var objTr=$("#tableColumnItem>tbody .over");
	if(objTr.length==0) return;
	var fieldName=objTr.attr("fieldName");
	var rtn=TableRow.fieldManage.moveField(fieldName,direct);
	if(!rtn) return;
	if(direct){
		var prevObj=objTr.prev();
		objTr.insertBefore(prevObj);
	}
	else{
		var nextObj=objTr.next();
		objTr.insertAfter(nextObj);
	}
};

/**
 * 添加列。
 */
TableRow.addColumn=function(isMain){
	ColumnDialog({isAdd:true,isMain:isMain,fieldManage:TableRow.fieldManage, callBack:function(field){
		isEdited = true;
		var rtn=TableRow.fieldManage.isFieldExist(field.fieldName);
		if(rtn) return false;
		TableRow.fieldManage.addField(field);
		$("#tableColumnItem>tbody").empty();
		$("#tableColumnItem>tbody").append($(TableRow.fieldManage.getHtml()));
		return true;
	}});
};

/**
 * 编辑字段
 */
TableRow.editField=function(fieldName,isMain){
	
	var tmpField=TableRow.fieldManage.getFieldByName(fieldName);
	if(tmpField==null) return;
	
	ColumnDialog({isAdd:false,isMain:isMain,allowEditColName:TableRow.allowEditColName, fieldManage:TableRow.fieldManage,field:tmpField,callBack:function(field){

		if(TableRow.fieldManage.isFieldExist(field.fieldName)){
			TableRow.fieldManage.updField(field);
		}
		else{
			TableRow.fieldManage.replaceByFieldName(fieldName,field);
		}
		$("#tableColumnItem>tbody").empty();
		
		$("#tableColumnItem>tbody").append($(TableRow.fieldManage.getHtml()));
		
		if(tableId!=0){
			isEdited = true;
			$("#tableColumnItem>tbody>tr:[fieldname="+field.fieldName+"]").attr('style','background-color:#FF8888;');
		}
		
		return true;
	}});
};

/**
 * 编辑列名及注释
 */
TableRow.editNameComment=function(tdObj){
	var trObj=tdObj.parent();
	var idx=$("#tableColumnItem>tbody>tr").index(trObj);
	
	var field=TableRow.fieldManage.getFieldByIndex(idx);
	var fieldName=tdObj.attr("name");
	//字段名称不允许编辑
	if(!TableRow.allowEditColName){
		 //field.fieldId为undefined表示新添加的字段，否则为原来的字段。
		 if(fieldName=="fieldName" )
			 return ;
	}
	var hasInput=tdObj.has("input").length==1;
	if(!hasInput){
		var txtObj=$("<input type='text' class='inputText' maxlength='20' size='20' value='"+tdObj.text()+"' />");
		txtObj.blur(function(){
			var tmpObj=$(this);
			var val=tmpObj.val();
			tmpObj.parent().text(val);
			tmpObj.remove();
			field[fieldName]=val;
			if(tableId!=0){
				isEdited = true;
				$("#tableColumnItem>tbody>tr:[fieldname="+field.fieldName+"]").attr('style','background-color:#FF8888;');
			}
		});
		tdObj.empty();
		tdObj.append(txtObj);
		txtObj.focus();
	}
};

/**
 * 编辑字段的选项。
 */
TableRow.editFieldOption=function (chkObj){
	var fieldName=chkObj.attr("name");
	var checked=chkObj.attr("checked");
	var trObj=chkObj.parents("tr");
	var idx=$("#tableColumnItem>tbody>tr").index(trObj);
	var field=TableRow.fieldManage.getFieldByIndex(idx);
	field[fieldName]=(checked!=undefined)?1:0;	
};
