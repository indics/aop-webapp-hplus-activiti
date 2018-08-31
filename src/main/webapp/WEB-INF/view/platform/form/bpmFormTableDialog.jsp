
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>选择自定义表</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerLayout.js" ></script>
<script type="text/javascript">
	$(function(){
		$("#defLayout").ligerLayout({ topHeight: 65,bottomHeight:40,allowTopResize:false,allowBottomResize:false});
		
		$("tr.odd,tr.even").unbind("hover");
		$("tr.odd,tr.even").click(function(){
			$(this).siblings().removeClass("over").end().addClass("over");
		});
	})

	function selectTable(){
		var obj=$("#bpmFormTableItem tr.over");
	
		if(obj.length>0){
			var objInput=$("input",obj);
			var aryTb=objInput.val().split(",");
			parent.getTable(aryTb[0],aryTb[1]);
		}
	}
	 
</script>
<style type="text/css">
	div.bottom{text-align: center;padding-top: 10px;}
	body {overflow: hidden;}
</style>
</head>
<body>
	
	<div id="defLayout">
		<div position="top" title="选择自定义表" >
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="dialog.ht">
				
						<span class="label">表名:</span><input type="text" name="Q_tableName_S"  class="inputText" size="10" value="${param['Q_tableName_S']}"/>
						<span class="label">描述:</span><input type="text" name="Q_tableDesc_S"  class="inputText" size="10" value="${param['Q_tableDesc_S']}"/>
						
				</form>
			</div>
		</div>
		<div position="center"  style="overflow: auto;">
	    	<display:table name="bpmFormTableList" id="bpmFormTableItem" requestURI="list.ht" sort="external"  export="false"  class="table-grid">
				<display:column  title="表名" style="text-align:left;width:200px;">
					<input  type="hidden" value="${bpmFormTableItem.tableId },${bpmFormTableItem.tableName }">
					${bpmFormTableItem.tableName }
				</display:column>
				<display:column property="tableDesc" title="描述" style="text-align:left"></display:column>
			</display:table>
			<cosim:paging tableId="bpmFormTableItem"/>
		</div>
		<div position="bottom"  class="bottom">
			<a href='#' class='button'  onclick="selectTable()" ><span class="icon ok"></span><span>选择</span></a>
			<a href='#' class='button' style='margin-left:10px;' onclick="parent.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div> 
</body>
</html>


