<%--
	time:2011-11-09 11:20:13
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>组织架构明细</title>
	<%@include file="/commons/include/get.jsp" %>
	<%-- <script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script> --%>
	<style type="text/css"> 
		html{scroll:no;height:100%}
	    body {scroll:no;height:90%; padding:0px; margin:0;overflow:auto !important}
    </style>
    <script>
    	function delOrg(){
    		$.ligerMessageBox.confirm('提示','确定要删除吗？此操作将删除所有子组织',function(rtn){
    			if(rtn){
    				$.ajax({ 
   				       type: "POST", 
   				       url: "orgdel.ht", 
   				       data: "orgId=${sysOrg.orgId}", 
   				       success: function(){ 
   				    	   $.ligerMessageBox.alert('删除成功');
		    				window.location.reload();
   				       } 
   				    });     				
    			}
    		});
    	}
    	
    	function sortOrg(){
    		var urlShow = 'sortList.ht?orgId=${sysOrg.orgId}&demId=1&rand=' + Math.random();
    		$.ligerDialog.open({ url:urlShow, height: 330,width: 500, title :'组织浏览', name:"frameDialog_",
    			buttons: [ { text: '确定', onclick: function (item, dialog) { dialog.close(); } } ] 
    		});
    	}
    	
    	//批量导入
    	function batchImport(){
    		OpenDialog({
    			url : 'toImport.ht',
    			dialogWidth:500,
    			dialogHeight:200
    		});
    	}
    </script>
</head>
<body>
 <div class="panel" id="toppanel">
 		<c:choose>
		  	<c:when test="${action=='global' }">
		  		<f:tab curTab="组织简介" tabName="enterpriseOrg"/>
		  	</c:when>
		  	<c:otherwise>
		  		<f:tab curTab="组织简介" tabName="enterpriseOrgGrade"/>
		  	</c:otherwise>
		  </c:choose>
		  
			
		<c:if test="${flag== 1}">
		    <div class="panel-toolbar" id="pToolbar">
				<div class="toolBar">
						<div class="group"><a class="link back"  href="listById.ht?orgId=${sysOrg.orgSupId}&path=${path}" >返回</a></div>	
				</div>	
		    </div>
	    </c:if>
		<div class="panel-body" id="pbody">	
			<c:choose>
				<c:when test="${empty sysOrg}">
					<div style="text-align: center;margin-top: 10%;">尚未指定具体组织!</div>
				</c:when>
				<c:otherwise>
						<div class="panel-toolbar">
							<div class="toolBar">
								<div class="group"><a class="link add" href="edit.ht?orgId=${sysOrg.orgId}&demId=1&action=add">添加下级组织</a></div>
								<div class="l-bar-separator"></div>
								<div class="group"><a class="link save" href="edit.ht?orgId=${sysOrg.orgId}&demId=1&flag=upd">编辑</a></div>
								<div class="l-bar-separator"></div>
								<div class="group"><a class="link delete"  href="javascript:delOrg();">删除</a></div>
								<div class="l-bar-separator"></div>
								<div class="group"><a class="link back"  href="javascript:sortOrg();">排序</a></div>
								<!-- <div class="l-bar-separator"></div>
								<div class="group"><a class="link edit" href="#" onclick="batchImport();">批量导入</a></div> -->
							</div>
						</div>
						<table id="tableid" class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="20%">所属维度:</th>
								<td width="80%" colspan="3">${sysOrg.demName}</td>
							</tr>
							<tr>
								<th width="20%">组织名称:</th>
								<td width="30%">${sysOrg.orgName}</td>
								<th width="20%">建立人:</th>
								<td width="30%">${sysOrg.createName}</td>
							</tr>
							<tr>
								<th>上级组织:</th>
								<td>${sysOrg.orgSupName}</td>
								<th>修改人:</th>
								<td>${sysOrg.updateName}</td>
							</tr>
							
							<tr>
								<th>组织类型:</th>
								<td>							
								 			<c:forEach items="${sysOrgTypelist}" var="org" >
								 					<c:if test="${sysOrg.orgType eq org.id}">${org.name}</c:if>													
											</c:forEach> 				
								</td>
								<th>建立时间:</th>
								<td>${f:shortDate(sysOrg.createtime)}</td>
							</tr>
							<tr>
								<th>组织负责人:</th>
								<td>${userNameCharge}</td>
								<th>修改时间:</th>
								<td>${f:shortDate(sysOrg.updatetime)}</td>
							</tr>
							<tr>
							    <th>组织描述:</th>
							    <td colspan="3">${sysOrg.orgDesc}</td>
							 </tr>
					    </table>
				</c:otherwise>
			</c:choose>	
	    </div>   
 </div>
</body>
</html>
