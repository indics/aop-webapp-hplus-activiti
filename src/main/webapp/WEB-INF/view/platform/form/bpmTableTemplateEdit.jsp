<%--
	time:2012-05-22 14:58:08
	desc:edit the 查看表格业务数据的模板
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>生成数据模板</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" href="${ctx }/js/tree/v35/zTreeStyle.css" type="text/css"/>
	<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerComboBox.js"></script>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmTableTemplate"></script>
	<script type="text/javascript" src="${ctx }/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/lg/plugins/htCatCombo.js"></script>	
	<script type="text/javascript">	    
		$(function() {
			function closeWindow(){
				
			};
			function showRequest(formData, jqForm, options) {				
				return true;
			};			
			function showResponse(responseText, statusText)  { 
				var obj=new com.cosim.form.ResultMessage(responseText);
				if(obj.isSuccess()){//成功
					$.ligerMessageBox.success('提示信息',obj.getMessage(),function(){
						parent.refresh();
					});					
			    }else{//失败
			    	$.ligerDialog.err('出错信息',"生成数据模板失败",obj.getMessage());
			    }
			};
			valid(showRequest,showResponse);
			$("a.save").click(function(){				
				$('#bpmTableTemplateForm').submit();				
			});
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">生成数据模板</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="javascript:;">保存</a></div>					
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="bpmTableTemplateForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">数据模板名称: </th>
							<td><input type="text" id="templateName" name="templateName" value="${bpmTableTemplate.templateName}" size="40" class="inputText"/></td>
						</tr>						
						<tr>
							<th width="20%">业务数据授权类型: </th>
							<td>							
								<select name="authorType" >
									<c:forEach items="${permissionMap }" var="item">
										<option value="${item.key}" <c:if test="${bpmTableTemplate.authorType==item.key }">selected</c:if>>${item.value.desc }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th width="20%">备注 : </th>
							<td>
								
								<textarea name="memo"  rows="3" cols="60">${bpmTableTemplate.memo}</textarea>
							</td>
						</tr>
						<c:choose>
							<c:when test="${bpmTableTemplate.id==0}">
							<tr>
								<th width="20%">列表模板: </th>
								<td>
									<select name="htmlList">
										<c:forEach items="${listTemplate}" var="bpmFormTemplate">
											<option value="${bpmFormTemplate.templateId}">${bpmFormTemplate.templateName}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							</c:when>								
							<c:otherwise>
							<tr>
								<th width="20%">列表模板：</th>
									<td>
										<textarea id="htmlList" name="htmlList" cols=150 rows=20>${fn:escapeXml(bpmTableTemplate.htmlList)}</textarea>
									</td>
							</tr>
							</c:otherwise>
						</c:choose>
					</table>
					<input type="hidden" name="formKey" value="${bpmTableTemplate.formKey}" />
					<input type="hidden" name="id" value="${bpmTableTemplate.id}" />
				</form>
				
		</div>
</div>
</body>
</html>
