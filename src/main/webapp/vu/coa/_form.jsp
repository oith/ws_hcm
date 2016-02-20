<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags' %>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form' %>
<%--CSS--%>

<form:errors path='*' cssClass='errorblock' element='div' />

<div class='row'>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='code'><spring:message code='code' text='Code'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='code' class='form-control' type='text' required='true' maxlength='10'/>
            <form:errors path='code' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='title'><spring:message code='title' text='Title'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='title' class='form-control' type='text' required='true' maxlength='100'/>
            <form:errors path='title' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='retainedEarningsAccount'><spring:message code='retainedEarningsAccount' text='Retained Earnings Account'/></form:label>
            <form:select path='retainedEarningsAccount.id' class='form-control' name='retainedEarningsAccount' id='retainedEarningsAccount' >
                <form:options items='${retainedEarningsAccounts}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='retainedEarningsAccount' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='lengthOfAccount'><spring:message code='lengthOfAccount' text='Length Of Account'/></form:label>
            <form:input path='lengthOfAccount' class='form-control' type='number' min='4' max='10'/>
            <form:errors path='lengthOfAccount' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>