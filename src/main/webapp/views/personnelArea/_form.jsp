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
            <form:input path='code' class='form-control' type='text' required='true'  maxlength='4'/>
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
            <form:label path='address'><spring:message code='address' text='Address'/></form:label>
            <%--{personnelArea.addresss}--%>
            <form:errors path='address' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='companyCode'><spring:message code='companyCode' text='Company Code'/></form:label>
            <form:select path='companyCode' class='form-control' name='companyCode' id='companyCode' >
                <form:option value="" label="--Select Yaa--"></form:option>
                <form:options items='${companyCodes}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='companyCode' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>