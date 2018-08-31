<%--
	time:2011-12-28 14:04:30
	desc:edit the 模版管理
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>编辑模版管理</title>
<%@include file="/commons/include/form.jsp"%>
<script type="text/javascript"
	src="${ctx}/servlet/ValidJs?form=sysTemplate"></script>
<script type="text/javascript"
	src="${ctx }/js/cosim/platform/system/SysDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript"
	src="${ctx}/js/ckeditor/ckeditor_sysTemp.js"></script>
<script type="text/javascript">
	    $(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			editor=ckeditor('content');
			if(${sysTemplate.templateId ==null }){
				valid(showRequest,showResponse,1);
			}else{
				valid(showRequest,showResponse);
			}
			$("a.save").click(function() {
				$('#content').val(editor.getData());
				$('#sysTemplateForm').submit(); 
			});					
		});
	</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<c:choose>
					<c:when test="${sysTemplate.templateId !=null }">
						<span class="tbar-label">编辑模版管理</span>
					</c:when>
					<c:otherwise>
						<span class="tbar-label">添加模版管理</span>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link save" id="dataFormSave" href="#">保存</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link back" href="list.ht">返回</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">

			<form id="sysTemplateForm" method="post" action="save.ht">
				<table class="table-detail" cellpadding="0" cellspacing="0"
					border="0">
					<tr>
						<th width="16%">类型:</th>
						<td><input type="radio" name="templateType" value="1"
							<c:if test='${sysTemplate.templateType==1||sysTemplate.templateType==null}'>checked</c:if> />手机短信
							<input type="radio" name="templateType" value="2"
							<c:if test='${sysTemplate.templateType==2}'>checked</c:if> />邮件 <input
							type="radio" name="templateType" value="3"
							<c:if test='${sysTemplate.templateType==3}'>checked</c:if> />站内消息

						
					</tr>
					<tr>
						<th>模版名称:</th>
						<td><input type="text" id="name" name="name"
							value="${sysTemplate.name}" class="inputText"
							style="width: 500px !important" /></td>
					</tr>
					<tr>
						<th>模版内容:</th>
						<td><textarea id="content" name="content">${fn:escapeXml(sysTemplate.content)}</textarea>
						</td>
					</tr>
				</table>
				<input type="hidden" name="templateId"
					value="${sysTemplate.templateId}" />
			</form>

		</div>
	</div>
</body>
</html>
