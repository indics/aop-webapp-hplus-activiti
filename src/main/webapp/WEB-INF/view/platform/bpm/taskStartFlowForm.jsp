<%@ page pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
	<head>
		<title>流程启动--${bpmDefinition.subject} --版本:${bpmDefinition.versionNo}</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
		<%@include file="/commons/include/customForm.jsp" %>
		<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/BpmImageDialog.js"></script>
		
		<script type="text/javascript">
			var isExtForm=${isExtForm};
			var isFormEmpty=${isFormEmpty};
			var hasLoadComplete=false;
			var actDefId="${bpmDefinition.actDefId}";
			var form;
			$(function(){
				//设置表单。
				initForm();
				//启动流程事件绑定。
				$("a.run").click(startWorkFlow);
				//保存表单
				$("a.save").click(saveForm);	
				//选择第一步任务的执行人
				chooseJumpType();
			});
			
			//设置表单。
			function initForm(){
				if(isFormEmpty) return;
				//表单不为空的情况。
				if(isExtForm){
					form=$('#frmWorkFlow').form({excludes:"[type=append]"});
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
					
				}
				else{
					initSubForm();
				}
			};
			
			function selExeUsers(obj,nodeId){
				var destTaskId=$("#destTask").val();
				$("#lastDestTaskId").val(destTaskId);
				var span=$(obj).siblings("span");
				FlowUserDialog({callback:function(aryTypes,aryIds,aryNames){
					if(aryIds==null) return;
					var aryTmp=[];
					for(var i=0;i<aryIds.length;i++){
						var val=aryTypes[i] +"^" + aryIds[i] +"^" +aryNames[i];
						var check="<input type='checkbox' name='" + nodeId + "_userId' checked='checked' value='"+ val+"'/>&nbsp;"+aryNames[i];
						aryTmp.push(check);
					}
					span.html(aryTmp.join(''));
				}});
			}
			
			//是否点击了开始按钮。
			var isStartFlow=true;
			
			function saveForm(){
				isStartFlow=false;
				var  action="${ctx}/platform/bpm/task/saveData.ht";
				submitForm(action,"a.save");
			}
			
			function startWorkFlow(){
				isStartFlow=true;
				var  action="${ctx}/platform/bpm/task/startFlow.ht";
				submitForm(action,"a.run");
			}
			
			//表单数据提交。
			//action:表单提交到的URL
			//button：点击按钮的样式。
			function submitForm(action,button){
				var operatorType=(isStartFlow)?1:6;
				//前置事件处理
				var rtn=beforeClick(operatorType);
				if( rtn==false){
					return;
				}
				if($(button).hasClass("disabled"))return;
				if(isFormEmpty){
					$.ligerDialog.warn('流程表单为空，请先设置流程表单!',"提示信息");
					return;
				}
				
				$('#frmWorkFlow').attr("action",action);
				
				if(isExtForm){
					var rtn=form.valid();
					if(rtn){
						
						if(isExtForm){//提交第三方表单时检查该表单的参数
							var frm=$('#frmWorkFlow');
							if(!frm.valid()) return ;
							if(frm.setData)frm.setData();
						}
						
						$(button).addClass("disabled");
						$('#frmWorkFlow').submit();
					}
				}else{
					//获取自定义表单的数据
					var data=CustomForm.getData();
					
					var rtn=CustomForm.validate();
					if(!rtn){
						return;
					}
					//Office控件提交。
					OfficePlugin.submit();
					//获取自定义表单的数据
					data=CustomForm.getData();
					//设置表单数据
					$("#formData").val(data);
					$(button).addClass("disabled");
					$('#frmWorkFlow').submit();
				}
			}
		
			function showBpmImageDlg(){
				BpmImageDialog({actDefId:"${bpmDefinition.actDefId}"});
			}
			
			function initSubForm(){
				$('#frmWorkFlow').ajaxForm({success:showResponse }); 
			}
			
			function showResponse(responseText){
				var button=(isStartFlow)? "a.run":"a.save";
				var operatorType=(isStartFlow)?1:6;
				
				$(button).removeClass("disabled");
				var obj=new com.cosim.form.ResultMessage(responseText);
				if(obj.isSuccess()){
					var msg=(isStartFlow)?"启动流程成功!":"保存表单数据成功!";
					$.ligerDialog.success(msg,'提示信息',function(){
						//添加后置事件处理
						var rtn=afterClick(operatorType);
						if( rtn==false){
							return;
						}
						if(window.opener){
							window.opener.location.reload();
							window.close();
						}
					});
					
				}
				else{
					var msg=(isStartFlow)?"启动流程失败!":"保存表单数据失败!";
					$.ligerDialog.err('提示信息',msg,obj.getMessage());
				}
			}
			
			function chooseJumpType(){
				var obj=$('#jumpDiv');
				var url="${ctx}/platform/bpm/task/tranTaskUserMap.ht?actDefId=${bpmDefinition.actDefId}&selectPath=0&isStart=1";
				url=url.getNewUrl();
				obj.html(obj.attr("tipInfo")).show().load(url);
			}

		</script>
		<style type="text/css" media="print">
			.noprint{display:none;} 
			.printForm{display:block !important;} 
			.noForm{font-size: 14px;font-weight: bold;text-align: center;}
		</style>
	</head>
	<body>
		<form id="frmWorkFlow" method="post" >
			<div class="panel">
					<%@include file="incToolBarStart.jsp" %>
					<div style="padding:6px 8px 3px 12px;" class="noprint">
						<b>流程简述：</b>${bpmDefinition.descp}
					</div>
					
					<div class="panel-body printForm" style="overflow: auto;">
						
							<c:choose>
								<c:when test="${bpmDefinition.showFirstAssignee==1}">
									<div id="jumpDiv" class="noprint" style="display:none;" tipInfo="正在加载表单请稍候..."></div>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${isFormEmpty==true}">
									<div class="noForm">没有设置流程表单。</div>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${isExtForm}">
											<div id="divExternalForm" formUrl="${form}"></div>
										</c:when>
										<c:otherwise>
											<div type="custform">${form}</div>
											<input type="hidden" name="formData" id="formData" />
											<c:if test="${not empty  paraMap}">
												<c:forEach items="${paraMap}" var="item">
												<input type="hidden" name="${item.key}" value="${item.value}" />
          										</c:forEach>
											</c:if>
										</c:otherwise>
									</c:choose>	
								</c:otherwise>
							</c:choose>
							<input type="hidden" name="actDefId" value="${bpmDefinition.actDefId}"/>
							<input type="hidden" name="defId" value="${bpmDefinition.defId}"/>
							<input type="hidden" name="businessKey" value="${businessKey}"/>
						
					</div>
			</div>
		</form>
	</body>
	
</html>
