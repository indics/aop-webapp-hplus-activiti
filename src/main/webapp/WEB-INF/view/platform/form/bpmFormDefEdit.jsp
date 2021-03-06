
<%--
	time:2011-11-16 16:34:16
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>编辑自定义表单</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/form.jsp"%>
<link rel="stylesheet" href="${ctx }/js/tree/v35/zTreeStyle.css" type="text/css" />
<link rel="stylesheet" href="${ctx }/styles/default/css/tab/tab.css" type="text/css" />
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerLayout.js"></script>
<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=bpmFormDef"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/Permission.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/FormDef.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/PageTab.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/FormContainer.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
<!-- ueditor -->
<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/editor_api.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/js/ueditor/themes/default/ueditor.css"/>
<style type="text/css">

</style>
<script type="text/javascript">
	var tabTitle="${bpmFormDef.tabTitle}";
	var formKey=${bpmFormDef.formKey};
	var tableId=${bpmFormDef.tableId};
	var __Permission__;
	var tab;
	
	function showRequest(formData, jqForm, options) {
		return true;
	}
	
	
	
	$(function() {
		//权限处理
		__Permission__=new Permission();
		__Permission__.loadPermission(tableId,formKey);
		//验证代码
		valid(showRequest, showResponse);		
		$("a.save").click(save);		
		
		$("#frmDefLayout").ligerLayout({leftWidth : 200,height:height,onHeightChanged:function(layoutHeight, diffHeight, middleHeight){
			
		}});
		var height = $(".l-layout-center").height();
        $("#colstree").height(height-120);
        $("#tabPermission").height(height-30);
        
     	$("#tab").ligerTab({height: $("#frmDefLayout").height(),onBeforeSelectTabItem:function(tabId){
			if(tabId=='tabitem2'){
				syncOpinion();
			}
		}});
		
		tab = $("#tab").ligerGetTabManager();
		FormDef.getEditor();
		editor.addListener('ready',function(){
			initTab();
		});
		//ueditor渲染textarea
		editor.render("html");
		editor.tableId = tableId;
		//获取字段显示到左边的字段树中
		getAllFields();
		$("#btnPreView").click(function(){
			preview();
		});
		$("input[name='rdoPermission']").click(setPermision);
		
   		window.onbeforeunload = function() {				 											
   		  return '你确定吗？';
   	 	};
	});
	
	//预览
	function preview(){
		saveChange();
		var objForm = formContainer.getResult();
		var frm=new com.cosim.form.Form();
		frm.creatForm("bpmPreview",__ctx+"/platform/form/bpmFormHandler/edit.ht");
		frm.addFormEl("name",$("#subject").val());
		frm.addFormEl("title",objForm.title);
		frm.addFormEl("html",objForm.form);
		frm.addFormEl("comment",$("#formDesc").val());
		frm.setTarget("_blank");
		frm.setMethod("post");
		frm.submit();
		frm.clearFormEl();
	};
	
	//批量设置权限。
	function setPermision(){
		var val=$(this).val();
		var obj=$(this).closest("[name=tableContainer]");
		switch(val){
			//hidden
			case "1":
				$(".r_select,.w_select",obj).val("none");
				break;
			//readonly
			case "2":
				$(".r_select",obj).val("everyone");
				$(".w_select",obj).val("none");
				break;
			//edit
			case "3":
				$(".r_select",obj).val("everyone");
				$(".w_select",obj).val("everyone");
				break;
		}
	}

	//同步权限设置中的意见列表
	function syncOpinion() {
		var editorBody = editor.getBody();
		var opinions = $(editorBody).find("[name^='opinion:']");
		__Permission__.syncOpinion(opinions);
	};
	//保存表单数据。
	function save() {
		if (editor.ifSourceMode() == 1) {
			$.ligerMessageBox.warn('提示信息', '不能在源代码模式下保存表单');
			return;
		}
		saveChange();
		var rtn = $("#bpmFormDefForm").valid();
		if (!rtn)
			return;
		syncOpinion();
		var data = {};
		var arr = $('#bpmFormDefForm').serializeArray();
		$.each(arr, function(i, d) {
			data[d.name] = d.value;
		});

		//保存当前tab的数据。
		var idx = tabControl.getCurrentIndex() - 1;
		saveTabChange(idx);
		var objForm = formContainer.getResult();

		data['tabTitle'] = objForm.title;
		
		data['html'] = objForm.form;
		
        while(data['html'].indexOf('？')!=-1){
        	data['html']=data['html'].replace('？','');
       }
		$.post('save.ht', {
			data : JSON.stringify(data),
			permission : __Permission__.getPermissionJson(),
			tableName : $('#tableName').val()
		}, FormDef.showResponse);
	}

	function getAllFields() {
		FormDef.getFieldsByTableId(tableId);
	}

	//tab控件
	var tabControl;
	//存储数据控件。
	var formContainer;
	//添加tab页面
	function addCallBack() {
		var curPage = tabControl.getCurrentIndex();
		var str = "新页面";
		var idx = curPage - 1;
		formContainer.insertForm(str, "", idx);
		saveTabChange(idx-1,idx);		
	}
	//切换tab之前，返回false即中止切换
	function beforeActive(prePage) {
		if (editor.ifSourceMode()) {
			$.ligerMessageBox.warn('提示信息', '不能在源代码模式下切换页面');
			return 0;
		}
		return 1;
	}
	//点击激活tab时执行。
	function activeCallBack(prePage, currentPage) {
		if (prePage == currentPage)
			return;
		//保存上一个数据。
		saveTabChange(prePage - 1, currentPage - 1);
	}
	//根据索引设置数据
	function setDataByIndex(idx) {
		if (idx == undefined)
			return;
		var obj = formContainer.getForm(idx);
		editor.setContent(obj.form);
		$("b", tabControl.currentTab).text(obj.title);
	}
	//在删除页面之前的事件，返回false即中止删除操作
	function beforeDell(curPage) {
		if (editor.ifSourceMode() == 1) {
			$.ligerMessageBox.warn('提示信息', '不能在源代码模式下删除页面');
			return 0;
		}
		return 1;
	}
	//点击删除时回调执行。
	function delCallBack(curPage) {
		formContainer.removeForm(curPage - 1);
		var tabPage = tabControl.getCurrentIndex();
		setDataByIndex(tabPage - 1);
	}
	//文本返回
	function txtCallBack() {
		var curPage = tabControl.getCurrentIndex();
		var idx = curPage - 1;
		var title = tabControl.currentTab.text();
		//设置标题
		formContainer.setFormTitle(title, idx);
	}
	//tab切换时保存数据
	function saveTabChange(index, curIndex){
		var data = editor.getContent();
		formContainer.setFormHtml(data, index);
		setDataByIndex(curIndex);
	}
	//表单或者标题发生变化是保存数据。
	function saveChange() {
		var index = tabControl.getCurrentIndex() - 1;
		var title = tabControl.currentTab.text();
		var data = editor.getContent();
		formContainer.setForm(title, data, index);
	}
	//初始化TAB
	function initTab() {
		var formData = editor.getContent();
		if (tabTitle == "")
			tabTitle = "页面1";
		formContainer = new FormContainer();
		var aryTitle = tabTitle.split(formContainer.splitor);
		var aryForm = formData.split(formContainer.splitor);
		var aryLen = aryTitle.length;
		//初始化
		formContainer.init(tabTitle, formData);

		tabControl = new PageTab("pageTabContainer", aryLen, {
			addCallBack : addCallBack,
			beforeActive : beforeActive,
			activeCallBack : activeCallBack,
			beforeDell : beforeDell,
			delCallBack : delCallBack,
			txtCallBack : txtCallBack
		});
		tabControl.init(aryTitle);
		if (aryLen > 1) {
			editor.setContent(aryForm[0]);
		};		
	};
