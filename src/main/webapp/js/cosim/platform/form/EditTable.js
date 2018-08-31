/**
 * 下拉选项模版。
 */
var optiontemplate = '<option value="#value">#text</option>';

/**
 * 字段类型数据
 */
var varchar_="varchar";
var clob_="clob";
var date_="date";
var number_="number";


/**
 * 控件类型。
 */
var controlList = [ {key : '1',value : '单行文本框'}, {key : '2',value : '多行文本框'},
                    {key : '10',value : '富文本框'}, {key : '3',value : '数据字典'}, 
                    {key : '4',value : '人员选择器(单选)'}, {key : '8',value : '人员选择器(多选)'}, 
                    {key : '5',value : '角色选择器'}, {key : '6',value : '组织选择器'}, 
                    {key : '7',value : '岗位选择器'}, {key : '9',value : '文件上传'},
                    {key : '11',value : '下拉选项'},{key : '13',value : '复选框'},
                    {key : '14',value : '单选按钮'} ,{key : '12',value : 'Office控件'},
                    {key : '15',value : '日期控件'}];
/**
 * 值来源。
 */
var varFromList=[{key:0,value:'表单输入'},{key:1,value:'脚本运算(显示)'},
                 {key:2,value:'脚本运算(不显示)'},{key:3,value:'流水号'}];


/**
 * 判断字段名唯一
 */
jQuery.validator.addMethod("uniqueName", function(value, element) {
	var rtn=TableRow.fieldManage.isFieldExist(value);
	return !rtn;
}, "字段已存在");

jQuery.validator.addMethod("word", function(value, element) {
	return /^[a-zA-Z_]*$/gi.test(value);
}, "只能为字母和下划线");

/**
 * 数据表验证器。
 * @returns
 */
function validTable(){
	var __valid__=$("#bpmTableForm").validate({
		rules: {
			name:{
				required:true,
				maxlength:20,
				word:true
			},
			comment:{
				maxlength:50
			}
		},
		messages: {
			name:{
				required:"表名必填",
				maxlength:"表名最多 20 个字符."
			},
			comment:{
				maxlength:"注释 50字符."
			}
		}
	});
	return __valid__;
}


/**
 * 验证字段填写是否正确。
 * @returns
 */
function validateField(){
	var __valid__ = $('#frmFields').validate({
		rules : {
			fieldName : {
				required : true,
				uniqueName : __isFieldAdd__,
				word: true
			},
			charLen : {
				required : true,
				digits : true
				
			},
			intLen : {
				required : true,
				digits : true
				
			},
			decimalLen : {
				required : true,
				digits : true
			}
		},
		messages : {
			fieldName : {
				required : "字段名称必填"
			},
			charLen : {
				required : "文字长度必填",
				digits:"填写数字"
			},
			intLen : {
				required : "整数长度必填",
				digits:"填写数字"
			},
			decimalLen : {
				required : "小数长度必填",
				digits:"填写数字"
			}
		}
	});
	return __valid__;

}


/**
 * 初始点击主表，子表选项按钮。
 */
function handIsMain(){
	$("input[name='isMain']").click(function(){
		var curIsMain = $(this).val();
		var objTr=$("#spanMainTable");
		(curIsMain==1)?objTr.hide():objTr.show();
	});
}



/**
 * 处理值表单数据来源的change事件。
 */
function handValueFrom(){
	$("#valueFrom").change(function(){
		var val=parseInt( $(this).val());
		switch(val){
			//表单输入
			case 0:
				$("#trIdentity,#trScript,#trDict").hide();
				$("#trControlType,#trRule").show();
				break;
			//脚本运算(显示),
			case 1:
			//脚本运算(不显示)
			case 2:
				$("#trIdentity,#trDict,#trRule,#trControlType").hide();
				$("#trScript").show();
				break;
			//流水号
			case 3:
				$("#trRule,#trScript,#trDict,#trControlType").hide();
				$("#trIdentity").show();
				break;
		}
	});
}


/**
 * 处理字段类型fieldType的change事件。
 */
