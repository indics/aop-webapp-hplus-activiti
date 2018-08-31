
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
					if($("#compListFrame").contents().find("input:[name='sysOrgInfoId']:checkbox:checked").length == 0){
						$.ligerMessageBox.warn('提示信息','请选择至少一个企业！');
						return false;
					}else{
						var ids=[];
						var names=[];
						var fileId = $("#compListFrame").contents().find("input:[name='sysOrgInfoId']:checkbox:checked").each(function(){
							var id= $(this).val();
							var name= $(this).attr("name");
							ids.put(id);
							name.put(name);
						});
						var retVal={
								status:1,
								ids:ids,
								names:names
						};
						window.returnValue=retVal;
						window.close();
					}
			});
			
			$('#btnClose').click(function(){
				var retVal={
						status:-1
				};
				window.returnValue=retVal;
				window.close();
			});
		});
	</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业列表</span>
			</div>
		</div>
		<div style="height:500px;">
			<iframe id="compListFrame" name="compListFrame" height="90%"
				width="100%" frameborder="0"
				src="${ctx}/platform/system/sysOrg/compSelector.ht"></iframe>
		</div>

		<div position="bottom"  class="bottom" style='margin-top:10px'>
			<a class='button' id="btnSelect"><span class="icon ok"></span><span >选择</span></a>
			<a class="button" id="btnClose" style='margin-left:10px;'  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div>
	<!-- end of panel -->
</body>
</html>


