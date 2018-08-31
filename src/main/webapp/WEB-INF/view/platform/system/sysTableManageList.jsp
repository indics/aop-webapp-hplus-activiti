
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自定义表管理管理列表</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript"src="${ctx}/js/cosim/platform/system/AddResourceDialog.js"></script>

<script type="text/javascript">
	function preview(id){
		var url=__ctx+ "/platform/system/sysTableManage/preview.ht?__displayId__="+id;
		var winArgs="dialogWidth=800px;dialogHeight=600px;help=0;status=0;scroll=0;center=1";
		url=url.getNewUrl();
		window.showModalDialog(url,{},winArgs);
	}
	
	function addToResource(id,name){
		var url="/platform/system/sysTableManage/preview.ht?__displayId__="+id;
		AddResourceDialog({addUrl:url,name:name});
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义表管理管理列表</span>
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
									<span class="label">名称:</span><input type="text" name="Q_name_SL"  class="inputText" value="${param['Q_name_SL']}"/>
									<span class="label">别名:</span><input type="text" name="Q_alias_SL"  class="inputText" value="${param['Q_alias_SL']}"/>
							</div>
					</form>
			</div>
		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="sysTableManageList" id="sysTableManageItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
					<display:column title="${checkAll}" media="html" style="width:30px;">
						  	<input type="checkbox" class="pk" name="id" value="${sysTableManageItem.id}">
					</display:column>
					<display:column property="name" title="名称" sortable="true" sortName="name"></display:column>
					<display:column property="alias" title="别名" sortable="true" sortName="alias"></display:column>
<%-- 							<display:column  title="显示样式" sortable="true" sortName="style"> --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${sysTableManageItem.style==0}"> --%>
<!-- 										<span class="green">列表</span> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<span class="red">树形</span> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
<%-- 							</display:column> --%>
					<display:column  title="是否为表" sortable="true" sortName="isTable">
						<c:choose>
							<c:when test="${sysTableManageItem.isTable==0}">
								<span class="red">视图</span>
							</c:when>
							<c:otherwise>
								<span class="green">数据库表</span>
							</c:otherwise>
						</c:choose>
					</display:column>
					<display:column property="objName" title="对象名称" sortable="true" sortName="objName"></display:column>
					<display:column property="dsAlias" title="数据源名称" sortable="true" sortName="dsAlias"></display:column>
					<display:column title="管理" media="html" style="width:300px;text-align:center">
						<a href="del.ht?id=${sysTableManageItem.id}" class="link del">删除</a>
						<a href="edit.ht?id=${sysTableManageItem.id}" class="link edit">编辑</a>
						<a href="editDspTemplate.ht?id=${sysTableManageItem.id}" class="link redo">修改模板</a>
						<a href="#" onclick="preview('${sysTableManageItem.id}')"  class="link detail">预览</a>
						<a href="#" onclick="addToResource('${sysTableManageItem.id}','${sysTableManageItem.name}')"  class="link collapse">添加为菜单</a>
					</display:column>
				</display:table>
				<cosim:paging tableId="sysTableManageItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


