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

    $(document).ready(function () {
        $("#datepicker_startDate").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
    });


//function getCodableDTO(obj1, lblEmployeeName,lblEmployeeID){
//    var code = obj1; 
//   
//    $.ajax({
//        type : "GET",
//        url: '/MAC_CONTEXT_PATH/profile/getCodableDTOemp',
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
<%--<form:hidden path="id"/>--%>

<div>   
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="head-table"> 
        <tr>
            <td><form:label path="firstName"><spring:message code="firstName" text="First Name"/></form:label></td>
            <td><form:input path="firstName" type="text" size="30" maxlength="30"/></td>
            <td><form:errors path="firstName" cssClass="error" element="div"/></td>
            <td><form:label path="middleName"><spring:message code="middleName" text="Middle Name"/></form:label></td>
            <td><form:input path="middleName" type="text" size="30" maxlength="30"/></td>
            <td><form:errors path="middleName" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="lastName"><spring:message code="lastName" text="Last Name"/></form:label></td>
            <td><form:input path="lastName" type="text" size="30" maxlength="30"/></td>
            <td><form:errors path="lastName" cssClass="error" element="div"/></td>
            <td><form:label path="nickName"><spring:message code="nickName" text="Nick Name"/></form:label></td>
            <td><form:input path="nickName" type="text" size="30" maxlength="30"/></td>
            <td><form:errors path="nickName" cssClass="error" element="div"/></td>
        </tr>
        <tr>
            <td><form:label path="profilePicFile"><spring:message code="profilePicFile" text="profile Pic File"/></form:label></td>
                <td>
                    <!--<img height="110px" width="90px" alt="${profile.profilePicFile}" src="<%=request.getContextPath()%>/pics/${profile.profilePicFile}"/>-->

                <c:url var="macImage" value="/profile/getPhoto/${profile.profilePicFile}" />
                <!--<div id="preview">-->
                <img id="imagePreview" height="110px" width="90px" src="${macImage}" alt="${macImage}"/>
                <!--</div>-->

                <form:hidden path="profilePicFile"/>
                <input id="profilePicFileOBJ" name="profilePicFileOBJ" type="file" accept="image/*"/>
            </td> 
            <td><form:errors path="profilePicFile" cssClass="error" element="div"/></td>
        </tr>
    </table>
</div>   