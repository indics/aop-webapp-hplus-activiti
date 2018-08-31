<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>定时任务管理</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp" %>
    <script type="text/javascript" src="${ctx }/js/lg/plugins/ligerWindow.js" ></script>
 </head>
 <body>
		<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">任务列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link add" href="addJob1.ht">添加</a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <table  cellpadding="1" cellspacing="1"   class="table-grid">
						    <thead>
							    <tr>
								    <th>序号</th>
								    <th>任务名称</th>
								    <th>任务类</th>
								    <th>任务描述</th>
								    <th>管理</th>
							    </tr>
						    </thead>
						    <tbody>
							    <c:forEach items="${jobList}" var="d" varStatus="status">
						           <tr class="${status.index%2==0?'odd':'even'}">
							           <td >${status.index +1}</td>
							           <td >${d.key.name }</td>
							           <td >${d.jobClass.name }</td>
							           <td >${d.description }</td>
							           <td >
							                <a href="delJob.ht?jobName=${d.key.name }" class="link del" >删除</a>
											<a href="addTrigger1.ht?jobName=${d.key.name }" class="link flowDesign">添加计划</a>
											<a href="getTriggersByJob.ht?jobName=${d.key.name }" class="link detail">计划列表</a>
											<a  href="executeJob.ht?jobName=${d.key.name}" class="link run">执行</a> 
											<a href="getLogList.ht?jobName=${d.key.name}" class="link flowDesign">日志</a>
							           </td>
						           </tr>
						        </c:forEach>
						    </tbody>
					    </table>
					
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