function handFieldType(){
	$("#fieldType").change(function(){
		var val=$(this).val();
		if(val==varchar_ || val==clob_ ||  val==number_){
			$("#trControlType").show();
		}
		//处理条件。
		handCondition();
		//处理数据长度
		if(val==varchar_){
			$("#spanCharLen").show();
			$("#spanIntLen,#spanDecimalLen,#spanDateFormat").hide();
			var controlType=$("#controlType").val();
			//下拉框，复选框，单选按钮
			if(controlType=="11" || controlType=="13" || controlType=="14"){
				$("#trOption").show();
			}
			else{
				$("#trOption").hide();
			}
		}else if(val==number_){
			$("#spanCharLen,#trOption,#spanDateFormat").hide();
			$("#spanDecimalLen,#spanIntLen").show();
		}else if(val==date_){
			$("#spanCharLen,#spanIntLen,#spanDecimalLen,#trOption").hide();
			$("#spanDateFormat").show();
		}
		else{
			$("#spanCharLen,#spanIntLen,#spanDecimalLen,#trOption,#spanDateFormat").hide();
		}
		//验证规则
		if(val ==varchar_ || val==clob_){
			$("#trRule").show();
		}
		else{
			$("#trRule").hide();
		}
		
		//设置值来源
		setValueFromByFieldType(val);
		//设置控件类型
		setControlByType(val);
		//脚本隐藏
		$("#trScript").hide();
		//处理条件
		
	});
}
/**
 * 处理复选框【isQuery】点击事件。
 */
function handConditionClick(){
	var obj=$("#isQuery");
	obj.click(handCondition);
}

/**
 * 处理条件选择。
 */
function handCondition(){
	var obj=$("#isQuery");
	var isChecked=obj.attr("checked")=="checked";
	if(isChecked){
		var selObj=$("#selCondition");
		var fieldType=$("#fieldType").val();
		initCondition(selObj,fieldType);
		if(fieldType!==clob_){
			$("#trCondition").show();
		}
		else{
			$("#trCondition").hide();
			obj.removeAttr("checked");
		}
		
	}
	else{
		$("#trCondition").hide();
	}
}


function changeCharLen(len){
	var val=$("#charLen").val();
	if(val==50){
		$("#charLen").val(len);
	}
}

/**
 * 处理控件类型修改事件。
 */
function handControlType(){	
	//控件类型修改
	$("#controlType").change(function(){
		var val=parseInt($(this).val());
		$("#formUserTr").hide();
		$("#showCurUserTr").hide();
		$("#showCurOrgTr").hide();
		$("#trDict").hide();
		$("#trOption").hide();
		$("#spanDateFormat").hide();
		switch(val){
			//数据字典
			case 3:
				$("#trDict").show();
				$("#trOption").hide();
				break;
			//人员选择器
			case 4:
				$("#showCurUserTr").show();
			case 8:
				$("#formUserSpan").text('所选人员作为下一节点执行人');
				$("#formUserTr").show();
				break;
			//部门选择器
			case 6:
				$("#formUserSpan").text('所选部门负责人作为下一节点执行人');
				$("#formUserTr").show();
				$("#showCurOrgTr").show();
				break;
			//如果选择文件上传控件，将字符宽度默认修改为2000个字符。
			case 9:
				changeCharLen(2000);
				break;
			//下拉选项,单选框，复选框
			case 11:
			case 13:
			case 14:
				$("#trOption").show();
				$("#trDict").hide();
				break;
			//日期控件
			case 15:
				$("#spanDateFormat").show();
				changeCharLen(20);
				break;			
		}
	});
}

/**
 * 根据字段类型设置控件类型。
 * @param fieldType
 */
function setControlByType(fieldType){
	var objSelect=$('#controlType');
	objSelect.empty();
	$(controlList).each(function(i, d) {
		var option = optiontemplate.replaceAll('#value', d.key).replace('#text', d.value);
		//文本类型
		if(fieldType==varchar_){
			if(d.key!="10" )
				objSelect.append(option);
		}else if(fieldType==clob_){
			//富文本框和文件类型
			if(d.key=="2" || d.key=="10"  )
				objSelect.append(option);
		}else if(fieldType==date_ ){
			if(d.key=="1" )
				objSelect.append(option);
		}
		else if(fieldType==number_){
			if(d.key=="1" ){
				objSelect.append(option);
			}
		}
	});
}

/**
 * 设置字段来源。
 * @param fieldType
 */
