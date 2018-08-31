<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<table class="table-detail">
		<tr>
			<th width="100px">节点执行人</th>
			<td width="90%">
				<input type="hidden" id="destTask" name="destTask" value="${nodeId}"/>
				<input type="hidden" id="lastDestTaskId" name="lastDestTaskId" value="">
				<span id="jumpUserDiv"></span>
				<a href="#" id="jumpUserLink" class="link grant" onclick="selectExeUsers(this)">选择..</a>
			</td>
		</tr>
	</table>
