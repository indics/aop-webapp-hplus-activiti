<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<%@include file="/commons/include/get.jsp"%>
<html>
<head>
<title>企业角色配置管理信息列表</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/ScriptDialog.js" ></script>
<%@include file="/commons/include/form.jsp" %>
<script type="text/javascript"	src="${ctx}/js/cosim/displaytag.js"></script>
<script>
function roleDialog(tenantId){
	// 计算位置和大小
	var dialogLeft = 300;
	var dialogTop = 50;
	var dialogWidth = window.screen.width - 200;;
	var dialogHeight = 600;
	
	var conf = {
		url : 'dialog.ht',
		dialogHeight : dialogHeight,
		//dialogWidth : dialogWidth,
		//dialogLeft : dialogLeft,
		//dialogTop : dialogTop,
		param : {
			tenantId : tenantId
		},
		callback : function(roles){
			var win1 = $.ligerDialog.waitting('正在设置中,请稍候...');
			var rolesId = [];
			var rolesName = [];
			for(var i=0;i<roles.length;i++){
				rolesId.push(roles[i].roleId);
				rolesName.push(roles[i].角色名);
			}
			$.ajax({
				url : 'updateRoles.ht',
				type : 'post',
				data : {
					tenantId : tenantId,
					rolesId : rolesId,
					rolesName : rolesName
				},
				success : function(responseText){
					var obj = new com.cosim.form.ResultMessage(responseText);
					if(obj.isSuccess()){
						$.ligerMessageBox.success('提示信息', "设置成功，已将用户原有角色重新进行绑定！");
					}else{
						$.ligerMessageBox.error('错误信息', obj.getMessage());
					}
					win1.close();
				},
				failure : function(msg){
					$.ligerMessageBox.error('错误信息', msg);
					win1.close();
				}
			})
		}
	}
	RoleDialog(conf);
}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业角色配置管理信息列表</span>
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
				<display:column property="sysOrgInfoId" title="企业账号" sortable="true" sortName="sn" maxLength="80" style="text-align:center;"></display:column>
				<display:column media="html" title="企业名称">
					<a href="javascript:void(0);" title="${InfoItem.name}"><ap:textTip max="10" value="${InfoItem.name}"/></a>
				</display:column>
				<display:column property="scale" title="企业规模" sortable="true" sortName="scale" maxLength="80" style="text-align:center;"></display:column>
				<display:column property="connecter" title="联系人" sortable="true" sortName="connecter"></display:column>
				<display:column property="tel" title="手机" sortable="true" sortName="tel"></display:column>
				<display:column  title="注册时间" sortable="true" sortName="createtime" style="text-align:center;">
					<fmt:formatDate value="${InfoItem.createtime}" pattern="yyyy-MM-dd"/>
				</display:column>
				<display:column title="管理" media="html" style="width:80px;">
					<a href="javascript:roleDialog(${InfoItem.sysOrgInfoId})" class="link detail">角色配置</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="InfoItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>