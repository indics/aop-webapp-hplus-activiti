<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看业务数据</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
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
						</div>	
					</div>
					<div class="panel-search">
						<form id="searchForm" method="post" action="myList.ht">
							<div class="row">
								<span class="label">列表模板名:</span><input type="text" name="Q_templateName_SL" class="inputText" value="${param['Q_templateName_SL']}"/>											
							</div>
						</form>
					</div>
				</div>
				<div class="panel-body">
					 <display:table name="bpmTableTemplateList" id="bpmTableTemplateItem" requestURI="myList.ht" sort="external" cellpadding="1" cellspacing="1"  class="table-grid">						
							<display:column property="templateName" title="列表模板名"></display:column>
							<display:column property="tableName" title="表名"></display:column>
							<display:column property="categoryName" title="表单类型 "></display:column>
							<display:column title="管理" media="html" style="width:250px;text-align:center">
								<a href="get.ht?id=${bpmTableTemplateItem.id}" class="link detail">查看业务数据</a>
							</display:column>
					  </display:table>
					  <cosim:paging tableId="bpmTableTemplateItem"/>
					
				</div>
			</div>
</body>
</html>


