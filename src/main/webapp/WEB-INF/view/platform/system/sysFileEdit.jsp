
<%--
	time:2011-11-26 18:19:16
--%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 附件</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=sysFile"></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js"></script>
	<script type="text/javascript" src="${ctx }/js/cosim/platform/system/FlexUploadDialog.js"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#sysFileForm').submit(); 
			});
			
			
		});
		// 测试附件上传
		function testFile(){
			new FlexUploadDialog({
				isSingle : false,
				callback : function(fileIds, fileNames){
					alert('fileIds=' + fileIds + ',fileNames=' + fileNames);
				}
			});
		}
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">编辑附件</span>
			</div> 
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
							
					<!-- 测试 -->
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link test" href="#" onclick="testFile();">测试附件</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="save.ht">
					<div class="panel-detail">
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="20%">文件名:<span class="required">*</span>:</th>
								<td><input type="text" id="fileName" name="fileName" value="${sysFile.fileName }" class="inputText" /></td>
							</tr>
							<tr>
								<th width="20%">选择分类: </th>
								<td>
								<select id="typeId" name="typeId" style="width:20%">
								<c:forEach items="${globalTypeList }" var="globalType">
								<option value="${globalType.typeId }">${globalType.typeName }</option>
								</c:forEach>.
								</select>
								</td>
							</tr>
							<tr>
								<th width="20%">文件路径<span class="required">*</span>:</th>
								
								<td><input type="text" id="filePath" name="filePath" value="${sysFile.filePath }" class="inputText" /></td>
							</tr>
							<tr>
								<th width="20%">扩展名: </th>
								
								<td><input type="text" id="ext" name="ext" value="${sysFile.ext }" class="inputText" /></td>
							</tr>
							<tr>
								<th width="20%">附件类型<span class="required">*</span>:</th>
								
								<td>
								<input type="text" id="fileType" name="fileType" value="${sysFile.fileType }" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="20%">说明: </th>
								
								<td><input type="text" id="note" name="note" value="${sysFile.note }" class="inputText" /></td>
							</tr>
							<tr>
								<th width="20%">字节数: </th>
								
								<td><input type="text" id="totalBytes" name="totalBytes" value="${sysFile.totalBytes }" class="inputText" /></td>
							</tr>
							<tr>
								<th width="20%">是否已删除: </th>
								<td>
									<select id="delFlag" name="delFlag" class="select" style="width:160px;">
										<c:choose>
											<c:when test="${sysFile.delFlag eq 1}">
												<option value="0">否</option>
												<option value="1" selected="selected">是</option>
											</c:when>
											<c:when test="${sysFile.delFlag eq 0 }">
												<option value="0" selected="selected">否</option>
												<option value="1">是</option>
											</c:when>
											<c:otherwise>
												<option>--请选择--</option>
												<option value="0">否</option>
												<option value="1">是</option>
											</c:otherwise>
										</c:choose>
									</select>
								</td>
							</tr>
						</table>
						<input type="hidden" name="fileId" value="${sysFile.fileId}" />
					</div>
				</form>
		</div>
</div>
</body>
</html>
