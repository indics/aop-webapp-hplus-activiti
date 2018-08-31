<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<table style="width:100%" id="table_${nodeTag}" class="table-grid">								
	<tr>
		<td colspan="5" style="padding:0;margin: 0;background-color: #DFF5FD">
			<div class="panel-toolbar" style="border:none;">
				<div class="toolBar" style="margin:0;">
					<div class="group"><a class="link add" id="btnSearch"  onclick="addNewNodeUser('${nodeTag}')">添加</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del " id="btnSearch"  onclick="delRows('${nodeTag}');">删除</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link preview " id="btnPreview"  onclick="previewUserSetting()">预览</a></div>
				</div>
			</div>
		</td>
	</tr>
	<thead>
	<tr>
		<th width="80" nowrap="nowrap">序号</th>
		<th width="98" nowrap="nowrap">用户类型</th>
		<th width="*" nowrap="nowrap">用户来自</th>
		<th width="15">位置调整</th>
		<th nowrap="nowrap" width="80">运算类型</th>
	</tr>
	</thead>
	<tbody class="data">
	<c:choose>
		<c:when test="${fn:length(nodeUserMap.nodeUserList)==0}">
			<tr>
				<td nowrap="nowrap" height="28">
		
					<input type='checkbox' name='nodeUserCk'/>&nbsp;1
					<input type="hidden" name="nodeUserId" value=""/>
					<input type="hidden" name="nodeId" value="${nodeTag}"/>
					<select name="assignUseType">
						<option value="0" selected="selected">参与流程</option>
						<option value="1">接收通知</option>
					</select>
				</td>
				<td>
					<select name="assignType" class="select" onchange="assignTypeChange(this);">
						<c:forEach items="${userSetTypes}" var="item">
							<option value="${item.key}" <c:if test="${item.key==1}">selected="selected"</c:if> >${item.value}</option>
						</c:forEach>							
					</select>
				</td>
				<td>
					<input type="hidden" name="cmpIds" value=""/>
					<textarea name="cmpNames" style="width:80%" rows="2" class="textarea" readonly="readonly"></textarea>
					<a class="button" onclick="selectCmp(this);"><span>选择...</span></a>
				</td>
				<td>
					<a id="moveupField" class="link moveup"></a>
					<a id="movedownField" class="link movedown"></a>
				</td>
				<td>
					<select name="compType">
						<option value="0">或运算</option>
						<option value="1">与运算</option>
						<option value="2">排除</option>
					</select>
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${nodeUserMap.nodeUserList}" var="userNode" varStatus="cnt">
				<tr id="${nodeUserMap.nodeId}_${cnt.count}">
					<td  nowrap="nowrap" height="28">
				
						<input type='checkbox' name='nodeUserCk'/> ${cnt.count}
						<input type="hidden" name="nodeUserId" value="${userNode.nodeUserId}"/>
						<input type="hidden" name="nodeId" value="${userNode.nodeId}"/>
						<input type="hidden" name="assignUseType" value="${userNode.assignUseType}"/>													
						<c:choose>
							<c:when test="${userNode.assignUseType==0}">参与流程</c:when>
							<c:when test="${userNode.assignUseType==1}">接收通知</c:when>														
						</c:choose>
					</td>
					<td>
						<input type="hidden" name="assignType" value="${userNode.assignType}"/>
						<span>
							${userSetTypes[userNode.assignType]}
						</span>
					</td>
					<td>
						<input type="hidden" name="cmpIds" value='${userNode.cmpIds}'/>
						<c:choose>
							<c:when test="${userNode.assignType==0 
											or userNode.assignType==9 
											or userNode.assignType==11 
											or userNode.assignType==13
											or userNode.assignType==14
											or userNode.assignType==15}">
									<span>${userSetTypes[userNode.assignType]}</span>
									<textarea name="cmpNames" style="width:80%;display:none;" rows="3" class="textarea">${userNode.cmpNames}</textarea>
									<a class="button" onclick="selectCmp(this);" style="display:none;">
										<span>选择...</span>
									</a>
							</c:when>
							
							<c:otherwise>
								<textarea name="cmpNames" readonly="readonly" style="width:80%;visibility:visible" rows="2" class="textarea">${userNode.cmpNames}</textarea>
								<a class="button" onclick="selectCmp(this);" style="visibility:visible"><span>选择...</span></a>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<a class="link moveup" onclick="move('table_${nodeTag}','up','${cnt.count}')"></a>
						<a class="link movedown" onclick="move('table_${nodeTag}','down','${cnt.count}')"></a>
					</td>
					<td>
						<select name="compType">
							<option value="0" <c:if test="${userNode.compType==0}">selected</c:if> >或运算</option>
							<option value="1" <c:if test="${userNode.compType==1}">selected</c:if> >与运算</option>
							<option value="2" <c:if test="${userNode.compType==2}">selected</c:if> >排除</option>
						</select>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>					