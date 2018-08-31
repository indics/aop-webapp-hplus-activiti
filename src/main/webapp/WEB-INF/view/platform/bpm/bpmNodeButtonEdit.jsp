<%--
	time:2012-07-25 18:26:13
	desc:edit the 自定义工具条
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 自定义工具条</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmNodeButton"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/BpmNodeButton.js"></script>
	<script type="text/javascript">
		var isStartForm=${bpmNodeButton.isstartform};
		var isSign=${bpmNodeButton.nodetype};
		
		$(function() {
			function showRequest(formData, jqForm, options) { 
				var operatortype=$("#operatortype").val();
				if(operatortype=="0"){
					$.ligerMessageBox.warn('提示信息',"请选择操作类型");
					return false;
				}
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#bpmNodeButtonForm').submit(); 
			});
			$("a.back").click(function(){
				var nurl =__ctx + "/platform/bpm/bpmNodeButton/getByNode.ht?defId=${defId}&nodeId=${nodeId}&buttonFlag=${buttonFlag}";
				$.gotoDialogPage(nurl);
			})
			//获取操作类型。
			BpmNodeButton.getOperatorType(isStartForm,isSign);
			
			$("#operatortype").change(function(){
				var val=$(this).find("option:selected").text().trim();
				var operatorType=parseInt($(this).val());
				if(val!=""){
					$("#btnname").val(val);
				}
				if(isStartForm==0){
					if(operatorType>8){
						$("#trprevscript,#trafterscript").hide();
					}
					else{
						$("#trprevscript,#trafterscript").show();
					}	
				}
				else{
					if(operatorType==1 || operatorType==6){
						$("#trprevscript,#trafterscript").show();
					}
					else{
						$("#trprevscript,#trafterscript").hide();
						
					}	
				}
			});
		});
	
		
		function showResponse(data){
			var obj=new com.cosim.form.ResultMessage(data);
			if(obj.isSuccess()){//成功
				$.ligerMessageBox.confirm('提示信息','操作成功,继续操作吗?',function(rtn){
					if(rtn){
						location.reload();
					}else{
						var nurl =__ctx + "/platform/bpm/bpmNodeButton/getByNode.ht?defId=${defId}&nodeId=${nodeId}&buttonFlag=${buttonFlag}";
						$.gotoDialogPage(nurl);
					}
				});
		    }else{//失败
		    	$.ligerDialog.err('出错信息',"保存按钮失败",obj.getMessage());
		    }
		};


	</script>
</head>
<body>
  <c:if test="${buttonFlag}"> 
	<jsp:include page="incDefinitionHead.jsp">
		<jsp:param value="节点操作按钮" name="title"/>
	</jsp:include>
	<f:tab curTab="操作按钮管理" tabName="flow"/>
</c:if>
<div class="panel">
		<div class="panel-top">
			
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="#">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="bpmNodeButtonForm" method="post" action="save.ht">
					
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="20%">按钮名称: </th>
								<td><input type="text" id="btnname"  name="btnname" value="${bpmNodeButton.btnname}"  class="inputText"/></td>
							</tr>
							
							<tr>
								<th width="20%">操作类型: </th>
								<td>
									<select id="operatortype"  name="operatortype" operatortype="${bpmNodeButton.operatortype}" >
									</select>
								</td>	
							</tr>
							<c:choose>
								<c:when test="${item.isstartform==1 }">
									<tr id="trprevscript" <c:if test="${bpmNodeButton.operatortype>1}">style="display:none"</c:if> >
										<th width="20%">前置脚本: </th>
										<td><textarea  id="prevscript" name="prevscript" cols="50" rows="5"  class="inputText">${bpmNodeButton.prevscript}</textarea> </td>
									</tr>
									<tr id="trafterscript" <c:if test="${bpmNodeButton.operatortype>1}">style="display:none"</c:if> >
										<th width="20%">后置脚本: </th>
										<td><textarea  id="afterscript" name="afterscript" cols="50" rows="5"  class="inputText">${bpmNodeButton.afterscript}</textarea></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr id="trprevscript" <c:if test="${bpmNodeButton.operatortype>8}">style="display:none"</c:if> >
										<th width="20%">前置脚本: </th>
										<td><textarea  id="prevscript" name="prevscript" cols="50" rows="5"  class="inputText">${bpmNodeButton.prevscript}</textarea>
											<br> 
											<b>脚本为javascript，用于在提交前做些处理，需要返回true或false。返回false时不做提交动作。</b>
										</td>
									</tr>
									<tr id="trafterscript" <c:if test="${bpmNodeButton.operatortype>8}">style="display:none"</c:if> >
										<th width="20%">后置脚本: </th>
										<td><textarea  id="afterscript" name="afterscript" cols="50" rows="5"  class="inputText">${bpmNodeButton.afterscript}</textarea>
											<br>
											<b>脚本为javascript，用于在提交后做些处理，需要返回true或false。返回false时可以控制不关闭当前窗口。</b>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
							
							
						
						</table>
						<input type="hidden" id="returnUrl" value="getByNode.ht?defId=${bpmNodeButton.defId}&nodeId=${bpmNodeButton.nodeid}" />
						<input type="hidden" name="actdefid" value="${bpmNodeButton.actdefid}" />
						<input type="hidden" name="nodeid" value="${bpmNodeButton.nodeid}" />
						<input type="hidden" name="defId" value="${bpmNodeButton.defId}" />
						<input type="hidden" name="nodetype" value="${bpmNodeButton.nodetype}" />
						<input type="hidden" name="isstartform" value="${bpmNodeButton.isstartform}" />
						<input type="hidden" name="sn" value="${bpmNodeButton.sn}" />
						<input type="hidden" name="id" value="${bpmNodeButton.id}" />
					
				</form>
		</div>
</div>
</body>
</html>
