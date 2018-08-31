<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>ht_task管理</title>
<%@include file="/commons/include/get.jsp" %>

</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">ht_task管理列表</span>
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
						<span class="label">任务名称:</span><input type="text" name="Q_taskName_SL"  class="inputText" />
						<span class="label">任务类型:</span><input type="text" name="Q_taskType_SL"  class="inputText" />
						<span class="label">任务状态:</span><input type="text" name="Q_taskState_SL"  class="inputText" />
						<span class="label">任务执行人:</span><input type="text" name="Q_taskAssignee_SL"  class="inputText" />
						<span class="label">起始时间 从:</span> <input  name="Q_begintaskStarttime_DL"  class="inputText date" />
						<span class="label">至: </span><input  name="Q_endtaskStarttime_DG" class="inputText date" />
						<span class="label">结束时间 从:</span> <input  name="Q_begintaskEndtime_DL"  class="inputText date" />
						<span class="label">至: </span><input  name="Q_endtaskEndtime_DG" class="inputText date" />
						<span class="label">持续时间:</span><input type="text" name="Q_taskDuration_SL"  class="inputText" />
						<span class="label">任务链接:</span><input type="text" name="Q_taskLink_SL"  class="inputText" />
						<span class="label">任务描述:</span><input type="text" name="Q_taskDescp_SL"  class="inputText" />
						<span class="label">来源ID:</span><input type="text" name="Q_sourceId_SL"  class="inputText" />
						<span class="label">来源单据类型:</span><input type="text" name="Q_sourceType_SL"  class="inputText" />
						<span class="label">流程任务ID:</span><input type="text" name="Q_proccessTaskId_SL"  class="inputText" />
						<span class="label">流程执行ID:</span><input type="text" name="Q_processExecutionId_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="htTaskList" id="htTaskItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="taskId" value="${htTaskItem.taskId}">
				</display:column>
				<display:column property="taskName" title="任务名称" sortable="true" sortName="taskName"></display:column>
				<display:column property="taskType" title="任务类型" sortable="true" sortName="taskType"></display:column>
				<display:column property="taskState" title="任务状态" sortable="true" sortName="taskState"></display:column>
				<display:column property="taskAssignee" title="任务执行人" sortable="true" sortName="taskAssignee"></display:column>
				<display:column  title="起始时间" sortable="true" sortName="taskStarttime">
					<fmt:formatDate value="${htTaskItem.taskStarttime}" pattern="yyyy-MM-dd"/>
				</display:column>
				<display:column  title="结束时间" sortable="true" sortName="taskEndtime">
					<fmt:formatDate value="${htTaskItem.taskEndtime}" pattern="yyyy-MM-dd"/>
				</display:column>
				<display:column property="taskDuration" title="持续时间" sortable="true" sortName="taskDuration"></display:column>
				<display:column property="taskLink" title="任务链接" sortable="true" sortName="taskLink" maxLength="80"></display:column>
				<display:column property="taskDescp" title="任务描述" sortable="true" sortName="taskDescp" maxLength="80"></display:column>
				<display:column property="sourceId" title="来源ID" sortable="true" sortName="sourceId"></display:column>
				<display:column property="sourceType" title="来源单据类型" sortable="true" sortName="sourceType"></display:column>
				<display:column property="proccessTaskId" title="流程任务ID" sortable="true" sortName="proccessTaskId"></display:column>
				<display:column property="processExecutionId" title="流程执行ID" sortable="true" sortName="processExecutionId"></display:column>
				<display:column title="管理" media="html" style="width:180px">
					<a href="del.ht?taskId=${htTaskItem.taskId}" class="link del">删除</a>
					<a href="edit.ht?taskId=${htTaskItem.taskId}" class="link edit">编辑</a>
					<a href="get.ht?taskId=${htTaskItem.taskId}" class="link detail">明细</a>
					
				</display:column>
			</display:table>
			<cosim:paging tableId="htTaskItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


