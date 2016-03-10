<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div>
    <b><spring:message code="audit" text="Audit"/></b>
</div>  

<c:if test="${audit.auditor.insertByUser!=null}">
    <dt><spring:message code="insertByUser" text="Insert By User"/></dt>
    <dd>
        <c:out value="${audit.auditor.insertByUser.fullName}"/>
    </dd> 
</c:if>
<c:if test="${audit.auditor.insertDate!=null}">
    <dt><spring:message code="insertDate" text="Insert Date"/></dt>
    <dd>
        <fmt:formatDate value="${audit.auditor.insertDate}" type="date" pattern="dd/MM/yyyy EEEEE hh:mm a"/>
    </dd> 
</c:if>
<c:if test="${audit.auditor.updateByUser!=null}">
    <dt><spring:message code="updateByUser" text="Update By User"/></dt>
    <dd>
        <c:out value="${audit.auditor.updateByUser.fullName}"/>
    </dd> 
</c:if>
<c:if test="${audit.auditor.updateDate!=null}">
    <dt><spring:message code="updateDate" text="Update Date"/></dt>
    <dd>
        <fmt:formatDate value="${audit.auditor.updateDate}" type="date" pattern="dd/MM/yyyy EEEEE hh:mm a"/>
    </dd> 
</c:if>
