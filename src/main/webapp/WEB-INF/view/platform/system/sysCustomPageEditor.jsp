
<%--
	time:2012-10-29 12:00:23
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>自定义页面明细</title>
<%@include file="/commons/include/getById.jsp"%>
<!-- ueditor -->
<link rel="stylesheet" type="text/css" href="${ctx}/js/ueditor/themes/default/ueditor.css"/>
<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/page-editor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/page-editor/editor_api.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/js/cosim/platform/system/PageUEditor.js"></script>
<style type="text/css">
	div.custom-display{
		background-color: red;
	}
</style>
<script type="text/javascript">
	//放置脚本
	$(function(){
		//初始化编辑器
		var pageUEditor=new PageUEditor();
		var editor = pageUEditor.getEditor();
		editor.addListener('ready',function(){
			//设置初始内容
			var arguments = window.dialogArguments;
			editor.setContent(arguments.template);
		});
		editor.render("pageEditor");		
		//绑定关闭事件
		$('a.link.close').click(function(){
			var retval={
					status:false
			};
			window.returnValue=retval;
			window.close();
		});
		//绑定确定事件
		$('a.link.ok').click(function(){
			var content = editor.getContent();
			var retval={
					status:true,
					value:content
			};
			window.returnValue=retval;
			window.close();
		});
		
		
	});
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义页面内容</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link ok" href="#">确定</a>
					</div>
					<div class="l-bar-separator"></div>
					<a class="link close" href="#">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<div id="pageEditor"></div>
	</div>
</body>
</html>

