<%--
	time:2014-03-19 14:36:49
	desc:edit the cloud_saas_form
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 cloud_saas_form</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#saasRoleForm').form();
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
						window.location.href = "${ctx}/cloud/saas/role/listByTenant.ht";
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
			    <c:when test="${saasRole.saasRoleId !=null}">
			        <span class="tbar-label">编辑角色</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加角色</span>
			    </c:otherwise>			   
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back" href="listByTenant.ht">返回</a></div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="saasRoleForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="20%">角色名: </th>
					<td><input type="text" id="roleName" name="roleName" value="${saasRole.roleName}"  class="inputText" validate="{required:true,maxlength:25}"  /></td>
				</tr>
				<tr>
					<th width="20%">角色别名: </th>
					<td><input type="text" id="roleAlias" name="roleAlias" value="${saasRole.roleAlias}"  class="inputText" validate="{required:true,maxlength:25}"  />一般以cloud_role开头</td>
				</tr>
				<tr>
					<th width="20%">备注: </th>
					<td><input type="text" id="memo" name="memo" value="${saasRole.memo}"  class="inputText" validate="{required:false,maxlength:25}"  /></td>
				</tr>
			</table>
			<input type="hidden" name="saasRoleId" value="${saasRole.saasRoleId}" />
		</form>
		
	</div>
</div>
</body>
</html>
