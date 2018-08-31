<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@include file="/commons/include/html_doctype.html"%>
<html>
	<head>
		<title>流程任务-[${task.name}]执行</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
		<%@include file="/commons/include/customForm.jsp" %>
		<%@include file="/js/msg.jsp"%>
		<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
		<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/TaskSignWindow.js"></script>
		<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/TaskAddSignWindow.js"></script>
		<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/TaskBackWindow.js"></script>
		<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/TaskImageUserDialog.js"></script>
		<script type="text/javascript" src="${ctx}/js/cosim/platform/tabOperator.js"></script>
		<script type="text/javascript">
		var taskId='${task.id}';
		var isExtForm=${isExtForm};
		var isEmptyForm=${isEmptyForm};
		var isSignTask=${isSignTask};
		var isHidePath=${isHidePath};
		
		$(function(){
			//隐藏掉投票数据
			$('#taskSignDataItem').hide();
		})
		
		//操作类型
		//1.完成任务
		//2.保存数据
		var operatorType=1;
		
	
		//补签
		function showAddSignWindow(){
			TaskAddSignWindow({taskId:taskId,callback:function(sign){
				loadTaskSign();
			}});
		}
		
		//加载会签数据。
		function loadTaskSign(){
			$(".taskOpinion").load('${ctx}/platform/bpm/task/toSign.ht?taskId=${task.id}');
		}
		//显示流程图
		function showTaskUserDlg(){
			TaskImageUserDialog({taskId:taskId});
		}
		
		function submitForm(action,button){
			
			if($(button).hasClass("disabled"))return;
			if(isEmptyForm){
				$.ligerDialog.error("还没有设置表单!",'提示信息');
				return;
			}
			
			$('#frmWorkFlow').attr("action",action);
			if(isExtForm){
				$(button).addClass("disabled");
				$('#frmWorkFlow').submit();
			}else{
				var data=CustomForm.getData();
				var rtn=CustomForm.validate();
				if(!rtn) return;
				
				//Office控件提交。
				OfficePlugin.submit();
				data=CustomForm.getData();
				//设置表单数据
				$("#formData").val(data);
				$(button).addClass("disabled");
				$('#frmWorkFlow').submit();
			}
		}
		
		function saveData(){
			var operatorObj=getByOperatorType();
			var button="#" +operatorObj.btnId;
			
			var rtn=beforeClick(operatorType);
			
			if( rtn==false){
				return;
			}
			
			var action="${ctx}/platform/bpm/task/saveData.ht";
			submitForm(action,button);
		}

		//完成当前任务。
		function completeTask(){
			//运行时必须指定本企业人员,否则不能提交
			if($('#allowSpecUsr').val()==3){
				var chk = $('input[name$=_userId]:checked');
				if(chk.size()==0){
					alert('请选择下一环节执行人');
					return;						
				}
			}
			var nextPathId=$("input[name='nextPathId']");
			if(nextPathId.length>0){
				var v=$("input[name='nextPathId']:checked").val();
				if(!v){
				
					$.ligerDialog.error("在同步条件后的执行路径中，您至少需要选择一条路径!",'提示信息');
					return;	
				}
			}
			var operatorObj=getByOperatorType();
		
			var button="#" +operatorObj.btnId;
			var action="${ctx}/platform/bpm/task/complete.ht";
			//执行前置脚本
			var rtn=beforeClick(operatorType);
			if( rtn==false){
				return;
			}
			submitForm(action,button);
		}
		
		
		function getByOperatorType(){
			var obj={};
			switch(operatorType){
				//同意
				case 1:
					obj.btnId="btnAgree";
					obj.msg="执行任务成功!";
					break;
				//反对
				case 2:
					obj.btnId="btnNotAgree";
					obj.msg="执行任务成功!";
					break;
				//弃权
				case 3:
					obj.btnId="btnAbandon";
					obj.msg="执行任务成功!";
					break;
					//驳回
				case 4:
					obj.btnId="btnReject";
					obj.msg="驳回任务成功!";
					break;
				//驳回到发起人
				case 5:
					obj.btnId="btnRejectToStart";
					obj.msg="驳回到发起人成功!";
					break;
				//保存表单
				case 8:
					obj.btnId="btnSave";
					obj.msg="保存表单数据成功!";
					break;
				
			}
			return obj;
		}
		
		function getErrorByOperatorType(){
			var rtn="";
			switch(operatorType){
				//同意
				case 1:
				//反对
				case 2:
				//弃权
				case 3:
					rtn="执行任务失败!";
					break;
				//驳回
					//驳回
				case 4:
					rtn="驳回任务失败!";
					break;
				//驳回到发起人
				case 5:
					rtn="驳回到发起人失败!";
					break;
				//保存表单
				case 8:
					rtn="保存表单数据失败!";
					break;
			}
			return rtn;
		}
		
		function showResponse(responseText){
			var operatorObj=getByOperatorType();
			$("#" +operatorObj.btnId).removeClass("disabled");
			var obj=new com.cosim.form.ResultMessage(responseText);
			if(obj.isSuccess()){
				$.ligerDialog.success(operatorObj.msg,'提示信息',function(){
					var rtn=afterClick(operatorType);
					if( rtn==false){
						return;
					}
					if(window.opener){
						window.opener.location.reload();
						window.close();
					}
				});
			}else{
				var title=getErrorByOperatorType();
				$.ligerDialog.err('出错信息',title,obj.getMessage());
			}
		}
		
		//弹出回退窗口 TODO 去除
		function showBackWindow(){
			new TaskBackWindow({taskId:taskId}).show();
		}
		
		$(function(){
			initForm();
			//显示路径
			chooseJumpType($('#allowSpecUsr').val());
			//允许运行时指定执行人
			//allowSpecUsr($('#allowSpecUsr').val());
			resizeIframe();
		});	
		
		function initBtnEvent(){
			//0，弃权，1，同意，2反对。
			var objVoteAgree=$("#voteAgree");
			var objBack=$("#back");
			
			//同意
			if($("#btnAgree").length>0){
				$("#btnAgree").click(function(){
					
					if(isExtForm){//提交第三方表单时检查该表单的参数
						try {
							if(setFormData)
								setFormData();
						}catch(ex){}
						var frm=$('#frmWorkFlow');
						if(!frm.valid()) return ;
						
						if(frm.setData)frm.setData();
					}
					
					var isDirectComlete = false;
					
					if($("#chkDirectComplete").length>0){
						if($("#chkDirectComplete").attr("checked")=="checked"){
							isDirectComlete = true;
						}
					}
					
					operatorType=1;
					var tmp = '1';
					if(isDirectComlete){//直接一票通过
						tmp = '5';
					}
					objVoteAgree.val(tmp);
					objBack.val("0");
					completeTask();
				});
			}
			//反对
			if($("#btnNotAgree").length>0){
				$("#btnNotAgree").click(function(){
					
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
						if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					var isDirectComlete = false;
					
					if($("#chkDirectComplete").length>0){
						if($("#chkDirectComplete").attr("checked")=="checked"){
							isDirectComlete = true;
						}
					}
					
					operatorType=2;
					var tmp = '2';
					if(isDirectComlete){//直接一票通过
						tmp = '6';
					}
					objVoteAgree.val(tmp);
					objBack.val("0");
					completeTask();
				});
			}
			//弃权
			if($("#btnAbandon").length>0){
				$("#btnAbandon").click(function(){
					
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
						if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					operatorType=3;
					objVoteAgree.val(0);
					objBack.val("");
					completeTask();
				})
			}
			//驳回
			if($("#btnReject").length>0){
				$("#btnReject").click(function(){
					
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
						if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					operatorType=4;
					objVoteAgree.val(3);
					objBack.val(1);
					completeTask();
				})
			}
			//驳回到发起人
			if($("#btnRejectToStart").length>0){
				$("#btnRejectToStart").click(function(){
					
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
						if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					operatorType=5;
					//驳回到发起人
					objVoteAgree.val(3);
					objBack.val(2);
					completeTask();
				})
			}
			//保存表单
			if($("#btnSave").length>0){
				$("#btnSave").click(function(){
					
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
						if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					operatorType=8;
					saveData();
				})
			}
		}
		
		function initForm(){
			//初始化按钮事件。
			initBtnEvent();
			
			if(isEmptyForm){
				return;
			}
			if(isExtForm){				
				var formUrl=$('#divExternalForm').attr("formUrl");
				
				
				///如果是以“http://”开头说明是外部系统URL表单
				var index = formUrl.indexOf("http://");
				if (index == 0){
					 $.ajax({
						   url: formUrl,
						   dataType: "jsonp",
						   type: "GET",
						   success: function(data){
							   var html = data.data;
							   $('#divExternalForm').html(html);
							   hasLoadComplete=true;
								//动态执行第三方表单指定执行的js
								try{
									afterOnload();
								}catch(e){}
								initSubForm();
						   },
						   error:function(XMLHttpRequest, textStatus, errorThrown)
						   {
							   console.log(XMLHttpRequest);
							   console.log(textStatus);  
							   console.log(errorThrown);  
							   console.log(XMLHttpRequest.status);  
							   console.log(XMLHttpRequest.readyState);  
							   console.log(XMLHttpRequest.responseText);  
						   }
					 });
					 
				}else{
					$('#divExternalForm').load(formUrl, function() {
						hasLoadComplete=true;
						//动态执行第三方表单指定执行的js
						try{
							afterOnload();
						}catch(e){}
						initSubForm();
					});
				}
				
			}else{
				$(".taskopinion").each(function(){
					$(this).removeClass("taskopinion");
					var actInstId=$(this).attr("instanceId");
				});
				initSubForm();
			}
		}
		
		function initSubForm(){
			$('#frmWorkFlow').ajaxForm({success:showResponse }); 
		}
		
		function showRoleDlg(){
			RoleDialog({callback:function(roleId,roleName){$('#forkUserUids').val(roleId);}}); 
		}
		
		function chooseJumpType(val){
			if(isHidePath) return;
			var obj=$('#jumpDiv');
			var url="";
			if(val==1){
				url="${ctx}/platform/bpm/task/tranTaskUserMap.ht?taskId=${task.id}&selectPath=0";
			}
			//选择路径跳转
			else if(val==2){
				url="${ctx}/platform/bpm/task/tranTaskUserMap.ht?taskId=${task.id}";
			}
			//自由跳转
			else if(val==3){
				url="${ctx}/platform/bpm/task/freeJump.ht?taskId=${task.id}";
			}
			url=url.getNewUrl();
			
			obj.html(obj.attr("tipInfo")).show().load(url);
			
		};
		
		//允许企业指定本企业人员
		function allowSpecUsr(val){
			if(val==3){
				var obj=$('#allowSpecUser');
				var url="${ctx}/platform/bpm/task/allowSpecUsr.ht?taskId=${task.id}";
				url=url.getNewUrl();
				//obj.html(obj.attr("tipInfo")).show().load(url);
				obj.show().load(url);
			}
		}
		
		//为目标节点选择执行的人员列表		
		function selExeUsers(obj,nodeId){
			var destTaskId=$("#destTask").val();
			$("#lastDestTaskId").val(destTaskId);
			var span=$(obj).siblings("span");
			
			var aryChk=$(":checkbox",span);
			var selectExecutors =[];  
			aryChk.each(function(){   
				var val=$(this).val();
			    var k=val.split("^");
				var userObj={};
				userObj.type=k[0];;
				userObj.id=k[1];;
				userObj.name=k[2];;
				selectExecutors.push(userObj);    
			});    
		
			FlowUserDialog({selectUsers:selectExecutors,callback:function(types,objIds,objNames){
				if(objIds==null) return;
				var aryTmp=[];
				for(var i=0;i<objIds.length;i++){
					var check="<input type='checkbox' name='" + nodeId + "_userId' checked='checked' value='"+types[i] +"^"+  objIds[i]+"^"+objNames[i] +"'/>&nbsp;"+objNames[i];
					aryTmp.push(check);
				}
				span.html(aryTmp.join(''));
			}});
			
			/**获取下一节点执行人
			NextUserDialog({taskId:taskId, selectUsers:selectExecutors,callback:function(types,objIds,objNames){
				if(objIds==null) return;
				var aryTmp=[];
				for(var i=0;i<objIds.length;i++){
					var check="<input type='checkbox' name='" + nodeId + "_userId' checked='checked' value='"+types[i] +"^"+  objIds[i]+"^"+objNames[i] +"'/>&nbsp;"+objNames[i];
					aryTmp.push(check);
				}
				span.html(aryTmp.join(''));
			}});**/
		}
		
		function selectExeUsers(obj){
			var nodeId=$("#destTask").val();
			$("#lastDestTaskId").val(nodeId);
			selExeUsers(obj,nodeId);
		}
		//显示审批历史
		function showTaskOpinions(){
			var winArgs="dialogWidth=800px;dialogHeight=600px;help=1;status=1;scroll=1;center=1;resizable:1";				
			var url='${ctx}/platform/bpm/taskOpinion/list.ht?taskId='+taskId+"&isOpenDialog=1";
			url=url.getNewUrl();
			window.showModalDialog(url,"",winArgs);
		}
		//更改
		function changeDestTask(sel){
			var nodeId=sel.value;
			$('#lastDestTaskId').val(nodeId);
			if(nodeId==""){
				$('#jumpUserDiv').html("");
				return;
			}
			var url="${ctx}/platform/bpm/task/getTaskUsers.ht?taskId=${task.id}&nodeId="+nodeId;
			$.getJSON(url, function(dataJson){
				var data=eval(dataJson);
				//alert(dataJson);
				var aryHtml=[];
				for(var i=0;i<data.length;i++){
				  var span="<input type='checkbox' name='" + nodeId + "_userId' checked='checked' value='user^"+data[i].userId+"^"+data[i].fullname+"'/>&nbsp;"+data[i].fullname;
				  aryHtml.push(span);
				}
				$('#jumpUserDiv').html(aryHtml.join(''));
			});
			
		}
		//转交代办
		function changeAssignee(){
			FlowUserDialog({
				isSingle:true,
				callback:function(types,userIds,fullnames){
					if(userIds==null) return;
					var memo="";
					$("#assigneeId").val(userIds[0]);
					$.ligerDialog.open({
						width: 350,
						height:115,
						title: "注意事项", 
						isResize:true,
						target:$("#delegeteMemo"),
						buttons: [{ text: '确定', onclick:function(item,dialog){
							memo=$("#memo").val();
							dialog.hide();
							var url="${ctx}/platform/bpm/task/delegate.ht";
							var id=$("#assigneeId").val();
							var params= {taskId:taskId,userId:id ,memo:memo};
							$.post(url,params,function(responseText){
								var obj=new com.cosim.form.ResultMessage(responseText);
								if(obj.isSuccess()){
									 $.ligerMessageBox.success('提示信息',('成功把任务[${task.name}]交给'+fullnames[0]),function(){
										 if(window.opener){
											window.opener.location.reload();
											window.close();
										 }
									 });
								}else{
									$.ligerMessageBox.error("任务交办失败！");
								}
							});
						}}]
					});
				}
			});
		};
		
		
		function resizeIframe(){
			if($("#frameDetail").length==0) return;
			$("#frameDetail").load(function() { 
				$(this).height($(this).contents().height()+20); 
			}) ;
		}
		
		
		// 选择常用语
		function addComment(){
			var objContent=document.getElementById("voteContent");
			var selItem = $('#selTaskAppItem').val();
			jQuery.insertText(objContent,selItem);
		}
		
		function openForm(formUrl){
			var winArgs="dialogWidth=500px;dialogHeight=400px;help=0;status=0;scroll=0;center=1";
			var url=formUrl.getNewUrl();
			window.open(url,"",winArgs);
		}
		
	</script>	
	<style type="text/css" media="print">
		.noprint{display:none;} 
		.printForm{display:"block";} 
	</style>
