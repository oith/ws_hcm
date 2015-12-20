<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<spring:message code="profileJobDtls" text="Profile Job Details"/>
<c:if test="${not empty profile.profileJobDtls}">
    <div style=" padding-top: 10px; padding-bottom: 10px">
        <div id="div_ProfileJobDtls" style="margin: auto; overflow-x: scroll">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
                <thead style="color: white; background-color: #967ADC; text-align: center; font-weight: bold">
                    <tr>
                        <td><spring:message code="org" text="Organization"/></td>
                        <td><spring:message code="fromDate" text="From Date"/></td>
                        <td><spring:message code="toDate" text="To Date"/></td>
                        <td><spring:message code="remarks" text="Remarks"/></td>
                        <td><spring:message code="slNo" text="Sl No"/></td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${profile.profileJobDtls}" var="profileJobDtl"  varStatus="loopStatus">
                        <tr  class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                            <td><c:out value="${profileJobDtl.org}"/></td>
                            <td><fmt:formatDate value="${profileJobDtl.fromDate}" type="date" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${profileJobDtl.toDate}" type="date" pattern="dd/MM/yyyy"/></td>
                            <td><c:out value="${profileJobDtl.remarks}"/></td>
                            <td><c:out value="${profileJobDtl.slNo}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
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
        //$(".not_show").hide();

        $("#fromDate").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
        $("#toDate").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
    });

    $(document).on("click", "tr", function () {
        $("#job_id").val($("td:eq(0)", this).text());
        $("#org").val($("td:eq(2)", this).text());
        $("#fromDate").val($("td:eq(3)", this).text());
        $("#toDate").val($("td:eq(4)", this).text());
        $("#job_remarks").val($("td:eq(5)", this).text());
        $("#job_slNo").val($("td:eq(6)", this).text());
    });

    $(document).on("click", "#job_crt", function () {
        $("#job_id").val("");
        $("#org").val("");
        $("#fromDate").val("");
        $("#toDate").val("");
        $("#job_remarks").val("");
        $("#job_slNo").val("");
    });

    $(document).on("click", ".job_dtl_del", function () {
        var contextPath = "<%=request.getContextPath()%>";
        var action = "/profile/det/del/";
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: "GET",
            data: "",
            async: false,
            success: function (response) {
                $("#div_ProfileJobDtls").load(location.href + " #div_ProfileJobDtls>*", "");
//                alert("Data deleted successfully!");
                setTimeout(function () {
                    alert("Data deleted successfully!");
                }, 500);
            },
            error: function (exception) {
                alert(
                        "Sorry, an error occurred! Please try again later\n" +
                        "(ProfileJobDtls/Erase)"
                        );
            }
        });
    });
</script>