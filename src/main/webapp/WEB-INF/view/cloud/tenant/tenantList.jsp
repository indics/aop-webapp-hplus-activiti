<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>企业未审核信息列表</title>
<%@include file="/commons/include/get.jsp" %>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业信息列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list">
					<div class="row">
						<span class="label">企业名称:</span><input type="text" name="Q_name_SL"  class="inputText" />
						<span class="label">联系人:</span><input type="text" name="Q_connecter_SL"  class="inputText" />
						<span class="label">手机:</span><input type="text" name="Q_tel_SL"  class="inputText" />
					</div>
					<div class="row">	
						<span class="label">公司编码:</span><input type="text" name="Q_sysOrgInfoId_EL"  class="inputText" />
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
		    <display:table name="infoList" id="infoItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="sysOrgInfoId" value="${infoItem.sysOrgInfoId}">
				</display:column>
				<display:column property="sysOrgInfoId" title="企业账号" sortable="true" sortName="sysOrgInfoId" maxLength="80"></display:column>
				<display:column property="name" title="企业名称" sortable="true" sortName="name" maxLength="80"></display:column>
				<display:column property="connecter" title="联系人" sortable="true" sortName="connecter"></display:column>
				<display:column  title="注册时间" sortable="true" sortName="createtime">
					<fmt:formatDate value="${infoItem.createtime}" pattern="yyyy-MM-dd"/>
				</display:column>
				<display:column title="审核状态" sortable="true" sortName="state">
					<c:if test="${infoItem.state=='0'}">
						新注册
					</c:if>
					<c:if test="${infoItem.state=='1'}">
						未审核
					</c:if>
					<c:if test="${infoItem.state=='2'}">
						审核通过
					</c:if>
				</display:column>
				<display:column title="管理" media="html">
					<a href="${ctx }/b2b/operation/auth/user/listForSecuAdmin.ht?sysOrgInfoId=${infoItem.sysOrgInfoId}" class="link detail">人员</a>
					<%-- <a href="org.ht?tenantId=${infoItem.sysOrgInfoId}" class="link detail">组织</a>
					<a href="pos.ht?tenantId=${infoItem.sysOrgInfoId}" class="link detail">岗位</a>
					<a href="role.ht?tenantId=${infoItem.sysOrgInfoId}" class="link detail">角色</a>
					<a href="workflow.ht?tenantId=${infoItem.sysOrgInfoId}" class="link detail">流程</a> --%>
				</display:column>
			</display:table>
			<cosim:paging tableId="infoItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


