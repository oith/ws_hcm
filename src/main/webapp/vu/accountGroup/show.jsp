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
        <a href="${pageContext.request.contextPath}/accountGroup/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="accountGroup" text="AccountGroup"/>
        </a>
        <a href="${pageContext.request.contextPath}/accountGroup/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="accountGroup" text="AccountGroup"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${accountGroup.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
            <c:if test='${accountGroup.coa.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${accountGroup.coa.code}'/>
                </dd>
            </c:if>
            <c:if test='${accountGroup.coa.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${accountGroup.coa.title}'/>
                </dd>
            </c:if>
            <c:if test='${accountGroup.coa.retainedEarningsAccount!=null}'>
                <dt><spring:message code='retainedEarningsAccount' text='Retained Earnings Account'/></dt>
                <dd>
                    <c:out value='${accountGroup.coa.retainedEarningsAccount}'/>
                </dd>
            </c:if>
            <c:if test='${accountGroup.coa.lengthOfAccount!=null}'>
                <dt><spring:message code='lengthOfAccount' text='Length Of Account'/></dt>
                <dd>
                    <c:out value='${accountGroup.coa.lengthOfAccount}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${accountGroup.accountGroup!=null}'>
                <dt><spring:message code='accountGroup' text='Account Group'/></dt>
                <dd>
                    <c:out value='${accountGroup.accountGroup}'/>
                </dd>
            </c:if>
            
            <c:if test='${accountGroup.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${accountGroup.title}'/>
                </dd>
            </c:if>
            
            <c:if test='${accountGroup.fromAccount!=null}'>
                <dt><spring:message code='fromAccount' text='From Account'/></dt>
                <dd>
                    <c:out value='${accountGroup.fromAccount}'/>
                </dd>
            </c:if>
            
            <c:if test='${accountGroup.toAccount!=null}'>
                <dt><spring:message code='toAccount' text='To Account'/></dt>
                <dd>
                    <c:out value='${accountGroup.toAccount}'/>
                </dd>
            </c:if>
            
            <c:if test='${accountGroup.active!=null}'>
                <dt><spring:message code='active' text='Active'/></dt>
                <dd>
                    <c:choose >
                        <c:when test='${accountGroup.active==null}'></c:when>
                        <c:when test='${accountGroup.active}'>
                            <spring:message code='default.boolean.true' text='YES'/>
                        </c:when>
                        <c:otherwise>
                            <spring:message code='default.boolean.false' text='NO'/>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </c:if>
            
            <c:if test='${accountGroup.slNo!=null}'>
                <dt><spring:message code='slNo' text='Sl No'/></dt>
                <dd>
                    <c:out value='${accountGroup.slNo}'/>
                </dd>
            </c:if>
            
            <c:if test='${accountGroup.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${accountGroup.description}'/>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${accountGroup}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/accountGroup/edit/${accountGroup.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/accountGroup/copy/${accountGroup.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/accountGroup/delete/${accountGroup.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>