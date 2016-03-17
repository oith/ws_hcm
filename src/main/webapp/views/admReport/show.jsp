<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags' %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form' %>

<tiles:insertDefinition name='defaultTemplate' />

<tiles:putAttribute name='header'>
    <jsp:include page='/template/header.jsp' />
</tiles:putAttribute>

<tiles:putAttribute name='menu'>
    <%--<jsp:include page='/template/menu.jsp' />--%>
</tiles:putAttribute>

<tiles:putAttribute name='body'>
    <title><spring:message code='project.title.show' text='Show'/></title>
    <div>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
            <i class="glyphicon glyphicon-home"></i>
            <spring:message code="home"/>
        </a>
        <a href="${pageContext.request.contextPath}/admReport/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="admReport" text="AdmReport"/>
        </a>
        <a href="${pageContext.request.contextPath}/admReport/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="admReport" text="AdmReport"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${admReport.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${admReport.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${admReport.module!=null}'>
                <dt><spring:message code='module' text='Module'/></dt>
                <dd>
                    <c:out value='${admReport.module}'/>
                </dd>
            </c:if>
            
            <c:if test='${admReport.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${admReport.title}'/>
                </dd>
            </c:if>
            
            <c:if test='${admReport.fileName!=null}'>
                <dt><spring:message code='fileName' text='File Name'/></dt>
                <dd>
                    <c:out value='${admReport.fileName}'/>
                </dd>
            </c:if>
            
            <c:if test='${admReport.isActive!=null}'>
                <dt><spring:message code='isActive' text='Is Active'/></dt>
                <dd>
                    <c:choose >
                        <c:when test='${admReport.isActive==null}'></c:when>
                        <c:when test='${admReport.isActive}'>
                            <spring:message code='default.boolean.true' text='YES'/>
                        </c:when>
                        <c:otherwise>
                            <spring:message code='default.boolean.false' text='NO'/>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </c:if>
            
            <c:if test='${admReport.slNo!=null}'>
                <dt><spring:message code='slNo' text='Sl No'/></dt>
                <dd>
                    <c:out value='${admReport.slNo}'/>
                </dd>
            </c:if>
            
            <c:if test='${admReport.tags!=null}'>
                <dt><spring:message code='tags' text='Tags'/></dt>
                <dd>
                    <c:if test='${not empty admReport.tags}'>
                        <c:set var='oith_var_tags'/>
                        <c:set var='oith_var_tags'/>
                        <c:forEach items='${admReport.tags}' var='oith_val_tags'>
                            <c:set var='oith_var_tags' value='${oith_var_tags}, ${oith_val_tags}'/>
                        </c:forEach> 
                        <c:out value='[${oith_var_tags.substring(2)}]'/>
                    </c:if>
                </dd>
            </c:if>

            <c:if test='${admReport.supportFormats!=null}'>
                <dt><spring:message code='supportFormats' text='Support Formats'/></dt>
                <dd>
                    <c:if test='${not empty admReport.supportFormats}'>
                        <c:set var='oith_var_supportFormats'/>
                        <c:set var='oith_var_supportFormats'/>
                        <c:forEach items='${admReport.supportFormats}' var='oith_val_supportFormats'>
                            <c:set var='oith_var_supportFormats' value='${oith_var_supportFormats}, ${oith_val_supportFormats}'/>
                        </c:forEach> 
                        <c:out value='[${oith_var_supportFormats.substring(2)}]'/>
                    </c:if>
                </dd>
            </c:if>
            
            <c:if test='${admReport.remarks!=null}'>
                <dt><spring:message code='remarks' text='Remarks'/></dt>
                <dd>
                    <c:out value='${admReport.remarks}'/>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${admReport}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>
        <div><jsp:include page='_admReportDetails.jsp'/></div>

    </div>
    <a href="${pageContext.request.contextPath}/admReport/edit/${admReport.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/admReport/copy/${admReport.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/admReport/delete/${admReport.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>