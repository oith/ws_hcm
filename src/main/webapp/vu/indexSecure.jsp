<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<title><spring:message code="project.title"/></title>

<tiles:insertDefinition name="defaultTemplate" />

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp" />
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp" />--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <h1><spring:message code="welcome.to.secure.oith" text="Welcome to Secure OITH"/></h1>

    <h4><spring:message code="welcome.to.moto.oith" text="An easiest way to java WEB application development!!!"/></h4>

    <p>
        <spring:message code="welcome.to.desc.oith" text="Congratulations, you have successfully started your first OITH application! At the moment
                        this is the default page, feel free to modify it to either redirect to a controller or display whatever
                        content you may choose. Below is a list of controllers that are currently deployed in this application,
                        click on each to execute its default action:"/>
    </p>
    <p>
        <br/>

    <sec:authorize access="isAuthenticated()">
        Username: <sec:authentication property="principal.username" />
        <br/>
        Role: <sec:authentication property="principal.authorities"/>
    </sec:authorize>
    <br/>
    <c:forEach var="listValue" items="${lists}">
        <a href="${pageContext.request.contextPath}${listValue}">${listValue}</a><br/>
    </c:forEach>

</p>

</tiles:putAttribute>

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>

