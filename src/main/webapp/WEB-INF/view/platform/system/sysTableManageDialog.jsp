<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>SYS_CUSTOM_DISPLAY管理</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript">
	$(function(){
		$('#btnSelect').click(function(){
			var isiframe= window.dialogArguments.isiframe;
			if($("#sysTableManageListFrame").contents().find("input:[name=id]:radio:checked").length == 0){
				$.ligerMessageBox.warn('提示信息','请选择一个显示组件！');
				return false;
			}else{
				var selectEl= $("#sysTableManageListFrame").contents().find("input:[name=id]:radio:checked");
				var id=selectEl.val();
				var name=selectEl.attr('tableManageName');
				window.returnValue={
					status:true,
					id:id,
					name:name
				};
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
				<span class="tbar-label">自定义显示选择</span>
			</div>
		</div>
		<div style="height:500px;">
			<iframe id="sysTableManageListFrame" name="sysTableManageListFrame" height="90%"
				width="100%" frameborder="0"
				src="${ctx}/platform/system/sysTableManage/selector.ht"></iframe>
		</div>

		<div position="bottom"  class="bottom" style='margin-top:10px'>
			<a class='button' id="btnSelect"><span class="icon ok"></span><span >选择</span></a>
			<a class="button" id="btnClose" style='margin-left:10px;'  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div>
	<!-- end of panel -->
</body>
</html>


