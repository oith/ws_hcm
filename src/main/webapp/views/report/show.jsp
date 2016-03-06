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
        <a href='${pageContext.request.contextPath}/'><spring:message code='home'/></a> |
        <a href='${pageContext.request.contextPath}/report/index'><spring:message code='list.link.label'/>&NonBreakingSpace;<spring:message code='report' text='Report'/></a> |
        <a href='${pageContext.request.contextPath}/report/create'><spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='report' text='Report'/></a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${report.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${report.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${report.reportGroup!=null}'>
                <dt><spring:message code='reportGroup' text='Report Group'/></dt>
                <dd>
                    <c:out value='${report.reportGroup}'/>
                </dd>
            </c:if>
            
            <c:if test='${report.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${report.title}'/>
                </dd>
            </c:if>
            
            <c:if test='${report.fileName!=null}'>
                <dt><spring:message code='fileName' text='File Name'/></dt>
                <dd>
                    <c:out value='${report.fileName}'/>
                </dd>
            </c:if>
            
            <c:if test='${report.isActive!=null}'>
                <dt><spring:message code='isActive' text='Is Active'/></dt>
                <dd>
                    <c:choose >
                        <c:when test='${report.isActive}'>
                            <spring:message code='default.boolean.true' text='YES'/>
                        </c:when>
                        <c:otherwise>
                            <spring:message code='default.boolean.false' text='NO'/>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </c:if>
            
            <c:if test='${report.slNo!=null}'>
                <dt><spring:message code='slNo' text='Sl No'/></dt>
                <dd>
                    <c:out value='${report.slNo}'/>
                </dd>
            </c:if>
            
            <c:if test='${report.tags!=null}'>
                <dt><spring:message code='tags' text='Tags'/></dt>
                <dd>
                    <c:set var='oith_var_tags'/>
                    <c:forEach items='${report.tags}' var='oith_val_tags'>
                        <c:set var='oith_var_tags' value='${oith_var_tags}, ${oith_val_tags}'/>
                    </c:forEach> 
                    <c:out value='[${oith_var_tags.substring(2)}]'/>
                </dd>
            </c:if>
            
            <c:if test='${report.supportFormatArrs!=null}'>
                <dt><spring:message code='supportFormatArrs' text='Support Format Arrs'/></dt>
                <dd>
                    <c:set var='oith_var_supportFormatArrs'/>
                    <c:forEach items='${report.supportFormatArrs}' var='oith_val_supportFormatArrs'>
                        <c:set var='oith_var_supportFormatArrs' value='${oith_var_supportFormatArrs}, ${oith_val_supportFormatArrs}'/>
                    </c:forEach> 
                    <c:out value='[${oith_var_supportFormatArrs.substring(2)}]'/>
                </dd>
            </c:if>
            
            <c:if test='${report.supportFormats!=null}'>
                <dt><spring:message code='supportFormats' text='Support Formats'/></dt>
                <dd>
                    <c:set var='oith_var_supportFormats'/>
                    <c:forEach items='${report.supportFormats}' var='oith_val_supportFormats'>
                        <c:set var='oith_var_supportFormats' value='${oith_var_supportFormats}, ${oith_val_supportFormats}'/>
                    </c:forEach> 
                    <c:out value='[${oith_var_supportFormats.substring(2)}]'/>
                </dd>
            </c:if>
            
            <c:if test='${report.remarks!=null}'>
                <dt><spring:message code='remarks' text='Remarks'/></dt>
                <dd>
                    <c:out value='${report.remarks}'/>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${report}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>
        <div><jsp:include page='_reportDetails.jsp'/></div>

    </div>
    <a href='${pageContext.request.contextPath}/report/edit/<c:out value='${report.id}'/>'><spring:message code='edit.link.label'/></a> |
    <a href='${pageContext.request.contextPath}/report/copy/<c:out value='${report.id}'/>'><spring:message code='copy.link.label'/></a> |
    <a href='${pageContext.request.contextPath}/report/delete/<c:out value='${report.id}'/>' onclick='return confirm('Are you sure to delete?');' ><spring:message code='delete.link.label'/></a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>