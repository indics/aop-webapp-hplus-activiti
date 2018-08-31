<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" import="com.cosim.platform.model.system.Resources"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>角色资源分配</title>
	<%@include file="/commons/include/form.jsp" %>
	<base target="_self"/> 
	<link href="${ctx}/styles/ligerUI/ligerui-all.css" rel="stylesheet"	type="text/css" />
	<link rel="stylesheet" href="${ctx }/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script> 
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.exedit-3.5.min.js"></script> 
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
	<script type="text/javascript">
		//当前访问系统
		var systemId = ${f:getCurrentSystemId()};
		var roleId = '${requestScope.roleId}';
		var tenantId = '${requestScope.tenantId}';
		
		//树展开层数
		var expandDepth = 1; 
		$(function(){
			//加载树
			loadTree();
			$("a.save").click(save);
		});
	  
		//树
		var resourcesTree;
		//加载树
		function loadTree(){
			var setting = {
				data: {
					key : {
						name: "resName",
						title: "resName"
					},
					simpleData: {
						enable: true,
						idKey: "resId",
						pIdKey: "parentId",
						rootPId: <%=Resources.ROOT_PID%>
					}
				},
				view: {
					selectedMulti: true
				},
				check: {
					enable: true,
					chkboxType: { "Y": "ps", "N": "s" }
				}
				
			};
			
			
			function successFun(result){
				resourcesTree = $.fn.zTree.init($("#resourcesTree"), setting,eval(result));
				if(expandDepth!=0){
					resourcesTree.expandAll(false);
					var nodes = resourcesTree.getNodesByFilter(function(node){
						return (node.level < expandDepth);
					});
					if(nodes.length>0){
						for(var i=0;i<nodes.length;i++){
							resourcesTree.expandNode(nodes[i],true,false);
						}
					}
				}else{
					resourcesTree.expandAll(true);
				}
			}
			
			//一次性加载
			var url="${ctx}/cloud/saas/res/getTenantResTreeChecked.ht";
			$.ajax({
				type: "POST",
				url: url,
				data: {
					tenantId: tenantId, 
					roleId: roleId,
					systemId:systemId
				},
				success: successFun
			});
		}
		
		//保存
		function save(){
			var resourcesTree = $.fn.zTree.getZTreeObj("resourcesTree");
			var nodes = resourcesTree.getCheckedNodes(true);
			var resIds="";
			$.each(nodes,function(i,n){
				if(n.resId!=<%=Resources.ROOT_ID%>)resIds+=n.resId+",";
			});
			
			resIds=resIds.substring(0,resIds.length-1);
		
			var url="${ctx}/cloud/saas/res/upd.ht";
			var data= "tenantId=${tenantId}&roleId=${roleId}&resIds="+resIds;
			$.post(url,data,function(result){
				var obj=new com.cosim.form.ResultMessage(result);
				if(obj.isSuccess()){
					$.ligerMessageBox.confirm('提示信息','企业资源分配成功,是否继续?',function(rtn){
						if(!rtn){
							window.close();
						}
					});
				}else{
					$.ligerMessageBox.warn('企业资源分配出错!');
				}
			})
		};
	</script>
<style type="text/css">
body{overflow:hidden;}
.ztree{overflow: auto;<c:if test="${systemId!=null}">height: 380px;</c:if><c:if test="${systemId==null}">height: 350px;</c:if> }
html { overflow-x: hidden; }
</style>
</head>
<body>
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">企业资源配置</span>
			<div class="toolBar" style="float:right;">
				<div class="group"><a class="link save" id="btnSearch">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link del" onclick="javasrcipt:window.close()">关闭</a></div>
			</div>	
		</div>
		<div class="panel-toolbar" style="display:none;">
			<div class="toolBar">
				<div class="group"><a class="link save" id="btnSearch">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link del" onclick="javasrcipt:window.close()">关闭</a></div>
			</div>	
		</div>
	</div>
	<div class="row" style="display: none;">
		<div class="panel-detail">
			<table id="disSys" border="0" cellspacing="0" cellpadding="0"  class="table-detail">
				<tr>
					<td width="30%" style="text-align: right;">
						<span class="label">选择系统:</span>
					</td>
					<td>
						<select id="subSystem">  
							<c:forEach var="subSystemItem" items="${subSystemList}"> 
							 <option <c:if test="${systemId==subSystemItem.systemId}">selected="selected"</c:if> value="${subSystemItem.systemId}">${subSystemItem.sysName}</option>  
					        </c:forEach>  
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="panel-detail" >
		<div id="resourcesTree" class="ztree"></div>
	</div>
</body>
</html>
<script>
$(function(){
	var clientWith = document.body.clientWidth;
	var clientHeight = document.body.clientHeight;
	$('.panel-detail').height(clientHeight-110);
	$('#resourcesTree').height(clientHeight-120);
});
</script>