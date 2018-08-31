<%@page import="com.cosim.platform.model.system.GlobalType"%>
<%@page pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html"%>
<html>
	<head>
		<title>选择流程表单</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
		<%@include file="/commons/include/form.jsp" %>
		<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
		<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
		<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerLayout.js" ></script>
	    <script type="text/javascript"	src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	    <script type="text/javascript" src="${ctx}/js/cosim/platform/form/GlobalType.js"></script>
	    <script type="text/javascript">
	   		var catKey="<%=GlobalType.CAT_FORM%>";
			var globalType=new GlobalType(catKey,"glTypeTree",{onClick:treeClick,expandByDepth:2});
			
			$(function(){
				$("#defLayout").ligerLayout({ leftWidth: 200,height: '90%',
						bottomHeight :40,
					 	allowBottomResize:false});
			
				globalType.loadGlobalTree();
			});
			
			//展开收起
			function treeExpandAll(type){
				globalType.treeExpandAll(type);
			};
			
			function treeClick( treeNode){
				if(treeNode.isRoot==undefined){
					var categroyId=treeNode.typeId;
				
					var url="selector.ht?categoryId="+categroyId;
	        		$("#formFrame").attr("src",url);
				}
        	}
			
			function selectForm(){
				var formName="";
				var formKey="";
				var tableId="";
				$('#formFrame').contents().find(":radio[name='formKey']:checked").each(function(){
					formName=$(this).siblings("input[name='subject']").val();
					formKey=$(this).val();
					tableId=$(this).siblings("input[name='tableId']").val();
				});
				if(formKey==""){
					$.ligerMessageBox.warn('提示信息',"请选择表单ID!");
					return "";
				}
				//如果打开了弹出窗口
		    	if(window.parent.document.getElementById("dialog-body")){
		    		window.parent.rtn = {formKey:formKey,formName:formName,tableId:tableId};//将要返回的数据赋值给父窗口的rtn变量
		        	window.parent.isDialogHTML5Close = true;//弹出窗口已经关闭
		        	closeDialogHTML5(); 	
		        	return;
		    	}
				window.returnValue={formKey:formKey,formName:formName,tableId:tableId};
				window.close();
			}
			
		</script>
		<style type="text/css">
			body{overflow: hidden;}
			div.bottom{text-align: center;}
			div.bottom input {width:65px;margin: 8px 10px;font-size: 14px;height: 23px;}
		</style>
	</head>
	<body>
			<div id="defLayout" >
	            <div position="left" title="表单分类" style="overflow: auto;float:left;">
					<ul id="glTypeTree" class="ztree"></ul>
	            </div>
	            <div position="center"  title="表单">
	          		<iframe id="formFrame" name="formFrame" height="100%" width="100%" frameborder="0"  src="selector.ht"></iframe>
	            </div>  
       	  </div>
       	 <div position="bottom"  class="bottom" style='margin-top:10px;'>
			  <a href='#' class='button'  onclick="selectForm()" ><span class="icon ok"></span><span >选择</span></a>
			  <a href='#' class='button' style='margin-left:10px;' onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	
	</body>
</html>
