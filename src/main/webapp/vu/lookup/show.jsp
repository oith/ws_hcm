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
        <%--<form:hidden path="id"/>--%>
        <dl class="dl-horizontal">

            <c:if test="${lookup.code!=null}">
                <dt><spring:message code="code" text="Code"/></dt>
                <dd>
                    <c:out value="${lookup.code}"/>
                </dd>
            </c:if>

            <c:if test="${lookup.lookupKeyword!=null}">
                <dt><spring:message code="lookupKeyword" text="Lookup Keyword"/></dt>
                <dd>
                    <c:out value="${lookup.lookupKeyword}"/>
                </dd>
            </c:if>

            <c:if test="${lookup.name!=null}">
                <dt><spring:message code="name" text="Name"/></dt>
                <dd>
                    <c:out value="${lookup.name}"/>
                </dd>
            </c:if>

            <c:if test="${lookup.active!=null}">
                <dt><spring:message code="active" text="Active"/></dt>
                <dd>
                    <c:out value="${lookup.active}"/>
                </dd>
            </c:if>

            <c:if test="${lookup.slNo!=null}">
                <dt><spring:message code="slNo" text="Sl No"/></dt>
                <dd>
                    <c:out value="${lookup.slNo}"/>
                </dd>
            </c:if>

            <c:if test="${lookup.remarks!=null}">
                <dt><spring:message code="remarks" text="Remarks"/></dt>
                <dd>
                    <c:out value="${lookup.remarks}"/>
                </dd>
            </c:if>
          
            <c:set target="audit" property="audit" var="audit" value="${lookup}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true" />
        </dl>

    </div>

    <a href="${pageContext.request.contextPath}/lookup/edit/<c:out value="${lookup.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/lookup/copy/<c:out value="${lookup.id}"/>"><spring:message code="copy.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/lookup/delete/<c:out value="${lookup.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    