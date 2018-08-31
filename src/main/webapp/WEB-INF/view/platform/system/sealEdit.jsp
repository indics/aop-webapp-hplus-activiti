<%--
	time:2012-08-29 11:26:00
	desc:edit the 电子印章
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 电子印章</title>
	<%@include file="/commons/include/form.jsp" %>
	<%@include file="/js/msg.jsp"%>
	
	<c:set var="fullpath" value="E:/workspace/bpm/src/main/webapp" />
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/ntkosign/NtkoSignManage.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/FlexUploadDialog.js"></script>
	<style type="text/css">
		.displaynone{
			display:none;
		}
	</style>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			
			$('body').addClass('displaynone');
			var ntkoSignManage=new NtkoSignManage();
			var attachmentId='${seal.attachmentId}';
			ntkoSignManage.load('divSeal',attachmentId);
			var ntkoSignObj=ntkoSignManage.getntkoSignObject();
			
			if(!attachmentId.isEmpty()){
				$('#sealPassword').val(ntkoSignObj.Password);
				$('#sealPasswordConform').val(ntkoSignObj.Password);
			}
			
// 			var ntkoSignObject=ntkoSignManage.getntkoSignObject();
			var fmt=$('#sealForm').form();
// 			function showRequest(formData, jqForm, options) { 
// 				return true;
// 			} 


			
			$("a.add").click(function(){
				var retval = ntkoSignManage.newSign();
				var ntkoSignObj=ntkoSignManage.getntkoSignObject();
				if(retval!=-1){
					$('#sealName').val(ntkoSignObj.SignName);
					$('#belongName').val(ntkoSignObj.SignUser);
					$('#sealPassword').val(ntkoSignObj.Password);
					$('#sealPasswordConform').val(ntkoSignObj.Password);
				}
			});
			
			$("a.save").click(function() {
				var rtn=fmt.valid();
				if(!rtn){
					return false;
				}
				var ntkoSignObj=ntkoSignManage.getntkoSignObject();
				ntkoSignObj.SignName = $("#sealName").val();
				ntkoSignObj.SignUser = $("#belongName").val();
				ntkoSignObj.Password = $("#sealPassword").val();
				
				var result = ntkoSignManage.saveSign();
				if(result){
					$('#attachmentId').val(result);
					var url="save.ht";
					var form = $("#sealForm");
					form.ajaxForm(options);
					form.submit();
				}else{
					$.ligerDialog.error("印章上传到服务器出错");
					return false;
				}
			});
			
			$('body').removeClass('displaynone');
		});
		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerDialog.confirm( obj.getMessage()+",是否继续操作", "提示信息", function(rtn) {
					if(rtn){
					}else{
						window.returnValue=true;
						this.close();
					}
					if(!rtn){
						window.returnValue=true;
						location.href='list.ht';
					}
					else{
						location.reload();
					}
				});
			} else {
				$.ligerDialog.err('出错信息',"添加印章失败",obj.getMessage());
			}
		}
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top" >
			<div class="tbar-title">
				<span class="tbar-label">编辑电子印章</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
					<div class="group"><a class="link add" >新建</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sealForm" method="post" action="save.ht">
					
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th>印章：</th>
								<td><div id="divSeal"></div></td>
							<tr>
								<th width="20%">印章名称:  <span class="required">*</span></th>
								<td><input type="text" id="sealName" name="sealName" validate="{required:true,maxlength:50}" value="${seal.sealName}" tipId="sealNameError" class="inputText"/><span id="sealNameError"></span></td>
							</tr>
							<tr>
								<th width="20%">印章所属单位或个人:  <span class="required">*</span></th>
								<td><input type="text" id="belongName" name="belongName" value="${seal.belongName}"  validate="{required:true,maxlength:50}" tipId="belongNameError" class="inputText"/><span id="belongNameError"></span></td>
							</tr>
							<tr>
								<th width="20%">印章口令:  <span class="required">*</span></th>
								<td><input type="password" id="sealPassword" name="sealPassword"  validate="{required:true,minlength:6,maxlength:30}" tipId="sealPasswordError" class="inputText"/><span id="sealPasswordError"></span></td>
							</tr>			<tr>
								<th width="20%">印章口令确认:  <span class="required">*</span></th>
								<td><input type="password" id="sealPasswordConform" name="sealPasswordConform" validate="{equalTo:'sealPassword'}" tipId="sealPasswordConformError" class="inputText"/><span id="sealPasswordConformError"></span></td>
							</tr>
						</table>
						<!-- Hidden filed -->
						<input type="hidden" id="belongId" name="belongId" value="${seal.belongId}"/>
						<input type="hidden" id="sealId" name="sealId" value="${seal.sealId}"/>
						<input type="hidden" id="attachmentId" name="attachmentId" value="${seal.attachmentId}"/>
				
				</form> 
		</div>
</div>
</body>
</html>
