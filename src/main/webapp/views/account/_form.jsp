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
            <form:label path='nameSecondary'><spring:message code='nameSecondary' text='Name Secondary'/></form:label>
            <form:input path='nameSecondary' class='form-control' type='text' maxlength='100'/>
            <form:errors path='nameSecondary' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='companyCode'><spring:message code='companyCode' text='Company Code'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='companyCode' class='form-control' name='companyCode' id='companyCode' required='true' >
                <form:options items='${companyCodes}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='companyCode' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='accountGroup'><spring:message code='accountGroup' text='Account Group'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='accountGroup.id' class='form-control' name='accountGroup' id='accountGroup' required='true' >
                <form:options items='${accountGroups}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='accountGroup' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='accountStatement'><spring:message code='accountStatement' text='Account Statement'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='accountStatement' class='form-control' name='accountStatement' id='accountStatement' required='true' >
                <form:options items='${accountStatements}' ></form:options>
            </form:select>
            <form:errors path='accountStatement' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>