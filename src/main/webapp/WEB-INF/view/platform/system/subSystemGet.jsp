<%--
	time:2011-11-21 12:22:07
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>子系统管理明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
	<table border="0" cellspacing="0" cellpadding="0" class="listHeader">
		<tr>
			<td class="title">子系统管理明细</td>
			<td>
				<div class="toolBar">
					<a class="link back" href="getSubSystem.ht">返回</a>
				</div>
			</td>
		</tr>
	</table>
	<div class="line"></div>
	<table border="0" cellspacing="0" cellpadding="0" class="listTable">
		<tr>
			<td class="form_title">系统名称:</td>
			<td class="form_input">${subSystem.sysName}</td>
		</tr>
		<tr>
			<td class="form_title">别名(系统中唯一):</td>
			<td class="form_input">${subSystem.alias}</td>
		</tr>
		<tr>
			<td class="form_title">系统的图标:</td>
			<td class="form_input">${subSystem.logo}</td>
		</tr>
		<tr>
			<td class="form_title">系统首页地址:</td>
			<td class="form_input">${subSystem.defaultUrl}</td>
		</tr>
		<tr>
			<td class="form_title">备注:</td>
			<td class="form_input">${subSystem.memo}</td>
		</tr>
		<tr>
			<td class="form_title">创建时间:</td>
			<td class="form_input">${subSystem.createtime}</td>
		</tr>
		<tr>
			<td class="form_title">创建人:</td>
			<td class="form_input">${subSystem.creator}</td>
		</tr>
		<tr>
			<td class="form_title">允许删除:</td>
			<td class="form_input">${subSystem.allowDel}</td>
		</tr>
		<tr>
			<td class="form_title">选择组织架构:</td>
			<td class="form_input">${subSystem.needOrg}</td>
		</tr>
		<tr>
			<td class="form_title">是否激活:</td>
			<td class="form_input">${subSystem.isActive}</td>
		</tr>
	</table>
</body>
</html>
