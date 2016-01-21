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
            <form:label path='name'><spring:message code='name' text='Name'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='name' class='form-control' type='text' required='true' maxlength='50'/>
            <form:errors path='name' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='nameSecondary'><spring:message code='nameSecondary' text='Name Secondary'/></form:label>
            <form:input path='nameSecondary' class='form-control' type='text' maxlength='50'/>
            <form:errors path='nameSecondary' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='street'><spring:message code='street' text='Street'/></form:label>
            <form:input path='street' class='form-control' type='text' maxlength='100'/>
            <form:errors path='street' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='poBox'><spring:message code='poBox' text='Po Box'/></form:label>
            <form:input path='poBox' class='form-control' type='text' maxlength='100'/>
            <form:errors path='poBox' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='poCode'><spring:message code='poCode' text='Po Code'/></form:label>
            <form:input path='poCode' class='form-control' type='text' maxlength='100'/>
            <form:errors path='poCode' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='city'><spring:message code='city' text='City'/></form:label>
            <form:input path='city' class='form-control' type='text' maxlength='100'/>
            <form:errors path='city' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='country'><spring:message code='country' text='Country'/></form:label>
            <form:select path='country' class='form-control' name='country' id='country' >
                <form:options items='${countrys}' ></form:options>
            </form:select>
            <form:errors path='country' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='language'><spring:message code='language' text='Language'/></form:label>
            <form:select path='language' class='form-control' name='language' id='language' >
                <form:options items='${languages}' ></form:options>
            </form:select>
            <form:errors path='language' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='currency'><spring:message code='currency' text='Currency'/></form:label>
            <form:select path='currency' class='form-control' name='currency' id='currency' >
                <form:options items='${currencys}' ></form:options>
            </form:select>
            <form:errors path='currency' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>