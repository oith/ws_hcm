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
//        url: '/MAC_CONTEXT_PATH/post/getCodableDTOpost',
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
<form:hidden path="id"/>
<form:hidden path="user.id"/>
<div>   
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="head-table">
        <tr>

            <td><form:label path="subject"><spring:message code="subject" text="Subject"/></form:label></td>
            <td><form:textarea path="subject" type="text" size="30" maxlength="500"/></td>
            <td><form:errors path="subject" cssClass="error" element="div"/></td>
            <td><form:label path="content"><spring:message code="content" text="Content"/></form:label></td>
            <td><form:textarea path="content" type="text" size="30" maxlength="500"/></td>
            <td><form:errors path="content" cssClass="error" element="div"/></td>
        </tr>


    </table>
</div>   