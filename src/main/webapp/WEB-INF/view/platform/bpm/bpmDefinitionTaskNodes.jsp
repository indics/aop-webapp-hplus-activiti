<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<%@include file="/commons/include/form.jsp" %>
	<title>选择流程任务列表</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<link href="${ctx}/styles/ligerUI/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript">
		//选择任务节点
		function selectTaskNode(){
			var nodeIdRd=$('.nodeId:checked');
			if(nodeIdRd){
				//如果打开了弹出窗口
		    	if(window.parent.document.getElementById("dialog-body")){
		    		window.parent.rtn = {nodeId:nodeIdRd.val(),nodeName:nodeIdRd.attr('nodeName')};//将要返回的数据赋值给父窗口的rtn变量
		    	}else{
		    		window.returnValue={nodeId:nodeIdRd.val(),nodeName:nodeIdRd.attr('nodeName')};	
		    	}
				
			}else{
				//如果打开了弹出窗口
		    	if(window.parent.document.getElementById("dialog-body")){
		    		window.parent.rtn = {nodeId:'',nodeName:''};//将要返回的数据赋值给父窗口的rtn变量
		    	}else{
					window.returnValue={nodeId:'',nodeName:''};
		    	}
			}
			if(window.parent.document.getElementById("dialog-body")){
				window.parent.isDialogHTML5Close = true;//弹出窗口已经关闭
	        	closeDialogHTML5(); 	
	        	return;
			}
			window.close();
		}
	</script>
</head>
<body>
	<h2>选择任务节点</h2>
	<table cellpadding="1" cellspacing="1"  class="table-grid">
		<thead>
			<tr>
				<th width="120">
					序号
				</th>
				<th>
					节点名称
				</th>
			</tr>
		</thead>
		<c:forEach items="${taskNodeMap}" var="map" varStatus="i">
			<tr>
				<td>
					<span>${i.count}</span>
					<input type="radio" class="nodeId" name="nodeId" value="${map.key}" nodeName="${map.value}"/>
				</td>
				<td>
					${map.value}
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="bottom" style='margin-top:10px;'>
		<a href='#' class='button' onclick="selectTaskNode()"><span >选择</span></a>
		<a href='#' class='button' style='margin-left:10px;' onclick="window.close()"><span >取消</span></a>
	</div>
</body>
</html>
