<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>审核通过企业信息列表</title>
<%@include file="/commons/include/get.jsp" %>
<style>
	.table-grid a:link{text-decoration:none;}
</style>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">审核通过企业信息列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link select"  action="change/1.ht">置为未审核</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="listPassing.ht">
					<div class="row">
						<span class="label">企业名称:</span><input type="text" name="Q_name_SL"  class="inputText" />
						<span class="label">联系人:</span><input type="text" name="Q_connecter_SL"  class="inputText" />
						<span class="label">手机:</span><input type="text" name="Q_tel_SL"  class="inputText" />
					</div>
					<div class="row">	
						<span class="label">公司编码:</span><input type="text" name="Q_sysOrgInfoId_S"  class="inputText" />
						<span class="label">注册时间 从:</span> <input  name="Q_beginregistertime_DL"  class="inputText date" />
						<span class="label">至: </span><input  name="Q_endregistertime_DG" class="inputText date" />
						
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="tenantList" id="tenantItem" requestURI="listPassing.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="sysOrgInfoId" value="${tenantItem.sysOrgInfoId}">
				</display:column>
				<display:column property="sysOrgInfoId" title="企业账号" sortable="true" sortName="sysOrgInfoId" maxLength="20" style="text-align:center;"></display:column>
				<display:column title="企业名称" media="html">
					<a href="${ctx}/b2b/member/factory/factoryInfo/forSysadmin.ht?sysOrgInfoId=${tenantItem.sysOrgInfoId}" title="${tenantItem.name}"><ap:textTip value="${tenantItem.name}" max="20" more="..."/></a>
				</display:column>
				<display:column property="scale" title="企业规模" sortable="true" sortName="scale" maxLength="80" style="text-align:center;"></display:column>
				<display:column property="connecter" title="联系人" sortable="true" sortName="connecter" style="text-align:center;"></display:column>
				<display:column property="tel" title="手机" sortable="true" sortName="tel" style="text-align:center;"></display:column>
				<display:column  title="注册时间" sortable="true" sortName="createtime" style="text-align:center;">
					<fmt:formatDate value="${tenantItem.createtime}" pattern="yyyy-MM-dd"/>
				</display:column>
				<display:column title="管理" media="html" style="width:100px; text-align:center;">
					<a href="${ctx}/cloud/system/auth/user/list.ht?sysOrgInfoId=${tenantItem.sysOrgInfoId}" class="link detail">人员</a>
					<a href="${ctx}/cloud/system/auth/org/list.ht?sysOrgInfoId=${tenantItem.sysOrgInfoId}" class="link detail">组织</a>
<%-- 					<a href="${ctx}/cloud/saas/position/tree.ht?sysOrgInfoId=${tenantItem.sysOrgInfoId}" class="link detail">岗位</a> --%>
<%-- 					<a href="${ctx}/platform/bpm/bpmDefinition/manage.ht?sysOrgInfoId=${tenantItem.sysOrgInfoId}" class="link detail">流程</a> --%>
				</display:column>
			</display:table>
			<cosim:paging tableId="tenantItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


