<%--
	time:2011-11-26 11:35:04
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>系统日志明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">系统日志详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="../sysAudit/list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysAuditForm" method="post" action="add2.ht">
					<div class="panel-detail">
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="20%">操作名称:</th>
								<td>${sysAudit.opName}</td>
							</tr>
							<tr>
								<th width="20%">执行时间:</th>
								<td>${sysAudit.exeTime}</td>
							</tr>
							<tr>
								<th width="20%">执行人ID:</th>
								<td>${sysAudit.executorId}</td>
							</tr>
							<tr>
								<th width="20%">执行人:</th>
								<td>${sysAudit.executor}</td>
							</tr>
							<tr>
								<th width="20%">IP:</th>
								<td>${sysAudit.fromIp}</td>
							</tr>
							<tr>
								<th width="20%">执行方法:</th>
								<td>${sysAudit.exeMethod}</td>
							</tr>
							<tr>
								<th width="20%">请求URL:</th>
								<td>${sysAudit.requestURI}</td>
							</tr>
							<tr>
								<th width="20%">请求参数:</th>
								<td>${sysAudit.reqParams}</td>
							</tr>
						</table>
					</div>
				</form>
		</div>
</div>

</body>
</html>
