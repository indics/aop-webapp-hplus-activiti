<%--
	time:2011-11-28 11:31:14
	desc:edit the 系统表单模板
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>复制模板</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript">
		var obj=window.dialogArguments;
		var valid;
		$(function(){
			$("#templateName").val(obj.templateName);
			$("#alias").val(obj.alias);
			valid=$("#formCopy").form();
		});
		function save(){
			var rtn = valid.valid();
			if (!rtn){
				return;			
			}
			
			var templateId=obj.templateId;
			var newTemplateName=$("#newTemplateName").val();
			var oldTemplateName=$("#templateName").val();
			var alias=$("#alias").val();
			var newAlias=$("#newAlias").val();
			
			var url="copyTemplate.ht";
			var para="templateId="+templateId+"&newTemplateName="+newTemplateName+"&newAlias="+newAlias;
			
			if(newTemplateName==""||newAlias==""){
				//window.close();
			}else{
				if(newTemplateName==oldTemplateName){
					$.ligerMessageBox.error('提示信息','模板名不能同名！');
			    }else{
				    $.post(url,para,function(data){
				    	var obj=new com.cosim.form.ResultMessage(data);
			    		if(obj.isSuccess()){
						    $.ligerMessageBox.success("提示信息",obj.getMessage(),function(){
							    window.close();
				    		});
			    		}else{
			    			$.ligerDialog.err('出错信息',"复制模板失败",obj.getMessage());
			    		}
				    });
			}
		  }
		}
	</script>
	<style>
		html { overflow-x: hidden; }
	</style>
</head>
<body>
<div class="panel">
  <div class="panel-top">
    <div class="tbar-title">
	    <span class="tbar-label">复制模板</span>
	</div>
	<div class="panel-toolbar">
			<div class="toolBar">
			<div class="group"><a class="link save" id="btnSearch" onclick="save()">保存</a></div>
			<div class="l-bar-separator"></div>
			<div class="group"><a class="link del" onclick="javasrcipt:window.close()">关闭</a></div>
	</div>	
	</div>
</div>
	<div class="panel-body">
		<form id="formCopy" name="formCopy">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<th width="30%">原模板名称: </th>
					<td><input type="text" id="templateName" name="templateName" class="inputText" disabled="disabled"/></td>
				</tr>
				<tr>
					<th width="30%">新模板名称: </th>
					<td><input type="text" id="newTemplateName" name="newTemplateName" class="inputText"  validate="{required:true}"/></td>
				</tr>
				<tr>
					<th width="30%">原模板别名: </th>
					<td><input type="text" id="alias" name="alias" class="inputText" disabled="disabled"/></td>
				</tr>
				<tr>
					<th width="30%">新模板别名: </th>
					<td><input type="text" id="newAlias" name="newAlias"class="inputText"  validate="{required:true}"/></td>
				</tr>
		</table>
		</form>
	</div>
</div>
</body>
</html>
