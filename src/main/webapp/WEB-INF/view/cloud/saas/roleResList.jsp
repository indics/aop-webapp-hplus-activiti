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
				<span class="tbar-label">角色资源映射管理列表</span>
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
						<span class="label">roleId:</span><input type="text" name="Q_roleid_SL"  class="inputText" />
						<span class="label">资源主键:</span><input type="text" name="Q_resid_SL"  class="inputText" />
						<span class="label">租户ID:</span><input type="text" name="Q_tenantid_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="saasRoleResList" id="saasRoleResItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="saasroleresid" value="${saasRoleResItem.saasroleresid}">
				</display:column>
				<display:column property="roleid" title="roleId" sortable="true" sortName="roleId"></display:column>
				<display:column property="resid" title="资源主键" sortable="true" sortName="resId"></display:column>
				<display:column property="tenantid" title="租户ID" sortable="true" sortName="tenantId"></display:column>
				<display:column title="管理" media="html" style="width:180px">
					<a href="del.ht?saasroleresid=${saasRoleResItem.saasroleresid}" class="link del">删除</a>
					<a href="edit.ht?saasroleresid=${saasRoleResItem.saasroleresid}" class="link edit">编辑</a>
					<a href="get.ht?saasroleresid=${saasRoleResItem.saasroleresid}" class="link detail">明细</a>
					
				</display:column>
			</display:table>
			<cosim:paging tableId="saasRoleResItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


