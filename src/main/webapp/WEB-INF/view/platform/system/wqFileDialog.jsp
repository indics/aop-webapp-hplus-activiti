<%@page import="com.cosim.platform.model.system.GlobalType"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%
	String basePath = request.getContextPath();
	String isSingle = request.getParameter("isSingle");
	request.setAttribute("isSingle", isSingle);
%>

<html>
<head>
<title>选择附件</title>
<%@include file="/commons/include/form.jsp" %>
<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerMenu.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerLayout.js"></script>
<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/GlobalType.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/FileMenu.js"></script>

<script type="text/javascript">
	var isSingle=${isSingle};
	
	var catKey="<%=GlobalType.CAT_FILE%>";
	
	var url="${ctx}/platform/system/globalType/getPersonType.ht";
	
	var fileMenu=new FileMenu();
	
	var curMenu;
	
	var conf={url:url,onClick:treeClick,onRightClick:zTreeOnRightClick,expandByDepth:1};
	
	var globalType=new GlobalType(catKey,"glTypeTree",conf);
	
	$(function() {
		$("#defLayout").ligerLayout({
			leftWidth : 196,
			height : '100%',
			allowLeftResize :false,
			bottomHeight:40
		});
		globalType.loadGlobalTree();
	});

	//展开收起
	function treeExpandAll(type) {
		globalType.treeExpandAll(type);
	};
	
	function treeClick(treeNode) {
		var typeId=treeNode.typeId;
		var url = "${ctx}/platform/system/sysFile/selector.ht?typeId=" + typeId +"&isSingle=${isSingle}";
		$("#fileFrame").attr("src", url);
	}
	
	/**
	 * 树右击事件
	 */
	function zTreeOnRightClick(event, treeId, treeNode) {
		
		if (treeNode) {
			globalType.currentNode=treeNode;
			globalType.glTypeTree.selectNode(treeNode);
			curMenu=fileMenu.getMenu(treeNode, handler);
			curMenu.show({ top: event.pageY, left: event.pageX });
		}
	};
	
	 function hiddenMenu(){
		if(curMenu){
			curMenu.hide();
		}
	 }
     
     function handler(item){
     	hiddenMenu();
     	var txt=item.text;
     	switch(txt){
     		case "添加分类":
     			globalType.openGlobalTypeDlg(true);
     			break;
     		case "编辑分类":
     			globalType.openGlobalTypeDlg(false);
     			break;
     		case "删除分类":
     			globalType.delNode();
     			break;
     		case "添加我的分类":
     			globalType.openGlobalTypeDlg(true,true);
     			break;
     	}
     }

	/**
	 * 添加选中的数据
	 */
	function add(ch){
		//所选
		var fileId = $(ch).val();
		var fileName = $(ch).siblings("input[name='fileName']").val();
		var filePath = $(ch).siblings("input[name='filePath']").val();
		var ext = $(ch).siblings("input[name='ext']").val();
		var canAdd = true;
		$("#sysFileList").find(":input[name='fileId']").each( function(){
			if(fileId == $(this).val()){
				canAdd = false;
			}
		});
		if(!canAdd) return;
		var tr=getRow(fileId,filePath,fileName,ext);
		$("#sysFileList").append(tr);
	};
	
	function getRow(fileId,filePath,fileName,ext){
		var tr = '<tr>';
		tr += '<td>';
		tr += '	<input type="hidden" class="pk" name="fileId" value="' + fileId + '"> ';
		tr += '	<input type="hidden" class="pk" name="filePath" value="' + filePath + '"> ';
		tr += '	<input type="hidden" class="pk" name="ext" value="' + ext + '"> ';
		tr += '	<input type="text" style="border:none;" size="12" readonly="readonly" class="pk" name="fileName" value="' + fileName + '"> ';
		tr += '</td>';
		tr += '<td><a onclick="javascript:delRow(this);" class="link del">删除</a> </td>';
		tr += '</tr>';
		return tr;
	}

	function delRow(obj){
		var tr=$(obj).parents("tr");
		$(tr).remove();
	};
	/**
	 * 清空所有的
	 */
	function dellAll(){
		$("#sysFileList").empty();
	};
	/**
	 * 选中所有
	 */
	function selectMulti(obj){
		if($(obj).attr("checked") == "checked")
		add(obj);
	};

	function selectAll(obj){
		var state = $(obj).attr("checked");
		if(state == undefined) {
			checkAll(false);		
		} else {		
			checkAll(true);
		}
	};

	function checkAll(checked){
		$("#fileFrame").contents().find("input[type='checkbox'][class='pk']").each(function(){
			$(this).attr("checked", checked);
			if(checked){
				add(this);
			}
		});
	};


	
	 /**
	 * 文件上传，窗口
	 */
	function fileUpload(){
		var url="${ctx}/platform/system/sysFile/getFileUpload.ht";
		var currentNode=globalType.currentNode;
		if(currentNode && currentNode.isRoot==undefined){
			url+="?typeId="+currentNode.typeId;
		}
	 	var winArgs="dialogWidth:500px;dialogHeight:300px";
	 	url=url.getNewUrl();
	 	var rtn=window.showModalDialog(url,"",winArgs);
	 	var myiframe = document.getElementById("fileFrame");
	 	myiframe.src=myiframe.src.getNewUrl();
	}
	
	function selectFile(){
		var chIds;
		if (isSingle==1) {
			chIds = $('#fileFrame').contents().find(":input[name='fileId'][checked]");
		} else {
			chIds = $("#sysFileList").find(":input[name='fileId']");
		}
		var aryFileId = new Array();
		var aryFileName = new Array();
		var aryPath = new Array();
		var aryExt = new Array();
		$.each(chIds, function(i, ch) {
			aryFileId.push($(ch).val());
			aryFileName.push($(ch).siblings("input[name='fileName']").val());
			aryPath.push($(ch).siblings("input[name='filePath']").val());
			aryExt.push($(ch).siblings("input[name='ext']").val());
		});
		var obj={fileIds:aryFileId.join(','),fileNames:aryFileName.join(','),filePaths:aryPath.join(','),extPath:aryExt.join(",")};
		window.returnValue=obj;
		window.close();
	}

