<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<tiles:insertDefinition name="defaultTemplate" />

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp" />
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp" />--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.show" text="Show"/></title>

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home"/></a> |
        <a href="${pageContext.request.contextPath}/profile/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="profile" text="Profile"/></a> |
        <a href="${pageContext.request.contextPath}/profile/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="profile" text="Profile"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <%--<form:hidden path="id"/>--%>
        <dl class="dl-horizontal">

            <c:if test="${profile.code!=null}">
                <dt><spring:message code="code" text="Code"/></dt>
                <dd>
                    <c:out value="${profile.code}"/>
                </dd>
            </c:if>

            <c:if test="${profile.title!=null}">
                <dt><spring:message code="title" text="Title"/></dt>
                <dd>
                    <c:out value="${profile.title}"/>
                </dd>
            </c:if>

            <c:if test="${profile.firstName!=null}">
                <dt><spring:message code="firstName" text="First Name"/></dt>
                <dd>
                    <c:out value="${profile.firstName}"/>
                </dd>
            </c:if>

            <c:if test="${profile.middleName!=null}">
                <dt><spring:message code="middleName" text="Middle Name"/></dt>
                <dd>
                    <c:out value="${profile.middleName}"/>
                </dd>
            </c:if>

            <c:if test="${profile.lastName!=null}">
                <dt><spring:message code="lastName" text="Last Name"/></dt>
                <dd>
                    <c:out value="${profile.lastName}"/>
                </dd>
            </c:if>

            <c:if test="${profile.nickName!=null}">
                <dt><spring:message code="nickName" text="Nick Name"/></dt>
                <dd>
                    <c:out value="${profile.nickName}"/>
                </dd>
            </c:if>

            <c:if test="${profile.nid!=null}">
                <dt><spring:message code="nid" text="Nid"/></dt>
                <dd>
                    <c:out value="${profile.nid}"/>
                </dd>
            </c:if>

            <c:if test="${profile.profilePicFile!=null}">
                <dt><spring:message code="profilePicFile" text="Profile Pic File"/></dt>
                <dd>
                    <c:url var="macImage" value="/profile/getPhoto/${profile.profilePicFile}"/>
                    <img id="imagePreview" class="img-rounded" height="110px" width="90px" src="${macImage}" alt="${macImage}"/>
                </dd>
            </c:if>

            <c:if test="${profile.contactInfo!=null}">
                <dt><spring:message code="contactInfo" text="Contact Info"/></dt>
                <dd>
                    <c:if test="${profile.contactInfo.mobile!=null}">
                    <dt><spring:message code="mobile" text="Mobile"/></dt>
                    <dd>
                        <c:out value="${profile.contactInfo.mobile}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactInfo.phone!=null}">
                    <dt><spring:message code="phone" text="Phone"/></dt>
                    <dd>
                        <c:out value="${profile.contactInfo.phone}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactInfo.email!=null}">
                    <dt><spring:message code="email" text="Email"/></dt>
                    <dd>
                        <c:out value="${profile.contactInfo.email}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactInfo.web!=null}">
                    <dt><spring:message code="web" text="Web"/></dt>
                    <dd>
                        <c:out value="${profile.contactInfo.web}"/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:if test="${profile.address!=null}">
                <dt><spring:message code="address" text="Address"/></dt>
                <dd>
                    <c:if test="${profile.address.addressType!=null}">
                    <dt><spring:message code="addressType" text="Address Type"/></dt>
                    <dd>
                        <c:out value="${profile.address.addressType}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.address.careOf!=null}">
                    <dt><spring:message code="careOf" text="Care Of"/></dt>
                    <dd>
                        <c:out value="${profile.address.careOf}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.address.holding!=null}">
                    <dt><spring:message code="holding" text="Holding"/></dt>
                    <dd>
                        <c:out value="${profile.address.holding}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.address.street!=null}">
                    <dt><spring:message code="street" text="Street"/></dt>
                    <dd>
                        <c:out value="${profile.address.street}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.address.zip!=null}">
                    <dt><spring:message code="zip" text="Zip"/></dt>
                    <dd>
                        <c:out value="${profile.address.zip}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.address.city!=null}">
                    <dt><spring:message code="city" text="City"/></dt>
                    <dd>
                        <c:out value="${profile.address.city}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.address.state!=null}">
                    <dt><spring:message code="state" text="State"/></dt>
                    <dd>
                        <c:out value="${profile.address.state}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.address.country!=null}">
                    <dt><spring:message code="country" text="Country"/></dt>
                    <dd>
                        <c:out value="${profile.address.country}"/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:if test="${profile.user!=null}">
                <dt><spring:message code="user" text="User"/></dt>
                <dd>
                    <c:if test="${profile.user.username!=null}">
                    <dt><spring:message code="username" text="Username"/></dt>
                    <dd>
                        <c:out value="${profile.user.username}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.password!=null}">
                    <dt><spring:message code="password" text="Password"/></dt>
                    <dd>
                        <c:out value="${profile.user.password}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.fullName!=null}">
                    <dt><spring:message code="fullName" text="Full Name"/></dt>
                    <dd>
                        <c:out value="${profile.user.fullName}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.gender!=null}">
                    <dt><spring:message code="gender" text="Gender"/></dt>
                    <dd>
                        <c:out value="${profile.user.gender}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.dob!=null}">
                    <dt><spring:message code="dob" text="Dob"/></dt>
                    <dd>
                        <fmt:formatDate value="${profile.user.dob}" type="date" pattern="dd/MM/yyyy"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.accountNonExpired!=null}">
                    <dt><spring:message code="accountNonExpired" text="Account Non Expired"/></dt>
                    <dd>
                        <c:out value="${profile.user.accountNonExpired}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.accountNonLocked!=null}">
                    <dt><spring:message code="accountNonLocked" text="Account Non Locked"/></dt>
                    <dd>
                        <c:out value="${profile.user.accountNonLocked}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.credentialsNonExpired!=null}">
                    <dt><spring:message code="credentialsNonExpired" text="Credentials Non Expired"/></dt>
                    <dd>
                        <c:out value="${profile.user.credentialsNonExpired}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.enabled!=null}">
                    <dt><spring:message code="enabled" text="Enabled"/></dt>
                    <dd>
                        <c:out value="${profile.user.enabled}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.root!=null}">
                    <dt><spring:message code="root" text="Root"/></dt>
                    <dd>
                        <c:out value="${profile.user.root}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.authorities!=null}">
                    <dt><spring:message code="authorities" text="Authorities"/></dt>
                    <dd>
                        <c:out value="${profile.user.authorities}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.favorites!=null}">
                    <dt><spring:message code="favorites" text="Favorites"/></dt>
                    <dd>
                        <c:out value="${profile.user.favorites}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.params!=null}">
                    <dt><spring:message code="params" text="Params"/></dt>
                    <dd>
                        <c:out value="${profile.user.params}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.user.envs!=null}">
                    <dt><spring:message code="envs" text="Envs"/></dt>
                    <dd>
                        <c:out value="${profile.user.envs}"/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:if test="${profile.chestSize!=null}">
                <dt><spring:message code="chestSize" text="Chest Size"/></dt>
                <dd>
                    <c:out value="${profile.chestSize}"/>
                </dd>
            </c:if>

            <c:if test="${profile.height!=null}">
                <dt><spring:message code="height" text="Height"/></dt>
                <dd>
                    <c:out value="${profile.height}"/>
                </dd>
            </c:if>

            <c:if test="${profile.weight!=null}">
                <dt><spring:message code="weight" text="Weight"/></dt>
                <dd>
                    <c:out value="${profile.weight}"/>
                </dd>
            </c:if>

            <c:if test="${profile.bloodGroup!=null}">
                <dt><spring:message code="bloodGroup" text="Blood Group"/></dt>
                <dd>
                    <c:out value="${profile.bloodGroup}"/>
                </dd>
            </c:if>

            <c:if test="${profile.religion!=null}">
                <dt><spring:message code="religion" text="Religion"/></dt>
                <dd>
                    <c:out value="${profile.religion}"/>
                </dd>
            </c:if>

            <c:if test="${profile.maritalSts!=null}">
                <dt><spring:message code="maritalSts" text="Marital Sts"/></dt>
                <dd>
                    <c:out value="${profile.maritalSts}"/>
                </dd>
            </c:if>

            <c:if test="${profile.marriageDate!=null}">
                <dt><spring:message code="marriageDate" text="Marriage Date"/></dt>
                <dd>
                    <fmt:formatDate value="${profile.marriageDate}" type="date" pattern="dd/MM/yyyy"/>
                </dd>
            </c:if>

            <c:if test="${profile.noOfChild!=null}">
                <dt><spring:message code="noOfChild" text="No Of Child"/></dt>
                <dd>
                    <c:out value="${profile.noOfChild}"/>
                </dd>
            </c:if>

            <c:if test="${profile.contactPresonPrimary!=null}">
                <dt><spring:message code="contactPresonPrimary" text="Contact Preson Primary"/></dt>
                <dd>
                    <c:if test="${profile.contactPresonPrimary.name!=null}">
                    <dt><spring:message code="name" text="Name"/></dt>
                    <dd>
                        <c:out value="${profile.contactPresonPrimary.name}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactPresonPrimary.address!=null}">
                    <dt><spring:message code="address" text="Address"/></dt>
                    <dd>
                        <c:out value="${profile.contactPresonPrimary.address}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactPresonPrimary.contactInfo!=null}">
                    <dt><spring:message code="contactInfo" text="Contact Info"/></dt>
                    <dd>
                        <c:out value="${profile.contactPresonPrimary.contactInfo}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactPresonPrimary.designation!=null}">
                    <dt><spring:message code="designation" text="Designation"/></dt>
                    <dd>
                        <c:out value="${profile.contactPresonPrimary.designation}"/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:if test="${profile.contactPresonSecondary!=null}">
                <dt><spring:message code="contactPresonSecondary" text="Contact Preson Secondary"/></dt>
                <dd>
                    <c:if test="${profile.contactPresonSecondary.name!=null}">
                    <dt><spring:message code="name" text="Name"/></dt>
                    <dd>
                        <c:out value="${profile.contactPresonSecondary.name}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactPresonSecondary.address!=null}">
                    <dt><spring:message code="address" text="Address"/></dt>
                    <dd>
                        <c:out value="${profile.contactPresonSecondary.address}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactPresonSecondary.contactInfo!=null}">
                    <dt><spring:message code="contactInfo" text="Contact Info"/></dt>
                    <dd>
                        <c:out value="${profile.contactPresonSecondary.contactInfo}"/>
                    </dd>
                </c:if>
                <c:if test="${profile.contactPresonSecondary.designation!=null}">
                    <dt><spring:message code="designation" text="Designation"/></dt>
                    <dd>
                        <c:out value="${profile.contactPresonSecondary.designation}"/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:set target="audit" property="audit" var="audit" value="${profile}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true" />
        </dl>
        <div><jsp:include page="_profileEduDtls.jsp"/></div>
        <div><jsp:include page="_profileJobDtls.jsp"/></div>

    </div>

    <a href="${pageContext.request.contextPath}/profile/admin_edit/<c:out value="${profile.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/profile/admin_copy/<c:out value="${profile.id}"/>"><spring:message code="copy.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/profile/admin_delete/${profile.id}" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>
</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    
