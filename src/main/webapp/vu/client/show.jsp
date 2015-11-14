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
        <a href="${pageContext.request.contextPath}/client/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="client" text="Client"/></a> |
        <a href="${pageContext.request.contextPath}/client/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="client" text="Client"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list hrIrGrdScr">

            <c:if test="${client.code!=null && !client.code.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="code" text="Code"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="code">
                        <c:out value="${client.code}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${client.active!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="active" text="Active"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="active">
                        <c:if test="${client.active}"><spring:message code="default.boolean.true" text="YES"/></c:if><c:if test="${!client.active}"><spring:message code="default.boolean.false" text="NO"/></c:if>
                        </span>
                    </li>
            </c:if>

            <%--<c:if test="${client.slNo!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="slNo" text="Sl No"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="slNo">
                        <c:out value="${client.slNo}"/>
                    </span>
                </li>
            </c:if>--%>

            <c:if test="${client.name!=null && !client.name.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="name" class="property-label">
                        <spring:message code="name" text="Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="name">
                        <c:out value="${client.name}"/>
                    </span>
                </li>
            </c:if>


            <c:if test="${client.domain!=null && !client.domain.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="domain" class="property-label">
                        <spring:message code="domain" text="domain"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="domain">
                        <c:out value="${client.domain}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${client.loginUrl!=null && !client.loginUrl.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="loginUrl" class="property-label">
                        <spring:message code="loginUrl" text="loginUrl"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="loginUrl">
                        <c:out value="${client.loginUrl}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${client.userCreateUrl!=null && !client.userCreateUrl.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="userCreateUrl" class="property-label">
                        <spring:message code="userCreateUrl" text="userCreateUrl"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="userCreateUrl">
                        <c:out value="${client.userCreateUrl}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${client.remarks!=null && !client.remarks.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="remarks" text="Remarks"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="remarks">
                        <c:out value="${client.remarks}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${client.clientCategory!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="clientCategory" text="Client Category"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="clientCategory">
                        <c:out value="${client.clientCategory}"/>
                    </span>
                </li>
            </c:if>
            <%--<c:set target="audit" property="audit" var="audit" value="${client}" scope="request"/>--%>
            <%--<jsp:include page="../_auditShow.jsp" flush="true" />--%>
        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/client/edit/<c:out value="${client.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/client/delete/<c:out value="${client.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>


</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    