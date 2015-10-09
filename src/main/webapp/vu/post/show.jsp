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
        <a href="${pageContext.request.contextPath}/post/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="post" text="Post"/></a> |
        <a href="${pageContext.request.contextPath}/post/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="post" text="Post"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list hrIrGrdScr">

            <c:if test="${post.subject!=null && !post.subject.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="subject" class="property-label">
                        <spring:message code="subject" text="subject"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="subject">
                        <c:out value="${post.subject}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${post.user!=null}">
                <li class="fieldcontain first_item">
                    <span id="user" class="property-label">
                        <spring:message code="user" text="user"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="user">
                        <c:out value="${post.user.displayName}"/>
                    </span>
                </li>
            </c:if>



            <c:if test="${post.content!=null && !post.content.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="content" class="property-label">
                        <spring:message code="content" text="content"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="content">
                        <c:out value="${post.content}"/>
                    </span>
                </li>
            </c:if>

        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/post/edit/<c:out value="${post.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/post/delete/<c:out value="${post.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>


</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    