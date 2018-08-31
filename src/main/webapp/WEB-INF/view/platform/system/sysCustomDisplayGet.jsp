
<%--
	time:2012-10-23 17:59:41
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>自定义显示 明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义显示 详细信息</span>
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
				<th width="20%">名称:</th>
				<td>${sysCustomDisplay.name}</td>
			</tr>
			 <tr>
				<th width="20%">描述:</th>
				<td>${sysCustomDisplay.description}</td>
			</tr>
			<tr>
				<th width="20%">数据源:</th>
				<td>${sysCustomDisplay.dsName}</td>
			</tr>
			<tr>
				<th>脚本:</th>
				<td><div style="width: 100%;"><textarea readonly="readonly"  style="width: 98%;height: 150px">${sysCustomDisplay.script}</textarea></div></td>
			</tr>
			 <tr>
				<th width="20%">是否分页:</th>
				<td>
					<c:choose>
						<c:when test="${sysCustomDisplay.paged==1}">
							是
						</c:when>
						<c:when test="${sysCustomDisplay.paged==-1}">
							否
						</c:when>
						<c:otherwise>
							未知
						</c:otherwise>		
					</c:choose>
				</td>
			</tr>
 			<c:if test="${sysCustomDisplay.paged==1}">
 				<tr>
					<th width="20%">分页大小:</th>
					<td>${sysCustomDisplay.pageSize}</td>
				</tr>
 			</c:if>
			<tr>
				<th width="20%">显示模板:</th>
				<td><div style="width: 100%;"><textarea readonly="readonly"  style="width: 98%;height: 300px">${sysCustomDisplay.dspTemplate}</textarea></div></td>
			</tr>
		</table>
		</div>
		
	</div>
</body>
</html>

