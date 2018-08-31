<%@ page pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
		<title>流程实例-[${processRun.subject}]表单</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
		<%@include file="/commons/include/customForm.jsp" %>
		<script type="text/javascript">
		var isExtForm=eval('${isExtForm}');
		$(function(){
			if(isExtForm){
				var formUrl=$('#divExternalForm').attr("formUrl");
				$('#divExternalForm').load(formUrl, function() {
					//将所有input改为readonly
					$('input').each(function(){
						$(this).parent('td').text($(this).val());
					})
					$('a').each(function(){
						$(this).remove();
					})
				});
			}
		});
	</script>	
</head>
<body>
       <div class="l-layout-header">流程实例-[${processRun.subject}]表单</div>
       <div class="panel">
		<div class="panel-body">
 		表单URL:${form} 
			<c:choose>
				<c:when test="${isExtForm==true }">
					<div id="divExternalForm" formUrl="${form}"></div>
				</c:when>
				<c:otherwise>
					${form}
				</c:otherwise>
			</c:choose>
	   </div>
      </div> 
</body>
</html>
