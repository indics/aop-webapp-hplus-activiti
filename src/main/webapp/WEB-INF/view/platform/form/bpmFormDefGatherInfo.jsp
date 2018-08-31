
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>新建表单</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/form.jsp" %>
<link rel="stylesheet" href="${ctx }/js/tree/v35/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/htCatCombo.js"></script>
<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmFormDef"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/FormTableDialog.js"></script>
<style type="text/css">
	html,body{height:100%;width:100%; overflow: hidden;}
</style>

<script type="text/javascript">
	window.name="frmEdit";
	var designType="table_create";
	$(function(){
		function showRequest(formData, jqForm, options) {
			return true;
		}
		valid(showRequest,showResponse);		
		$("#dataFormSave").click(function(){
			var rtn=$('#bpmFormDefForm').valid();
			if(!rtn) return;
			if(designType=='table_create'){
				var tableId=$("#tableId").val();
				if(!tableId){
					$.ligerMessageBox.error("提示信息","请您选择要生成的表");
					return;
				}
				$("#bpmFormDefForm").attr("action","selectTemplate.ht");
			}
			else{
				$("#bpmFormDefForm").attr("action","chooseDesignTemplate.ht");
			}
			$('#bpmFormDefForm')[0].submit();
		});
	});
	
	function selectTable(){
		var callBack=function(tableId,tableName){		
			$("#tableId").val(tableId);
			$("#tableName").val(tableName);
		}
		FormTableDialog(callBack);
	}
	function resetTable(){
		$("#tableId").val('');
		$("#tableName").val('');
	};
	function designTypeChange(){
		var val = $("input:radio[name='designType']:checked").attr("id");
		if(!val)return;
		designType = val;
		if(designType=="editor_design"){
			$("#table_tr").hide();
		}
		else{
			$("#table_tr").show();
		}
	};
</script>

</head>
<body >
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">新建表单</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link run" id="dataFormSave" href="#">下一步</a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="panel-detail">
			<form  id="bpmFormDefForm" method="post" action="selectTemplate.ht" >
				 
				 <table cellpadding="1" cellspacing="1" class="table-detail">
					<tr>
						<th width="150">表单标题:</th> 
						<td><input id="subject" type="text" name="subject" value="" class="inputText" size="30" /></td>
					</tr>
					<tr>
						<th width="150">表单类型:</th>
						<td>
							<input class="catComBo" catKey="FORM_TYPE" valueField="categoryId" catValue="${categoryId}" name="typeName" height="150" width="200"/>
						</td>
					</tr>
					<tr>
						<th width="150">表单描述:</th>
						<td>
							<textarea rows="3" cols="35" id="formDesc" name="formDesc" class="textarea"></textarea>
						</td>
					</tr>
					<tr>
						<th width="150">设计类型:</th>
						<td>
							<input id="table_create"  onclick="designTypeChange()" name="designType" type="radio" checked="checked"/><label for="table_create">通过表生成</label>
							<input id="editor_design" onclick="designTypeChange()" name="designType" type="radio" /><label for="editor_design">编辑器设计</label>
						</td>
					</tr>
					<tr id="table_tr">
						<th width="150">表:</th>
						<td style="padding-top: 5px;">
							
							<input type="text" id="tableName" name="tableName" value="" readonly="readonly">
							<input type="hidden" id="tableId" name="tableId" value="">
							<a href='#' class='button'  onclick="selectTable()" ><span>...</span></a>
							<a href='#' class='button' style='margin-left:10px;' onclick="resetTable()"><span>重选</span></a>
						</td>
					</tr>
				</table>
				
			</form>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


