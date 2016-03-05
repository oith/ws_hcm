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
        <a href="${pageContext.request.contextPath}/account/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="account" text="Account"/>
        </a>
        <a href="${pageContext.request.contextPath}/account/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="account" text="Account"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${account.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${account.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${account.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${account.title}'/>
                </dd>
            </c:if>
            
            <c:if test='${account.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${account.nameSecondary}'/>
                </dd>
            </c:if>
            
            <c:if test='${account.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>

                </dd>
            </c:if>
            
            <c:if test='${account.accountGroup!=null}'>
                <dt><spring:message code='accountGroup' text='Account Group'/></dt>
                <dd>
            <c:if test='${account.accountGroup.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
                    <c:out value='${account.accountGroup.coa}'/>
                </dd>
            </c:if>
            <c:if test='${account.accountGroup.accountGroup!=null}'>
                <dt><spring:message code='accountGroup' text='Account Group'/></dt>
                <dd>
                    <c:out value='${account.accountGroup.accountGroup}'/>
                </dd>
            </c:if>
            <c:if test='${account.accountGroup.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${account.accountGroup.title}'/>
                </dd>
            </c:if>
            <c:if test='${account.accountGroup.fromAccount!=null}'>
                <dt><spring:message code='fromAccount' text='From Account'/></dt>
                <dd>
                    <c:out value='${account.accountGroup.fromAccount}'/>
                </dd>
            </c:if>
            <c:if test='${account.accountGroup.toAccount!=null}'>
                <dt><spring:message code='toAccount' text='To Account'/></dt>
                <dd>
                    <c:out value='${account.accountGroup.toAccount}'/>
                </dd>
            </c:if>
            <c:if test='${account.accountGroup.active!=null}'>
                <dt><spring:message code='active' text='Active'/></dt>
                <dd>
                    <c:out value='${account.accountGroup.active}'/>
                </dd>
            </c:if>
            <c:if test='${account.accountGroup.slNo!=null}'>
                <dt><spring:message code='slNo' text='Sl No'/></dt>
                <dd>
                    <c:out value='${account.accountGroup.slNo}'/>
                </dd>
            </c:if>
            <c:if test='${account.accountGroup.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${account.accountGroup.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${account.accountStatement!=null}'>
                <dt><spring:message code='accountStatement' text='Account Statement'/></dt>
                <dd>
                    <c:out value='${account.accountStatement}'/>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${account}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/account/edit/${account.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/account/copy/${account.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/account/delete/${account.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>