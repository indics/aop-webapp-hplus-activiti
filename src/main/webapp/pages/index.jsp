<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<c:if test="${empty SPRING_SECURITY_LAST_USERNAME}">
	<a href="/login">去登陆</a>
</c:if>
<c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}">
	您好，${SPRING_SECURITY_CONTEXT.authentication.principal.fullname}
	<sec:authentication property="principal.fullname" />
</c:if>
<%--<c:redirect url="/loginSystem.jsp"/>--%>
<br/>
<%
	Enumeration e=session.getAttributeNames();
    String temp;
    out.write("下面循环输出Session所有属性及其值："  + "</br>");
    for (;e.hasMoreElements();){
         temp=(String)e.nextElement();
         out.write(temp+"=" + session.getAttribute(temp) + "</br>");
    }
%>