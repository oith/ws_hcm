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
        <a href="${pageContext.request.contextPath}/company/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="company" text="Company"/>
        </a>
        <a href="${pageContext.request.contextPath}/company/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="company" text="Company"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${company.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${company.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${company.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${company.name}'/>
                </dd>
            </c:if>
            
            <c:if test='${company.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${company.nameSecondary}'/>
                </dd>
            </c:if>
            
       <%--     <c:if test='${company.street!=null}'>
                <dt><spring:message code='street' text='Street'/></dt>
                <dd>
                    <c:out value='${company.street}'/>
                </dd>
            </c:if>
            
            <c:if test='${company.poBox!=null}'>
                <dt><spring:message code='poBox' text='Po Box'/></dt>
                <dd>
                    <c:out value='${company.poBox}'/>
                </dd>
            </c:if>
            
            <c:if test='${company.poCode!=null}'>
                <dt><spring:message code='poCode' text='Po Code'/></dt>
                <dd>
                    <c:out value='${company.poCode}'/>
                </dd>
            </c:if>--%>
            
            <c:if test='${company.city!=null}'>
                <dt><spring:message code='city' text='City'/></dt>
                <dd>
                    <c:out value='${company.city}'/>
                </dd>
            </c:if>
            
            <c:if test='${company.country!=null}'>
                <dt><spring:message code='country' text='Country'/></dt>
                <dd>
                    <c:out value='${company.country}'/>
                </dd>
            </c:if>
            
            <c:if test='${company.language!=null}'>
                <dt><spring:message code='language' text='Language'/></dt>
                <dd>
                    <c:out value='${company.language}'/>
                </dd>
            </c:if>
            
            <c:if test='${company.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${company.currency}'/>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${company}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>

    <a href="${pageContext.request.contextPath}/company/edit/${company.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/company/copy/${company.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/company/delete/${company.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>