<%--
	time:2012-01-05 12:01:21
	desc:edit the 脚本管理
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>其他参数设置</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_rule.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/FlowVarWindow.js"></script>
	
	<script type="text/javascript">
	var defId=${bpmDefinition.defId };
	
	$(function(){
		editor=ckeditor('taskNameRule');
		handFlowVars();		
	});
	
	function handFlowVars(){
		var objConditionCode=$("#taskNameRule");
		$("select[name='selFlowVar']").change(function(){		
			var val=$(this).val();
			var text=$(this).find("option:selected").text();
			if(val.length==0) return;
			if(text=="发起人(长整型)")
				text=text.replace("(长整型)","");			
			var inStr="{"+text+":"+val+"}";
			InsertText(inStr);
		});
	}
	
	function InsertText(val){
		// Get the editor instance that we want to interact with.
		var oEditor = CKEDITOR.instances.taskNameRule;
		// Check the active editing mode.
		if ( oEditor.mode == 'wysiwyg' ){
			oEditor.insertText( val );
		}else
			alert( '请把编辑器设置为编辑模式' );
	}

	
	function saveParam(){
		var taskNameRule=CKEDITOR.instances["taskNameRule"].getData();
		var toFirstNode=$("#toFirstNode").attr("checked");
		var needStartForm=$("#needStartForm").attr("checked");
		var showFirstAssignee=$("#showFirstAssignee").attr("checked");
		var startFirstNode=$('#startFirstNode').val();
		var formDetailUrl=$('#formDetailUrl').val();
		var outForm=$('#isOutForm').attr("checked");
		var toFirstNodeVal=1;
		var needStartFormVal=1;
		var showFirstAssigneeVal=1;
		var isOutForm=1;
		if(toFirstNode==undefined){
			toFirstNodeVal=0;
		}
		if(outForm==undefined){
			isOutForm=0;
		}
		if(needStartForm==undefined){
			needStartFormVal=0;
		}
		if(showFirstAssignee==undefined){
			showFirstAssigneeVal=0;
		}
		var params={defId:defId,taskNameRule:taskNameRule,toFirstNode:toFirstNodeVal,needStartForm:needStartFormVal,showFirstAssignee:showFirstAssigneeVal,startFirstNode:startFirstNode,isOutForm:isOutForm,formDetailUrl:formDetailUrl};
		
		$.post("saveParam.ht",params,function(msg){
			var obj=new com.cosim.form.ResultMessage(msg);
			if(obj.isSuccess()){
				$.ligerMessageBox.success('操作成功',obj.getMessage());
			}else{
				$.ligerDialog.err('出错信息',"流程定义其他参数设置失败",obj.getMessage());
			}
		});
	}
	
	
	</script>
</head>
<body> 
            <jsp:include page="incDefinitionHead.jsp">
		   		<jsp:param value="其他参数" name="title"/>
			</jsp:include>
            <f:tab curTab="其他参数" tabName="flow"/>
            <div class="panel-top">
	            <div class="tbar-title">
					<span class="tbar-label">流程定义其他参数设置</span>
				</div>
				<div class="panel-toolbar">
					<div class="toolBar">
						<div class="group"><a class="link save" onclick="saveParam()">保存</a></div>
					</div>	
				</div>
			</div>
            <div class="panel-detail">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<th width="15%">流程标题规则定义</th>
					<td>
						表单变量:<f:flowVar defId="${defId}" controlName="selFlowVar"></f:flowVar>
						<textarea id="taskNameRule" row="6" name="taskNameRule" >${bpmDefinition.taskNameRule }</textarea>
					</td>	
				</tr>
				<tr>
					<th width="15%">驳回到的发起人节点:</th>
					<td>
						<select id="startFirstNode" name="startFirstNode">
							<c:forEach items="${nodeSetList}" var="node">
							<option value="${node.nodeId}" <c:if test="${bpmDefinition.startFirstNode==node.nodeId}">selected="selected"</c:if><c:if test="${firstTaskName==node.nodeId }">selected="selected"</c:if> > ${node.nodeName}</option>
							</c:forEach>
						</select>
						
						<a href="#" class="tipinfo"><span>当操作驳回至发起人时，流程回退到该选择的节点，默认为流程的第一个节点</span></a>
					</td>	
				</tr>
				<tr>
					<th width="15%">跳过第一个任务:</th>
					<td>
						<input id="toFirstNode" type="checkbox" name="toFirstNode" value="1"  <c:if test="${bpmDefinition.toFirstNode==1 }">checked="checked"</c:if> />
						<a href="#" class="tipinfo"><span>流程启动后直接完成第一个节点的任务。</span></a>
					</td>	
				</tr>
				<tr>
					<th width="15%">开始节点需要表单:</th>
					<td>
						<input id="needStartForm" type="checkbox" name="needStartForm" value="1"  <c:if test="${bpmDefinition.needStartForm==1 }">checked="checked"</c:if> />
						<a href="#" class="tipinfo"><span>如果勾选，那么流程起始节点需要定义表单，默认为需要。</span></a>
					</td>	
				</tr>
				<tr>
					<th width="15%">流程启动选择执行人:</th>
					<td>
						<input id="showFirstAssignee" type="checkbox" name="showFirstAssignee" value="1"  <c:if test="${bpmDefinition.showFirstAssignee==1 }">checked="checked"</c:if> />
						<a href="#" class="tipinfo"><span>如果勾选，那么流程启动时可以改变下一步的执行人，默认不可以。</span></a>
					</td>	
				</tr>
				<tr>
					<th width="15%">允许API调用:</th>
					<td>
						<input id="isOutForm" type="checkbox" name="isUseOutForm" value="1"  <c:if test="${bpmDefinition.isUseOutForm==1 }">checked="checked"</c:if> />
						<a href="#" class="tipinfo"><span>如果勾选，那么流程执行时会转向设置的url业务表单上去。</span></a>
					</td>	
				</tr>
				<tr>
					<th width="15%">表单明细Url:</th>
					<td>
						<input id="formDetailUrl" class="inputText" style="width:300px;" type="text" name="formDetailUrl" value="${bpmDefinition.formDetailUrl}"   />
						<a href="#" class="tipinfo"><span>地址写法规则为：如果表单页面平台在同一个应用中，路径从根开始写,不需要上下文路径。如果需要使用的表单不再同一个应用下。则需要写完整路径如:http://***/crm/addUser.ht 。</span></a>
					</td>	
				</tr>
			</table>
			</div>
			<input type="hidden" id="defId" name="defId" value="${bpmDefinition.defId }">
</body>
</html>
