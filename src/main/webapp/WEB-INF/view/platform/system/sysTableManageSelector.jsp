<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>自定义表管理选择</title>
<%@include file="/commons/include/get.jsp" %>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义表管理管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">名称:</span><input type="text" name="Q_name_S"  class="inputText" value="${param['Q_name_S']}"/>
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
		    <display:table name="sysTableManageList" id="sysTableManageItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
					  	<input type="radio" class="pk" name="id" value="${sysTableManageItem.id}" tableManageName="${sysTableManageItem.name}">
				</display:column>
				<display:column property="name" title="名称" sortable="true" sortName="name"></display:column>
				<display:column property="alias" title="别名" sortable="true" sortName="alias"></display:column>
				<display:column  title="显示样式" sortable="true" sortName="style">
					<c:choose>
						<c:when test="${sysTableManageItem.style==0}">
							<span class="green">列表</span>
						</c:when>
						<c:otherwise>
							<span class="red">树形</span>
						</c:otherwise>
					</c:choose>
				</display:column>
				<display:column  title="是否为表" sortable="true" sortName="istable">
					<c:choose>
						<c:when test="${sysTableManageItem.istable==0}">
							<span class="red">视图</span>
						</c:when>
						<c:otherwise>
							<span class="green">数据库表</span>
						</c:otherwise>
					</c:choose>
				</display:column>
				<display:column property="objname" title="对象名称" sortable="true" sortName="objname"></display:column>
				<display:column property="dsalias" title="数据源名称" sortable="true" sortName="dsalias"></display:column>
			</display:table>
			<cosim:paging tableId="sysTableManageItem"/>
		</div>
	</div> <!-- end of panel -->
</body>
</html>


