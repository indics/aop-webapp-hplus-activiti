<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>cloud_saas_form管理</title>
<%@include file="/commons/include/get.jsp" %>

</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">cloud_saas_form管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link add" href="edit.ht">添加</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link update" id="btnUpd" action="edit.ht">修改</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del"  action="del.ht">删除</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">公司Id:</span><input type="text" name="Q_companyid_SL"  class="inputText" />
						<span class="label">源Url:</span><input type="text" name="Q_srcurl_SL"  class="inputText" />
						<span class="label">转化Url:</span><input type="text" name="Q_transferurl_SL"  class="inputText" />
						<span class="label">状态:</span><input type="text" name="Q_state_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="saasFormList" id="saasFormItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="id" value="${saasFormItem.id}">
				</display:column>
				<display:column property="companyid" title="公司Id" sortable="true" sortName="companyId"></display:column>
				<display:column property="srcurl" title="源Url" sortable="true" sortName="srcUrl" maxLength="80"></display:column>
				<display:column property="transferurl" title="转化Url" sortable="true" sortName="transferUrl" maxLength="80"></display:column>
				<display:column property="state" title="状态" sortable="true" sortName="state"></display:column>
				<display:column title="管理" media="html" style="width:180px">
					<a href="del.ht?id=${saasFormItem.id}" class="link del">删除</a>
					<a href="edit.ht?id=${saasFormItem.id}" class="link edit">编辑</a>
					<a href="get.ht?id=${saasFormItem.id}" class="link detail">明细</a>
					
				</display:column>
			</display:table>
			<cosim:paging tableId="saasFormItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


