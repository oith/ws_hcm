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
        <a href="${pageContext.request.contextPath}/emp/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="emp" text="Emp"/>
        </a>
        <a href="${pageContext.request.contextPath}/emp/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="emp" text="Emp"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>

            <c:if test='${emp.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${emp.code}'/>
                </dd>
            </c:if>

            <c:if test='${emp.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${emp.name}'/>
                </dd>
            </c:if>

            <c:if test='${emp.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${emp.nameSecondary}'/>
                </dd>
            </c:if>

            <c:if test='${emp.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:if test='${emp.interval.startDate!=null}'>
                    <dt><spring:message code='startDate' text='Start Date'/></dt>
                    <dd>
                        <fmt:formatDate value='${emp.interval.startDate}' type='date' pattern='dd/MM/yyyy'/>
                    </dd>
                </c:if>
                <c:if test='${emp.interval.endDate!=null}'>
                    <dt><spring:message code='endDate' text='End Date'/></dt>
                    <dd>
                        <fmt:formatDate value='${emp.interval.endDate}' type='date' pattern='dd/MM/yyyy'/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:if test='${emp.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${emp.description}'/>
                </dd>
            </c:if>

            <c:if test='${emp.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
                    <c:if test='${emp.profile.code!=null}'>
                    <dt><spring:message code='code' text='Code'/></dt>
                    <dd>
                        <c:out value='${emp.profile.code}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.title!=null}'>
                    <dt><spring:message code='title' text='Title'/></dt>
                    <dd>
                        <c:out value='${emp.profile.title}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.firstName!=null}'>
                    <dt><spring:message code='firstName' text='First Name'/></dt>
                    <dd>
                        <c:out value='${emp.profile.firstName}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.middleName!=null}'>
                    <dt><spring:message code='middleName' text='Middle Name'/></dt>
                    <dd>
                        <c:out value='${emp.profile.middleName}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.lastName!=null}'>
                    <dt><spring:message code='lastName' text='Last Name'/></dt>
                    <dd>
                        <c:out value='${emp.profile.lastName}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.nickName!=null}'>
                    <dt><spring:message code='nickName' text='Nick Name'/></dt>
                    <dd>
                        <c:out value='${emp.profile.nickName}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.nid!=null}'>
                    <dt><spring:message code='nid' text='Nid'/></dt>
                    <dd>
                        <c:out value='${emp.profile.nid}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.profilePicFile!=null}'>
                    <dt><spring:message code='profilePicFile' text='Profile Pic File'/></dt>
                    <dd>
                        <c:out value='${emp.profile.profilePicFile}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.contactInfo!=null}'>
                    <dt><spring:message code='contactInfo' text='Contact Info'/></dt>
                    <dd>
                        <c:out value='${emp.profile.contactInfo}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.address!=null}'>
                    <dt><spring:message code='address' text='Address'/></dt>
                    <dd>
                        <c:out value='${emp.profile.address}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.user!=null}'>
                    <dt><spring:message code='user' text='User'/></dt>
                    <dd>
                        <c:out value='${emp.profile.user}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.chestSize!=null}'>
                    <dt><spring:message code='chestSize' text='Chest Size'/></dt>
                    <dd>
                        <c:out value='${emp.profile.chestSize}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.height!=null}'>
                    <dt><spring:message code='height' text='Height'/></dt>
                    <dd>
                        <c:out value='${emp.profile.height}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.weight!=null}'>
                    <dt><spring:message code='weight' text='Weight'/></dt>
                    <dd>
                        <c:out value='${emp.profile.weight}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.bloodGroup!=null}'>
                    <dt><spring:message code='bloodGroup' text='Blood Group'/></dt>
                    <dd>
                        <c:out value='${emp.profile.bloodGroup}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.religion!=null}'>
                    <dt><spring:message code='religion' text='Religion'/></dt>
                    <dd>
                        <c:out value='${emp.profile.religion}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.maritalSts!=null}'>
                    <dt><spring:message code='maritalSts' text='Marital Sts'/></dt>
                    <dd>
                        <c:out value='${emp.profile.maritalSts}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.marriageDate!=null}'>
                    <dt><spring:message code='marriageDate' text='Marriage Date'/></dt>
                    <dd>
                        <fmt:formatDate value='${emp.profile.marriageDate}' type='date' pattern='dd/MM/yyyy'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.noOfChild!=null}'>
                    <dt><spring:message code='noOfChild' text='No Of Child'/></dt>
                    <dd>
                        <c:out value='${emp.profile.noOfChild}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.contactPersonPrimary!=null}'>
                    <dt><spring:message code='contactPersonPrimary' text='Contact Person Primary'/></dt>
                    <dd>
                        <c:out value='${emp.profile.contactPersonPrimary}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.contactPersonSecondary!=null}'>
                    <dt><spring:message code='contactPersonSecondary' text='Contact Person Secondary'/></dt>
                    <dd>
                        <c:out value='${emp.profile.contactPersonSecondary}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.profileEduDtls!=null}'>
                    <dt><spring:message code='profileEduDtls' text='Profile Edu Dtls'/></dt>
                    <dd>
                        <c:out value='${emp.profile.profileEduDtls}'/>
                    </dd>
                </c:if>
                <c:if test='${emp.profile.profileJobDtls!=null}'>
                    <dt><spring:message code='profileJobDtls' text='Profile Job Dtls'/></dt>
                    <dd>
                        <c:out value='${emp.profile.profileJobDtls}'/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:if test='${emp.doj!=null}'>
                <dt><spring:message code='doj' text='Doj'/></dt>
                <dd>
                    <fmt:formatDate value='${emp.doj}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>

           

            <c:set target='audit' property='audit' var='audit' value='${emp}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/emp/edit/${emp.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/emp/copy/${emp.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/emp/delete/${emp.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>