<%--
	time:2012-06-25 11:05:09
	desc:edit the 自定义表管理
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 自定义表管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript"src="${ctx}/js/cosim/platform/system/ScriptDialog.js"></script>
	<link  rel="stylesheet" type="text/css" href="${ctx}/js/codemirror/lib/codemirror.css" >
	<script type="text/javascript" src="${ctx}/js/codemirror/lib/codemirror.js"></script>
	<script type="text/javascript" src="${ctx}/js/codemirror/lib/util/matchbrackets.js"></script>
    <script type="text/javascript" src="${ctx}/js/codemirror/mode/groovy/groovy.js"></script>
    <script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js"></script>
    <link href="${ctx}/styles/default/css/jquery.qtip.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.js" ></script>
    <script type="text/javascript" src="${ctx}/js/cosim/ajaxgrid.js" ></script>
    <script type="text/javascript"src="${ctx}/js/cosim/platform/system/SysTableManageEdit.js"></script>
	<style type="text/css">
		.tab-top{
			margin:0 0 0 0;
		}
		#sysTableManageForm td{
			padding:2px 3px;
		}
		#sysTableManageForm th{
			padding:2px 6px;
		}
		.even {
			height: 28px;
		}
		.odd {
			height: 28px;
		}
		.over{
			background: #FCF1CA;
		}
		.hide{
			display: none;
		}
		.moveSelect{
			margin:4px auto;
		}
		.leftHeader th{
			text-align: left;
		}
		
		.condition-cols{
			height:400px;
			overflow: auto;
			float:left;
			width: 30%;
		}
		.condition-conds{
			height:400px;
			overflow: auto;
			float:left;
			width:70%;
		}
		.condition-cols-div{
			border: solid 1px #A8CFEB;
			padding: 2px;
			height:394px;
		}
		.condition-conds-div{
			border: solid 1px #A8CFEB;
			padding: 2px;
			height:394px;
		}
		.condition-conds-div-left{
			height:394px;
			overflow: auto;
			float:left;
			width:15%;
		}
		
		.condition-conds-div-right{
			height:394px;
			overflow: auto;
			float:left;
			width:85%;
		}
		.condition-conds-div-left-div{
			text-align:center;
			vertical-align:middle;
			height:390px;
			border: solid 1px #A8CFEB;
			margin: 1px
		}
		.condition-conds-div-right-div{
			height:386px;
			border: solid 1px #A8CFEB;
			padding: 2px;
			margin: 1px;
		}
		
		.condition-script-div{
			border: solid 1px #A8CFEB;
			padding: 2px;
			height:394px;
			
		}
		.condition-script-div-script-editor{
			width:100%;
			height:348px;
		}
		
		.condition-script-div-parameters{
			height: 40px;
		}
		
		.condition-script-div-parameters-list{
			height: 36px;
			overflow: auto;
		}
		
		.condition-script-div-script{
			height:346px;
		}
		
		.condition-script-div-script-operate{
/* 			position: absolute; */
			margin-top: 5px;
		}
		
		.info{
			padding-right: 5px;
		}
		
		.info ul li{
			list-style: disc;
			margin-left: 30px;
		}
		.info font{
			color: red;
		}
	</style>
	<script type="text/javascript">
		var conditonScriptEditor=null;
		var tabcomp=null;
		var pgmswitchta=false;
		$(function() {
			//Tag Layout
			tabcomp=$("#tab").ligerTab({
				onBeforeSelectTabItem:onBeforeSelectTabItem
			});
			
			var isAdd=${sysTableManage.id}>0?false:true;
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#sysTableManageForm').form();
			$("a.save").click(function() {
				if(!validate()){
					return;
				}
				
				conditonScriptEditor.save();
				var setting = getParameterSetting();
				if(setting==false){
					return;
				}
				$("#displayField").val(JSON.stringify(setting.fieldSetting));
				var conditionType=$("input[name='conditionType']:checked").val();
				if(conditionType==1){
					$("#conditionField").val(JSON.stringify(setting.conditionField));
				}else{
					$("#conditionField").val(setting.conditionField);
				}
				$("#parameters").val(JSON.stringify(setting.parameters));
				
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					customFormSubmit(options);
					$("#sysTableManageForm").resetForm();
				}
			});
			
			$("#btnSelectTable").click(selectTable);
			//绑定选择条件点击事件
			$("#selectCondition").click(selectCondition);
			
			if(!isAdd){
				var fieldsStr = $("#displayField").val();
				var condsStr = $("#conditionField").val();
				var paramsStr = $("#parameters").val();
				var conditionType = $("input[name='conditionType']:checked").val();
				var fields=$.parseJSON(fieldsStr);
				var conds;
				if(condsStr){
					if(conditionType==1){
						conds = $.parseJSON(condsStr);
					}else{
						conds=condsStr;
					}
				}
				var params=$.parseJSON(paramsStr);
				initSetting({fields:fields,conds:conds,params:params},conditionType);
			}
			
			setTimeout(function(){
				var height=$("#conditionScript").height();
				conditonScriptEditor = CodeMirror.fromTextArea(document.getElementById("conditionScript"), {
					mode: "text/x-groovy",
			        lineNumbers: true,
			        matchBrackets: true
			    });
				conditonScriptEditor.setSize(null,height);
			},0);
			
			$("input[name='conditionType']").click(function(){
				var type=$("input[name='conditionType']:checked").val();
				switchConditionType(type);
			});
			//根据条件类型隐藏或显示相应信息
			var conditionType=$("input[name='conditionType']:checked").val();
			switchConditionType(conditionType);
			
			$("table tr").bind('dblclick',function(event){ 
			    clearSelection(); 
			});
			
			$("#templateIdTip").qtip({
				content:"添加更多数据模板，请到自定义表单模板中添加类型为\"自定义表管理模板\"的模板"
			});
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">编辑自定义表管理</span>
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
				<form id="sysTableManageForm" method="post" action="save.ht" >
				<div id="tab">
					<div tabid="baseSetting" id="table" title="设置基本信息">
						<div >
							<div class="tbar-title">
								<span class="tbar-label">自定义表管理管理基本信息</span>
							</div>
							<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main" style="border-width: 0!important;">
								<tr>
									<th width="10%">名称: </th>
									<td width="30%"><input type="text" id="name" name="name" value="${sysTableManage.name}"  class="inputText"  validate="{required:true,maxlength:50}"/></td>
									
								</tr>
								<tr>
									<th width="10%">别名: </th>
									<td >
										<input type="text" id="alias" name="alias" value="${sysTableManage.alias}"  class="inputText"  validate="{required:true,maxlength:50}"/>
										<span id="aliasInfo" style="color:red"></span>
									</td>
								</tr>
								<tr>
									<th >是否分页: </th>
									<td>
										<input type="radio" name="needPage" value="0"  onclick="switchNeedPage();" <c:if test="${sysTableManage.needPage==0}">checked="checked"</c:if> >不分页
										<input type="radio" name="needPage" value="1" onclick="switchNeedPage();" <c:if test="${sysTableManage.needPage==1}">checked="checked"</c:if>>分页
										<span style="color:red;<c:if test="${sysTableManage.needPage==0}">display:none;</c:if>" id="spanPageSize" name="spanPageSize">
											分页大小：
											  <select id="pageSize" name="pageSize" >
											  		<option value="5" <c:if test="${sysTableManage.pageSize==5}">selected="selected"</c:if> >5</option>
													<option value="10" <c:if test="${sysTableManage.pageSize==10}">selected="selected"</c:if>>10</option>
													<option value="15" <c:if test="${sysTableManage.pageSize==15}">selected="selected"</c:if> >15</option>
													<option value="20" <c:if test="${sysTableManage.pageSize==20}">selected="selected"</c:if>>20</option>
													<option value="50" <c:if test="${sysTableManage.pageSize==50}">selected="selected"</c:if>>50</option>						  
											  </select>
										 </span>
									</td>
								</tr>
								<tr>
		 							<th>是否可编辑:</th>
		 							<td>
		 								<input type="radio" name="editable" value="0"  <c:if test="${sysTableManage.editable==0}">checked="checked"</c:if> >不可编辑
										<input type="radio" name="editable" value="1"  <c:if test="${sysTableManage.editable==1}">checked="checked"</c:if> >可编辑
										<span class="green">只对有主键的数据表有效</span>
		 							</td>
								</tr>
								<tr>
									<th >数据源: </th>
									<td>
										<c:choose>
											<c:when  test="${sysTableManage.id==0}">
												<select id="dsAlias" name="dsAlias" onchange="dsAliasOnChangeHandler(this)">
													<option value="">--请选择数据源--</option>
													<c:forEach items="${dsList}" var="ds">
														<option value="${ds.alias}">${ ds.name}</option>
													</c:forEach>
												</select>
												<input type="hidden" id="dsName" name="dsName"/>
										</c:when>
										<c:otherwise>
											<span>${sysTableManage.dsName}</span>
										</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th >查询表/视图: </th>
									<td>
										<c:choose>
											<c:when  test="${sysTableManage.id==0}">
												<input readonly="readonly" type="text" name="objName" id="objName">
												<a href="#" id="btnSelectTable" class="link get">选择对象</a>
											</c:when>
											<c:otherwise>
												<span>${sysTableManage.objName}</span>
												<c:if test="${sysTableManage.isTable==1}"><span class="green"> [表] </span></c:if>
												<c:if test="${sysTableManage.isTable==0}"><span class="green"> [视图] </span></c:if>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>数据模板</th>
									<td>
										<select name="templateId" id="templateId">
											<option value="">--请选择数据模板--</option>
											<c:forEach items="${templates}" var="template">
												<option  value="${template.templateId}" <c:if test="${sysTableManage.templateId==template.templateId}">selected="selected"</c:if>>${template.templateName}</option>
											</c:forEach>
										</select>
										<a class="link tipinfo" id="templateIdTip"></a>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div tabid="displaySetting" id="table" title="设置显示字段">
						<div>
							<div class="tbar-title">
								<span class="tbar-label">自定义表管理管理显示字段</span>
							</div>
							<table id="columnsTbl"  class="table-detail">
								<thead>
									<tr class="leftHeader">
<!-- 									<th>选择</th> -->
										<th width="20%">
											<input type="checkbox" id="chkall" onclick="selectAll(this)"/>
											显示
										</th>
										<th width="20%">列名</th>
										<th width="20%">类型</th>
										<th>注释</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
					<div tabid="parameterSetting" id="table" title="设置自定义变量">
						<div>
							<div class="tbar-title">
								<span class="tbar-label">自定义表管理管理自定义变量</span>
							</div>
							<div class="panel-toolbar">
								<div class="group">
									<a id="addParameter" class="link add" onclick="addParameter()" href="#"><span class="green">添加</span></a>
								</div>
								<div class="l-bar-separator"></div>
								<div class="group">
									<a class="link tipinfo" href="#" onclick="helpInfoShow(this,'parameterSettingHelpInfo')">使用帮助</a>
								</div>
							</div>
							<table id="parameters-table" class="table-grid" style="margin-top: 5px">
								<thead>
									<tr class="leftHeader">
										<th width="20%" style="text-align: center;">参数名</th>
										<th width="20%" style="text-align: center;">显示名</th>
										<th width="10%" style="text-align: center;">参数类型</th>
										<th width="10%" style="text-align: center;">值来源</th>
										<th width="30%" style="text-align: center;">参数值</th>
										<th style="text-align: center;">管理</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
					<div tabid="conditionSetting" id="table" title="设置过滤条件">
						<div>
							<div class="tbar-title">
								<span class="tbar-label">自定义表管理管理过滤条件</span>
							</div>
							<div class="panel-toolbar">
								<div class="toolBar">
									<span  style="color:blue ;float: left;margin-left: 10px">条件类型：</span>
									<span class="green" style="float: left;margin-left: 10px">
										<label for="condition-build">建立条件</label>
										<input id="condition-build" value="1" type="radio" name="conditionType" <c:if test="${sysTableManage.conditionType==1}">checked="checked"</c:if> >
									</span>
									<span class="green" style="float: left;margin-left: 20px">
										<label for="condition-script">脚本条件</label>
										<input id="condition-script" value="2" type="radio" name="conditionType" <c:if test="${sysTableManage.conditionType==2}">checked="checked"</c:if> >
									</span>
									<span style="float: left;margin-left: 20px">
										<a class="link tipinfo" href="#"  onclick="helpInfoShow(this,'conditionSettingHelpInfo')">使用帮助</a>
									</span>
								</div>
							</div>
							<div>
								<div class="condition-cols">
									<div class="condition-cols-div">
										<table id="condition-columnsTbl" cellpadding="0" cellspacing="0" border="0" class="table-detail">
											<thead>
												<tr class="leftHeader">
													<th>选择</th>
													<th>列名</th>
													<th>类型</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
								</div>
								<div class="condition-conds">
									<div class="condition-conds-div condition-conds-build" id="condition-build-div">
										<div class="condition-conds-div-left">
											<div class="condition-conds-div-left-div">
												<a style="margin-top: 180px;" id="selectCondition" href="#" class="button">
													<span>==></span>
												</a>
											</div>
										</div>
										<div class="condition-conds-div-right">
											<div class="condition-conds-div-right-div">
												<table id="conditionTbl" cellpadding="0" cellspacing="0" border="0" class="table-detail">
													<thead>
														<tr class="leftHeader">
															<th width="50px">联合类型</th>
															<th>字段名</th>
															<th>条件</th>
															<th>显示名</th>
															<th>值来源</th>
															<th width="145px">值</th>
															<th>管理</th>
														</tr>
													</thead>
													<tbody>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="condition-conds-div condition-conds-script" id="condition-script-div">
										<div id="condition-script-div-parameters" class="condition-script-div-parameters">
											<table class="table-detail">
												<tr>
													<th width="70px">自定义变量</th>
													<td>
														<div class="condition-script-div-parameters-list" id="condition-script-div-parameters-list"></div>
													</td>
												</tr>
											</table>
										</div>
										<div class="condition-script-div-script">
											<table class="table-detail">
												<tr>
													<th width="70px" valign="top">
<!-- 														<div style="position: relative;height:100%;vertical-align: middle;"> -->
															<div class="condition-script-div-script-operate">
																<a class="link next" onclick="validateConditionScript(this)">验证脚本</a>
															</div>
															<div style="margin-top: 150px">条件脚本</div>
<!-- 														</div> -->
													</th>
													<td>
														<textarea class="condition-script-div-script-editor" id="conditionScript"><c:if test="${sysTableManage.conditionType==2 }">${sysTableManage.conditionField}</c:if></textarea>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="hidden-input" class="hide">
					<input type="hidden" id="id" name="id" value="${sysTableManage.id}" />
					<input type="hidden" id="displayField" name="displayField" value="${fn:escapeXml(sysTableManage.displayField)}" />
					<input type="hidden" id="conditionField"  name="conditionField" value="${fn:escapeXml(sysTableManage.conditionField)}" />
					<input type="hidden" id="parameters" name="parameters" value="${fn:escapeXml(sysTableManage.parameters)}" />
					<input type="hidden" id="isTable" name="style" value="${sysTableManage.isTable}" />
					<c:if test="${sysTableManage.id!=0}">
						<input type="hidden" id="dsAlias" name="dsAlias" value="${sysTableManage.dsAlias}" />
						<input type="hidden" id="dsName" name="style" value="${sysTableManage.dsName}" />
						<input type="hidden" id="objName" name="style" value="${sysTableManage.objName}" />
					</c:if>
				</div>
				</form>
		</div>
</div>
<div id="parameterSettingHelpInfo" class="hide">
<div class="info">
	<table class="table-detail">
    <tbody>
        <tr>
            <th width="50px">
               	 概念
            </th>
            <td>
                <p>
              		自定义变量是用户自行添加的变量。变量与变量的值作为一个<span class="brown">Key</span>、<span class="brown">Value</span>对被放入到一个<span class="brown">HashMap</span>的容器中，容器的名字约定为<span class="brown">VarMap</span>。并通过<span class="brown">VarMap</span>进行访问，访问方式与在<span class="brown">Java</span>中访问<span class="brown">HashMap</span>类型的变量相同。
                </p>
            </td>
        </tr>
        <tr>
            <th>
   		             变量定义
            </th>
            <td>
                <p>
       		             自定义变量包括定义变量的名字、注释、类型、值来源、和值。名字命名规则与<span class="brown">Java</span>语言中的变量相同。
                </p>
                <h4>
       		             自定义变量的值来源可分为：
                </h4>
                <ul>
                    <li>
                        <p>
                 		           输入，此类型的变量要求在<span class="brown">FreeMarker</span>模板在定义一个对应的输入框供用户输入。变量的值最终从页面的提交请求中获取。
                        </p>
                    </li>
                    <li>
                        <p>
           			                 固定值，此类型的变量的值在定义变量时直接指定。
                        </p>
                    </li>
                    <li>
                        <p>
               		             脚本，脚本类型的值在变量使用时动态解析脚本时得到。
                        </p>
                    </li>
                </ul>
            </td>
        </tr>
        <tr>
            <th>
               	 使用变量
            </th>
            <td>
                <p>
                    	自定义的变量可以在<span class="brown">FreeMarker</span>模板和过滤条件中使用。使用时通过预定义<span class="brown">HashMap</span>类型的容器变量<span class="brown">VarMap</span>进行访问。
                </p>
                <h4>
                   	 如：
                </h4>
                <ul>
                    <li>
                        <p>
                            	在<span class="brown">FreeMarker</span>中访问自定义变量name：<span class="brown">&lt;#assisn </span><span class="red">na=VarMap[</span><span class="brown">&quot;name&quot;</span><span class="red">]</span><span class="brown"> &gt;</span>
                        </p>
                    </li>
                    <li>
                        <p>
                            	在脚本类型的过滤条件中访问自定义变量name：<span class="red">Obj</span><span class="red">ect na=VarMap.get(</span><span class="brown">&quot;name&quot;</span><span class="red">);</span>
                        </p>
                    </li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>
</div>
</div>
<div id="conditionSettingHelpInfo" class="hide">
	<div  class="info">
		<table class="table-detail">
			<tr>
				<th width="50px">概念</th>
				<td>
					<p>
						通过过滤条件，可对自定义表获取的数据集进行过滤。过滤的形式是以<span class="brown">SQL</span>的<span class="brown">WHERE</span>条件添加到查询语句中的。
					</p>
				</td>
			</tr>
			<tr>
				<th>条件类型</th>
				<td>
					<h4>过滤的条件类型可分为两种：</h4>
					<ul>
						<li>建立条件，是以图形界面方式进行过滤条件的建立。此类型的条件不支持条件的嵌套。</li>
						<li>脚本条件，通过编写脚本进行添加过滤条件。编写的脚本要求，脚本在最终解析后，得到一个如<span class="brown">"col1=value1 and (col2=value2 or col2=value3)"</span>,可用于<span class="brown">SQL</span>语句的<span class="brown">WHERE</span>子句的字符串。
							在脚本中，可以通过<span class="brown">VarMap</span>访问自定义的变量。<span class="brown">VarMap</span>是一个<span class="brown">HashMap</span>类型的变量，对<span class="brown">VarMap</span>操作与<span class="brown">Java</span>中对<span class="brown">HashMap</span>类型的变量相同。
							例如，要添加一个动态的用户ID过滤条件，如果自定义变量中的定义了变量userId，且值不为空，则将userId作为过滤条件:<br/>
							String wh=<span class="brown">""</span>;<br/>
							Long userId=VarMap.get("userId");<br/>
							<span class="brown">if</span>(userId!=<span class="brown">null</span>){<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;wh="userId="+userId;<br/>
							}<br/>
							<span class="brown">return</span> wh;<br/>
						</li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>
