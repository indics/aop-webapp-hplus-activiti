<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>代码生成</title>
<%@include file="/commons/include/form.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/displaytag.js" ></script>
<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/BpmDefinitionDialog.js"></script>
<script type="text/javascript">
	var form;
	$(function() {
		var options={};
		if(showResponse){
			options.success=showResponse;
		}
		form=$("#codeForm").form();
		form.ajaxForm(options);
		$("#codeDetail").ligerLayout({ 
			leftWidth: '25%',
			height: '100%',
			topHeight:30,
			bottomHeight:50,
			allowLeftCollapse:false,
			rightWidth:'73%',
			centerWidth:'2%',
			allowRightResize:false,
		 	allowRightCollapse:false
		});
		initTable();
		$("#dataFormSave").click(codegen);
		
	});
	
	
	function codegen(){
		var hasTemp=$('[name="templateId"]:checked').length;
		var hasTable=$("#codeForm").find('[name="tableId"]').length;
		if(!hasTable){
			$.ligerMessageBox.error('提示信息','还未选择任何自定义表');
			return;
		}
		if(hasTemp==0){
			$.ligerMessageBox.error('提示信息','还未选择任何模版');
			return;
		}
		if(form.valid()){
			$("#codeForm").submit();
		}
		
	}
	function showResponse(responseText) {
		var obj = new com.cosim.form.ResultMessage(responseText);
		if (obj.isSuccess()) {
			$.ligerMessageBox.success("成功", obj.getMessage(), function() {
				window.close();
				$("#codeForm").resetForm();
			});
		} else {
			$.ligerMessageBox.error("提示信息",obj.getMessage());
		}
	}
	
	function initTable(){
		var tree=window.parent.tableTree;
		var nodes=tree.getCheckedNodes(true);
		for(var i=0;i<nodes.length;i++){
			var node=nodes[i];
			var tableName=node.tableName;
			var className=$.getFirstUpper(tableName);
			var classVar=$.getFirstLower(tableName);
			var tr="<tr><td>"+tableName+
			"<input type='hidden' name='tableName' value='"+tableName+"'/>"+
			"</td><td><input type='text' class='inputText' name='className' validate='{required:true}' value='"+className+"'/></td>"+
			"<td><input type='text' class='inputText' name='classVar' validate='{required:true}' value='"+classVar+"'/></td>"+
			"<td><input type='text' class='inputText' name='packageName' validate='{required:true}' value=''/></td>"+
			"<input type='hidden' class='inputText' name='tableId' value='"+node.tableId+"'/>"+
			"</tr>";
			if(node.tableId!=0){
				$("#tableVarSet").append(tr);
			}
		}
	}
	
	function selectFlow(){
		BpmDefinitionDialog({isSingle:true,isAllowApi:true,returnDefKey:true,callback:function(defIds,subjects,defKeys){
			$("#flowName").val(subjects);
			$("#defKey").val(defKeys);
		}});
	}

	
</script>
<style type="text/css">
	html {height: 100%}
	body {padding: 0px;margin: 0;overflow: hidden;}
	#codeDetail {width: 100%;margin: 0;padding: 0;}
</style>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link run" id="dataFormSave" href="#">生成</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
		<form method="post" id="codeForm" action="codegen.ht">
		<div id="codeDetail" style="bottom: 1; top: 1">
			<div position="top">
				<div class="row">
					&nbsp;<span class="label">是否覆盖原有文件:</span>&nbsp;<input type="checkbox" name="override"  class="inputText" value="1" />&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="label">流程定义:</span>&nbsp;<input type="text" id="flowName" name="flowName" readonly="readonly"  class="inputText" value="" />&nbsp;<a  href="#" onclick="selectFlow()"  class="button"><span>选 择...</span></a>
					<input type="hidden" name="defKey" id="defKey" value=""/>
				</div>
			</div>
			<div position="left" title="代码生成器模版" id="tempalteManage" >
				<table cellpadding="1" class="table-grid table-list" cellspacing="1" id="templates">
						<tr style="width:200px;">
							<th><input type="checkbox" id="chkall"/></th>
							<th>模版名称</th>
							<th>别名</th>
						</tr>
						<c:forEach var="template" items="${templateList}" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" name="templateId" class="pk" value="${template.id}" id="templateId" >
							</td>
							<td >
								${template.templateName}
							</td>
							<td>
								${template.templateAlias}
							</td>
							<input type="hidden" name="templateName" value="${template.templateName}"/>
						</tr>
						</c:forEach>
					</table>
			</div>
			<div position="center"></div>
			<div position="right" title="自定义表" id="tableManage">
				<table id="tableVarSet" cellpadding="1" class="table-grid table-list" cellspacing="1">
      				<tr>
      					<th>
      						表名
      					</th>
      					<th>
      						类名(class)
      					</th>
      					<th>
      						变量名(classVar)
      					</th>
      					<th>
      						包名(package)
      					</th>
      				</tr>
      			</table>
			</div>
		</div>
		</form>
		</div>
	</div>
</body>
</html>