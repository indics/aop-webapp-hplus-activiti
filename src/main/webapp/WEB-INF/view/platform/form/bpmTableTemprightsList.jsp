<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" import="com.cosim.platform.model.bpm.BpmDefRights"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>业务数据模板权限管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/commons/include/form.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmTableTemprights"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/htButtons.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>

<script type="text/javascript">
	$(function() {
		function showRequest(formData, jqForm, options) { 
			return true;
		} 
		function showResponse(responseText, statusText)  {			
			var obj=new com.cosim.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerMessageBox.success('提示信息',obj.getMessage(),function(rtn){
					if(rtn){
						window.close();
					}
				});				
		    }else{//失败
		    	$.ligerDialog.err('出错信息',"保存角色资源失败",obj.getMessage());
		    }
		}
		valid(showRequest,showResponse);
		
		$("a.save").click(function() {
			$('#bpmTableTemprightsForm').submit(); 
		});
	});

	function reset(obj) {
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

</script>

</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
				<c:choose>
					<c:when test="${type==0}">${bpmTableTemplate.templateName}</c:when>
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
					<div class="group"><a class="link del" onclick="window.close()" href="#">关闭</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div class="panel-data">
			<form id="bpmTableTemprightsForm" action="${ctx}/platform/form/bpmTableTemprights/save.ht" method="post">
				<div class="panel-detail">
					<input type="hidden"  name="id" value="${id}">
					<input type="hidden"  name="type" value="${type}">
					<table id="bpmDefRightTable"  class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th>权限分类</th>
							<th style="text-align: left;">授权给</th>
							<th style="text-align: left;">选择</th>
						</tr> 
							<tr>
								<th>用户授权</th>
								<td>
									<textarea rows="3" cols="60" name="ownerName">${rightsMap.user.ownerName}</textarea>
									<input type="hidden" name="ownerId" value="${rightsMap.user.ownerId }">
									<input type="hidden" name="rightType" value="1">
								</td>
								<td>
									<a class="button" onclick="chooseUser(this);" ><span>选择...</span></a>
									&nbsp;				
									<a class="button" onclick="reset(this);" ><span>重置</span></a>
								</td>
							</tr>
							<tr>
								<th>角色授权</th>
								<td>		
									<textarea rows="3" cols="60" name="ownerName">${rightsMap.role.ownerName}</textarea>
									<input type="hidden" name="ownerId" value="${rightsMap.role.ownerId }">
									<input type="hidden" name="rightType" value="2">				
								</td>
								<td>
									<a class="button" onclick="chooseRole(this);" ><span>选择...</span></a>
									&nbsp;
									<a class="button" onclick="reset(this);" ><span>重置</span></a>
								</td>
							</tr>
							<tr>
								<th>组织授权</th>
								<td>
									<textarea rows="3" cols="60" name="ownerName">${rightsMap.org.ownerName}</textarea>
												<input type="hidden" name="ownerId" value="${rightsMap.org.ownerId }">
												<input type="hidden" name="rightType" value="3">
								</td>
								<td>
									<a class="button" onclick="chooseOrg(this);" ><span>选择...</span></a>
									&nbsp;
									<a class="button" onclick="reset(this);" ><span>重置</span></a>
								</td>
							</tr>
					</table>
					</div>
				</form>
			</div>
		</div>
		<!-- end of panel-body -->
	</div>
	<!-- end of panel -->
</body>
</html>


