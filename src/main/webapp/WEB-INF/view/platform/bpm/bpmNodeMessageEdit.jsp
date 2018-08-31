<%--
	time:2011-12-31 15:48:59
	desc:edit the 流程节点消息
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 流程节点消息</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerTab.js" ></script>
	<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerWindow.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerMenu.js" ></script>
    <script type="text/javascript"  src="${ctx }/js/cosim/platform/system/SysDialog.js"></script>
	<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_message_node.js"></script>
	<script type="text/javascript">
		 var obj;
		 var tab = null;
		 var editorMail,editorMsg,editorSysMsg;
         $(function (){ 
         	var height=$(document.body).height()-65;
            $("#tabMyInfo").ligerTab({height:height});
            editorMail=ckeditor('mailContent');
 		    editorMsg=ckeditor('msgContent');
 		    editorSysMsg=ckeditor('sysMsgContent');
 		 	$("a.save").click(save);
         });
         
		 function showRequest(formData, jqForm, options) {
				return true;
			}
			
	     function save(){
    		 var valRes=validata();
    		 if(!valRes) return;
    		 var rtn=$("#bpmNodeMessageForm").valid();
    		 if(!rtn) return;
    		 var content_mail=editorMail.getData();
    		 var content_mobile=editorMsg.getData();
    		 var content_inner=editorSysMsg.getData();
    		 $("#mailContent").val(content_mail);
    		 $("#msgContent").val(content_mobile);
    		 $("#sysMsgContent").val(content_inner);
    		 
    		 var url=__ctx+ "/platform/bpm/bpmNodeMessage/save.ht";
    		 var para=$('#bpmNodeMessageForm').serialize();
    		 $.post(url,para,showResult);
	     }
	     
	     function validata(){
    		 if($("#receiver_mail").val()!=""){
    			 if($("#subject_mail").val()==""){
    				 $.ligerMessageBox.warn('提示信息','请输入邮件的主题');
    				 return false;}
    			 else return true;
    		 }
    		 if($("#receiver_inner").val()!=""){
    			 if($("#subject_inner").val()==""){
    				 $.ligerMessageBox.warn('提示信息','请输入站内信息的主题');
    				 return false;}
    			 else return true;
    		 }
    		 else return true;
	     }
	     function showResult(responseText)
			{			
				var obj=new com.cosim.form.ResultMessage(responseText);
				
				if(!obj.isSuccess()){
					$.ligerDialog.err("出错信息","编辑流程节点失败",obj.getMessage());
					return;
				}else{
					$.ligerMessageBox.success('提示信息',obj.getMessage(),function(rtn){
						if(rtn) window.close();						
					});
				}
			}
	    function dlgCallBack(userIds,fullnames,emails,mobiles)
		{
			var userIdArr;
			var userNameArr;
			var emailArr;
			var mobileArr;
			var userIdStr="";
			var userNameStr="";
			var emailStr="";
			var mobileStr="";
			var resultStr="";
			if(userIds!="")
			{
				userIdArr=userIds.split(",");
				userNameArr=fullnames.split(",");
				emailArr=emails.split(",");
				mobileArr=mobiles.split(",");
				for(var i=0;i<userIdArr.length;i++)
				{ 					
					userIdStr=userIdArr[i];					
					userNameStr=userNameArr[i];
					emailStr=emailArr[i];
					mobileStr=mobileArr[i];
					if(resultStr=="")
					{
						if(obj.indexOf("mail")!=-1)
						{
							resultStr=userNameStr+"("+emailStr+")";
							//resultStr=emailStr;
						}
						else if(obj.indexOf("mobile")!=-1)
						{
							resultStr=userNameStr+"("+mobileStr+")";
						}
						else if(obj.indexOf("inner")!=-1)
						{
							resultStr=userNameStr+"("+userIdStr+")";
						}
						
					}
					else
					{
						if(obj.indexOf("mail")!=-1)
						{
							resultStr=resultStr+","+userNameStr+"("+emailStr+")";
							//resultStr=resultStr+emailStr;
						}
						else if(obj.indexOf("mobile")!=-1)
						{
							resultStr=resultStr+","+userNameStr+"("+mobileStr+")";
						}
						else if(obj.indexOf("inner")!=-1)
						{
							resultStr=resultStr+","+userNameStr+"("+userIdStr+")";
						}						
					}
					
				} 
				
			}
			
			$("#"+obj).val(resultStr);			
		
		};
		function addClick(oName)
		{
			obj=oName;
			 UserDialog({sSingle:false,callback:dlgCallBack});
		};
		//清空
		function reSet(obj)
		{
			$("#"+obj).val("");			
		}
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">消息参数设置</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link save" id="btnSearch">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link del" onclick="javasrcipt:window.close()">关闭</a></div>
			
			</div>	
		</div>
	</div>
	<div class="panel-body">
		<form id="bpmNodeMessageForm" method="post" action="save.ht">
			<div id="tabMyInfo" class="panel-nav">
				<div id="mailDiv" title="邮件信息" style="overflow: auto">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">邮件主题: </th>
							<td><input type="text" id="subject_mail" name="subject_mail" value="${subject_mail}"  class="inputText" style="width:325px !important"/> 
							<label><input type="checkbox" <c:if test="${sendToStartUser_mail==1 }">checked="checked"</c:if>  value="1" name="sendToStartUser_mail"/>发送至流程发起人</label>
							</td>
						</tr>
						<tr>
							<th width="20%">邮件接收人: </th>
							<td valign="top">
							<textarea id="receiver_mail" name="receiver_mail"  rows="2" readonly="readonly" style="width:328px !important">${receiver_mail}</textarea>
							<a href="#" onclick="addClick('receiver_mail')" class="link get">选择</a>
					        <a href="#" onclick="reSet('receiver_mail')" class="link clean">清空</a>
							</td>
						</tr>
						
						<tr>
							<th width="20%">邮件内容: </th>
							<td>
								<textarea rows="6" cols="60" id="mailContent" name="content_mail" >${content_mail}</textarea>
							</td>
						</tr>
					</table>
				</div>
				<div title="手机短信" id="phoneDiv">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">						
						<tr>
							<th width="20%">短信接收人: </th>
							<td valign="top">
							<textarea id="receiver_mobile" name="receiver_mobile" rows="3" readonly="readonly" style="width:328px !important">${receiver_mobile}</textarea>
							<a href="#" onclick="addClick('receiver_mobile')" class="link get">选择</a>
					        <a href="#" onclick="reSet('receiver_mobile')" class="link clean">清空</a>
					        <label><input type="checkbox" value="1" <c:if test="${sendToStartUser_mobile==1 }">checked="checked"</c:if> name="sendToStartUser_mobile"/>发送至流程发起人</label>
							</td>
						</tr>								
						<tr>
							<th width="20%">短信内容: </th>
							<td>
								<textarea rows="6" cols="60" id="msgContent" name="content_mobile" >${content_mobile}</textarea>
							</td>
						</tr>
					</table>
				</div>
				<div title="内部消息" id="sysMessageDiv">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">消息主题: </th>
							<td>
								<input type="text" id="subject_inner" name="subject_inner" value="${subject_inner}"  class="inputText" style="width:324px !important"/>
								<label><input type="checkbox" value="1" <c:if test="${sendToStartUser_inner==1 }">checked="checked"</c:if> name="sendToStartUser_inner"/>发送至流程发起人</label>
							</td>
						</tr>
						<tr>
							<th width="20%">消息接收人: </th>
							<td valign="top">
							<textarea id="receiver_inner" name="receiver_inner"  rows="3" readonly="readonly" style="width:328px !important">${receiver_inner}</textarea>
							<a href="#" onclick="addClick('receiver_inner')" class="link get">选择</a>
					        <a href="#" onclick="reSet('receiver_inner')" class="link clean">清空</a>
							</td>
						</tr>									
						<tr>
							<th width="20%">消息模版: </th>
							<td>
								<textarea rows="6" cols="60" id="sysMsgContent" name="content_inner" >${content_inner}</textarea>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" id="defId" name="defId" value="${defId}"  class="inputText"/>		
			<input type="hidden" id="id" name="id" value="${id}"  class="inputText"/>				
			<input type="hidden" id="actDefId" name="actDefId" value="${actDefId}"  class="inputText"/>
			<input type="hidden" id="nodeId" name="nodeId" value="${nodeId}"  class="inputText"/>														
		 </form>
	   </div>
</div>
</body>
</html>
