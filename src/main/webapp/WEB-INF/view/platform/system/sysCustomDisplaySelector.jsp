<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>自定义显示管理</title>
<%@include file="/commons/include/get.jsp" %>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义显示管理列表</span>
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
		    <display:table name="sysCustomDisplayList" id="sysCustomDisplayItem" requestURI="selector.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column style="width:30px;">
			  		<input type="radio" class="pk" name="id" value="${sysCustomDisplayItem.id}" dsplName="${sysCustomDisplayItem.name}">
				</display:column>
				<display:column property="name" title="名称" sortable="true" sortName="name"></display:column>
				<display:column title="分页" sortable="true" sortName="paged">
					<c:choose>
						<c:when test="${sysCustomDisplayItem.paged==1}">
							<span class="green">分页</span>
						</c:when>
						<c:when test="${sysCustomDisplayItem.paged!=1}">
							<span class="brown">不分页</span>
						</c:when>
					</c:choose>
				</display:column>
				<display:column property="pageSize" title="分页大小" sortable="true" sortName="pageSize"></display:column>
				<display:column property="description" title="描述" sortable="true" sortName="description" maxLength="80"></display:column>
			</display:table>
			<cosim:paging tableId="sysCustomDisplayItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


