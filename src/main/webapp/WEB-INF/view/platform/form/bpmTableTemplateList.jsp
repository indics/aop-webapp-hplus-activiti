<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看业务数据</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/FlowRightDialog.js"></script>
</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">业务数据目录</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link search" id="btnSearch">查询</a></div>
							<div class="l-bar-separator"></div>							
							<div class="group"><a class="link del" action="del.ht">删除</a></div>
						</div>	
					</div>
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
								<span class="label">列表模板名:</span><input type="text" name="Q_templateName_SL" class="inputText" value="${param['Q_templateName_SL']}"/>											
							</div>
						</form>
					</div>
				</div>
				<div class="panel-body">
						<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="bpmTableTemplateList" id="bpmTableTemplateItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="id" value="${bpmTableTemplateItem.id}">
							</display:column>
							<display:column property="templateName" title="列表模板名"></display:column>
							<display:column  title="授权类型">
								<c:choose>
									<c:when test="${bpmTableTemplateItem.authorType==1}">
										查看所有数据
									</c:when>
									<c:when test="${bpmTableTemplateItem.authorType==2 }">
										查看本人数据
									</c:when>
									<c:when test="${bpmTableTemplateItem.authorType==3 }">
										查看本人及下属数据
									</c:when>
									<c:when test="${bpmTableTemplateItem.authorType==4 }">
										查看本组织的数据
									</c:when>
								</c:choose>
								
							</display:column>
							<display:column property="tableName" title="表名"></display:column>
							<display:column property="categoryName" title="表单类型 "></display:column>
							<display:column title="管理" media="html" style="width:250px;">								
								<a href="javascript:;" onclick="javascript:jQuery.openFullWindow('edit.ht?id=${bpmTableTemplateItem.id}&ifEdit=1');" class="link edit">编辑</a>
								<a href="del.ht?id=${bpmTableTemplateItem.id}" class="link del">删除</a>
								<a href="javascript:FlowTemplateDialog(${bpmTableTemplateItem.id},0)" class="link grant" title="授权">授权</a>								
							</display:column>
						</display:table>
						<cosim:paging tableId="bpmTableTemplateItem"/>
					
				</div>
			</div>
</body>
</html>


