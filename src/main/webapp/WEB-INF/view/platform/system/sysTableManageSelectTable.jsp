<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户</title>
<%@include file="/commons/include/get.jsp"%>

<script type="text/javascript">
		$(function(){
			$('#btnSelect').click(function(){
					if($("#objectListFrame").contents().find("input:[name=objectId]:radio:checked").length == 0){
						$.ligerMessageBox.warn('提示信息','请选择数据表/视图！');
						return false;
					}else{
						var select = $("#objectListFrame").contents().find("input:[name=objectId]:radio:checked");
						var tableName=select.attr("tableName");
						var tableType=select.attr("tableType");
						var retVal={
							tableName:tableName,
							tableType:tableType
						};
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
		<div style="height:555px;">
			<iframe id="objectListFrame" name="objectListFrame" height="100%"
				width="100%" frameborder="0"
				src="${ctx}/platform/system/sysTableManage/selectTableSelector.ht?dsName=${dsName}"></iframe>
		</div>

		<div position="bottom"  class="bottom" style='margin:10px auto'>
			<a class='button' id="btnSelect"><span class="icon ok"></span><span >选择</span></a>
			<a class="button" id="btnClose" style='margin-left:10px;'  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div>
	<!-- end of panel -->
</body>
</html>