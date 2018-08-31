<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>节点设置管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/FormDialog.js"></script>

<script type="text/javascript">
	//流程定义ID
	var actDefId="${bpmDefinition.actDefId}";
	
	
	function save(){
		$('#dataForm')[0].submit();
	}
	
	//选择表单
	function selectForm(obj) {
		FormDialog({
			callback : function(ids, names, tableId) {
				var tdObj=$(obj).parent();
				$("input.formKey",tdObj).val(ids);
				$("input.formDefName",tdObj).val(names);
				$("input.tableId",tdObj).val(tableId);
				//$("span[name='spanForm']",tdObj).html(names);
				//给表单添加 超链接，使之能看到表单明细
				var namesUrl="<a target='_blank' href="+__ctx+"/platform/form/bpmFormHandler/edit.ht?formDefId="+ids+" >"+names+"</a>";
				$("span[name='spanForm']",tdObj).html(namesUrl);
				// 是否显示子表授权功能
				$.ajax({
					type : "POST",
					url : __ctx + "/platform/form/bpmFormDef/isSubTable.ht",
					data : {formKey:ids},
					dataType : "json",
					success : function(res) {
						var result= eval('(' + res + ')');
						if(result.success && obj.id == 'subNodeSel'){
							$("a.grant").show();
						}else{
							$("a.grant").hide();
							//$.ligerMessageBox.warn("提示信息",result.msg);
						}
					},
					error : function(res) {
						
					}
				});
			}
		})
	}
	//全局表单授权
	function authorizeDialog(aurl){
		var url=aurl;
		var winArgs="dialogWidth=800px;dialogHeight=600px;help=0;status=no;center=yes;resizable=no;";
		url=url.getNewUrl();
		window.showModalDialog(url,"",winArgs);
	}
	
	//清除表单
	function clearForm(obj){
		var btn=$(obj);
		var tdObj=btn.parent();
		$("input.formKey",tdObj).val('');
		$("input.formDefName",tdObj).val('');
		$("span[name='spanForm']",tdObj).text('');
		
	}
	
	//表单授权
	function authorize(obj,nodeId){
		var btn=$(obj);
		var tdObj=btn.parent();
		var objDefId=$("input.formKey",tdObj);
		if(objDefId.val()==""||objDefId.val()==0){
			$.ligerMessageBox.warn("提示信息","请先选择表单!");
			return;
		}
		var formKey=objDefId.val();
	
		var url= __ctx + '/platform/form/bpmFormDef/rightsDialog.ht?actDefId=' +actDefId+'&nodeId=' + nodeId +'&formKey=' + formKey;
	   if(nodeId.length>0){
			var oldformKey=$("input.oldFormKey",tdObj).val();
			if(oldformKey!=formKey)
				url+='&isAlert=true'
		}
		authorizeDialog(url,nodeId,formKey);
	}
	
	// 弹出子表授权脚本填写页面
	function subDataGrant(obj,nodeId){
		var btn=$(obj);
		var tdObj=btn.parent();
		var objDefId=$("input.formKey",tdObj);
		var formKey=objDefId.val();
		var tableId = $("input.tableId").val();
		var url= __ctx + '/platform/form/bpmFormDef/subRightsDialog.ht?actDefId=' 
			+actDefId+'&nodeId=' + nodeId +'&formKey=' + formKey+'&tableId='+tableId;
		authorizeDialog(url,nodeId,formKey);
	}

	
	
	$(function(){
		
		$('#ckJumpType').on('click',function(){
			$('.jumpType').attr('checked',this.checked);
		});
		
		$('#ckHidenOption').on('click',function(){
			var checked=this.checked;
			$('.hideOption').attr('checked',checked);
		});
		
		$('#ckHidenPath').on('click',function(){
			var checked=this.checked;
			$('.hidePath').attr('checked',checked);
		});
		
		if($('#existSubTable').val()==0){
			$('a.grant').hide();
		}
		
		//处理表单类型
		handFormType();
		//验证handler
		validHandler();
		
		showHelper();
	});
	
	function handFormType(){
		$("select.selectForm").change(function(){
			var obj=$(this);
			var value=obj.val();
			var trObj=obj.closest("tr");
			if(value==-1){
				$("table.table-detail",trObj).hide();
			}
			else{
				$("table.table-detail",trObj).show();
				if(value==0){
					$("div.form",trObj).show();
					$("div.url",trObj).hide();
				}
				else{
					$("div.form",trObj).hide();
					$("div.url",trObj).show();
				}
			}
		});
	}
	
	function validHandler(){
		$("input.handler").blur(function(){
			var obj=$(this);
			var val=obj.val();
			if(val.trim()==""){
				return;
			}
			///如果是以“http://”开头说明是外部系统的处理器，此时不再去后台校验
			var index = val.indexOf("http://");
			if (index == 0){
				return ;
			}
			
			var params={handler:val};
			$.post("validHandler.ht",params,function(data){
				var json=eval("(" +data +")");
				if(json.result!='0'){
					$.ligerMessageBox.warn("提示信息",json.msg,function(){
						obj.focus();
					});
				}
			});
		});
	}
	
	function showHelper(){
		var cookie=$.getCookie("help");
		if(cookie=="hidden") {
			$("ul.help").hide();
			return ;
		}
		$("ul.help").show();
	}
	
	function toggleHelp(){
		var display=$("ul.help").css("display");
		if(display=="none"){
			$("ul.help").show();
			$.setCookie("help","show");
		}
		else{
			$("ul.help").hide();
			$.setCookie("help","hidden");
		}
	}
	
