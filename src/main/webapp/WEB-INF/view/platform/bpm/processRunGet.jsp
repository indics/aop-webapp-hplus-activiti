<%--
	time:2011-12-04 18:56:52
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>流程实例明细</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
	<f:link href="web.css" ></f:link>
		<%@include file="/commons/include/get.jsp" %>
    <script type="text/javascript">
    </script> 
	<style type="text/css"> 
	    body{ padding:0px; margin:0;overflow:hidden;}  
	</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流程实例详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link back" href="${returnUrl}">返回</a>
					</div>
				</div>
			</div>
		</div>
		<f:tab curTab="流程运行明细" tabName="process"/>
		<div class="panel-body">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="20%">
							运行实例ID(runId)
						</th>
						<td>${processRun.runId}</td>
					</tr>
					<tr>
						<th width="20%">流程定义ID:</th>
						<td>${processRun.defId}</td>
					</tr>
					<tr>
						<th width="20%">流程实例标题:</th>
						<td>${processRun.subject}</td>
					</tr>
					<tr>
						<th width="20%">创建人ID:</th>
						<td>${processRun.creatorId}</td>
					</tr>
					<tr>
						<th width="20%">创建人:</th>
						<td>${processRun.creator}</td>
					</tr>
					<tr>
						<th width="20%">创建时间:</th>
						<td><fmt:formatDate value="${processRun.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th width="20%">业务表单简述:</th>
						<td>${processRun.busDescp}</td>
					</tr>
					<tr>
						<th width="20%">状态:</th>
						<td>
							<c:choose>
							<c:when test="${processRun.status==1}">
								<font color='green'>正在运行</font>
							</c:when>
							<c:when test="${processRun.status==2}">
								结束
							</c:when>
						</c:choose>
						</td>
					</tr>
					<tr>
						<th width="20%">ACT流程实例ID:</th>
						<td>${processRun.actInstId}</td>
					</tr>
					<tr>
						<th width="20%">ACT流程定义ID:</th>
						<td>${processRun.actDefId}</td>
					</tr>
					<tr>
						<th width="20%">businessKey:</th>
						<td>${processRun.businessKey}</td>
					</tr>
				</table>
			</div><!-- end of tab panel -->
		</div>
</div>

</body>
</html>
