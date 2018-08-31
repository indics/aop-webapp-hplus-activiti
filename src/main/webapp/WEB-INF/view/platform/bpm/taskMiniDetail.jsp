<%
	//用于任务管理(taskList.jsp)中的某一任务的右边明细显示 
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<script>
	var taskId="${taskEntity.id}";
	$(function(){
		
		var menuItem={ width: 120, items:[
  					            { id:'changePath',taskId:taskId,text: '更改执行路径', click: itemclick},
  					            { id:'completeTask', taskId:taskId,text: '完成任务', click: itemclick},
  					            { id:'approvalDetail',taskId:taskId, text: '审批明细', click: itemclick},
  					            { id:'businessForm',taskId:taskId, text: '业务表单', click: itemclick}
  					           ]
  					        };
		//加上菜单
	 	$("div[name='taskMenu']").ligerMenuBar({ items: [
        				{ text: '<a href="#">更多任务操作</a>', menu: menuItem}]
		});
		
		$("div[name='taskMenu']").removeClass('l-menubar');
	});
	function itemclick(item){
	    if(item.id=='changePath'){//更改执行路径
	    	var winArgs="dialogWidth=680px;dialogHeight=340px;help=0;status=0;scroll=1;center=1";
			url=__ctx + "/platform/bpm/task/changePath.ht?taskId="+ item.taskId;
			url=url.getNewUrl();
			window.showModalDialog(url,"",winArgs);
	    }else if(item.id=='completeTask'){//结束任务
	    	$.ligerMessageBox.confirm('提示信息','确定结束该任务吗?',function(rtn){
	    		if(!rtn) return;
	    		url=__ctx + "/platform/bpm/task/end.ht?taskId="+ item.taskId;
   				$.post(url,function(responseText){
   					var obj=new com.cosim.form.ResultMessage(responseText);
   					if(obj.isSuccess()){//成功
   						$.ligerMessageBox.success('提示信息',obj.getMessage(),function(){
   							location.href=__ctx + "/platform/bpm/task/list.ht";
   						});
   					}
   					else{
   						$.ligerDialog.err('出错信息',"结束该流程失败",obj.getMessage());
   					}
   				});
	    	});	
	    }else if(item.id=='approvalDetail'){
	    	var winArgs="dialogWidth=780px;dialogHeight=600px;help=0;status=0;scroll=1;center=1";
	    	var url=__ctx + '/platform/bpm/taskOpinion/list.ht?taskId='+item.taskId;
	    	url=url.getNewUrl();
			window.showModalDialog(url,"",winArgs);
	    }else if(item.id=='taskComment'){// 任务评论
	    	TaskCommentWindow({taskId:item.taskId});
	    }
	    else if(item.id=="businessForm"){
	    	var url=__ctx+ '/platform/bpm/task/getForm.ht?taskId='+item.taskId;
	    	jQuery.openFullWindow(url);
	    }
	}
</script>
<div class="panel-toolbar">
	<div class="toolBar">
		<div class="group"><div name="taskMenu"></div></div>
	</div>
</div>
<table class="table-detail" style="width:100%">
	<tr>
		<th nowrap="nowrap" width="100">流程事项名称</th>
		<td width="*">
			${processRun.subject}
		</td>
	</tr>
	<tr>
		<th>任务ID</th>
		<td>${taskEntity.id}</td>
	</tr>
	<tr>
		<th nowrap="nowrap">
			流程运行(RUNID)
		</th>
		<td>${processRun.runId}</td>
	</tr>
	<tr>
		<th nowrap="nowrap">任务名</th>
		<td>${taskEntity.name}</td>
	</tr>
	<tr>
		<th>任务描述</th>
		<td>
			<c:choose>
				<c:when test="${not empty task.description}">
					${taskEntity.description}
				</c:when>
				<c:otherwise>${taskEntity.name}</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap">所属人</th>
		<td>
		 <span><f:userName userId="${taskEntity.owner}"/></span>&nbsp; <c:if test="${not empty param['manage']}"><a href='#' class='button' onclick="setTaskOwner(this,${taskEntity.id})"><span>更改..</span></c:if> </a>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap">执行人</th>
		<td>
			<span><f:userName userId="${taskEntity.assignee}"/></span>&nbsp;<c:if test="${not empty param['manage']}"><a href='#' class='button' onclick="setTaskAssignee(this,${taskEntity.id})"><span>更改..</span></c:if></a>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap">候选执行人</th>
		<td>
			<c:choose>
				<c:when test="${fn:length(candidateUsers)==0}">
					<font color='red'>暂无</font>
				</c:when>
				<c:otherwise>
					<c:forEach items="${candidateUsers}" var="executor">
						<c:if test="${not empty executor }">
						<c:set var="type" >
							<c:choose>
								<c:when test="${executor.type eq 'org' }">(组织)</c:when>
								<c:when test="${executor.type eq 'role' }">(角色)</c:when>
								<c:when test="${executor.type eq 'pos' }">(岗位)</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:set>
						<img src='${ctx}/styles/default/images/bpm/user-16.png'>${executor.executor}${type }
						</c:if>
					</c:forEach>		
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th>当前活动任务</th>
		<td>
			<c:forEach items="${curTaskList}" var="curTask" varStatus="i"><c:if test="${i.count>1}">,</c:if>${curTask.name}(<f:userName userId="${curTask.assignee}"/>)</c:forEach>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap">创建时间</th>
		<td>
			<fmt:formatDate value="${taskEntity.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap">到期时间</th>
		<td>
			<fmt:formatDate value="${taskEntity.dueDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</td>
	</tr>
</table>
<br/>
<table class="table-detail" style="width:100%">
	<tr>
		<th nowrap="nowrap" width="100">流程定义名称</th>
		<td>${processDefinition.subject}</td>
	</tr>
	<tr>
		<th>版本</th>
		<td>
			${processDefinition.versionNo}
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap">流程定义描述</th>
		<td>
			${processDefinition.descp}
		</td>
	</tr>
	
</table>

