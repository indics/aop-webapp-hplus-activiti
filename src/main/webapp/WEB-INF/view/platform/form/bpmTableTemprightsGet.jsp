<%--
	time:2012-05-28 09:04:06
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>查看业务数据模板的权限信息明细</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/getById.jsp" %>
	<script type="text/javascript">
		//放置脚本
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">查看业务数据模板的权限信息详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="back bar-button" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div class="panel-detail">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="20%">模板ID:</th>
						<td>${bpmTableTemprights.templateId}</td>
					</tr>
					<tr>
						<th width="20%">权限所有者类型:</th>
						<td>${bpmTableTemprights.rightType}</td>
					</tr>
					<tr>
						<th width="20%">拥有者ID:</th>
						<td>${bpmTableTemprights.ownerId}</td>
					</tr>
					<tr>
						<th width="20%">拥有者名称:</th>
						<td>${bpmTableTemprights.ownerName}</td>
					</tr>
					<tr>
						<th width="20%">权限搜索类型:</th>
						<td>${bpmTableTemprights.searchType}</td>
					</tr>
				</table>
				</div>
		</div>
</div>

</body>
</html>
