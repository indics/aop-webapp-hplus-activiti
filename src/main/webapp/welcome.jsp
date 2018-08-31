<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>这是首页</title>
</head>
<body>
	<c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}">
		你好，<sec:authentication property="principal.fullname" />
		<a href="/logout">退出</a>
	</c:if>
	<c:if test="${empty SPRING_SECURITY_LAST_USERNAME}">
		<a href="/login">登录</a>
	</c:if>
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
</body>
</html>