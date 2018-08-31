
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>自定义表管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/lg/plugins/ligerWindow.js"></script>
<script type="text/javascript"
	src="${ctx }/js/cosim/platform/bpm/SetRelationWindow.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/js/cosim/platform/bpm/ImportExportXmlUtil.js"
	charset="UTF-8"></script>
<script type="text/javascript">
	var win;
	function showRelation(tableId,dsName) {
		var conf={tableId:tableId,dsName:dsName};
		SetRelationWindow(conf);
	}
	
	function assignMainTable(subTableId){
		var url=__ctx + "/platform/form/bpmFormTable/assignMainTable.ht?subTableId="+subTableId;
		var winArgs="dialogWidth=400px;dialogHeight=200px;help=0;status=0;scroll=0;center=1;resizable=1";
		url=url.getNewUrl();
		var rtn=window.showModalDialog(url,"",winArgs);
	}
	
	function newTableTemp(e){		
		var url=__ctx + '/platform/form/bpmTableTemplate/edit.ht?tableId='+e;
		win= $.ligerDialog.open({ url: url, height: 400,width:600 ,isResize: false });		
	}
	function closeWin(){
		if(win){
			win.close();
		}		
	}	
	function generator(tableId) {
		$.ligerMessageBox.confirm('提示信息','将连同子表一起生成,是否继续?',function(rtn){
			if(!rtn) return;

			$.post('generateTable.ht', {'tableId': tableId}, function(data) {
				var obj=new com.cosim.form.ResultMessage(data);
				if(obj.isSuccess()){//成功
					$.ligerMessageBox.success('提示信息',"生成成功",function(){
						location.reload();
					});
				
			    }else{//失败
			    	$.ligerDialog.err('出错信息',"生成自定义表失败",obj.getMessage());
			    }
			});

		});
	}
	
	// 导出自定义表
	function ExportXml(){
		var tableId = "";
		$("input[type='checkbox'][class='pk']:checked").each(function(){ 
				var obj=$(this);
				if(obj.val()==1)
					tableId+= obj.attr('id')+",";
		
		});
		if(tableId.length==0){
			$.ligerMessageBox.warn("请选择主表进行导出!");
			return;
		}else{
			tableId=tableId.substring(0,tableId.length-1);
		}
		var url = __ctx + "/platform/form/bpmFormTable/export.ht?tableIds="+tableId;
		ImportExportXml.showModalDialog({url:url});
		
	}
	//导入自定义xml
	function ImportXml(){
		var url= __ctx + "/platform/form/bpmFormTable/import.ht";
		ImportExportXml.showModalDialog({url:url});
	}
	
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">自定义表管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link search" id="btnSearch">查询</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link add" href="edit.ht">添加</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link download" href="#" onclick="ExportXml()">导出</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link upload" href="#" onclick="ImportXml()">导入</a>
					</div>
				</div>
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht">
					<div class="row">
						<span class="label">表名:</span><input type="text"
							name="Q_tableName_SL" class="inputText"
							value="${param['Q_tableName_SL']}" /> <span class="label">描述:</span><input
							type="text" name="Q_tableDesc_SL" class="inputText"
							value="${param['Q_tableDesc_SL']}" /> <span class="label">是否主表:</span>
						<select name="Q_isMain_SN" value="${param['Q_isMain_SN']}">
							<option value="">全部</option>
							<option value="1"
								<c:if test="${param['Q_isMain_SN'] == 1}">selected</c:if>>主表</option>
							<option value="0"
								<c:if test="${param['Q_isMain_SN'] == 0}">selected</c:if>>子表</option>
						</select> <span class="label">生成方式:</span> <select name="Q_genByForm_SN"
							value="${param['Q_genByForm_SN']}">
							<option value="">全部</option>
							<option value="0"
								<c:if test="${param['Q_genByForm_SN'] == 0}">selected</c:if>>自定义表</option>
							<option value="1"
								<c:if test="${param['Q_genByForm_SN'] == 1}">selected</c:if>>由表单生成</option>

						</select>


					</div>
				</form>
			</div>
		</div>
		<div class="panel-body">



			<c:set var="checkAll">
				<input type="checkbox" id="chkall" />
			</c:set>
			<display:table name="bpmFormTableList" id="bpmFormTableItem"
				requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"
				export="false" class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;">
					<input type="checkbox" class="pk" name="tableId"
						id="${bpmFormTableItem.tableId}"
						value="${bpmFormTableItem.isMain}">
				</display:column>
				<display:column property="tableName" title="表名"
					style="text-align:left"></display:column>


				<display:column property="tableDesc" title="描述"
					style="text-align:left"></display:column>
				<display:column title="属性" style="text-align:left">
					<c:choose>
						<c:when test="${bpmFormTableItem.isMain == 1}">
								主表
							</c:when>
						<c:otherwise>
								子表
								<c:if test="${bpmFormTableItem.mainTableId == 0}">
								<a href="#"
									onclick="assignMainTable(${bpmFormTableItem.tableId})">分配主表</a>
							</c:if>
						</c:otherwise>
					</c:choose>
				</display:column>
				<display:column title="状态" style="text-align:center">
					<c:choose>
						<c:when test="${bpmFormTableItem.isPublished==0}">
							<span class="red">未生成</span>
						</c:when>
						<c:otherwise>
							<span class="green">已生成</span>
						</c:otherwise>
					</c:choose>
				</display:column>
				<display:column title="生成方式" style="text-align:left">
					<c:choose>
						<c:when test="${bpmFormTableItem.genByForm == 0}">
							<span class="red">自定义表</span>
						</c:when>
						<c:otherwise>
							<span class="green">由表单生成</span>
						</c:otherwise>
					</c:choose>
				</display:column>
				<display:column title="管理" media="html" style="text-align:left;">
					<c:choose>
						<c:when test="${bpmFormTableItem.isExternal == 0 }">

							<c:if test="${bpmFormTableItem.genByForm==0}">
								<a href="edit.ht?tableId=${bpmFormTableItem.tableId}"
									class="link edit">编辑</a>
								<f:a alias="delTable"
									href="delByTableId.ht?tableId=${bpmFormTableItem.tableId}"
									css="link del">删除</f:a>
								<c:if
									test="${bpmFormTableItem.isMain == 1  && bpmFormTableItem.isPublished==0}">
									<a href="#" class="link table"
										onclick="generator('${bpmFormTableItem.tableId}')">生成表</a>
								</c:if>
							</c:if>

						</c:when>
						<c:otherwise>
							<a href="editExt.ht?tableId=${bpmFormTableItem.tableId}"
								class="link edit">编辑</a>
							<f:a alias="delTable"
								href="delExtTableById.ht?tableId=${bpmFormTableItem.tableId}"
								css="link del">删除</f:a>
							<a href="#"
								onclick="showRelation('${bpmFormTableItem.tableId}','${bpmFormTableItem.dsName}')">表关系</a>
						</c:otherwise>
					</c:choose>
					<a href="get.ht?tableId=${bpmFormTableItem.tableId}"
						class="link detail">明细</a>
					<c:if test="${bpmFormTableItem.isPublished!=0}">
						<a
							href="editIndex.ht?tableId=${bpmFormTableItem.tableId}&tableName=${bpmFormTableItem.tableName}"
							class="link edit">索引管理</a>
					</c:if>
				</display:column>
			</display:table>
			<cosim:paging tableId="bpmFormTableItem" />

		</div>
		<!-- end of panel-body -->
	</div>
	<!-- end of panel -->
</body>
</html>


