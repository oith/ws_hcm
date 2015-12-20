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
            <form:label path="emp"><spring:message code="emp" text="emp"/><span class="required-indicator needed">*</span></form:label>
            <form:select path="emp.id" class="form-control" name="emp" id="emp" required="true" >
                <form:options items="${emps}" itemValue="id"></form:options>
            </form:select>
            <form:errors path="emp" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="appDate"><spring:message code="appDate" text="appDate"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="appDate" class="form-control" type="date" id="datepicker_appDate" placeholder="DD/MM/YYYY" required="true" maxlength="10"/>
            <form:errors path="appDate" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="code"><spring:message code="code" text="code"/></form:label>
            <form:input path="code" class="form-control" type="text" maxlength="100"/>
            <form:errors path="code" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="remarks"><spring:message code="remarks" text="remarks"/></form:label>
            <form:input path="remarks" class="form-control" type="text" maxlength="100"/>
            <form:errors path="remarks" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="approval"><spring:message code="approval" text="approval"/></form:label>
            
            <form:errors path="approval" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="appliedAmount"><spring:message code="appliedAmount" text="appliedAmount"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="appliedAmount" class="form-control" type="number" required="true" min="0" max="100"/>
            <form:errors path="appliedAmount" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="sanctionAmount"><spring:message code="sanctionAmount" text="sanctionAmount"/></form:label>
            <form:input path="sanctionAmount" class="form-control" type="number" min="0" max="100"/>
            <form:errors path="sanctionAmount" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="installmentAmount"><spring:message code="installmentAmount" text="installmentAmount"/></form:label>
            <form:input path="installmentAmount" class="form-control" type="number" min="0" max="100"/>
            <form:errors path="installmentAmount" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="interestPct"><spring:message code="interestPct" text="interestPct"/></form:label>
            <form:input path="interestPct" class="form-control" type="number" min="0" max="100"/>
            <form:errors path="interestPct" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="remainingAmount"><spring:message code="remainingAmount" text="remainingAmount"/></form:label>
            <form:input path="remainingAmount" class="form-control" type="number" min="0" max="100"/>
            <form:errors path="remainingAmount" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="lastInstallmentAmount"><spring:message code="lastInstallmentAmount" text="lastInstallmentAmount"/></form:label>
            <form:input path="lastInstallmentAmount" class="form-control" type="number" min="0" max="100"/>
            <form:errors path="lastInstallmentAmount" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="lastInterestAmount"><spring:message code="lastInterestAmount" text="lastInterestAmount"/></form:label>
            <form:input path="lastInterestAmount" class="form-control" type="number" min="0" max="100"/>
            <form:errors path="lastInterestAmount" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="lastTouchPayrollPeriod"><spring:message code="lastTouchPayrollPeriod" text="lastTouchPayrollPeriod"/></form:label>
            <form:select path="lastTouchPayrollPeriod.id" class="form-control" name="lastTouchPayrollPeriod" id="lastTouchPayrollPeriod" >
                <form:options items="${lastTouchPayrollPeriods}" itemValue="id"></form:options>
            </form:select>
            <form:errors path="lastTouchPayrollPeriod" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="sanctionDate"><spring:message code="sanctionDate" text="sanctionDate"/></form:label>
            <form:input path="sanctionDate" class="form-control" type="date" id="datepicker_sanctionDate" placeholder="DD/MM/YYYY" maxlength="10"/>
            <form:errors path="sanctionDate" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="loanType"><spring:message code="loanType" text="loanType"/><span class="required-indicator needed">*</span></form:label>
            <form:select path="loanType" class="form-control" name="loanType" id="loanType" required="true" >
                <form:options items="${loanTypes}" ></form:options>
            </form:select>
            <form:errors path="loanType" cssClass="error" element="div"/>
        </div>
    </div>   
     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="loanStatus"><spring:message code="loanStatus" text="loanStatus"/><span class="required-indicator needed">*</span></form:label>
            <form:select path="loanStatus" class="form-control" name="loanStatus" id="loanStatus" required="true" >
                <form:options items="${loanStatuss}" ></form:options>
            </form:select>
            <form:errors path="loanStatus" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
<div class="row">     
    <div class="col-xs-6">
        <div class="form-group">
            <form:label path="reasonForLoan"><spring:message code="reasonForLoan" text="reasonForLoan"/></form:label>
            <form:input path="reasonForLoan" class="form-control" type="text" maxlength="100"/>
            <form:errors path="reasonForLoan" cssClass="error" element="div"/>
        </div>
    </div>   
</div>
  

          
<%--

loanApp

<form:label path="slNo"><spring:message code="slNo" text="sl No"/><span class="required-indicator needed">*</span></form:label>

<form:select path="loanAppKeyword" class="form-control" name="loanAppKeyword" id="loanAppKeyword" required="true">
<form:options items="${loanAppKeywords}"></form:options>
</form:select>

<form:input path="transDate" type="date" required="true" id="datepicker_transDate" placeholder="DD/MM/YYYY" maxlength="10"/>
           
<form:input path="fieldAttribute" class="form-control" type="text" required="true" size="30" maxlength="100"/>

<form:input path="slNo" class="form-control" type="number" size="15" maxlength="15"/>

<form:textarea path="remarks" class="form-control" type="text" size="30" maxlength="500"/>

<form:checkbox path="active"/>

<form:errors path="active" cssClass="error" element="div"/>

--%>