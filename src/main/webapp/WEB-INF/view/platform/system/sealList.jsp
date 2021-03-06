
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<%@include file="/commons/include/get.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>电子印章管理</title>
<%@include file="/commons/include/get.jsp" %>

</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">电子印章管理列表</span>
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
							&nbsp;
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link add" target="_blank"  href="${ctx}/cloud/research/office.ht?fileId=10000028210096">在线电子签章</a></div>
							
						</div>	
					</div>
					<div class="panel-search">
							<form id="searchForm" method="post" action="list.ht">
									<div class="row">
										<span class="label">印章名:</span><input type="text" name="Q_sealName_SL"  class="inputText" value="${param['Q_sealName_SL']}"/>								
										<span class="label">印章持有者姓名:</span><input type="text" name="Q_belongName_SL"  class="inputText" value="${param['Q_belongName_SL']}"/>
									</div>
							</form>
					</div>
				</div>
				<div class="panel-body">
					
				
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="sealList" id="sealItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="sealId" value="${sealItem.sealId}">
							</display:column>
							<display:column property="sealName" title="印章名" sortable="true" sortName="sealName"></display:column>
							
							<display:column property="belongName" title="印章持所属单位或个人" sortable="true" sortName="belongName"></display:column>
							<display:column title="管理" media="html" style="width:180px;text-align:center">
								<a href="del.ht?sealId=${sealItem.sealId}" class="link del">删除</a>
								<a href="edit.ht?sealId=${sealItem.sealId}" class="link edit">编辑</a>
								<a href="get.ht?sealId=${sealItem.sealId}" class="link detail">明细</a>
							</display:column>
						</display:table>
						<cosim:paging tableId="sealItem"/>
					
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
</html>


