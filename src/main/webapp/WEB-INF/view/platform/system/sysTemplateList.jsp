<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>模板管理列表</title>
<%@include file="/commons/include/get.jsp"%>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">模板管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link search" id="btnSearch">查询</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link add" href="edit.ht">添加</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link del" action="del.ht">删除</a>
					</div>
				</div>
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">类型: <select id="Q_templateType_S"
							name="Q_templateType_S" style="width: 100px !important"
							class="select">
								<option value="">全部</option>
								<option value="1"
									<c:if test='${sysTemplateItem.templateId==1}'>selected</c:if>>手机短信</option>
								<option value="2"
									<c:if test='${sysTemplateItem.templateId==2}'>selected</c:if>>邮件</option>
								<option value="3"
									<c:if test='${sysTemplateItem.templateId==3}'>selected</c:if>>站内消息
								</option>
						</select>
						</span> <span class="label">模板名称:</span><input type="text" name="Q_name_SL" class="inputText" value="${param['Q_name_SL']}"/>
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
			<c:set var="checkAll">
				<input type="checkbox" id="chkall" />
			</c:set>
			<display:table name="sysTemplateList" id="sysTemplateItem"
				requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"
				export="true" class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
					<input type="checkbox" class="pk" name="templateId" value="${sysTemplateItem.templateId}">
				</display:column>

				<display:column property="name" title="模板名称" sortable="true"
					sortName="name"></display:column>
					
				<display:column title="类型" sortable="true" sortName="templateType">
					<c:choose>
						<c:when test="${sysTemplateItem.templateType==1}">
							<span class="red">手机短信</span>
								   	</c:when>
						<c:when test="${sysTemplateItem.templateType==2}">
									         <span class="brown">邮件 </span>
								   	</c:when>
						<c:otherwise>
								      	<span class="green">站内消息 </span>
								  </c:otherwise>
					</c:choose>
				</display:column>
				
				<display:column title="模板来源">
					<c:choose>
						<c:when test="${sysTemplateItem.isSystemTemp==0}">
					         <span class="green">自定义模板</span>
					   	</c:when>
						<c:when test="${sysTemplateItem.isSystemTemp==1}">
					        <span class="red">系统模板</span>
				   		</c:when>
						<c:otherwise>
					      	<span class="brown">其他</span>    
					  	</c:otherwise>
					</c:choose>
				</display:column>
				
				<display:column title="管理" media="html" style="width:260px;text-align:center">
					<c:choose>
						<c:when test="${sysTemplateItem.isDefault==1}">
							<a class="link setting disabled">设置默认</a>
						</c:when>
						<c:otherwise>
							<a class="link setting" href="setDefault.ht?templateId=${sysTemplateItem.templateId}&tempType=${sysTemplateItem.templateType}">设置默认</a>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${sysTemplateItem.isSystemTemp==1}">
							<a class="link del disabled">删除</a>
						</c:when>
						<c:otherwise>
							<a href="del.ht?templateId=${sysTemplateItem.templateId}" class="link del">删除</a>
						</c:otherwise>
					</c:choose>					
					<a href="edit.ht?templateId=${sysTemplateItem.templateId}"
						class="link edit">编辑</a>
					<a href="get.ht?templateId=${sysTemplateItem.templateId}"
						class="link detail">明细</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="sysTemplateItem" />
		</div>
	</div>
</body>
</html>


