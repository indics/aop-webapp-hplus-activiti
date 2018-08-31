<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<%@include file="/commons/include/get.jsp"%>
<html>
<head>
<title>企业资源配置管理信息列表</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/ScriptDialog.js" ></script>
<%@include file="/commons/include/form.jsp" %>
<script type="text/javascript"	src="${ctx}/js/cosim/displaytag.js"></script>
<script>
function copyRole(roleId,roleName){
	CopyRoleDialog({roleId:roleId});
}


function resDialog(tenantId){
	var dialogLeft = 300;
	var dialogTop = 50;
	var width = 500;
	var height = window.screen.height - 200;
    var url=__ctx+"/cloud/saas/res/edit.ht?tenantId="+tenantId;
	var winArgs='dialogTop='+dialogTop+'px;dialogLeft='+dialogLeft+'px;dialogWidth='+width+'px;dialogHeight='+height+'px;status=0;help=0;';
	url=url.getNewUrl();
	window.showModalDialog(url,"",winArgs);
}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业资源配置管理信息列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
				</div>
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="saas.ht">
					<div class="row">
						<span class="label">企业名称:</span><input type="text" name="Q_name_SL"  class="inputText" />
						<span class="label">联系人:</span><input type="text" name="Q_connecter_SL"  class="inputText" />
						<span class="label">手机:</span><input type="text" name="Q_tel_SL"  class="inputText" />
					</div>
					<div class="row">	
						<span class="label">公司账号:</span><input type="text" name="Q_sysOrgInfoId_SE"  class="inputText" />
						<span class="label">注册时间 从:</span> <input  name="Q_beginregistertime_DL"  class="inputText date" />
						<span class="label">至: </span><input  name="Q_endregistertime_DG" class="inputText date" />
						
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="InfoList" id="InfoItem" requestURI="saas.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px; text-align:center;">
			  		<input type="checkbox" class="pk" name="sysOrgInfoId" value="${InfoItem.sysOrgInfoId}">
				</display:column>
				<display:column property="sysOrgInfoId" title="企业账号" sortable="true" sortName="sn" maxLength="80" style="text-align:right;"></display:column>
				<display:column title="企业名称" media="html">
					<a href="javascript:void(0);" title="${InfoItem.name}"><ap:textTip value="${InfoItem.name}" max="20" more="..."/></a>
				</display:column>
				<display:column property="scale" title="企业规模" sortable="true" sortName="scale" maxLength="80" style="text-align:center;"></display:column>
				<display:column property="connecter" title="联系人" sortable="true" sortName="connecter" style="text-align:center;"></display:column>
				<display:column property="tel" title="手机" sortable="true" sortName="tel" style="text-align:center;"></display:column>
				<display:column  title="注册时间" sortable="true" sortName="createtime" style="text-align:center;">
					<fmt:formatDate value="${InfoItem.createtime}" pattern="yyyy-MM-dd"/>
				</display:column>
				<display:column title="管理" media="html" style="width:70px; text-align:center;">
					<a href="javascript:resDialog(${InfoItem.sysOrgInfoId});" class="link detail">资源配置</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="InfoItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>