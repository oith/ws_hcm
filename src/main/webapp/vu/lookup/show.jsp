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
        <a href="${pageContext.request.contextPath}/lookup/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="lookup" text="Lookup"/></a> |
        <a href="${pageContext.request.contextPath}/lookup/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="lookup" text="Lookup"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list hrIrGrdScr">

            <c:if test="${lookup.code!=null && !lookup.code.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="code" text="Code"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="code">
                        <c:out value="${lookup.code}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${lookup.active!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="active" text="Active"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="active">
                        <c:if test="${lookup.active}"><spring:message code="default.boolean.true" text="YES"/></c:if><c:if test="${!lookup.active}"><spring:message code="default.boolean.false" text="NO"/></c:if>
                        </span>
                    </li>
            </c:if>

            <c:if test="${lookup.slNo!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="slNo" text="Sl No"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="slNo">
                        <c:out value="${lookup.slNo}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${lookup.name!=null && !lookup.name.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="name" class="property-label">
                        <spring:message code="name" text="Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="name">
                        <c:out value="${lookup.name}"/>
                    </span>
                </li>
            </c:if>



            <c:if test="${lookup.remarks!=null && !lookup.remarks.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="remarks" text="Remarks"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="remarks">
                        <c:out value="${lookup.remarks}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${lookup.lookupKeyword!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="lookupKeyword" text="Lookup Keyword"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="lookupKeyword">
                        <c:out value="${lookup.lookupKeyword}"/>
                    </span>
                </li>
            </c:if>

            <c:set target="audit" property="audit" var="audit" value="${lookup}" scope="request"/>
            <jsp:include page="../_audit_show.jsp" flush="true" />


        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/lookup/edit/<c:out value="${lookup.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/lookup/delete/<c:out value="${lookup.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>


</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    