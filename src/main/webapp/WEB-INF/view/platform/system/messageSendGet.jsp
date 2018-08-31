<%--
	time:2012-01-14 15:10:58
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>发送消息明细</title>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript">
	function dyniframesize(down) { 
		var pTar = null; 
		if (document.getElementById){ 
			pTar = document.getElementById(down); 
		} 
		else{ 
			eval('pTar = ' + down + ';'); 
		} 
		if (pTar && !window.opera){ 
			//begin resizing iframe 
			pTar.style.display="block";
			if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){ 
				//ns6 syntax 
				pTar.height = pTar.contentDocument.body.offsetHeight +20; 
				pTar.width = pTar.contentDocument.body.scrollWidth; 
			}
			else if (pTar.Document && pTar.Document.body.scrollHeight){ 
				//ie5+ syntax 
				pTar.height = pTar.Document.body.scrollHeight; 
				pTar.width = pTar.Document.body.scrollWidth; 
			} 
		}
	} 
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">发送消息详细信息</span>
			</div>
			<c:if test="${flag!='desk'}">
				<div class="panel-toolbar">
					<div class="toolBar">
						<div class="group"><a class="link back" href="list.ht">返回</a></div>
					</div>
				</div>
			</c:if>
		</div>
		<div class="panel-body">
			
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<th width="20%">标题:</th>
					<td>${messageSend.subject}</td>
				</tr>
				<tr>
					<th width="20%">收信人:</th>
					<td colspan="3">${messageSend.receiverName}</td>
				</tr>					
				<tr>
					<th width="20%">内容:</th>
					<td colspan="3">${messageSend.content}</td>
				</tr>
				<tr>
					<th width="20%">发送时间:</th>
					<td colspan="3"><fmt:formatDate value="${messageSend.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<c:if test="${messageSend.canReply==1}">
				<tr>
					<th width="20%">回复信息：</th>
					<td colspan="3"><a href="${ctx}/platform/system/messageReply/list.ht?messageId=${messageSend.id}&userId=${messageSend.userId}">查看回复信息</a></td>
				</tr>
				</c:if>	
			</table>
			

			<iframe id="detailFrame" height="100%" width="100%" frameborder="0" onload="javascript:dyniframesize('detailFrame')"
				src="readDetail.ht?id=${messageSend.id}&canReply=${messageSend.canReply}"></iframe>
				
		</div>
</div>

</body>
</html>