function setValueFromByFieldType(fieldType){
	var objSelect=$('#valueFrom');
	objSelect.empty();
	$(varFromList).each(function(i, d) {
		var key=d.key;
		var option = optiontemplate.replaceAll('#value', key).replace('#text', d.value);
	
		//文本
		if(fieldType==varchar_){
			objSelect.append(option);
		}
		//数字
		else if(fieldType==number_){
			if(key!=3){
				objSelect.append(option);
			}
		}
		//大文本
		else if(fieldType==clob_){
			if(key==0){
				objSelect.append(option);
			}
		}
		//日期
		else{
			if(key!=3){
				objSelect.append(option);
			}
		}
	});
	
}

/**
 * 添加列时初始化窗体的界面。
 * 设置数据。
 */
function initAdd(){
	$("#spanIntLen,#spanDecimalLen,#spanDecimalLen,#trDict,#trScript,#trIdentity,#trOption,#spanDateFormat,#trCondition").hide();
	setControlByType("varchar");
	//动态加载数据字典。
	JsLoader.LoadCount=1;
	JsLoader.Load(__ctx +"/js/lg/plugins/htCatCombo.js","javascript1");
}

/**
 * 重置字段。
 */
function resetField(){
	$("#spanIntLen,#spanDecimalLen,#spanDecimalLen,#trDict,#trScript,#trIdentity,#trOption,#spanDateFormat,#trCondition").hide();
	setControlByType("varchar");
	$("#fieldName,#fieldDesc").val("");
	$("#isRequired,#isList,#isQuery,#isFlowVar").attr("checked",false);
	$("#fieldType").val("varchar").change();
	$("#charLen").val(50);
	$("#intLen").val(13);
	$("#decimalLen").val(0);
	$("#options").val("");//
	//重置验证规则
	$("#validRule").get(0).selectedIndex=0;
	InitMirror.editor.setCode("");
}

/**
 * 设置字段的长度。
 */
function setFieldLengthByFieldValue(filed){
	if(filed.fieldType==varchar_){
		var charLen=parseInt( $("#charLen").val());
		filed.charLen=charLen;
	}
	else if(filed.fieldType==number_){
		var intLen=parseInt($("#intLen").val());
		var decimalLen=parseInt($("#decimalLen").val());
		filed.intLen=intLen;
		filed.decimalLen=decimalLen;
	}
}
/**
 * 根据值来源设置相应的字段。
 * @param field
 */
function setFieldByValueFrom(field){
	
	var from=parseInt( field.valueFrom);
	
	switch(from){
		//表单
		case 0:
			break;
		//1,2脚本
		case 1:
		case 2:
			field.script=$("#script").val();
			break;
		//流水号
		case 3:
			field.identity=$("#identity").val();
			break;
	}
}



/**
 * 根据字段信息设置控件长度。
 * @param field
 */
function setFieldLengthByField(field){
	var fieldType=field.fieldType;
	switch(fieldType){
		case varchar_:
			$("#charLen").val(field.charLen);
			$("#spanCharLen").show();
			$("#spanIntLen,#spanDecimalLen").hide();
			break;
		case number_:
			$("#intLen").val(field.intLen);
			$("#decimalLen").val(field.decimalLen);
			$("#spanCharLen").hide();
			$("#spanIntLen,#spanDecimalLen").show();
			break;
		default:
			$("#spanCharLen,#spanIntLen,#spanDecimalLen").hide();
			break;
	}
	
}


/**
 * 根据数据来源，设置相关控件的状态。
 * @param field
 */
function setValueFromByField(field){
	$("#valueFrom").val(field.valueFrom);
	var from=parseInt(field.valueFrom);
	switch(from){
		//表单输入
		case 0:
			$("#trScript,#trIdentity").hide();
			break;
		//脚本输入
		case 1:
		case 2:
			$("#trScript").show();
			$("#trIdentity").hide();
			$("#script").val(field.script);
			break;
		//流水号
		case 3:
			$("#trScript").hide();
			$("#trIdentity").show();
			$("#identity").val(field.identity);
			break;
	}
}

/**
 * 设置验证规则
 * @param field
 */
function setValidRuleByField(field){
	var validRule=field.validRule;
	
	if(field.fieldType==varchar_ || field.fieldType==clob_){
		$("#trRule").show();
		$("#validRule").val(validRule);
	}
	else{
		$("#trRule").hide();
	}
}

/**
 * 设置字段的验证规则。
 * @param field
 */
function setFieldByValidRule(field){
	if(field.fieldType==varchar_ || field.fieldType==clob_){
		field.validRule=$("#validRule").val();
	}
}


