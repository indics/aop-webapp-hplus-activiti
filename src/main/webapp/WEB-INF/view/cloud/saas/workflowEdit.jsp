<%--
	time:2013-08-19 17:21:54
	desc:edit the 企业流程定义
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 企业流程定义</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#serviceEntflowForm').form();
			$("a.save").click(function() {
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
		});
		
		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
					if(rtn){
						this.close();
					}else{
						window.location.href = "${ctx}/cloud/aftersale/serviceEntflow/list.ht";
					}
				});
			} else {
				$.ligerMessageBox.error("提示信息",obj.getMessage());
			}
		}
		
	//企业选择器
	var dd;
	function selectEnt(){
		//弹出供应商物品选择框
		var urlShow = '${ctx}/cloud/console/busiarea/selectAreaGroupTree.ht';
		dd = $.ligerDialog.open({ url:urlShow, height: 480,width: 850, title :'企业选择器', name:"frameDialog_"});
	}	
	
	//商圈列表回调函数
	function _callBackAreaGroupTrees(companys){
		dd.close();
		
		if(companys.length > 1){
			$.ligerMessageBox.alert('只能选一家供应商');
			return;
		}
		var names = '', ids = '' , telphones = '', contactmans = '';
		for(var i=0; i<companys.length; i++){
			var company = companys[i];
			names += ',' + company.name.trim();
			ids += ',' + company.id.trim();
			telphones += ',' + company.telphone.trim();
			contactmans += ',' + company.contactman.trim();
		}
		if(names != '')
			names = names.substring(1);
		if(ids != '')
			ids = ids.substring(1);
		if(telphones != '')
			telphones = telphones.substring(1);
		if(contactmans != '')
			contactmans = contactmans.substring(1);
			
		$("#entid").val(ids);
		$("#entname").val(names);
	}
	
		function selectEnt(){
			CommonDialog("org_info_listmore",
			function(data) {
				var row=data;
				var names='',ids='';
      		for(var i=0; i<row.length; i++){
      			ids += ',' + row[i].SYS_ORG_INFO_ID;
      			names += ',' + row[i].NAME;
      		}
      		ids = ids!=''?ids.substring(1):"";
      		names = names!=''?names.substring(1):"";
      		 
      		$("#entid").val(ids);
			$("#entname").val(names);
			
			});
		}	
		
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${serviceEntflow.id !=null}">
			        <span class="tbar-label">编辑企业流程定义</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加企业流程定义</span>
			    </c:otherwise>			   
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back" href="list.ht">返回</a></div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="serviceEntflowForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
			<tr>
					<th width="20%">程流名称: </th>
					<td><input type="text" id="flowname" name="flowname" value="${serviceEntflow.flowname}"  class="inputText" validate="{required:true,maxlength:50}"  /></td>
				</tr>
					<tr>
					<th width="20%"> 流程类型: </th>
					<td><input type="text" id="flowtype" name="flowtype" value="${serviceEntflow.flowtype}"  class="inputText" validate="{required:true,maxlength:80}"  /></td>
				</tr>
				<tr>
					<th width="20%">流程定义KEY: </th>
					<td><input type="text" id="flowkey" name="flowkey" value="${serviceEntflow.flowkey}"  class="inputText" validate="{required:true,maxlength:50}"  /></td>
				</tr>
				 
				<tr>
					<th width="20%">业企名称: </th>
					<td>
					<input type="hidden" id="entid" name="entid" value="${serviceEntflow.entid}"    />
					<input type="text" size="50" id="entname" name="entname" value="${serviceEntflow.entname}" readonly="readonly"  class="r" validate="{required:true}"  />
					<a href="#" onclick="selectEnt();">选择</a>
					</td>
				</tr>
				<tr>
					<th width="20%">备注: </th>
					<td>
					<textarea rows="3" cols="50" id="remake" name="remake" >${serviceEntflow.remake}</textarea>
				</tr>
			</table>
			<input type="hidden" name="id" value="${serviceEntflow.id}" />
		</form>
		
	</div>
</div>
</body>
</html>
