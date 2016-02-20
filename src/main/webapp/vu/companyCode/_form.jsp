<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags' %>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form' %>
<%--CSS--%>

<form:errors path='*' cssClass='errorblock' element='div' />
<div class='container'>
    <div class="panel-body">
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
        </div>
        <div class='row'>
            <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                <div class='form-group'>
                    <form:label path='company'><spring:message code='company' text='Company'/></form:label>
                    <form:select path='company' class='form-control' name='company' id='company' >
                        <form:options items='${companys}' itemValue='id'></form:options>
                    </form:select>
                    <form:errors path='company' cssClass='error' element='div'/>
                </div>
            </div>

            <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                <div class='form-group'>
                    <form:label path='city'><spring:message code='city' text='City'/></form:label>
                    <form:input path='city' class='form-control' type='text' maxlength='100'/>
                    <form:errors path='city' cssClass='error' element='div'/>
                </div>
            </div>
        </div>
        <div class='row'>
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
        </div>
        <div class='row'>
            <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                <div class='form-group'>
                    <form:label path='currency'><spring:message code='currency' text='Currency'/><span class='required-indicator needed'>*</span></form:label>
                    <form:select path='currency' class='form-control' name='currency' required='true' id='currency' >
                        <form:options items='${currencys}' ></form:options>
                    </form:select>
                    <form:errors path='currency' cssClass='error' element='div'/>
                </div>
            </div>
        </div>
    </div>
</div>            
<%--JS--%>

<%--[report]--%>

