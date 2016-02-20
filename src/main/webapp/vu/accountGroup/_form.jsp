<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags' %>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form' %>
<%--CSS--%>

<form:errors path='*' cssClass='errorblock' element='div' />

<div class='row'>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='coa'><spring:message code='coa' text='Coa'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='coa.id' class='form-control' name='coa' id='coa' required='true' >
                <form:options items='${coas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='coa' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='accountGroup'><spring:message code='accountGroup' text='Account Group'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='accountGroup' class='form-control' type='text' required='true' maxlength='4'/>
            <form:errors path='accountGroup' cssClass='error' element='div'/>
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
            <form:label path='fromAccount'><spring:message code='fromAccount' text='From Account'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='fromAccount' class='form-control' type='text' required='true' maxlength='10'/>
            <form:errors path='fromAccount' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='toAccount'><spring:message code='toAccount' text='To Account'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='toAccount' class='form-control' type='text' required='true' maxlength='10'/>
            <form:errors path='toAccount' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='active'><spring:message code='active' text='Active'/></form:label>
            <form:checkbox path='active'/>
            <form:errors path='active' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='slNo'><spring:message code='slNo' text='Sl No'/></form:label>
            <form:input path='slNo' class='form-control' type='number' min='0' max='100'/>
            <form:errors path='slNo' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
        <div class='form-group'>
            <form:label path='description'><spring:message code='description' text='Description'/></form:label>
            <form:textarea path='description' class='form-control' type='text' maxlength='500'/>
            <form:errors path='description' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>