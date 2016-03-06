<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<tiles:insertDefinition name="defaultTemplate" />

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp" />
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp" />--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.index" text="Index"/></title>

    <script>window.jQuery || document.write('<script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"><\/script>')</script>

    <div>   
        <a href="${pageContext.request.contextPath}/"><span class="glyphicon glyphicon-home"></span><spring:message code="home"/></a> |
        <a href="${pageContext.request.contextPath}/profile/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="profile" text="Profile"/></a>
    </div>

    <h1><spring:message code="list.page.title"/></h1>

    <form:form action="${pageContext.request.contextPath}/profile/index" commandName="searchCriteria" method="POST">

        <table>
            <tr>
                <td><form:label path="searchTerm"><spring:message code="label.searchTerm"/>:</form:label></td>
                <td><form:input path="searchTerm" type="text" id="txtSearch" size="20"/></td>
                <td><form:label path="searchTerm"><spring:message code="default.foundRec" arguments="${searchCriteria.totalRecs}" htmlEscape="false" /></form:label></td>
                </tr>

                <tr>
                    <td><form:label path="pageSize"><spring:message code="label.pageSize"/>:</form:label></td>
                <td><form:select path="pageSize">
                        <form:option value="5" label="5" />
                        <form:option value="10" label="10" />
                        <form:option value="20" label="20" />
                        <form:option value="50" label="50" />
                        <form:option value="100" label="100" />
                        <form:option value="200" label="200" />
                        <form:option value="500" label="500" />
                        <form:option value="1000" label="1000" />
                        <%--   <form:options items="${pageSize}" />--%>
                    </form:select></td>
            </tr>
            <tr>
                <td><form:label path="page"><spring:message code="label.page"/>:</form:label></td>
                <td><form:select path="page">
                        <%--<form:option value="-1" label="...Select..." />--%>
                        <form:options items="${pages}" />
                    </form:select></td>
            </tr>
        </table>

        <div>
            <button type="submit" class="btn btn-info">
                <span class="fa fa-search"></span><spring:message code="search.form.submit.label"/>
            </button>
        </div>
    </form:form>

    <c:if test="${profiles.size()!=0}">

        <div style="margin: auto; overflow-x: scroll; padding-top: 5px">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="style-table">

                <thead>
                    <tr>
                        <td></td>
                        <td><spring:message code="code" text="Code"/></td>
                        <td><spring:message code="title" text="title"/></td>
                        <td><spring:message code="firstName" text="firstName"/></td>
                        <td><spring:message code="middleName" text="middleName"/></td>
                        <td><spring:message code="lastName" text="lastName"/></td>
                        <td><spring:message code="nickName" text="nickName"/></td>
                        <td><spring:message code="nid" text="nid"/></td>
                        <td><spring:message code="profilePicFile" text="profilePicFile"/></td>
                        <td><spring:message code="contactInfo" text="contactInfo"/></td>
                        <td><spring:message code="address" text="address"/></td>
                        <td><spring:message code="user" text="user"/></td>
                        <td><spring:message code="chestSize" text="chestSize"/></td>
                        <td><spring:message code="height" text="height"/></td>
                        <td><spring:message code="weight" text="weight"/></td>
                        <td><spring:message code="bloodGroup" text="bloodGroup"/></td>
                        <td><spring:message code="maritalSts" text="maritalSts"/></td>
                        <td><spring:message code="religion" text="religion"/></td>
                        <td><spring:message code="marriageDate" text="marriageDate"/></td>
                        <td><spring:message code="noOfChild" text="noOfChild"/></td>
                        <td><spring:message code="contactPersonPrimary" text="contactPersonPrimary"/></td>
                        <td><spring:message code="contactPersonSecondary" text="contactPersonSecondary"/></td>



                        <%--   
                        <td><spring:message code="code" text="Code"/></td>
                        <td><spring:message code="active" text="Active"/></td>
                        <td><spring:message code="slNo" text="Sl No"/></td>
                        <td><spring:message code="name" text="Name"/></td>
                        <td><spring:message code="remarks" text="Remarks"/></td>
                        <td><spring:message code="profileKeyword" text="Profile Keyword"/></td>
                        --%>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${profiles}" var="profile"  varStatus="loopStatus">

                        <tr class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                            <td><a href="${pageContext.request.contextPath}/profile/show/<c:out value="${profile.id}"/>"><spring:message code="show.link.label"/></a></td>
                            <td><c:out value="${profile.code}"/></td>
                            <td><c:out value="${profile.title}"/></td>
                            <td><c:out value="${profile.firstName}"/></td>
                            <td><c:out value="${profile.middleName}"/></td>
                            <td><c:out value="${profile.lastName}"/></td>
                            <td><c:out value="${profile.nickName}"/></td>
                            <td><c:out value="${profile.nid}"/></td>
                            <td>
                                <c:url var="macImage" value="/profile/getPhoto/small/${profile.profilePicFile}"/>
                                <img id="imagePreview" height="55px" width="45px" src="${macImage}" alt="${macImage}"/>
                            </td>
                            <td><c:out value="${profile.contactInfo}"/></td>
                            <td><c:out value="${profile.address}"/></td>
                            <td><c:out value="${profile.user}"/></td>
                            <td><c:out value="${profile.chestSize}"/></td>
                            <td><c:out value="${profile.height}"/></td>
                            <td><c:out value="${profile.weight}"/></td>
                            <td><c:out value="${profile.bloodGroup}"/></td>
                            <td><c:out value="${profile.maritalSts}"/></td>
                            <td><c:out value="${profile.religion}"/></td>
                            <td><fmt:formatDate value="${profile.marriageDate}" type="date" pattern="dd/MM/yyyy"/></td>
                            <td><c:out value="${profile.noOfChild}"/></td>
                            <td><c:out value="${profile.contactPersonPrimary}"/></td>
                            <td><c:out value="${profile.contactPersonSecondary}"/></td>


                            <%--
                            <td><c:out value="${profile.code}"/></td>
                            <td><c:if test="${profile.active}"><spring:message code="default.boolean.true" text="YES"/></c:if><c:if test="${!profile.active}"><spring:message code="default.boolean.false" text="NO"/></c:if></td>
                            <td><c:out value="${profile.slNo}"/></td>
                            <td><c:out value="${profile.name}"/></td>
                            <td><c:out value="${profile.remarks}"/></td>
                            <td><c:out value="${profile.profileKeyword}"/></td>
                            --%>

                            <td><a href="${pageContext.request.contextPath}/profile/edit/<c:out value="${profile.id}"/>"><spring:message code="edit.link.label"/></a></td>
                            <td><a href="${pageContext.request.contextPath}/profile/delete/<c:out value="${profile.id}"/>" onclick="return confirm('Are you sure to delete?');" ><span class="glyphicon glyphicon-trash"></span><spring:message code="delete.link.label"/></a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <!--<div class="row-fluid">-->
        <!--    <div>
        <util:pagination thispage="${profiles}"></util:pagination>
    </div>-->
    </c:if>
    <c:if test="${empty profiles}">
        <p>
            <spring:message code="list.page.label.no.data.found" text="No data found"/>
        </p>
    </c:if>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    
