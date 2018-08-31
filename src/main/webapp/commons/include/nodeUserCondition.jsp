<!-- update2012-12-29 ht-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
<!--
function changeAllowSpecUsr(obj){
	var nodeSetId = $(obj).attr("nodeSetId");
	var value = $(obj).val();
	var url = __ctx+"/platform/bpm/bpmDefinition/specifyExecutorOnRuntime.ht";
	$.ajax({
		url:url,
		async:false,
		data:{
			nodeSetId:nodeSetId,
			allow:value
		}
	}).done(function(data){
		
		var msg = "";
		switch(value){
		case 1:
			msg = "节点修改为不允许运行时指定执行人员";
			break;
		case 2:
			msg = "节点修改为允许运行时指定企业";
			break;
		case 3:
			msg = "节点修改为允许运行时指定本企业人员";
			break;
		}

		if(data.status==1){
			var text = '<p><font color="green">'+msg+'</font></p>'
			$.ligerMsg.correct(text,false,function(){
				$.ligerMsg.close();
			});
		}else{
			var text = '<p><font color="red">'+msg+' 失败！</font></p>'
			$.ligerMsg.warn(text,false,function(){
				$.ligerMsg.close();
			});
		}
	});;
};
//-->
</script>
<table style="width:100%" id="table_${nodeUserMap.nodeId}" class="table-grid">
	<tr>
		<td colspan="6" style="padding:0;margin: 0;background-color: #DFF5FD">
			<div class="panel-toolbar" style="border:none;">
				<div class="toolBar" style="margin:0;">
					<div class="group"><a class="link add" id="btnSearch" onclick="conditionDialog('table_${nodeUserMap.nodeId}')">添加</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class=" update link " onclick="conditionDialog('table_${nodeUserMap.nodeId}',true)">修改</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del " id="btnSearch" onclick="delRows('table_${nodeUserMap.nodeId}');">删除</a></div>
<!-- 					<div class="l-bar-separator"></div> -->
<%-- 					<div class="group"><a class="link update " onclick="repairOldData('table_${nodeUserMap.nodeId}');">数据修复</a></div> --%>
					<div class="l-bar-separator"></div>
					<div class="group">
						<div style="margin-left: 20px">
							<span class="green">运行时指定执行人：</span>
							<select nodeSetId="${nodeUserMap.setId}" onchange="changeAllowSpecUsr(this)">
								<option value="1" <c:if test="${nodeUserMap.allowSpecUsr==1}">selected="selected"</c:if>>不能指定</option>
								<option value="2" <c:if test="${nodeUserMap.allowSpecUsr==2}">selected="selected"</c:if>>指定企业</option>
								<option value="3" <c:if test="${nodeUserMap.allowSpecUsr==3}">selected="selected"</c:if>>本企业人员</option>
							</select>
<%-- 							<input nodeSetId="${nodeUserMap.setId}" id="checked_${nodeUserMap.nodeId}" name="allowSpecify" type="checkbox"  <c:if test="${nodeUserMap.allowSpecUsr==1}">checked="checked"</c:if> /><label for="checked_${nodeUserMap.nodeId}">允许运行时指定${nodeUserMap.allowSpecUsr}</label> --%>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" name="setId" value="${nodeUserMap.setId}"/>
			<input type="hidden" name="defId" value="${defId}"/>
			<input type="hidden" name="nodeId" value="${nodeUserMap.nodeId}"/>
		</td>
	</tr>
	<thead>
	<tr>
		<th width="80" nowrap="nowrap">序号</th>
		<th width="*" nowrap="nowrap">条件名称</th>
		<th width="*" nowrap="nowrap">条件</th>
		<th nowrap="nowrap" width="60">位置调整</th>
	</tr>
	</thead>
	<tbody class="data">
	<c:choose>
		<c:when test="${fn:length(nodeUserMap.bpmUserConditionList)>0}">
			<c:forEach items="${nodeUserMap.bpmUserConditionList}" var="conditionNode" varStatus="cnt">
				<tr>
					<td>
							<input type='checkbox' name='nodeUserCk' onchange="changeCheck(this)"/>&nbsp;${cnt.count}						
							<input type="hidden" name="conditionId" value="${conditionNode.id}"/>		
								<input type="hidden" name="sn" value="${conditionNode.sn}"/>					
							<c:if test="${nodeTag!=null}">
								<input type="hidden" name="nodeTag" value="${nodeTag}"/>
							</c:if>
					</td>
					<td>
							${conditionNode.conditionname }
					</td>
					<td>
							<textarea name="cmpNames" style="width:90%" rows="3" class="textarea" readonly="readonly">${conditionNode.conditionShow}</textarea>
					</td>
					<td>
							<a class="link moveup" onclick="move('table_${nodeUserMap.nodeId}','up',this)"></a>
							<a class="link movedown" onclick="move('table_${nodeUserMap.nodeId}','down',this)"></a>
						<!-- 	<input type="text" name="conditionGroups" value="${conditionNode.sn }"  size="2"   onblur="alertConditionSn(this)"/> -->
					</td>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>
	</tbody>
</table>