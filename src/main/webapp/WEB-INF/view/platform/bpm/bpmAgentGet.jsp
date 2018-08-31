<%--
	time:2012-01-07 17:31:48
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>流程代理明细</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流程代理详细信息</span>
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
						<th width="20%">agentid:</th>
						<td>${bpmAgent.agentid}</td>
					</tr>
					<tr>
						<th width="20%">流程定义ID:</th>
						<td>${bpmAgent.defid}</td>
					</tr>
					<tr>
						<th width="20%">agentuserid:</th>
						<td>${bpmAgent.agentuserid}</td>
					</tr>
					<tr>
						<th width="20%">touserid:</th>
						<td>${bpmAgent.touserid}</td>
					</tr>
					<tr>
						<th width="20%">actdefid:</th>
						<td>${bpmAgent.actdefid}</td>
					</tr>
				</table>
			</div>
		</div>
</div>

</body>
</html>
