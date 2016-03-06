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
        <a href="${pageContext.request.contextPath}/joinApp/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="joinApp" text="JoinApp"/>
        </a>
        <a href="${pageContext.request.contextPath}/joinApp/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="joinApp" text="JoinApp"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${joinApp.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
            <c:if test='${joinApp.profile.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.code}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.title}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.firstName!=null}'>
                <dt><spring:message code='firstName' text='First Name'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.firstName}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.middleName!=null}'>
                <dt><spring:message code='middleName' text='Middle Name'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.middleName}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.lastName!=null}'>
                <dt><spring:message code='lastName' text='Last Name'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.lastName}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.nickName!=null}'>
                <dt><spring:message code='nickName' text='Nick Name'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.nickName}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.nid!=null}'>
                <dt><spring:message code='nid' text='Nid'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.nid}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.profilePicFile!=null}'>
                <dt><spring:message code='profilePicFile' text='Profile Pic File'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.profilePicFile}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.contactInfo!=null}'>
                <dt><spring:message code='contactInfo' text='Contact Info'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.contactInfo}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.address!=null}'>
                <dt><spring:message code='address' text='Address'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.address}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.user!=null}'>
                <dt><spring:message code='user' text='User'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.user}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.chestSize!=null}'>
                <dt><spring:message code='chestSize' text='Chest Size'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.chestSize}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.height!=null}'>
                <dt><spring:message code='height' text='Height'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.height}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.weight!=null}'>
                <dt><spring:message code='weight' text='Weight'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.weight}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.bloodGroup!=null}'>
                <dt><spring:message code='bloodGroup' text='Blood Group'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.bloodGroup}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.religion!=null}'>
                <dt><spring:message code='religion' text='Religion'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.religion}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.maritalSts!=null}'>
                <dt><spring:message code='maritalSts' text='Marital Sts'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.maritalSts}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.marriageDate!=null}'>
                <dt><spring:message code='marriageDate' text='Marriage Date'/></dt>
                <dd>
                    <fmt:formatDate value='${joinApp.profile.marriageDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.noOfChild!=null}'>
                <dt><spring:message code='noOfChild' text='No Of Child'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.noOfChild}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.contactPersonPrimary!=null}'>
                <dt><spring:message code='contactPersonPrimary' text='Contact Person Primary'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.contactPersonPrimary}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.contactPersonSecondary!=null}'>
                <dt><spring:message code='contactPersonSecondary' text='Contact Person Secondary'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.contactPersonSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.profileEduDtls!=null}'>
                <dt><spring:message code='profileEduDtls' text='Profile Edu Dtls'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.profileEduDtls}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.profile.profileJobDtls!=null}'>
                <dt><spring:message code='profileJobDtls' text='Profile Job Dtls'/></dt>
                <dd>
                    <c:out value='${joinApp.profile.profileJobDtls}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${joinApp.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${joinApp.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${joinApp.appDate!=null}'>
                <dt><spring:message code='appDate' text='App Date'/></dt>
                <dd>
                    <fmt:formatDate value='${joinApp.appDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            
            <c:if test='${joinApp.remarks!=null}'>
                <dt><spring:message code='remarks' text='Remarks'/></dt>
                <dd>
                    <c:out value='${joinApp.remarks}'/>
                </dd>
            </c:if>
            
            <c:if test='${joinApp.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
            <c:if test='${joinApp.interval.startDate!=null}'>
                <dt><spring:message code='startDate' text='Start Date'/></dt>
                <dd>
                    <fmt:formatDate value='${joinApp.interval.startDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.interval.endDate!=null}'>
                <dt><spring:message code='endDate' text='End Date'/></dt>
                <dd>
                    <fmt:formatDate value='${joinApp.interval.endDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${joinApp.position!=null}'>
                <dt><spring:message code='position' text='Position'/></dt>
                <dd>
            <c:if test='${joinApp.position.isHoHo!=null}'>
                <dt><spring:message code='isHoHo' text='Is Ho Ho'/></dt>
                <dd>
                    <c:out value='${joinApp.position.isHoHo}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.position.costCenter!=null}'>
                <dt><spring:message code='costCenter' text='Cost Center'/></dt>
                <dd>
                    <c:out value='${joinApp.position.costCenter}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${joinApp.approval!=null}'>
                <dt><spring:message code='approval' text='Approval'/></dt>
                <dd>
            <c:if test='${joinApp.approval.submitDate!=null}'>
                <dt><spring:message code='submitDate' text='Submit Date'/></dt>
                <dd>
                    <fmt:formatDate value='${joinApp.approval.submitDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.approval.originatedBy!=null}'>
                <dt><spring:message code='originatedBy' text='Originated By'/></dt>
                <dd>
                    <c:out value='${joinApp.approval.originatedBy}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.approval.approvedBy!=null}'>
                <dt><spring:message code='approvedBy' text='Approved By'/></dt>
                <dd>
                    <c:out value='${joinApp.approval.approvedBy}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.approval.checkedBy!=null}'>
                <dt><spring:message code='checkedBy' text='Checked By'/></dt>
                <dd>
                    <c:out value='${joinApp.approval.checkedBy}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.approval.recommendBy!=null}'>
                <dt><spring:message code='recommendBy' text='Recommend By'/></dt>
                <dd>
                    <c:out value='${joinApp.approval.recommendBy}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.approval.notifiedTo!=null}'>
                <dt><spring:message code='notifiedTo' text='Notified To'/></dt>
                <dd>
                    <c:out value='${joinApp.approval.notifiedTo}'/>
                </dd>
            </c:if>
            <c:if test='${joinApp.approval.submittedBy!=null}'>
                <dt><spring:message code='submittedBy' text='Submitted By'/></dt>
                <dd>
                    <c:out value='${joinApp.approval.submittedBy}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${joinApp}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>

    </div>
    <a href="${pageContext.request.contextPath}/joinApp/edit/${joinApp.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/joinApp/copy/${joinApp.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/joinApp/delete/${joinApp.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>