<%--
	time:2012-02-03 14:40:59
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>流水号生成明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流水号生成详细信息</span>
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
						<th width="20%">名称:</th>
						<td>${indetity.name}</td>
					</tr>
					<tr>
						<th width="20%">别名:</th>
						<td>${indetity.alias}</td>
					</tr>
					<tr>
						<th width="20%">规则:</th>
						<td>${indetity.rule}</td>
					</tr>
					<tr>
						<th width="20%">每天生成:</th>
						<td> 
							<c:choose>
								<c:when test="${indetity.genEveryDay==1}">
									是
								</c:when>
								<c:otherwise>
									否
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th width="20%">流水号长度:</th>
						<td>${indetity.noLength}</td>
					</tr>
					<tr>
						<th width="20%">初始值:</th>
						<td>${indetity.initValue}</td>
					</tr>
					<tr>
						<th width="20%">当前值:</th>
						<td>${indetity.curValue}</td>
					</tr>
				</table>
			</div>
		</div>
</div>

</body>
</html>
