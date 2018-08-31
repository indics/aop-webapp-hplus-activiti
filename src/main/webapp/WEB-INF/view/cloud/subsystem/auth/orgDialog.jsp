<%@page pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript">
	
		var orgTree = null;
		//树展开层数
		var expandDepth = 2; 
		$(function() {
			$("#defLayout").ligerLayout({
				leftWidth : 220,
				height : '90%',
				minLeftWidth:220
			});
			
			$('#demensionId').change(function(){
        		var demensionId=$(this).val();
        		loadTree(demensionId);
             });
			
			loadTree(1);
			
			$("#demensionId").val(1);
		});
	
		//展开收起
		function treeExpandAll(type) {
			orgTree = $.fn.zTree.getZTreeObj("orgTree");
			orgTree.expandAll(type);
		};
		
		function treeExpand() {
			orgTree = $.fn.zTree.getZTreeObj("orgTree");
			var treeNodes = orgTree.transformToArray(orgTree.getNodes());
			for(var i=1;i<treeNodes.length;i++){
				if(treeNodes[i].children){
					orgTree.expandNode(treeNodes[i], true, false, false);
				}
			}
		};
		
		function loadTree(value) {
			var setting = {
					data: {
						key : {
							name: "orgName"
						},
					
						simpleData: {
							enable: true,
							idKey: "orgId",
							pIdKey: "orgSupId",
							rootPId: 0
						}
					},
					async: {
						enable: true,
						url:"${ctx}/cloud/config/enterprise/org/selector/getTreeData.ht?demId="+value,
						autoParam:["orgId","orgSupId"]
					},
					callback:{
						onClick : treeClick,
						onAsyncSuccess: orgTreeOnAsyncSuccess
					}
					
				};
				orgTree=$.fn.zTree.init($("#orgTree"), setting);
		};
		//判断是否为子结点,以改变图标	
		function orgTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
			if(treeNode){
		  	 	var children=treeNode.children;
			  	 if(children.length==0){
			  		treeNode.isParent=true;
			  		orgTree = $.fn.zTree.getZTreeObj("orgTree");
			  		orgTree.updateNode(treeNode);
			  	 }
			}
		};
		//选择分类
		function getSelectNode() {
			orgTree = $.fn.zTree.getZTreeObj("orgTree");
			var nodes = orgTree.getSelectedNodes();
			var node = nodes[0];
			if (node == null || node.orgId == 0)
				return '';
			return node.orgId;
		}
	
		function treeClick(event, treeId, treeNode) {
			//取得组织id
			var orgId = getSelectNode();
			var demId = $("#demensionId").val();
			var url = "${ctx}/cloud/config/enterprise/org/selector.ht?orgId=" + orgId + "&demId=" + demId;
			$("#orgFrame").attr("src", url);
			setOrgId(orgId,demId);
		}
		
		function setOrgId(orgId,demId){
			$("#orgId").val(orgId);
			$("#demId").val(demId);
		}
	
		
		function selectOrg(){
			var aryOrgIds=new Array();
			var aryOrgNames=new Array();
			$('#orgFrame').contents().find("input[name='orgId']:checked").each(function(){
				aryOrgNames.push($(this).siblings("input[name='orgName']").val());
				aryOrgIds.push($(this).val());
			});
			var orgIds=aryOrgIds.join(",");
			var orgNames=aryOrgNames.join(",");
			if(orgIds==""){
				$.ligerMessageBox.warn('提示信息',"请选择组织ID!");
				return "";
			}
			window.returnValue={orgId:orgIds,orgName:orgNames};
			window.close();
		}
		
	</script>
	<style type="text/css">
		html { overflow-x: hidden; }
		.ztree {
			overflow: auto;
		}
		
		.label {
			color: #6F8DC6;
			text-align: right;
			padding-right: 6px;
			padding-left: 0px;
			font-weight: bold;
		}
	</style>
</head>
<body>
	<div id="defLayout">
		<div  position="left" title="组织树" style="overflow: auto; float: left;width: 100%;">
			 <div style="width:100%;">
		        <select id="demensionId"  style="width:99.8% !important;">  
		              <option value="0" > ---------全部--------- </option>
		              <c:forEach var="dem" items="${demensionList}">  
		              	<option  value="${dem.demId}">${dem.demName}</option>  
		              </c:forEach>  
		        </select>
	         </div>

			<div class="tree-toolbar">
				<span class="toolBar">
					<div class="group">
						<a class="link reload" id="treeFresh" href="javascript:loadTree();">刷新</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link expand" id="treeExpandAll"
							href="javascript:treeExpand()">展开</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link collapse" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a>
					</div>
				</span>
			</div>
			<ul id="orgTree" class="ztree"></ul>
		</div>
		<div position="center">
			<div class="l-layout-header">组织列表</div>
			<div class="panel-search">
				<form action="selector.ht" id="orgSearchForm" method="POST" target="orgFrame">
					<div class="row">
						<span class="label">组织名:</span> 
						<input type="hidden" name="orgId" id="orgId" /> 
						<input type="hidden" name="demId" id="demId" /> 
						<input type="text" id="orgName" name="orgName" 
						class="inputText" size="40" value="${param['orgName']}"/> &nbsp; 
						<a href="#" onclick="$('#orgSearchForm').submit()" class='button'><span>查询</span></a>
						
					</div>
				</form>
			</div>

			<iframe id="orgFrame" name="orgFrame" height="80%" width="100%"
				frameborder="0" src="${ctx}/cloud/config/enterprise/org/selector.ht"></iframe>
		</div>
	</div>
	 <div position="bottom"  class="bottom" style='margin-top:10px;'>
		<a href='#' class='button' onclick="selectOrg()" ><span class="icon ok"></span><span >选择</span></a>
		<a href='#' class='button' style='margin-left:10px;' onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
	</div>
</body>
</html>