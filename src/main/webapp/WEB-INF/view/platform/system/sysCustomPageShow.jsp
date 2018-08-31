<%--
	time:2012-10-29 12:00:23
	desc:edit the 自定义页面
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title> ${sysCustomPage.title} </title>
	<%@include file="/commons/include/get.jsp" %>
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script> 
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.exedit-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/ajaxgrid.js" ></script>
	<script type="text/javascript">
		$(function(){
			//查询
			$("a.link.search").click(function(){
				if(!$(this).hasClass('disabled')) {
					$(this).closest("div.panel-top").find("form:[name='searchForm']").submit();
				}
			});
		});
	</script>
</head>
<body>
	<div>
		${sysCustomPage.content}
	</div>
</body>
</html>
