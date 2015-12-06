<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>

    <b><spring:message code="audit" text="Audit"/></b>
    
    <c:if test="${audit.auditor.insertByUser!=null}">
        <li class="fieldcontain first_item">
            <span id="title" class="property-label">
                <spring:message code="insertByUser" text="Insert By User"/>: 
            </span>
            <span class="property-value" aria-labelledby="insertByUser">
                <c:out value="${audit.auditor.insertByUser.fullName}"/>
            </span>
        </li>
    </c:if>

    <c:if test="${audit.auditor.insertDate!=null}">
        <li class="fieldcontain first_item">
            <span id="title" class="property-label">
                <spring:message code="insertDate" text="Insert Date"/>: 
            </span>
            <span class="property-value" aria-labelledby="insertDate">
                <fmt:formatDate value="${audit.auditor.insertDate}" type="date" pattern="dd/MM/yyyy EEEEE hh:mm a"/>
            </span>
        </li>
    </c:if>

    <c:if test="${audit.auditor.updateByUser!=null}">
        <li class="fieldcontain first_item">
            <span id="title" class="property-label">
                <spring:message code="updateByUser" text="Update By User"/>: 
            </span>
            <span class="property-value" aria-labelledby="updateByUser">
                <c:out value="${audit.auditor.updateByUser.fullName}"/>
            </span>
        </li>
    </c:if>
    <c:if test="${audit.auditor.updateDate!=null}">
        <li class="fieldcontain first_item">
            <span id="title" class="property-label">
                <spring:message code="updateDate" text="Update Date"/>: 
            </span>
            <span class="property-value" aria-labelledby="updateDate">
                <fmt:formatDate value="${audit.auditor.updateDate}" type="date" pattern="dd/MM/yyyy EEEEE hh:mm a"/>
            </span>
        </li>
    </c:if>

</div>   