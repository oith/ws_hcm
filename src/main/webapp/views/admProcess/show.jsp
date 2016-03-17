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
        <a href="${pageContext.request.contextPath}/admProcess/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="admProcess" text="AdmProcess"/>
        </a>
        <a href="${pageContext.request.contextPath}/admProcess/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="admProcess" text="AdmProcess"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${admProcess.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${admProcess.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${admProcess.module!=null}'>
                <dt><spring:message code='module' text='Module'/></dt>
                <dd>
                    <c:out value='${admProcess.module}'/>
                </dd>
            </c:if>
            
            <c:if test='${admProcess.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${admProcess.title}'/>
                </dd>
            </c:if>
            
            <c:if test='${admProcess.cmd!=null}'>
                <dt><spring:message code='cmd' text='Cmd'/></dt>
                <dd>
                    <c:out value='${admProcess.cmd}'/>
                </dd>
            </c:if>
            
            <c:if test='${admProcess.isActive!=null}'>
                <dt><spring:message code='isActive' text='Is Active'/></dt>
                <dd>
                    <c:choose >
                        <c:when test='${admProcess.isActive==null}'></c:when>
                        <c:when test='${admProcess.isActive}'>
                            <spring:message code='default.boolean.true' text='YES'/>
                        </c:when>
                        <c:otherwise>
                            <spring:message code='default.boolean.false' text='NO'/>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </c:if>
            
            <c:if test='${admProcess.slNo!=null}'>
                <dt><spring:message code='slNo' text='Sl No'/></dt>
                <dd>
                    <c:out value='${admProcess.slNo}'/>
                </dd>
            </c:if>
            
            <c:if test='${admProcess.remarks!=null}'>
                <dt><spring:message code='remarks' text='Remarks'/></dt>
                <dd>
                    <c:out value='${admProcess.remarks}'/>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${admProcess}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>
        <div><jsp:include page='_admProcessDetails.jsp'/></div>

    </div>
    <a href="${pageContext.request.contextPath}/admProcess/edit/${admProcess.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/admProcess/copy/${admProcess.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/admProcess/delete/${admProcess.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>