/**
 * 从页面控件获取字段数据对象。
 * @returns 
 */
function getField(){
	var field={charLen:0,intLen:0,decimalLen:0,dictType:'',identity:'',validRule : '',isDeleted:0,
	valueFrom : 0,script:'',controlType : 1};
	field.fieldName=$("#fieldName").val();
	field.fieldDesc=$("#fieldDesc").val();
	field.fieldType=$("#fieldType").val();
	
	field.controlType=$("#controlType").val();
	//设置数据字典
	//3：数据字典
	if(field.controlType==3){
		field.dictType=$("#dictType").val();
	}
	
	
	//控件类型为下拉框。
	//11,下拉选项
	//13,复选框
	//14,单选按钮
	if(field.controlType==11 || field.controlType==13 || field.controlType==14){
		field.options=$("#options").val().trim();
	}
	//设置日期格式
	//数据类型为日期的时候，需要设置日期格式。
	//15,日期控件
	if(field.controlType==15 || field.fieldType==date_){
		var isCurrentDate=$("#isCurrentDate").attr("checked");
		var format=$("#selDateFormat").val().trim();
		var json;
		if(isCurrentDate!=undefined){
			json={"format":format,"displayDate":1};
		}
		else{
			json={"format":format,"displayDate":0};
		}
		field.ctlProperty=JSON.stringify(json)  ;
	}
	if(field.controlType==4 || field.controlType==6 || field.controlType==8){
		var isformuser=$("#ifFormUser:checked").val()? 1:0;
		json={"isformuser":isformuser};
		field.ctlProperty=JSON.stringify(json);
	}
	
	// 显示当前用户
	if(field.controlType==4){
		var showCurUser=$("#showCurUser:checked").val()? 1:0;
		json={"showCurUser":showCurUser};
		field.ctlProperty=JSON.stringify(json);
	}
	
	// 显示当前组织
	if(field.controlType==6){
		var showCurOrg=$("#showCurOrg:checked").val()? 1:0;
		json={"showCurOrg":showCurOrg};
		field.ctlProperty=JSON.stringify(json);
	}
	
	//选项
	field.isRequired=$("#isRequired").attr("checked")?1:0;
	field.isList=$("#isList").attr("checked")?1:0;
	field.isQuery=$("#isQuery").attr("checked")?1:0;
	field.isFlowVar=$("#isFlowVar").attr("checked")?1:0;
	field.isAllowMobile=$('#isAllowMobile').attr('checked')?1:0;
	//设置字段长度
	setFieldLengthByFieldValue(field);
	//值来源
	field.valueFrom =$("#valueFrom").val();
	//根据来源设置对应的属性值。
	setFieldByValueFrom(field);
	//设置验证规则
	setFieldByValidRule(field);
	//设置条件
	setCondition(field);
	
	return field;
}

function setCondition(field){
	if(field.isQuery==0){
		return;
	}
	var condition=$("#selCondition").val();
	var condValFrom=$("#selValueFrom").val();
	var condValue=$("#selValInput").val();
	if(field.ctlProperty!=null && field.ctlProperty!=""){
		var json=jQuery.parseJSON(field.ctlProperty);
		json.condition=condition;
		json.condValFrom=condValFrom;
		json.condValue=condValue;
		field.ctlProperty=JSON.stringify(json) ;
	}
	else{
		var json={
				condition:condition,
				condValFrom:condValFrom,
				condValue:condValue
		};
		field.ctlProperty=JSON.stringify(json);
	}
}

/**
 * 根据字段设置页面控件状态。
 */
