
<%--
	time:2012-10-29 12:00:23
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>自定义页面明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义页面详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link back" href="list.ht">返回</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<th width="20%">名称:</th>
					<td>${sysCustomPage.name}</td>
				</tr>
	 
				<tr>
					<th width="20%">标题:</th>
					<td>${sysCustomPage.title}</td>
				</tr>
				<tr>
					<th width="20%">描述:</th>
					<td>${sysCustomPage.description}</td>
				</tr>
				<tr>
					<th width="10%">模板:</th>
					<td>
						<div>
							<textarea id="template" name="template" readonly="readonly" class="inputText" style="width: 99%;height: 300px">${sysCustomPage.template}</textarea>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>

