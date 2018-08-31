<%--
	time:2012-10-23 17:59:41
	desc:edit the 自定义显示
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@page language="java" import="com.cosim.platform.model.system.SysCustomDisplay"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 自定义显示</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript"src="${ctx}/js/cosim/platform/system/ScriptDialog.js"></script>
	<link rel="stylesheet" href="${ctx }/js/tree/v33/zTreeStyle.css" type="text/css" />
	<script type="text/javascript"	src="${ctx}/js/tree/v33/jquery.ztree.core-3.3.min.js"></script>
	<script type="text/javascript"	src="${ctx}/js/tree/v33/jquery.ztree.exedit-3.3.min.js"></script>
	<script type="text/javascript"	src="${ctx}/js/tree/v33/jquery.ztree.excheck-3.3.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
	
	<link  rel="stylesheet" type="text/css" href="${ctx}/js/codemirror/lib/codemirror.css" >
	<script type="text/javascript" src="${ctx}/js/codemirror/lib/codemirror.js"></script>
	<script type="text/javascript" src="${ctx}/js/codemirror/lib/util/matchbrackets.js"></script>
    <script type="text/javascript" src="${ctx}/js/codemirror/mode/plsql/plsql.js"></script>
    <script type="text/javascript"src="${ctx}/js/cosim/platform/system/SysCustomDisplayEdit.js"></script>
	<style type="text/css">
		.hide{
			display: none;
		}
		#tablesShow{
			margin-top:2px;
			height: 460px;
 			padding:0 auto;
			overflow: auto;
			float:left;
 			width:250px;
 			border: solid 1px #A8CFEB;
		}
		#tablesOperate{
			margin:2px 0 0 2px;
			height: 460px;
 			padding:0 auto;
			overflow: auto;
			float:left;
 			width:88px;
 			border: solid 1px #A8CFEB;
		}
		.sbutton{
			margin: 10px 0px 10px 2px ;
		}
		
		
		#leftArea{
			float: left;
			width:28.3%;
			height: 468px;
		}
		#centerArea{
			float: left;
			width:9.1%;
			height: 468px;
		}
		#rightArea{
			float: left;
			width:62.5%;
			height: 468px;
			border: 0px solid rgb(123, 171, 207);
		}
		
		.table-tr-left th{
			text-align: left;
		}
	</style>
	<script type="text/javascript">
		var tablesTree=null;
		var scriptEditor=null;
		$(function() {
			var id=$("#id").val()||0;
			var isAdd=id<=0?true:false;
			initPage(isAdd);
			//修改（非添加）时，初始化数据源选择的值
			var initds='${sysCustomDisplay.dsName}';
			if(initds!=''){
				$('#dsName').val(initds);
			}
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			//保存
			$("a.save").click(function(){
				var resultMsg = validateFirstStepSetting(isAdd);
				if(resultMsg.status){
					if(resultMsg.message){
						$.ligerMessageBox.error(resultMsg.message);
					}
					$(".step-first").show();
					$(".step-second").hide();
					return;
				}
				resultMsg = validateSecondStepSetting(isAdd);
				if(resultMsg.status){
					if(resultMsg.message){
						$.ligerMessageBox.error(resultMsg.message);
					}
					return;
				}
				customFormSubmit(options);
			});	
			
			//如果需要分页，显示分页大小组件。反之隐藏。
			$('#needPageFalse').click(function(){
				$('#pageSize').val('');
				$('#pageSpan').hide();
			});
			$('#needPageTrue').click(function(){
				$('#pageSpan').show();
				$('#pageSize').val('');
			});
			setTimeout(function(){
				var height=$("#script").height();
				var readOnly=!isAdd;
				scriptEditor = CodeMirror.fromTextArea(document.getElementById("script"), {
					mode: "text/x-plsql",
			        lineNumbers: true,
			        matchBrackets: true,
			        readOnly:readOnly
			    });
				scriptEditor.setSize(null,height);
			},0);
		});

		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
					if(rtn){
					}else{
						window.returnValue=true;
						this.close();
					}
				});
			} else {
				$.ligerDialog.err('出错信息',"保存自定义管理失败",obj.getMessage());
			}
		}
		
		
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${sysCustomDisplay.id !=null}">
			        <span class="tbar-label">编辑自定义显示</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加自定义显示</span>
			    </c:otherwise>			   
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar step-first">
				<div class="group"><a class="link next" id="first-next" href="#">下一步</a></div>
				<div class="l-bar-separator"></div>
