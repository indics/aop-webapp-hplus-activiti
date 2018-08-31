<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.cosim.platform.model.system.SysParam"
    pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>用户参数自定义</title>
<%@include file="/commons/include/form.jsp" %>
<link rel="stylesheet" href="${ctx }/js/tree/v35/zTreeStyle.css" type="text/css" />
<script type="text/javascript"	src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script> 
<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.exedit-3.5.min.js"></script> 
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/ConditionExpression.js"></script>
<script type="text/javascript">
	var zTree;
	var conditionExpress;
	var _dataType;
	var args = window.dialogArguments;
	var zNodes;
	var expandByDepth = 2;
	var setting = {
		edit: {
			enable: true,
			showRemoveBtn: true,
			showRenameBtn: false,
			drag:{
				isCopy:true,
				isMove:true,
				prev:true,
				inner:true,
				next:true
			}
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeDrop: beforeDrop,
			onRemove: onTreeRemove,
			onClick: onTreeClick,
			onDrop: onTreeOnDrop
		}
	};

	function onTreeRemove(event, treeId, treeNode) {
		zTree.refresh();
		calc();
	};

	function onTreeClick(event, treeId, treeNode) {
		var type=treeNode.type;
	    switch(type){
	    	case "1":
	    		break;
	    	case "2":
	    		break;
	    	case "3":
	    		$("input[name=action][value='3']").attr("checked",true);
	    		break;
	    }
	};


	function beforeDrop(treeId, treeNodes, targetNode, moveType) {
		if(targetNode.type=='3')return false;
		if(treeNodes[0].type!='3')return false;
		return true;	
	};
	
	function onTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
	    calc();
	};

	$(function() {
		zNodes=args.cmpIds;
		var cmpIdsAry=args.cmpIds;
		var a=cmpIdsAry.lastIndexOf(',');

		if(a==cmpIdsAry.length-2){
			cmpIdsAry=cmpIdsAry.substring(0, a)+"]";
		}
 		var cmpIdsJson = jQuery.parseJSON(cmpIdsAry);

		var jsonLength = getJsonLength(cmpIdsJson);
		for(var i=0;i<jsonLength;i++){
			switch (cmpIdsJson[i].type) {
			case 1:
				cmpIdsJson[i].icon =__ctx+ "/styles/default/images/icon/or.gif";
				break;
			case 2:
				cmpIdsJson[i].icon =__ctx+"/styles/default/images/icon/and.gif";
				break;
			case 3:
				cmpIdsJson[i].icon =__ctx+"/styles/default/images/icon/code.gif";
				break;
			}
		}
		_dataType = $("#paramKey").find("option:selected").attr("title");
		$("a.save").click(function() {
			save();
		});		
		zTree = $.fn.zTree.init($("#treeCondition"), setting, cmpIdsJson);
		
		//表达式计算JS。
		conditionExpress = new com.cosim.platform.system.ConditionExpression();
		$("a.no").click(cancelSelect);
		$("#defLayout").ligerLayout({
			height : '90%'
		});
	
		$("#txtCondition").val(args.cmpNames);
		$("#valCondition").val(args.cmpIds);
	});
	
	function getJsonLength(json){
	    var len=0;
 	    if(Boolean(json)){
 	        for(var i in json) len++;
		}
	    return len;
	}
	
	function cancelSelect() {
		if (zTree) {
			zTree.cancelSelectedNode();
		}
	};

	function txtExpressionChangeHandler(e) {
			var nodes = zTree.getSelectedNodes();
			var selectNode;
			if (!nodes)
				return;
	
			selectNode = nodes[0];
			if (selectNode) {
				if (selectNode.type == "<%=SysParam.CONDITION_EXP %>"){
				selectNode.expression=this.value;
				calc();
			}
		}
	};

	function add(){
		var isRoot=$("#chkRoot").attr("checked");
		if(isRoot)
			blnChecked=true;
		var type=$("input[name=action]:checked").val();
		var dataType	=$("#paramKey").find("option:selected").attr("title");
		var paramValue	= $("#paramValue").val();
		var paramKey		=$("#paramKey").val();
		var paramCondition	=$("#paramCondition").val();
		var txt=paramKey	+	paramCondition	+	paramValue;
		var node=conditionExpress.genNode(type,txt);
		var nodes=zTree.getSelectedNodes();
		var selectNode;
		if(nodes){
			selectNode=nodes[0];
		}
		if(selectNode){
			//选中条件不是条件节点。
			if(selectNode.type!="<%=SysParam.CONDITION_EXP %>"){			
				if(node.type=="<%=SysParam.CONDITION_EXP %>" && validateVal(dataType,paramValue)){
					node.dataType=dataType;
					zTree.addNodes(selectNode, node);
				}
			}
			else{
				$.ligerMessageBox.warn('提示信息','条件表达式下不能添加条件!');
			}
		}
		else if(type=="<%=SysParam.CONDITION_EXP %>"){
			if(validateVal(dataType,paramValue)){
				node.dataType=dataType;
				zTree.addNodes(null, node);
			}		
		}else{
			zTree.addNodes(null, node);
		}	
		calc();
	};

	function calc(){
		conditionExpress.reset();
		var nodes = zTree.getNodes();
		var sb=new StringBuffer();
		sb.append("[");
		for(var i=0;i<nodes.length;i++){
			var node=nodes[i];
			conditionExpress.evaluate(node);
			if(conditionExpress.hasError) break;
			else{
				evaluateJson(node,sb);
			}
		}
		var result=conditionExpress.getResult();
		$("#txtCondition").val(result);
	
		sb.append("]");
		$("#valCondition").val(sb);
	};

	/**
	 * 构建条件表达式。
	 */
	function evaluateJson(ex,sb){	
		
		var id=ex.id;
		var pN=ex.getParentNode();
		var pId='null';
		if(pN)pId=pN.id;	
		//长度
		var childLen=0;
		if(ex.children) 
			childLen=ex.children.length;
		if(ex.type=="<%=SysParam.CONDITION_EXP %>"){
			var json='{"type":'+ex.type+',"expression":"'+ex.expression+'","dataType":"'+ex.dataType+'","id":'+id+',"pId":'+pId+',"name":"'+ex.expression+'"},';
			sb.append(json);		
		}
		else if((ex.type=="<%=SysParam.CONDITION_OR %>"|| ex.type=="<%=SysParam.CONDITION_AND %>") && childLen==0)
		{
			var json='{"type":'+ex.type+',"typeName":"'+ex.typeName+'","id":'+id+',"pId":'+pId+',"name":"'+ex.typeName+'"},';
			sb.append(json);
		}else if((ex.type=="<%=SysParam.CONDITION_OR %>" || ex.type=="<%=SysParam.CONDITION_AND %>") && childLen>0){
			var json='{"type":'+ex.type+',"typeName":"'+ex.typeName+'","children":['+evaluateChildJson(ex.children)+'],"id":'+id+',"pId":'+pId+',"name":"'+ex.typeName+'"},';
			sb.append(json);
		}
	};

	function evaluateChildJson(children){
		var len=children.length;
		var sb=new StringBuffer();
		for(var i=0;i<len;i++){
			var  ex=children[i];
			var id=ex.id;
			var pN=ex.getParentNode();
			var pId='null';
			if(pN)pId=pN.id;
			var json='{"type":'+ex.type+',"expression":"'+ex.expression+'","dataType":"'+ex.dataType+'","id":'+id+',"pId":'+pId+',"name":"'+ex.expression+'"},';
			sb.append(json);
		}
		sb=sb.toString();
		if(sb.length>0)sb=sb.substring(0,(sb.length-1));
		return sb;
	};

	function changeCondition() {
		if (_dataType == $("#paramKey").find("option:selected").attr("title"))
			return;
		_dataType = $("#paramKey").find("option:selected").attr("title");
		if (_dataType.length > 0) {
			$("#paramCondition option").remove();
			$("#paramCondition").append("<option value='='>=</option>");
			$("#paramCondition").append("<option value='!='>!=</option>");
			if (_dataType == "String") {
				$("#paramCondition").append(
						"<option value=' like '>like</option>");
			} else {
				$("#paramCondition").append("<option value='>'>></option>");
				$("#paramCondition").append("<option value='<'><</option>");
				$("#paramCondition").append("<option value='>='>>=</option>");
				$("#paramCondition").append("<option value='<='><=</option>");
			}
		}
	};

	function validateVal(dataType, paramValue) {
		changeCondition();
		var yes = true;
		if (paramValue == "") {
			if ($("#paramValue").next().html() == null
					|| $("#paramValue").next().html() == '')
				$("#paramValue").after('<font color="red">条件不能为空。</font>');
			yes = false;
		}
		if (dataType == "Integer") {
			if (isNaN(paramValue)) {
				$("#paramValue").addClass("error");
				if ($("#paramValue").next().html() == null
						|| $("#paramValue").next().html() == '')
					$("#paramValue").after('<font color="red">请输入数字。</font>');
				yes = false;
			}
		} else if (dataType == "Date") {
			var pattern = /^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s(((0?[0-9])|([1-2][0-3]))\:([0-5]?[0-9])((\s)|(\:([0-5]?[0-9])))))?$/;
			if (!pattern.exec(paramValue)) {
				$("#paramValue").addClass("error");
				if ($("#paramValue").next().html() == null
						|| $("#paramValue").next().html() == '')
					$("#paramValue").after('<font color="red">请输入日期。</font>');
				yes = false;
			}
		}
		if (yes) {
			$("#paramValue").removeClass("error");
	
			if ($("#paramValue").next().html() != null)
				$("#paramValue").next().empty();
		}
		return yes;
	};

	function selectParam() {
		window.returnValue = {
			paramValue1 : $("#valCondition").val(),
			paramValue2 : $("#txtCondition").val()
		};
		window.close();
	};
	
	function preview() {
		if (conditionExpress.hasError) {
			$.ligerMessageBox.warn('提示信息', '条件表达式有错误');
			return;
		}
		var userParam = $("#valCondition").val();
		var winArgs = "dialogWidth=650px;dialogHeight=500px;help=0;status=0;scroll=0;center=1";
		var url = __ctx + '/platform/system/sysUserParam/getByParamKey.ht';
		url=url.getNewUrl();
		var obj={flag:0,params:userParam,url:url};
		window.showModalDialog(url,obj, winArgs);
	};
