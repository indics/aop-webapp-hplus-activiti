<%--
	time:2012-10-18 15:46:59
	desc:edit the SYS_CUSTOM_DATA
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>

<html>
<head>
	<title>数据查询显示预览</title>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/ajaxgrid.js" ></script>
</head>
<body>
<div class="panel">
	<div class="panel-body">
		<div id="content">
			${html}
		</div>
	</div>
</div>
</body>
</html>
