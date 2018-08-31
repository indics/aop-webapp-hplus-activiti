<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>企业未审核信息列表</title>
<%@include file="/commons/include/get.jsp" %>
	<%@include file="/commons/b2b/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=inquiry"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/subform.js"></script>
	<script type="text/javascript" src="${ctx}/js/scroll/hScrollPane.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/FlexUploadDialog.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
	<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script>
	function toWsh(){
		var s="";
		$('input[name="sysOrgInfoId"]:checked').each(function(){
			s+=$(this).val()+","
		});
		if(s.length==0){
			$.ligerMessageBox.success("提示信息", "至少要选择一掉数据");
			return false;
		}
		$.ligerDialog.waitting("正在保存，请稍候...");
		$.ajax({
			type:'POST',
			url:'${ctx}/b2b/operation/member/member/updateStateToWSH.ht',
			data:{
				'sysOrgInfoId': s
			},success: function(data){
				var obj = new com.cosim.form.ResultMessage(data);
				if (obj.isSuccess()) {
					$.ligerDialog.close();
					$.ligerMessageBox.success("提示信息", obj.getMessage()+"", function(rtn) {
						window.location.reload();				
					});
				} else {
					$.ligerMessageBox.error("提示信息",obj.getMessage());
				}
			}
		})
	}
	
	function toYsh(){
		var s="";
		$('input[name="sysOrgInfoId"]:checked').each(function(){
			s+=$(this).val()+","
		});
		if(s.length==0){
			$.ligerMessageBox.success("提示信息", "至少要选择一掉数据");
			return false;
		}
		$.ligerDialog.waitting("正在保存，请稍候...");
		$.ajax({
			type:'POST',
			url:'${ctx}/b2b/operation/member/member/updateStateToYSH.ht',
			data:{
				'sysOrgInfoId': s
			},success: function(data){
				var obj = new com.cosim.form.ResultMessage(data);
				if (obj.isSuccess()) {
					$.ligerDialog.close();
					$.ligerMessageBox.success("提示信息", obj.getMessage()+"", function(rtn) {
						window.location.reload();				
					});
				} else {
					$.ligerMessageBox.error("提示信息",obj.getMessage());
				}
			}
		})
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业未审核信息列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del"  action="del.ht">删除</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link" id="toWsh" onclick="toWsh()">置为未审核</a></div>
					<div class="group"><a class="link" id="toYsh" onclick="toYsh()">置为已审核</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="listXzc.ht">
					<div class="row">
						<span class="label">企业名称:</span><input type="text" name="Q_name_SL"  class="inputText" />
						<span class="label">联系人:</span><input type="text" name="Q_connecter_SL"  class="inputText" />
						<span class="label">手机:</span><input type="text" name="Q_tel_SL"  class="inputText" />
					</div>
					<div class="row">	
						<span class="label">公司编码:</span><input type="text" name="Q_sysOrgInfoId_EL"  class="inputText" />
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
		    <display:table name="factoryInfoList" id="factoryInfoItem" requestURI="listXzc.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="checkbox" class="pk" name="sysOrgInfoId" value="${factoryInfoItem.sysOrgInfoId}">
				</display:column>
				<display:column property="sysOrgInfoId" title="企业账号" sortable="true" sortName="sysOrgInfoId" maxLength="80"></display:column>
				<display:column property="name" title="企业名称" sortable="true" sortName="name" maxLength="80"></display:column>
				<display:column property="connecter" title="联系人" sortable="true" sortName="connecter"></display:column>
				<%-- <display:column property="email" title="邮箱" sortable="true" sortName="email" maxLength="80"></display:column> --%>
				<display:column property="address" title="地址" sortable="true" sortName="address" maxLength="80"></display:column>
				<display:column  title="注册时间" sortable="true" sortName="createtime">
					<fmt:formatDate value="${factoryInfoItem.createtime}" pattern="yyyy-MM-dd"/>
				</display:column>
				<display:column title="管理" media="html">
					<a href="${ctx }/b2b/member/factory/factoryInfo/forSysadmin.ht?sysOrgInfoId=${factoryInfoItem.sysOrgInfoId}" class="link detail">明细</a>
				</display:column>
			</display:table>
			<cosim:paging tableId="factoryInfoItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


