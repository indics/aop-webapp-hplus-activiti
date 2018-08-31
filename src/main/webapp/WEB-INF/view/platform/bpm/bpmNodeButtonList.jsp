<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>节点设置管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>

<script type="text/javascript">

$(function(){
	$("a.link.init").unbind("click");
	$("a.link.del").unbind("click");
	init();
	clear();
});

function init(){
	$.confirm("a.link.init",'确认初始化按钮吗？');
}

function clear(){
	$.confirm("a.link.del",'确认清除该流程定义的所有按钮吗？');
}
</script>

</head>
<body>
    
    <jsp:include page="incDefinitionHead.jsp">
   		<jsp:param value="节点操作按钮" name="title"/>
	</jsp:include>
    <f:tab curTab="操作按钮管理" tabName="flow"/>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流程任务审批按钮设置</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link init"  href="initAll.ht?defId=${bpmDefinition.defId}">初始化全部按钮</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del" href="delByDefId.ht?defId=${bpmDefinition.defId}">清除按钮配置</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			
				<form action="save.ht" method="post" id="dataForm">
				    <input type="hidden" name="defId" value="${bpmDefinition.defId}"/>
					
							<table cellpadding="1" cellspacing="1" class="table-detail" style="margin-bottom: 4px;">
								<tr >
									<th  width="15%">流程启动表单:</th>
									<td>
										<c:set var="btnList" value="${btnMap.start}"></c:set>
										<c:choose>
											<c:when test="${empty btnList }">
												启动流程,流程示意图,打印,通知方式【短信，邮件】
											</c:when>
											<c:otherwise>
												<c:forEach items="${btnList}" var="btn" varStatus="status" >
													${btn.btnname}<c:if test="${!status.last}">,</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</td>
									<td >
										<a class="link edit" href="getByNode.ht?defId=${bpmDefinition.defId}">编辑</a>
										
										<a class="link init" href="init.ht?defId=${bpmDefinition.defId}">初始化</a>
										
										<a  class="link del"  href="deByDefNodeId.ht?defId=${bpmDefinition.defId}">删除</a>
									</td>
								</tr>
							</table>
					    <table cellpadding="1" cellspacing="1" class="table-grid table-list">
							<thead>
							<tr>
								<th>序号</th>
								<th>节点名</th>
								<th>类型</th>
								<th>
									操作按钮
								</th>
								<th>
									管理
								</th>
							</tr>
							</thead>
							<c:forEach items="${bpmNodeSetList}" var="item" varStatus="status">
							<tr>
								<td>
									${status.index +1}
								</td>
								<td>
									<input type="hidden" name="nodeId" value="${item.nodeId}"/>
									<input type="hidden" name="nodeName" value="${item.nodeName}"/>${item.nodeName}
								</td>
								<td>
									<c:choose>
										<c:when test="${taskMap[item.nodeId]==1 }"><span class="red">会签</span> </c:when>
										<c:otherwise><span class="green">普通节点</span></c:otherwise>
									</c:choose>
									
								</td>
								<td nowrap="nowrap">
									<c:set var="btnList" value="${btnMap[item.nodeId] }"></c:set>
									<c:choose>
										<c:when test="${empty btnList }">
											完成任务,交办,驳回,驳回到发起人,流程执行示意图,审批历史,打印,通知方式【短信，邮件】
										</c:when>
										<c:otherwise>
											<c:forEach items="${btnList}" var="btn" varStatus="status" >
												${btn.btnname}<c:if test="${!status.last}">,</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<a class="link edit" href="getByNode.ht?defId=${bpmDefinition.defId}&nodeId=${item.nodeId}">编辑</a>
									<a class="link init" href="init.ht?defId=${bpmDefinition.defId}&nodeId=${item.nodeId}">初始化</a>
									<a  class="link del"  href="deByDefNodeId.ht?defId=${bpmDefinition.defId}&nodeId=${item.nodeId}">删除</a>
								</td>
								
							</tr>
							</c:forEach>
						</table>
						
				</form>
			
		</div>				
	</div>
</body>
</html>





