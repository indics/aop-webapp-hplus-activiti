<%--
	time:2013-01-16 10:13:31
	desc:edit the 子表权限
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 子表权限</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#BpmSubtableRightsForm').form();
			$("a.save").click(function() {
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
		});
		
		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
					if(rtn){
						this.close();
					}else{
						window.location.href = "${ctx}/platform/bpm/BpmSubtableRights/list.ht";
					}
				});
			} else {
				$.ligerMessageBox.error("提示信息",obj.getMessage());
			}
		}
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${BpmSubtableRights.id !=null}">
			        <span class="tbar-label">编辑子表权限</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加子表权限</span>
			    </c:otherwise>			   
		    </c:choose>
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
		<form id="BpmSubtableRightsForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="20%">流程定义ID: </th>
					<td><input type="text" id="defid" name="defid" value="${BpmSubtableRights.defid}"  class="inputText" validate="{required:false,maxlength:22,number:true }"  /></td>
				</tr>
				<tr>
					<th width="20%">节点ID: </th>
					<td><input type="text" id="nodeid" name="nodeid" value="${BpmSubtableRights.nodeid}"  class="inputText" validate="{required:false,maxlength:50}"  /></td>
				</tr>
				<tr>
					<th width="20%">子表表ID: </th>
					<td><input type="text" id="tableid" name="tableid" value="${BpmSubtableRights.tableid}"  class="inputText" validate="{required:false,maxlength:22,number:true }"  /></td>
				</tr>
				<tr>
					<th width="20%">权限类型(1,简单配置,2,脚本): </th>
					<td><input type="text" id="permissiontype" name="permissiontype" value="${BpmSubtableRights.permissiontype}"  class="inputText" validate="{required:false,maxlength:22,number:true }"  /></td>
				</tr>
				<tr>
					<th width="20%">权限配置: </th>
					<td><input type="text" id="permissionseting" name="permissionseting" value="${BpmSubtableRights.permissionseting}"  class="inputText" validate="{required:false}"  /></td>
				</tr>
			</table>
			<input type="hidden" name="id" value="${BpmSubtableRights.id}" />					
		</form>
		
	</div>
</div>
</body>
</html>
