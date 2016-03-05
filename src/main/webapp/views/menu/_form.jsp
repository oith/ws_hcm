<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet"/>
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script>

<form:errors path="*" cssClass="errorblock" element="div" />
<!--<div class="container">-->

<div class="row">

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="code"><spring:message code="code" text="Code"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="code" class="form-control" type="text" required="true" maxlength="100"/>
            <form:errors path="code" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="menuType"><spring:message code="menuType" text="Menu Type"/><span class="required-indicator needed">*</span></form:label>
            <form:select path="menuType" class="form-control" name="menuType" id="menuType" required="true" >
                <form:options items="${menuTypes}" ></form:options>
            </form:select>
            <form:errors path="menuType" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="text"><spring:message code="text" text="Text"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="text" class="form-control" type="text" required="true" maxlength="100"/>
            <form:errors path="text" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="address"><spring:message code="address" text="Address"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="address" class="form-control" type="text" required="true" maxlength="100"/>
            <form:errors path="address" cssClass="error" element="div"/>
        </div>
    </div>

</div>

<%--
menu
--%>