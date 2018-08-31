<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>我的待办任务</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
<script type="text/javascript">
function executeTask(taskId){
	 var url="${ctx}/platform/bpm/task/toStart.ht?taskId="+taskId;
	 jQuery.openFullWindow(url);
}
//更改任务执行用户
function changeTaskUser(taskId,taskName){
	//显示用户选择器
	UserDialog({
		isSingle:true,
		callback:function(userId,fullname){
			if(userId=='' || userId==null || userId==undefined) return;
			var url='${ctx}/platform/bpm/task/delegate.ht';
			var params= {taskId:taskId,userId:userId };
			$.post(url,params,function(responseText){
				var obj=new com.cosim.form.ResultMessage(responseText);
				//成功
				if(obj.isSuccess()){
					$.ligerMessageBox.success('提示信息','任务交办成功!',function(){
			    		 location.reload();	 
			    	 });
				}
				else{
					$.ligerMessageBox.error('提示信息','任务交办失败!');
				}
			});
		}
	});
}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">任务管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="forMeWithSecurity.ht">
					<div class="row">
						<span class="label">流程定义名称:</span>
						<select name="Q_processName_SL" >
						<option value="">所有</option>
						<option value="公开询盘流程">公开询盘流程</option>
						<option value="定向询盘流程">定向询盘流程</option>
						<option value="询盘应答流程">询盘应答流程</option>
						<option value="询盘优选流程">询盘优选流程</option>
						<option value="试制流程">试制流程</option>
						<option value="发布能力流程">发布能力流程</option>
						
						<option value="甲方添加合同">甲方添加合同</option>
						<option value="甲方验收合同">甲方验收合同</option>
						<option value="甲方审查合同执行节点">甲方审查合同执行节点</option>
						
						<option value="乙方交付合同">乙方交付合同</option>
						<option value="乙方上报合同执行节点">乙方上报合同执行节点</option>
						
						</select>
						<span class="label">事项名称:</span><input type="text" name="Q_subject_SL"  class="inputText" style="width:13%;" value="${param['Q_subject_SL']}"/>
						<span class="label">任务名称:</span><input type="text" name="Q_name_SL"  class="inputText" style="width:13%;" value="${param['Q_name_SL']}"/>
						
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
			
			
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="taskList" id="taskItem" requestURI="forMeWithSecurity.ht" sort="external" cellpadding="1" cellspacing="1"  class="table-grid">
					<display:column title="${checkAll}" media="html" style="width:30px;">
						  	<input type="checkbox" class="pk" name="id" value="${taskItem.id}">
					</display:column>
					<display:column property="subject" title="事项名称" style="text-align:left"></display:column>
					<display:column property="processName" title="流程定义名称" style="text-align:left"></display:column>
					<display:column property="name" title="任务名称" sortable="true" sortName="name_" style="text-align:left"></display:column>
					
					<display:column title="执行人" sortable="true" sortName="assignee_" style="text-align:left">
						<f:userName userId="${taskItem.assignee}"/>
					</display:column>
					<display:column title="创建时间" sortable="true" sortName="create_time_">
						<fmt:formatDate value="${taskItem.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</display:column>
					
					<%--
					<display:column title="所属人" sortable="true" sortName="owner_" style="text-align:left">
						<f:userName userId="${taskItem.owner}"/>
					</display:column>
					<display:column title="到期时间" sortable="true" sortName="due_date_">
						<fmt:formatDate value="${taskItem.dueDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</display:column>
					--%>
					<display:column title="管理" media="html" style="width:240px;">	
						<a href="detail.ht?taskId=${taskItem.id}" class="link detail" title="明细">明细</a>				
						<c:choose>
							<c:when test="${not empty taskItem.assignee && empty taskItem.executionId && taskItem.description=='通知任务' }">
								<a href="javascript:executeTask(${taskItem.id})" class="link run" title="主办">主办</a>
								<!-- <a href="${ctx}/platform/bpm/task/toStart.ht?taskId=${taskItem.id}" class="link run" title="主办">主办</a> -->
							</c:when>
							<c:when test="${not empty taskItem.assignee && not empty taskItem.executionId }">
								<a href="javascript:executeTask(${taskItem.id})" class="link run" title="主办">主办</a>
								<!-- <a href="${ctx}/platform/bpm/task/toStart.ht?taskId=${taskItem.id}" class="link run" title="主办">主办</a> -->
								<c:if test="${not empty candidateMap[taskItem.id] }">
								       		<a href="unlock.ht?taskId=${taskItem.id}" class="link unlock" title="解锁">解锁</a>
								</c:if> 
								<!-- <a href="javascript:changeTaskUser(${taskItem.id},'${taskItem.name}')" class="link goForward" title="交办">交办</a> -->
							</c:when>
							<c:otherwise >
								<a href="claim.ht?taskId=${taskItem.id}" class="link lock" title="锁定">锁定</a>
							</c:otherwise>
						</c:choose>	
					</display:column>
				</display:table>
				<cosim:paging tableId="taskItem"/>
			
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