</script>
</head>
<body>
<div id="defLayout">
	<div position="center">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">构造条件</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
				
					<div class="group"><a onclick="add();" class="link add">添加</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a onclick="cancelSelect();" class="link no">取消选中</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a onclick="preview();" class="link preview">预览</a></div>
				</div>	
			</div>
		</div>
		<div class="panel-body">
			<div class="panel-detail">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="35%">条件:</th>
						<td>			
							<input type="radio" value="<%=SysParam.CONDITION_AND %>"  name="action" checked="checked" />并&nbsp;
							<input type="radio" value="<%=SysParam.CONDITION_OR %>"  name="action"/>或
						</td>
					</tr>
					<tr>
						<th>表达式:</th>
						<td>
							<input type="radio" value="<%=SysParam.CONDITION_EXP %>"  name="action"/> 
							<select id="paramKey" onchange="validateVal();">
								<c:forEach items="${sysParamList}" var="p" >
									<option title="${p.dataType }" value="${p.paramKey }" >${p.paramName }</option>
								</c:forEach>
							</select>			
							
							<select id="paramCondition" >
								<option value="=">=</option>
								<option value="!=">!=</option>
								<option value=">">></option>
								<option value="<"><</option>
								<option value=">=">>=</option>
								<option value="<="><=</option>
							</select>
							
							<input type="text" id="paramValue" onchange="validateVal()"/>
							
						</td>
					</tr>
					
					<tr height="100px">
						<th>条件树:</th>
						<td  valign="top">
							<ul id="treeCondition" class="ztree" style="height:150px;overflow: auto;"></ul>
						</td>
					</tr>
					<tr height="100px">
						<th>条件:</th>
						<td  valign="top">
							<textarea rows="6" cols="75" id="txtCondition"></textarea>
							<textarea style="display: none;" rows="6" cols="75" id="valCondition"></textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>

<div position="bottom"  class="bottom" style='margin-top:10px'>
		&nbsp;&nbsp;<a href='#' class='button'  onclick="selectParam()" ><span class="icon ok"></span><span >选择</span></a>
		&nbsp;&nbsp;<a href='#' class='button'  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
</div>
</body>
</html>