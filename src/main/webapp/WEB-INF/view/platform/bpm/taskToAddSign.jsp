<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>选择补签人员</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
	<script type="text/javascript">
	var taskId="${param.taskId}";
	function selectSignUsers(){
		var uIds=$("#addSignUserIds");
		var uNames=$('#addSignFullnames');
		UserDialog({callback:function(userIds,fullnames){
						uIds.val(userIds);
						uNames.val(fullnames);
					}
		});
	}
	
	function save(){
		 var signUserIds=$("#addSignUserIds").val();
		 var params={taskId:taskId,signUserIds:signUserIds };
		 if(signUserIds=='') return;
   		 $.post(__ctx+'/platform/bpm/task/addSign.ht',params,
       		 function(){
				 $.ligerMessageBox.success('操作成功','你成功进行了补签!',function(){
					//如果打开了弹出窗口
				    	if(window.parent.document.getElementById("dialog-body")){
				    		window.parent.rtn = {};//将要返回的数据赋值给父窗口的rtn变量
				        	window.parent.isDialogHTML5Close = true;//弹出窗口已经关闭
				        	closeDialogHTML5(); 	
				        	return;
				    	}
					 this.window.returnValue={};
					 this.window.close();
				 });
       		 }
   		 );
	}
	
	$(function(){
		$("#dataFormSave").click(save);
	});
	</script>
</head>
<body>


<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">任务补签</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group">
					<a class="link save" id="dataFormSave" href="#">补签</a>
				</div>
				<div class="l-bar-separator"></div>
				<div class="group">
					<a class="link del" href="#" onclick="window.close()">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<div class="panel-detail">
		<table class="table-detail">
			<tr>
				<th nowrap="nowrap">选择补签人员</th>
				<td>
					<input type="hidden" id="addSignUserIds"/>
					<input type="hidden" id="taskId" value="${param.taskId}"/>
					<input type="text" size="60" value="" readonly="readonly" id="addSignFullnames" class="inputText"/> <input type="button" onclick="selectSignUsers()" value="选择.."/>
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>
