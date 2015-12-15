<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<script type="text/javascript">
    //            $(function()
    //            {
    //                $('#datepicker1').datepicker({
    //                    showOn: "button",
    //                    dateFormat: "dd/mm/yy",
    //                    disabled: false,
    //                    buttonImage: "calendar.png",
    //                    buttonImageOnly: true
    //                });
    //            });



    //$(document).ready(function() {
    //    $("#datepicker1").datepicker({dateFormat: "mm/dd/yy"});
    //});
    //$(document).ready(function() {
    //    $("#datepicker2").datepicker({dateFormat: "mm/dd/yy"});
    //});   

    //$(function() {
    //    $( "#dialog" ).dialog();
    //});



//function getCodableDTO(obj1, lblEmployeeName,lblEmployeeID){
//    var code = obj1; 
//   
//    $.ajax({
//        type : "GET",
//        url: '/MAC_CONTEXT_PATH/lookup/getCodableDTOlookup',
//        data: ({code : code}),
//        success: function(d) {
//            //alert("ok:"+d.id)
//            $('#'+lblEmployeeID).val(d.id)
//        $('#'+lblEmployeeName).text(d.caption)
//        },
//        error: function(err) {
//            //alert("err gg:"+err)
//            $('#'+lblEmployeeName).text(err.err)
//        }
//    });
//} 
</script>

<form:errors path="*" cssClass="errorblock" element="div"/>

<div>   
    <div class="row">            
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="code"><spring:message code="code" text="Code"/><span class="required-indicator needed">*</span></form:label>
                <form:input path="code" class="form-control" type="text" required="true" size="30" maxlength="20"/>
                <form:errors path="code" cssClass="error" element="div"/>
            </div>
        </div>             
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="active"><spring:message code="active" text="Active"/></form:label>
                <form:checkbox path="active"/>
                <form:errors path="active" cssClass="error" element="div"/>
            </div>
        </div>  
    </div>  


    <div class="row">            
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="name"><spring:message code="name" text="Name"/><span class="required-indicator needed">*</span></form:label>
                <form:input path="name" class="form-control" type="text" required="true" size="30" maxlength="100"/>
                <form:errors path="name" cssClass="error" element="div"/>
            </div>
        </div>             
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="domain"><spring:message code="domain" text="Domain"/><span class="required-indicator needed">*</span></form:label>
                <form:input path="domain" class="form-control" type="text" required="true" size="20" maxlength="20"/>
                <form:errors path="domain" cssClass="error" element="div"/>
            </div>
        </div>  
    </div>  

    <div class="row">            
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="loginUrl"><spring:message code="loginUrl" text="Login Url"/><span class="required-indicator needed">*</span></form:label>
                <form:input path="loginUrl" class="form-control" type="text" required="true" size="30" maxlength="100"/>
                <form:errors path="loginUrl" cssClass="error" element="div"/>
            </div>
        </div>             
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="userCreateUrl"><spring:message code="userCreateUrl" text="User Create Url"/><span class="required-indicator needed">*</span></form:label>
                <form:input path="userCreateUrl" class="form-control" type="text" required="true" size="30" maxlength="100"/>
                <form:errors path="userCreateUrl" cssClass="error" element="div"/>
            </div>
        </div>  
    </div>  
            
    <div class="row">  
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="remarks"><spring:message code="remarks" text="Remarks"/></form:label>
                <form:textarea path="remarks" class="form-control" type="text" size="30" maxlength="500"/>
                <form:errors path="remarks" cssClass="error" element="div"/>
            </div>
        </div>             
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="clientCategory"><spring:message code="clientCategory" text="Client Category"/><span class="required-indicator needed">*</span></form:label>
                <form:select path="clientCategory" class="form-control" name="clientCategory" id="clientCategory" required="true">
                    <form:option value="${null}" label="--Select--">  
                        <form:options items="${clientCategorys}"></form:options>
                    </form:option>
                </form:select>
                <form:errors path="clientCategory" cssClass="error" element="div"/>
            </div>
        </div>  
    </div>  

</div>   