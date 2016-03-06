<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet"/>
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
<!--<div class="container">-->

<div class="row">

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="code"><spring:message code="code" text="Code"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="code" class="form-control" type="text" required="true" maxlength="10"/>
            <form:errors path="code" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="name"><spring:message code="name" text="Name"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="name" class="form-control" type="text" required="true" maxlength="50"/>
            <form:errors path="name" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="nameSecondary"><spring:message code="nameSecondary" text="Name Secondary"/></form:label>
            <form:input path="nameSecondary" class="form-control" type="text" maxlength="50"/>
            <form:errors path="nameSecondary" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="interval"><spring:message code="interval" text="Interval"/></form:label>
                <!--{emp.intervals}-->
            <form:errors path="interval" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="form-group">
            <form:label path="description"><spring:message code="description" text="Description"/></form:label>
            <form:textarea path="description" class="form-control" type="text" maxlength="500"/>
            <form:errors path="description" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-4 col-sm-2 col-md-2 col-lg-2">
        <div class="form-group">
            <form:label path="profile"><spring:message code="profile" text="Profile"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="profile.code" class="form-control" type="text" required="true"  size="6" maxlength="6"/>
            <form:errors path="profile" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
        <div class="form-group">
            <form:label path="profile">Caption</form:label> 
            <form:input path="profile.user.fullName" class="form-control" type="text" disabled="true" size="30" maxlength="30"/>
        </div>
    </div>


    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="doj"><spring:message code="doj" text="Doj"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="doj" class="form-control" type="date" id="datepicker_doj" placeholder="DD/MM/YYYY" required="true" maxlength="10"/>
            <form:errors path="doj" cssClass="error" element="div"/>
        </div>
    </div>


</div>

<%--
emp
--%>