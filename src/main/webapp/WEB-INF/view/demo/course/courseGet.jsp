
<%--
	time:2016-05-20 11:59:20
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>cloud_course明细</title>
<%@include file="/commons/include/form.jsp" %>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">cloud_course详细信息</span>
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
				<th width="20%">year:</th>
				<td>${course.year}</td>
			</tr>
 
			<tr>
				<th width="20%">term:</th>
				<td>${course.term}</td>
			</tr>
 
			<tr>
				<th width="20%">create_user:</th>
				<td>${course.createUser}</td>
			</tr>
 
			<tr>
				<th width="20%">create_time:</th>
				<td>
				<fmt:formatDate value="${course.createTime}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
 
			<tr>
				<th width="20%">task_id:</th>
				<td>${course.taskId}</td>
			</tr>
 
			<tr>
				<th width="20%">run_id:</th>
				<td>${course.runId}</td>
			</tr>
 
			<tr>
				<th width="20%">run_state:</th>
				<td>${course.runState}</td>
			</tr>
		</table>
		<table class="table-grid table-list" cellpadding="1" cellspacing="1">
			<tr>
				<td colspan="2" style="text-align: center">cloud_course_item :cloud_course_item</td>
			</tr>
			<tr>
				<th>course_name</th>
				<th>course_teacher</th>
			</tr>	
			<c:forEach items="${courseItemList}" var="courseItemItem" varStatus="status">
				<tr>
						<input type="hidden" id="id" name="id" value="${courseItemItem.id}"  class="inputText"/>
						<td style="text-align: center">${courseItemItem.courseName}</td>								
						<td style="text-align: center">${courseItemItem.courseTeacher}</td>								
				</tr>
			</c:forEach>
		</table>
		</div>
		
	</div>
</body>
</html>

