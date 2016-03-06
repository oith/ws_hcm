<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<form:errors path="*" cssClass="errorblock" element="div" />

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
            <form:label path="lookupKeyword"><spring:message code="lookupKeyword" text="Lookup Keyword"/><span class="required-indicator needed">*</span></form:label>
            <form:select path="lookupKeyword" class="form-control" name="lookupKeyword" id="lookupKeyword" required="true" >
                <form:options items="${lookupKeywords}" ></form:options>
            </form:select>
            <form:errors path="lookupKeyword" cssClass="error" element="div"/>
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
            <form:label path="active"><spring:message code="active" text="Active"/></form:label>
            <form:checkbox path="active"/>
            <form:errors path="active" cssClass="error" element="div"/>
        </div>
    </div>   

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="slNo"><spring:message code="slNo" text="Sl No"/></form:label>
            <form:input path="slNo" class="form-control" type="number" min="0" max="100"/>
            <form:errors path="slNo" cssClass="error" element="div"/>
        </div>
    </div>   

    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="form-group">
            <form:label path="remarks"><spring:message code="remarks" text="Remarks"/></form:label>
            <form:textarea path="remarks" class="form-control" type="text" maxlength="500"/>
            <form:errors path="remarks" cssClass="error" element="div"/>
        </div>
    </div>   
</div>

<%--
lookup
--%>