<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cosim.platform.model.bpm.BpmDefRights"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程定义扩展管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/ImportExportXmlUtil.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/tabOperator.js" ></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/FlowRightDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/FlowUtil.js" ></script>
<script type="text/javascript">
	  
	
	// 导出流程定义
	function exportXml(){	
		var bpmDefIds = ImportExportXml.getChkValue('pk');
		if (bpmDefIds ==''){
			$.ligerMessageBox.warn('提示信息','还没有选择,请选择一项流程定义!');
			return ;
		}

		var url=__ctx + "/platform/bpm/bpmDefinition/export.ht?bpmDefIds="+bpmDefIds;
		ImportExportXml.showModalDialog({url:url,height:400});
	}

	
	//导入流程定义
	function importXml(){
		var url=__ctx + "/platform/bpm/bpmDefinition/import.ht";
		ImportExportXml.showModalDialog({url:url});
	}
	
	
	 
</script>
</head>
<body>      
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流程定义管理</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch">查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del"  action="del.ht">删除</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link flowDesign" onclick="window.open('design.ht')">在线流程设计</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link download"  href="#" onclick="exportXml()">导出</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link upload"  href="#" onclick="importXml()">导入</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link reload"  href="#" onclick="window.location.reload()">刷新</a></div>						
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">&nbsp;&nbsp;&nbsp;标题:</span><input type="text" name="Q_subject_SL"  class="inputText" style="width:13%;" value="${param['Q_subject_SL']}"/>
						<!-- 
						<span class="label">流程分类:</span><input type="text" name="Q_typeName_S" class="inputText" style="width:13%;" value="${param['Q_typeName_S']}"/>
						 -->
						<span class="label">流程定义Key:</span><input type="text" name="Q_defKey_SL"  class="inputText" style="width:13%;" value="${param['Q_defKey_SL']}"/>
						<span class="label">描述:</span><input type="text" name="Q_descp_SL" class="inputText" maxlength="125" style="width:13%;" value="${param['Q_descp_SL']}"/>
						<span class="label">状态:</span>
						<select name="Q_status_L" class="select" style="width:13%;" value="${param['Q_status_L']}">
							<option value="">所有</option>
							<option value="0" <c:if test="${param['Q_status_L'] == 0}">selected</c:if>>未发布</option>
							<option value="1" <c:if test="${param['Q_status_L'] == 1}">selected</c:if>>已发布</option>
							<option value="2" <c:if test="${param['Q_status_L'] == 2}">selected</c:if>>禁用</option>
						</select>
						<br>
						<span class="label">创建时间:</span><input type="text" name="Q_createtime_DL"  class="inputText date" style="width:13%;" value="${param['Q_createtime_DL']}"/>
						<span class="label">至</span><input name="Q_endcreatetime_DG" class="inputText date" style="width:13%;" value="${param['Q_endcreatetime_DG']}"/>
					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="bpmDefinitionList" id="bpmDefinitionItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
					<display:column title="${checkAll}" media="html" style="width:30px;">
						  	<input type="checkbox" class="pk" name="defId" value="${bpmDefinitionItem.defId}">
					</display:column>
					<display:column property="subject" title="标题" sortable="true" sortName="subject" ></display:column>
					
					<display:column title="分类" sortable="true" sortName="typeId">
						<c:out value="${bpmDefinitionItem.typeName}"></c:out>
					</display:column>
					<display:column property="versionNo" title="版本" sortable="true" sortName="versionNo" style="width:25px"></display:column>
					<display:column title="发布状态" sortable="true" sortName="status" style="width:45px;">
						<c:choose>
							<c:when test="${bpmDefinitionItem.status eq 0}"><span class="red">未发布</span></c:when>
							<c:when test="${bpmDefinitionItem.status eq 1}"><span class="green">已发布</span></c:when>
							<c:when test="${bpmDefinitionItem.status eq 2}"><span class="red">禁用</span></c:when>
							<c:otherwise><span class="red">未选择</span></c:otherwise>
						</c:choose>
					</display:column>
					<display:column title="创建时间" sortable="true" sortName="createtime"  style="width:70px;">
						<fmt:formatDate value="${bpmDefinitionItem.createtime}" pattern="yyyy-MM-dd"/>
					</display:column>
					<display:column  title="启用状态" sortable="true" sortName="disableStatus" style="width:45px;">
							<c:choose>
							    <c:when test="${bpmDefinitionItem.disableStatus eq 1}"><span class="red">禁用</span></c:when>
								<c:when test="${bpmDefinitionItem.disableStatus eq 0}"><span class="green">启用</span></c:when>
								<c:otherwise><span class="red">未设定</span></c:otherwise>
							</c:choose>
					</display:column>
					<display:column title="管理" media="html"  style="width:360px;">
						<a alias="delProcess" href="del.ht?defId=${bpmDefinitionItem.defId}" class="link del" >删除</a>
						<a alias="flex" href="design.ht?defId=${bpmDefinitionItem.defId}" target="_blank" class="link flowDesign" >设计</a>
						<c:if test="${bpmDefinitionItem.status==1}">
							<a alias="setBpm" href="detail.ht?defId=${bpmDefinitionItem.defId}" class="link setting" >设置</a>
							<a alias="startProcess" href="#" onclick="FlowUtil.startFlow(${bpmDefinitionItem.defId},'${bpmDefinitionItem.actDefId}')" class="link run" >启动</a>
						</c:if>
						<a alias="grantProcess" href="javascript:FlowRightDialog(${bpmDefinitionItem.defId},0,'${bpmDefinitionItem.defKey}')" class="link grant" >授权</a>
						<c:if test="${bpmDefinitionItem.status==0}">
							<a alias="publishProcess" href="deploy.ht?defId=${bpmDefinitionItem.defId}" class="link deploy" >发布</a>
						</c:if>
						<c:if test="${bpmDefinitionItem.status==1}">
							<a alias="setDisableStatus" class="link lock" href="updateDisableStatus.ht?defId=${bpmDefinitionItem.defId}&disableStatus=${bpmDefinitionItem.disableStatus}" >
									<c:choose>
									    <c:when test="${bpmDefinitionItem.disableStatus eq 0}">禁用</c:when>
										<c:when test="${bpmDefinitionItem.disableStatus eq 1}">启用</c:when>
								    </c:choose>
							</a>
						</c:if>
					<a href="${ctx}/cloud/saas/workflow/list.ht?defId=${bpmDefinitionItem.defId}" class="link deploy">映射企业</a>
					</display:column>
				</display:table>
				<cosim:paging tableId="bpmDefinitionItem"/>
			
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


