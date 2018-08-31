
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业列表</title>
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
		<form id="searchForm" method="post" action="compSelector.ht">
			<div class="row">
				<span class="label">企业名:</span><input type="text" name="Q_name_SL"  class="inputText" />
				<span class="label">行业:</span><input type="text" name="Q_industry_SL"  class="inputText" />
			</div>
		</form>
	</div>
	<br />
 <display:table name="sysOrgInfoList" id="sysOrgInfoItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="sysOrgInfoId" value="${sysOrgInfoItem.sysOrgInfoId}">
				</display:column>
				<display:column property="email" title="EMAIL" sortable="true" sortName="email" maxLength="80"></display:column>
				<display:column property="name" title="NAME" sortable="true" sortName="name" maxLength="80"></display:column>
				<display:column property="industry" title="INDUSTRY" sortable="true" sortName="industry" maxLength="80"></display:column>
				<display:column property="scale" title="SCALE" sortable="true" sortName="scale" maxLength="80"></display:column>
				<display:column property="address" title="ADDRESS" sortable="true" sortName="address" maxLength="80"></display:column>
				<display:column property="postcode" title="POSTCODE" sortable="true" sortName="postcode" maxLength="80"></display:column>
				<display:column property="connecter" title="CONNECTER" sortable="true" sortName="connecter"></display:column>
				<display:column property="tel" title="TEL" sortable="true" sortName="tel"></display:column>
				<display:column property="fax" title="FAX" sortable="true" sortName="fax"></display:column>
				<display:column property="homephone" title="HOMEPHONE" sortable="true" sortName="homephone"></display:column>
			</display:table>
			<cosim:paging tableId="sysOrgInfoItem"/>
</body>
</html>


