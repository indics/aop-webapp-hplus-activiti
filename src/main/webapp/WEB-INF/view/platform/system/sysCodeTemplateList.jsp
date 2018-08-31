<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>自定义表代码模版管理</title>
<%@include file="/commons/include/get.jsp" %>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义表代码模版管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link add" href="edit.ht">添加</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link update" id="btnUpd" action="edit.ht">修改</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link init" id="btnInit" action="init.ht">初始化模版</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">模版名称:</span><input type="text" name="Q_tamplateName_SL"  class="inputText" />
						<span class="label">别名:</span><input type="text" name="Q_templateAlias_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="sysCodeTemplateList" id="sysCodeTemplateItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="id" value="${sysCodeTemplateItem.id}">
				</display:column>
				<display:column property="templateName" title="模版名称" sortable="true" sortName="tamplateName"></display:column>
				<display:column property="templateAlias" title="别名" sortable="true" sortName="templateAlias"></display:column>
				<display:column property="memo" title="备注" sortable="true" sortName="memo"></display:column>
				<display:column  title="模版类型" sortable="true" sortName="templateType">
				<c:choose >
					<c:when test="${sysCodeTemplateItem.templateType==1}"><span class="red">系统模版</span></c:when>
				</c:choose>
				</display:column>
				<display:column title="管理" media="html" style="width:180px">
					<c:if test="${sysCodeTemplateItem.templateType==0}">
					<a href="del.ht?id=${sysCodeTemplateItem.id}" class="link del">删除</a>
					</c:if>
					<a href="edit.ht?id=${sysCodeTemplateItem.id}" class="link edit">编辑</a>
					<a href="get.ht?id=${sysCodeTemplateItem.id}" class="link detail">明细</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="sysCodeTemplateItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


