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
            <form:input path="code" class="form-control" type="text" required="true" maxlength="10"/>
            <form:errors path="code" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="title"><spring:message code="title" text="title"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="title" class="form-control" type="text" required="true" maxlength="100"/>
            <form:errors path="title" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="accNo"><spring:message code="accNo" text="accNo"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="accNo" class="form-control" type="text" required="true" maxlength="20"/>
            <form:errors path="accNo" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="active"><spring:message code="active" text="active"/></form:label>
            <form:checkbox path="active"/>
            <form:errors path="active" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="slNo"><spring:message code="slNo" text="slNo"/></form:label>
            <form:input path="slNo" class="form-control" type="number" min="0" max="50"/>
            <form:errors path="slNo" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="empRequired"><spring:message code="empRequired" text="empRequired"/></form:label>
            <form:checkbox path="empRequired"/>
            <form:errors path="empRequired" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="description"><spring:message code="description" text="description"/></form:label>
            <form:textarea path="description" class="form-control" type="text" maxlength="500"/>
            <form:errors path="description" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
  

          
<%--

accountHeadFm

<form:label path="slNo"><spring:message code="slNo" text="sl No"/><span class="required-indicator needed">*</span></form:label>

<form:select path="accountHeadFmKeyword" class="form-control" name="accountHeadFmKeyword" id="accountHeadFmKeyword" required="true">
<form:options items="${accountHeadFmKeywords}"></form:options>
</form:select>

<form:input path="fieldAttribute" class="form-control" type="text" required="true" size="30" maxlength="100"/>

<form:input path="slNo" class="form-control" type="number" size="15" maxlength="15"/>

<form:textarea path="remarks" class="form-control" type="text" size="30" maxlength="500"/>

<form:checkbox path="active"/>

<form:errors path="active" cssClass="error" element="div"/>

--%>