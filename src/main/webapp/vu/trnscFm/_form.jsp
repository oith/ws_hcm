<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<script type="text/javascript">
    $(document).ready(function () {
        $("#datepicker_transDate").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
    });
</script>

<form:errors path="*" cssClass="errorblock" element="div" />
<form:hidden path="id"/>
<div>   
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="head-table">
        <tr>
            <td><form:label path="code"><spring:message code="code" text="Code"/><span class="required-indicator needed">*</span></form:label></td>
            <td><form:input path="code" type="text" required="true" size="30" maxlength="20"/></td>
            <td><form:errors path="code" cssClass="error" element="div"/></td>
            <td><form:label path="transDate"><spring:message code="transDate" text="Trans Date"/><span class="required-indicator needed">*</span></form:label></td>
            <td><form:input path="transDate" type="date" required="true" id="datepicker_transDate" placeholder="DD/MM/YYYY" maxlength="10"/></td>
            <td><form:errors path="transDate" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="accountHeadFm"><spring:message code="accountHeadFm" text="Account HeadFm"/><span class="required-indicator needed">*</span></form:label></td>
                <td>
                <form:select path="accountHeadFm.id" name="accountHeadFm" id="accountHeadFm" required="true">
                    <form:option value="${null}" label="--Select--"/>  
                    <form:options itemValue="id" items="${accountHeadFms}"/>
                </form:select>  
            </td>
            <td><form:errors path="accountHeadFm" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="amount"><spring:message code="amount" text="Amount"/><span class="required-indicator needed">*</span></form:label></td>
            <td><form:input path="amount" type="number" required="true" min="1" max="100000"/></td>
            <td><form:errors path="amount" cssClass="error" element="div"/></td>      
            <td><form:label path="sign"><spring:message code="sign" text="Sign"/><span class="required-indicator needed">*</span></form:label></td>
            <td><form:select path="sign" name="sign" id="sign" >
                    <form:option value="DR" label="Debit"/>
                    <form:option value="CR" label="Credit"/>
                </form:select></td>
            <td><form:errors path="sign" cssClass="error" element="div"/></td>
        </tr> 

        <tr>
            <td><form:label path="emp"><spring:message code="emp" text="Employee"/></form:label></td>
            <td><form:input path="emp" type="text" size="20" maxlength="20"/></td>
            <td><form:errors path="emp" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="accountHeadFmOpposite"><spring:message code="accountHeadFmOpposite" text="Account Head Fm Opposite"/><span class="required-indicator needed">*</span></form:label></td>
                <td>
                <form:select  path="accountHeadFmOpposite.id" name="accountHeadFmOpposite" id="accountHeadFmOpposite" required="true">
                    <form:option value="${null}"  label="--Select--"/>  
                    <form:options itemValue="id" items="${accountHeadFms}"/>
                </form:select>  
            </td>
            <td><form:errors path="accountHeadFmOpposite" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="narration"><spring:message code="narration" text="Narration"/></form:label></td>
            <td><form:textarea path="narration" type="text" cols="20" rows="2" maxlength="500"/></td>
            <td><form:errors path="narration" cssClass="error" element="div"/></td>
        </tr>

    </table>
</div>   