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
            <%--<form:label path='alphaObjType'><spring:message code='alphaObjType' text='Alpha Type'/></form:label>--%>
            <select class='form-control' name='alphaObjType' id='alphaObjType' >
                <options items='${alphaObjTypes}' ></options>
            </select>
            <%--<form:errors path='alphaObjType' cssClass='error' element='div'/>--%>
        </div>
    </div>
        
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='hcmObjectAlpha'><spring:message code='hcmObjectAlpha' text='Hcm Object Alpha'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='hcmObjectAlpha' class='form-control' name='hcmObjectAlpha' id='hcmObjectAlpha' required='true' >
                <form:options items='${hcmObjectAlphas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='hcmObjectAlpha' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='hcmObjectBeta'><spring:message code='hcmObjectBeta' text='Hcm Object Beta'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='hcmObjectBeta' class='form-control' name='hcmObjectBeta' id='hcmObjectBeta' required='true' >
                <form:options items='${hcmObjectBetas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='hcmObjectBeta' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='relType'><spring:message code='relType' text='Rel Type'/></form:label>
            <form:select path='relType' class='form-control' name='relType' id='relType' >
                <form:options items='${relTypes}' ></form:options>
            </form:select>
            <form:errors path='relType' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='interval'><spring:message code='interval' text='Interval'/></form:label>
            <!--{association.intervals}-->
            <form:errors path='interval' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>