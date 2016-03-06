<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet"/>
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<script type="text/javascript">
    $(document).ready(function () {
        $("#datepicker_dob").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
    });
</script>

<form:errors path="*" cssClass="errorblock" element="div"/>

<div>   
    <div class="row">            
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <div class="form-group">
                <form:label path="username"><spring:message code="username" text="User Name"/></form:label>
                <form:input path="username" class="form-control" type="text" size="30" maxlength="30"/>
                <form:errors path="username" cssClass="error" element="div"/>
            </div>
        </div>             
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <div class="form-group">
                <form:label path="fullName"><spring:message code="fullName" text="Full Name"/></form:label>
                <form:input path="fullName" class="form-control" type="text" size="50" maxlength="50"/>
                <form:errors path="fullName" cssClass="error" element="div"/>
            </div>
        </div>  


        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
            <div class='form-group'>
                <form:label path='gender'><spring:message code='gender' text='Gender'/><span class='required-indicator needed'>*</span></form:label>
                <form:select path='gender' class='form-control' name='gender' id='gender' required='true' >
                    <form:options items='${genders}' ></form:options>
                </form:select>
                <form:errors path='gender' cssClass='error' element='div'/>
            </div>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <div class="form-group">
                <form:label path="dob"><spring:message code="dob" text="Dob"/></form:label>
                <form:input path="dob" class="form-control" id="datepicker_dob" placeholder="DD/MM/YYYY"/>
                <form:errors path="dob" cssClass="error" element="div"/>
            </div>
        </div>  

        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <div class="form-group">
                <form:label path="password"><spring:message code="password" text="Password"/></form:label>
                <form:password path="password" class="form-control" showPassword="true" size="30" maxlength="30"/>
                <form:errors path="password" cssClass="error" element="div"/>
            </div>
        </div>             
    </div>  
</div>   