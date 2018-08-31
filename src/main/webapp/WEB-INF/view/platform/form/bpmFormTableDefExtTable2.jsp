<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>添加外部表定义</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/form.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/ColumnDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/EditTable.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/FieldsManage.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
	input.error {
	    border: 1px solid red;
	}
</style>
<script type="text/javascript">

	var dataSource="${dataSource}";
	var tableName="${tableName}";
	
	var validator;
	
	var fieldObj;
	
	var table=null;
	
	$(function(){
		fieldObj=new FieldsManage();
		
		TableRow.setFieldManage(fieldObj);
		
		TableRow.setAllowEditColName(false);
		
		
		$.get("getTableModel.ht",{dataSource:dataSource,tableName:tableName},function(data){
			bindExtTable(data);
			table=data.table;
		});
		
	
		//行高亮
		$("#tableColumnItem").delegate("tbody>tr", "click", function() {
			$("#tableColumnItem>tbody>tr").removeClass("over");
			$(this).addClass("over");
		});
		//编辑列的详细信息
		$("#tableColumnItem").delegate("tbody>tr a[name='editColumn']", "click", function() {
			var trObj=$(this).parent().parent();
			var idx=$("#tableColumnItem>tbody>tr").index(trObj);
			var field=fieldObj.getFieldByIndex(idx);
			TableRow.editField(field.fieldName);
		});
		//处理选项选择。
		$("#tableColumnItem").delegate("tbody>tr input:checkbox", "click", function() {
			var chkObj=$(this);
			TableRow.editFieldOption(chkObj);
		});
		//处理点击列名和列注释。
		$("#tableColumnItem").delegate("tbody>tr>td[class='editField']", "click", function() {
			var tdObj=$(this);
			TableRow.editNameComment(tdObj);
		});
		
		//字段上移动
		$("#moveupField").click(function(){
			TableRow.move(true);
		});
		//字段下移
		$("#movedownField").click(function(){
			TableRow.move(false);
		});
		
		$("#delField").click(function(){
			TableRow.del();
		});
		
		validator=validTable();
		//处理字段保存
		handSave();
		
	});
	
	/**
	 * 处理保存事件。
	 */
	function handSave(){
		$("#dataFormSave").click(function(){
			var rtn=validator.form();
			if(!rtn) return;
			
			var name=$("#name").val();
			var comment=$("#comment").val();
			var isMain=$("input:radio[name='isMain']:checked").val();
			var keyType=$('#keyType').val();
			var keyValue="";
			if(keyType==2) keyValue=$('#keyValue').val();
			var pkField=$('#pkField').val();
			
			var tableJson={tableName:name,tableDesc:comment,isMain:isMain,keyType:keyType,keyValue:keyValue,pkField:pkField,dsAlias:dataSource};
			table= $.extend({}, table, tableJson);
			var tableJson=JSON.stringify(table);
			var fieldJson=JSON.stringify(fieldObj.Fields);
			
			$.post("saveExtTable.ht",{table:tableJson,fields:fieldJson},showResponse);
		});
	}
	
	/**
	 * 显示返回结果。
	 */
	function showResponse(data){
		var obj=new com.cosim.form.ResultMessage(data);
		if(obj.isSuccess()){//成功
			$.ligerMessageBox.success('提示信息','添加外部表定义成功!',function(){
				var returnUrl=$("a.back").attr("href");
				location.href=returnUrl;
			});
	    }else{//失败
	    	$.ligerDialog.err('出错信息',"添加外部表定义失败",obj.getMessage());
	    }			
	}
	
	function changeKeyType(obj){
		var objTmp=$("#tdKeyValue");
		var display=(obj.value==2)?"":"none";
		objTmp.css("display",display);
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					添加外部表定义
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link save" id="dataFormSave" href="#">保存</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="defExtTable1.ht">返回</a></div>
				</div>
			</div>
		</div>
		<br>
		<form id="bpmTableForm" method="post" action="add2.ht">
			<div class="panel-detail">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="5%">表名: </th>
						<td width="15%">
							<input  type="text" id="name" name="name" maxlength='25' class="inputText"/>
							
						</td>
						<th width="5%">注释: </th>
						<td width="15%">
							<input  type="text" id="comment" name="comment"  class="inputText"/>
							
						</td>
						<th width="10%">是否主表: </th>
						<td>
							<input  type="radio"  name="isMain"  value="1" checked="checked"/>主表
							<input  type="radio"  name="isMain"  value="0" />从表
						</td>
						<td>
								主键:&nbsp;
								<select id="pkField" name="pkField" style="width:150px;">
								</select>
						</td>
						<td >
							
							主键规则:&nbsp;
							<select id="keyType" name="keyType" onchange="changeKeyType(this);">
								<option value="0">无</option>
								<option value="1">GUID</option>
								<option value="2">流水号</option>
								<option value="3">时间序列</option>
							</select>
							
						</td>
						<td style="display:none;" id="tdKeyValue">流水号:
							<select id="keyValue" name="keyValue">
							</select>
						</td>
					</tr>
				</table>
			</div>
			<br>
			<div class="panel-top">
				<div class="panel-toolbar">
					<div class="toolBar">
						<div class="group"><a id="moveupField" class="link moveu">上移</a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a id="movedownField" class="link movedown">下移</a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a id="delField" class="link del">删除</a></div>
					</div>	
				</div>
			</div>
			<div class="panel-body">
				<div class="panel-data">
					<table id="tableColumnItem" class="table-grid table-list" id="0" cellpadding="1" cellspacing="1">
			   		<thead>
			   			<th width="20%">列名</th>
			   			<th width="20%">注释</th>
			    		<th width="10%">类型</th>
			    		<th width="10%">必填</th>
			    		<th width="10%">显示到列表</th>
			    		<th width="10%">作为查询条件</th>
			    		<th width="10%">是否流程变量</th>
			    		<th width="10%">管理</th>
			    	</thead>
			    	<tbody>
			    		
			    	</tbody>
			   	 </table>
				</div>
			</div>
		</form>
	
</div>
</body>
</html>
