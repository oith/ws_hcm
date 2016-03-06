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
        <a href="${pageContext.request.contextPath}/allCodeDef/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="allCodeDef" text="AllCodeDef"/>
        </a>
        <a href="${pageContext.request.contextPath}/allCodeDef/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="allCodeDef" text="AllCodeDef"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${allCodeDef.domClass!=null}'>
                <dt><spring:message code='domClass' text='Dom Class'/></dt>
                <dd>
                    <c:out value='${allCodeDef.domClass}'/>
                </dd>
            </c:if>
            
            <c:if test='${allCodeDef.mode!=null}'>
                <dt><spring:message code='mode' text='Mode'/></dt>
                <dd>
                    <c:out value='${allCodeDef.mode}'/>
                </dd>
            </c:if>
            
            <c:if test='${allCodeDef.preFix!=null}'>
                <dt><spring:message code='preFix' text='Pre Fix'/></dt>
                <dd>
                    <c:out value='${allCodeDef.preFix}'/>
                </dd>
            </c:if>
            
            <c:if test='${allCodeDef.postFix!=null}'>
                <dt><spring:message code='postFix' text='Post Fix'/></dt>
                <dd>
                    <c:out value='${allCodeDef.postFix}'/>
                </dd>
            </c:if>
            
            <c:if test='${allCodeDef.nextValue!=null}'>
                <dt><spring:message code='nextValue' text='Next Value'/></dt>
                <dd>
                    <c:out value='${allCodeDef.nextValue}'/>
                </dd>
            </c:if>
            
            <c:if test='${allCodeDef.codeLength!=null}'>
                <dt><spring:message code='codeLength' text='Code Length'/></dt>
                <dd>
                    <c:out value='${allCodeDef.codeLength}'/>
                </dd>
            </c:if>
            
            <c:if test='${allCodeDef.active!=null}'>
                <dt><spring:message code='active' text='Active'/></dt>
                <dd>
                    <c:choose >
                        <c:when test='${allCodeDef.active}'>
                            <spring:message code='default.boolean.true' text='YES'/>
                        </c:when>
                        <c:otherwise>
                            <spring:message code='default.boolean.false' text='NO'/>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${allCodeDef}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/allCodeDef/edit/${allCodeDef.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/allCodeDef/copy/${allCodeDef.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/allCodeDef/delete/${allCodeDef.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>