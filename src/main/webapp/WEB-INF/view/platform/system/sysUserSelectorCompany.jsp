
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>用户列表</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript">
	var isSingle='${isSingle}';
	$(function(){
		$("#sysUserItem").find("tr").bind('click', function() {
			if(isSingle=='true'){
				var rad=$(this).find('input[name=userData]:radio');
				rad.attr("checked","checked");
			}else{
				var ch=$(this).find(":checkbox[name='userData']");
				window.parent.selectMulti(ch);
			}
		});
	});
</script>
</head>
<body style="overflow-x: hidden;overflow-y: auto;">
	<div class="panel-search" style="width: 80%;">
		<form id="searchForm" method="post" action="${ctx}/platform/system/sysUser/selectorCompany.ht" >
			<div class="row">
				<input type="hidden" name="isSingle" value="${isSingle }">
				<input type="hidden" name="companyId" value="${companyId }">
				<span class="label">姓名:</span><input size="14" type="text" name="Q_fullname_SL"  class="inputText" value="${param['Q_fullname_SL']}"/>
				&nbsp;<input type="submit" value="查询" onclick="window.parent.setCenterTitle('全部用户')"/>
			</div>
		</form>
	</div>
   	<c:if test="${isSingle==false}">
    	<c:set var="checkAll">
			<input onclick="window.parent.selectAll(this);" type="checkbox" />
		</c:set>
	</c:if>
	<display:table  name="sysUserList" id="sysUserItem" requestURI="selector.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
		<display:column title="${checkAll}" media="html" style="width:30px;">
				<c:choose>
					<c:when test="${isSingle==false}">
						<input onchange="window.parent.selectMulti(this);" type="checkbox" class="pk" name="userData" value="${sysUserItem.userId}#${sysUserItem.fullname}#${sysUserItem.email}#${sysUserItem.mobile}">
					</c:when>
					<c:otherwise>
						<input type="radio" class="pk" name="userData" value="${sysUserItem.userId}#${sysUserItem.fullname}#${sysUserItem.email}#${sysUserItem.mobile}">
					</c:otherwise>
				</c:choose>
		</display:column>
		<display:column  property="fullname" title="姓名" sortable="true" sortName="fullname"></display:column>
	</display:table>
	<cosim:paging tableId="sysUserItem" showExplain="false"/>
</body>
</html>


