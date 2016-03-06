<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet"/>
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script>

<script type="text/javascript">
    $(document).ready(function () {

    });
</script>

<form:errors path="*" cssClass="errorblock" element="div" />
<!--<div class="container">-->

<div class="row">

    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <div class="form-group">
            <form:label path="subject"><spring:message code="subject" text="Subject"/><span class="required-indicator needed">*</span></form:label>
            <form:input path="subject" class="form-control" type="text" required="true" maxlength="100"/>
            <form:errors path="subject" cssClass="error" element="div"/>
        </div>
    </div>

    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="form-group">
            <form:label path="content"><spring:message code="content" text="Content"/><span class="required-indicator needed">*</span></form:label>
            <form:textarea path="content" class="form-control" type="text" required="true" maxlength="500"/>
            <form:errors path="content" cssClass="error" element="div"/>
        </div>
    </div>

</div>

<%--
post
--%>