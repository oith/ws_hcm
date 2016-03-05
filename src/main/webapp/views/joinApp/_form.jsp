<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags' %>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form' %>
<%--CSS--%>

<form:errors path='*' cssClass='errorblock' element='div' />

<div class='row'>

    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='profile'><spring:message code='profile' text='Profile'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='profile.code' class='form-control' type='text' required='true'  size='6' maxlength='6'/>
            <form:input path='profile.id' class='form-control' type='text' required='true'  size='24' maxlength='24'/>
            <form:input path='profile.user.fullName' class='form-control' type='text' disabled="true"/>
            <form:errors path='profile' cssClass='error' element='div'/>
        </div>
    </div>

    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='code'><spring:message code='code' text='Code'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='code' class='form-control' type='text' required='true' maxlength='100'/>
            <form:errors path='code' cssClass='error' element='div'/>
        </div>
    </div>

    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='appDate'><spring:message code='appDate' text='App Date'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='appDate' class='form-control datepicker' type='date' required='true' maxlength='10'/>
            <form:errors path='appDate' cssClass='error' element='div'/>
        </div>
    </div>

    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
        <div class='form-group'>
            <form:label path='remarks'><spring:message code='remarks' text='Remarks'/></form:label>
            <form:textarea path='remarks' class='form-control' type='text' maxlength='500'/>
            <form:errors path='remarks' cssClass='error' element='div'/>
        </div>
    </div>

    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='interval'><spring:message code='interval' text='Interval'/></form:label>
                <!--{joinApp.intervals}-->
            <form:errors path='interval' cssClass='error' element='div'/>
        </div>
    </div>

    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='position'><spring:message code='position' text='Position'/></form:label>
                <!--//{joinApp.positions}-->
            <form:errors path='position' cssClass='error' element='div'/>
        </div>
    </div>

    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='approval'><spring:message code='approval' text='Approval'/></form:label>
                <!--{joinApp.approvals}-->
            <form:errors path='approval' cssClass='error' element='div'/>
        </div>
    </div>

</div>

<%--JS--%>

<%--[report]--%>