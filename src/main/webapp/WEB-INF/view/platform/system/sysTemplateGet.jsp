<%--
	time:2011-12-28 14:04:30
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>模版管理明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">模版管理详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="../sysTemplate/list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div class="panel-detail">
				<form id="sysTemplateForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">类型:</th>
							<td>
							<c:choose>
							    <c:when test="${sysTemplateItem.templateType==1}">
									         手机短信
								   	</c:when>
								   	<c:when test="${sysTemplateItem.templateType==2}">
									         邮件模版 
								   	</c:when>
							       	<c:otherwise>
								      html模版    
								  </c:otherwise>
							    </c:choose>
							</td>
						</tr>
						<tr>
							<th width="20%">模版名称:</th>
							<td>${sysTemplate.name}</td>
						</tr>
						<tr>
							<th width="20%">模版内容:</th>
							<td>${sysTemplate.content}</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
</div>

</body>
</html>
