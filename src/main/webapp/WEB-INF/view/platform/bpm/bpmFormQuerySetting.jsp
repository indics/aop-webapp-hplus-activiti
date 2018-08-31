<%--
	time:2012-06-25 11:05:09
	desc:edit the 通用表单对话框
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 通用表单查询</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<%@include file="/commons/include/get.jsp" %>		
	<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript"src="${ctx}/js/cosim/platform/system/ScriptDialog.js"></script>
	<script type="text/javascript">
		$(function() {
				$("#defLayout").ligerLayout({ leftWidth: 270,height: '100%',
				bottomHeight:50,allowLeftCollapse:false,rightWidth:465,allowRightResize:false,centerWidth:20,
			 	allowBottomResize:false,allowRightCollapse:false});
				
				init();	
		});
		
		function init(){
			$("input.treeField").focus(function(){
				curField=$(this);
			});
			var fields = window.dialogArguments;	
			if(fields.displayField)initDisplayField(fields.displayField);
			if(fields.conditionField)initConditionField(fields.conditionField);
			if(fields.resultField)initResultField(fields.resultField);
		}
		//未保存的自定义对话框，在已经设置列以后再次打开设置列的窗口时 初始化已设置的列
		function initDisplayField(displayField){
			var fieldObj=eval("("+displayField+")"),
				objContainer=$("#trDisplayField");
			objContainer.empty();
			for(var i=0,c;c=fieldObj[i++];){
				objContainer.append(getDispalyField(c.field,c.comment));
			}
		};
		
		//初始化条件字段
		function initConditionField(conditionField){
			var fieldObj=eval("("+conditionField+")"),
				objContainer=$("#trConditionField");
			objContainer.empty();
			for(var i=0,c;c=fieldObj[i++];){
				objContainer.append(getConditionField(c.field,c.comment,c.dbType));
				var curTr = $("#condition"+c.field),
					curValTr = $("#conditionVal"+c.field);
				$("select.condition",curTr).val(c.condition);
				$("select[name='changeDefalut']",curValTr).val(c.defaultType);
				changeDefault($("select[name='changeDefalut']",curValTr));
				$("textarea[name='defaultValue']",curValTr).val(c.defaultValue);
			}
		};
		
		//初始化返回字段
		function initResultField(resultField){
			var fieldObj=eval("("+resultField+")"),
				objContainer=$("#trRtnField");
			objContainer.empty();
			if(!fieldObj)return;
			for(var i=0,c;c=fieldObj[i++];){
				objContainer.append(getRtnField(c.field,c.comment));
			}
		};
		
		var curField;
		/*
		 *左边字段选择
		 */
		function selectTreeField(){   
			var obj=$("input:checkbox[name='fieldName']:checked");
			if(curField==null || curField.length==0){
				$.ligerMessageBox.error('提示信息',"请选择右边的输入框!");
				return;
			}
			if(obj.length==0){
				$.ligerMessageBox.error('提示信息',"请选择左边的字段!");
				return;
			}
			if(obj.length>1){
				$.ligerMessageBox.error('提示信息',"只能选择一个左边的字段!");
				return;
			}
			curField.val(obj.val());

		}		
		
		function delRow(obj){
			$(obj).closest("tr").remove();
			
		}
		
		function delConditionTr(obj){
			var tr=$(obj).closest("tr");
			tr.next().remove().end().remove();
		}		
		
		function getConditionField(fieldName,comment,dbType){
			var db=getConditionSelect(dbType,fieldName,comment);
			var sb=new StringBuffer();
			sb.append("<tr class='trCondition' id='condition"+ fieldName +"'>");
			sb.append("<td >"+fieldName+"</td>");
			sb.append("<td >"+db+"</td>");
			sb.append("<td >"+comment+"</td>");
			sb.append("<td><a alt='上移' href='#' class='link moveup' onclick='sortConditionTr(this,true)'></a>");
			sb.append("<a alt='下移' href='#' class='link movedown' onclick='sortConditionTr(this,false)'></a>");
			sb.append("<a href='#' class='link del'  onclick='delConditionTr(this)' >删除</a></td>");
			sb.append("</tr>");
			sb.append("<tr id='conditionVal"+ fieldName +"'>");
			sb.append("<td>默认值</td>");
			sb.append("<td><select name='changeDefalut' onchange='changeDefault(this)'>");
			sb.append("<option value='1'>参数传入</option>");
			sb.append("<option value='2'>固定值</option><option value='3'>脚本</option></select></td>");
			sb.append("<td colspan='2'><a style='display:none;' href='#' name='btnScript' class='link var' title='常用脚本' onclick='selectScript(this)'>常用脚本</a>");
			sb.append("<textarea name='defaultValue' cols='40' rows='3' ");
			sb.append("		style='display:none;' ");
			sb.append("></textarea></td>");
			sb.append("</tr>");
			return sb.toString();
		}
		
		function selectScript(obj) {
			var linkObj=$(obj);
			var txtObj=linkObj.next()[0];
			ScriptDialog({
				callback : function(script) {
					$.insertText(txtObj,script);
				}
			});
		};
		
		function changeDefault(obj){
			var val=$(obj).val();
			var objTr=$(obj).parents("tr");
			var txtObj=$("textarea[name='defaultValue']",objTr);
			var linkObj=$("a[name='btnScript']",objTr);
			switch(val){
				case "1":
					txtObj.hide();
					linkObj.hide();
					break;
				case "2":
					txtObj.show();
					linkObj.hide();
					break;
				case "3":
					txtObj.show();
					linkObj.show();
					break;
			}
		}
			
		function getRtnField(fieldName,comment){
			var sb=new StringBuffer();
			sb.append("<tr id='rtn"+ fieldName +"' name='"+fieldName+"' comment='"+comment+"' >");
			sb.append("<td >"+fieldName+"</td>");
			sb.append("<td >"+comment+"</td>");
			sb.append("<td><a alt='上移' href='#' class='link moveup' onclick='sortTr(this,true)'>&nbsp;&nbsp;</a>");
			sb.append("<a alt='下移' href='#' class='link movedown' onclick='sortTr(this,false)'>&nbsp;&nbsp;</a>");
			sb.append("<a href='#' class='link del' onclick='delRow(this)' >删除</a></td>");
			sb.append("</tr>");
			return sb.toString();
		}
		
		function getConditionSelect(dbType,name,comment){
			var sb=new StringBuffer();
			sb.append("<select class='condition' name='"+name+"' dbType='"+dbType+"' comment='"+comment+"'>");
			switch(dbType){
				case "varchar":
					sb.append("<option value='='>等于</option>");
					sb.append("<option value='like'>LIKE</option>");
					sb.append("<option value='likeEnd'>LIKEEND</option>");
					break;
				case "number":
					sb.append("<option value='='>等于</option>");
					sb.append("<option value='>='>大于等于</option>");
					sb.append("<option value='>'>大于</option>");
					sb.append("<option value='<'>小于</option>");
					sb.append("<option value='<='>小于等于</option>");
					break;
				case "date":
					sb.append("<option value='='>等于</option>");
					sb.append("<option value='between'>Between</option>");
					sb.append("<option value='>='>大于等于</option>");
					sb.append("<option value='<='>小于等于</option>");
					
					break;
				
			}
			
			sb.append("</select>");
			return sb;
		}
		
		
		function setConditionField(isList){
			var objContainer=$("#trConditionField");
			$("input[name='fieldName']:checked").each(function(){
				var trObj=$(this).closest("tr");	
				var fieldName=$(this).val();  //id
				var comment=$("input[name='comment']",trObj).val();
				var dbType=$(this).attr("dbType");
				var tr=getConditionField(fieldName,comment,dbType,isList);
				objContainer.append(tr);
				
			});
		}
		
		function setReturnField(){
			var objContainer=$("#trRtnField");
			$("input:checkbox[name='fieldName']:checked").each(function(){
				var trObj=$(this).closest("tr");	
				var fieldName=$(this).val();  //id
				var comment=$("input[name='comment']",trObj).val();
				var obj=$("#rtn" + fieldName);
				if(obj.length==0){
					var tr=getRtnField(fieldName,comment);
					objContainer.append(tr);
				}
			});
		}
		
		var displayStr="";
		var conditionStr="";
		var rtnStr="";		
		
		function buildTreeJson(){
			var aryRtnField=[];
			var  rtn="";
			var treeId=$("#treeId").val();
			var parentId=$("#parentId").val();
			var displayName=$("#displayName").val();
			
			if(treeId=="" || parentId=="" || displayName==""){
				rtn+="请填写映射树的字段\r\n";
			}
			
			displayStr="{id:'"+treeId+"',pid:'"+parentId+"',displayName:'"+displayName+"'}";
			var result=getCondition();
			if(!result){
				rtn+="请填写条件字段的值\r\n";
			}
			//条件字段
			$("#trRtnField").children().each(function(){
				var fieldName=$(this).attr("name");
				var comment=$(this).attr("comment");
				var obj={};
				obj.field=fieldName;
				obj.comment=comment;
				aryRtnField.push(obj);
			});
			
			if(aryRtnField.length==0){
				rtn+="请选择返回字段";
			}
			rtnStr=JSON.stringify(aryRtnField);
			
			return rtn;
		}
		
		//获取选择的条件。
		function getCondition(){
			var aryContion=[];
			var rtn=true;
			$("#trConditionField").children("tr.trCondition").each(function(){
				var trObj=$(this);
				var trDefault=trObj.next();
				var selObj=$('select.condition',trObj);
				var fieldName=selObj.attr("name");
				var comment=selObj.attr("comment");
				var condition=selObj.attr("value");
				var dbType=selObj.attr("dbType");
				var obj={};
				obj.field=fieldName;
				obj.comment=comment;
				obj.condition=condition;
				obj.dbType=dbType;
				
				var selDefault=$("select[name='changeDefalut']",trDefault).val();
				var txtDefault=$("textarea[name='defaultValue']",trDefault).val();
				if(selDefault!="1" && txtDefault.trim()==""){
					rtn=false;
				}
				obj.defaultType=selDefault;
				if(selDefault=="1"){
					obj.defaultValue="";
				}
				else{
					obj.defaultValue=txtDefault;
				}
				aryContion.push(obj);
			});
			conditionStr=JSON.stringify(aryContion);
			return rtn;
		}
		
		function buildListJson(){
			var rtn="";
			var aryDisplay=[];
			
			var aryRtnField=[];
			
			var result=getCondition();
			if(!result){
				rtn+="请填写条件字段的值\r\n";
			}
			
			$("#trRtnField").children().each(function(){
				var fieldName=$(this).attr("name");
				var comment=$(this).attr("comment");
				var obj={};
				obj.field=fieldName;
				obj.comment=comment;
				aryRtnField.push(obj);
			});
			
			if(aryRtnField.length==0){
				rtn+="请选择返回字段";
			}
			
			displayStr=JSON.stringify(aryDisplay);
			rtnStr=JSON.stringify(aryRtnField);
			
			return rtn;
			
		}
		
	    function selectForm(){
	    	var rtn="";
			//如果是树状的只取不大于3个的返回值				
			if($("input.treeField").length>0) {
				rtn=buildTreeJson();
			}
			else{
				rtn=buildListJson();
			}
			if(rtn!=""){
				$.ligerMessageBox.warn('提示信息',rtn);
				return;
			}
			var rerurnlist= new Array(displayStr,conditionStr,rtnStr); 
			//如果打开了弹出窗口
	    	if(window.parent.document.getElementById("dialog-body")){
	    		window.parent.rtn = rerurnlist;//将要返回的数据赋值给父窗口的rtn变量
	        	window.parent.isDialogHTML5Close = true;//弹出窗口已经关闭
	        	closeDialogHTML5(); 	
	        	return;
	    	}
			window.returnValue=rerurnlist;
	    	window.close();
			
	    }
	    
		function sortTr(obj,isUp) {
			var thisTr = $(obj).parents("tr");
			if(isUp){
				var prevTr = $(thisTr).prev();
				if(prevTr){
					thisTr.insertBefore(prevTr);
				}
			}
			else{
				var nextTr = $(thisTr).next();
				if(nextTr){
					thisTr.insertAfter(nextTr);
				}
			}
		};
	    
		function sortConditionTr(obj,isUp) {
			var thisTr = $(obj).closest("tr");
			var nextTr=thisTr.next();
			
			//向上
			if(isUp){
				var prevTr = thisTr.prev();
				if(prevTr.length==0) return;
				var targeTr=prevTr.prev();
				thisTr.insertBefore(targeTr)
				nextTr.insertBefore(targeTr);
			}
			else{
				var tmpTr =nextTr.next();
				if(tmpTr.length==0) return;
				var targeTr=tmpTr.next();
				nextTr.insertAfter(targeTr);
				thisTr.insertAfter(targeTr);
			}
		};
	
	    
	</script>
	<style type="text/css">
		body{ padding:2px; margin:0 0 0 0;overflow: hidden; }
		div.fieldContainer{border:1px solid #BED5F3;margin-top: 3px;height:143px;}
		div.content{height:110px;overflow: auto;}
		ul.btnContainer{text-align: center;margin-top: 60px;}
		li.btn{margin-top: 3px;height:143px;line-height:143px; }
		li.btnTree{margin-top: 3px;height:40px;line-height:40px; }
	</style>
	
</head>
<body>
		<div id="defLayout" >
	            <div position="left" title="获取字段列表" style="overflow: scroll;width: 270px;height:450px;">
					<table cellpadding="1" class="table-grid table-list" cellspacing="1">
						<tr>
							<th></th>
							<th>字段</th>
							<th>注释</th>
						</tr>
						<c:forEach var="col" items="${tableModel.columnList }" varStatus="status">
						<c:set var="clsName"  ><c:choose><c:when test="${status.index%2==0}">odd</c:when><c:otherwise>even</c:otherwise></c:choose> </c:set>
						<tr class="${clsName}">
							<td>
								<c:choose>
	            					<c:when test="${style==0 }">
										<input type="checkbox" name="fieldName"  class="pk"  value="${col.name }"  dbType="${col.columnType }">
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="fieldName" class="pk"  value="${col.name }" id="${col.name }" dbType="${col.columnType }">
									</c:otherwise>
								</c:choose>
							</td>
							<td nowrap="nowrap">
								${col.name }
							</td>
							<td>
								<input type="text" name="comment" class="inputText" value="${col.comment }">
							</td>
						</tr>
						</c:forEach>
					</table>
	            </div>
	            <div position="center" >
           			<ul class="btnContainer">
	          			<li class="btnTree" style="margin-top:120px;">
	          				 <a href='#' class='button'  onclick="setConditionField(false)" ><span >==></span></a>
	          			</li>
	          			<li class="btnTree" style="margin-top:140px;">
	          				<a href='#' class='button'  onclick="setReturnField()" ><span >==></span></a>
	          			</li>
	          		</ul>
	            </div>  
	            <div id="fieldSetting" position="right"  title="字段设置">
					<div class="panel-detail">
	          			<div class="header" style="margin-top:5px;">
	          				条件字段
	          			</div>
	          			<div class="content" style="height:210px;">
	          			<table cellpadding="1" class="table-grid table-list" cellspacing="1">
	          				<tr>
	          					<th>
	          						字段名
	          					</th>
	          					<th>
	          						条件
	          					</th>
	          					
	          					<th>
	          						显示名
	          					</th>
	          					<th>
	          						管理
	          					</th>
	          				</tr>
	          				<tbody id="trConditionField">
	          					<c:forEach items="${ bpmFormDialog.conditionList}" var="field">
	          						<tr class='trCondition' id='condition${field.fieldName}' name='${field.fieldName}' comment='${field.comment}'>
	          							<td>${field.fieldName}</td>
	          							<td>
	          								<select class='condition' name='${field.fieldName}' dbType='${field.fieldType}' comment='${field.comment}' >
	          								<c:choose>
	          									<c:when test="${field.fieldType=='varchar'}">
		          									<option value='=' <c:if test="${field.condition=='='}">selected</c:if> >等于</option>
													<option value='like' <c:if test="${field.condition=='like'}">selected</c:if>>LIKE</option>
													<option value='likeEnd' <c:if test="${field.condition=='likeEnd'}">selected</c:if>>LIKEEND</option>
	          									</c:when>
	          									<c:when test="${field.fieldType=='number'}">
	          										<option value='=' <c:if test="${field.condition=='='}">selected</c:if>>等于</option>
													<option value='>=' <c:if test="${field.condition=='>='}">selected</c:if> >大于等于</option>
													<option value='>' <c:if test="${field.condition=='>'}">selected</c:if> >大于</option>
													<option value='<' <c:if test="${field.condition=='<'}">selected</c:if> >小于</option>
													<option value='<=' <c:if test="${field.condition=='<='}">selected</c:if>>小于等于</option>
	          									</c:when>
	          									<c:otherwise>
	          										<option value='=' <c:if test="${field.condition=='='}">selected</c:if>>等于</option>
													<option value='between' <c:if test="${field.condition=='between'}">selected</c:if> >between</option>
													<option value='>=' <c:if test="${field.condition=='>='}">selected</c:if> >大于等于</option>
													<option value='<=' <c:if test="${field.condition=='<='}">selected</c:if> >小于等于</option>
	          									</c:otherwise>
	          								</c:choose>
	          								</select>
										</td>
										<td>${field.comment}</td>
	          							
	          							<td>
	          							<a alt='上移' href='#' class='link moveup' onclick='sortConditionTr(this,true)'></a>
	          							<a alt='下移' href='#' class='link movedown' onclick='sortConditionTr(this,false)'></a>
	          							<a href='#' class='link del'  onclick='delConditionTr(this)' >删除</a>
	          							</td>
	          						</tr>
	          					

	          						<tr id='conditionVal${field.fieldName}'>
	          							<td>默认值</td>
	          							<td>
	          								<select name='changeDefalut' onchange='changeDefault(this)'>
	          									<option value="2" <c:if test="${field.defaultType=='2'}">selected</c:if>>固定值</option>
	          									<option value="3" <c:if test="${field.defaultType=='3'}">selected</c:if>>脚本</option>
	          								</select>
	          							</td>
	          							<td colspan="2">
	          							<a <c:if test="${ field.defaultType=='2'}">style='display:none;'</c:if>  href='#' name='btnScript' 
	          							class='link var' title='常用脚本' onclick='selectScript(this)'>常用脚本</a>
	          							<textarea name='defaultValue' cols='40' rows='3' >${field.defaultValue}</textarea></td>
	          						</tr>
	          					</c:forEach>
	          				</tbody>
	          			</table>
          			</div>
	          		</div>
	          		<div class="panel-detail">
	          			<div class="header">
	          				返回字段
	          			</div>
	          			<div style="height: 180px;overflow: auto;">
		          			<table cellpadding="1" class="table-grid table-list" cellspacing="1">
		          				<tr>
		          					<th>
		          						字段名
		          					</th>
		          					<th>
		          						显示名
		          					</th>
		          					<th>
		          						管理
		          					</th>
		          				</tr>
		          				<tbody id="trRtnField">
		          					<c:forEach items="${ bpmFormDialog.returnList}" var="field">
		          						<tr id='rtn${field.fieldName}' name='${field.fieldName}' comment='${field.comment}'>
		          							<td>${field.fieldName}</td>
		          							<td>${field.comment}</td>
		          							<td>
		          							<a alt='上移' href='#' class='link moveup' onclick='sortTr(this,true)'>&nbsp;</a>
		          							<a alt='下移' href='#' class='link movedown' onclick='sortTr(this,true)'>&nbsp;</a>
		          							<a href='#' class='link del'  onclick='delRow(this)' >删除</a>
		          							</td>
		          						</tr>
		          					</c:forEach>
		          				</tbody>
		          			</table>
		          		</div>
	          		</div>
	            </div>
	            <div position="bottom" class="bottom" style="padding-top: 15px;">
					  <a href='#' class='button'  onclick="selectForm()" ><span class="icon ok"></span><span >确定</span></a>
			  		<a href='#' class='button' style='margin-left:10px;' onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
				</div>
				
				<input type="hidden" name="resultfield" id="resultfield" value="${bpmFormDialog.resultfield}"/>
				<input type="hidden" name="id" id="id" value="${bpmFormDialog.id}"/>
       	  </div>
       	 
</body>
</html>
