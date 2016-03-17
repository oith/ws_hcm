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
            <form:input path='code' class='form-control' type='text' required='true' maxlength='4'/>
            <form:errors path='code' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='module'><spring:message code='module' text='Module'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='module' class='form-control' name='module' id='module' required='true' >
                <form:options items='${modules}' ></form:options>
            </form:select>
            <form:errors path='module' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='title'><spring:message code='title' text='Title'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='title' class='form-control' type='text' required='true' maxlength='50'/>
            <form:errors path='title' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='fileName'><spring:message code='fileName' text='File Name'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='fileName' class='form-control' type='text' required='true' maxlength='30'/>
            <form:errors path='fileName' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='isActive'><spring:message code='isActive' text='Is Active'/></form:label>
            <form:checkbox path='isActive'/>
            <form:errors path='isActive' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='slNo'><spring:message code='slNo' text='Sl No'/></form:label>
            <form:input path='slNo' class='form-control' type='number' min='0' max='10000000'/>
            <form:errors path='slNo' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='tags'><spring:message code='tags' text='Tags'/></form:label>
            <form:select path='tags' class='form-control' name='tags' id='tags' items='${tags}' multiple='true'/>
            <form:errors path='tags' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='supportFormats'><spring:message code='supportFormats' text='Support Formats'/></form:label>
            <form:select path='supportFormats' class='form-control' name='supportFormats' id='supportFormats' items='${supportFormats}' multiple='true'/>
            <form:errors path='supportFormats' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
        <div class='form-group'>
            <form:label path='remarks'><spring:message code='remarks' text='Remarks'/></form:label>
            <form:textarea path='remarks' class='form-control' type='text' maxlength='500'/>
            <form:errors path='remarks' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>