</script>
<style type="text/css">
body{overflow: hidden;}
</style>
</head>
<body>
	<div id="defLayout">
		 <div position="left" title="附件分类树" style="overflow: auto;float:left;width:210px">
            	<div class="tree-toolbar">
					<span class="toolBar">
						<div class="group"><a class="link reload" id="treeFresh" href="javascript:globalType.loadGlobalTree();">刷新</a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a class="link expand" id="treeExpandAll" href="javascript:treeExpandAll(true)">展开</a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a class="link collapse" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a></div>
					</span>
				</div>
				<ul id="glTypeTree" class="ztree"></ul>
        </div>
		
		<div position="center"><div class="l-layout-header">附件分类列表</div>			
			<iframe id="fileFrame" name="fileFrame" height="90%" width="100%" frameborder="0" src="${ctx}/platform/system/sysFile/selector.ht?isSingle=${isSingle}"></iframe>
		</div>
		<c:if test="${isSingle == 0}">
			<div position="right" title="<a onclick='javascript:dellAll();' class='link del'>清空 </a>" style="overflow-y: auto;">
				<table width="145" id="sysFileList" class="table-grid table-list" id="0" cellpadding="1" cellspacing="1"></table>
			</div>
		</c:if>
		<div position="bottom"  class="bottom" >
				<a href='#' class='button'  onclick="fileUpload();" ><span class="icon upload"></span><span >上  传</span></a>
				<a href='#' class='button' style='margin-left:10px;'  onclick="selectFile()" ><span class="icon ok"></span><span >选择</span></a>
				<a href='#' class='button' style='margin-left:10px;'  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div>
</body>
</html>