<%--
	time:2012-12-19 15:38:01
	desc:edit the 自定义表代码模版
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>编辑 自定义表代码模版</title>
<%@include file="/commons/include/form.jsp"%>
<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
<script type="text/javascript">
	$(function() {
		var options = {};
		if (showResponse) {
			options.success = showResponse;
		}
		var frm = $('#sysCodeTemplateForm').form();
		$("a.save").click(function() {
			frm.ajaxForm(options);
			if (frm.valid()) {
				$('#sysCodeTemplateForm').submit();
			}
		});
	});

	function showResponse(responseText) {
		var obj = new com.cosim.form.ResultMessage(responseText);
		if (obj.isSuccess()) {
			$.ligerMessageBox
					.confirm(
							"提示信息",
							obj.getMessage() + ",是否继续操作",
							function(rtn) {
								if (rtn) {
									this.close();
									$("#sysCodeTemplateForm").resetForm();
								} else {
									window.location.href = "${ctx}/platform/system/sysCodeTemplate/list.ht";

								}
							});
		} else {
			$.ligerMessageBox.error("提示信息", obj.getMessage());
		}
	}

	function changeMacro(obj) {
		var isCheck = $(obj).attr('checked');
		if (isCheck) {
			$("#fileName").closest('tr').hide();
			$("#fileDir").closest('tr').hide();
		} else {
			$("#fileName").closest('tr').show();
			$("#fileDir").closest('tr').show();
		}
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<c:choose>
					<c:when test="${sysCodeTemplate.id !=null}">
						<span class="tbar-label">编辑自定义表代码模版</span>
					</c:when>
					<c:otherwise>
						<span class="tbar-label">添加自定义表代码模版</span>
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
			<form id="sysCodeTemplateForm" method="post" action="save.ht">
				<table class="table-detail" cellpadding="0" cellspacing="0"
					border="0" type="main">
					<tr>
						<th width="20%">模版名称:</th>
						<td><input type="text" id="templateName" name="templateName"
							value="${sysCodeTemplate.templateName}" class="inputText"
							validate="{required:true,maxlength:200}" /></td>
					</tr>
					<tr>
						<th width="20%">别名:</th>
						<td><input type="text" id="templateAlias"
							name="templateAlias" value="${sysCodeTemplate.templateAlias}"
							class="inputText" validate="{required:true,maxlength:200}" /></td>
					</tr>
					<tr>
						<th width="20%">备注:</th>
						<td><input type="text" id="memo" name="memo"
							value="${sysCodeTemplate.memo}" class="inputText"
							validate="{required:false,maxlength:200}" /></td>
					</tr>
					<tr>
						<th width="20%">是否为宏模版:</th>
						<td><c:choose>
								<c:when test="${sysCodeTemplate.templateType==1}">
									<c:choose>
										<c:when test="${sysCodeTemplate.isMacro==1}">是</c:when>
										<c:otherwise>否</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<input type="checkbox" onclick="changeMacro(this);"
										name="isMacro" value="${sysCodeTemplate.isMacro}"
										class="inputText" validate="{required:false,maxlength:200}"
										<c:if test="${sysCodeTemplate.isMacro==1}">checked="checked"</c:if> />
								</c:otherwise>
							</c:choose></td>
					</tr>

					<tr
						<c:if test="${sysCodeTemplate.isMacro==1}">style="display: none;"</c:if>>
						<th width="20%">模版生成的文件名:</th>
						<td><input type="text" id="fileName" name="fileName"
							value="${sysCodeTemplate.fileName}" class="inputText"
							style="width: 150px;" validate="{required:false,maxlength:200}" /></td>
					</tr>
					<tr
						<c:if test="${sysCodeTemplate.isMacro==1}">style="display: none;"</c:if>>
						<th width="20%">模版对应的文件路径:</th>
						<td><input type="text" id="fileDir" name="fileDir"
							value="${sysCodeTemplate.fileDir}" class="inputText"
							style="width: 230px;" validate="{required:false,maxlength:400}" /></td>
					</tr>

					<tr>
						<th width="20%">模版HTML:</th>
						<td><textarea name="html" cols="120" rows="20">${fn:escapeXml(sysCodeTemplate.html)}</textarea>
						</td>
					</tr>
				</table>
				<input type="hidden" name="id" value="${sysCodeTemplate.id}" />
			</form>

		</div>
	</div>
</body>
</html>
