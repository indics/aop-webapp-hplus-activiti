<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>数据列表</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">列表</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link search" id="btnSearch">查询</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back" href="../bpmFormTable/list.ht">返回</a></div>
			</div>	
		</div>
	</div>
	<div class="panel-body">
	${html}
	</div><!-- end of panel-body -->	
</div>
</body>
</html>
