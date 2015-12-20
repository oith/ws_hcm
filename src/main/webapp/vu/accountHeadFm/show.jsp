<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<tiles:insertDefinition name="defaultTemplate"/>

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp"/>
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp"/>--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.show" text="Show"/></title>

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home"/></a> |
        <a href="${pageContext.request.contextPath}/accountHeadFm/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="accountHeadFm" text="AccountHeadFm"/></a> |
        <a href="${pageContext.request.contextPath}/accountHeadFm/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="accountHeadFm" text="AccountHeadFm"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list">

            <c:if test="${accountHeadFm.code!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="code" text="CODE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="code">
                        <c:out value="${accountHeadFm.code}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${accountHeadFm.title!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="title" text="TITLE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="title">
                        <c:out value="${accountHeadFm.title}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${accountHeadFm.accNo!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="accNo" text="ACCNO"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="accNo">
                        <c:out value="${accountHeadFm.accNo}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${accountHeadFm.active!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="active" text="ACTIVE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="active">
                        <c:out value="${accountHeadFm.active}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${accountHeadFm.slNo!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="slNo" text="SLNO"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="slNo">
                        <c:out value="${accountHeadFm.slNo}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${accountHeadFm.empRequired!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="empRequired" text="EMPREQUIRED"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="empRequired">
                        <c:out value="${accountHeadFm.empRequired}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${accountHeadFm.description!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="description" text="DESCRIPTION"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="description">
                        <c:out value="${accountHeadFm.description}"/>
                    </span>
                </li>
            </c:if>

            <c:set target="audit" property="audit" var="audit" value="${accountHeadFm}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true"/>
        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/accountHeadFm/edit/<c:out value="${accountHeadFm.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/accountHeadFm/delete/<c:out value="${accountHeadFm.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp"/>
</tiles:putAttribute>    