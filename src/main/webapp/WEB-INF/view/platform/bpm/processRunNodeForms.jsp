<%@page pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
	<head>
		<title>流程实例业务表单明细</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
		<%@include file="/commons/include/getById.jsp" %>
		<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
	</head>
	<body >
		<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流程明细--${processRun.subject}</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="${preUrl}">返回</a></div>
				</div>
			</div>
		</div>
		<f:tab curTab="业务表单" tabName="process"/>
		<div class="panel-body">
			<table class="table-detail" style="width:100%" >
				<c:forEach items="${bpmNodeSetList }" var="nodeSet">
					<tr>
						<th width="200" nowrap="nowrap">${nodeSet.nodeName}(${nodeSet.nodeId})</th>
						<td><a href="#" class="link detail" style="font-size:15px;" onclick="jQuery.openFullWindow('${ctx}/platform/bpm/processRun/formHtml.ht?runId=${processRun.runId}&nodeId=${nodeSet.nodeId}')">查看表单</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	</body>
</html>
