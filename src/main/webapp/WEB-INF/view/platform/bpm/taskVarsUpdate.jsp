<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>修改变量的值</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript">
	var obj=window.dialogArguments;
	$(function(){
		$("#varValue").val(obj.varsValue);
	})
	function save(){
		var value=$('#varValue').val();
		var params={id:obj.id,varsValue:value};
		$.post("updateVars.ht",params,function(data){
			var obj=new com.cosim.form.ResultMessage(data);
			if(obj.isSuccess()){
				$.ligerMessageBox.success("成功",obj.getMessage(),function(){
					window.close();
				})
			}else{
				$.ligerDialog.err('出错信息',"修改变量值失败",obj.getMessage());
			}
		});
	}
	</script>
</head>
<body>
<div class="panel">
  	<div class="panel-top">
		<div class="tbar-title">
		    <span class="tbar-label">修改变量值</span>
		</div>
		<div class="panel-toolbar">
				<div class="toolBar">
				<div class="group"><a class="link save" id="btnSearch" onclick="save()">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link del" onclick="javasrcipt:window.close()">关闭</a></div>
				</div>	
		</div>
 	</div>
	<div class="panel-body">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th width="30%">变量值: </th>
				<td><input type="text" id="varValue" name="varValue"class="inputText"/></td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>
