<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cosim.platform.model.bpm.BpmDefRights"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的流程定义列表</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/FlowUtil.js" ></script>
</head>
<body>      
			<div class="panel">
				<div class="panel-top">
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link search" id="btnSearch">查询</a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="selector.ht">
							<div class="row">
								<span class="label">&nbsp;&nbsp;&nbsp;标题:</span><input type="text" name="Q_subject_S"  class="inputText" style="width:13%;" value="${param['Q_subject_S']}"/>
								<span class="label">描述:</span><input type="text" name="Q_descp_S" class="inputText" maxlength="125" style="width:13%;" value="${param['Q_descp_S']}"/>
								<span class="label">创建时间:</span><input type="text" name="Q_createtime_DL"  class="inputText date" style="width:13%;" value="${param['Q_createtime_DL']}"/>
								<span class="label">至</span><input name="Q_endcreatetime_DG" class="inputText date" style="width:13%;" value="${param['Q_endcreatetime_DG']}"/>
							</div>
						</form>
					</div>					
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="bpmDefinitionList" id="bpmDefinitionItem" requestURI="selector.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="defId" value="${bpmDefinitionItem.defId}">
								  	<input type="hidden" name="subject" value="${bpmDefinitionItem.subject}"/>
								  	<input type="hidden" name="defKey" value="${bpmDefinitionItem.defKey}"/>
							</display:column>
							<display:column property="subject" title="标题" sortable="true" sortName="subject" ></display:column>
							
							<display:column title="分类" sortable="true" sortName="typeName">
								<c:out value="${bpmDefinitionItem.typeName}"></c:out>
							</display:column>
							<display:column property="versionNo" title="版本" sortable="true" sortName="versionNo" style="width:60px"></display:column>
							
							<display:column title="创建时间" sortable="true" sortName="createtime" style="width:100px">
								<fmt:formatDate value="${bpmDefinitionItem.createtime}" pattern="yyyy-MM-dd"/>
							</display:column>
						</display:table>
						<cosim:paging tableId="bpmDefinitionItem"/>
					</div>
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
</html>


