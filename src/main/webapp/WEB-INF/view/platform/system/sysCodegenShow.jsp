<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>自定义表代码生成</title>
<%@include file="/commons/include/get.jsp"%>
<link rel="stylesheet" href="${ctx }/js/tree/v30/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${ctx }/js/tree/v30/jquery.ztree.core-3.0.min.js"></script>
<script type="text/javascript" src="${ctx }/js/tree/v30/jquery.ztree.excheck-3.0.min.js"></script>
<script type="text/javascript" src="${ctx }/js/tree/v30/jquery.ztree.exedit-3.0.min.js"></script>
<script type="text/javascript">
	var tableTree;
	var height;
	$(function() {
		$("#layout").ligerLayout({
			leftWidth : 225,
			height : '100%',
			allowLeftResize : false
		});
		height = $('#layout').height();
		loadTree("");
		$("#treeReFresh").click(function() {
			loadTree("");
			$("#viewFrame").attr("src","${ctx}/platform/system/sysCodegen/detail.ht");
		});

		$("#treeExpand").click(function() {
			tableTree.expandAll(true);
		});
		$("#treeCollapse").click(function() {
			tableTree.expandAll(false);
		});
		$("#treeSearch").click(function(){
			var tableName=$("#search").val();
			loadTree(tableName);
		});
	});
	
	function loadTree(tableName) {
		var setting = {
			data : {
				key : {
					name : "tableDesc"
				},
				simpleData : {
					enable : true,
					idKey : "tableId",
					pIdKey : "parentId",
					rootPId : 1
				}
			},
			view : {
				selectedMulti : false
			},
			check:{
				enable:true
			},
			callback : {
				onCheck	: zTreeOnCheck
			}
		};

		$.post(
			"${ctx}/platform/system/sysCodegen/getTableData.ht?tableName="+tableName,
			function(result) {
				for ( var i = 0; i < result.length; i++) {
					var node = result[i];
					if (node.isRoot!= 1) {
						if (node.isMain== 1) {
							node.icon ="${ctx}/styles/default/images/icon/prodia_call_activity.png";
						} else {
							node.icon = "${ctx}/styles/default/images/icon/icon-remark15X15.gif";
						}
					}
				}
				tableTree = $.fn.zTree.init($("#tableTree"), setting,result);
				tableTree.expandAll(true);
				
			});
	}
	
	function zTreeOnCheck(event, treeId, treeNode){
		$("#viewFrame").attr("src","${ctx}/platform/system/sysCodegen/detail.ht");
	}
	
</script>
<style type="text/css">
	.ztree {
		overflow: auto;
	}
	html {height: 100%}
	body {padding: 0px;margin: 0;overflow: hidden;}
	#layout {width: 99.5%;margin: 0;padding: 0;}
</style>
</head>
<body>
	<div id="layout" style="bottom: 1; top: 1">
		<div position="left" title="自定义表管理" id="TreeManage"
			style="overflow: auto; height: 100%; width: 100% !important;">
			<div style="width: 100%;">
					<input type="text" name="tableName" id="search" style="width:75%;"><a class="link search" id="treeSearch">查询</a>
			</div>
			<div class="tree-toolbar" id="pToolbar">
				<div class="toolBar"
					style="text-overflow: ellipsis; white-space: nowrap">
					<div class="group">
						<a class="link reload" id="treeReFresh">刷新</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link expand" id="treeExpand">展开</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link collapse" id="treeCollapse">收起</a>
					</div>
				</div>
			</div>
			<ul id="tableTree" class="ztree" style="overflow:auto;" ></ul>
		</div>
		<div position="center" id="tableView" style="height: 100%;">
			<div class="l-layout-header" >自定义表代码</div>
			<iframe id="viewFrame" src="${ctx}/platform/system/sysCodegen/detail.ht" frameborder="0" width="100%"
				height="100%"></iframe>
		</div>
	</div>
</body>
</html>