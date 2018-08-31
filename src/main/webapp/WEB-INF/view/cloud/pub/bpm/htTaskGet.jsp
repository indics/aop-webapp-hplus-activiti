
<%--
	time:2015-04-09 14:56:11
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>ht_task明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">ht_task详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link back" href="list.ht">返回</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			 
			<tr>
				<th width="20%">任务名称:</th>
				<td>${htTask.taskName}</td>
			</tr>
 
			<tr>
				<th width="20%">任务类型:</th>
				<td>${htTask.taskType}</td>
			</tr>
 
			<tr>
				<th width="20%">任务状态:</th>
				<td>${htTask.taskState}</td>
			</tr>
 
			<tr>
				<th width="20%">任务执行人:</th>
				<td>${htTask.taskAssignee}</td>
			</tr>
 
			<tr>
				<th width="20%">起始时间:</th>
				<td>
				<fmt:formatDate value="${htTask.taskStarttime}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
 
			<tr>
				<th width="20%">结束时间:</th>
				<td>
				<fmt:formatDate value="${htTask.taskEndtime}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
 
			<tr>
				<th width="20%">持续时间:</th>
				<td>${htTask.taskDuration}</td>
			</tr>
 
			<tr>
				<th width="20%">任务链接:</th>
				<td>${htTask.taskLink}</td>
			</tr>
 
			<tr>
				<th width="20%">任务描述:</th>
				<td>${htTask.taskDescp}</td>
			</tr>
 
			<tr>
				<th width="20%">来源ID:</th>
				<td>${htTask.sourceId}</td>
			</tr>
 
			<tr>
				<th width="20%">来源单据类型:</th>
				<td>${htTask.sourceType}</td>
			</tr>
 
			<tr>
				<th width="20%">流程任务ID:</th>
				<td>${htTask.proccessTaskId}</td>
			</tr>
 
			<tr>
				<th width="20%">流程执行ID:</th>
				<td>${htTask.processExecutionId}</td>
			</tr>
		</table>
		</div>
		
	</div>
</body>
</html>

