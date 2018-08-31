<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>角色资源映射管理</title>
<%@include file="/commons/include/get.jsp" %>

</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">角色管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link add" href="edit.ht">添加</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link update" id="btnUpd" action="edit.ht">修改</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del"  action="del.ht">删除</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">资源Id:</span><input type="text" name="Q_resId_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="saasResList" id="saasResItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="saasRoleId" value="${saasResItem.saasResId}">
				</display:column>
				<display:column property="resId" title="资源Id" sortable="true" sortName="roleName"></display:column>
				<display:column title="资源名称" sortable="true">
					${saasResItem.res.resName}
				</display:column>
				<display:column property="tenantId" title="租户ID" sortable="true" sortName="tenantId"></display:column>
				<display:column title="管理" media="html" style="width:180px">
					<a href="del.ht?saasroleresid=${saasResItem.saasResId}" class="link del">删除</a>
					<a href="edit.ht?saasroleresid=${saasResItem.saasResId}" class="link edit">编辑</a>
					<a href="get.ht?saasroleresid=${saasResItem.saasResId}" class="link detail">明细</a>
					
				</display:column>
			</display:table>
			<cosim:paging tableId="saasResItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>