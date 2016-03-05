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
        <a href="${pageContext.request.contextPath}/coa/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="coa" text="Coa"/>
        </a>
        <a href="${pageContext.request.contextPath}/coa/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="coa" text="Coa"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${coa.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${coa.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${coa.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${coa.title}'/>
                </dd>
            </c:if>
            
            <c:if test='${coa.retainedEarningsAccount!=null}'>
                <dt><spring:message code='retainedEarningsAccount' text='Retained Earnings Account'/></dt>
                <dd>
            <c:if test='${coa.retainedEarningsAccount.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${coa.retainedEarningsAccount.code}'/>
                </dd>
            </c:if>
            <c:if test='${coa.retainedEarningsAccount.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${coa.retainedEarningsAccount.title}'/>
                </dd>
            </c:if>
            <c:if test='${coa.retainedEarningsAccount.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${coa.retainedEarningsAccount.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${coa.retainedEarningsAccount.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
                    <c:out value='${coa.retainedEarningsAccount.companyCode}'/>
                </dd>
            </c:if>
            <c:if test='${coa.retainedEarningsAccount.accountGroup!=null}'>
                <dt><spring:message code='accountGroup' text='Account Group'/></dt>
                <dd>
                    <c:out value='${coa.retainedEarningsAccount.accountGroup}'/>
                </dd>
            </c:if>
            <c:if test='${coa.retainedEarningsAccount.accountStatement!=null}'>
                <dt><spring:message code='accountStatement' text='Account Statement'/></dt>
                <dd>
                    <c:out value='${coa.retainedEarningsAccount.accountStatement}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${coa.lengthOfAccount!=null}'>
                <dt><spring:message code='lengthOfAccount' text='Length Of Account'/></dt>
                <dd>
                    <c:out value='${coa.lengthOfAccount}'/>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${coa}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/coa/edit/${coa.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/coa/copy/${coa.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/coa/delete/${coa.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>