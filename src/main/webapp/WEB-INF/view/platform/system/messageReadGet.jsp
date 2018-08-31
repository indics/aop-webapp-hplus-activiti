<%--
	time:2012-01-14 15:14:52
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>接收状态明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">接收状态详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div class="panel-detail">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="20%">消息ID:</th>
						<td>${messageRead.messageId}</td>
					</tr>
					<tr>
						<th width="20%">接收人Id:</th>
						<td>${messageRead.receiverId}</td>
					</tr>
					<tr>
						<th width="20%">接收人:</th>
						<td>${messageRead.receiver}</td>
					</tr>
					<tr>
						<th width="20%">接收时间:</th>
						<td>${messageRead.receiveTime}</td>
					</tr>
				</table>
			</div>
		</div>
</div>

</body>
</html>