<!-- 				<div class="group"><a class="link back" href="list.ht">返回</a></div> -->
			</div>
			<div class="toolBar step-second hide">
				<div class="group"><a class="link prev" id="second-prev" href="#">上一步</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link save" href="#">保存</a></div>
				<div class="l-bar-separator"></div>
<!-- 				<div class="group"><a class="link back" href="list.ht">返回</a></div> -->
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="sysCustomDisplayForm" method="post" action="save.ht">
			<div class="step-first">
				<div id="firstLayout">
					<div position="left" title="数据表/视图信息">
						<div >
							<div id="tablesShow">
								<div id="tablesTree" class="ztree" ></div>
							</div>
							<div id="tablesOperate">
								<a class="sbutton button" href="#" onclick="treeSelect(1)"><span title="将左边的选择的节点插入到右边的脚本输入框中">选择节点</span></a>
								<a class="sbutton button" href="#" onclick="treeSelect(2)"><span title="在右边的脚本输入框中插入一个基本查询语句的框架">查询模板</span></a>
							</div>
						</div>
					</div>
					<div position="center">
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
							<tr>
								<th width="10%">名称: </th>
								<td><input type="text"  id="name" name="name" value="${sysCustomDisplay.name}"  class="inputText" validate="{required:true,maxlength:120}"  /></td>
								<th width="10%">描述: </th>
								<td><input type="text" id="description" name="description" value="${sysCustomDisplay.description}"  class="inputText" validate="{required:false}"  /></td>
							</tr>
							<tr>
								<th>脚本类型</th>
								<td>
									<c:choose>
										<c:when test="${!(sysCustomDisplay.id>0)}">
											<select id="scriptType" name="scriptType">
												<option value="1" <c:if test="${sysCustomDisplay.scriptType==1}"> selected="selected" </c:if> >SQL</option>
												<option value="2" <c:if test="${sysCustomDisplay.scriptType==2}"> selected="selected" </c:if> >Groovy</option>
											</select>
										</c:when>
										<c:otherwise>
											<c:if test="${sysCustomDisplay.scriptType==1 }">SQL</c:if>
											<c:if test="${sysCustomDisplay.scriptType!=1 }">Groovy</c:if>
											<input id="scriptType" name="scriptType" type="hidden" value="${sysCustomDisplay.scriptType}"/>
										</c:otherwise>
									</c:choose>
								</td>
								<th >数据源: </th>
								<td >
									<c:choose>
										<c:when test="${sysCustomDisplay.id>0}">
											${sysCustomDisplay.dsName}
											<input type="hidden" id="dsName" name="dsName" value="${sysCustomDisplay.dsName}"/>
										</c:when>
										<c:otherwise>
											<select id="dsName" name="dsName" class="select"  onchange="changeDataSource()">
												<option value="">--请选择数据源--</option>
												<c:forEach items="${dataSources }" var="dataSource">
													<option value="${dataSource.alias}">${dataSource.name }</option>
												</c:forEach>
											</select>								
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>脚本：</th>
								<td colspan="3" style="height: 430px">
									<textarea <c:if test="${sysCustomDisplay.id>0}">readonly="readonly" </c:if> id="script" name="script" class="inputText" validate="{required:true}"  style="width: 98%;height: 420px">${sysCustomDisplay.script}</textarea>
								</td>					
							</tr>
						</table>
					</div>
				</div>
			</div>
		
			<div class="step-second hide">
				<div id="pageinfo">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="10%">分页:</th>
							<td >
								<input id="needPageTrue" type="radio" name="paged" value="1"  <c:if test="${sysCustomDisplay.paged==1}">checked="checked"</c:if>/>
								<label for="needPageTrue">分页</label>
								<input id="needPageFalse" type="radio" name="paged" value="-1" <c:if test="${sysCustomDisplay.paged!=1}">checked="checked"</c:if>/>
								<label for="needPageFalse">不分页</label>
								<span id="pageSpan" class="red" <c:if test="${sysCustomDisplay.paged==-1}">style="display:none;"</c:if> >
									<span>&nbsp;&nbsp;分页大小:</pre></span>
									<span id="pageSizeSpan" >
										  <select id="pageSize" name="pageSize"  style="width: 100px">
										  		<option value="5" <c:if test="${sysCustomDisplay.pageSize==5}">selected="selected"</c:if>>5</option>
												<option value="10" <c:if test="${sysCustomDisplay.pageSize==10}">selected="selected"</c:if>>10</option>
												<option value="15" <c:if test="${sysCustomDisplay.pageSize==15}">selected="selected"</c:if> >15</option>
												<option value="20" <c:if test="${sysCustomDisplay.pageSize==20}">selected="selected"</c:if>>20</option>
												<option value="50" <c:if test="${sysCustomDisplay.pageSize==50}">selected="selected"</c:if>>50</option>	
												<option value="100" <c:if test="${sysCustomDisplay.pageSize==100}">selected="selected"</c:if>>100</option>					  
										  </select>
									 </span>
								 </span>				
							</td>
						</tr>
						<tr>
							<th>模板</th>
							<td>
								<select id="template" onchange="templateChangeHandler(this)">
									<option value="">--请选择模板--</option>
									<c:forEach items="${templates}" var="item">
										<option value="${item['file'] }" setting="${item['setting']}" <c:if test="${item['file'] == sysCustomDisplay.template}">selected="selected"</c:if>>${item['name']}</option>
									</c:forEach>
								</select>
								<a href="#" onclick="settingTemplate()">设置模板参数</a>
							</td>
						</tr>
						<tr>
							<th>条件设置</th>
							<td>
								<div >
									<div id="leftArea">
									<div style="border: 1px solid rgb(123, 171, 207);height: 460px;overflow: auto;">
										<table id="columnsTbl" class="table-detail">
											<thead>
												<tr>
													<th colspan="3" style="text-align: center">列信息</th>
												</tr>
												<tr class="table-tr-left">
													<th width="30px">选择</th>
													<th>列名</th>
													<th>注释</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
										</div>
									</div>
									<div id="centerArea">
										<div>
											<table style="width: 90%;height: 460px;margin: 1px auto;">
												<tr>
													<th style="text-align: center">添加选择</th>
												</tr>
												<tr>
													<td style="text-align: center;">
														<a id="selectCondition" style="margin-top: 30px;" onclick="selectCondition()" href="#" class="button">
														<span>==></span>
														</a>
													</td>
												</tr>
											</table>
										</div>
									</div>
									<div id="rightArea">
										<div style="border: 1px solid rgb(123, 171, 207);height: 460px;overflow: auto;">
											<table id="conditionTbl" class="table-detail">
												<thead>
													<tr><th colspan="7" style="text-align:center;">条件</th></tr>
													<tr class="table-tr-left">
														<th width="50px">联合类型</th>
														<th>字段名</th>
														<th>条件</th>
														<th>显示名</th>
														<th>值来源</th>
														<th>值</th>
														<th>管理</th>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
										</div>
									</div>
									<div style="clear: both;"></div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" id="id" name="id" value="${sysCustomDisplay.id}" />
			<input type="hidden" id="conditionField" name="conditionField" value="${fn:escapeXml(sysCustomDisplay.conditionField) }"/>
			<input type="hidden" id="fieldSetting" name="fieldSetting" value="${fn:escapeXml(sysCustomDisplay.fieldSetting) }"/>
			<input type="hidden" id="setting" name="setting" value="${fn:escapeXml(sysCustomDisplay.setting)}" />
		</form>
		<input  type="hidden" id="fields" name="fields" value="${fn:escapeXml(sysCustomDisplay.fieldSetting) }"/>
	</div>
</div>
</body>
</html>
