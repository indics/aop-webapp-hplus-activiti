<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/include/get.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	
	<%@include file="/commons/include/html_doctype.html"%>
	<%@include file="/commons/include/form.jsp"%>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<link href="${ctx}/styles/cloud/main.css" rel="stylesheet" type="text/css" />
	<title>分类基本信息</title>	
	<script>
		var options = {};
		var dd = {}
		if (showResponse) {
			options.success = showResponse;
		}
		
		function showResponse(responseText) {			
			var obj = new com.cosim.form.ResultMessage(responseText);
			dd.close();
			if (obj.isSuccess()) {
				$.ligerMessageBox.alert("提示信息",obj.getMessage());
			} else {
				$.ligerMessageBox.error("提示信息", obj.getMessage());
			}
		}
		
		//导入Excel
		function importExcel(){
			var frm = $('#importForm').form();
			var file = $('#importForm').find('#excel').val();
			var tem=file.substring(file.length-3,file.length);
			
			if(file==""){
				$.ligerMessageBox.alert("提示信息","请选择文件！");
				return;
			}
			
			if(tem!="xls"){
				$.ligerMessageBox.alert("提示信息","请选择扩展名为.xls的文件！");
				return;
			}
			
			dd = $.ligerDialog.waitting('正在导入,请等待...');			
			frm.ajaxForm(options);
			frm.submit();
		}
	</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">用户基本信息</span>
			</div>
		</div>
		<div class="panel-body">
			<form id="importForm" action="improtUser.ht" method="post" enctype="multipart/form-data">
			<table class="table-grid">
				<tr>
					<td style="text-align:right; width: 18%;">文件导入</td>
					<td style="text-align:left; width: 82%; padding-left:10px;"><input type="file" id="excel" name="excel"/></td>
				</tr>
				<tr>
					<td style="text-align:right; width: 18%;"></td>		
					<td style="text-align:left; padding-left:10px;">
						<input style="padding:0px 5px;" type="button" onclick="importExcel();" value="数据导入"/>
						<a style="margin-left:20px; font-weight:bold;" href="${ctx}/template/XX企业-人员信息导入.xls" id="template">模板下载</a>
					</td>
				</tr>
				<tr>
					<td style="text-align:right; width: 18%; color:red;">注意</td>		
					<td style="text-align:left; padding-left:10px; color:red;">
						1.在信息导入前，请下载为您提供的导入模板。<br/>
						2.部门名称必须跟系统的名称相对应。<br/>
						3.角色名称必须跟系统的名称相对应。
					</td>
				</tr>
			</table>
			</form>
		</div>	
	</div>
</div>
</body>
</html>
