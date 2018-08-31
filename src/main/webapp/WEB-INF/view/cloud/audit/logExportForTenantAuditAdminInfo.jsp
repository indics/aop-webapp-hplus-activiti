<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>企业审计管理员导出日志</title>
<%@include file="/commons/b2b/form.jsp"%>
<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/subform.js"></script>
<script type="text/javascript"
	src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/scroll/hScrollPane.js"></script>
<script type="text/javascript"
	src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
<script type="text/javascript">
	function export0Check(){
		var beginexeTime=$("#beginexeTime").val();
		var endexeTime=$("#endexeTime").val();
		if( !beginexeTime ){
	        alert("开始时间不能为空!");
	        return false; 
	    }else if( !endexeTime ){
	        alert("结束时间不能为空!");
	        return false; 
	    }
		if(endexeTime<beginexeTime){
			alert("结束时间不能早于开始时间!");
	        return false; 
		}
		$("#type").val(0);
		return true;
	}
	function export1Check(){
		var beginexeTime=$("#beginexeTime").val();
		var endexeTime=$("#endexeTime").val();
		if( !beginexeTime ){
	        alert("开始时间不能为空!");
	        return false; 
	    }else if( !endexeTime ){
	        alert("结束时间不能为空!");
	        return false; 
	    }
		if(endexeTime<beginexeTime){
			alert("结束时间不能早于开始时间!");
	        return false; 
		}
		var nowDate=new Date();
		var startDate= new Date(Date.parse(beginexeTime.replace(/-/g,   "/")));
		var endDate= new Date(Date.parse(endexeTime.replace(/-/g,   "/")));
		if((nowDate-endDate)<180*24*60*60*1000){
			alert("对不起，您只能删除180天前的日志！请重新选择结束日期！");
			return false;
		}
		$("#type").val(1);
		return true;
	}
</script>
</head>
<body>
<div class="panel">
	<div class="panel-body">
		<form id="sysAudit" action="exportAudit.ht">
			<div align="center">
				<span><b>开始时间：</b><input type="text" id="beginexeTime"  name="beginexeTime" class="inputText date" /></span>&nbsp;&nbsp;&nbsp;&nbsp;
				<span><b>结束时间：</b><input type="text" id="endexeTime"  name="endexeTime" class="inputText date" /></span>
				<input type="hidden" id="type"  name="type" />
				<input type="hidden" name="tenantId"  value="${tenantId}" />
				<input type="hidden" name="qysjgly"  value="企业审计管理员" />
				<input type="hidden" name="userName"  value="企业审计管理员" />
			</div>
			<br>
			<div align="center">
				<span><input id="export1" type="submit" value="导出并删除" onclick="return export1Check()"></span>
				<span><input id="export0" type="submit" value="导出日志" onclick="return export0Check()"></span>
			</div>
		</form>
	</div>
</div>
</body>
</html>


