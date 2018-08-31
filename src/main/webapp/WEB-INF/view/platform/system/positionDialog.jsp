<%@page pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<%@include file="/commons/include/form.jsp" %>
	<link href="${ctx}/styles/ligerUI/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerLayout.js"></script>
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript">
	
		var posTree = null;
		var expandByDepth = 0;
		//树节点是否可点击
		var treeNodelickAble=true;
		$(function() {
			$("#defLayout").ligerLayout({
				leftWidth : 220,
				height : '100%'
			});
			loadTree();
		});
	
		//展开收起
		function treeExpandAll(type) {
			posTree = $.fn.zTree.getZTreeObj("posTree");
			posTree.expandAll(type);
		};
		//异步加载展开
		function treeExpand() {
			posTree = $.fn.zTree.getZTreeObj("posTree");
			var treeNodes = posTree.transformToArray(posTree.getNodes());
			for(var i=1;i<treeNodes.length;i++){
				if(treeNodes[i].children){
					posTree.expandNode(treeNodes[i], true, false, false);
				}
			}
		};
		
		var posTree;
		function loadTree(){
			var setting = {
				data: {
					key : {
						
						name: "posName",
						title: "posName"
					},
				
					simpleData: {
						enable: true,
						idKey: "posId",
						pIdKey: "parentId",
						rootPId: 0
					}
				},
				async: {
					enable: true,
					url:"${ctx}/platform/system/position/getChildTreeData.ht",
					autoParam:["posId","parentId"],
					dataFilter: filter
				},
				callback:{
					onClick: treeClick,
					onAsyncSuccess: zTreeOnAsyncSuccess
				}
				
			};
			posTree=$.fn.zTree.init($("#posTree"), setting);
			treeNodelickAble=true;
			
			
		};
		
		//判断是否为子结点,以改变图标	
		function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
			if(treeNode){
		  	 var children=treeNode.children;
			  	 if(children.length==0){
			  		treeNode.isParent=true;
			  		posTree = $.fn.zTree.getZTreeObj("posTree");
			  		posTree.updateNode(treeNode);
			  	 }
			}
		};
		
		//过滤节点,默认为父节点,以改变图标	
		function filter(treeId, parentNode, childNodes) {
				if (!childNodes) return null;
				for (var i=0, l=childNodes.length; i<l; i++) {
					if(!childNodes[i].isParent){
						childNodes[i].isParent = true;
					}
				}
				return childNodes;
		};
		//选择分类
		function getSelectNode() {
			posTree = $.fn.zTree.getZTreeObj("posTree");
			var nodes = posTree.getSelectedNodes();
			var node = nodes[0];
			if (node == null || node.posId == 0)
				return '';
			return node.posId;
		}
	
		function treeClick(event, treeId, treeNode) {
			var pid = getSelectNode();
			var url = "${ctx}/platform/system/position/selector.ht?" + "pid=" + pid;
			$("#posFrame").attr("src", url);
	
			setPid(pid);
		}
	
		function setPid(pid) {
			document.getElementById('pid').value = pid;
		}
		
		function  selectPosition(){
			var aryIds=new Array();
			var aryNames=new Array();
			$('#posFrame').contents().find("input[name='posId']:checked").each(function(){
				aryNames.push($(this).siblings("input[name='posName']").val());
				aryIds.push($(this).val());
			});
			var posIds=aryIds.join(",");
			var posNames=aryNames.join(",");
			window.returnValue={posId:posIds,posName:posNames};
			window.close();
			
		}
	</script>
</head>
<body>
	<div id="defLayout">
		<div position="left" title="岗位树" style="overflow:auto;" >
			<div class="tree-toolbar">
				<span class="toolBar">
					<div class="group">
						<a class="link reload" id="treeFresh" href="javascript:loadTree();">刷新</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link expand" id="treeExpandAll" href="javascript:treeExpand()">展开</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link collapse]" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a>
					</div>
				</span>
			</div>
			<ul id="posTree" class="ztree"></ul>
		</div>
		<div position="center">
			<div class="l-layout-header">岗位列表</div>
			<div class="panel-search" style="border:none;">
				<form id="searchForm" action="selector.ht" method="POST" target="posFrame">
					<div class="row">
						<span class="label">岗位名称:</span> 
						<input type="hidden" name="pid" id="pid" /> 
						<input type="text" id="posName" name="posName" class="inputText" size="40" value="${param['posName']}"/> &nbsp; 
						<a href='#' class='button'  onclick="$('#searchForm').submit();"><span>查询</span></a>
					</div>
				</form>
			</div>

			<iframe id="posFrame" name="posFrame" height="90%" width="100%" frameborder="0" src="${ctx}/platform/system/position/selector.ht"></iframe>
		</div>
		<div position="bottom"  class="bottom">
			<a href='#' class='button'  onclick="selectPosition()" ><span class="icon ok"></span><span>选择</span></a>
			<a href='#' class='button' style='margin-left:10px;'  onclick="window.close()"><span class="icon cancel"></span><span>取消</span></a>
		</div>
	</div>
</body>
</html>