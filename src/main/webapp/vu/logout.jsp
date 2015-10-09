<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<title>fffffgg</title>

<%--<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"  %>--%>

<%--<% session.invalidate();%>--%>
You are now logged out!!
<br>
<a href="${pageContext.request.contextPath}/index">Home Page</a>
<br>
<a href="${pageContext.request.contextPath}/login">Login Page</a>