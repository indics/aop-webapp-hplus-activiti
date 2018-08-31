<%--
	time:2012-01-07 17:31:48
	desc:edit the 流程代理
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 流程代理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmAgent"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#bpmAgentForm').submit(); 
			});
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
				<c:choose>
					<c:when test="${bpmAgent.id==0}">
						添加
					</c:when>
					<c:otherwise>
						编辑
					</c:otherwise>
				</c:choose>
				流程代理
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="bpmAgentForm" method="post" action="save.ht">
					<div class="panel-detail">
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="20%">agentid: </th>
								<td><input type="text" id="agentid" name="agentid" value="${bpmAgent.agentid}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">流程定义Key: </th>
								<td><input type="text" id="defKey" name="defKey" value="${bpmAgent.defKey}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">agentuserid: </th>
								<td><input type="text" id="agentuserid" name="agentuserid" value="${bpmAgent.agentuserid}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">touserid: </th>
								<td><input type="text" id="touserid" name="touserid" value="${bpmAgent.touserid}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">actdefid: </th>
								<td><input type="text" id="actdefid" name="actdefid" value="${bpmAgent.actdefid}"  class="inputText"/></td>
							</tr>
						</table>
						<input type="hidden" name="id" value="${bpmAgent.id}" />
					</div>
				</form>
		</div>
</div>
</body>
</html>
