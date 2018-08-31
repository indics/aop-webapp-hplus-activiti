<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自定义表单列表</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>

<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerDialog.js" ></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CopyFormDefDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/ImportExportXmlUtil.js"  charset="UTF-8"></script>
<script type="text/javascript">
	var win;
	function newFormDef(){
		var url=__ctx + '/platform/form/bpmFormDef/gatherInfo.ht?categoryId=${categoryId}';
		//win= $.ligerDialog.open({title:"新建表单", url: url, height: 350,width:550 ,isResize: false });	
		win= $.ligerDialog.open({title:"新建表单", url: url, height: 600,width:800 ,isResize: false });	
	}

	function closeWin(){
		if(win){
			win.close();
		}
	}
	
	$(function(){
		$("a.link.del").unbind("click");
		delFormDef();
		publish();
		handNewVersion();
	});	
	
	function copyFormDef(formDefId){
		CopyFormDefDialog({formDefId:formDefId,center:0});
	};
	
	function publish(){
		$.confirm("a.link.deploy",'确认发布吗？');
	}
	
	function delFormDef(){
		$.confirm("a.link.del",'确定删除该自定义表单吗？');
	}
	
	function handNewVersion(){
		$.confirm("a.link.newVersion",'确认新建版本吗？');
	}
	
	function authorizeDialog(formKey){
		var url=__ctx + '/platform/form/bpmFormDef/rightsDialog.ht?formKey=' + formKey;
		var winArgs="dialogWidth=800px;dialogHeight=600px;help=0;status=no;center=yes;resizable=no;";
		url=url.getNewUrl();
		window.showModalDialog(url,"",winArgs);
	}
	
	
	// 导出自定义表单
	function exportXml(){	
		var formDefIds = ImportExportXml.getChkValue('pk');
		if (formDefIds ==''){
			$.ligerMessageBox.warn('提示信息','还没有选择,请选择一项自定义表单!');
			return ;
		}

		var url=__ctx + "/platform/form/bpmFormDef/export.ht?formDefIds="+formDefIds;
		ImportExportXml.showModalDialog({url:url});
	}

	
	//导入自定义表单
	function importXml(){
		var url=__ctx + "/platform/form/bpmFormDef/import.ht";
		ImportExportXml.showModalDialog({url:url});
	}
	
