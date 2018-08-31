<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cosim.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>用户表管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerWindow.js" ></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
	<script type="text/javascript">
		var mockParams;
		$(function(){
			mockParams = window.dialogArguments;
			console.dir(mockParams);
			//初始化
			if(mockParams.startUser.need){
				var suTr = $("<tr></tr>");
				suTr.append("<td>流程发起人:</td>");
				var	inputHtml = 
					'<input id="startUser" readonly="readonly" value="'+ mockParams.startUser.name +'" userId="'+ mockParams.startUser.id +'"/>'+ 
					'<a class="button" onclick="selectUser(this,1)">'+
						'<span>选择</span>'+
					'</a>';
				suTr.append($("<td></td>").html(inputHtml));
				
				$("#mockParams tbody").append(suTr);
			}
			if(mockParams.prevUser.need){
				var puTr = $("<tr></tr>");
				puTr.append("<td>前一执行人:</td>");
				var	inputHtml = 
					'<input id="prevExecUser" readonly="readonly"  value="'+ mockParams.prevUser.name +'" userId="'+ mockParams.prevUser.id +'"/>'+ 
					'<a class="button" onclick="selectUser(this,2)">'+
						'<span>选择</span>'+
					'</a>';
				puTr.append($("<td></td>").html(inputHtml));
				$("#mockParams tbody").append(puTr);
			}
			
			for(var i=0;i<mockParams.nodeUsers.length;i++){
				var user = mockParams.nodeUsers[i];
				if(user.need){
					var nuTr = $("<tr></tr>");
					nuTr.append("<td>"+user.nname+":</td>");
					var	inputHtml = '<input id="'+user.nid+'" readonly="readonly"  value="'+ user.name +'" userId="'+ user.id +'"/>'+ 
					'<a class="button" onclick="selectUser(this,3)">'+
						'<span>选择</span>'+
					'</a>';
					nuTr.append($("<td></td>").html(inputHtml));
					$("#mockParams tbody").append(nuTr);
				}
			}
			
		});
		function selectUser(obj,type){
			var id="";
			var name="";
			if(type==1){
				id = $("#startUser").attr("userId");
				name = $("#startUser").val();
			}else if(type==2){
				id = $("#prevExecUser").attr("userId");
				name = $("#prevExecUser").val();
			}else if(type==3){
				var nodeUsr = $(obj).closest("tr").find("input");
				id = nodeUsr.attr("userId");
				name = nodeUsr.val();
			}
			
			var selectUsers={id:id,name:name};
			
			UserDialog({
				isSingle:true,
				selectUsers:selectUsers,
				callback:function(userId,fullname,email,mobile){
					if(type==1){
						$("#startUser").attr("userId",userId);
						$("#startUser").val(fullname);
						mockParams.startUser.id=userId;
						mockParams.startUser.name=fullname;
					}else if(type==2){
						$("#prevExecUser").attr("userId",userId);
						$("#prevExecUser").val(fullname);
						mockParams.prevUser.id=userId;
						mockParams.prevUser.name=fullname;
					}else if(type==3){
						var nodeUsr = $(obj).closest("tr").find("input");
						nodeUsr.attr("userId",userId);
						nodeUsr.val(fullname);
						var nid = nodeUsr.attr("id");
						for(var i=0;i<mockParams.nodeUsers.length;i++){
							if(mockParams.nodeUsers[i].nid==nid){
								mockParams.nodeUsers[i].id=userId;
								mockParams.nodeUsers[i].name=fullname;
								break;
							}
						}
					}
				}
			});
		};
		
		function clickCancel(){
			//如果打开了弹出窗口
	    	if(window.parent.document.getElementById("dialog-body")){
	    		window.parent.rtn = mockParams.status=1;//将要返回的数据赋值给父窗口的rtn变量
	        	window.parent.isDialogHTML5Close = true;//弹出窗口已经关闭
	        	closeDialogHTML5(); 	
	        	return;
	    	}
			window.returnValue=mockParams.status=1;
			window.close();
		};
		
		function clickOk(){
			var flag=false;
			$("#mockParams tbody tr").each(function(){
				var ele=$(this);
				if(ele.is(":visible")){
					var val = ele.find("input").val();
					if(!val){
						flag=true;
						return false;
					}
				}
			});
			
			if(flag){
				$.ligerMessageBox.error("错误提示","所有参数必须有值！");
				return;
			}
			mockParams.status=0;
			//如果打开了弹出窗口
	    	if(window.parent.document.getElementById("dialog-body")){
	    		window.parent.rtn = mockParams;//将要返回的数据赋值给父窗口的rtn变量
	        	window.parent.isDialogHTML5Close = true;//弹出窗口已经关闭
	        	closeDialogHTML5(); 	
	        	return;
	    	}
			window.returnValue=mockParams;
			window.close();
		};
	</script>
	
	<style type="text/css">
		thead th{
			text-align: left!important;
			padding-left: 5px;
		}
	</style>
</head>

<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">预览用户设置 参数设置</span>
			</div>
		</div>
		<div class="panel-body">
			<div style="height: 220px">
	   		<table id="mockParams" class="table-detail">
	   			<thead>
	   				<tr>
	   					<th>参数名</th>
	   					<th>参数值</th>
	   				</tr>
	   			</thead>
	   			<tbody>
<!-- 	   				<tr class="startUserFlag"> -->
<!-- 	   					<td>流程发起人:</td> -->
<!-- 	   					<td> -->
<!-- 	   						<input id="startUser" readonly="readonly" />  -->
<!-- 	   						<a class="button" onclick="selectUser(this,1)"> -->
<!-- 	   							<span>选择</span> -->
<!-- 	   						</a> -->
<!-- 	   					</td> -->
<!-- 	   				</tr> -->
<!-- 	   				<tr class="prevUserFlag"> -->
<!-- 	   					<td>上一执行人:</td> -->
<!-- 	   					<td> -->
<!-- 	   						<input id="prevExecUser" readonly="readonly"/>  -->
<!-- 	   						<a class="button" onclick="selectUser(this,2)"> -->
<!-- 	   							<span>选择</span> -->
<!-- 	   						</a> -->
<!-- 	   					</td> -->
<!-- 	   				</tr> -->
	   			</tbody>
	   		</table>
	   		</div>
		</div>
		<div>
			<div position="bottom"  class="bottom" >
				<a class="button" onclick="clickOk()"  >
					<span class="icon ok"></span><span>确定</span>
				</a> 
				<a class="button" onclick="clickCancel()" style="margin-left:10px;">
					<span class="icon cancel"></span><span >取消</span>
				</a>
			</div>
		</div>
	</div>
</body>
</html>


