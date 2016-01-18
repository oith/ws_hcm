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
        <a href='${pageContext.request.contextPath}/report/create'><spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='report' text='Report'/></a>
    </div>
    <h1><spring:message code='list.page.title'/></h1>
    <form:form action='${pageContext.request.contextPath}/report/index' commandName='searchCriteria' method='POST'>
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

    <c:if test='${reports.size()!=0}'>

        <div class='table-responsive'>
            <table class='table table-striped table-bordered table-hover table-condensed'>
                <thead>
                    <tr>
                        <th></th>
                        <th><spring:message code='code' text='Code'/></th>
                        <th><spring:message code='reportGroup' text='Report Group'/></th>
                        <th><spring:message code='title' text='Title'/></th>
                        <th><spring:message code='fileName' text='File Name'/></th>
                        <th><spring:message code='isActive' text='Is Active'/></th>
                        <th><spring:message code='slNo' text='Sl No'/></th>
                        <th><spring:message code='tags' text='Tags'/></th>
                        <th><spring:message code='supportFormatArrs' text='Support Format Arrs'/></th>
                        <th><spring:message code='supportFormats' text='Support Formats'/></th>
                        <th><spring:message code='reportDetails' text='Report Details'/></th>
                        <th><spring:message code='remarks' text='Remarks'/></th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach items='${reports}' var='report'  varStatus='loopStatus'>
                        <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                            <td><a href='${pageContext.request.contextPath}/report/show/${report.id}'><spring:message code='show.link.label'/></a></td>
                            <td><c:out value='${report.code}'/></td>
                            <td><c:out value='${report.reportGroup}'/></td>
                            <td><c:out value='${report.title}'/></td>
                            <td><c:out value='${report.fileName}'/></td>
                            <td>
                                <c:choose >
                                    <c:when test='${report.isActive}'>
                                        <spring:message code='default.boolean.true' text='YES'/>
                                    </c:when>
                                    <c:otherwise>
                                        <spring:message code='default.boolean.false' text='NO'/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value='${report.slNo}'/></td>
                            <td>
                                <c:set var='oith_var_tags'/>
                                <c:forEach items='${report.tags}' var='oith_val_tags'>
                                    <c:set var='oith_var_tags' value='${oith_var_tags}, ${oith_val_tags}'/>
                                </c:forEach> 
                                <c:out value='[${oith_var_tags.substring(2)}]'/>
                            </td>
                            <td>
                                <c:set var='oith_var_supportFormatArrs'/>
                                <c:forEach items='${report.supportFormatArrs}' var='oith_val_supportFormatArrs'>
                                    <c:set var='oith_var_supportFormatArrs' value='${oith_var_supportFormatArrs}, ${oith_val_supportFormatArrs}'/>
                                </c:forEach> 
                                <c:out value='[${oith_var_supportFormatArrs.substring(2)}]'/>
                            </td>
                            <td>
                                <c:set var='oith_var_supportFormats'/>
                                <c:forEach items='${report.supportFormats}' var='oith_val_supportFormats'>
                                    <c:set var='oith_var_supportFormats' value='${oith_var_supportFormats}, ${oith_val_supportFormats}'/>
                                </c:forEach> 
                                <c:out value='[${oith_var_supportFormats.substring(2)}]'/>
                            </td>
                            <td><c:out value='${report.reportDetails}'/></td>
                            <td><c:out value='${report.remarks}'/></td>

                            <td><a href='${pageContext.request.contextPath}/report/edit/${report.id}'><spring:message code='edit.link.label'/></a></td>
                            <td><a href='${pageContext.request.contextPath}/report/copy/${report.id}'><spring:message code='copy.link.label'/></a></td>
                            <td><a href='${pageContext.request.contextPath}/report/delete/${report.id}' onclick='return confirm('Are you sure to delete?');' ><spring:message code='delete.link.label'/></a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test='${empty reports}'>
        <p>
            <spring:message code='list.page.label.no.data.found' text='No data found'/>
        </p>
    </c:if>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>