
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
</head>
<body>
    
    <jsp:include page="incDefinitionHead.jsp">
    	<jsp:param value="流程实例列表" name="title"/>
    </jsp:include>
	<f:tab curTab="流程实例" tabName="flow"/>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流程实例查询</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search " id="btnSearch">查询</a></div>
				</div>	
			</div>
			<div class="panel-search">
					<form id="searchForm" method="post" action="${ctx}/platform/bpm/bpmDefinition/instance.ht">
							<div class="row">
										<input type="hidden" name="defId" value="${bpmDefinition.defId}"/>
										<span class="label">流程实例标题:</span><input type="text" name="Q_subject_SL"  class="inputText" value="${param['Q_subject_SL']}"/>
										<span class="label">创建时间 从:</span> <input size="12"  name="Q_begincreatetime_DL"  class="inputText date" value="${param['Q_begincreatetime_DL']}"/>
										<span class="label">至: </span><input size="12" name="Q_endcreatetime_DG" class="inputText date" value="${param['Q_endcreatetime_DG']}"/>
										<span class="label">状态:</span>
											<select name="Q_status_SN" value="${param['Q_status_SN']}">
												<option value="">所有..</option>
												<option value="1" <c:if test="${param['Q_status_SN'] == 1}">selected</c:if>>正在运行</option>
												<option value="2" <c:if test="${param['Q_status_SN'] == 2}">selected</c:if>>结束</option>
											</select>
							</div>
					</form>
			</div>
		</div>
		<div class="panel-body">
			
			
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="processRunList" id="processRunItem" requestURI="instance.ht" sort="external" cellpadding="1" cellspacing="1"  class="table-grid">
					<display:column title="${checkAll}" media="html" style="width:30px;">
						  	<input type="checkbox" class="pk" name="runId" value="${processRunItem.runId}">
					</display:column>
					<display:column property="subject" title="流程实例标题" sortable="true" sortName="subject" style="text-align:left"></display:column>
					<display:column property="creator" title="创建人" sortable="true" sortName="creator"></display:column>
					<display:column  title="创建时间" sortable="true" sortName="createtime">
						<fmt:formatDate value="${processRunItem.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</display:column>
					<display:column  title="结束时间" sortable="true" sortName="endTime">
						<fmt:formatDate value="${processRunItem.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</display:column>
					<display:column property="duration" title="持续时间" sortable="true" sortName="duration"></display:column>
					
					<display:column title="状态" sortable="true" sortName="status">
						<c:choose>
							<c:when test="${processRunItem.status==1}">
								<font color='green'>正在运行</font>
							</c:when>
							<c:when test="${processRunItem.status==2}">
								结束
							</c:when>
						</c:choose>
					</display:column>
					<display:column title="管理" media="html" style="width:180px">
						<a href="${ctx }/platform/bpm/processRun/get.ht?runId=${processRunItem.runId}" class="link detail">明细</a>
					</display:column>
				</display:table>
				<cosim:paging tableId="processRunItem"/>
		
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


