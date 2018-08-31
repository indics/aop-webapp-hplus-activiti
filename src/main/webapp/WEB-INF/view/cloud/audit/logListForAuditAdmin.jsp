<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>平台审计管理员查看日志</title>
<%@include file="/commons/include/get.jsp"%>
<script type="text/javascript">
	//弹出导出日志窗口
	var quote_window = null;
	function exportAudits() {
		var urlShow = '${ctx}/cloud/system/audit/log/exportForAuditAdminInfo.ht';
		quote_window = $.ligerDialog.open({
			url : urlShow,
			width : 500,
			height : 155,
			allowClose : true,
			title : '日志导出',
			name : "frameDialog_"
		});
	}
	function _callBack() {
		quote_window.close();
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">日志列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group">
<!-- 						<a class="link" href="exportAuditAdmin.ht?type=0">导出日志</a>
 -->						<a class="link" href="javaScript:exportAudits()">导出日志</a>
					</div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="listForAuditAdmin.ht">
					<div class="row">
						<span class="label">操作时间 从:</span> <input  name="Q_beginexeTime_DL"  class="inputText date" />
						<span class="label">至: </span><input  name="Q_endexeTime_DG" class="inputText date" />
						<span class="label">执行人:</span><input type="text" name="Q_executor_SL"  class="inputText" />
						<span class="label">IP:</span><input type="text" name="Q_fromIp_SL"  class="inputText" />
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="sysAuditList" id="sys_auditItem" requestURI="listForAuditAdmin.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="auditId" value="${sys_auditItem.auditId}">
				</display:column>
				<display:column property="opName" title="操作名称" sortable="true" sortName="opName" maxLength="80"></display:column>
				<display:column  title="执行时间" sortable="true" sortName="exeTime">
					<fmt:formatDate value="${sys_auditItem.exeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</display:column>
				<display:column property="tenantName" title="会员名称" sortable="true" sortName="tenantName" maxLength="15"></display:column>
				<display:column property="executor" title="执行人" sortable="true" sortName="executor"></display:column>
				<display:column property="fromIp" title="IP" sortable="true" sortName="fromIp"></display:column>
				<%-- 
				<display:column property="exeMethod" title="执行方法" sortable="true" sortName="exeMethod" maxLength="80"></display:column>
				<display:column property="requestURI" title="请求URL" sortable="true" sortName="requestURI" maxLength="80"></display:column>
				 --%>
				<display:column property="reqParams" title="操作内容" sortable="false" sortName="reqParams" maxLength="30"></display:column>
				<display:column property="resultState" title="状态" sortable="true" sortName="resultState" maxLength="10"></display:column>
				<display:column title="管理" media="html" style="width:180px">
					<div align="center">
						<a href="get.ht?auditId=${sys_auditItem.auditId}" class="link detail">明细</a>
					</div>
				</display:column>
			</display:table>
			<cosim:paging tableId="sys_auditItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


