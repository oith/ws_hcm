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
        <a href="${pageContext.request.contextPath}/personnelSubarea/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="personnelSubarea" text="PersonnelSubarea"/>
        </a>
        <a href="${pageContext.request.contextPath}/personnelSubarea/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="personnelSubarea" text="PersonnelSubarea"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${personnelSubarea.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${personnelSubarea.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${personnelSubarea.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${personnelSubarea.name}'/>
                </dd>
            </c:if>
            
            <c:if test='${personnelSubarea.personnelArea!=null}'>
                <dt><spring:message code='personnelArea' text='Personnel Area'/></dt>
                <dd>
            <c:if test='${personnelSubarea.personnelArea.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${personnelSubarea.personnelArea.code}'/>
                </dd>
            </c:if>
            <c:if test='${personnelSubarea.personnelArea.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${personnelSubarea.personnelArea.name}'/>
                </dd>
            </c:if>
            <c:if test='${personnelSubarea.personnelArea.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${personnelSubarea.personnelArea.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${personnelSubarea.personnelArea.address!=null}'>
                <dt><spring:message code='address' text='Address'/></dt>
                <dd>
                    <c:out value='${personnelSubarea.personnelArea.address}'/>
                </dd>
            </c:if>
            <c:if test='${personnelSubarea.personnelArea.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
                    <c:out value='${personnelSubarea.personnelArea.companyCode}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${personnelSubarea}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/personnelSubarea/edit/${personnelSubarea.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/personnelSubarea/copy/${personnelSubarea.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/personnelSubarea/delete/${personnelSubarea.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>