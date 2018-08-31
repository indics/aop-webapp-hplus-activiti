
<%--
	time:2012-10-23 17:59:41
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>${description}</title>
<%@include file="/commons/include/getById.jsp"%>
<%@include file="/commons/include/get.jsp" %>
<link href="${ctx}/js/lg/skins/Aqua/css/ligerui-grid.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-body">
			<div id="content">
				${html }
			</div>		
		</div>
	</div>
</body>
</html>

