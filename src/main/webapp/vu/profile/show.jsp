<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet"/>
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>

<tiles:insertDefinition name="defaultTemplate"/>

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp"/>
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp"/>--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.show" text="Show"/></title>

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home"/></a> |
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <%--<form:hidden path="id"/>--%>

        <ol class="property-list hrIrGrdScr">

            <c:if test="${profile.title!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="title" text="TITLE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="title">
                        <c:out value="${profile.title}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.user.fullName!=null && !profile.user.fullName.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="fullName" text="Full Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="user.fullName">
                        <c:out value="${profile.user.fullName}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.user.username!=null && !profile.user.username.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="username" text="User Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="user.username">
                        <c:out value="${profile.user.username}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.user.gender!=null }">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="gender" text="Gender"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="user.gender">
                        <c:out value="${profile.user.gender}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.user.dob!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="dob" text="Date of Birth"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="user.dob">
                        <fmt:formatDate value="${profile.user.dob}" type="date" pattern="dd/MM/yyyy"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.firstName!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="firstName" text="FIRSTNAME"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="firstName">
                        <c:out value="${profile.firstName}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.middleName!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="middleName" text="MIDDLENAME"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="middleName">
                        <c:out value="${profile.middleName}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.lastName!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="lastName" text="LASTNAME"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="lastName">
                        <c:out value="${profile.lastName}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.nickName!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="nickName" text="NICKNAME"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="nickName">
                        <c:out value="${profile.nickName}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.profilePicFile!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="profilePicFile" text="Profile Pic File"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="profilePicFile">
                        <c:url var="macImage" value="/profile/getPhoto/${profile.profilePicFile}"/>
                        <img id="imagePreview" height="110px" width="90px" src="${macImage}" alt="${macImage}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.nid!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="nid" text="NID"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="nid">
                        <c:out value="${profile.nid}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.contactInfo!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="contactInfo" text="CONTACTINFO"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="contactInfo">
                        <c:out value="${profile.contactInfo}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.address!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="address" text="ADDRESS"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="address">
                        <c:out value="${profile.address}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.chestSize!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="chestSize" text="CHESTSIZE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="chestSize">
                        <c:out value="${profile.chestSize}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.height!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="height" text="HEIGHT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="height">
                        <c:out value="${profile.height}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.weight!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="weight" text="WEIGHT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="weight">
                        <c:out value="${profile.weight}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.bloodGroup!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="bloodGroup" text="BLOODGROUP"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="bloodGroup">
                        <c:out value="${profile.bloodGroup}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.maritalSts!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="maritalSts" text="MARITALSTS"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="maritalSts">
                        <c:out value="${profile.maritalSts}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.religion!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="religion" text="RELIGION"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="religion">
                        <c:out value="${profile.religion}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.marriageDate!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="marriageDate" text="MARRIAGEDATE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="marriageDate">
                        <c:out value="${profile.marriageDate}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.noOfChild!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="noOfChild" text="NOOFCHILD"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="noOfChild">
                        <c:out value="${profile.noOfChild}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.contactPresonPrimary!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="contactPresonPrimary" text="CONTACTPRESONPRIMARY"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="contactPresonPrimary">
                        <c:out value="${profile.contactPresonPrimary}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${profile.contactPresonSecondary!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="contactPresonSecondary" text="CONTACTPRESONSECONDARY"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="contactPresonSecondary">
                        <c:out value="${profile.contactPresonSecondary}"/>
                    </span>
                </li>
            </c:if>

            <c:set target="audit" property="audit" var="audit" value="${profile}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true"/>

        </ol> 
        <div><jsp:include page="_profileEduDtls.jsp"/></div>
        <div><jsp:include page="_profileJobDtls.jsp"/></div>
    </div>

    <a href="${pageContext.request.contextPath}/profile/edit"><spring:message code="edit.link.label" text="Edit"/></a> |

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp"/>
</tiles:putAttribute>    

