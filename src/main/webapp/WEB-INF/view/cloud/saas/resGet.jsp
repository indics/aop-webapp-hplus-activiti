
<%--
	time:2014-03-19 14:36:49
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>企业资源明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业资源详细信息</span>
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
				<th width="20%">租户:</th>
				<td>${saasRes.tenant.name}</td>
			</tr>
 
			<tr>
				<th width="20%">资源:</th>
				<td>${saasRes.res.name}</td>
			</tr>
			<tr>
				<th width="20%">状态:</th>
				<td>${saasRes.status}</td>
			</tr>
		</table>
		</div>
		
	</div>
</body>
</html>

