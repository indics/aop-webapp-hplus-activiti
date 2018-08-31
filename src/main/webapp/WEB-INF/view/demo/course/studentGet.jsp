
<%--
	time:2016-08-25 15:01:21
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>demo_student明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">demo_student详细信息</span>
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
				<th width="20%">姓名:</th>
				<td>${student.name}</td>
			</tr>
 
			<tr>
				<th width="20%">性别:</th>
				<td>${student.sex}</td>
			</tr>
 
			<tr>
				<th width="20%">爱好:</th>
				<td>${student.honor}</td>
			</tr>
 
			<tr>
				<th width="20%">创建时间:</th>
				<td>
				<fmt:formatDate value="${student.createTime}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
 
			<tr>
				<th width="20%">创建用户:</th>
				<td>${student.createUser}</td>
			</tr>
		</table>
		<table class="table-grid table-list" cellpadding="1" cellspacing="1">
			<tr>
				<td colspan="2" style="text-align: center">demo_student_item :demo_student_item</td>
			</tr>
			<tr>
				<th>课程ID</th>
				<th>说明</th>
			</tr>	
			<c:forEach items="${studentItemList}" var="studentItemItem" varStatus="status">
				<tr>
						<input type="hidden" id="itemId" name="itemId" value="${studentItemItem.itemId}"  class="inputText"/>
						<td style="text-align: center">${studentItemItem.courseId}</td>								
						<td style="text-align: center">${studentItemItem.remark}</td>								
				</tr>
			</c:forEach>
		</table>
		</div>
		
	</div>
</body>
</html>

