<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择自定义表</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript">
	function getTable(tableId,tableName){
		var obj={tableId:tableId,tableName:tableName};
		//如果打开了弹出窗口
    	if(window.parent.document.getElementById("dialog-body")){
    		window.parent.rtn = obj;//将要返回的数据赋值给父窗口的rtn变量
        	window.parent.isDialogHTML5Close = true;//弹出窗口已经关闭
        	closeDialogHTML5(); 	
        	return;
    	}
		window.returnValue=obj;
		window.close();
	}
</script>
<style type="text/css">
	div.bottom{text-align: center;padding-top: 10px;}
	html,body{width:100%;height:100%;margin: 0 0 0 0;padding: 0 0 0 0 ;overflow: hidden;}
</style>
</head>
<body>
	<iframe src="dialog.ht" width="100%" height="100%" frameborder="0"></iframe>
</body>
</html>


