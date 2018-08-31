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
			var frm=$('#saasFormForm').form();
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
						window.location.href = "${ctx}/cloud/form/saasForm/list.ht";
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
			    <c:when test="${saasForm.id !=null}">
			        <span class="tbar-label">编辑cloud_saas_form</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加cloud_saas_form</span>
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
		<form id="saasFormForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="20%">公司Id: </th>
					<td><input type="text" id="companyid" name="companyid" value="${saasForm.companyid}"  class="inputText" validate="{required:false,number:true }"  /></td>
				</tr>
				<tr>
					<th width="20%">源Url: </th>
					<td><input type="text" id="srcurl" name="srcurl" value="${saasForm.srcurl}"  class="inputText" validate="{required:false,maxlength:600}"  /></td>
				</tr>
				<tr>
					<th width="20%">转化Url: </th>
					<td><input type="text" id="transferurl" name="transferurl" value="${saasForm.transferurl}"  class="inputText" validate="{required:false,maxlength:600}"  /></td>
				</tr>
				<tr>
					<th width="20%">状态: </th>
					<td><input type="text" id="state" name="state" value="${saasForm.state}"  class="inputText" validate="{required:false,maxlength:60}"  /></td>
				</tr>
			</table>
			<input type="hidden" name="id" value="${saasForm.id}" />
		</form>
		
	</div>
</div>
</body>
</html>
