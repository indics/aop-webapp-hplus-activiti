<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>流程节点人员设置</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/get.jsp" %>
	<%@include file="/commons/include/nodeUserConditionJS.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/ScriptDialog.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerMsg.js"></script>
	<script type="text/javascript">
		$(function(){
			$("a.del").unbind("click");
			$("div.group > a.link.update").unbind('click');
			$('#btnReflesh').attr('href',window.location.href);
		});
		
		function repairDisposableData(){
			$.post(__ctx+"/platform/bpm/bpmDefinition/repairDisposableData.ht", {},function(data){
				var result=eval('('+data+')');
				if(result.result==1){
					$.ligerMessageBox.warn(result.message+",请自行刷新页面");
				}else{
					$.ligerMessageBox.warn(result.message);
				}					
			});	
			
		}
	</script>
	
	<base target="_self" />
</head>
<body>	
	<c:if test="${empty nodeTag}">
	    <jsp:include page="incDefinitionHead.jsp">
		    	<jsp:param value="节点人员设置" name="title"/>
		</jsp:include>
		<f:tab curTab="人员设置" tabName="flow"/>
	</c:if>
	<div class="panel">
			<div class="panel-top">
				<div class="tbar-title">
					<span class="tbar-label">流程定义节点人员设置</span>
				</div>
<!-- 			<div class="panel-toolbar"> -->
<!-- 				<div class="toolBar">  -->
<!-- 					<div class="group"><a class="link update" onclick="repairDisposableData()">一键修复数据</a></div> -->
<!-- 				</div>	 -->
<!-- 			</div> -->
		</div>
		<div class="panel-body">
			<form action="saveUser.ht" method="post" id="defUserForm">
				<input type="hidden" name="defId" value="${defId}"/>
				<input type="hidden" name="nodeTag" value="${nodeTag}"/>
				<table class="table-grid" style="width:100%">
					<thead>
					<tr>
						<th width="15" nowrap="nowrap">序号</th>
						<th >节点名称</th>
						<th width="*">节点人员</th>
					</tr>
					</thead>
					<tbody>
						<c:forEach items="${nodeUserMapList}" var="nodeUserMap" varStatus="i">
							<tr>
								<td>${i.count}</td>
								<td>${nodeUserMap.nodeName}(${nodeUserMap.nodeId})</td>
								<td>
									<%@include file="/commons/include/nodeUserCondition.jsp" %>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div style="height:40px"></div>
			</form>
			
		</div>				
	</div>
	<div id="divScriptData" style="display: none;">
		<a href="#" id="btnScript" class="link var" title="常用脚本" onclick="selectScript()">常用脚本</a>
		<ul>
			<li>可以使用的流程变量,[startUser],开始用户,<li>[startUser],上个任务的用户[prevUser]。</li>
			<li>表达式必须返回Set&lt;String&gt;集合类型的数据,集合元素为用户Id。</li>
		</ul>
		<textarea id="txtScriptData" rows="10" cols="80" style="height: 200px;width:480px"></textarea>
	</div>
	<a href="#" id="btnReflesh" class="hidden" >刷新页面</a>
</body>
</html>
