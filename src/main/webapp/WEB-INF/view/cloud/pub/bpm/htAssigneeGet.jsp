
<%--
	time:2015-04-09 14:56:11
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>ht_assignee明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">ht_assignee详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link back" href="list.ht">返回</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			 
			<tr>
				<th width="20%">ASSIGNEE_TYPE:</th>
				<td>${htAssignee.assigneeType}</td>
			</tr>
 
			<tr>
				<th width="20%">TENANT_ID:</th>
				<td>${htAssignee.tenantId}</td>
			</tr>
 
			<tr>
				<th width="20%">GROUP_ID:</th>
				<td>${htAssignee.groupId}</td>
			</tr>
 
			<tr>
				<th width="20%">USER_ID:</th>
				<td>${htAssignee.userId}</td>
			</tr>
 
			<tr>
				<th width="20%">TASK_ID:</th>
				<td>${htAssignee.taskId}</td>
			</tr>
		</table>
		</div>
		
	</div>
</body>
</html>

