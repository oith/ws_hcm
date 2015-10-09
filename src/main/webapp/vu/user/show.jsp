<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<tiles:insertDefinition name="defaultTemplate" />

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp" />
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp" />--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.show" text="Show"/></title>

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home"/></a> |
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <%--<form:hidden path="id"/>--%>
        <ol class="property-list hrIrGrdScr">

            <c:if test="${user.username!=null && !user.username.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="username" text="Username"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="username">
                        <c:out value="${user.username}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${user.dob!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="dob" text="Date of Birth"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="dob">
                        <fmt:formatDate value="${user.dob}" type="date" pattern="dd/MM/yyyy"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${user.displayName!=null && !user.displayName.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="displayName" text="Display Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="displayName">
                        <c:out value="${user.displayName}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${user.gender!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="gender" text="Gender"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="gender">
                        <c:out value="${user.gender}"/>
                    </span>
                </li>
            </c:if>

            <%--    
            <c:if test="${user.password!=null && !user.password.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="password" text="Password"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="password">
                        <c:out value="${user.password}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${user.enabled!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="enabled" text="Enabled"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="enabled">
                        <c:if test="${user.enabled}"><spring:message code="default.boolean.true" text="YES"/></c:if><c:if test="${!user.enabled}"><spring:message code="default.boolean.false" text="NO"/></c:if>
                        </span>
                    </li>
            </c:if>
            <c:if test="${user.authorities!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="authorities" text="Authorities"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="authorities">
                        <b><c:out value="${user.authorities}"/></b>
                    </span>
                </li>
            </c:if>
            --%>
            
        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/user/edit"><spring:message code="edit.link.label"/></a> |
</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    