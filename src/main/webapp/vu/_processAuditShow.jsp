<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  
<div>

    <b><spring:message code="processAudit" text="Process Audit"/></b>
    
    <c:if test="${processAudit.processByUser!=null}">
        <li class="fieldcontain first_item">
            <span id="title" class="property-label">
                <spring:message code="processByUser" text="Insert By User"/>: 
            </span>
            <span class="property-value" aria-labelledby="processByUser">
                <c:out value="${processAudit.processByUser.fullName}"/>
            </span>
        </li>
    </c:if>

    <c:if test="${processAudit.processDate!=null}">
        <li class="fieldcontain first_item">
            <span id="title" class="property-label">
                <spring:message code="processDate" text="Insert Date"/>: 
            </span>
            <span class="property-value" aria-labelledby="processDate">
                <fmt:formatDate value="${processAudit.processDate}" type="date" pattern="dd/MM/yyyy EEEEE hh:mm a"/>
            </span>
        </li>
    </c:if>

    <c:if test="${processAudit.tamperByUser!=null}">
        <li class="fieldcontain first_item">
            <span id="title" class="property-label">
                <spring:message code="tamperByUser" text="Update By User"/>: 
            </span>
            <span class="property-value" aria-labelledby="tamperByUser">
                <c:out value="${processAudit.tamperByUser.fullName}"/>
            </span>
        </li>
    </c:if>
    <c:if test="${processAudit.tamperDate!=null}">
        <li class="fieldcontain first_item">
            <span id="title" class="property-label">
                <spring:message code="tamperDate" text="Update Date"/>: 
            </span>
            <span class="property-value" aria-labelledby="tamperDate">
                <fmt:formatDate value="${processAudit.tamperDate}" type="date" pattern="dd/MM/yyyy EEEEE hh:mm a"/>
            </span>
        </li>
    </c:if>

</div>   