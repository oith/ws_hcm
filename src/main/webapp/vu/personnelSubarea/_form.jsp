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
            <form:label path='name'><spring:message code='name' text='Name'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='name' class='form-control' type='text' required='true' maxlength='50'/>
            <form:errors path='name' cssClass='error' element='div'/>
        </div>
    </div>

    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='personnelArea'><spring:message code='personnelArea' text='Personnel Area'/></form:label>
            <form:select path='personnelArea.id' class='form-control' name='personnelArea' id='personnelArea' >
                <form:option value="" label="--Select--"></form:option>
                <form:options items='${personnelAreas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='personnelArea' cssClass='error' element='div'/>
        </div>
    </div>

</div>

<%--JS--%>

<%--[report]--%>