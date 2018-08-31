<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>通用表单查询管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript">
	function selectQuery(){
		var alias="";
		$(".pk").each(function(){
			var checked=$(this).attr("checked");
			if(checked){
				alias=$(this).val();
			}
		});
		
		if(alias==""){
			$.ligerMessageBox.confirm('提示信息','请选择一条记录');
			return;
		}else{
			//如果打开了弹出窗口
	    	if(window.parent.document.getElementById("dialog-body")){
	    		window.parent.rtn = alias;//将要返回的数据赋值给父窗口的rtn变量
	        	window.parent.isDialogHTML5Close = true;//弹出窗口已经关闭
	        	closeDialogHTML5(); 	
	        	return;
	    	}
			window.returnValue=alias;
			window.close();
		}
		
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">通用表单查询管理列表</span>
			</div>
		</div>
		<div class="panel-body" >
		    <display:table name="bpmFormQueryList" id="bpmFormQueryItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
			  		<input type="radio" class="pk" name="id" value="${bpmFormQueryItem.alias}">
				</display:column>
				<display:column property="name" title="名称" sortable="true" sortName="name"></display:column>
				<display:column property="alias" title="别名" sortable="true" sortName="alias"></display:column>
				<display:column property="objName" title="对象名称" sortable="true" sortName="objName"></display:column>
			</display:table>
			<cosim:paging tableId="bpmFormQueryItem" showExplain="false"/>
		</div><!-- end of panel-body -->	
		<div position="bottom"  class="bottom" >
			<a href="#" class="button"  onclick="selectQuery()" ><span class="icon ok"></span><span >选择</span></a>
			<a href="#" class="button" style="margin-left:10px;"  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>			
	</div> <!-- end of panel -->
</body>
</html>


