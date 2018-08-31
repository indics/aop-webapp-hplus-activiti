<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cosim.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>用户表管理</title>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerWindow.js" ></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
	<script type="text/javascript">
	function openUserUnder(userid,obj){
		if($(obj).hasClass('disabled')) return false;
		 
		var conf={};				
		var url=__ctx + "/platform/system/userUnder/list.ht?userId="+userid;
		conf.url=url;
		var dialogWidth=550;
		var dialogHeight=450;
		conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
		var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
			+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;				
		var rtn=window.showModalDialog(url,"",winArgs);		
	}
	
	//批量导入
	function batchImport(){
		OpenDialog({
			url : '/cloud/config/enterprise/user/toImport.ht',
			dialogWidth:500,
			dialogHeight:200
		});
	}
	
	function postEdit(postURL,userId,sysOrgInfoId,returnUserListUrl){
				var ExportForm = document.createElement("FORM");  
				document.body.appendChild(ExportForm);  
				var userIdInput = document.createElement("input");  
				userIdInput.setAttribute("name", "userId");  
				userIdInput.setAttribute("type", "hidden");  
				userIdInput.value = userId;				
				ExportForm.appendChild(userIdInput);
				
				var sysOrgInfoIdInput = document.createElement("input");  
				sysOrgInfoIdInput.setAttribute("name", "sysOrgInfoId");  
				sysOrgInfoIdInput.setAttribute("type", "hidden");  
				sysOrgInfoIdInput.value = sysOrgInfoId;				
				ExportForm.appendChild(sysOrgInfoIdInput);  
				
				var returnUserListURLInput = document.createElement("input");  
				returnUserListURLInput.setAttribute("name", "returnUserListUrl");  
				returnUserListURLInput.setAttribute("type", "hidden");  
				returnUserListURLInput.value = returnUserListUrl;				
				ExportForm.appendChild(returnUserListURLInput); 
				 
				ExportForm.action = postURL;				
				ExportForm.method = "POST";    
				ExportForm.submit();  
	}
	</script>
</head>
<body>
<c:set var="SysUser_EXPIRED" value="<%=SysUser.EXPIRED %>" />
<c:set var="SysUser_UN_EXPIRED" value="<%=SysUser.UN_EXPIRED %>"  />

