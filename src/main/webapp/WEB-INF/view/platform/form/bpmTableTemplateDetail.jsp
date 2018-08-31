<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>查看表格业务数据的模板详细信息</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/getById.jsp" %>
	<%@include file="/commons/include/customForm.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/displaytag.js" ></script>	
	<script type="text/javascript">
		function goBack(){
			history.back();
		}
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">			
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" onclick="goBack()" href="javascript:;">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				${html}
		</div>
</div>
</body>
</html>
