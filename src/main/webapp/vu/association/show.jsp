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
        <a href="${pageContext.request.contextPath}/association/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="association" text="Association"/>
        </a>
        <a href="${pageContext.request.contextPath}/association/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="association" text="Association"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${association.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${association.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${association.hcmObjectAlpha!=null}'>
                <dt><spring:message code='hcmObjectAlpha' text='Hcm Object Alpha'/></dt>
                <dd>
            <c:if test='${association.hcmObjectAlpha.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectAlpha.code}'/>
                </dd>
            </c:if>
            <c:if test='${association.hcmObjectAlpha.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectAlpha.name}'/>
                </dd>
            </c:if>
            <c:if test='${association.hcmObjectAlpha.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectAlpha.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${association.hcmObjectAlpha.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectAlpha.interval}'/>
                </dd>
            </c:if>
            <c:if test='${association.hcmObjectAlpha.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectAlpha.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${association.hcmObjectBeta!=null}'>
                <dt><spring:message code='hcmObjectBeta' text='Hcm Object Beta'/></dt>
                <dd>
            <c:if test='${association.hcmObjectBeta.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectBeta.code}'/>
                </dd>
            </c:if>
            <c:if test='${association.hcmObjectBeta.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectBeta.name}'/>
                </dd>
            </c:if>
            <c:if test='${association.hcmObjectBeta.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectBeta.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${association.hcmObjectBeta.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectBeta.interval}'/>
                </dd>
            </c:if>
            <c:if test='${association.hcmObjectBeta.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${association.hcmObjectBeta.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${association.relType!=null}'>
                <dt><spring:message code='relType' text='Rel Type'/></dt>
                <dd>
                    <c:out value='${association.relType}'/>
                </dd>
            </c:if>
            
            <c:if test='${association.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
            <c:if test='${association.interval.startDate!=null}'>
                <dt><spring:message code='startDate' text='Start Date'/></dt>
                <dd>
                    <fmt:formatDate value='${association.interval.startDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${association.interval.endDate!=null}'>
                <dt><spring:message code='endDate' text='End Date'/></dt>
                <dd>
                    <fmt:formatDate value='${association.interval.endDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${association}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/association/edit/${association.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/association/copy/${association.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/association/delete/${association.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>