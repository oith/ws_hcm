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
        $("#datepicker_doj").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
        $("#datepicker_doe").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
    });
</script>

<form:errors path="*" cssClass="errorblock" element="div" />
<form:hidden path="id"/>
<form:hidden path="profile.id"/>
<div>   
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="head-table">
        <tr>
            <td><form:label path="code"><spring:message code="code" text="Code"/><span class="required-indicator">*</span></form:label></td>
            <td><form:input path="code" type="text" required="true" size="30" maxlength="20"/></td>
            <td><form:errors path="code" cssClass="error" element="div"/></td>


            <td>${emp.profile.user.username}</td>
  <!--            <td><form:label path="profile.user.username"><spring:message code="code" text="Code"/><span class="required-indicator">*</span></form:label></td>
              <td><form:input path="profile.user.username" type="text" required="true" size="30" maxlength="20"/></td>
              <td><form:errors path="profile.user.username" cssClass="error" element="div"/></td>-->

        </tr>
        <tr>
            <td><form:label path="doj"><spring:message code="doj" text="Date of Join"/></form:label></td>
            <td><form:input path="doj" id="datepicker_doj" placeholder="DD/MM/YYYY" /></td>
            <td><form:errors path="doj" cssClass="error" element="div"/></td>
            <td><form:label path="doe"><spring:message code="doe" text="Date of Expired"/></form:label></td>
            <td><form:input path="doe" id="datepicker_doe" placeholder="DD/MM/YYYY" /></td>
            <td><form:errors path="doe" cssClass="error" element="div"/></td>
        </tr>

    </table>
</div>   