function initControlByField(field,allowEditColName){
	
	$("#fieldName").val(field.fieldName);
	$("#fieldDesc").val(field.fieldDesc);
	$("#fieldType").val(field.fieldType);
	//设置控件类型
	setControlByType(field.fieldType);
	//选择控件类型
	$("#controlType").val(field.controlType);
	
	//显示字典类型。
	if(field.dictType!=null && field.dictType!=""){
		$("#trDict").show();
		$("#dictTypeName").attr("catValue",field.dictType);
	}
	else{
		$("#trDict").hide();
	}
	
	 
	//设置字段选项。
	$("#isRequired").attr("checked",field.isRequired==1);
	$("#isList").attr("checked",field.isList==1);
	$("#isQuery").attr("checked",field.isQuery==1);
	$("#isFlowVar").attr("checked",field.isFlowVar==1);
	
	//设置值来源
	setValueFromByField(field);
	
	//设置数据长度
	setFieldLengthByField(field);
	//验证规则
	setValidRuleByField(field);
	//控件类型为下拉框选项，单选框，复选框
	if(field.controlType==11 || field.controlType==13 || field.controlType==14){
		$("#options").val(field.options);
		$("#trOption").show();
	}
	else{
		$("#trOption").hide();
	}
	//日期类型
	if(field.fieldType==date_ || field.controlType==15){
		$("#spanDateFormat").show();
		try{
			var property=eval("(" + field.ctlProperty +")");
			$("#selDateFormat").val(property.format);
			if(property.displayDate==1){
				$("#isCurrentDate").attr("checked","checked");
			}
		}
		catch(e){
		}
	}
	//人员选择器
	if(field.controlType==4 || field.controlType==8){
		$("#formUserSpan").text('所选人员作为下一节点执行人');
		$("#formUserTr").show();
		try{
			var property=eval("(" + field.ctlProperty +")");
			if(property.isformuser)				
				$("#ifFormUser").attr("checked","checked");
		}
		catch(e){
		}
	}
	
	if(field.controlType==4){
		$("#showCurUserTr").show();
		try{
			var property=eval("(" + field.ctlProperty +")");
			if(property.showCurUser)				
				$("#showCurUser").attr("checked","checked");
		}
		catch(e){
		}
	}
	
	//部门选择器
	if(field.controlType==6){
		$("#formUserSpan").text('所选部门负责人作为下一节点执行人');
		$("#formUserTr").show();
		try{
			var property=eval("(" + field.ctlProperty +")");
			if(property.isformuser)				
				$("#ifFormUser").attr("checked","checked");
		}
		catch(e){
		}
		
		
		$("#showCurOrgTr").show();
		try{
			var property=eval("(" + field.ctlProperty +")");
			if(property.showCurOrg)
				$("#showCurOrg").attr("checked","checked");
		}
		catch(e){
		}
		
	}
	else{
		$("#spanDateFormat").hide();
	}
	//设置条件字段
	bindCondition(field);
	
	//修改控件是否允许编辑字段的名字和数据类型。
	setEditStatus(allowEditColName);
	//渲染数据字典。
	JsLoader.LoadCount=1;
	JsLoader.Load(__ctx + "/js/lg/plugins/htCatCombo.js","javascript1");
}

/**
 * 设置控件状态，是否允许编辑。
 * @param allowEditColName
 */
function setEditStatus(allowEditColName){
	if(allowEditColName) return;
	$("#fieldName").attr('disabled', 'disabled');
	$("#charLen").attr('disabled', 'disabled');
	$("#intLen").attr('disabled', 'disabled');
	$("#decimalLen").attr('disabled', 'disabled');
	$("#fieldType").attr('disabled', 'disabled');
}

/**
 * 绑定表和字段数据。
 * @param table
 */
function bindTable(data,allowEditTbColName){
	
	var table=data.bpmFormTable;
	
	$("#name").val(table.tableName);
	//禁止编辑
	if(!allowEditTbColName){
		$("#name").attr('disabled', 'disabled');
		$(":radio[name='isMain']").attr('disabled', 'disabled');
		$("#mainTable").attr('disabled', 'disabled');
	}
	
	$("#comment").val(table.tableDesc);
	$(":radio[name='isMain'][value="+table.isMain+"]").attr("checked","checked");
	//赋给下拉框，这个下拉框只包含未生成的主表列表。
	$("#mainTable").val(table.mainTableId);
	//将主表id赋给隐藏表单。
	$("#mainTableId").val(table.mainTableId);
	
	
	var fieldList=data.fieldList;
	TableRow.fieldManage.setFields(fieldList);
	$("#tableColumnItem>tbody").append(TableRow.fieldManage.getHtml());
}


/**
 * 绑定字段。
 * @param table
 */
function bindExtTable(data){
	var table=data.table;
	$("#name").val(table.tableName);
	//禁止编辑
	$("#name").attr('disabled', 'disabled');
	$("#comment").val(table.tableDesc);
	var fieldList=data.fieldList;
	TableRow.setAllowEditColName(false);
	TableRow.fieldManage.setFields(fieldList);
	$("#tableColumnItem>tbody").append(TableRow.fieldManage.getHtml());
	//绑定主键字段下拉框
	bindPkField(fieldList,"");
	//绑定流水号下拉框
	bindIdentity(data.identityList,"");
}

