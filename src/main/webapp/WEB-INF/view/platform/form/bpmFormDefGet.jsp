<%--
	time:2012-02-20 09:25:49
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>表单信息</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/getById.jsp" %>
	<script type="text/javascript">
		//放置脚本
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">表单信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="${returnUrl}">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<th width="20%">表单名:</th>
					<td>${bpmFormDef.subject}</td>
				</tr>
				<tr>
					<th width="20%">备注:</th>
					<td>${bpmFormDef.formDesc}</td>
				</tr>
				
				<tr>
					<th width="20%">默认版本:</th>
					<td> 
						<c:choose>
							<c:when test="${bpmFormDef.isDefault==1}">
								默认
							</c:when>
							<c:otherwise>
								非默认
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th width="20%">发布状态:</th>
					<td> 
						<c:choose>
							<c:when test="${bpmFormDef.isPublished==1}">
								发布
							</c:when>
							<c:otherwise>
								未发布
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<c:if test="${bpmFormDef.isPublished==1}">
					<tr>
						<th width="20%">发布人:</th>
						<td> 
							${bpmFormDef.publishedBy }
						</td>
					</tr>
					<tr>
						<th width="20%">发布时间:</th>
						<td> 
							<fmt:formatDate value="${bpmFormDef.publishTime}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</c:if>
				<tr>
						<th width="20%">发布人:</th>
						<td> 
							${bpmFormDef.publishedBy }
						</td>
				</tr>
				<tr>
						<th width="20%">表单HTML:</th>
						<td> 
							<textarea cols="100" rows="10">
								${fn:escapeXml(bpmFormDef.html)}
							</textarea>
							
						</td>
				</tr>
				
			</table>
		</div>
</div>

</body>
</html>