<c:set var="SysUser_LOCKED" value="<%=SysUser.LOCKED %>"/>
<c:set var="SysUser_UN_LOCKED" value="<%=SysUser.UN_LOCKED %>"/>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">&lt;${soi.name}&gt;企业用户表管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a alias="searchEnterpriseUser" class="link search" id="btnSearch">查询</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link add" href="edit.ht?sysOrgInfoId=${sysOrgInfoId}&returnUserListUrl=${returnUserListUrl}">添加</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a alias="delEnterpriseUser" class="link del" action="del.ht">删除</a>
					</div>
			<!-- 		<div class="l-bar-separator"></div>
					<div class="group"><a class="link edit" href="#" onclick="batchImport();">批量导入</a></div> -->
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="javascript:history.back();">返回</a></div>
					
				</div>	
			</div>
			<div class="panel-search">
					<form id="searchForm" method="post" action="list.ht?sysOrgInfoId=${param.sysOrgInfoId}">
							<div class="row">
								<span class="label">姓名:</span><input type="text" name="Q_fullname_SL"  class="inputText" style="width:9%" value="${param['Q_fullname_SL']}"/>
								<span class="label">创建时间从:</span><input type="text" id="Q_begincreatetime_DL" name="Q_begincreatetime_DL"  class="inputText Wdate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'Q_endcreatetime_DG\');}'})" style="width:9%" value="${param['Q_begincreatetime_DL']}"/>
								<span class="label">至</span><input type="text" id="Q_endcreatetime_DG" name="Q_endcreatetime_DG"  class="inputText Wdate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'Q_begincreatetime_DL\');}'})" style="width:9%" value="${param['Q_endcreatetime_DG']}"/>
								<span class="label">是否过期:</span>	
								<select name="Q_isExpired_S" class="select" style="width:8%;" value="${param['Q_isExpired_S']}">
									<option value="">--选择--</option>
								<option value="${SysUser_EXPIRED}"  <c:if test="${param['Q_isExpired_S'] == SysUser_EXPIRED }">selected</c:if>>是</option>
								<option value="${SysUser_UN_EXPIRED}" <c:if test="${param['Q_isExpired_S'] == SysUser_UN_EXPIRED }">selected</c:if>>否</option>
								</select>
								<span class="label">是否锁定:</span>
								<select name="Q_isLock_S" class="select" style="width:8%;" value="${param['Q_isLock_S']}">
									<option value="">--选择--</option>
								<option value="${SysUser_LOCKED}"  <c:if test="${param['Q_isLock_S'] == SysUser_LOCKED }">selected</c:if>>是</option>
								<option value="${SysUser_UN_LOCKED}" <c:if test="${param['Q_isLock_S'] == SysUser_UN_LOCKED }">selected</c:if>>否</option>
								</select>
								<span class="label">状态:</span>
								<select name="Q_status_S" class="select" style="width:8%;" value="${param['Q_status_S']}">
									<option value="">--选择--</option>
									<option value="<%=SysUser.STATUS_OK %>">激活</option>
									<option value="<%=SysUser.STATUS_NO %>">禁用</option>
									<option value="<%=SysUser.STATUS_Del %>">删除</option>
								</select>
							</div>
					</form>
			</div>
		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="sysUserList" id="sysUserItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"  export="false"  class="table-grid">
					<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
						  	<input type="checkbox" class="pk" name="userId" value="${sysUserItem.userId}:${sysOrgInfoId}">
					</display:column>
					<display:column property="fullname" title="姓名" sortable="true" sortName="fullname" style="width:100px;text-align:left"></display:column>
					<display:column property="shortAccount" title="登录名" sortable="true" sortName="shortAccount" style="text-align:left"></display:column>
					<display:column  title="创建时间" sortable="true" sortName="createtime" style="text-align:center;">
						<fmt:formatDate value="${sysUserItem.createtime}" pattern="yyyy-MM-dd"/>
					</display:column>
					<display:column title="是否过期" sortable="true" sortName="isExpired" style="text-align:center;">
						<c:choose>
							<c:when test="${sysUserItem.isExpired==1}">
								<span class="red">已过期</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span class="green">未过期</span>
						   	</c:otherwise>
						</c:choose>
					</display:column>
	                <display:column title="是否可用" sortable="true" sortName="isLock" style="text-align:center;">
						<c:choose>
							<c:when test="${sysUserItem.isLock==1}">
								<span class="red">已锁定</span>
						   	</c:when>
					       	<c:otherwise>
					       		<span class="green">未锁定</span>
						   	</c:otherwise>
						</c:choose>
					</display:column>
                	<display:column title="状态" sortable="true" sortName="status" style="text-align:center;">
						<c:choose>
							<c:when test="${sysUserItem.status==1}">
								<span class="green">激活</span>
								
						   	</c:when>
						   	<c:when test="${sysUserItem.status==0}">
						   		<span class="red">禁用</span>
								
						   	</c:when>
					       	<c:otherwise>
					       		<span class="red">删除</span>
						   	</c:otherwise>
						</c:choose>
					</display:column>
					<display:column title="管理" media="html" style="width:160px;text-align:center;">					
						<!-- <a alias="updateEnterpriseUserInfo" class="link edit" href="edit.ht?userId=${sysUserItem.userId}&sysOrgInfoId=${sysOrgInfoId}&returnUserListUrl=${returnUserListUrl}">编辑</a> -->
						<a alias="updateEnterpriseUserInfo" class="link edit" onclick="postEdit('edit.ht','${sysUserItem.userId}','${sysOrgInfoId}','${returnUserListUrl}')">编辑</a>
						<a alias="userEnterpriseInfo" class="link detail" href="get.ht?userId=${sysUserItem.userId}">明细</a>						
						<a alias="resetEnterprisePwd" class="link resetPwd" href="resetPwdView.ht?userId=${sysUserItem.userId}">重置密码</a>
						<a alias="setEnterpriseStatus" class="link setting" href="editStatusView.ht?userId=${sysUserItem.userId}">设置状态</a>						
					</display:column>
				</display:table>
				<cosim:paging tableId="sysUserItem"/>			
		</div>
	</div>
</body>
</html>


