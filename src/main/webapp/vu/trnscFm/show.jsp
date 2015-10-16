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
        <a href="${pageContext.request.contextPath}/trnscFm/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="trnscFm" text="Account Head Fm"/></a> |
        <a href="${pageContext.request.contextPath}/trnscFm/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="trnscFm" text="Account Head Fm"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list hrIrGrdScr">

            <c:if test="${trnscFm.code!=null && !trnscFm.code.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="code" text="Code"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="code">
                        <c:out value="${trnscFm.code}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.title!=null && !trnscFm.title.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="name" class="property-label">
                        <spring:message code="title" text="title"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="title">
                        <c:out value="${trnscFm.title}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.accNo!=null && !trnscFm.accNo.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="description" text="Description"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="description">
                        <c:out value="${trnscFm.accNo}"/>
                    </span>
                </li>
            </c:if>
            <c:set target="audit" property="audit" var="audit" value="${trnscFm}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true" />

        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/trnscFm/edit/<c:out value="${trnscFm.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/trnscFm/delete/<c:out value="${trnscFm.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    