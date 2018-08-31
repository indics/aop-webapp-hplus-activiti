
<%--
	time:2013-08-19 17:21:54
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>企业流程定义明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业流程定义详细信息</span>
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
				<th width="20%">业企名称:</th>
				<td>${serviceEntflow.entname}</td>
			</tr>
 
			<tr>
				<th width="20%"> 流程类型:</th>
				<td>${serviceEntflow.flowtype}</td>
			</tr>
 
			<tr>
				<th width="20%">流程定义KEY:</th>
				<td>${serviceEntflow.flowkey}</td>
			</tr>
 
			<tr>
				<th width="20%">程流名称:</th>
				<td>${serviceEntflow.flowname}</td>
			</tr>
 
			<tr>
				<th width="20%">备注:</th>
				<td>${serviceEntflow.remake}</td>
			</tr>
		</table>
		</div>
		
	</div>
</body>
</html>

