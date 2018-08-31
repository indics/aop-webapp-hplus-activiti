
<%--
	time:2011-11-16 16:34:16
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>表单授权</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/form.jsp"%>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/Permission.js"></script>

<script type="text/javascript">
	var nodeId="${nodeId}";
	var actDefId="${actDefId}";
	var formKey="${formKey}";
	var tableId="${tableId}";
	var isNodeRights=${isNodeRights};

	var __Permission__;
	
	$(function() {
		//权限处理
		__Permission__=new Permission();
		//设置节点权限。
		if(isNodeRights){
			__Permission__.loadByNode(actDefId,nodeId,formKey);
			$("#nodeId").change(changeNode);
		}
		else{
			//根据表单key获取表单权限。
			__Permission__.loadPermission(tableId,formKey);
		}
		$("#dataFormSave").click(savePermission);
		$("input:radio").click(setPermision);
		$("#initRights").click(function(){
			$.ligerDialog.confirm("是否确定重置权限设置?",function (r){
					if(r){
						var url = __ctx+"/platform/form/bpmFormDef/initRights.ht";
						$.post(url,{formkey:formKey},function(d){
							if(d.result)
								$.ligerDialog.success(d.message,function(){
									location.reload();		
								});
							else
								$.ligerDialog.warn(d.message);
						});
					}
				});
		});
	});
	
	//批量设置权限。
	function setPermision(){
		var val=$(this).val();
		var obj=$(this).closest("[name=tableContainer]");
		$("span[name='r_span'],span[name='w_span']",obj).hide();
		$("span[name='r_span'],span[name='w_span']",obj).val("");
		switch(val){
			//hidden
			case "1":
				$(".r_select,.w_select",obj).val("none");
				break;
			//readonly
			case "2":
				$(".r_select",obj).val("everyone");
				$(".w_select",obj).val("none");
				break;
			//edit
			case "3":
				$(".r_select,.w_select",obj).val("everyone");
				break;
		}
	}
	
	//重新加载任务节点的权限
	function changeNode(){
		var obj=$("#nodeId");
		nodeId=obj.val();
		__Permission__.loadByNode(actDefId,nodeId,formKey);
	};
	
	//保存权限数据。
	function savePermission(){
		//设置所有的权限。
		__Permission__.setAllPermission();
		
		var json=__Permission__.getPermissionJson();
		var params={};
		params.formKey=formKey;
		params.permission=json;
		//流程节点权限。
		if(isNodeRights){
			params.actDefId=actDefId;
			params.nodeId=nodeId;
		}
		
		$.post("savePermission.ht",params,showResponse);
	}
		
	function showResponse(data){
		var obj=new com.cosim.form.ResultMessage(data);
		if(obj.isSuccess()){//成功
			$.ligerMessageBox.confirm('提示信息','操作成功,继续操作吗?',function(rtn){
				if(!rtn){
					window.close();
				}
			});
	    }else{//失败
	    	$.ligerDialog.err('出错信息',"表单授权失败",obj.getMessage());
	    }
	};
</script>
</head>
<body >
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">表单授权</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group">
					<a class="link save" id="dataFormSave" href="#">保存</a>
				</div>
				<div class="l-bar-separator"></div>
				<div class="group">
					<a class="link close" href="javascript:window.close();">关闭</a>
				</div>
				<c:if test="${nodeId==null}">
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link init" id="initRights" href="javascript:;">重置权限设置</a>
					</div>
				</c:if>				
			</div>
		</div>
	</div>

	<div  class="panel-body">
			<c:if test="${isNodeRights}">
				<form id="bpmFormDefForm">
					<table cellpadding="0" cellspacing="0" border="0" style=" margin: 4px 0px;"  class="table-detail">
						<tr style="height:25px;">
							<td>流程节点:
								<select id="nodeId" >
									<c:forEach items="${nodeMap }" var="node">
										<option value="${node.key}" <c:if test="${node.key== nodeId}"> selected="selected" </c:if> >${node.value}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
					
				</form>
				
			</c:if>
			
			<table cellpadding="1" cellspacing="1" class="table-grid" name="tableContainer">
				<tr>
					<th width="20%">字段</th>
					<th width="40%">只读权限</th>
					<th width="40%">编辑权限</th>
				</tr>
				<tr>
					<td colspan="3">
						<input type="radio" value="1" name="rdoPermission" id="fieldHidden" ><label for="fieldHidden">隐藏</label>
						<input type="radio" value="2" name="rdoPermission" id="fieldReadonly"><label for="fieldReadonly">只读</label>
						<input type="radio" value="3" name="rdoPermission" id="fieldEdit" ><label for="fieldEdit">编辑</label>
					</td>
				</tr>
				<tbody id="fieldPermission"></tbody>
			</table>
		
			<table  cellpadding="1" cellspacing="1" class="table-grid" style="margin-top: 5px;"  name="tableContainer">
				<tr>
					<th width="20%">子表</th>
					<th width="40%">只读权限</th>
					<th width="40%">编辑权限</th>
				</tr>
				<tr>
					<td colspan="3">
						<input type="radio" value="1" name="rdoTbPermission" id="tableHidden" ><label for="tableHidden">隐藏</label>
						<input type="radio" value="2" name="rdoTbPermission" id="tableReadonly"><label for="tableReadonly">只读</label>
						<input type="radio" value="3" name="rdoTbPermission" id="tableEdit" ><label for="tableEdit">编辑</label>
					</td>
				</tr>
				<tbody id="tablePermission"></tbody>
			</table>
		
			<table  cellpadding="1" cellspacing="1" class="table-grid" style="margin-top: 5px;" name="tableContainer">
				<tr>
					<th width="20%">意见</th>
					<th width="40%">只读权限</th>
					<th width="40%">编辑权限</th>
				</tr>
				<tr>
					<td colspan="3">
						<input type="radio" value="1" name="rdoOpPermission" id="opinionHidden" ><label for="opinionHidden">隐藏</label>
						<input type="radio" value="2" name="rdoOpPermission" id="opinionReadonly"><label for="opinionReadonly">只读</label>
						<input type="radio" value="3" name="rdoOpPermission" id="opinionEdit" ><label for="opinionEdit">编辑</label>
					</td>
				</tr>
				<tbody id="opinionPermission"></tbody>
			</table>
	</div>
</body>
</html>

