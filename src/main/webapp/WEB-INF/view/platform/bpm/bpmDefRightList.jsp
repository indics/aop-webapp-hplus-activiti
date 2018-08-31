<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" import="com.cosim.platform.model.bpm.BpmDefRights"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>流程定义权限管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/commons/include/form.jsp" %>
<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmDefRights"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/htButtons.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>

<script type="text/javascript">
	$(function() {
		$("span.htbtn").htButtons();

		function showRequest(formData, jqForm, options) { 
			return true;
		} 
		valid(showRequest,showResponse);
		
		$("a.save").click(function() {
			$('#bpmDefRightsForm').submit(); 
		});
		
		function showResponse(responseText, statusText)  { 
			var obj=new com.cosim.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerMessageBox.success('提示信息',obj.getMessage(),function(rtn){
					if(rtn){
						window.close();
					}
				});
				
		    }else{//失败
		    	$.ligerDialog.err("出错信息","保存流程定义权限失败",obj.getMessage());
		    }
		} 
		
	});

	function resetSelect(obj) {
		var tr=$(obj).parents("tr");
		$(tr).find(":input[name='ownerId']").val('');
		$(tr).find(":input[name='ownerName']").val('');
	}

	function setVal(obj,userIds, fullnames){
		var tr=$(obj).parents("tr");
		$(tr).find(":input[name='ownerId']").val(userIds);
		$(tr).find(":input[name='ownerName']").val(fullnames);
	}
	
	function chooseUser(obj) {
		UserDialog({
			callback:function(userIds, fullnames){
				setVal(obj,userIds, fullnames);
			}
		});
	};

	function chooseOrg(obj){
		OrgDialog({
			callback:function(orgIds, orgnames){
				setVal(obj,orgIds, orgnames);
			}
		});
	};

	function chooseRole(obj){
		RoleDialog({
			callback:function(roleIds, rolenames){
			setVal(obj,roleIds, rolenames);
			}
		});
	};
	
	function isChangeCheck(){
		var v = $('#isChange').val();
		if(v==0){
			$('#isChange').val(1);
		}else{
			$('#isChange').val(0);
		}
	}

</script>

</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
				<c:choose>
					<c:when test="${type==0}">${bpmDefinition.subject}</c:when>
					<c:otherwise>${globalType.typeName}</c:otherwise>
				</c:choose>-权限设置
				</span>
			</div>
			
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link save">保存</a>
					</div>
					<div class="l-bar-separator"></div>
					<c:if test="${isParent==1}">
						<div class="group">
							<input type="checkbox" id="chbIsChange" onclick="isChangeCheck()" > 子类型随父类型权限变更
						</div>
						<div class="l-bar-separator"></div>
					</c:if>
					<div class="group"><a class="link del" onclick="window.close()" href="#">关闭</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			
			<form id="bpmDefRightsForm" action="${ctx}/platform/bpm/bpmDefRight/save.ht" method="post">
				<input type="hidden"  name="id" value="${id}">
				<input type="hidden"  name="type" value="${type}">
				<input type="hidden"  name="defKey" value="${defKey}">
				<input type="hidden"  id="isChange" name="isChange" value="0">
				
						<table id="bpmDefRightTable"  class="table-detail table-grid" cellpadding="0" cellspacing="0" border="0">
							<thead>
							<tr>
								<th>权限分类</th>
								<th style="text-align: center;">授权给</th>
								<th style="text-align: center;">选择</th>
							</tr> 
							</thead>
								<tr>
									<td>用户授权</td>
									<td>
										<textarea rows="3" cols="60" name="ownerName" readonly="readonly">${rightsMap.user.ownerName}</textarea>
										<input type="hidden" name="ownerId" value="${rightsMap.user.ownerId }">
										<input type="hidden" name="rightType" value="1">
									</td>
									<td>
										<a class="button" onclick="chooseUser(this);" ><span>选择...</span></a>
										&nbsp;				
										<a class="button" onclick="resetSelect(this);" ><span>重置</span></a>
									</td>
								</tr>
								<tr>
									<td>角色授权</td>
									<td>		
										<textarea rows="3" cols="60" name="ownerName" readonly="readonly">${rightsMap.role.ownerName}</textarea>
										<input type="hidden" name="ownerId" value="${rightsMap.role.ownerId }">
										<input type="hidden" name="rightType" value="2">				
									</td>
									<td>
										<a class="button" onclick="chooseRole(this);" ><span>选择...</span></a>
										&nbsp;
										<a class="button" onclick="resetSelect(this);" ><span>重置</span></a>
									</td>
								</tr>
								<tr>
									<td>组织授权</td>
									<td>
										<textarea rows="3" cols="60" name="ownerName" readonly="readonly">${rightsMap.org.ownerName}</textarea>
													<input type="hidden" name="ownerId" value="${rightsMap.org.ownerId }">
													<input type="hidden" name="rightType" value="3">
									</td>
									<td>
										<a class="button" onclick="chooseOrg(this);" ><span>选择...</span></a>
										&nbsp;
										<a class="button" onclick="resetSelect(this);" ><span>重置</span></a>
									</td>
								</tr>
						</table>
					
				</form>
			
		</div>
		<!-- end of panel-body -->
	</div>
	<!-- end of panel -->
</body>
</html>