</script>
</head>
<body style="overflow:hidden">
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">在线表单编辑</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group">
					<a class="link save" id="dataFormSave" href="#">保存</a>
				</div>
				<div class="l-bar-separator"></div>
				<div class="group">
					<a class="link preview" id="btnPreView" href="javascript:;">预览</a>
				</div>
				<div class="group">
					<a class="link  del" href="javascript:window.onbeforeunload = null;window.close()">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<div  class="panel-body">
		<form id="bpmFormDefForm" method="post">
			<input id="formDefId" type="hidden" name="formDefId" value="${bpmFormDef.formDefId}" /> 
			<input id="tableId" type="hidden" name="tableId" value="${bpmFormDef.tableId}" />
			<input id="categoryId" type="hidden" name="categoryId" value="${bpmFormDef.categoryId}" /> 
			<input  type="hidden" name="formKey" value="${bpmFormDef.formKey}" /> 
			<input  type="hidden" name="isDefault" value="${bpmFormDef.isDefault}" /> 
			<input  type="hidden" name="versionNo" value="${bpmFormDef.versionNo}" /> 
			<input  type="hidden" name="isPublished" value="${bpmFormDef.isPublished}" /> 
			<input  type="hidden" name="publishedBy" value="${bpmFormDef.publishedBy}" /> 
			<input  type="hidden" name="publishTime" value="<fmt:formatDate value="${bpmFormDef.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" /> 
			<input  type="hidden" id="templatesId" name="templatesId" value="${bpmFormDef.templatesId}"/> 
			<div class="panel-nav">
				<table cellpadding="0" cellspacing="0" border="0"  class="table-detail">
					<tr>
						<th width="80">表单标题:&nbsp;</th>
						<td style="padding:4px;"><input id="subject" type="text" name="subject" value="${bpmFormDef.subject}" class="inputText" style="width:86%" /></td>
						<th width="80">描述:&nbsp;</th>
						<td style="padding:4px;"><input id="formDesc" type="text" name="formDesc" value="${bpmFormDef.formDesc}" class="inputText" style="width:86%"/></td>
					</tr>
				</table>
			</div>
		</form>
		<div id="tab" class="panel-nav">
			
			<div title="表单编辑">
				<div id="frmDefLayout">
					<div position="left" title="表字段" style="overflow: auto;">
						<div class="panel-toolbar tree-title">
							<span class="toolBar">
								<div class="group">
									<a class="link reload" onclick="getAllFields()">刷新</a>
								</div>
							</span>
						</div>
						<ul id="colstree" class="ztree"></ul>
					</div>
					<div id="editor" position="center"  style="overflow:auto;height:100%;">
						<textarea id="html" name="html">${fn:escapeXml(bpmFormDef.html) }</textarea>
						<div id="pageTabContainer"></div>
					</div>
				</div>
			</div>
			<div title="权限设置"   >
				<div id="tabPermission" style="overflow:auto;">
						<table cellpadding="1" cellspacing="1" style="margin-top: 2px;" class="table-grid" name="tableContainer">
							
							<tr>
								<th width="20%">字段</th>
								<th width="40%">只读权限</th>
								<th width="40%">编辑权限</th>
							</tr>
							<tr>
								<td colspan="3">
									<input type="radio" value="1" name="rdoPermission" id="fieldHidden" ><label for="fieldHidden">隐藏</label>
									<input type="radio" value="2" name="rdoPermission" id="fieldReadonly"><label for="fieldReadonly">只读</label>
									<input type="radio" value="3" name="rdoPermission" id="fieldEdit" ><label for="fieldEdit">编辑</label>
								</td>
							</tr>
							<tbody id="fieldPermission"></tbody>
						</table>
						<br />
						<table  cellpadding="1" cellspacing="1" class="table-grid" name="tableContainer">
							<tr>
								<th width="20%">子表</th>
								<th width="40%">只读权限</th>
								<th width="40%">编辑权限</th>
							</tr>
							<tr>
								<td colspan="3">
									<input type="radio" value="1" name="rdoPermission" id="tableHidden" ><label for="tableHidden">隐藏</label>
									<input type="radio" value="2" name="rdoPermission" id="tableReadonly"><label for="tableReadonly">只读</label>
									<input type="radio" value="3" name="rdoPermission" id="tableEdit" ><label for="tableEdit">编辑</label>
								</td>
							</tr>
							<tbody id="tablePermission"></tbody>
						</table>
						<br />
						<table  cellpadding="1" cellspacing="1" class="table-grid" name="tableContainer">
							<tr>
								<th width="20%">意见</th>
								<th width="40%">只读权限</th>
								<th width="40%">编辑权限</th>
							</tr>
							<tr>
								<td colspan="3">
									<input type="radio" value="1" name="rdoPermission" id="opinionHidden" ><label for="opinionHidden">隐藏</label>
									<input type="radio" value="2" name="rdoPermission" id="opinionReadonly"><label for="opinionReadonly">只读</label>
									<input type="radio" value="3" name="rdoPermission" id="opinionEdit" ><label for="opinionEdit">编辑</label>
								</td>
							</tr>
							<tbody id="opinionPermission" ></tbody>
						</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

