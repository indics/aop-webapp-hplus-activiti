<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>ht_assignee管理</title>
<%@include file="/commons/include/get.jsp" %>

</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">ht_assignee管理列表</span>
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
						<span class="label">ASSIGNEE_TYPE:</span><input type="text" name="Q_assigneeType_SL"  class="inputText" />
						<span class="label">TENANT_ID:</span><input type="text" name="Q_tenantId_SL"  class="inputText" />
						<span class="label">GROUP_ID:</span><input type="text" name="Q_groupId_SL"  class="inputText" />
						<span class="label">USER_ID:</span><input type="text" name="Q_userId_SL"  class="inputText" />
						<span class="label">TASK_ID:</span><input type="text" name="Q_taskId_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="htAssigneeList" id="htAssigneeItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="assigneeId" value="${htAssigneeItem.assigneeId}">
				</display:column>
				<display:column property="assigneeType" title="ASSIGNEE_TYPE" sortable="true" sortName="assigneeType"></display:column>
				<display:column property="tenantId" title="TENANT_ID" sortable="true" sortName="tenantId"></display:column>
				<display:column property="groupId" title="GROUP_ID" sortable="true" sortName="groupId"></display:column>
				<display:column property="userId" title="USER_ID" sortable="true" sortName="userId"></display:column>
				<display:column property="taskId" title="TASK_ID" sortable="true" sortName="taskId"></display:column>
				<display:column title="管理" media="html" style="width:180px">
					<a href="del.ht?assigneeId=${htAssigneeItem.assigneeId}" class="link del">删除</a>
					<a href="edit.ht?assigneeId=${htAssigneeItem.assigneeId}" class="link edit">编辑</a>
					<a href="get.ht?assigneeId=${htAssigneeItem.assigneeId}" class="link detail">明细</a>
					
				</display:column>
			</display:table>
			<cosim:paging tableId="htAssigneeItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


