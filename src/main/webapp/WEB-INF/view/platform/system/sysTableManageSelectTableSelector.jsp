
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>表/视图选择</title>
<%@include file="/commons/include/get.jsp"%>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$("#selectorTab").ligerTab();
	var tabcomp = $("#selectorTab").ligerGetTabManager();
	var tabItem='${tabItem}';
	switch(tabItem){
	case 'table':
		tabcomp.selectTabItem("tabitem1");
		break;
	case 'view':
		tabcomp.selectTabItem("tabitem2");
		break;
	}
	
	$("a.link.search").click(function(){
		var searchForm = $(this).closest("div.panel-toolbar").parent().find("form[name='searchForm']");
		searchForm.submit();
	});
});
	
</script>
<style type="text/css">
	#divTableTop{margin:0 0 0 0;}
	#divTableBody{margin:2px 0 0 0;}
	
	#divViewTop{margin:0 0 0 0;}
	#divViewBody{margin:2px 0 0 0;}
</style>
</head>
<body>
	<div id="selectorTab" >
		<div name="tab" id="table" title="选择表">
			<div class="panel-top" id="divTableTop">
				<div class="panel-toolbar">
					<div class="group">
						<a class="link search" id="btnSearch">查询</a>
					</div>
				</div>
				<div class="panel-search">
					<form name="searchForm" method="post" action="selectTableSelector.ht">
						<div class="row">
							<span class="label">表名:</span>
							<input type="text" name="tableName" class="inputText" value="${param['tableName']}"/>
							<input type="hidden" name="dsName" value="${dsName }"/> 
							<input type="hidden" name="tabItem" value="table"/>
						</div>
					</form>
				</div>
			</div>
			<div class="panel-body" id="divTableBody">
				<table class="table-grid" id="tables">
					<thead>
						<tr>
							<th>选择</th>
							<th>表名</th>
							<th>注释</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tableMap}" var="table" varStatus="status">
							<tr class="${status.count%2==0?'odd':'even'}">
								<td>
									<input type="radio" class="pk" name="objectId" tableName="${table.name}" tableType="table" />
								</td>
								<td>${table.name }</td>
								<td>${table.comment }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<cosim:paging tableId="tables"></cosim:paging>
			</div>
		</div>
		<div name="tab" id="view" title="选择视图">
			<div class="panel-top" id="divViewTop">
				<div class="panel-toolbar">
					<div class="group">
						<div class="group"><a class="link search" id="btnSearch">查询</a></div>
	<!-- 					<div class="l-bar-separator"></div> -->
	<!-- 					<div class="group"><a class="link add" href="editView.ht">添加</a></div> -->
					</div>
				</div>
				<div class="panel-search">
					<form name="searchForm" method="post" action="selectTableSelector.ht">
						<div class="row">
							<span class="label">视图名:</span>
							<input type="text" name="viewName" class="inputText" value="${param['viewName']}"/>
							<input type="hidden" name="dsName" value="${dsName }"/> 
							<input type="hidden" name="tabItem" value="view"/> 
						</div>
					</form>
				</div>
			</div>
			
			<div class="panel-body" id="divViewBody">
					<table id="views" class="table-grid table-list">
					<thead>
						<tr>
							<th>选择</th>
							<th>视图名</th>
							<th>注释</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${views}" var="view" varStatus="status">
							<tr class="${status.count%2==0?'odd':'even'}">
								<td>
									<input type="radio" class="pk" name="objectId" tableName="${view}" tableType="view" />
								</td>
								<td>${view}</td>
								<td></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<cosim:paging tableId="views"></cosim:paging>
			</div>
		</div>
	</div>
</body>
</html>


