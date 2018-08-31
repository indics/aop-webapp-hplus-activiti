<%--
	time:2011-11-21 22:50:46
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>添加 流程定义扩展</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmDefinition"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#bpmDefinitionForm').submit(); 
			});
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">添加用户</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="bpmDefinitions.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div class="panel-detail">
				<form id="bpmDefinitionForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">分类ID: :</th>
							
							<td><input type="text" id="typeId" name="typeId" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">流程标题:  <span class="required">*</span>:</th>
							
							<td><input type="text" id="subject" name="subject" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">流程定义Key:  <span class="required">*</span>:</th>
							
							<td><input type="text" id="defKey" name="defKey" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">任务标题生成规则: :</th>
							
							<td><input type="text" id="taskNameRule" name="taskNameRule" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">流程描述: :</th>
							
							<td><input type="text" id="descp" name="descp" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">创建时间: :</th>
							
							<td><input type="text" id="createtime" name="createtime" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">流程状态: :</th>
							
							<td><input type="text" id="status" name="status" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">最新版本: :</th>
							
							<td><input type="text" id="newVersion" name="newVersion" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">流程定义XML(设计器): :</th>
							
							<td><input type="text" id="defXml" name="defXml" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">activiti流程定义ID: :</th>
							
							<td><input type="text" id="actDefId" name="actDefId" value="" class="inputText" /></td>
						</tr>
						<tr>
							<th width="20%">act流程定义Key: :</th>
							
							<td><input type="text" id="actDefKey" name="actDefKey" value="" class="inputText" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
</div>
</body>
</html>
