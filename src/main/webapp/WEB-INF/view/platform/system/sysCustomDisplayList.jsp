<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>自定义显示管理</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/ajaxgrid.js" ></script>
<script type="text/javascript">
	$(function(){
		$("a.preview").click(function(){
			var href=$(this).attr("action");
			var url=__ctx+ "/platform/system/sysCustomDisplay/"+href;
			var winArgs="dialogWidth=1024px;dialogHeight=600px;help=0;status=0;scroll=0;center=1";
			url=url.getNewUrl();
			rtn = window.showModalDialog(url,"",winArgs);
		});
		
		$("a.add,a.edit,a.update").click(function(){
			var href=$(this).attr("action");
			var url=__ctx+ "/platform/system/sysCustomDisplay/"+href;
			var winArgs="dialogWidth=1024px;dialogHeight=600px;help=0;status=0;scroll=0;center=1";
			url=url.getNewUrl();
			rtn = window.showModalDialog(url,"",winArgs);
			if(rtn){
				window.location.reload();
			}
		});
	});
	
	function editDialog(){
		var winArgs="dialogWidth=800px;dialogHeight=600px;help=0;status=0;scroll=0;center=1";
		var url=$(obj).attr("action");
		url=url.getNewUrl();
		window.showModalDialog(url,{},winArgs);
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义显示管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link add" action="edit.ht">添加</a></div>
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
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="sysCustomDisplayList" id="sysCustomDisplayItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="id" value="${sysCustomDisplayItem.id}">
				</display:column>
				<display:column property="name" title="名称" sortable="true" sortName="name"></display:column>
<%-- 				<display:column title="分页" sortable="true" sortName="needPage"> --%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${sysCustomDisplayItem.needPage==1}"> --%>
<!-- 							<span class="green">分页</span> -->
<%-- 						</c:when> --%>
<%-- 						<c:when test="${sysCustomDisplayItem.needPage==-1}"> --%>
<!-- 							<span class="brown">不分页</span> -->
<%-- 						</c:when> --%>
<%-- 					</c:choose> --%>
<%-- 				</display:column> --%>
<%-- 				<display:column property="pageSize" title="分页大小" sortable="true" sortName="pageSize"></display:column> --%>
				<display:column property="description" title="描述" sortable="true" sortName="description" maxLength="80"></display:column>
				<display:column title="管理" media="html" style="width:280px">
					<a href="del.ht?id=${sysCustomDisplayItem.id}" class="link del">删除</a>
					<a action="edit.ht?id=${sysCustomDisplayItem.id}" class="link edit">编辑</a>
					<a href="get.ht?id=${sysCustomDisplayItem.id}" class="link detail">明细</a>
					<a href="editDspTemplate.ht?id=${sysCustomDisplayItem.id}" class="link redo">修改模板</a>
					<a action="preview.ht?__displayId=${sysCustomDisplayItem.id }" class="link preview">预览</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="sysCustomDisplayItem"/>
		</div><!-- end of panel-body -->	
	</div> <!-- end of panel -->
</body>
</html>


