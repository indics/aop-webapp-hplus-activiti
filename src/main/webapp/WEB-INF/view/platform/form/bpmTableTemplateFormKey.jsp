<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看业务数据</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript"src="${ctx}/js/cosim/platform/system/AddResourceDialog.js"></script>
<script type="text/javascript">
var formKey=${formKey};
function newTableTemp(){		
	
	var url=__ctx + '/platform/form/bpmTableTemplate/edit.ht?formKey='+formKey;
	win= $.ligerDialog.open({ url: url, height: 400,width:600 ,isResize: false });		
}

function refresh(){
	location.reload();
}

$(function(){
	$("#btnSearch").click(newTableTemp);
})

function openResDialog(id,name){
	var url="/platform/form/bpmTableTemplate/get.ht?id=" + id;
	AddResourceDialog({addUrl:url,name:name});
}
</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">业务数据目录</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link add" id="btnSearch">添加</a></div>
				<div class="l-bar-separator"></div>							
				<div class="group"><a class="link del" action="del.ht">删除</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back" href="${returnUrl}">返回</a></div>
			</div>	
		</div>
	</div>
	<div class="panel-body">
		
		
	
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="bpmTableTemplateList" id="bpmTableTemplateItem"  sort="external" cellpadding="1" cellspacing="1"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
					  	<input type="checkbox" class="pk" name="id" value="${bpmTableTemplateItem.id}">
				</display:column>
				<display:column property="templateName" title="列表模板名"></display:column>
				
				<display:column property="tableName" title="表名"></display:column>
				<display:column  title="授权类型">
					${permissionMap[bpmTableTemplateItem.authorType].desc }
				</display:column>
				<display:column property="categoryName" title="表单类型 "></display:column>
				<display:column title="管理" media="html" style="width:250px;">								
					<a href="javascript:;" onclick="javascript:jQuery.openFullWindow('edit.ht?id=${bpmTableTemplateItem.id}&ifEdit=1');" class="link edit">编辑</a>
					<a href="del.ht?id=${bpmTableTemplateItem.id}" class="link del">删除</a>
					<a href="javascript:openResDialog(${bpmTableTemplateItem.id},'${bpmTableTemplateItem.templateName}')" class="link flowDesign"  title="添加资源" >添加资源</a>							
				</display:column>
			</display:table>
		
	</div>
</div>
</body>
</html>


