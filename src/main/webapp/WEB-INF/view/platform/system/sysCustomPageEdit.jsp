<%--
	time:2012-10-29 12:00:23
	desc:edit the 自定义页面
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 自定义页面</title>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" type="text/css" href="${ctx}/js/ueditor/themes/default/ueditor.css"/>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/page-editor/editor_config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/page-editor/editor_api.js"></script>
	<script type="text/javascript" charset="utf-8" src="${ctx}/js/cosim/platform/system/PageUEditor.js"></script>
	<!-- ueditor -->
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			
			var editor = initEditor();
			
			var frm=$('#sysCustomPageForm').form();
			$("a.save").click(function() {
				var template=editor.getContent();
				if(template.isEmpty()){
					$.ligerMessageBox.warn("页面内容不能为空");
					return false;
				}
				$("#template").val(template);
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
			
		});
		//初始化编辑器
		function initEditor(){
			var pageUEditor=new PageUEditor();
			var editor = pageUEditor.getEditor();
			var template=$('#template').val();
			editor.addListener('ready',function(){
				//设置初始内容
				editor.setContent(template);
			});
			editor.render("pageEditor");	
			return editor;
		}
		
		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
					if(rtn){
						return;
					}else{
						window.opener.location.href = "${ctx}/platform/system/sysCustomPage/list.ht";
						this.close();
					}
				});
			} else {
				$.ligerDialog.err('出错信息',"编辑自定义页面失败",obj.getMessage());
			}
		}
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${sysCustomPage.id !=null}">
			        <span class="tbar-label">编辑自定义页面</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加自定义页面</span>
			    </c:otherwise>			   
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link close" href="#" onclick="window.close()">关闭</a></div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="sysCustomPageForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="10%">名称*: </th>
					<td><input type="text" id="name" name="name" value="${sysCustomPage.name}"  class="inputText" validate="{required:true,maxlength:150}"  /></td>
					<th width="10%">标题*: </th>
					<td><input type="text" id="title" name="title" value="${sysCustomPage.title}"  class="inputText" validate="{required:true,maxlength:600}"  /></td>
					<th width="10%">描述: </th>
					<td><input type="text" id="description" name="description" value="${sysCustomPage.description}"  class="inputText" validate="{required:false}"  /></td>
				</tr>
				<tr>
					<th>内容模板:</th>
					<td colspan="5">
						<div id="pageEditor"></div>
					</td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th width="15%">模板*: </th> -->
<!-- 					<td colspan="3"> -->
<!-- 						<div style="width: 60%;float: left;"> -->
<%-- 							<textarea id="template" name="template" class="inputText" validate="{required:true}"  style="width: 99%;height: 300px">${sysCustomPage.template}</textarea> --%>
<!-- 						</div> -->
<!-- 						<div style="width: 38%; float: right;margin:2px auto; border:1px solid gray;height: 300px;"> -->
<!-- 							<div class="toolBar"> -->
<!-- 								<div class="group"><a id="openPageEditor" class="link show" href="#">打开可视化编辑</a></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</td> -->
<!-- 				</tr> -->
			</table>
			<input type="hidden" id="id" name="id" value="${sysCustomPage.id}" />
			<input type="hidden" id="template" name="template" value="${fn:escapeXml(sysCustomPage.template) }"/>			
		</form>
		
	</div>
</div>
</body>
</html>
