<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>代理授权管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">代理授权管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link search" id="btnSearch">查询</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link add" href="edit.ht">添加</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link update" id="btnUpd" action="edit.ht">修改</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link del"  action="del.ht">删除</a></div>
						</div>	
					</div>
					<div class="panel-search">
							<form id="searchForm" method="post" action="list.ht">
									<div class="row">
												<span class="label">代理人:</span><input type="text" name="Q_tofullname_SL"  class="inputText" style="width:9%" value="${param['Q_tofullname_SL']}"/>
											
												<span class="label">开始时间 :</span> <input  name="Q_beginstarttime_DL"  class="inputText date" style="width:9%" value="${param['Q_beginstarttime_DL']}"/>
			
												<span class="label">结束时间 :</span><input  name="Q_endendtime_DG" class="inputText date" style="width:9%" value="${param['Q_endendtime_DG']}"/>
											
												<span class="label">是否全权代理:</span>
												<select name="Q_isall_SN" value="${param['Q_isall_SN']}" style="margin-left:9px;width:100px;">
														<option value="">--全部--</option>
														<option value="1" <c:if test="${param['Q_isall_SN'] == 1}">selected</c:if>>是</option>
														<option value="0" <c:if test="${param['Q_isall_SN'] == 0}">selected</c:if>>否</option>
												</select>
												<span class="label">是否有效:</span>
												<select name="Q_isvalid_SN"  value="${param['Q_isvalid_SN']}" style="margin-left:9px;width:100px;">
														<option value="">--全部--</option>
														<option value="1" <c:if test="${param['Q_isvalid_SN'] == 1}">selected</c:if>>是</option>
														<option value="0" <c:if test="${param['Q_isvalid_SN'] == 0}">selected</c:if>>否</option>
												</select>
									</div>
							</form>
					</div>
				</div>
				<div class="panel-body">
						<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="sysUserAgentList" id="sysUserAgentItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="agentid" value="${sysUserAgentItem.agentid}">
							</display:column>
							<display:column property="tofullname" title="代理给" sortable="true" sortName="tofullname"></display:column>
							<display:column  title="开始时间" sortable="true" sortName="starttime">
								<fmt:formatDate value="${sysUserAgentItem.starttime}" pattern="yyyy-MM-dd"/>
							</display:column>
							<display:column  title="结束时间" sortable="true" sortName="endtime">
								<fmt:formatDate value="${sysUserAgentItem.endtime}" pattern="yyyy-MM-dd"/>
							</display:column>
							<display:column title="是否全权代理" sortable="true" sortName="isall" style="text-align:center;">
							<c:if test="${sysUserAgentItem.isall==1 }"><span class="green">是</span></c:if>
							<c:if test="${sysUserAgentItem.isall==0 }"><span class="red">否</span></c:if>
							</display:column>
							<display:column title="是否有效" sortable="true" sortName="isvalid" style="text-align:center;">
							<c:if test="${sysUserAgentItem.isvalid==1 }"><span class="green">是</span></c:if>
							<c:if test="${sysUserAgentItem.isvalid==0 }"><span class="red">否</span></c:if>
							</display:column>
							<display:column title="管理" media="html" style="text-align:center;width:180px">
								<a href="del.ht?agentid=${sysUserAgentItem.agentid}" class="link del">删除</a>
								<a href="edit.ht?agentid=${sysUserAgentItem.agentid}" class="link edit">编辑</a>
								<a href="get.ht?agentid=${sysUserAgentItem.agentid}" class="link detail">明细</a>
							</display:column>
						</display:table>
						<cosim:paging tableId="sysUserAgentItem"/>
					
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
</html>


