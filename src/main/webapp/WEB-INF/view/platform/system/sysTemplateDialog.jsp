<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>信息内容模板选择</title>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript">
		window.name="win";
		$(function(){
			jQuery.highlightTableRows();
		});
		function selectTemplate(obj){		
			var conf=window.dialogArguments;			
			if(conf.isText){
				window.returnValue=$(obj).prev().text();
			}
			else{
				window.returnValue=$(obj).prev().html();
			}
			window.close();
		}
	</script>
</head>
<body>
<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">信息内容模板选择</span>
					</div>
				
				</div>
			<div class="panel-body">
				<div class="panel-data">
					   <display:table name="sysTemplateList" id="sysTemplateItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"  class="table-grid">											
						<display:column property="name" title="模板名称" sortable="true" sortName="name"></display:column>
						<display:column property="content"  title="模板内容" sortable="true" sortName="content" maxLength="80"></display:column>
						<display:column title="选择">
							<span style="display: none;" >${sysTemplateItem.content}</span>
							<a href="javascript:;" onclick="selectTemplate(this)" class="link edit" target="win">选择</a>
						</display:column>
					</display:table>
				</div>
			</div>			
		</div>
</body>
</html>
