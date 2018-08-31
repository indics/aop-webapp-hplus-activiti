<%--
	time:2012-06-25 11:05:09
	desc:edit the 通用表单对话框
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>自定义表管理预览</title>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<f:link href="web.css" ></f:link>
	<link href="${ctx}/js/lg/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/dynamic.jsp"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/displaytag.js"></script>
	<script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js"></script>
	
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script> 
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.exedit-3.5.min.js"></script>
	
	<script type="text/javascript">
	</script>
</head>
<body>
	<div name="custom_name" class="ztree">
	</div>

<script type="text/javascript">
	
	$(function(){
		var custom_namejson={id:"ID_",pid:"PARENT_ID_",displayName:"BUSINESS_KEY_"};
		var custom_namedialogTree;
		var custom_namesetting = {
			data: {
				key : {name: custom_namejson.displayName},
				simpleData: {
					enable: true,
					idKey: custom_namejson.id,
					pIdKey: custom_namejson.pid,
				}
			},
			check: {
				chkboxType:  { "Y" : "", "N" : "p" }
			}
		};
		var custom_nameurl=__ctx+"/platform/system/sysTableManage/getTreeData.ht";
		var custom_nameparams={
			__manageid__:10000000730001
		};
		$.post(custom_nameurl,custom_nameparams,function(result){
			for(var i=0;i<result.length;i++){
				if(result[i].BUSINESS_KEY_==null){
					result[i].BUSINESS_KEY_="";
				}
			}
			console.dir(JSON.stringify(result));
			custom_namedialogTree=$.fn.zTree.init($("div:[name='custom_name']"), custom_namesetting,result);
			custom_namedialogTree.expandAll(true);
		});
	});
</script>
</body>
</html>