/**
 * 绑定主键字段下拉框。
 * @param fieldList
 * @param defautValue
 */
function bindPkField(fieldList,defautValue){
	var obj=$("#pkField");
	for(var i=0;i<fieldList.length;i++){
		var field=fieldList[i];
		var option = optiontemplate.replaceAll('#value', field.fieldName).replace('#text', field.fieldDesc);
		obj.append(option);
	}
	if(defautValue!=undefined && defautValue==null && defautValue!=""){
		obj.val(defautValue);
	}
}

/**
 * 绑定流水号下拉框。
 * @param identityList
 * @param defautValue
 */
function bindIdentity(identityList,defautValue){
	var obj=$("#keyValue");
	for(var i=0;i<identityList.length;i++){
		var d=identityList[i];
		var option = optiontemplate.replaceAll('#value', d.alias).replace('#text', d.name);
		obj.append(option);
	}
	if(defautValue!=undefined && defautValue==null && defautValue!=""){
		obj.val(defautValue);
	}
}

/**
 * 绑定字段条件式。
 * @param dbType
 * @param defaultValue
 */
function bindCondition(field){
	if(field.isQuery==0) {
		$("#trCondition").hide();
		return;
	}
	$("#trCondition").show();
	var fieldType=field.fieldType;
	var prop=field.ctlProperty;
	var jsonObj=null;
	if(prop!=null && prop!=undefined && prop!=""){
		try{
			jsonObj=eval("(" + prop +")");
		}
		catch(e){
			jsonObj=null;
		}
	}

	var obj=$("#selCondition");
	initCondition(obj,fieldType);
	var valFrom=$('#selValueFrom');
	var value=$('#selValue');
	if(jsonObj!=null){
		var condition=jsonObj.condition;
		var condValFrom=jsonObj.condValFrom;
		var condValue=jsonObj.condValue;
		
		obj.val(condition);
		valFrom.val(condValFrom);
		initSelValueFrom(value,condValFrom);
		if(condValFrom==2||condValFrom==3){
			$('#selValInput').val(condValue);
		}else if(condValFrom==1){
			$('#selValInput').html(condValue);
		}
	}
	else{
		initSelValueFrom(value,-1);
	}
}

/**
 * 在条件下拉框添加字段。
 * @param selObj
 * @param fieldType
 */
function initCondition(selObj,fieldType){
	//在下拉框中设置字段数据类型
	var type=selObj.attr("fieldType");
	if(fieldType==type){
		return;
	}
	selObj.attr("fieldType",fieldType);
	selObj.empty(); 
	switch(fieldType){
		case "varchar":
			selObj.append("<option value='='>等于</option>");
			selObj.append("<option value='like'>LIKE</option>");
			selObj.append("<option value='likeEnd'>LIKEEND</option>");
			break;
		case "number":
			selObj.append("<option value='='>等于</option>");
			selObj.append("<option value='>='>大于等于</option>");
			selObj.append("<option value='>'>大于</option>");
			selObj.append("<option value='<'>小于</option>");
			selObj.append("<option value='<='>小于等于</option>");
			break;
		case "date":
			selObj.append("<option value='='>等于</option>");
			selObj.append("<option value='between'>日期之间</option>");
			break;	
	}
}


function initSelValueFrom(selObj,val){
	switch(val){
		case "1":
			var html="<span id='selValInput'>表单输入</span>";
			selObj.html(html);
			break;
		case "2":
			var html="<textarea id='selValInput' cols='40' rows='3'></textarea>";
			selObj.html(html);
			break;
		case "3":
			var html = "<a href='#' class='link var' title='常用脚本' onclick='selSelectScript(this)'>常用脚本</a></br>";
			html+="<textarea  id='selValInput' cols='40' rows='3'></textarea>"; 
			selObj.html(html);
			break;
		default:
			var html="";
			selObj.html(html);
	}
}

function changeSelValFrom(obj){
	var val=$(obj).val();
	var selVal=$("#selValue");
	initSelValueFrom(selVal,val);
}

function selSelectScript(obj) {
	var txtObj=$('#selValInput');
	ScriptDialog({
		callback : function(script) {
			txtObj.val(script);
		}
	});
};
