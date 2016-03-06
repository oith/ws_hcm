<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags' %>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form' %>
<%--CSS--%>

<form:errors path='*' cssClass='errorblock' element='div' />

<div class='row'>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='domClass'><spring:message code='domClass' text='Dom Class'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='domClass' class='form-control' type='text' required='true' maxlength='50'/>
            <form:errors path='domClass' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='mode'><spring:message code='mode' text='Mode'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='mode' class='form-control' name='mode' id='mode' required='true' >
                <form:options items='${modes}' ></form:options>
            </form:select>
            <form:errors path='mode' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='preFix'><spring:message code='preFix' text='Pre Fix'/></form:label>
            <form:input path='preFix' class='form-control' type='text' maxlength='10'/>
            <form:errors path='preFix' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='postFix'><spring:message code='postFix' text='Post Fix'/></form:label>
            <form:input path='postFix' class='form-control' type='text' maxlength='10'/>
            <form:errors path='postFix' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='nextValue'><spring:message code='nextValue' text='Next Value'/></form:label>
            <form:input path='nextValue' class='form-control' type='number' min='0' max='10000000'/>
            <form:errors path='nextValue' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='codeLength'><spring:message code='codeLength' text='Code Length'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='codeLength' class='form-control' type='number' required='true' min='0' max='10000000'/>
            <form:errors path='codeLength' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='active'><spring:message code='active' text='Active'/></form:label>
            <form:checkbox path='active'/>
            <form:errors path='active' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>