<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<form:errors path="*" cssClass="errorblock" element="div" />
<!--<div class="container">-->  

<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="code"><spring:message code="code" text="code"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="code" class="form-control" type="text" required="true" maxlength="100"/>
            <form:errors path="code" cssClass="error" element="div"/>
        </div>
    </div>   

    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="name"><spring:message code="name" text="name"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="name" class="form-control" type="text" required="true" maxlength="100"/>
            <form:errors path="name" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="desc"><spring:message code="desc" text="desc"/></form:label>
            <form:input path="desc" class="form-control" type="text" maxlength="100"/>
            <form:errors path="desc" cssClass="error" element="div"/>
        </div>
    </div>   
</div>



<%--

role

<form:label path="slNo"><spring:message code="slNo" text="sl No"/><span class="required-indicator needed">*</span></form:label>

<form:select path="roleKeyword" class="form-control" name="roleKeyword" id="roleKeyword" required="true">
<form:options items="${roleKeywords}"></form:options>
</form:select>

<form:input path="transDate" type="date" required="true" id="datepicker_transDate" placeholder="DD/MM/YYYY" maxlength="10"/>
           
<form:input path="fieldAttribute" class="form-control" type="text" required="true" size="30" maxlength="100"/>

<form:input path="slNo" class="form-control" type="number" size="15" maxlength="15"/>

<form:textarea path="remarks" class="form-control" type="text" size="30" maxlength="500"/>

<form:checkbox path="active"/>

<form:errors path="active" cssClass="error" element="div"/>

--%>