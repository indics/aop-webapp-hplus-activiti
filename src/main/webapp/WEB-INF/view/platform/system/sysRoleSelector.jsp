 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>系统角色表管理</title>
	<%@include file="/commons/include/get.jsp" %>
	<style type="text/css">
		html { overflow-x: hidden; }
	</style>
</head>
<body>
			<div class="panel">
					<div class="panel-top">
						<div class="panel-search">
							<form id="searchForm" method="post" action="selector.ht" target="roleFrame">
								<div class="row">
									<span class="label">角色名:</span><input type="text" name="Q_roleName_SL"  class="inputText" size="20" value="${param['Q_roleName_SL']}"/> &nbsp;<input type="submit" value="查询" />
								</div>
							</form>
						</div>
					</div>
					<div class="panel-body">
						<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="sysRoleList" id="sysRoleItem" requestURI="selector.ht" sort="external" cellpadding="1" cellspacing="1" class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="roleId"  value="${sysRoleItem.roleId}"/>
								  	<input type="hidden" name="roleName"  value="${sysRoleItem.roleName}"/>
							</display:column>
							<display:column property="roleName" title="角色名" sortable="true" sortName="roleName"></display:column>
							<display:column property="subSystem.sysName" title="子系统名称" sortable="true" sortName="sysName">
							</display:column>
							<display:column property="memo" title="备注" ></display:column>
						</display:table>
						<cosim:paging tableId="sysRoleItem" showExplain="false"/>	
				</div>				
			</div> 
</body>
</html>