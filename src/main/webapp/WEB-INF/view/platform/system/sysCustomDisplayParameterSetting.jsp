<%--
	time:2012-10-23 17:59:41
	desc:edit the SYS_CUSTOM_DISPLAY
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@page language="java" import="com.cosim.platform.model.system.SysCustomDisplay"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 SYS_CUSTOM_DISPLAY</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	
	<style type="text/css">
		#leftArea{
			float: left;
			width:40%;
		}
		#centerArea{
			float: left;
			width:8%;
		}
		#rightArea{
			float: left;
			width:52%;
		}
		.moveSelect{
			margin:4px auto;
		}
	</style>
	
	<script type="text/javascript">
		$(function() {
			var parameters = window.dialogArguments.parameters;
			init(parameters);
			//绑定 选择确定点击事件
			$("#selok").click(function(){
				var parameters={
						tblHeader:new Array(),
						condition:new Array()
				};
				//取表头Label（列的comment）
				$("#columnsTbl input:[name='comment']").each(function(){
					$this=$(this);
					var name=$this.attr("colname");
					var index=parseInt($this.attr("index"));
					var comment=$this.val();
					parameters.tblHeader.push({
						name:name,
						index:index,
						comment:comment
					});
				});
				//取条件字段
				$("#conditionTbl>tbody>tr").each(function(){
					var select =$(this).find("select");
					var name=select.attr("name");
					var cond=select.val();
					var type=select.attr("dbType");
					var comment=select.attr("comment");
					var condition={
							name:name,
							type:type,
							cond:cond,
							comment:comment
						};
					parameters.condition.push(condition);
				});
				window.returnValue={
						status:true,
						parameters:parameters
				};
				window.close();
			});
			
			//绑定选择条件点击事件
			$("#selectCondition").click(function(){
				$("input:[type='checkbox']:[name='colckbox']:checked").each(function(){
					var index=$(this).val();
					var col = $("input:[index="+index+"]");
					var name=col.attr("colname");
					var type=col.attr("dbType");
					var comment=col.val();
					var condition={
						name:name,
						type:type,
						cond:'=',
						comment:comment
					};
					var tr = constructConditionTr(condition);
					$("#conditionTbl tbody").append(tr);
				});
			});
		});
		//Initial page 
		function init(parameters){
			if(!parameters){
				return false;
			}
			//初始化数据列信息
			if(parameters.tblHeader){
				var tblHeader=parameters.tblHeader;
				for(var i=0;i<tblHeader.length;i++){
	// 				var name = tblHeader[i].name;
					var index=tblHeader[i].index;
					var value=tblHeader[i].comment;
					if(index && value){
						$("#columnsTbl input:[index="+index+"]").val(value);
					}
				}
			}
			//初始化条件信息
			if(parameters.condition){
				var condition=parameters.condition;
				for(var i=0;i<condition.length;i++){
					var name = condition[i].name;
					var type=condition[i].type;
					var comment=condition[i].comment;
					var cond=condition[i].cond;
					if(name && cond){
						var condition_={
								name:name,
								type:type,
								comment:comment,
								cond:cond
						};						
						var tr = constructConditionTr(condition_);
						$("#conditionTbl tbody").append(tr);
					}
				}
			}

			
		}
		
		//构造条件<tr>
		function constructConditionTr(condition){
			var type=condition.type;
			var name=condition.name;
			var comment=condition.comment;
			var cond=condition.cond;
			var constructOption=function(cond1,cond2){
				var $option=$("<option></option");
				$option.text(cond2);
				$option.val(cond2);
				if(cond1==cond2){
					$option.attr("selected","selected");
				}
				return $option;
			};
			//名称
			var $tdName = $("<td></td>");
			$tdName.append(name);
			//条件
			var $tdCond=$("<td></td>");
			var $select = $("<select></select>");
			$select.attr("name",name);
			$select.attr("dbType",type);
			$select.attr("comment",comment);
			$select.css("width","100%");
			switch(type){
				case 'varchar':
					$select.append(constructOption(cond,"="));
					$select.append(constructOption(cond,"likeEnd"));
					$select.append(constructOption(cond,"like"));
					break;
				case 'number':
					$select.append(constructOption(cond,"="));
					$select.append(constructOption(cond,">"));
					$select.append(constructOption(cond,"<"));
					$select.append(constructOption(cond,">="));
					$select.append(constructOption(cond,"<="));
					break;
				case 'int':
					$select.append(constructOption(cond,"="));
					$select.append(constructOption(cond,">"));
					$select.append(constructOption(cond,"<"));
					$select.append(constructOption(cond,">="));
					$select.append(constructOption(cond,"<="));
					break;
				default:
					$select.append(constructOption(cond,"="));
					$select.append(constructOption(cond,">="));
					$select.append(constructOption(cond,"<="));
					$select.append(constructOption(cond,"between"));
			}
			$tdCond.append($select);
			//注解
			var $tdComment=$("<td></td>");
			var $inputComment=$("<input type='text'/>");
			$inputComment.val(comment);
			$tdComment.append($inputComment);
			//管理
			var $tdManage=$("<td></td>");
			var $aDelete=$("<a onclick='delConditionTr(this)'>删除</a>");
			$aDelete.attr("href","#");
			$aDelete.addClass("link del");
			$tdManage.append($aDelete);
			
			$tr=$("<tr></tr>");
			$tr.append($tdName);
			$tr.append($tdCond);
			$tr.append($tdComment);
			$tr.append($tdManage);
			return $tr;
		}
		//删除选择的条件所有的表格的行
		function delConditionTr(obj){
			$(obj).closest("tr").remove();
		}
		
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">自定义显示参数设置</span>
		</div>
	</div>
	<div class="panel-body">
		<div id="leftArea">
			<table id="columnsTbl" class="table-grid">
				<tr>
					<th>选择</th>
					<th>列名</th>
					<th>注释</th>
				</tr>
				<c:forEach items="${columns}" var="column">
					<tr>
						<td>
							<input name="colckbox" type="checkbox" value="${column.index}"/>
						</td>
						<td>${column.name}</td>
						<td>
							<input name="comment" type="text" dbType="${column.columnType}" colname="${column.name}" index="${column.index}" value="${column.comment}"/>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div id="centerArea">
			<a id="selectCondition" href="#" class="button">
				<span>==></span>
			</a>
		</div>
		<div id="rightArea">
			<table id="conditionTbl" class="table-grid">
				<thead>
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
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<div style="clear: both;"></div>
	</div>
	<div position="bottom" class="bottom" style="padding-top: 15px;">
		<a id="selok" href='#' class='button'><span class="icon ok"></span><span >确定</span></a>
  		<a href='#' class='button' style='margin-left:10px;' onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
	</div>
</div>
</body>
</html>
