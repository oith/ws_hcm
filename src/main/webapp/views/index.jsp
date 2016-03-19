<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/images/favicon.ico"/>

<title><spring:message code="project.title" text="OITH Home"/></title>

<tiles:insertDefinition name="defaultTemplate"/>

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp"/>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <sec:authorize access="isAuthenticated()">
        <div>
            <sec:authentication property="principal"/>
        </div>
        <div>
            <c:forEach var="listValue" items="${lists}">
                <a href="${pageContext.request.contextPath}${listValue}">
                    <spring:message code="${listValue}" text="${listValue}"/>
                </a>
            </c:forEach>
        </div>
    </sec:authorize>               
    <%--    
        <h1><spring:message code="welcome.to.oith" text="Welcome to OITH"/></h1>

    <h4><spring:message code="welcome.to.moto.oith" text="An easiest way to java WEB application development!!!"/></h4>

    <p>
        <spring:message code="welcome.to.desc.oith" text="Congratulations, you have successfully started your first OITH application! At the moment
                        this is the default page, feel free to modify it to either redirect to a controller or display whatever
                        content you may choose. Below is a list of controllers that are currently deployed in this application,
                        click on each to execute its default action:"/>
    </p>--%>


</tiles:putAttribute>

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp"/>
</tiles:putAttribute>

