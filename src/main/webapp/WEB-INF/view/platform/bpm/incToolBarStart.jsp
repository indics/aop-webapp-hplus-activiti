<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
<div class="panel-top">
	<div class="tbar-title noprint">
		<span class="tbar-label">流程启动--${bpmDefinition.subject} --V${bpmDefinition.versionNo}</span>
	</div>
	<div class="panel-toolbar noprint" >
		<div class="toolBar">
			
			<c:choose>
				<c:when test="${empty mapButton }">
					<div class="group"><a class="link run">启动流程</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link save">保存表单</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link flowDesign" onclick="showBpmImageDlg()">流程示意图</a></div>
					<div class="l-bar-separator"></div>
					<a class="link print" onclick="window.print();">打印</a>
					通知方式：<input type="checkbox" value="1" name="informType">手机短信 &nbsp;<input type="checkbox" value="2" name="informType">邮件
				</c:when>
				<c:otherwise>
					<c:if test="${not empty mapButton.button}">
						<c:forEach items="${mapButton.button }" var="btn"  varStatus="status">
							<c:choose>
								
								<c:when test="${btn.operatortype==1 }">
									<!-- 启动流程 -->
									<div class="group"><a class="link run">${btn.btnname }</a></div>
								</c:when>
								
								<c:when test="${btn.operatortype==2 }">
									<!--流程示意图 -->
									<div class="group"><a class="link flowDesign" onclick="showBpmImageDlg()">${btn.btnname }</a></div>
								</c:when>
								
								<c:when test="${btn.operatortype==3 }">
									<!--打印 -->
									<div class="group"><a class="link print" onclick="window.print();">${btn.btnname }</a></div>
								</c:when>
								
								<c:when test="${btn.operatortype==6 }">
									<!--保存表单 -->
									<div class="group"><a class="link save">${btn.btnname }</a></div>
								</c:when>
							</c:choose>
							
							<c:if test="${not status.last}">
								<div class="l-bar-separator"></div>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${not empty mapButton.inform}">
						通知方式：
						<c:forEach items="${mapButton.inform }" var="btn"  varStatus="status">
							<c:choose>
								<c:when test="${btn.operatortype==4 }">
									<input type="checkbox" value="1" name="informType">${btn.btnname } &nbsp;
								</c:when>
								<c:when test="${btn.operatortype==5 }">
									<input type="checkbox" value="2" name="informType">${btn.btnname } &nbsp;
								</c:when>
								
							</c:choose>
						</c:forEach>
					</c:if>
				</c:otherwise>
			</c:choose>	
			
		</div>
	</div>
</div>
							
								
						
