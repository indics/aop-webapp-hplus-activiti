
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>电子印章管理</title>
<%@include file="/commons/include/get.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/ntkosign/NtkoSignManage.js"></script>
<script type="text/javascript">
		$(function(){
			var ntkoSignManage=new NtkoSignManage();
			$('#btnSelect').click(function(){
					if($("#sealListFrame").contents().find("input:[name=attachmentId]:radio:checked").length == 0){
						$.ligerMessageBox.warn('提示信息','请选择一个印章！');
						return false;
					}else{
						var fileId = $("#sealListFrame").contents().find("input:[name=attachmentId]:radio:checked").val();
						var retVal=$.parseJSON("{}");
						retVal.userName='${user.fullname}';
						retVal.fileId=fileId;
						window.returnValue=retVal;
						window.close();
					}
				
			});
			
			$('#btnClose').click(function(){
				window.close();
			});
		});
	</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">电子印章管理列表</span>
			</div>
		</div>
		<div style="height:500px;">
			<iframe id="sealListFrame" name="sealListFrame" height="90%"
				width="100%" frameborder="0"
				src="${ctx}/platform/system/seal/selector.ht"></iframe>
		</div>

		<div position="bottom"  class="bottom" style='margin-top:10px'>
			<a class='button' id="btnSelect"><span class="icon ok"></span><span >选择</span></a>
			<a class="button" id="btnClose" style='margin-left:10px;'  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div>
	<!-- end of panel -->
</body>
</html>


