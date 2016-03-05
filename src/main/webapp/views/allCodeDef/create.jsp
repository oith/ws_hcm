<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri='http://www.springframework.org/tags' prefix='spring'%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/functions' prefix='fn'%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt'%>
<%@ taglib uri='http://www.springframework.org/tags/form' prefix='form'%>

<tiles:insertDefinition name='defaultTemplate' />

<tiles:putAttribute name='header'>
    <jsp:include page='/template/header.jsp' />
</tiles:putAttribute>

<tiles:putAttribute name='menu'>
    <%--<jsp:include page='/template/menu.jsp' />--%>
</tiles:putAttribute>

<tiles:putAttribute name='body'>
    <title><spring:message code='project.title.create' text='Create'/></title>
    <div>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
            <i class="glyphicon glyphicon-home"></i>
            <spring:message code="home"/>
        </a>
        <a href="${pageContext.request.contextPath}/allCodeDef/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="allCodeDef" text="AllCodeDef"/>
        </a>
    </div>
    <h1><spring:message code='create.page.title'/></h1>
    <div>
        <form:form action='${pageContext.request.contextPath}/allCodeDef/create' commandName='allCodeDef' method='POST'>
            <jsp:include page='_form.jsp' />
            <div>
                <input class='btn btn-primary' type='submit' value='<spring:message code='create.page.submit.label'/>'/>
            </div>
        </form:form>
    </div>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>