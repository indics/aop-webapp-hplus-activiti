<%--
	time:2011-11-26 18:19:16
--%>
<%@page language="java" pageEncoding="UTF-8"%>

<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>附件明细</title>
	<%@include file="/commons/include/getById.jsp" %>	
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">附件详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="javascript:history.go(-1);">返回</a></div>
<!-- 					<div class="group"><a class="link back" href="../sysFile/list.ht">返回</a></div> -->
				</div>
			</div>
		</div>
		<div class="panel-body">
				<div class="panel-detail">
					<form id="sysFileForm" method="post" action="add2.ht">
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">						
							<tr>
								<th width="20%">文件名:</th>
								<td>${sysFile.fileName}</td>
							</tr>
					<%-- 		<tr>
								<th width="20%">文件路径:</th>
								<td>${sysFile.filePath}</td>
							</tr> --%>
							<tr>
								<th width="20%">创建时间:</th>
								<td>
									<fmt:formatDate value="${sysFile.createtime }" pattern="yyyy-MM-dd HH:ss"/>
								</td>
							</tr>
							<tr>
								<th width="20%">扩展名:</th>
								<td>${sysFile.ext}</td>
							</tr>						
							<tr>
								<th width="20%">说明:</th>
								<td>${sysFile.note}</td>
							</tr>
							<tr>
								<th width="20%">上传者:</th>
								<td>${sysFile.creator}</td>
							</tr>
							<tr>
								<th width="20%">字节数:</th>
								<td>${sysFile.totalBytes}</td>
							</tr>
							<tr>
								<th width="20%">操作:</th>
								<td>
									<c:choose>
										<c:when test="${sysFile.delFlag eq 1}"><font color="red">对不起，该文件已经被删除</font></c:when>
										<c:when test="${isOwner eq 0}"><font color="red">非文件拥有者，无法下载文件</font></c:when>
										<c:otherwise><a href="download.ht?fileId=${sysFile.fileId }" target="_blank" class="link download">下载</a></c:otherwise>
									</c:choose>
								</td>
							</tr>
						</table>
					</form>
				</div>
		</div>
</div>

</body>
</html>
