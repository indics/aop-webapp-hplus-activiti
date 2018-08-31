
<%--
	time:2012-11-13 14:20:23
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>SYS_TABLE_MANAGE明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">SYS_TABLE_MANAGE详细信息</span>
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
				<th width="20%">NAME:</th>
				<td>${sysTableManage.name}</td>
			</tr>
 
			<tr>
				<th width="20%">ALIAS:</th>
				<td>${sysTableManage.alias}</td>
			</tr>
 
			<tr>
				<th width="20%">STYLE:</th>
				<td>${sysTableManage.style}</td>
			</tr>
 
			<tr>
				<th width="20%">WIDTH:</th>
				<td>${sysTableManage.width}</td>
			</tr>
 
			<tr>
				<th width="20%">HEIGHT:</th>
				<td>${sysTableManage.height}</td>
			</tr>
 
			<tr>
				<th width="20%">ISSINGLE:</th>
				<td>${sysTableManage.issingle}</td>
			</tr>
 
			<tr>
				<th width="20%">NEEDPAGE:</th>
				<td>${sysTableManage.needpage}</td>
			</tr>
 
			<tr>
				<th width="20%">ISTABLE:</th>
				<td>${sysTableManage.istable}</td>
			</tr>
 
			<tr>
				<th width="20%">OBJNAME:</th>
				<td>${sysTableManage.objname}</td>
			</tr>
 
			<tr>
				<th width="20%">DISPLAYFIELD:</th>
				<td>${sysTableManage.displayfield}</td>
			</tr>
 
			<tr>
				<th width="20%">CONDITIONFIELD:</th>
				<td>${sysTableManage.conditionfield}</td>
			</tr>
 
			<tr>
				<th width="20%">DSNAME:</th>
				<td>${sysTableManage.dsname}</td>
			</tr>
 
			<tr>
				<th width="20%">DSALIAS:</th>
				<td>${sysTableManage.dsalias}</td>
			</tr>
 
			<tr>
				<th width="20%">ISSYNC:</th>
				<td>${sysTableManage.issync}</td>
			</tr>
 
			<tr>
				<th width="20%">PAGESIZE:</th>
				<td>${sysTableManage.pagesize}</td>
			</tr>
		</table>
		</div>
		
	</div>
</body>
</html>

