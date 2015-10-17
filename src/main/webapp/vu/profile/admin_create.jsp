<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
admin create from user
<tiles:putAttribute name="body">

    <title><spring:message code="project.title.create" text="Create"/></title>

    <div>   
        <a hre f="${pageContext.request.contextPath}/"><spring:message code="home" text="Home"/></a> 
    </div>

    <h1><spring:message code="create.page.title"/></h1>
    <div>
        <form:form action="${pageContext.request.contextPath}/admin/profile/admin_create" enctype="multipart/form-data" commandName="profile" method="POST">
            <input type="hidden" id="userId" value="${userId}" name="userId"/>
            <%--<form:hidden path="user"/>--%>
            <jsp:include page="_admin_form.jsp" />
            <div>
                <input type="submit" value="<spring:message code="create.page.submit.label"/>"/>
            </div>
        </form:form>
    </div>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute> 