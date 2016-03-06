<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<spring:message code="profileEduDtls" text="Profile Education Details"/> 

<c:if test="${not empty profile.profileEduDtls}">
    <div id="div_ProfileEduDtls" style="margin: auto; overflow-x: scroll; padding-top: 10px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
            <thead style="color: white; background-color: #4A89DC; text-align: center">
                <tr>
                    <td><spring:message code="edu" text="Education"/></td>
                    <td><spring:message code="passingYear" text="Passing Year"/></td>
                    <td><spring:message code="remarks" text="Remarks"/></td>
                    <td><spring:message code="slNo" text="Sl No"/></td>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${profile.profileEduDtls}" var="profileEduDtl"  varStatus="loopStatus">

                    <tr  class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                        <td><c:out value="${profileEduDtl.edu}"/></td>
                        <td><c:out value="${profileEduDtl.passingYear}"/></td>
                        <td><c:out value="${profileEduDtl.remarks}"/></td>
                        <td><c:out value="${profileEduDtl.slNo}"/></td>
                    </tr>

                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<!--========================================================================================================================================-->
<style>
    .modal {
        /*left: 50%;*/
        /*bottom: auto;*/
        /*right: auto;*/
        /*z-index: 1050;*/
        /*padding: 0;*/
        /*width: 600px;*/
        /*margin-left: -250px;*/
        /*margin-top: 20px;*/
        /*background-color: #ffffff;*/
        /*background-color: transparent;*/
        border: 1px solid #999999;
        border: 1px solid rgba(0, 0, 0, 0.2);
        border-radius: 6px;
        -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
        box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
        background-clip: padding-box;
    }
</style>
<!-------------------------------------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
    $(document).ready(function () {
        //    $(".not_show").hide();
    });

    $(document).on("click", "tr", function () {
        $("#edu_id").val($("td:eq(0)", this).text());
        $("#edu").val($("td:eq(2)", this).text());
        $("#passingYear").val($("td:eq(3)", this).text());
        $("#edu_remarks").val($("td:eq(4)", this).text());
        $("#edu_slNo").val($("td:eq(5)", this).text());
    });

    $(document).on("click", "#edu_crt", function () {
        $("#edu_id").val("");
        $("#edu").val("");
        $("#passingYear").val("");
        $("#edu_remarks").val("");
        $("#edu_slNo").val("");
    });

    $(document).on("click", ".edu_dtl_del", function () {
        var contextPath = "<%=request.getContextPath()%>";
        var action = "/profile/det/del/";
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: "GET",
            data: "",
            async: false,
            success: function (response) {
                $("#div_ProfileEduDtls").load(location.href + " #div_ProfileEduDtls>*", "");
//                alert("Data deleted successfully!");
                setTimeout(function () {
                    alert("Data deleted successfully!");
                }, 200);
            },
            error: function (exception) {
                alert(
                        "Sorry, an error occurred! Please try again later\n" +
                        "(ProfileEduDtls/Erase)"
                        );
            }
        });
    });


</script>
<!--========================================================================================================================================-->