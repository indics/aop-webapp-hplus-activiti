<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!-- cas登陆去掉下面这行 -->
<%-- <c:redirect url="/loginSystem.jsp"/> --%>

<c:if test="${empty SPRING_SECURITY_LAST_USERNAME}">
	<a href="${ctx}/loginAdmin.jsp">通过本地登陆</a>
	<a href="${ctx}/loginSystem.jsp">登陆运营管理员</a>
	<a href="${ctx}/login">通过CAS登陆</a>
</c:if>
<c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}">
	<a href="${ctx}/logout"><sec:authentication property="principal.fullname" /></a>
</c:if>

<br/>
<%
// 	Enumeration e=session.getAttributeNames();
//     String temp;
//     out.write("下面循环输出Session所有属性及其值："  + "</br>");
//     for (;e.hasMoreElements();){
//          temp=(String)e.nextElement();
//          out.write(temp+"=" + session.getAttribute(temp) + "</br>");
//     }
%>