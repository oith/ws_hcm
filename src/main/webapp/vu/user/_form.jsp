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
        $("#datepicker_dob").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
    });
</script>

<form:errors path="*" cssClass="errorblock" element="div" />

<div>   
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="head-table">

        <tr>
            <td><form:label path="username"><spring:message code="username" text="User Name"/></form:label></td>
            <td><form:input path="username" type="text" size="30" maxlength="30"/></td>
            <td><form:errors path="username" cssClass="error" element="div"/></td>
            <td><form:label path="fullName"><spring:message code="fullName" text="Full Name"/></form:label></td>
            <td><form:input path="fullName" type="text" size="50" maxlength="50"/></td>
            <td><form:errors path="fullName" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="gender"><spring:message code="gender" text="Gender"/></form:label></td>
            <td><form:select path="gender" items="${genders}"/></td>  
            <td><form:errors path="gender" cssClass="error" element="div"/></td>
            <td><form:label path="dob"><spring:message code="dob" text="Dob"/></form:label></td>
            <td><form:input path="dob" id="datepicker_dob" placeholder="DD/MM/YYYY" /></td>
            <td><form:errors path="dob" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="password"><spring:message code="password" text="Password"/></form:label></td>
            <td><form:password path="password" showPassword="true" size="30" maxlength="30"/></td>
            <td><form:errors path="password" cssClass="error" element="div"/></td>
            
          
            <td><form:label path="openInNewPage"><spring:message code="openInNewPage" text="Open In New Page"/></form:label></td>
            <td><form:checkbox path="openInNewPage"/></td>
            <td><form:errors path="openInNewPage" cssClass="error" element="div"/></td>
      
        </tr>
    </table>
</div>   