<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/include/get.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	
	<%@include file="/commons/include/html_doctype.html"%>
	<%@ include file="/commons/include/get.jsp"%>
	<%@include file="/commons/include/form.jsp"%>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<link href="${ctx}/styles/cloud/main.css" rel="stylesheet" type="text/css" />
	<title>导入信息</title>	
	<script>
	$(function() {
		var options={};
		if(showResponse){
			options.success=showResponse;
		}
		var frm=$('#f1').form();
		$("#importButton").click(function() {
			
			var file=$('#excel').val();
			var tem=file.substring(file.length-3,file.length);
			if(file==""){			 
				$.ligerMessageBox.alert("提示信息",	"请选择文件！");
				return;
			}
			if(tem!="xls"){
				$.ligerMessageBox.alert("提示信息",	"请选择扩展名为.xls的文件！");
				return;
			}
			$("#importButton").attr({"disabled":"disabled"});
			frm.submit();
		});
		
	});
	
	function showResponse(responseText) {
		var obj = new com.cosim.form.ResultMessage(responseText);
		dd.close();
		if (obj.isSuccess()) {
			$.ligerMessageBox.success("提示信息", "导入成功", function(rtn) {
				parent.location.href = "#";
				this.close();
			});
		} else {
			$.ligerMessageBox.error("提示信息",obj.getMessage());
		}
	}
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">会员信息导入</span>
			</div>
		</div>
		<div class="panel-body">
			<form id="f1" action="${ctx}/cloud/tenant/importTenantInfo.ht" method="post" enctype="multipart/form-data">
				<table class="table-grid">
					<tr>
						<td style="text-align:right; width: 18%;">文件导入</td>
						<td style="text-align:left; width: 82%; padding-left:10px;"><input type="file" id="excel" name="excel"/></td>
					</tr>
					<tr>
						<td style="text-align:right; width: 18%;"></td>
						<td style="text-align:left; width: 82%;padding-left:10px;">
							<input  style="padding:0px 5px;" type="button" type="button" id="importButton" value="导入" />
							<input  style="margin-left:10px; padding:0px 5px;" type="button" onclick="javascript:window.history.go(-1)" value="返回"/>
							<a style="margin-left:30px;" href="${ctx}/template/cloud/会员信息_模版.xls">模板下载</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>
