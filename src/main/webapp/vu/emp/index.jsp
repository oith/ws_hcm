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
        <a href='${pageContext.request.contextPath}/' class='btn btn-primary'>
            <i class='glyphicon glyphicon-home'></i>
            <spring:message code="home"/>
        </a>
        <a href='${pageContext.request.contextPath}/emp/create' class='btn btn-primary'>
            <i class='glyphicon glyphicon-plus'></i>
            <spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='emp' text='Emp'/>
        </a>
    </div>
    <h1><spring:message code='list.page.title'/></h1>
    <form:form action='${pageContext.request.contextPath}/emp/index' commandName='searchCriteria' method='POST'>
        <table>
            <tr>
                <td><form:label path='searchTerm'><spring:message code='label.searchTerm'/>:</form:label></td>
                <td>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="glyphicon glyphicon-search"></i>
                        </span>
                        <form:input path="searchTerm" class="form-control" type="text" id="txtSearch" size="20" />
                    </div>
                </td>
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
            <button type="submit" class="btn btn-info">
                <i class="glyphicon glyphicon-search"></i>
                <spring:message code="search.form.submit.label"/>
            </button>
        </div>
    </form:form>

    <c:if test='${emps.size()!=0}'>

        <div class='table-responsive'>
            <table class='table table-striped table-bordered table-hover table-condensed'>
                <thead>
                    <tr>
                        <th></th>
                        <th><spring:message code='code' text='Code'/></th>
                        <th><spring:message code='name' text='Name'/></th>
                        <th><spring:message code='nameSecondary' text='Name Secondary'/></th>
                        <th><spring:message code='interval' text='Interval'/></th>
                        <th><spring:message code='description' text='Description'/></th>
                        <th><spring:message code='profile' text='Profile'/></th>
                        <th><spring:message code='doj' text='Doj'/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items='${emps}' var='emp'  varStatus='loopStatus'>
                        <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                            <td>
                                <a href="${pageContext.request.contextPath}/emp/show/${emp.id}" class="btn btn-info">
                                    <i class="glyphicon glyphicon-book"></i>
                                    <spring:message code="show.link.label"/>
                                </a>
                            </td>
                            <td><c:out value='${emp.code}'/></td>
                            <td><c:out value='${emp.name}'/></td>
                            <td><c:out value='${emp.nameSecondary}'/></td>
                            <td><c:out value='${emp.interval}'/></td>
                            <td><c:out value='${emp.description}'/></td>
                            <td><c:out value='${emp.profile}'/></td>
                            <td><fmt:formatDate value='${emp.doj}' type='date' pattern='dd/MM/yyyy'/></td>
                          
                            <td>
                                <a href="${pageContext.request.contextPath}/emp/edit/${emp.id}" class="btn btn-warning">
                                    <i class="glyphicon glyphicon-edit"></i>
                                    <spring:message code="edit.link.label"/>
                                </a>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/emp/copy/${emp.id}" class="btn btn-primary">
                                    <i class="glyphicon glyphicon-copy"></i>
                                    <spring:message code="copy.link.label"/>
                                </a>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/emp/delete/${emp.id}" class="btn btn-danger" onclick="return confirm('Are you sure to delete?');" >
                                    <i class="glyphicon glyphicon-remove"></i>
                                    <spring:message code="delete.link.label"/>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test='${empty emps}'>
        <p>
            <spring:message code='list.page.label.no.data.found' text='No data found'/>
        </p>
    </c:if>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>