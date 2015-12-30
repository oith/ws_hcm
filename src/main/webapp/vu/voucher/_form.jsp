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
            <form:label path="code"><spring:message code="code" text="Code"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="code" class="form-control" type="text" required="true" maxlength="100"/>
            <form:errors path="code" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="appDate"><spring:message code="appDate" text="App Date"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="appDate" class="form-control" type="date" id="datepicker_appDate" placeholder="DD/MM/YYYY" required="true" maxlength="10"/>
            <form:errors path="appDate" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="remarks"><spring:message code="remarks" text="Remarks"/></form:label>
            <form:textarea path="remarks" class="form-control" type="text" maxlength="500"/>
            <form:errors path="remarks" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="transDate"><spring:message code="transDate" text="Trans Date"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="transDate" class="form-control" type="date" id="datepicker_transDate" placeholder="DD/MM/YYYY" required="true" maxlength="10"/>
            <form:errors path="transDate" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="currency"><spring:message code="currency" text="Currency"/></form:label>
            <form:select path="currency" class="form-control" name="currency" id="currency" >
                <form:options items="${currencys}" ></form:options>
            </form:select>
            <form:errors path="currency" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="periodAcc"><spring:message code="periodAcc" text="Period Acc"/></form:label>
       
            <form:errors path="periodAcc" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="companyCode"><spring:message code="companyCode" text="Company Code"/><span class="required-indicator needed">*</span></form:label>
            
            <form:errors path="companyCode" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="chequeInfo"><spring:message code="chequeInfo" text="Cheque Info"/></form:label>
          
            <form:errors path="chequeInfo" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="narration"><spring:message code="narration" text="Narration"/></form:label>
            <form:textarea path="narration" class="form-control" type="text" maxlength="500"/>
            <form:errors path="narration" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="isDeleted"><spring:message code="isDeleted" text="Is Deleted"/></form:label>
            <form:checkbox path="isDeleted"/>
            <form:errors path="isDeleted" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
  

          
<%--

voucher

<form:label path="slNo"><spring:message code="slNo" text="sl No"/><span class="required-indicator needed">*</span></form:label>

<form:select path="voucherKeyword" class="form-control" name="voucherKeyword" id="voucherKeyword" required="true">
<form:options items="${voucherKeywords}"></form:options>
</form:select>

<form:input path="transDate" type="date" required="true" id="datepicker_transDate" placeholder="DD/MM/YYYY" maxlength="10"/>
           
<form:input path="fieldAttribute" class="form-control" type="text" required="true" size="30" maxlength="100"/>

<form:input path="slNo" class="form-control" type="number" size="15" maxlength="15"/>

<form:textarea path="remarks" class="form-control" type="text" size="30" maxlength="500"/>

<form:checkbox path="active"/>

<form:errors path="active" cssClass="error" element="div"/>

--%>