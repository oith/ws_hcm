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
        <a href="${pageContext.request.contextPath}/menu/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="menu" text="Menu"/></a> |
        <a href="${pageContext.request.contextPath}/menu/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="menu" text="Menu"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <%--<form:hidden path="id"/>--%>
        <dl class="dl-horizontal">

            <c:if test="${menu.code!=null}">
                <dt><spring:message code="code" text="Code"/></dt>
                <dd>
                    <c:out value="${menu.code}"/>
                </dd>
            </c:if>

            <c:if test="${menu.menuType!=null}">
                <dt><spring:message code="menuType" text="Menu Type"/></dt>
                <dd>
                    <c:out value="${menu.menuType}"/>
                </dd>
            </c:if>

            <c:if test="${menu.text!=null}">
                <dt><spring:message code="text" text="Text"/></dt>
                <dd>
                    <c:out value="${menu.text}"/>
                </dd>
            </c:if>

            <c:if test="${menu.address!=null}">
                <dt><spring:message code="address" text="Address"/></dt>
                <dd>
                    <c:out value="${menu.address}"/>
                </dd>
            </c:if>

            <c:set target="audit" property="audit" var="audit" value="${menu}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true" />
        </dl>

    </div>

    <a href="${pageContext.request.contextPath}/menu/edit/<c:out value="${menu.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/menu/copy/<c:out value="${menu.id}"/>"><spring:message code="copy.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/menu/delete/<c:out value="${menu.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    