<%--
	time:2012-01-14 15:13:00
	desc:edit the 消息接收者
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>  
	<title>编辑 消息接收者</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=messageReceiver"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#messageReceiverForm').submit(); 
			});
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">编辑消息接收者</span>
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
				<form id="messageReceiverForm" method="post" action="save.ht">
					
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="20%">消息ID: </th>
								<td><input type="text" id="messageId" name="messageId" value="${messageReceiver.messageId}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">接收者类型: </th>
								<td><input type="text" id="receiveType" name="receiveType" value="${messageReceiver.receiveType}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">接收人ID: </th>
								<td><input type="text" id="receiverId" name="receiverId" value="${messageReceiver.receiverId}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">接收人: </th>
								<td><input type="text" id="receiver" name="receiver" value="${messageReceiver.receiver}"  class="inputText"/></td>
							</tr>
						</table>
						<input type="hidden" name="id" value="${messageReceiver.id}" />
					
				</form>
		</div>
</div>
</body>
</html>
