<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cosim.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>用户表管理</title>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerWindow.js" ></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
	<script language="JavaScript" type="text/javascript" src="${ctx}/js/layer/layer.js"></script>
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
		layer.open({
		    type: 2,
		    title: '导航提示',
		    shadeClose: false,
		    fix: true, 
		    shade: 0.6,
		    offset:50,
		    area: ['500px', '300px'],
		    content: "${ctx}/cloud/config/enterprise/user/toImport.ht" //iframe的url
		}); 
	}
	
	function showDetail(){
		$(".tbar-title a").parent().next().toggle();
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
				<a href="javascript:showDetail()" ><span class="tbar-label">用户表管理列表</span></a>
			</div>
			<div style="display: none;font-weight: normal;line-height: 20px;height:70px;background-color: #f5f5f5;padding-left: 25px;padding-right: 20px;">
				<p><br/></p>
				设置本公司旗下员工信息，可以设置所属部门，权限角色，员工图像等信息。
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<f:a alias="searchEnterpriseUser" css="link search" id="btnSearch">查询</f:a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<f:a alias="addEnterpriseUser" css="link add" href="edit.ht">添加</f:a>
					</div>
					<div class="l-bar-separator"></div>
<!-- 					<div class="group"> -->
<%-- 						<f:a alias="applyEnterpriseUser" css="link detail" href="apply.ht?systemId=${f:getCurrentSystemId()}&tenantId=${f:getCurrentTenantId()}" target="_blank">申请云网通行证</f:a> --%>
<!-- 					</div> -->
					<div class="l-bar-separator"></div>
					<div class="group">
						<f:a alias="delEnterpriseUser" css="link del" action="del.ht">删除</f:a>
					</div>
					<!-- <div class="l-bar-separator"></div>
					<div class="group"><a class="link edit" href="#" onclick="batchImport();">批量导入</a></div> -->
				</div>	
			</div>
			<div class="panel-search">
					<form id="searchForm" method="post" action="list.ht">
							<div class="row">
								<span class="label">姓名:</span><input type="text" name="Q_fullname_SL"  class="inputText" style="width:9%" value="${param['Q_fullname_SL']}"/>
								<!-- 					
								<span class="label">组织sn:</span><input type="text" name="Q_orgSn_L"  class="inputText" style="width:9%" value="${param['Q_orgSn_L']}"/>					
								 -->
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
								<%-- /////ht del b
								<span class="label">来源:</span>
								<select name="Q_fromType_S" class="select" style="width:8%;" value="${param['Q_fromType_S']}">
									<option value="">--选择--</option>
									<option value="<%=SysUser.FROMTYPE_DB %>">系统添加</option>
									<option value="<%=SysUser.FROMTYPE_AD %>">AD同步</option>
								</select>
								/////ht del e --%>
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
						<input type="checkbox" class="pk" name="userId" value="${sysUserItem.userId}">
					</display:column>
					<display:column title="姓名" media="html">
						<a href="get.ht?userId=${sysUserItem.userId}" title="${sysUserItem.fullname}"><ap:textTip value="${sysUserItem.fullname}" max="10" more="..."/></a>
					</display:column>
<%-- 					<display:column property="account" title="内部帐号" sortable="true" sortName="account" style="text-align:left"></display:column> --%>
					<display:column property="shortAccount" title="登录名" sortable="true" sortName="shortAccount" ></display:column>
					<%--
					<display:column  title="创建时间" sortable="true" sortName="createtime" style="text-align:center;">
						<fmt:formatDate value="${sysUserItem.createtime}" pattern="yyyy-MM-dd"/>
					</display:column>
					--%>
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
					<display:column title="管理" media="html" style="width:250px;text-align:left;">
					    <f:a alias="userUnder" css="link primary" href="#" onclick="openUserUnder('${sysUserItem.userId}',this)">下属管理</f:a>
						<f:a alias="delEnterpriseUser" css="link del" href="del.ht?userId=${sysUserItem.userId}">删除</f:a>
						<f:a alias="resetEnterprisePwd" css="link resetPwd" href="resetPwdView.ht?userId=${sysUserItem.userId}">重置密码</f:a>
						<c:if test="${sysUserItem.shortAccount!='system'}">
							<f:a alias="updateEnterpriseUserInfo" css="link edit" href="edit.ht?userId=${sysUserItem.userId}">编辑</f:a>
						</c:if>
						<c:if test="${sysUserItem.shortAccount!='system'}">
							<f:a alias="setEnterpriseStatus" css="link setting" href="editStatusView.ht?userId=${sysUserItem.userId}">设置状态</f:a>
						</c:if>
					</display:column>
				</display:table>
				<cosim:paging tableId="sysUserItem"/>
			
		</div>
	</div>
	<div style="height:140px; line-height:0px; font-size:0px; clear:both;overflow:hidden; display:block;"></div>
</body>
</html>


