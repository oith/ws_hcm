<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
    .error {
        color: #ff0000;
    }
    .errorblock {
        color: #000;
        background-color: #ffEEEE;
        border: 3px solid #ff0000;
        padding: 8px;
        margin: 16px;
    }
</style>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<script type="text/javascript">
    $(document).ready(function () {
        $("#datepicker_initDate").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
    });
</script>

<form:errors path="*" cssClass="errorblock" element="div" />
<form:hidden path="id"/>
<div>   
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="head-table">
        <tr>
            <td><form:label path="code"><spring:message code="code" text="Code"/><span class="required-indicator">*</span></form:label></td>
            <td><form:input path="code" type="text" required="true" size="10" maxlength="10"/></td>
            <td><form:errors path="code" cssClass="error" element="div"/></td>
            <td><form:label path="title"><spring:message code="title" text="title"/><span class="required-indicator">*</span></form:label></td>
            <td><form:input path="title" type="text" required="true" size="30" maxlength="30"/></td>
            <td><form:errors path="title" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="empRequired"><spring:message code="empRequired" text="Employee Required ?"/><span class="required-indicator">*</span></form:label></td>
            <td><form:checkbox path="empRequired"/></td>
            <td><form:errors path="empRequired" cssClass="error" element="div"/></td>
            <td><form:label path="active"><spring:message code="active" text="Active ?"/><span class="required-indicator">*</span></form:label></td>
            <td><form:checkbox path="active"/></td>
            <td><form:errors path="active" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="accNo"><spring:message code="accNo" text="Account No"/></form:label></td>
            <td><form:input path="accNo" type="text" required="true" size="20" maxlength="20"/></td>
            <td><form:errors path="accNo" cssClass="error" element="div"/></td>

            <td><form:label path="description"><spring:message code="description" text="Description"/></form:label></td>
            <td><form:textarea path="description" type="text" cols="20" rows="2" maxlength="500"/></td>
            <td><form:errors path="description" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="slNo"><spring:message code="slNo" text="slNo"/></form:label></td>
            <td><form:input path="slNo" type="number" min="1" max="100"/></td>
            <td><form:errors path="slNo" cssClass="error" element="div"/></td>      
        </tr>
    </table>
</div>   