<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>角色资源映射管理</title>
<%@include file="/commons/include/get.jsp" %>
<script>
function resRoleDialog(roleId){
    var url=__ctx+"/cloud/saas/res/editForRole.ht?tenantId=${tenantId}&roleId=" + roleId;
	var winArgs="dialogWidth=350px;dialogHeight=460px;status=0;help=0;";
	url=url.getNewUrl();
	window.showModalDialog(url,"",winArgs);
}

function showDetail(){
	$(".tbar-title a").parent().next().toggle();
}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<a href="javascript:showDetail()" ><span class="tbar-label">角色管理列表</span></a>
			</div>
			<div style="display: none;font-weight: normal;line-height: 20px;height:70px;background-color: #f5f5f5;padding-left: 25px;padding-right: 20px;">
				<p><br/></p>
				查看所有的角色信息
			</div>	
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
<!-- 				<div class="group"><a class="link add" href="edit.ht">添加</a></div>
					<div class="l-bar-separator"></div>
 					<div class="group"><a class="link update" id="btnUpd" action="edit.ht">修改</a></div> 
 					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del"  action="del.ht">删除</a></div> -->
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="listByTenant.ht">
					<div class="row">
						<span class="label">角色名:</span><input type="text" name="Q_roleName_SL"  class="inputText" />
						<span class="label">角色别名:</span><input type="text" name="Q_roleAlias_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="saasRoleList" id="saasRoleItem" requestURI="listByTenant.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="saasRoleId" value="${saasRoleItem.saasRoleId}">
				</display:column>
				<display:column property="roleName" title="角色名称" sortable="true" sortName="roleName"></display:column>
				<display:column property="roleAlias" title="角色别名" sortable="true" sortName="roleAlias"></display:column>
				<display:column property="memo" title="角色备注" sortable="true" sortName="memo"></display:column>
				<display:column property="tenantId" title="租户ID" sortable="true" sortName="tenantId"></display:column>
				<display:column title="管理" media="html" style="width:180px">
<%-- 					<a href="del.ht?id=${saasRoleItem.saasRoleId}" class="link del">删除</a> --%>
<%-- 					<a href="edit.ht?id=${saasRoleItem.saasRoleId}" class="link edit">编辑</a> --%>
<%-- 					<a href="javascript:resRoleDialog(${saasRoleItem.roleId})" class="link detail">分配资源</a> --%>
					<a href="${ctx}/cloud/saas/userRole/edit.ht?roleId=${saasRoleItem.roleId}" class="link detail">分配人员</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="saasRoleItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


