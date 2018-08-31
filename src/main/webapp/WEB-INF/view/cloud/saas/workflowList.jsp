<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>企业流程定义管理</title>
<%@include file="/commons/include/get.jsp" %>

</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业流程定义管理列表</span>
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
						<span class="label">业企名称:</span><input type="text" name="Q_entname_SL"  class="inputText" />
						<span class="label"> 流程类型:</span><input type="text" name="Q_flowtype_SL"  class="inputText" />
						<span class="label">流程定义KEY:</span><input type="text" name="Q_flowkey_SL"  class="inputText" />
						<span class="label">程流名称:</span><input type="text" name="Q_flowname_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="serviceEntflowList" id="serviceEntflowItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="id" value="${serviceEntflowItem.id}">
				</display:column>
				<display:column property="entname" title="业企名称" sortable="true" sortName="entname" maxLength="80"></display:column>
				<display:column property="flowtype" title=" 流程类型" sortable="true" sortName="flowtype" maxLength="80"></display:column>
				<display:column property="flowkey" title="流程定义KEY" sortable="true" sortName="flowkey" maxLength="80"></display:column>
				<display:column property="flowname" title="程流名称" sortable="true" sortName="flowname" maxLength="80"></display:column>
				<display:column title="管理" media="html" style="width:180px">
					<a href="del.ht?id=${serviceEntflowItem.id}" class="link del">删除</a>
					<a href="edit.ht?id=${serviceEntflowItem.id}" class="link edit">编辑</a>
					<a href="get.ht?id=${serviceEntflowItem.id}" class="link detail">明细</a>
					
				</display:column>
			</display:table>
			<cosim:paging tableId="serviceEntflowItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


