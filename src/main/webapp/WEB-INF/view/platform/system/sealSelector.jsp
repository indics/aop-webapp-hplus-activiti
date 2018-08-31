
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>电子印章管理</title>
<%@include file="/commons/include/get.jsp"%>
<script type="text/javascript" src="${ctx}/js/ntkosign/NtkoSignManage.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body>
	<div class="panel-toolbar">
		<div class="group">
			<a class="link search" id="btnSearch">查询</a>
		</div>
	</div>
	<div class="panel-search">
		<form id="searchForm" method="post" action="selector.ht">
			<div class="row">
				<span class="label">印章名:</span>
				<input type="text" name="Q_sealName_S" class="inputText" value="${param['Q_sealName_S']}"/> 
				<span class="label">印章持有者姓名:</span>
				<input type="text" name="Q_belongName_S" class="inputText" value="${param['Q_belongName_S']}"/>
			</div>
		</form>
	</div>
	<br />
	<display:table name="sealList" id="sealItem" requestURI="selector.ht" sort="external" cellpadding="1" cellspacing="1"  class="table-grid">
		<display:column media="html" style="width:30px;">
			<input type="radio" class="pk" name="attachmentId" value="${sealItem.attachmentId}" />
		</display:column>
		<display:column property="sealName" title="印章名" sortable="true" sortName="sealName"></display:column>
		<display:column property="belongName" title="印章持所属单位或个人" sortable="true" sortName="belongName"></display:column>
	</display:table>
	<cosim:paging tableId="sealItem" />
</body>
</html>


