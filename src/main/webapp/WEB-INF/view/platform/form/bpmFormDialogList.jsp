
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>通用表单对话框管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>

<script type="text/javascript">
	var win;
	function preview(alias){
		CommonDialog(alias,function(data){
			var json=JSON.stringify(data);
			$("#txtJsonData").val(json);
			if(!win){
				var obj=$("#divJsonData");
				win= $.ligerDialog.open({ target:obj , height: 300,width:500, modal :true}); 
			}
			win.show();
		});
	}
</script>
</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">通用表单对话框管理列表</span>
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
					    <display:table name="bpmFormDialogList" id="bpmFormDialogItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="id" value="${bpmFormDialogItem.id}">
							</display:column>
							<display:column property="name" title="名称" sortable="true" sortName="name"></display:column>
							<display:column property="alias" title="别名" sortable="true" sortName="alias"></display:column>
							<display:column  title="显示样式" sortable="true" sortName="style">
							
								<c:choose>
									<c:when test="${bpmFormDialogItem.style==0}">
										<span class="green">列表</span>
									</c:when>
									<c:otherwise>
										<span class="red">树形</span>
									</c:otherwise>
								</c:choose>
							</display:column>
							<display:column  title="是否单选" sortable="true" sortName="issingle">
								<c:choose>
									<c:when test="${bpmFormDialogItem.issingle==0}">
										<span class="red">多选</span>
									</c:when>
									<c:otherwise>
										<span class="green">单选</span>
									</c:otherwise>
								</c:choose>
							</display:column>
							<display:column property="width" title="宽度" sortable="true" sortName="width"></display:column>
							<display:column property="height" title="高度" sortable="true" sortName="height"></display:column>
							<display:column  title="是否为表" sortable="true" sortName="istable">
								<c:choose>
									<c:when test="${bpmFormDialogItem.istable==0}">
										<span class="red">视图</span>
									</c:when>
									<c:otherwise>
										<span class="green">数据库表</span>
									</c:otherwise>
								</c:choose>
							</display:column>
							<display:column property="objname" title="对象名称" sortable="true" sortName="objname"></display:column>
							<display:column property="dsalias" title="数据源名称" sortable="true" sortName="dsalias"></display:column>
							<display:column title="管理" media="html" style="width:180px;text-align:center">
								<f:a alias="delFormDialog" href="del.ht?id=${bpmFormDialogItem.id}" css="link del">删除</f:a>
								<a href="edit.ht?id=${bpmFormDialogItem.id}" class="link edit">编辑</a>
								<a href="javascript:preview('${bpmFormDialogItem.alias}')"  class="link detail">预览</a>
							</display:column>
						</display:table>
						<cosim:paging tableId="bpmFormDialogItem"/>
					
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
			
			<div id="divJsonData" style="display: none;">
				<div>对话框返回的JSON格式数据。</div>
				<ul>
					<li >1.单选为JSON对象数据,字段为return字段。</li>
					<li>2.多选为JSON数组,字段为return字段。</li>
				</ul>
				<textarea id="txtJsonData" rows="10" cols="80" style="height: 180px;width:480px"></textarea>
			</div>
</body>
</html>


