<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<script type="text/javascript">
	function beforeClick(operatorType){<c:if test="${not empty mapButton.button}">
		switch(operatorType){<c:forEach items="${mapButton.button }" var="btn"  ><c:if test="${not empty btn.prevscript}">
				case ${btn.operatortype}:
				${btn.prevscript}
				break;</c:if></c:forEach>
			}</c:if>
	}
	
	function afterClick(operatorType){<c:if test="${not empty mapButton.button}">
		switch(operatorType){<c:forEach items="${mapButton.button }" var="btn" ><c:if test="${not empty btn.afterscript}">
			case ${btn.operatortype}:
				${btn.afterscript}
				break;</c:if></c:forEach>
			}</c:if>
	}
	
</script>
<div class="noprint">
	<div class="panel-toolbar">
		<div class="toolBar">
		<c:choose>
				<c:when test="${!isClaim}">
				<div class="group"><a class="link lock" href="claim.ht?taskId=${task.id}">锁定</a></div>
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${empty mapButton }">
						<c:if test="${isSignTask && isAllowDirectExecute}">
							<div class="group">
								特权：<input type="checkbox" value="1" id="chkDirectComplete"><label for="chkDirectComplete">直接结束</label>
							</div>
						</c:if>
					<div class="group"><a id="btnAgree" class="link agree">完成任务</a></div>
					<div class="l-bar-separator"></div>
					<c:if test="${isSignTask==true}">
						<div class="group"><a id="btnNotAgree" class="link notAgree">反对</a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a id="btnAbandon" class="link abandon">弃权</a></div>
						<div class="l-bar-separator"></div>
						<c:if test="${isAllowRetoactive==true}">
							<div class="group"><a class="link flowDesign" onclick="showAddSignWindow()">补签</a></div>
							<div class="l-bar-separator"></div>
						</c:if>
					</c:if>
					<div class="group"><a id="btnSave" class="link save" >保存表单</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a id="btnForward" class="link goForward " onclick="changeAssignee()">交办</a></div>
					<div class="l-bar-separator"></div>
					<c:if test="${isCanBack}">
					<div class="group"><a id="btnReject" class="link reject" >驳回</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a id="btnRejectToStart" class="link rejectToStart" >驳回到发起人</a></div>
					<div class="l-bar-separator"></div>
					</c:if>
					
					<div class="group"><a class="link setting" onclick="showTaskUserDlg()">流程执行示意图</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link search" onclick="showTaskOpinions()">审批历史</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link print" onclick="window.print();">打印</a></div>
					
					&nbsp;通知方式：<input type="checkbox" value="1" name="informType">手机短信 &nbsp;<input type="checkbox" value="2" name="informType">邮件
					<c:if test="${isExtForm}">
						<c:choose>
							<c:when test="${!empty detailUrl && !empty form}">
								<div class="l-bar-separator"></div>
								<div class="group"><a class="link edit" onclick="openForm('${form}')" >编辑表单</a></div>
							</c:when>
						</c:choose>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="${not empty mapButton.button}">
						<c:if test="${isSignTask && isAllowDirectExecute}">
							<div class="group">
								特权：<input type="checkbox" value="1" id="chkDirectComplete"><label for="chkDirectComplete">直接结束</label>
							</div>
						</c:if>
						<c:forEach items="${mapButton.button }" var="btn"  varStatus="status">
							<c:choose>
								<c:when test="${btn.operatortype==1 }">
									<!--  同意-->
									<div class="group"><a id="btnAgree" class="link agree">${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
								</c:when>
								<c:when test="${btn.operatortype==2 }">
									<!-- 反对-->
									<div class="group"><a id="btnNotAgree" class="link notAgree">${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
								</c:when>
								<c:when test="${btn.operatortype==3 }">
									<!--弃权-->
									<c:if test="${isSignTask==true}">
									<div class="group"><a id="btnAbandon" class="link abandon">${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
									</c:if>
								</c:when>
								
								<c:when test="${btn.operatortype==4 }">
									<!--驳回-->
									<c:if test="${isCanBack}">
									<div class="group"><a id="btnReject" class="link reject">${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
									</c:if>
								</c:when>
								<c:when test="${btn.operatortype==5 }">
									<!--驳回到发起人-->
									<c:if test="${isCanBack && toBackNodeId!=task.taskDefinitionKey}">
										<div class="group"><a id="btnRejectToStart" class="link rejectToStart">${btn.btnname }</a></div>
										<div class="l-bar-separator"></div>
									</c:if>
								</c:when>
								<c:when test="${btn.operatortype==6 }">
									<!--转交代办-->
									<div class="group"><a id="btnForward" class="link goForward" onclick="changeAssignee()">${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
								</c:when>
								<c:when test="${btn.operatortype==7 }">
									<c:if test="${isSignTask==true}">
									<!--补签-->
									<c:if test="${isAllowRetoactive==true}">
										<div class="group"><a class="link flowDesign" onclick="showAddSignWindow()">${btn.btnname }</a></div>
										<div class="l-bar-separator"></div>
									</c:if>
									</c:if>
								</c:when>
								<c:when test="${btn.operatortype==8 }">
									<!--保存表单-->
									<div class="group"><a id="btnSave" class="link save" >${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
								</c:when>
								<c:when test="${btn.operatortype==9 }">
									<!--流程示意图-->
									<div class="group"><a class="link setting" onclick="showTaskUserDlg()">${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
								</c:when>
								<c:when test="${btn.operatortype==10 }">
									<!--打印-->
									<div class="group"><a class="link print" onclick="window.print();">${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
								</c:when>
								<c:when test="${btn.operatortype==11 }">
									<!--审批历史-->
									<div class="group"><a class="link history" onclick="showTaskOpinions()">${btn.btnname }</a></div>
									<div class="l-bar-separator"></div>
								</c:when>
							</c:choose>
							
							
						</c:forEach>
					</c:if>
					<c:if test="${not empty mapButton.inform}">
						通知方式：
						<c:forEach items="${mapButton.inform }" var="btn"  varStatus="status">
							<c:choose>
								<c:when test="${btn.operatortype==12 }">
									<input type="checkbox" value="1" name="informType">${btn.btnname } &nbsp;
								</c:when>
								<c:when test="${btn.operatortype==13 }">
									<input type="checkbox" value="2" name="informType">${btn.btnname } &nbsp;
								</c:when>
							</c:choose>
						</c:forEach>
					</c:if>
					<c:if test="${isExtForm}">
						<c:choose>
							<c:when test="${!empty detailUrl && !empty form}">
								<div class="l-bar-separator"></div>
								<div class="group"><a class="link edit" onclick="openForm('${form}')" >编辑表单</a></div>
							</c:when>
						</c:choose>
					</c:if>
				</c:otherwise>
				</c:choose>
				</c:otherwise>
		</c:choose>
		<c:if test="${fn:indexOf(bpmNodeSet.jumpType,'1')!=-1}">
			<span style="padding-top:4px"><input type="radio" checked="checked" name="jumpType" onclick="chooseJumpType(1)" />&nbsp;正常跳转</span>
		</c:if>
		<c:if test="${fn:indexOf(bpmNodeSet.jumpType,'2')!=-1}">
			<span style="padding-top:4px"><input type="radio" name="jumpType" onclick="chooseJumpType(2)" />&nbsp;选择路径跳转</span>
		</c:if>
		<c:if test="${fn:indexOf(bpmNodeSet.jumpType,'3')!=-1}">
			<span style="padding-top:4px"><input type="radio" name="jumpType" onclick="chooseJumpType(3)" />&nbsp;自由跳转</span>
		</c:if>
		</div>	
	</div>
</div>
