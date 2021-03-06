<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>复制表单</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/form.jsp"%>
<link rel="stylesheet" href="${ctx }/js/tree/v35/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerComboBox.js"></script>
<script type="text/javascript" src="${ctx }/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctx }/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="${ctx }/js/lg/plugins/htCatCombo.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
<script type="text/javascript">
	var valid;
	$(function(){
		valid=$("#formCopy").form();
	});
	
	function save() {
		var rtn = valid.valid();
		if (!rtn){
			return;			
		}
		var formDefId=$("#formDefId").val(),
			formName=$("#formName").val(),
			typeId=$("#categoryId").val(),
			formDesc=$("#formDesc").val();
		
		var url = "saveCopy.ht";
		var para = "formDefId=" + formDefId + "&formName=" + formName
				+ "&typeId=" + typeId+ "&formDesc=" + formDesc;
		$.post(url, para, function(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {//成功
				$.ligerMessageBox.success('提示信息', obj.getMessage(), function() {
					window.close();
				});
			} else {//失败
				$.ligerDialog.err('出错信息',"复制表单失败",obj.getMessage());
			}
		});
	}
</script>
<style type="text/css">
html {
	overflow-x: hidden;
}
</style>
</head>
<body>
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">复制表单</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group">
					<a class="link save" id="btnSearch" onclick="save()">保存</a>
				</div>
				<div class="l-bar-separator"></div>
				<div class="group">
					<a class="link del" onclick="javasrcipt:window.close()">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="formCopy" name="formCopy">
			<input id="formDefId" type="hidden" value="${bpmFormDef.formDefId }" />
			<table class="table-detail" cellpadding="0" cellspacing="0"
				border="0">
				<tr>
					<th width="15%">原表单名称:</th>
					<td><input type="text" class="inputText" disabled="disabled" value="${bpmFormDef.subject}" /></td>
					<th width="15%">新表单名称:</th>
					<td><input type="text" id="formName" name="formName" validate="{required:true}" class="inputText" /></td>
				</tr>
				<tr>
					<th width="15%">原表单类型:</th>
					<td><input type="text" class="inputText" disabled="disabled" value="${bpmFormDef.categoryName}" /></td>
					<th width="15%">新表单类型:</th>
					<td><input class="catComBo" catKey="FORM_TYPE" valueField="categoryId" catValue="${categoryId}" id="typeId" name="typeId" height="200" width="137" /></td>
				</tr>
				<tr>
					<th width="15%">原表单描述:</th>
					<td><input type="text" class="inputText" disabled="disabled" value="${bpmFormDef.formDesc}" /></td>
					<th width="15%">新表单描述:</th>
					<td><input type="text" id="formDesc" validate="{required:true}" name="formDesc" class="inputText" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
