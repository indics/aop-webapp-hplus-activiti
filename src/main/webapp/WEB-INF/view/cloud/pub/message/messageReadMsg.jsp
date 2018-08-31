
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>消息接收者管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">消息接收管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link search" id="btnSearch">查询</a></div>
							<div class="l-bar-separator"></div>						
							<div class="group"><a class="link del"  action="del.ht">删除</a></div>
						</div>	
					</div>
					<div class="panel-search">
							<form id="searchForm" method="post" action="list.ht">
									<div class="row">
								        <span class="label">标题:</span><input type="text" name="Q_subject_SL"  class="inputText" value="${param['Q_subject_SL']}"/>																						
										<span class="label">消息类型:</span>												
										<select name="Q_messageType_S" class="select" value="${param['Q_messageType_S']}">
										    <option value="">全部</option>
											<option value="11" <c:if test="${param['Q_messageType_S'] == 11}">selected</c:if>>询盘提醒 </option>
									    </select>
										<span class="label">发送时间:</span> <input  name="Q_beginreceiveTime_DL"  class="inputText datetime" value="${param['Q_beginreceiveTime_DL']}"/>
										<span class="label">至: </span><input  name="Q_endreceiveTime_DG" class="inputText datetime" value="${param['Q_endreceiveTime_DG']}"/>
									</div>
							</form>
					</div>
				</div>
				<div class="panel-body">
					
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="messageReceiverList" id="messageReceiverItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="id" value="${messageReceiverItem.rid}">
							</display:column>
							<display:column property="userName" title="发信人" sortable="true" sortName="userName"></display:column>
							<display:column property="subject" title="标题" sortable="true" sortName="subject"></display:column>
							<display:column title="消息类型" sortable="true" sortName="messageType" style="text-align:center;">
							<c:choose>
							   	<c:when test="${messageReceiverItem.messageType==11}">
							                  询盘提醒
							   	</c:when>
						       	<c:otherwise>
							                   其他                 
							   	</c:otherwise>
						    </c:choose>
							</display:column>	
							<display:column title="发送时间" sortable="true" sortName="sendTime" style="text-align:center;">
								<fmt:formatDate value="${messageReceiverItem.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</display:column>							
							<display:column  title="收信时间" sortable="true" sortName="receiveTime" style="text-align:center;">
								<c:choose>
									<c:when test="${messageReceiverItem.receiveTime!=null}">
										<fmt:formatDate value="${messageReceiverItem.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</c:when>
									<c:otherwise>
										未读消息
									</c:otherwise>
								</c:choose>
							</display:column>
							<display:column title="管理" media="html" style="width:180px">
								<c:if test="${messageReceiverItem.rid!=null}">
									<a href="del.ht?id=${messageReceiverItem.rid}" class="link del">删除</a>
								</c:if>
								<c:if test="${messageReceiverItem.canReply==1}">
								<a href="${ctx}/platform/system/messageReply/edit.ht?messageId=${messageReceiverItem.id}" class="link edit">回复</a>
								</c:if>
								<a href="${ctx}/platform/system/messageRead/list.ht?messageId=${messageReceiverItem.id}" class="link detail">明细</a>
							</display:column>
						</display:table>
						<cosim:paging tableId="messageReceiverItem"/>
				
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
</html>


