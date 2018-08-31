<%--
	time:2015-04-09 14:56:11
	desc:edit the ht_task
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 ht_task</title>
	<%@include file="/commons/b2b/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=htTask"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#htTaskForm').submit(); 
			});
		});
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${htTask.taskId !=null}">
			        <span class="tbar-label">编辑ht_task</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加ht_task</span>
			    </c:otherwise>			   
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back " href="list.ht">返回</a></div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="htTaskForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="20%">任务名称:  <span class="required">*</span></th>
					<td><input type="text" id="taskName" name="taskName" value="${htTask.taskName}" validate="{required:true,maxlength:150}" class="inputText"/></td>
					<th width="20%">任务类型:  <span class="required">*</span></th>
					<td><input type="text" id="taskType" name="taskType" value="${htTask.taskType}" validate="{required:true,maxlength:60}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">任务状态: </th>
					<td><input type="text" id="taskState" name="taskState" value="${htTask.taskState}" validate="{required:false,maxlength:60}" class="inputText"/></td>
					<th width="20%">任务执行人: </th>
					<td><input type="text" id="taskAssignee" name="taskAssignee" value="${htTask.taskAssignee}" validate="{required:false,maxlength:150}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">起始时间:  <span class="required">*</span></th>
					<td><input type="text" id="taskStarttime" name="taskStarttime" value="<fmt:formatDate value='${htTask.taskStarttime}' pattern='yyyy-MM-dd'/>" validate="{required:true,date:true}" class="inputText date"/></td>
					<th width="20%">结束时间: </th>
					<td><input type="text" id="taskEndtime" name="taskEndtime" value="<fmt:formatDate value='${htTask.taskEndtime}' pattern='yyyy-MM-dd'/>" validate="{required:false,date:true}" class="inputText date"/></td>
				</tr>
				<tr>
					<th width="20%">持续时间: </th>
					<td><input type="text" id="taskDuration" name="taskDuration" value="${htTask.taskDuration}" validate="{required:false,number:true }" class="inputText"/></td>
					<th width="20%">任务链接: </th>
					<td><input type="text" id="taskLink" name="taskLink" value="${htTask.taskLink}" validate="{required:false,maxlength:765}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">任务描述: </th>
					<td><input type="text" id="taskDescp" name="taskDescp" value="${htTask.taskDescp}" validate="{required:false,maxlength:765}" class="inputText"/></td>
					<th width="20%">来源ID: </th>
					<td><input type="text" id="sourceId" name="sourceId" value="${htTask.sourceId}" validate="{required:false,number:true }" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">来源单据类型: </th>
					<td><input type="text" id="sourceType" name="sourceType" value="${htTask.sourceType}" validate="{required:false,maxlength:60}" class="inputText"/></td>
					<th width="20%">流程任务ID: </th>
					<td><input type="text" id="proccessTaskId" name="proccessTaskId" value="${htTask.proccessTaskId}" validate="{required:false,maxlength:90}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">流程执行ID: </th>
					<td><input type="text" id="processExecutionId" name="processExecutionId" value="${htTask.processExecutionId}" validate="{required:false,maxlength:90}" class="inputText"/></td>
				</tr>
			</table>
			<input type="hidden" name="taskId" value="${htTask.taskId}" />					
		</form>
	</div>
</div>
</body>
</html>
