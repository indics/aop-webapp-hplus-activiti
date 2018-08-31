<%--
	time:2015-04-09 14:56:11
	desc:edit the ht_assignee
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 ht_assignee</title>
	<%@include file="/commons/b2b/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=htAssignee"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#htAssigneeForm').submit(); 
			});
		});
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${htAssignee.assigneeId !=null}">
			        <span class="tbar-label">编辑ht_assignee</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加ht_assignee</span>
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
		<form id="htAssigneeForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="20%">ASSIGNEE_TYPE:  <span class="required">*</span></th>
					<td><input type="text" id="assigneeType" name="assigneeType" value="${htAssignee.assigneeType}" validate="{required:true,maxlength:60}" class="inputText"/></td>
					<th width="20%">TENANT_ID: </th>
					<td><input type="text" id="tenantId" name="tenantId" value="${htAssignee.tenantId}" validate="{required:false,number:true }" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">GROUP_ID: </th>
					<td><input type="text" id="groupId" name="groupId" value="${htAssignee.groupId}" validate="{required:false,number:true }" class="inputText"/></td>
					<th width="20%">USER_ID: </th>
					<td><input type="text" id="userId" name="userId" value="${htAssignee.userId}" validate="{required:false,number:true }" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">TASK_ID:  <span class="required">*</span></th>
					<td><input type="text" id="taskId" name="taskId" value="${htAssignee.taskId}" validate="{required:true,number:true }" class="inputText"/></td>
				</tr>
			</table>
			<input type="hidden" name="assigneeId" value="${htAssignee.assigneeId}" />					
		</form>
	</div>
</div>
</body>
</html>
