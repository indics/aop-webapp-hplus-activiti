<%--
	time:2012-11-27 10:37:13
	desc:edit the 通用表单查询
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 通用表单查询</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#bpmFormQueryForm').form();
			$("a.save").click(function() {
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
			$("#btnSearch").click(searchObjectList);
		});
		
		function searchObjectList(){
			var selList=$("#objname");
			var dsName=$("#dataSource").val();
			var objectname=$("#objectname").val();
			var istable=$("#istable").val();
			var url=__ctx +"/platform/form/bpmFormDialog/getByDsObjectName.ht";
		
			$.ligerDialog.waitting('正在查询，请等待...');
			$.post(url, { dsName:dsName, objectName: objectname,istable:istable },function(data) {
				$.ligerDialog.closeWaitting();
				selList.empty();
				var success=data.success;
				if(success=='false'){
					$.ligerDialog.error("出错了!");
					return;
				}
				//表的处理
				if(istable=="1"){
					var tables=data.tables;
					for(key in tables ){
						selList.append("<option title='"+tables[key]+"' value='"+ key+"'>"+ key +"("+tables[key] +")" +"</option>" );
					}
				}
				//视图的处理
				else{
					var aryView=data.views;
					for(var i=0;i<aryView.length;i++){
						var v=aryView[i];
						selList.append("<option value='"+ v+"'>"+v+"</option>" );
					}
				}
		    });
		}
		
		function selsize(){
			var isneedPage=$("input:radio[name='needpage']:checked").val();
			if(isneedPage>0){
				$("#spanPageSize").show();
			}
			else{
				$("#spanPageSize").hide();
			}
		}
		
		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
					if(rtn){
						this.close();
						$("#bpmFormQueryForm").resetForm();
					}else{
						window.location.href = "${ctx}/platform/bpm/bpmFormQuery/list.ht";
					}
				});
			} else {
				$.ligerDialog.err("出错信息","编辑通用表单失败",obj.getMessage());
			}
		}
		
		function dialog(){
			$("#selInfo").text("");
			var id=$("#id").val();
			var istable=$("#istable").val();
			var objname=$("#objname").val();
			var dataSource=$("#dataSource").val();
			
			if(id==0){
				if(objname==null){
					$("#selInfo").text("请先选择数据库表");
					return ;
				}
			}
			showSettingDialog(dataSource,objname,istable,id);
		}
		
		function showSettingDialog(dsName,objectname,istable,id){
			var settingobj=$("#settingobj").val(),
				fields={};
			
			if(settingobj==objectname){
				var conditionField=$("#conditionfield").val(),
					resultField=$("#resultfield").val();
				
				if(conditionField)
					fields.conditionField=conditionField;
				if(resultField)
					fields.resultField=resultField;
			}
			
			var url="setting.ht?dsName=" +dsName +"&objectName=" + objectname + "&istable=" + istable +"&id=" + id;
			var winArgs="dialogWidth=800px;dialogHeight=540px;help=0;status=0;scroll=1;center=1;resizable=1;";
			url=url.getNewUrl();
			var rtn=window.showModalDialog(url,fields,winArgs);
			if(rtn==undefined) return;
           	if(rtn.length>0){
           		 $("#settingobj").val(objectname);
           		 $("#conditionfield").val(rtn[1]);
           		 $("#resultfield").val(rtn[2]); 
          	}
           
		}
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${bpmFormQuery.id !=null}">
			        <span class="tbar-label">编辑通用表单查询</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加通用表单查询</span>
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
		<form id="bpmFormQueryForm" method="post" action="save.ht">
		
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">查询名称: </th>
							<td><input type="text" id="name" name="name" value="${bpmFormQuery.name}"  class="inputText"/></td>
							<th width="20%">查询别名: </th>
							<td><input type="text" id="alias" name="alias" value="${bpmFormQuery.alias}"  class="inputText"/><span id="aliasInfo" style="color:red"></span></td>
						</tr>
						<c:if test="${bpmFormQuery.id==0}">
							<tr>
								<th width="20%">数据源: </th>
								<td>
									<select id="dataSource" name="dsalias">
										<c:forEach items="${dsList}" var="ds">
											<option value="${ds.alias}">${ ds.name} </option>
										</c:forEach>
									</select>
								</td>
								<th width="20%">查询表(视图): </th>
								<td>
									<select name="isTable" id="istable">
										<option value="1">表</option>
										<option value="0">视图</option>
									</select>
									<input type="text" name="objectname" id="objectname">
									<a href="javascript:;" id="btnSearch" class="link search">查询</a>
									
								</td>
							</tr>
						</c:if>
						<tr>
							<th width="20%">查询字段设置: </th>
							<td colspan="3" valign="top">
								<a href="javascript:;" id="btnSetting" class="link setting" onclick="dialog()">设置列</a>
								<c:choose>
									<c:when test="${bpmFormQuery.id==0}">
										<br>
										<select id="objname" name="objName" size="10" style="width:350px;">
										</select>
										<span id="selInfo" name="selInfo" style="color:red"></span>
									</c:when>
									<c:otherwise >
										<input type="hidden"  id="objname" name="objName" value="${bpmFormQuery.objName}" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
			
			<input type="hidden" id="id" name="id" value="${bpmFormQuery.id}" />
			<input type="hidden" id="settingobj" value="${bpmFormQuery.objName}" />
			<textarea  id="conditionfield"  name="conditionfield" style="display: none;">
				${bpmFormQuery.conditionfield}
			</textarea>
			<textarea  id="resultfield"  name="resultfield" style="display: none;">
				${bpmFormQuery.resultfield}
			</textarea>				
		</form>
		
	</div>
</div>
</body>
</html>
