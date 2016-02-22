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
        <a href="${pageContext.request.contextPath}/hcmObject/index" class="btn btn-info">
            <i class="glyphicon glyphicon-list"></i>
            <spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="hcmObject" text="HcmObject"/>
        </a>
        <a href="${pageContext.request.contextPath}/hcmObject/create" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>
            <spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="hcmObject" text="HcmObject"/>
        </a>
    </div>
    <h1><spring:message code='show.page.title'/></h1>
    <div>
        <dl class='dl-horizontal'>
            
            <c:if test='${hcmObject.hcmObjectType!=null}'>
                <dt><spring:message code='hcmObjectType' text='Hcm Object Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.hcmObjectType}'/>
                </dd>
            </c:if>
            
            <c:if test='${hcmObject.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.code}'/>
                </dd>
            </c:if>
            
            <c:if test='${hcmObject.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.name}'/>
                </dd>
            </c:if>
            
            <c:if test='${hcmObject.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${hcmObject.nameSecondary}'/>
                </dd>
            </c:if>
            
            <c:if test='${hcmObject.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
            <c:if test='${hcmObject.interval.startDate!=null}'>
                <dt><spring:message code='startDate' text='Start Date'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.interval.startDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.interval.endDate!=null}'>
                <dt><spring:message code='endDate' text='End Date'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.interval.endDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
            <c:if test='${hcmObject.profile.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.title}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.firstName!=null}'>
                <dt><spring:message code='firstName' text='First Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.firstName}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.middleName!=null}'>
                <dt><spring:message code='middleName' text='Middle Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.middleName}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.lastName!=null}'>
                <dt><spring:message code='lastName' text='Last Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.lastName}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.nickName!=null}'>
                <dt><spring:message code='nickName' text='Nick Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.nickName}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.nid!=null}'>
                <dt><spring:message code='nid' text='Nid'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.nid}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.profilePicFile!=null}'>
                <dt><spring:message code='profilePicFile' text='Profile Pic File'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.profilePicFile}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.contactInfo!=null}'>
                <dt><spring:message code='contactInfo' text='Contact Info'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.contactInfo}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.address!=null}'>
                <dt><spring:message code='address' text='Address'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.address}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.user!=null}'>
                <dt><spring:message code='user' text='User'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.user}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.chestSize!=null}'>
                <dt><spring:message code='chestSize' text='Chest Size'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.chestSize}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.height!=null}'>
                <dt><spring:message code='height' text='Height'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.height}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.weight!=null}'>
                <dt><spring:message code='weight' text='Weight'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.weight}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.bloodGroup!=null}'>
                <dt><spring:message code='bloodGroup' text='Blood Group'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.bloodGroup}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.religion!=null}'>
                <dt><spring:message code='religion' text='Religion'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.religion}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.maritalSts!=null}'>
                <dt><spring:message code='maritalSts' text='Marital Sts'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.maritalSts}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.marriageDate!=null}'>
                <dt><spring:message code='marriageDate' text='Marriage Date'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.profile.marriageDate}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.noOfChild!=null}'>
                <dt><spring:message code='noOfChild' text='No Of Child'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.noOfChild}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.contactPersonPrimary!=null}'>
                <dt><spring:message code='contactPersonPrimary' text='Contact Person Primary'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.contactPersonPrimary}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.contactPersonSecondary!=null}'>
                <dt><spring:message code='contactPersonSecondary' text='Contact Person Secondary'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.contactPersonSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.profileEduDtls!=null}'>
                <dt><spring:message code='profileEduDtls' text='Profile Edu Dtls'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.profileEduDtls}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.profile.profileJobDtls!=null}'>
                <dt><spring:message code='profileJobDtls' text='Profile Job Dtls'/></dt>
                <dd>
                    <c:out value='${hcmObject.profile.profileJobDtls}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.doj!=null}'>
                <dt><spring:message code='doj' text='Doj'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.doj}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            
            <c:if test='${hcmObject.isHeadOfPosition!=null}'>
                <dt><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></dt>
                <dd>
                    <c:choose >
                        <c:when test='${hcmObject.isHeadOfPosition==null}'></c:when>
                        <c:when test='${hcmObject.isHeadOfPosition}'>
                            <spring:message code='default.boolean.true' text='YES'/>
                        </c:when>
                        <c:otherwise>
                            <spring:message code='default.boolean.false' text='NO'/>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </c:if>
            
            <c:if test='${hcmObject.costCenter!=null}'>
                <dt><spring:message code='costCenter' text='Cost Center'/></dt>
                <dd>
            <c:if test='${hcmObject.costCenter.hcmObjectType!=null}'>
                <dt><spring:message code='hcmObjectType' text='Hcm Object Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.hcmObjectType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.name}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.interval}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.profile}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.doj!=null}'>
                <dt><spring:message code='doj' text='Doj'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.costCenter.doj}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.isHeadOfPosition!=null}'>
                <dt><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.isHeadOfPosition}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.costCenter!=null}'>
                <dt><spring:message code='costCenter' text='Cost Center'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.costCenter}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.orgUnitType!=null}'>
                <dt><spring:message code='orgUnitType' text='Org Unit Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.orgUnitType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.orgUnitAccAssignment!=null}'>
                <dt><spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.orgUnitAccAssignment}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.storageLocations!=null}'>
                <dt><spring:message code='storageLocations' text='Storage Locations'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.storageLocations}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.purchasingOrg!=null}'>
                <dt><spring:message code='purchasingOrg' text='Purchasing Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.purchasingOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.salesOffice!=null}'>
                <dt><spring:message code='salesOffice' text='Sales Office'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.salesOffice}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.companyCode}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.currency}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.divisions!=null}'>
                <dt><spring:message code='divisions' text='Divisions'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.divisions}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.salesOrg!=null}'>
                <dt><spring:message code='salesOrg' text='Sales Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.salesOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.responsibleEmp!=null}'>
                <dt><spring:message code='responsibleEmp' text='Responsible Emp'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.responsibleEmp}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.companyCodes!=null}'>
                <dt><spring:message code='companyCodes' text='Company Codes'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.companyCodes}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.coa}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.fiscalYearVariant!=null}'>
                <dt><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.fiscalYearVariant}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.controllingArea!=null}'>
                <dt><spring:message code='controllingArea' text='Controlling Area'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.controllingArea}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.costCenter.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${hcmObject.costCenter.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.orgUnitType!=null}'>
                <dt><spring:message code='orgUnitType' text='Org Unit Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.orgUnitType}'/>
                </dd>
            </c:if>
            
       
            
            <c:if test='${hcmObject.purchasingOrg!=null}'>
                <dt><spring:message code='purchasingOrg' text='Purchasing Org'/></dt>
                <dd>
            <c:if test='${hcmObject.purchasingOrg.hcmObjectType!=null}'>
                <dt><spring:message code='hcmObjectType' text='Hcm Object Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.hcmObjectType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.name}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.interval}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.profile}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.doj!=null}'>
                <dt><spring:message code='doj' text='Doj'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.purchasingOrg.doj}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.isHeadOfPosition!=null}'>
                <dt><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.isHeadOfPosition}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.costCenter!=null}'>
                <dt><spring:message code='costCenter' text='Cost Center'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.costCenter}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.orgUnitType!=null}'>
                <dt><spring:message code='orgUnitType' text='Org Unit Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.orgUnitType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.orgUnitAccAssignment!=null}'>
                <dt><spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.orgUnitAccAssignment}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.storageLocations!=null}'>
                <dt><spring:message code='storageLocations' text='Storage Locations'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.storageLocations}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.purchasingOrg!=null}'>
                <dt><spring:message code='purchasingOrg' text='Purchasing Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.purchasingOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.salesOffice!=null}'>
                <dt><spring:message code='salesOffice' text='Sales Office'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.salesOffice}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.companyCode}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.currency}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.divisions!=null}'>
                <dt><spring:message code='divisions' text='Divisions'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.divisions}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.salesOrg!=null}'>
                <dt><spring:message code='salesOrg' text='Sales Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.salesOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.responsibleEmp!=null}'>
                <dt><spring:message code='responsibleEmp' text='Responsible Emp'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.responsibleEmp}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.companyCodes!=null}'>
                <dt><spring:message code='companyCodes' text='Company Codes'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.companyCodes}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.coa}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.fiscalYearVariant!=null}'>
                <dt><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.fiscalYearVariant}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.controllingArea!=null}'>
                <dt><spring:message code='controllingArea' text='Controlling Area'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.controllingArea}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.purchasingOrg.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${hcmObject.purchasingOrg.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.salesOffice!=null}'>
                <dt><spring:message code='salesOffice' text='Sales Office'/></dt>
                <dd>
            <c:if test='${hcmObject.salesOffice.hcmObjectType!=null}'>
                <dt><spring:message code='hcmObjectType' text='Hcm Object Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.hcmObjectType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.name}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.interval}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.profile}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.doj!=null}'>
                <dt><spring:message code='doj' text='Doj'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.salesOffice.doj}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.isHeadOfPosition!=null}'>
                <dt><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.isHeadOfPosition}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.costCenter!=null}'>
                <dt><spring:message code='costCenter' text='Cost Center'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.costCenter}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.orgUnitType!=null}'>
                <dt><spring:message code='orgUnitType' text='Org Unit Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.orgUnitType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.orgUnitAccAssignment!=null}'>
                <dt><spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.orgUnitAccAssignment}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.storageLocations!=null}'>
                <dt><spring:message code='storageLocations' text='Storage Locations'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.storageLocations}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.purchasingOrg!=null}'>
                <dt><spring:message code='purchasingOrg' text='Purchasing Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.purchasingOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.salesOffice!=null}'>
                <dt><spring:message code='salesOffice' text='Sales Office'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.salesOffice}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.companyCode}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.currency}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.divisions!=null}'>
                <dt><spring:message code='divisions' text='Divisions'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.divisions}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.salesOrg!=null}'>
                <dt><spring:message code='salesOrg' text='Sales Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.salesOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.responsibleEmp!=null}'>
                <dt><spring:message code='responsibleEmp' text='Responsible Emp'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.responsibleEmp}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.companyCodes!=null}'>
                <dt><spring:message code='companyCodes' text='Company Codes'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.companyCodes}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.coa}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.fiscalYearVariant!=null}'>
                <dt><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.fiscalYearVariant}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.controllingArea!=null}'>
                <dt><spring:message code='controllingArea' text='Controlling Area'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.controllingArea}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOffice.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOffice.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
            <c:if test='${hcmObject.companyCode.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.companyCode.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.companyCode.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.companyCode.name}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.companyCode.company!=null}'>
                <dt><spring:message code='company' text='Company'/></dt>
                <dd>
                    <c:out value='${hcmObject.companyCode.company}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.companyCode.city!=null}'>
                <dt><spring:message code='city' text='City'/></dt>
                <dd>
                    <c:out value='${hcmObject.companyCode.city}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.companyCode.country!=null}'>
                <dt><spring:message code='country' text='Country'/></dt>
                <dd>
                    <c:out value='${hcmObject.companyCode.country}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.companyCode.language!=null}'>
                <dt><spring:message code='language' text='Language'/></dt>
                <dd>
                    <c:out value='${hcmObject.companyCode.language}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.companyCode.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${hcmObject.companyCode.currency}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${hcmObject.currency}'/>
                </dd>
            </c:if>
            
            <c:if test='${hcmObject.salesOrg!=null}'>
                <dt><spring:message code='salesOrg' text='Sales Org'/></dt>
                <dd>
            <c:if test='${hcmObject.salesOrg.hcmObjectType!=null}'>
                <dt><spring:message code='hcmObjectType' text='Hcm Object Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.hcmObjectType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.name}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.interval}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.profile}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.doj!=null}'>
                <dt><spring:message code='doj' text='Doj'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.salesOrg.doj}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.isHeadOfPosition!=null}'>
                <dt><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.isHeadOfPosition}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.costCenter!=null}'>
                <dt><spring:message code='costCenter' text='Cost Center'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.costCenter}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.orgUnitType!=null}'>
                <dt><spring:message code='orgUnitType' text='Org Unit Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.orgUnitType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.orgUnitAccAssignment!=null}'>
                <dt><spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.orgUnitAccAssignment}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.storageLocations!=null}'>
                <dt><spring:message code='storageLocations' text='Storage Locations'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.storageLocations}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.purchasingOrg!=null}'>
                <dt><spring:message code='purchasingOrg' text='Purchasing Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.purchasingOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.salesOffice!=null}'>
                <dt><spring:message code='salesOffice' text='Sales Office'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.salesOffice}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.companyCode}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.currency}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.divisions!=null}'>
                <dt><spring:message code='divisions' text='Divisions'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.divisions}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.salesOrg!=null}'>
                <dt><spring:message code='salesOrg' text='Sales Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.salesOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.responsibleEmp!=null}'>
                <dt><spring:message code='responsibleEmp' text='Responsible Emp'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.responsibleEmp}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.companyCodes!=null}'>
                <dt><spring:message code='companyCodes' text='Company Codes'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.companyCodes}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.coa}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.fiscalYearVariant!=null}'>
                <dt><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.fiscalYearVariant}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.controllingArea!=null}'>
                <dt><spring:message code='controllingArea' text='Controlling Area'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.controllingArea}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.salesOrg.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${hcmObject.salesOrg.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.responsibleEmp!=null}'>
                <dt><spring:message code='responsibleEmp' text='Responsible Emp'/></dt>
                <dd>
            <c:if test='${hcmObject.responsibleEmp.hcmObjectType!=null}'>
                <dt><spring:message code='hcmObjectType' text='Hcm Object Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.hcmObjectType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.name}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.interval}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.profile}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.doj!=null}'>
                <dt><spring:message code='doj' text='Doj'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.responsibleEmp.doj}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.isHeadOfPosition!=null}'>
                <dt><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.isHeadOfPosition}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.costCenter!=null}'>
                <dt><spring:message code='costCenter' text='Cost Center'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.costCenter}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.orgUnitType!=null}'>
                <dt><spring:message code='orgUnitType' text='Org Unit Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.orgUnitType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.orgUnitAccAssignment!=null}'>
                <dt><spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.orgUnitAccAssignment}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.storageLocations!=null}'>
                <dt><spring:message code='storageLocations' text='Storage Locations'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.storageLocations}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.purchasingOrg!=null}'>
                <dt><spring:message code='purchasingOrg' text='Purchasing Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.purchasingOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.salesOffice!=null}'>
                <dt><spring:message code='salesOffice' text='Sales Office'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.salesOffice}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.companyCode}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.currency}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.divisions!=null}'>
                <dt><spring:message code='divisions' text='Divisions'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.divisions}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.salesOrg!=null}'>
                <dt><spring:message code='salesOrg' text='Sales Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.salesOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.responsibleEmp!=null}'>
                <dt><spring:message code='responsibleEmp' text='Responsible Emp'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.responsibleEmp}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.companyCodes!=null}'>
                <dt><spring:message code='companyCodes' text='Company Codes'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.companyCodes}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.coa}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.fiscalYearVariant!=null}'>
                <dt><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.fiscalYearVariant}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.controllingArea!=null}'>
                <dt><spring:message code='controllingArea' text='Controlling Area'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.controllingArea}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.responsibleEmp.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${hcmObject.responsibleEmp.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
            <c:if test='${hcmObject.coa.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.coa.code}'/>
                </dd>
            </c:if>
           


                </dd>
            </c:if>
            
            <c:if test='${hcmObject.fiscalYearVariant!=null}'>
                <dt><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></dt>
                <dd>
            <c:if test='${hcmObject.fiscalYearVariant.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.fiscalYearVariant.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.fiscalYearVariant.title!=null}'>
                <dt><spring:message code='title' text='Title'/></dt>
                <dd>
                    <c:out value='${hcmObject.fiscalYearVariant.title}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.fiscalYearVariant.calendarType!=null}'>
                <dt><spring:message code='calendarType' text='Calendar Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.fiscalYearVariant.calendarType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.fiscalYearVariant.noOfPosting!=null}'>
                <dt><spring:message code='noOfPosting' text='No Of Posting'/></dt>
                <dd>
                    <c:out value='${hcmObject.fiscalYearVariant.noOfPosting}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.fiscalYearVariant.noOfSpecialPosting!=null}'>
                <dt><spring:message code='noOfSpecialPosting' text='No Of Special Posting'/></dt>
                <dd>
                    <c:out value='${hcmObject.fiscalYearVariant.noOfSpecialPosting}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.controllingArea!=null}'>
                <dt><spring:message code='controllingArea' text='Controlling Area'/></dt>
                <dd>
            <c:if test='${hcmObject.controllingArea.hcmObjectType!=null}'>
                <dt><spring:message code='hcmObjectType' text='Hcm Object Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.hcmObjectType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.code!=null}'>
                <dt><spring:message code='code' text='Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.code}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.name!=null}'>
                <dt><spring:message code='name' text='Name'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.name}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.nameSecondary!=null}'>
                <dt><spring:message code='nameSecondary' text='Name Secondary'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.nameSecondary}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.interval!=null}'>
                <dt><spring:message code='interval' text='Interval'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.interval}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.profile!=null}'>
                <dt><spring:message code='profile' text='Profile'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.profile}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.doj!=null}'>
                <dt><spring:message code='doj' text='Doj'/></dt>
                <dd>
                    <fmt:formatDate value='${hcmObject.controllingArea.doj}' type='date' pattern='dd/MM/yyyy'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.isHeadOfPosition!=null}'>
                <dt><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.isHeadOfPosition}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.costCenter!=null}'>
                <dt><spring:message code='costCenter' text='Cost Center'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.costCenter}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.orgUnitType!=null}'>
                <dt><spring:message code='orgUnitType' text='Org Unit Type'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.orgUnitType}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.orgUnitAccAssignment!=null}'>
                <dt><spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.orgUnitAccAssignment}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.storageLocations!=null}'>
                <dt><spring:message code='storageLocations' text='Storage Locations'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.storageLocations}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.purchasingOrg!=null}'>
                <dt><spring:message code='purchasingOrg' text='Purchasing Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.purchasingOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.salesOffice!=null}'>
                <dt><spring:message code='salesOffice' text='Sales Office'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.salesOffice}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.companyCode!=null}'>
                <dt><spring:message code='companyCode' text='Company Code'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.companyCode}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.currency!=null}'>
                <dt><spring:message code='currency' text='Currency'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.currency}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.divisions!=null}'>
                <dt><spring:message code='divisions' text='Divisions'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.divisions}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.salesOrg!=null}'>
                <dt><spring:message code='salesOrg' text='Sales Org'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.salesOrg}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.responsibleEmp!=null}'>
                <dt><spring:message code='responsibleEmp' text='Responsible Emp'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.responsibleEmp}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.companyCodes!=null}'>
                <dt><spring:message code='companyCodes' text='Company Codes'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.companyCodes}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.coa!=null}'>
                <dt><spring:message code='coa' text='Coa'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.coa}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.fiscalYearVariant!=null}'>
                <dt><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.fiscalYearVariant}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.controllingArea!=null}'>
                <dt><spring:message code='controllingArea' text='Controlling Area'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.controllingArea}'/>
                </dd>
            </c:if>
            <c:if test='${hcmObject.controllingArea.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${hcmObject.controllingArea.description}'/>
                </dd>
            </c:if>

                </dd>
            </c:if>
            
            <c:if test='${hcmObject.description!=null}'>
                <dt><spring:message code='description' text='Description'/></dt>
                <dd>
                    <c:out value='${hcmObject.description}'/>
                </dd>
            </c:if>
            
            <c:set target='audit' property='audit' var='audit' value='${hcmObject}' scope='request'/>
            <jsp:include page='../_auditShow.jsp' flush='true' />
        </dl>
        <div><jsp:include page='_storageLocations.jsp'/></div>
        <div><jsp:include page='_divisions.jsp'/></div>
        <div><jsp:include page='_companyCodes.jsp'/></div>

    </div>
    <a href="${pageContext.request.contextPath}/hcmObject/edit/${hcmObject.id}" class="btn btn-warning">
        <i class="glyphicon glyphicon-edit"></i>
        <spring:message code="edit.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/hcmObject/copy/${hcmObject.id}"class="btn btn-primary">
        <i class="glyphicon glyphicon-copy"></i>
        <spring:message code="copy.link.label"/>
    </a>
    <a href="${pageContext.request.contextPath}/hcmObject/delete/${hcmObject.id}" onclick="return confirm('Are you sure to delete?');" class="btn btn-danger">
        <i class="glyphicon glyphicon-remove"></i>
        <spring:message code="delete.link.label"/>
    </a>
</tiles:putAttribute>

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp' />
</tiles:putAttribute>