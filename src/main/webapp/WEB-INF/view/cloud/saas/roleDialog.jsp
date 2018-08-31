<%@page pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html"%>
<%@include file="/commons/include/get.jsp"%>
<html>
	<head>
		<title>选择角色</title>
		<%@include file="/commons/include/form.jsp" %>
		<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	    <script type="text/javascript"	src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	    <script type="text/javascript"	src="${ctx}/js/cosim/displaytag.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#defLayout").ligerLayout({ leftWidth: 320,height: '100%',minLeftWidth:220,centerWidth:50,rightWidth:300});
				displayRightTable();
			});
			
			function selectRole(){
				var saasRoles = $.getSelectedRows($('#saasRoleItem'),$('#saasRoleItem tbody tr'));
				window.returnValue={roleId:saasRoles};
				window.close();
			}
			
			function toRight(){
				//获取所选
				var $frame = $(window.frames['roleFrame'].document);
				var $table = $frame.find('#sysRoleItem');
				var sysRoles = $.getSelectedRows($table);
				var saasRoles = $.getSelectedRows($('#saasRoleItem'),$('#saasRoleItem tbody tr'));
				for(var i=0; i<sysRoles.length; i++){
					var role = sysRoles[i];
					var flag = true;
					for(var j=0; j<saasRoles.length; j++){
						flag = true;
						var saasRole = saasRoles[j];
						 if(role.roleId == saasRole.roleId){
							 $.ligerMessageBox.warn('提示信息', role['角色名'] + '已存在,请不要重复勾选');
							 flag = false;
							 break;
						 }
					}
					if(flag)
						appendRow(i, role);
				}
				
				displayRightTable();
			}
			
			/**
			  *
			  *<tr class="odd">
					<td style="width:30px;">
						<input type="checkbox" value="10000034580004" name="roleId" class="pk">
						<input type="hidden" value="总裁助理" name="roleName">
					</td>
					<td>总裁助理</td>
					<td>副总裁助理</td>
				</tr>
			  *
			  */
			function appendRow(index,saasRole){
				var styleClass = index%2==0?'even':'odd';
				var $tr = $('<tr class="' + styleClass + '"></tr>');
				$tr.append('<td><input type="checkbox" value="'+ saasRole.roleId + '" name="roleId" class="pk"/></td>');
				$tr.append('<td>' + saasRole['角色名'] + '</td>');
				
				$('#saasRoleItem').append($tr);
			}
			
			function toLeft(){
				$('#saasRoleItem').find('tbody input:checked').parent().parent().remove();
			}
			
			function displayRightTable(){
				//行高亮
				jQuery.highlightTableRows();
				//选中一行
				jQuery.selectTr();
				//全选
				handlerCheckAll();
			}
		</script>
		
	</head>
	<body style="overflow: hidden;">
			<div id="defLayout" >
	            <div position="left" title="系统角色" style="float:left;width:320px;height:500px">
	            	<iframe id="roleFrame" name="roleFrame" height="100%" width="100%" frameborder="0"  src="selector.ht"></iframe>
	            </div>
	            <div position="center" title="选择" style="float:left;width:50px;height:500px">
	            	<div style="padding-top:100px;padding-left:5px;">
	          			<a href='#' class='button'  onclick="toRight();" style="width:20px;"><span>>></span></a>
	          			<br/><br/><br/>
	          			<a href='#' class='button'  onclick="toLeft();" style="width:20px;"><span><<</span></a>
	          		</div>
	            </div>
	            <div position="right" title="企业角色" style="float:left;width:300px;height:500px;overflow-y:auto">
	            	<table cellspacing="1" cellpadding="1" class="table-grid table-list" id="saasRoleItem">
						<thead>
							<tr>
								<th style="width:10px;">
									<input type="checkbox" id="chkall">
								</th>
								<th class="sortable" style="width:90%;">
									角色名
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="saasRole" items="${saasRoleList}">
								<tr>
									<td style="width:30px;">
										<input type="checkbox" value="${saasRole.roleId}" name="roleId" class="pk">
									</td>
									<td>${saasRole.roleName}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
	            </div>
	            <div position="bottom"  class="bottom" style='margin-top:10px; border:0px;'>
				    <a href='#' class='button'  onclick="selectRole()" ><span class="icon ok"></span><span >设置</span></a>
				   	<a href='#' class='button' style='margin-left:10px;' onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
				</div>
       	  </div>
       	  
	</body>
</html>