<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet"/>
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<form:errors path="*" cssClass="errorblock" element="div"/>
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
            <form:label path="transDate"><spring:message code="transDate" text="transDate"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="transDate" class="form-control" type="date" id="datepicker_transDate" placeholder="DD/MM/YYYY" required="true" maxlength="10"/>
            <form:errors path="transDate" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="accountHeadFm"><spring:message code="accountHeadFm" text="accountHeadFm"/><span class="required-indicator needed">*</span></form:label>
            <form:select path="accountHeadFm.id" class="form-control" name="accountHeadFm" id="accountHeadFm" required="true" >
                <form:options items="${accountHeadFms}" itemValue="id"></form:options>
            </form:select>
            <form:errors path="accountHeadFm" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="sign"><spring:message code="sign" text="sign"/><span class="required-indicator needed">*</span></form:label>
            <form:select path="sign" class="form-control" name="sign" id="sign" required="true" >
                <form:options items="${signs}" ></form:options>
            </form:select>
            <form:errors path="sign" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="amount"><spring:message code="amount" text="amount"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="amount" class="form-control" type="number" required="true" min="1" max="100000"/>
            <form:errors path="amount" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="accountHeadFmOpposite"><spring:message code="accountHeadFmOpposite" text="accountHeadFmOpposite"/><span class="required-indicator needed">*</span></form:label>
            <form:select path="accountHeadFmOpposite.id" class="form-control" name="accountHeadFmOpposite" id="accountHeadFmOpposite" required="true" >
                <form:options items="${accountHeadFmOpposites}" itemValue="id"></form:options>
            </form:select>
            <form:errors path="accountHeadFmOpposite" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="emp"><spring:message code="emp" text="emp"/></form:label>
            <form:select path="emp.id" class="form-control" name="emp" id="emp" >
                <form:options items="${emps}" itemValue="id"></form:options>
            </form:select>
            <form:errors path="emp" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="narration"><spring:message code="narration" text="narration"/></form:label>
            <form:textarea path="narration" class="form-control" type="text" maxlength="500"/>
            <form:errors path="narration" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
  

          
<%--

trnscFm

<form:label path="slNo"><spring:message code="slNo" text="sl No"/><span class="required-indicator needed">*</span></form:label>

<form:select path="trnscFmKeyword" class="form-control" name="trnscFmKeyword" id="trnscFmKeyword" required="true">
<form:options items="${trnscFmKeywords}"></form:options>
</form:select>

<form:input path="transDate" type="date" required="true" id="datepicker_transDate" placeholder="DD/MM/YYYY" maxlength="10"/>
           
<form:input path="fieldAttribute" class="form-control" type="text" required="true" size="30" maxlength="100"/>

<form:input path="slNo" class="form-control" type="number" size="15" maxlength="15"/>

<form:textarea path="remarks" class="form-control" type="text" size="30" maxlength="500"/>

<form:checkbox path="active"/>

<form:errors path="active" cssClass="error" element="div"/>

--%>