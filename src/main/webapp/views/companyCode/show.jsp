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
        <a href="${pageContext.request.contextPath}/companyCode/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="companyCode" text="CompanyCode"/>
        </a>
        <a href="${pageContext.request.contextPath}/companyCode/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="companyCode" text="CompanyCode"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>

            <c:if test='${companyCode.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${companyCode.code}'/>
                </dd>
            </c:if>

            <c:if test='${companyCode.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${companyCode.name}'/>
                </dd>
            </c:if>
            <c:if test='${companyCode.company!=null}'>
                <dt><spring:message code='company' text='Company'/></dt>
                <dd>
                    <c:if test='${companyCode.company.code!=null}'>
                    <dt><spring:message code='code' text='Code'/></dt>
                    <dd>
                        <c:out value='${companyCode.company.code}'/>
                    </dd>
                </c:if>
                <c:if test='${companyCode.company.name!=null}'>
                    <dt><spring:message code='name' text='Name'/></dt>
                    <dd>
                        <c:out value='${companyCode.company.name}'/>
                    </dd>
                </c:if>
                <c:if test='${companyCode.company.nameSecondary!=null}'>
                    <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                    <dd>
                        <c:out value='${companyCode.company.nameSecondary}'/>
                    </dd>
                </c:if>
               
                <c:if test='${companyCode.company.city!=null}'>
                    <dt><spring:message code='city' text='City'/></dt>
                    <dd>
                        <c:out value='${companyCode.company.city}'/>
                    </dd>
                </c:if>
                <c:if test='${companyCode.company.country!=null}'>
                    <dt><spring:message code='country' text='Country'/></dt>
                    <dd>
                        <c:out value='${companyCode.company.country}'/>
                    </dd>
                </c:if>
                <c:if test='${companyCode.company.language!=null}'>
                    <dt><spring:message code='language' text='Language'/></dt>
                    <dd>
                        <c:out value='${companyCode.company.language}'/>
                    </dd>
                </c:if>
                <c:if test='${companyCode.company.currency!=null}'>
                    <dt><spring:message code='currency' text='Currency'/></dt>
                    <dd>
                        <c:out value='${companyCode.company.currency}'/>
                    </dd>
                </c:if>
                </dd>
            </c:if>

            <c:if test='${companyCode.city!=null}'>
                <dt><spring:message code='city' text='City'/></dt>
                <dd>
                    <c:out value='${companyCode.city}'/>
                </dd>
            </c:if>

            <c:if test='${companyCode.country!=null}'>
                <dt><spring:message code='country' text='Country'/></dt>
                <dd>
                    <c:out value='${companyCode.country}'/>
                </dd>
            </c:if>

            <c:if test='${companyCode.language!=null}'>
                <dt><spring:message code='language' text='Language'/></dt>
                <dd>
                    <c:out value='${companyCode.language}'/>
                </dd>
            </c:if>

            <c:if test='${companyCode.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${companyCode.currency}'/>
                </dd>
            </c:if>

            <c:set target='audit' property='audit' var='audit' value='${companyCode}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/companyCode/edit/${companyCode.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/companyCode/copy/${companyCode.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/companyCode/delete/${companyCode.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>