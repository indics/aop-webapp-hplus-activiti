<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>系统岗位表管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">${parent.posName }</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<f:a alias="postEdit" href="edit.ht?parentId=${parentId}" css="link add" name="添加">添加</f:a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<f:a id="btnUpd" alias="postEdit" action="edit.ht" css="link update" name="修改">修改</f:a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<f:a alias="delPosition" action="del.ht" css="link del" >删除</f:a>
					</div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<input type="hidden" name="Q_nodePath_S"  value="${ Q_nodePath_S}" />
						<span class="label">岗位名称:</span><input type="text" name="Q_posName_SL"  class="inputText" value="${param['Q_posName_SL']}"/>
					</div>
				</form>
			</div>		
		</div> 
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="positionList" id="positionItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
					  	<input type="checkbox" class="pk" name="posId" value="${positionItem.posId}">
				</display:column>
				<display:column property="posName" title="岗位名称"  style="width:300px;"></display:column>
				<display:column property="posDesc" title="岗位描述"  maxLength="250" ></display:column>
				<display:column title="管理" media="html" style="width:300px;text-align:center">
					<f:a  alias="delPosition" href="del.ht?posId=${positionItem.posId}" css="link del" >删除</f:a>
					<f:a  alias="postEdit" href="edit.ht?posId=${positionItem.posId}" css="link edit" name="编辑">编辑</f:a>
					<a href="${ctx}/platform/system/userPosition/edit.ht?posId=${positionItem.posId}" class="link auth">人员设置</a>
					<a href="${ctx}/platform/system/userPosition/get.ht?posId=${positionItem.posId}" class="link detail">人员明细</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="positionItem"/>
			
		</div>				
	</div> 
</body>
</html>


