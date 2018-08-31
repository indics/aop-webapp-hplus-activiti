<%--
	time:2012-11-27 11:26:00
	desc:编辑表数据记录
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 表数据</title>
	<%@include file="/commons/include/form.jsp" %>
	<%@include file="/js/msg.jsp"%>
	<style type="text/css">
	</style>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			$("a.save").click(function() {
				$('#dataForm').ajaxForm(options);
				$('#dataForm').submit();
			});
			
		
		});
		
		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
					if(rtn){
					}else{
						window.close();
					}
				});
			} else {
				$.ligerDialog.err('出错信息',"保存表数据失败",obj.getMessage());
			}
		}

	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top" >
			<div class="tbar-title">
				<span class="tbar-label">编辑表数据</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link cancel" onclick="window.close()">取消</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<form id="dataForm" method="post" action="saveData.ht">
				<table class="table-detail">
					<tr>
						<th>列名</th>
						<th>列值</th>
						<th>类型</th>
					</tr>
					<c:forEach items="${displayColumns}" var="column">
						<tr>
							<th>${column.comment}</th>
							<td>
								<c:choose>
									<c:when test="${fn:toUpperCase(column.columnType)=='DATE'}">
										<input name="${column.name}"  value="${dataMap[column.name]}" <c:if test="${column.isPk}">readonly="readonly"</c:if> class="datetime inputText"/>
									</c:when>
									<c:when test="${fn:toUpperCase(column.columnType)=='CLOB'}">
										<textarea rows="10" name="${column.name}" <c:if test="${column.isPk}">readonly="readonly"</c:if> class="inputText">${dataMap[column.name]}</textarea>
									</c:when>
									<c:otherwise>
										<input name="${column.name}"  value="${dataMap[column.name]}" <c:if test="${column.isPk}">readonly="readonly"</c:if> class="inputText"/>
									</c:otherwise>
								</c:choose>
							</td>
							<th>${fn:toUpperCase(column.columnType)}</th>
						</tr>
					</c:forEach>
				</table>
				<input type="hidden" name="sysTableManageId" value="${sysTableManageId}"/>
				<c:forEach items="${pkColumns}" var="column">
					<input type="hidden" name="__pk__${column.name }" value="${dataMap[column.name]}"/>
				</c:forEach>
			</form> 
		</div>
</div>
</body>
</html>
