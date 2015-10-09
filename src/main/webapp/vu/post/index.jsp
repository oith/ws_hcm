<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<tiles:insertDefinition name="defaultTemplate" />

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp" />
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp" />--%>
</tiles:putAttribute>

<c:if test="${flashMessage != null}">
    <div id="flashMessage" align="center">
        ${flashMessage}
    </div>
</c:if>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.index" text="Index"/></title>

    <script>window.jQuery || document.write('<script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"><\/script>')</script>

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home"/></a> |
        <a href="${pageContext.request.contextPath}/post/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="post" text="Post"/></a>
    </div>

    <h1><spring:message code="list.page.title"/></h1>

    <form:form action="${pageContext.request.contextPath}/post/index" commandName="searchCriteria" method="POST">

        <table>
            <tr>
                <td><form:label path="searchTerm"><spring:message code="label.searchTerm"/>:</form:label></td>
                <td><form:input path="searchTerm" type="text" id="txtSearch" size="20"/></td>
                <td><form:label path="searchTerm"><spring:message code="foundRec" arguments="${searchCriteria.totalRecs}" htmlEscape="false" /></form:label></td>
            </tr>

            <tr>
                <td><form:label path="pageSize"><spring:message code="label.pageSize"/>:</form:label></td>
                <td><form:select path="pageSize">
                        <%--<form:option value="2" label="2" />--%>
                        <%--<form:option value="3" label="3" />--%>
                        <form:option value="5" label="5" />
                        <form:option value="10" label="10" />
                        <form:option value="20" label="20" />
                        <form:option value="50" label="50" />
                        <form:option value="100" label="100" />
                        <form:option value="200" label="200" />
                        <form:option value="500" label="500" />
                        <form:option value="1000" label="1000" />
                        <%--   <form:options items="${pageSize}" />--%>
                    </form:select></td>
            </tr>
            <tr>
                <td><form:label path="page"><spring:message code="label.page"/>:</form:label></td>
                <td><form:select path="page">
                        <%--<form:option value="-1" label="...Select..." />--%>
                        <form:options items="${pages}" />
                    </form:select></td>
            </tr>
        </table>

        <div>
            <input type="submit" value="<spring:message code="search.form.submit.label"/>"/>
        </div>
    </form:form>

    <c:if test="${posts.size()!=0}">
        <div style="margin: auto; overflow-x: scroll; padding-top: 5px">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="style-table">
                <thead>
                    <tr>
                        <td></td>
                        <td><spring:message code="code" text="subject"/></td>
                        <td><spring:message code="slNo" text="content"/></td>
                        <td><spring:message code="name" text="user"/></td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${posts}" var="post"  varStatus="loopStatus">

                        <tr class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                            <td><a href="${pageContext.request.contextPath}/post/show/<c:out value="${post.id}"/>"><spring:message code="show.link.label"/></a></td>
                            <td><c:out value="${post.subject}"/></td>
                            <td><c:out value="${post.content}"/></td>
                            <td><c:out value="${post.user.displayName}"/></td>

                            <td><a href="${pageContext.request.contextPath}/post/edit/<c:out value="${post.id}"/>"><spring:message code="edit.link.label"/></a></td>
                            <td><a href="${pageContext.request.contextPath}/post/delete/<c:out value="${post.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <!--<div class="row-fluid">-->
        <!--    <div>
            <util:pagination thispage="${posts}"></util:pagination>
        </div>-->
    </c:if>
    <c:if test="${empty posts}">
        <p>
            <spring:message code="list.page.label.no.data.found" text="No data found"/>
        </p>
    </c:if>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    
