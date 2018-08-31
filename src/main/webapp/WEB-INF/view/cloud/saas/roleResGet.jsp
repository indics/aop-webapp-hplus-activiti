
<%--
	time:2014-07-24 09:47:02
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>角色资源映射明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">角色资源映射详细信息</span>
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
				<th width="20%">roleId:</th>
				<td>${saasRoleRes.roleid}</td>
			</tr>
 
			<tr>
				<th width="20%">资源主键:</th>
				<td>${saasRoleRes.resid}</td>
			</tr>
 
			<tr>
				<th width="20%">租户ID:</th>
				<td>${saasRoleRes.tenantid}</td>
			</tr>
		</table>
		</div>
		
	</div>
</body>
</html>

