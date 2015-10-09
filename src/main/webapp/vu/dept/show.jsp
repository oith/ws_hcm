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
        <a href="${pageContext.request.contextPath}/dept/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="dept" text="Department"/></a> |
        <a href="${pageContext.request.contextPath}/dept/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="dept" text="Department"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list hrIrGrdScr">
    
        <c:if test="${dept.code!=null && !dept.code.isEmpty()}">
            <li class="fieldcontain first_item">
                <span id="title" class="property-label">
                    <spring:message code="code" text="Code"/>: 
                </span>
                <span class="property-value" aria-labelledby="code">
                    <c:out value="${dept.code}"/>
                </span>
            </li>
        </c:if>

        <c:if test="${dept.name!=null && !dept.name.isEmpty()}">
            <li class="fieldcontain first_item">
                <span id="name" class="property-label">
                    <spring:message code="name" text="Name"/>: 
                </span>
                <span class="property-value" aria-labelledby="name">
                    <c:out value="${dept.name}"/>
                </span>
            </li>
        </c:if>

        <c:if test="${dept.description!=null && !dept.description.isEmpty()}">
            <li class="fieldcontain first_item">
                <span id="title" class="property-label">
                    <spring:message code="description" text="Description"/>: 
                </span>
                <span class="property-value" aria-labelledby="description">
                    <c:out value="${dept.description}"/>
                </span>
            </li>
        </c:if>

     
        </ol>
    
    </div>

    <a href="${pageContext.request.contextPath}/dept/edit/<c:out value="${dept.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/dept/delete/<c:out value="${dept.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    