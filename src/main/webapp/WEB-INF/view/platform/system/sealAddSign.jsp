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
	
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/ntkosign/NtkoSignManage.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
	
	<style type="text/css">
		.displaynone{
			display:none;
		}
	</style>
	<script type="text/javascript">
		$(function() {
			eventBind();
		});
		
		//事件绑定
		function eventBind(){
			//Ok Button
			$("#btnSelect").click(function(){
				var fileObj = document.getElementById('filename');
				fileObj.select();
 				var realpath = document.selection.createRange().text;
				var frm=$('#signForm').form();
				if(frm.valid()){
					var filename=realpath;
					var signname=$("#signname").val();
					var username=$("#username").val();
					var password=$("#password").val();
					var rtn={
							status:true,
							filename:filename,
							signname:signname,
							username:username,
							password:password
						};
						window.returnValue=rtn;
						window.close();
				}
			});
			
			$("#filename").bind("change",function(){
				var sUrl = $(this).val();
				if(!sUrl){
					return false;
				}
				var Extlist = ".jpg.jpeg.bmp.png.";	
				if(Extlist.indexOf('.'+getExt(sUrl)+'.')==-1){
					$.ligerMessageBox.warn("提示信息", "请选择有效图片");
					$("#filename").replaceWith( $(this).clone( true ));
				}
			});
		}
		
		function getExt(sUrl)
		{
	        var arrList = sUrl.split(".");
	        return arrList[arrList.length-1];
		}
		
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top" >
			<div class="tbar-title">
				<span class="tbar-label">编辑电子印章</span>
			</div>
		</div>
		<div class="panel-body">
			<form id="signForm" method="post" action="save.ht">
				<table class="table-detail">
					<tr>
						<th>图片：</th>
						<td>
							<input id="filename" name="filename" type="file" validate="{required:true}"  class="inputText">
							<span class="green">支持图片格式类型：jpg、jpeg、bmp、png</span>
						</td>
					</tr>
					<tr>
						<th>印章名：</th>
						<td><input id="signname" name="signname" type="text" validate="{required:true,maxlength:100}" class="inputText" /></td>
					</tr>
					<tr>
						<th>印章所属单位或个人：</th>
						<td>
							<input id="username" name="username" type="text" validate="{required:true,maxlength:50}" class="inputText" />
						</td>
					</tr>
					<tr>
						<th>密码：</th>
						<td>
							<input id="password" name="password" type="password" validate="{required:true,minlength:6,maxlength:32}"  class="inputText"/>
							<span class="green">长度至少六位</span>
						</td>
					</tr>
					<tr>
						<th>确认密码：</th>
						<td><input id="passwordConfirm" name="passwordConfirm" type="password" validate="{required:true,equalTo:'password'}"   class="inputText"/></td>
					</tr>
				</table>
			</form>
		</div>
		<div position="bottom"  class="bottom" style='margin-top:10px'>
			<a class='button' id="btnSelect"><span class="icon ok"></span><span >确定</span></a>
			<a class="button" id="btnClose" style='margin-left:10px;'  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div>
</body>
</html>
