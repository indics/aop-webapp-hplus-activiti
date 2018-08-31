<%--
	time:2012-06-25 11:05:09
	desc:edit the 通用表单对话框
--%>
<html>
<head>
	<title>自定义表管理预览</title>
	<%@include file="/commons/include/get.jsp" %>
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script> 
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.exedit-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/ajaxgrid.js" ></script>
	<script type="text/javascript">
	$(function(){
		$("a.link.search").click(function(){
			if(!$(this).hasClass('disabled')) {
				$(this).closest("div.panel-top").find("form:[name='searchForm']").submit();
			}
		});
	});
	</script>
</head>
<body>
	<div id="content">
		${html}
	</div>       	 
</body>
</html>