</head>
<body>
	<form id="frmWorkFlow"  method="post" >
		 <div class="panel">
		 		<div class="panel-top"> 
		            <div class="l-layout-header noprint" style="color:white;">
		            	任务审批处理--<b>${task.name}</b>--<i>[${bpmDefinition.subject}-V${bpmDefinition.versionNo}]</i>
		            </div>
		            <c:choose>
		            	<c:when test="${(empty task.executionId) && task.description=='通知任务' }">
		            		<jsp:include page="incTaskNotify.jsp"></jsp:include>
		            	</c:when>
		            	<c:otherwise>
		            		<jsp:include page="incToolBarNode.jsp"></jsp:include>
		            	</c:otherwise>
		            </c:choose>
		         </div>
	            
				<div class="panel-body">
					<c:choose>
						<c:when test="${bpmNodeSet.isHidePath==0}">
						<div id="jumpDiv" class="noprint" style="display:none;" tipInfo="正在加载表单请稍候...">
						</div>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${bpmNodeSet.isHideOption==0}">
							<div class="noprint">
								<jsp:include page="incTaskOpinion.jsp"></jsp:include>
							</div>
						</c:when>
					</c:choose>
					<div id="allowSpecUser" class="noprint" style="display:none;">
					</div>
					<div class="printForm" style="overflow: hidden;">
							<c:choose>
								<c:when test="${isEmptyForm==true}">
									<div class="noForm">没有设置流程表单。</div>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${isExtForm}">
											<c:choose>
												<c:when test="${!empty detailUrl}">
													<iframe id="frameDetail" src="${detailUrl}" scrolling="no"  frameborder="no"  width="100%" height="100%"></iframe>
												</c:when>
												<c:otherwise>
													<div class="printForm" id="divExternalForm" formUrl="${form}"></div>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<div class="printForm" type="custform">
											${form}
											</div>
											<input type="hidden" name="formData" id="formData" />
										</c:otherwise>
									</c:choose>	
								</c:otherwise>
							</c:choose>
					</div>
					<div class="panel-body" style="display: none" id="delegeteMemo">
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="30%">备注: </th>
								<td><input type="text" id="memo" name="memo"class="inputText"/></td>
							</tr>
							<input type="hidden" id="assigneeId" value=""/> 
						</table>
					</div>
					<input type="hidden" id="taskId" name="taskId" value="${task.id}"/> 
					<input type="hidden" name="agentTask" value="${param['agentTask']}"/>
					<input type="hidden" id="voteAgree" name="voteAgree" value="1"/> 
					<input type="hidden" id="back" name="back" value=""/>
					<input type="hidden" id="allowSpecUsr" name="allowSpecUsr" value="${bpmNodeSet.allowSpecUsr}"/>
				</div>
         </div> 
    </form>
</body>
</html>
