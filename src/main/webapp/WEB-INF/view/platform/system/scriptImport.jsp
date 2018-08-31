
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>自定义表导入</title>
<%@include file="/commons/include/form.jsp" %>

	<script type="text/javascript">
	window.name="win";
			
	$(function(){
		valid(showResponse);
		
		$("#btnSave").click(function(){
			var path = $('#xmlFile').val();
			var extNaem = path.substring(path.length-3, path.length);
			if(extNaem!='xml'){
				$.ligerMessageBox.warn("提示","请选择 *.xml文件进行导入!");
			}else{

				$("#importForm").submit();
			}
		});			
	});
	
	function showResponse(responseText){
		var obj=new com.cosim.form.ResultMessage(responseText);
		if(obj.isSuccess()){//成功
			$.ligerMessageBox.success('提示信息',obj.getMessage(),function(){
				window.returnValue=obj.getMessage();
				window.close();
			});
	    }else{//失败
	    	$.ligerDialog.err('出错信息',"自定义表导入失败",obj.getMessage());
	    }
	}
	
	function valid(showResponse){
		var options={success:showResponse};
		__valid=$("#importForm").validate({
			rules: {},
			messages: {},
			submitHandler:function(form){
				$(form).ajaxSubmit(options);
		    },
		    success: function(label) {}
		});
	}
	
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义表导入</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="btnSave">导入</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del" onclick="javasrcipt:window.close()">关闭</a></div>
				
				</div>	
			</div>
	</div>
	<div class="panel-body">
		<div class="panel-search">
			<form id="importForm" name="importForm" method="post" target="win" action="importXml.ht" enctype="multipart/form-data">
				<div class="row">
				 <table id="tableid" class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="22%">选择文件：</th>
						<td width="78%"><input type="file" size="40" name="xmlFile" id="xmlFile"/></td>						
					</tr>
				</table>				
				</div>
		    </form>
		</div>    		
	</div><!-- end of panel-body -->				
</div> 
</body>
</html>