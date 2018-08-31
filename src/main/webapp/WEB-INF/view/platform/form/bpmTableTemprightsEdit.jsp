<%--
	time:2012-05-28 09:04:06
	desc:edit the 查看业务数据模板的权限信息
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 查看业务数据模板的权限信息</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmTableTemprights"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#bpmTableTemprightsForm').submit(); 
			});
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					 <c:choose>
						<c:when test="${bpmTableTemprights.id==null}">
							添加查看业务数据模板的权限信息
						</c:when>
						<c:otherwise>
							编辑查看业务数据模板的权限信息
						</c:otherwise>
					 </c:choose> 	
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				
				<form id="bpmTableTemprightsForm" method="post" action="save.ht">
					<div class="panel-detail">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">模板ID: </th>
							<td><input type="text" id="templateId" name="templateId" value="${bpmTableTemprights.templateId}"  class="inputText"/></td>
						</tr>
						<tr>
							<th width="20%">权限所有者类型: </th>
							<td><input type="text" id="rightType" name="rightType" value="${bpmTableTemprights.rightType}"  class="inputText"/></td>
						</tr>
						<tr>
							<th width="20%">拥有者ID: </th>
							<td><input type="text" id="ownerId" name="ownerId" value="${bpmTableTemprights.ownerId}"  class="inputText"/></td>
						</tr>
						<tr>
							<th width="20%">拥有者名称: </th>
							<td><input type="text" id="ownerName" name="ownerName" value="${bpmTableTemprights.ownerName}"  class="inputText"/></td>
						</tr>
						<tr>
							<th width="20%">权限搜索类型: </th>
							<td><input type="text" id="searchType" name="searchType" value="${bpmTableTemprights.searchType}"  class="inputText"/></td>
						</tr>
					</table>
					<input type="hidden" name="id" value="${bpmTableTemprights.id}" />
					</div>
				</form>
		</div>
</div>
</body>
</html>
