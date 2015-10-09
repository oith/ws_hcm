<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>

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
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <%--<form:hidden path="id"/>--%>

        <ol class="property-list hrIrGrdScr">

            <c:if test="${profile.user.displayName!=null && !profile.user.displayName.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="displayName" text="Display Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="user.displayName">
                        <c:out value="${profile.user.displayName}"/>
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
            <c:if test="${profile.firstName!=null && !profile.firstName.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="firstName" text="First Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="firstName">
                        <c:out value="${profile.firstName}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.middleName!=null && !profile.middleName.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="middleName" text="Middle Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="middleName">
                        <c:out value="${profile.middleName}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.lastName!=null && !profile.lastName.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="lastName" text="Last Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="lastName">
                        <c:out value="${profile.lastName}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.nickName!=null && !profile.nickName.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="nickName" text="Nick Name"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="nickName">
                        <c:out value="${profile.nickName}"/>
                    </span>
                </li>
            </c:if>
            <c:if test="${profile.profilePicFile!=null && !profile.profilePicFile.isEmpty()}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="profilePicFile" text="Profile Pic File"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="profilePicFile">
                        <c:url var="macImage" value="/profile/getPhoto/${profile.profilePicFile}" />
                        <img id="imagePreview" height="110px" width="90px" src="${macImage}" alt="${macImage}"/>
                    </span>
                </li>
            </c:if>
                
            <c:set target="audit" property="audit" var="audit" value="${profile}" scope="request"/>
            <jsp:include page="../_audit_show.jsp" flush="true" />

        </ol>
        <div><jsp:include page="profileEduDtls.jsp" /></div>
        <div><jsp:include page="profileJobDtls.jsp" /></div>
    </div>

    <a href="${pageContext.request.contextPath}/profile/edit"><spring:message code="edit.link.label" text="Edit"/></a> |

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    

