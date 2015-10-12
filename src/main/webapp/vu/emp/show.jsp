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
        <a href="${pageContext.request.contextPath}/emp/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="emp" text="Department"/></a> |
        <a href="${pageContext.request.contextPath}/emp/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="emp" text="Department"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list hrIrGrdScr">

            <c:if test="${emp.code!=null && !emp.code.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="code" text="Code"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="code">
                        <c:out value="${emp.code}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${emp.profile!=null}">
                <li class="fieldcontain first_item">
                    <span id="name" class="property-label">
                        <spring:message code="profile" text="Profile"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="profile">
                        <a href="${pageContext.request.contextPath}/operator/profile/operator_show/<c:out value="${emp.profile.id}"/>" target="_blank"><c:out value="${emp.profile.user.displayName}"/></a>
                    </span>
                </li>
            </c:if>

            <c:if test="${emp.doj!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="doj" text="Date of Join"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="doj">
                        <fmt:formatDate value="${emp.doj}" type="date" pattern="dd/MM/yyyy EEEEE"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${emp.doe!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="doe" text="Date of Expired"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="doe">
                        <fmt:formatDate value="${emp.doe}" type="date" pattern="dd/MM/yyyy EEEEE"/>
                    </span>
                </li>
            </c:if>
            <c:set target="audit" property="audit" var="audit" value="${emp}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true" />
        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/emp/edit/<c:out value="${emp.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/emp/delete/<c:out value="${emp.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    