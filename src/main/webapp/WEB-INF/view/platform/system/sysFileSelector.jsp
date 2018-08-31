<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>附件信息列表</title>
<%@include file="/commons/include/get_ie.jsp"%>
<style type="text/css">
.file_name{
	text-decoration:none;
	color:black;
}
</style>
<link href="${ctx}/styles/default/css/jquery.qtip.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.js" ></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/ImageQtip.js" ></script>
<script type="text/javascript">
	$(function() {
		$("a.file_name").each(function() {
			var path = $(this).attr("path");			
			//图片类型
			if (/\w+.(png|gif|jpg)/gi.test(path)) {
				ImageQtip.drawImg(this,"${ctx}/"+path,{maxWidth:265});
			}
		});
		$("#sysFileItem  tr.even,#sysFileItem tr.odd").bind('click', function() {
			var trObj=$(this);
			var obj=$(":checkbox[name='fileId']",trObj);
			if(obj.length>0){
				window.parent.selectMulti(obj);
			}
			else{
				var obj=$(":radio[name='fileId']",trObj);
				obj.attr("checked",!obj.attr("checked"));
				obj.click(function(event){
					event.stopImmediatePropagation();
				});
			}
		});
	});
</script>
</head>
<body style="overflow-x: hidden; overflow-y: auto;">
	<div class="panel">
		<div class="panel-search">
			<form action="selector.ht" method="POST">
				<input type="hidden" name="typeId" id="typeId" /> 
				<span class="label">附件名称:</span> 
				<input type="text" id="fileName" name="Q_fileName_SL" style="width:130px;" maxlength="128" class="inputText" value="${param['Q_fileName_SL']}"/> 
				<input type="submit" value="查  询" />
			</form>
		</div>
		<c:if test="${isSingle==0}">
			<c:set var="checkAll">
				<input onclick="window.parent.selectAll(this);" type="checkbox" />
			</c:set>
		</c:if>
		
		<display:table name="sysFileList" id="sysFileItem" requestURI="selector.ht" sort="external" cellpadding="1"
			cellspacing="1" export="false" class="table-grid" style="text-align: center;">
			<display:column title="${checkAll}" media="html" style="width:30px;">
				<c:choose>
					<c:when test="${isSingle==0}">
						<input onchange="window.parent.selectMulti(this);" type="checkbox" class="pk" name="fileId" value="${sysFileItem.fileId}">
					</c:when>
					<c:otherwise>
						<input type="radio" class="pk" name="fileId" value="${sysFileItem.fileId}">
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="fileName" value="${sysFileItem.fileName}" />
				<input type="hidden" name="filePath" value="${sysFileItem.filePath}" />
				<input type="hidden" name="ext" value="${sysFileItem.ext}" />
			</display:column>
			<display:column title="名称" sortable="true" sortName="fileName">
				<a href="javascript:;" class="file_name" path="${sysFileItem.filePath}">${sysFileItem.fileName}</a>
			</display:column>
			<display:column property="ext" title="扩展名" sortable="true" sortName="ext" />
		</display:table>
		<cosim:paging tableId="sysFileItem" showExplain="false"/>
		
	</div>
</body>
</html>


