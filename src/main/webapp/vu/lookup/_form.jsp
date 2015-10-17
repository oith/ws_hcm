<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
    .error {
        color: #ff0000;
    }
    .errorblock {
        color: #000;
        background-color: #ffEEEE;
        border: 3px solid #ff0000;
        padding: 8px;
        margin: 16px;
    }
</style>

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

<form:errors path="*" cssClass="errorblock" element="div" />
<div>   
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="head-table">
        <tr>
            <td><form:label path="code"><spring:message code="code" text="Code"/><span class="required-indicator">*</span></form:label></td>
            <td><form:input path="code" type="text" required="true" size="30" maxlength="20"/></td>
            <td><form:errors path="code" cssClass="error" element="div"/></td>
            <td><form:label path="active"><spring:message code="active" text="Active"/></form:label></td>
            <td><form:checkbox path="active"/></td>
            <td><form:errors path="active" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="slNo"><spring:message code="slNo" text="Sl No"/></form:label></td>
            <td><form:input path="slNo" type="number" size="15" maxlength="15"/></td>
            <td><form:errors path="slNo" cssClass="error" element="div"/></td>
            <td><form:label path="name"><spring:message code="name" text="Name"/><span class="required-indicator">*</span></form:label></td>
            <td><form:input path="name" type="text" required="true" size="30" maxlength="100"/></td>
            <td><form:errors path="name" cssClass="error" element="div"/></td>
        </tr>
        <tr>

            <td><form:label path="remarks"><spring:message code="remarks" text="Remarks"/></form:label></td>
            <td><form:textarea path="remarks" type="text" size="30" maxlength="500"/></td>
            <td><form:errors path="remarks" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="lookupKeyword"><spring:message code="lookupKeyword" text="Lookup Keyword"/></form:label></td>
            <td>
                <form:select path="lookupKeyword" name="lookupKeyword" id="lookupKeyword" >
                    <form:option value="EDUCATION" label="EDUCATION"/>
                    <form:option value="BLOOD_GROUP" label="BLOOD GROUP"/>
                    <form:option value="PROFESSION" label="PROFESSION"/>
                </form:select>
            </td>
            <td><form:errors path="lookupKeyword" cssClass="error" element="div"/></td>
        </tr>

    </table>
</div>   