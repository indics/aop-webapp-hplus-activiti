<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>自定义页面管理</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript">
	$(function() {
		eventBind();
	});
	
	function eventBind(){
		$("a.link.add,a.link.edit").click(function(){
			var action=$(this).attr("action");
			var url=__ctx+ "/platform/system/sysCustomPage/"+action;
			var winArgs="dialogWidth=1024px;dialogHeight=700px;help=0;status=0;scroll=0;center=1";
			url=url.getNewUrl();
			var rtn=window.showModalDialog(url,"",winArgs);
			window.location.reload();
		});
	}
	
	function preview(id) {
		var url=__ctx+ "/platform/system/sysCustomPage/show.ht?id="+id;
		var winArgs="dialogWidth=1024px;dialogHeight=700px;help=0;status=0;scroll=0;center=1";
		url=url.getNewUrl();
		var rtn=window.showModalDialog(url,"",winArgs);
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义页面管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link add" action="edit.ht">添加</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del"  action="del.ht">删除</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">名称:</span><input type="text" name="Q_name_SL"  class="inputText" value="${param['Q_name_SL']}"/>
						<span class="label">标题:</span><input type="text" name="Q_title_SL"  class="inputText" value="${param['Q_title_SL']}"/>
						<span class="label">描述:</span><input type="text" name="Q_description_SL"  class="inputText" value="${param['Q_description_SL']}"/>
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="sysCustomPageList" id="sysCustomPageItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="id" value="${sysCustomPageItem.id}">
				</display:column>
				<display:column property="name" title="名称" sortable="true" sortName="name"></display:column>
				<display:column property="title" title="标题" sortable="true" sortName="title" maxLength="80"></display:column>
				<display:column property="description" title="描述" sortable="true" sortName="description" maxLength="80"></display:column>
				<display:column title="管理" media="html" style="width:200px">
					<a href="del.ht?id=${sysCustomPageItem.id}" class="link del">删除</a>
					<a action="edit.ht?id=${sysCustomPageItem.id}" class="link edit">编辑</a>
					<a href="get.ht?id=${sysCustomPageItem.id}" class="link detail">明细</a>
					<a onclick="preview(${sysCustomPageItem.id})" class="link preview">预览</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="sysCustomPageItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


