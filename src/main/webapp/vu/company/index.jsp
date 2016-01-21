<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>

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
    <title><spring:message code='project.title.index' text='Index'/></title>
    <script>window.jQuery || document.write('<script src='<%=request.getContextPath()%>/js/jquery-1.7.2.min.js'><\/script>')</script>
    <div>
        <a href='${pageContext.request.contextPath}/'><spring:message code='home'/></a> |
        <a href='${pageContext.request.contextPath}/company/create'><spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='company' text='Company'/></a>
    </div>
    <h1><spring:message code='list.page.title'/></h1>
    <form:form action='${pageContext.request.contextPath}/company/index' commandName='searchCriteria' method='POST'>
        <table>
            <tr>
                <td><form:label path='searchTerm'><spring:message code='label.searchTerm'/>:</form:label></td>
                <td><form:input path='searchTerm' class='form-control' type='text' id='txtSearch' size='20'/></td>
                <td><span class='label label-info'><spring:message code='foundRec' arguments='${searchCriteria.totalRecs}' htmlEscape='false' /></span></td>
            </tr>
            <tr>
                <td><form:label path='pageSize'><spring:message code='label.pageSize'/>:</form:label></td>
                <td><form:select path='pageSize' class='form-control'>
                        <form:option value='5' label='5' />
                        <form:option value='10' label='10' />
                        <form:option value='20' label='20' />
                        <form:option value='50' label='50' />
                        <form:option value='100' label='100' />
                        <form:option value='200' label='200' />
                        <form:option value='500' label='500' />
                        <form:option value='1000' label='1000' />
                        <%--   <form:options items='${pageSize}' />--%>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td><form:label path='page'><spring:message code='label.page'/>:</form:label></td>
                <td><form:select path='page' class='form-control'>
                        <%--<form:option value='-1' label='...Select...' />--%>
                        <form:options items='${pages}' />
                    </form:select>
                </td>
            </tr>
        </table>
        <div>
            <button type='submit' class='btn btn-info'>
                <span class='glyphicon glyphicon-search'></span><spring:message code='search.form.submit.label'/>
            </button>
        </div>
    </form:form>

    <c:if test='${companys.size()!=0}'>

        <div class='table-responsive'>
            <table class='table table-striped table-bordered table-hover table-condensed'>
                <thead>
                    <tr>
                        <th></th>
                        <th><spring:message code='auditor' text='Auditor'/></th>
                        <th><spring:message code='code' text='Code'/></th>
                        <th><spring:message code='name' text='Name'/></th>
                        <th><spring:message code='nameSecondary' text='Name Secondary'/></th>
                        <th><spring:message code='street' text='Street'/></th>
                        <th><spring:message code='poBox' text='Po Box'/></th>
                        <th><spring:message code='poCode' text='Po Code'/></th>
                        <th><spring:message code='city' text='City'/></th>
                        <th><spring:message code='country' text='Country'/></th>
                        <th><spring:message code='language' text='Language'/></th>
                        <th><spring:message code='currency' text='Currency'/></th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach items='${companys}' var='company'  varStatus='loopStatus'>
                        <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                            <td><a href='${pageContext.request.contextPath}/company/show/${company.id}'><spring:message code='show.link.label'/></a></td>
                            <td><c:out value='${company.auditor}'/></td>
                            <td><c:out value='${company.code}'/></td>
                            <td><c:out value='${company.name}'/></td>
                            <td><c:out value='${company.nameSecondary}'/></td>
                            <td><c:out value='${company.street}'/></td>
                            <td><c:out value='${company.poBox}'/></td>
                            <td><c:out value='${company.poCode}'/></td>
                            <td><c:out value='${company.city}'/></td>
                            <td><c:out value='${company.country}'/></td>
                            <td><c:out value='${company.language}'/></td>
                            <td><c:out value='${company.currency}'/></td>

                            <td><a href='${pageContext.request.contextPath}/company/edit/${company.id}'><spring:message code='edit.link.label'/></a></td>
                            <td><a href='${pageContext.request.contextPath}/company/copy/${company.id}'><spring:message code='copy.link.label'/></a></td>
                            <td><a href='${pageContext.request.contextPath}/company/delete/${company.id}' onclick='return confirm('Are you sure to delete?');' ><spring:message code='delete.link.label'/></a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test='${empty companys}'>
        <p>
            <spring:message code='list.page.label.no.data.found' text='No data found'/>
        </p>
    </c:if>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>