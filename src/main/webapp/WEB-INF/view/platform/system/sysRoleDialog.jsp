<%@page pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html"%>
<html>
	<head>
		<title>选择角色</title>
		<%@include file="/commons/include/form.jsp" %>
		<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	    <script type="text/javascript"	src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
		<script type="text/javascript">
			var systemTree=null;
			
			$(function(){
				$("#defLayout").ligerLayout({ leftWidth: 210,height: '100%',minLeftWidth:220});
				loadTree();
			});
			
			//展开收起
			function treeExpandAll(type){
				systemTree = $.fn.zTree.getZTreeObj("systemTree");
				systemTree.expandAll(type);
			};
			
			function loadTree(){
				var setting = {
	    			data: {
		    				key : 
		    				{
		    					name: "sysName",
		    					title: "sysName"
		    				},
		    				simpleData: {
		    					enable: true,
		    					idKey: "systemId",
		    					pIdKey: "parentId",
		    					rootPId: 0
		    				}
	    				},
	    			callback:{onClick: treeClick}
	    		};
				var url="${ctx}/platform/system/subSystem/tree.ht";
				$.post(url,function(result){
					systemTree=$.fn.zTree.init($("#systemTree"), setting,eval(result));
		            systemTree.expandAll(true);
				});
		    		
			}
			//选择分类
        	function getSelectNode()
        	{
        		systemTree = $.fn.zTree.getZTreeObj("systemTree");
        		var nodes  = systemTree.getSelectedNodes();
        		var node   = nodes[0];
        		if(node.systemId==0) return '';
        		return node.systemId;
        	}
			
			function treeClick(event, treeId, treeNode){
        		var url="${ctx}/platform/system/sysRole/selector.ht?Q_systemId_L="+getSelectNode();
        		$("#roleFrame").attr("src",url);
        	}
			
			function selectRole(){
				var aryRoleIds=new Array();
				var aryRoleNames=new Array();
				
				$('#roleFrame').contents().find("input[name='roleId']:checked").each(function(){
					aryRoleNames.push($(this).siblings("input[name='roleName']").val());
					aryRoleIds.push($(this).val());
				});
				
			
				var roleIds=aryRoleIds.join(",");
				var roleNames=aryRoleNames.join(",");
				if(roleIds==""){
					$.ligerMessageBox.warn('提示信息',"请选角色!");
					return "";
				}
				window.returnValue={roleId:roleIds,roleName:roleNames};
				window.close();
			}
			
		</script>
		
	</head>
	<body style="overflow: hidden;">
			<div id="defLayout" >
	            <div position="left" title="子系统" style="float:left;width:210px">
	            	<div class="tree-toolbar">
						<span class="toolBar">
							<div class="group"><a class="link reload" id="treeFresh" href="javascript:loadTree();">刷新</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link expand" id="treeExpandAll" href="javascript:treeExpandAll(true)">展开</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link collapse" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a></div>
						</span>
					</div>
					<ul id="systemTree" class="ztree"></ul>
	            </div>
	            <div position="center">
	          		<iframe id="roleFrame" name="roleFrame" height="100%" width="100%" frameborder="0"  src="${ctx}/platform/system/sysRole/selector.ht"></iframe>
	            </div>  
	            <div position="bottom"  class="bottom" style='margin-top:10px;'>
				    <a href='#' class='button'  onclick="selectRole()" ><span class="icon ok"></span><span >选择</span></a>
				   	<a href='#' class='button' style='margin-left:10px;' onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
				</div>
       	  </div>
       	  
	</body>
</html>