</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">自定义表单列表</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link search" id="btnSearch">查询</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link add" onclick="newFormDef()"  href="#">添加</a></div>
				<div class="l-bar-separator"></div>
				<div class="group">
					<a onclick="exportXml()" href="#" class="link download">导出</a>
				</div>
				<div class="l-bar-separator"></div>
				<div class="group">
					<a onclick="importXml()" href="#" class="link upload">导入</a>
				</div>
			</div>	
		</div>
		<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">表单标题:</span><input type="text" name="Q_subject_SL"  class="inputText" value="${param['Q_subject_SL']}"/>		
					</div>
				</form>
		</div>
	</div>
	<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall" />
			</c:set>
		    <display:table name="bpmFormDefList" id="bpmFormDefItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
					<input type="checkbox" class="pk" name="formDefId"
						value="${bpmFormDefItem.formDefId}">
				</display:column>
				<display:column property="subject" title="表单标题" sortable="true" sortName="subject" style="width:150px;"></display:column>
				<display:column property="tableName" title="对应表" sortable="true" sortName="tableName" ></display:column>
				<display:column property="categoryName" title="表单类别" sortable="true" sortName="categoryId" ></display:column>
				<display:column  title="发布状态" sortable="true" sortName="isPublished" style="text-align:left">
					<c:choose>
						<c:when test="${bpmFormDefItem.isPublished==1 }">
							<span class="green">已发布</span>
						</c:when>
						<c:otherwise>
							<span class="red">未发布</span>
						</c:otherwise>
					</c:choose>
				</display:column>
				<display:column title="设计类型" style="text-align:left;width:60px;">
					<c:choose>
						<c:when test="${bpmFormDefItem.designType==0 }">
							<span class="green">通过表生成</span>
						</c:when>
						<c:when test="${bpmFormDefItem.designType==1 }">
							<span class="brown">编辑器设计</span>
						</c:when>
					</c:choose>
				</display:column>
				<display:column title="版本信息" style="text-align:left;width:95px;">
					<c:choose>
						<c:when test="${publishedCounts[bpmFormDefItem.formDefId] > 0}">
							发布了<a href="versions.ht?formKey=${bpmFormDefItem.formKey}" >${publishedCounts[bpmFormDefItem.formDefId]}个版本</a>
						</c:when>
						<c:otherwise>
							发布了${publishedCounts[bpmFormDefItem.formDefId]}个版本
						</c:otherwise>
					</c:choose>
					<c:if test="${publishedCounts[bpmFormDefItem.formDefId] > 0}">
						,默认<a href="get.ht?formDefId=${bpmFormDefItem.formDefId}" >版本${defaultVersions[bpmFormDefItem.formDefId].versionNo}</a>
					</c:if>
				</display:column>				
				<display:column title="管理" media="html" >
					<c:choose>
						<c:when test="${bpmFormDefItem.isPublished== 1}">
							<a href="newVersion.ht?formDefId=${bpmFormDefItem.formDefId}"  class="link newVersion">新建版本</a>
						</c:when>
						<c:otherwise>
							
						<c:choose>
							<c:when test="${bpmFormDefItem.designType==0 }">
								<a href="#" onclick="javascript:jQuery.openFullWindow('edit.ht?formDefId=${bpmFormDefItem.formDefId}');" class="link edit">编辑</a>
								<a href="publish.ht?formDefId=${bpmFormDefItem.formDefId }" class="link deploy" >发布</a>
							</c:when>
							<c:when test="${bpmFormDefItem.designType==1 }">
								<a href="#" onclick="javascript:jQuery.openFullWindow('designEdit.ht?formDefId=${bpmFormDefItem.formDefId}');" class="link edit">编辑</a>
								
							</c:when>
						</c:choose>
						</c:otherwise>
					</c:choose>
					<f:a alias="delForm" css="link del" href="delByFormKey.ht?formKey=${bpmFormDefItem.formKey}">删除</f:a>
					<a href="get.ht?formDefId=${bpmFormDefItem.formDefId}" class="link detail">明细</a>
					
					<c:choose>
							<c:when test="${bpmFormDefItem.designType==0 }">
								<a target="_blank" href="${ctx}/platform/form/bpmFormHandler/edit.ht?formDefId=${bpmFormDefItem.formDefId}" class="link preview">预览</a>
								<a  class="link auth" href="javascript:authorizeDialog(${bpmFormDefItem.formKey})">表单权限</a>
							</c:when>
							<c:when test="${bpmFormDefItem.designType==1 }">
								<a href="#" onclick="javascript:jQuery.openFullWindow('preview.ht?formDefId=${bpmFormDefItem.formDefId}');" class="link preview">预览</a>
								<c:if test="${bpmFormDefItem.isPublished==1}">
									<a class="link auth"  href="javascript:authorizeDialog(${bpmFormDefItem.formKey})">表单权限</a>
								</c:if>
							</c:when>
					</c:choose>
					<c:if test="${bpmFormDefItem.isPublished==1}">
					<a  href="${ctx}/platform/form/bpmTableTemplate/formKey.ht?formKey=${bpmFormDefItem.formKey}" class="link preview">数据模版</a>
						<a  href="javascript:;" onclick="copyFormDef(${bpmFormDefItem.formDefId})" class="link copy">复制</a>
					</c:if>
				</display:column>
			</display:table>
			<cosim:paging tableId="bpmFormDefItem"/>
		
	</div><!-- end of panel-body -->				
</div> <!-- end of panel -->
</body>
</html>


