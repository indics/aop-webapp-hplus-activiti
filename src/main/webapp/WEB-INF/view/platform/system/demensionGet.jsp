<%--
	time:2011-11-08 12:04:22
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>维度信息明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="0" class="listHeader">
	<tr>
		<td class="title">维度信息明细</td>
		<td>
			<div class="toolBar">
				<a class="link back" href="list.ht">返回</a>
			</div>
		</td>
	</tr>
</table>
<div class="line"></div>
<table border="0" cellspacing="0" cellpadding="0" class="listTable">
	<tr>
		<td class="form_title">维度名称:</td>
		<td class="form_input">${demension.demName}</td>
	</tr>
	<tr>
		<td class="form_title">维度描述:</td>
		<td class="form_input">${demension.demDesc}</td>
	</tr>
	<tr>
		<td class="form_title">类型:</td>
		<td class="form_input">${demension.demType}</td>
	</tr>
</table>
</body>
</html>