</script>
<style type="text/css">
	ul.help li { list-style:inside circle;list-style-type:decimal ;padding-left: 10px;font-weight: normal; } 
</style>

</head>
<body>
    
     <jsp:include page="incDefinitionHead.jsp">
   		<jsp:param value="节点表单设置" name="title"/>
	</jsp:include>
    <f:tab curTab="表单管理" tabName="flow"/>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流程表单设置</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" onclick="save()">保存</a></div>
					<div class="l-bar-separator"></div>
					<img id="imgHelp" onclick="toggleHelp()" style="cursor: pointer;" alt="" src="${ctx}/styles/default/images/icon/help.gif" >
				</div>	
			</div>
		</div>
		<div class="panel-body">
			
				<form action="save.ht" method="post" id="dataForm">
				    <input type="hidden" name="defId" value="${bpmDefinition.defId}"/>
					<table cellpadding="1" cellspacing="1" class="table-detail" style="margin-bottom: 4px;">
						<tr>
							<td colspan="4">
								
								<ul class="help" style="display:none;">
									<li>表单
										<ul>
											<li>在线表单,为系统自定义表单。</li>
											<li>url表单,是外部表单。地址写法规则为：如果表单页面平台在同一个应用中，路径从根开始写，<span class="red">不需要上下文路径</span>，例如 ：/form/addUser.ht。
												如果需要使用的表单不再同一个应用下，则需要写完整路径如:http://***/crm/addUser.ht 。
											</li>
										</ul>
									</li>
									<li>处理器
										<ul>
											<li>处理器是需要开发人员定制的,一般情况下<span class="red">URL表单的处理器需要填写</span>。处理器的写法是 service类名首字母小写 +"." + 方法名称。
										需要注意的是这个service是需要通过spring容器管理的。另外方法的参数必须是ProcessCmd类。
										例如：userService.add,这个表示是UserService类中有一个，add(ProcessCmd cmd)的方法。</li>
											<li>
											前置和后置处理器区别在于执行时机不同，前置处理器是在启动流程或完成下一步这个动作之前执行的。
											后置处理器在启动流程或完成下一步之后执行的。
											</li>
										</ul>
										
									</li>
								</ul>
							</td>
						</tr>
						<tr >
							<th  width="15%">全局表单:</th>
							<td width="10%">
								<select name="globalFormType" class="selectForm" >
									<c:choose >
										<c:when test="${globalForm==null }">
											<option value="-1" selected="selected" >请选择..</option>
											<option value="0" >在线表单</option>
											<option value="1" >URL表单</option>
										</c:when>
										<c:otherwise>
											<option value="-1" <c:if test="${globalForm.formType==-1 }">selected="selected"</c:if>>请选择..</option>
											<option value="0"  <c:if test="${globalForm.formType==0 }">selected="selected"</c:if> >在线表单</option>
											<option value="1"  <c:if test="${globalForm.formType==1 }">selected="selected"</c:if>>URL表单</option>
										</c:otherwise>
									</c:choose>
								</select>
							</td>
							<td style="padding: 5px 2px 5px 2px;">
								<table class="table-detail" <c:if test="${globalForm==null}">style="display: none" </c:if>>
									<tr>
										<td nowrap="nowrap" class="head">表单:</td>
										<td>
											<div name="globalForm" class="form" <c:if test="${globalForm!=null && globalForm.formType!=0 }">style="display: none" </c:if>>
												<input id="defaultFormKey" class="formKey"  type="hidden" name="defaultFormKey" value="${globalForm.formKey }" >
												<input id="defaultFormName" class="formDefName"  type="hidden" name="defaultFormName" value="${globalForm.formDefName }">
								<span name="spanForm">				<a target="_blank" href="${ctx}/platform/form/bpmFormHandler/edit.ht?formDefId=${globalForm.formKey}" >${globalForm.formDefName }</a></span>
												<a href="javascript:;" class="link get" onclick="selectForm(this)">选择</a>
												<a href="javascript:;" class="link clean" onclick="clearForm(this)">重选</a>
												<a href="javascript:;" class="link auth" onclick="authorize(this,'')">表单授权</a>
												<a href="#" class="tipinfo"><span>设置全局表单授权，多个流程定义绑定该表单时，则使用该表单的授权信息一致；倘若其他流程定义绑定该表单且需使用不同表单权限控制则不需设置全局表单授权。</span></a>
											</div>
											<div name="globalFormUrl" <c:if test="${globalForm!=null && globalForm.formType!=1 }">style="display: none" </c:if> class="url" >
												表单URL:<input type="text" name="formUrlGlobal" value="${globalForm.formUrl }" class="inputText" size="85"/>
												<br/>
												明细URL:<input type="text" name="detailUrlGlobal" value="${globalForm.detailUrl }" class="inputText" size="85"/>
											</div>
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap" class="head">前置处理器:</td>
										<td>
											<input type="text" name="beforeHandlerGlobal" value="${globalForm.beforeHandler }" class="inputText handler" size="40"/>
											
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap" class="head">后置处理器:</td>
										<td>
											<input type="text" name="afterHandlerGlobal" value="${globalForm.afterHandler }" class="inputText handler" size="40"/>
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th width="15%">起始节点表单: </th>
							<td width="10%">
								<select name="startFormType" class="selectForm" >
									<c:choose >
										<c:when test="${startForm==null }">
											<option value="-1" selected="selected" >请选择..</option>
											<option value="0" >在线表单</option>
											<option value="1" >URL表单</option>
										</c:when>
										<c:otherwise>
											<option value="-1" <c:if test="${startForm.formType==-1 }">selected="selected"</c:if>>请选择..</option>
											<option value="0"  <c:if test="${startForm.formType==0 }">selected="selected"</c:if> >在线表单</option>
											<option value="1"  <c:if test="${startForm.formType==1 }">selected="selected"</c:if>>URL表单</option>
										</c:otherwise>
									</c:choose>
								</select>
							</td>
							<td style="padding: 5px 2px 5px 2px;">
								<table class="table-detail"  <c:if test="${startForm==null}">style="display: none" </c:if> >
									<tr>
										<td nowrap="nowrap" class="head">表单:</td>
										<td>
											<div name="startForm" class="form" <c:if test="${startForm!=null && startForm.formType!=0 }">style="display: none" </c:if> >
												<input id="startFormKey" class="formKey"  type="hidden" name="startFormKey" value="${startForm.formKey}">
												<input id="startFormName" class="formDefName"  type="hidden" name="startFormName" value="${startForm.formDefName}">
												<span name="spanForm"><a target="_blank" href="${ctx}/platform/form/bpmFormHandler/edit.ht?formDefId=${startForm.formKey}" >${startForm.formDefName}</a></span>
												<a href="javascript:;" class="link get" onclick="selectForm(this)">选择</a>
												<a href="javascript:;" class="link clean" onclick="clearForm(this)">重选</a>
											</div>
											<div name="startFormUrl" <c:if test="${startForm!=null && startForm.formType!=1 }">style="display: none" </c:if> class="url">
												表单URL:<input type="text" name="formUrlStart" value="${startForm.formUrl }" class="inputText" size="40"/>
											</div>
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap" class="head">前置处理器:</td>
										<td>
											<input type="text" name="beforeHandlerStart" value="${startForm.beforeHandler }" class="inputText handler" size="40" />
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap" class="head">后置处理器:</td>
										<td>
											<input type="text" name="afterHandlerStart" value="${startForm.afterHandler }" class="inputText handler" size="40"/>
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					 
				    <table cellpadding="1" cellspacing="1" class="table-grid table-list">
						<thead>
						<tr>
							<th width="20%">节点名</th>
							<th width="15%">
								<input type="checkbox" id="ckJumpType">
								跳转类型
							</th>
							<th width="10%">
								<input type="checkbox" id="ckHidenOption">隐藏意见表单
							</th>
							<th width="10%">
								<input type="checkbox" id="ckHidenPath">隐藏执行路径
							</th>
							<th width="15%">表单类型</th>
							<th width="35%">表单</th>
						</tr>
						
						</thead>
						<c:forEach items="${bpmNodeSetList}" var="item">
						<tr>
							<td>
								<input type="hidden" name="nodeId" value="${item.nodeId}"/>
								<input type="hidden" name="nodeName" value="${item.nodeName}"/>${item.nodeName}
							</td>
							<td nowrap="nowrap">
								<ul>
									<c:forEach items="${fn:split(item.jumpType,',')}" var="jp">
										<c:choose>
											<c:when test="${jp==1}">
												<c:set var="jumpType1" value="1"/>
											</c:when>
											<c:when test="${jp==2}">
												<c:set var="jumpType2" value="2"/>
											</c:when>
											<c:when test="${jp==3}">
												<c:set var="jumpType3" value="3"/>
											</c:when>
										</c:choose>
									</c:forEach>
									<li><input type="checkbox" class="jumpType" name="jumpType_${item.nodeId}" value="1" <c:if test="${jumpType1==1}">checked="checked"</c:if> />正常跳转</li> 
									<li><input type="checkbox" class="jumpType" name="jumpType_${item.nodeId}" value="2" <c:if test="${jumpType2==2}">checked="checked"</c:if> />选择路径跳转</li> 
									<li><input type="checkbox" class="jumpType" name="jumpType_${item.nodeId}" value="3" <c:if test="${jumpType3==3}">checked="checked"</c:if> />自由跳转</li>
									<c:remove var="jumpType1"/>
									<c:remove var="jumpType2"/>
									<c:remove var="jumpType3"/>
								</ul>
							</td>
							<td>
								<input type="checkbox" class="hideOption" name="isHideOption_${item.nodeId}" value="1" <c:if test="${item.isHideOption==1}">checked="checked"</c:if> />
							</td>
							<td>
								<input type="checkbox" class="hidePath" name="isHidePath_${item.nodeId}" value="1" <c:if test="${item.isHidePath==1}">checked="checked"</c:if> />
							</td>
							<td>
								<select name="formType" class="selectForm" >
									<option value="-1" <c:if test="${item.formType==-1}">selected</c:if>>请选择..</option>
									<option value="0" <c:if test="${item.formType==0}">selected</c:if>>在线表单</option>
									<option value="1" <c:if test="${item.formType==1}">selected</c:if>>URL表单</option>
								</select>
							</td>
							<td>
								<table class="table-detail"  <c:if test="${item.formType==-1}">style="display:none"</c:if>>
									<tr>
										<td nowrap="nowrap" class="head">表单:</td>
										<td>
											<div  class="form" <c:if test="${item!=null && item.formType!=0 }">style="display: none" </c:if> >
												<input type="hidden" class="formKey" name="formKey" value="${item.formKey}">
												<input type="hidden" class="oldFormKey" name="oldFormKey" value="${item.formKey}">
												<input type="hidden" class="formDefName" name="formDefName" value="${item.formDefName}">
												<input type="hidden" class="tableId" name="tableId" value="${item.mainTableId }">
												<span name="spanForm"><a target="_blank" href="${ctx}/platform/form/bpmFormHandler/edit.ht?formDefId=${item.formKey}" >${item.formDefName}</a></span>
												<a href="javascript:;" class="link get" onclick="selectForm(this)" id="subNodeSel">选择</a>
												<a href="javascript:;" class="link clean" onclick="clearForm(this)">重选</a>
												<a href="javascript:;" class="link auth" onclick="authorize(this,'${item.nodeId}')">表单授权</a>
												<input type="hidden" id="existSubTable" value="${item.existSubTable }">
												<a href="javascript:;" class="link grant" onclick="subDataGrant(this,'${item.nodeId}')">子表数据授权</a>
											</div>
											<div <c:if test="${item!=null && item.formType!=1 }">style="display: none" </c:if> class="url">
												表单URL:<input type="text" name="formUrl" value="${item.formUrl }" class="inputText" size="40"/>
												<br/>
												明细URL:<input type="text" name="detailUrl" value="${item.detailUrl }" class="inputText" size="40"/>
											</div>
											
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap" class="head">前置处理器:</td>
										<td><input type="text" name="beforeHandler" value="${item.beforeHandler}" class="inputText handler" size="40"/>
											
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap" class="head">后置处理器:</td>
										<td><input type="text" name="afterHandler" value="${item.afterHandler}" class="inputText handler" size="40"/>
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
						</c:forEach>
					</table>
				</form>
			
		</div>				
	</div>
</body>
</html>


