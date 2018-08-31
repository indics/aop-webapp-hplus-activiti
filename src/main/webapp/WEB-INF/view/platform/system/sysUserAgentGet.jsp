<%--
	time:2011-12-23 16:15:45
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>用户代理明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">用户代理详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="../sysUserAgent/list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<form id="sysUserAgentForm" method="post" action="add2.ht">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="20%">被代理用户ID:</th>
						<td>${sysUserAgent.agentuserid}</td>
					</tr>
					<tr>
						<th width="20%">授权用户ID:</th>
						<td>${sysUserAgent.touserid}</td>
					</tr>
					<tr>
						<th width="20%">授权用户:</th>
						<td>${sysUserAgent.tofullname}</td>
					</tr>
					<tr>
						<th width="20%">开始时间:</th>
						<td>${f:shortDate(sysUserAgent.starttime)}</td>
					</tr>
					<tr>
						<th width="20%">结束时间:</th>
						<td>${f:shortDate(sysUserAgent.endtime)}</td>
					</tr>
					<tr>
						<th width="20%">是否全权代理:</th>
						<td>
							<c:choose>
								<c:when test="${sysUserAgent.isall == 1}">
									是
								</c:when>
								<c:otherwise>
									否
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th width="20%">是否有效:</th>
						<td>
							<c:choose>
								<c:when test="${sysUserAgent.isvalid== 1}">
									是
								</c:when>
								<c:otherwise>
									否
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</form>
		</div>
</div>

</body>
</html>
