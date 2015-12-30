<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<button id="voucherDtls_create" type="button" class="btn btn-primary" data-toggle="modal" data-target="#voucherDtls_modal"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="voucherDtls" text="Voucher Dtls"/></button>

<c:if test="${not empty voucher.voucherDtls}">
    <div id="div_voucherDtls" style="margin: auto; overflow-x: scroll; padding-top: 10px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
            <thead style="color: white; background-color: #4A89DC; text-align: center">
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code="companyCode" text="Company Code"/></th>
                    <th><spring:message code="costCenter" text="Cost Center"/></th>
                    <th><spring:message code="coa" text="Coa"/></th>
                    <th><spring:message code="amountDr" text="Amount Dr"/></th>
                    <th><spring:message code="amountCr" text="Amount Cr"/></th>
                    <th><spring:message code="coaOpposite" text="Coa Opposite"/></th>
                    <th><spring:message code="emp" text="Emp"/></th>
                    <th><spring:message code="narration" text="Narration"/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${voucher.voucherDtls}" var="voucherDtls" varStatus="loopStatus">
                    <tr class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                        <td><c:out value="${loopStatus.index}"/></td>
                        <td><button id="${voucher.id}~${loopStatus.index}" type="button" class="btn btn-info" value="${voucher.id}~${loopStatus.index}" data-toggle="modal" data-target="#voucherDtls_modal" class="btn btn-primary"><spring:message code="edit.link.label" text="Edit"/></button></td>
                        <td><c:out value="${voucherDtls.companyCode}"/></td>
                        <td><c:out value="${voucherDtls.costCenter}"/></td>
                        <td><c:out value="${voucherDtls.coa}"/></td>
                        <td><c:out value="${voucherDtls.amountDr}"/></td>
                        <td><c:out value="${voucherDtls.amountCr}"/></td>
                        <td><c:out value="${voucherDtls.coaOpposite}"/></td>
                        <td><c:out value="${voucherDtls.emp}"/></td>
                        <td><c:out value="${voucherDtls.narration}"/></td>

                        <td><button type="button" class="voucherDtls_del btn btn-warning" value="voucherDtls~${voucher.id}~${loopStatus.index}">Erase</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="voucherDtls_modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">

                <form:form action="${pageContext.request.contextPath}/voucher/voucherDtls/edit" commandName="voucherDtls" method="POST" class="form-horizontal">

                    <!--modal-header-->                
                    <div class="modal-header" style="background-color: #5D9CEC">
                        <div class="form-group">
                            <h4 class="modal-title col-md-6" style="float: left">
                                <spring:message code="voucherDtls" text="Voucher Dtls"/>
                            </h4>
                            <button type="button" class="close col-md-6" data-dismiss="modal" style="float: right; text-align: right; color: red">&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class="modal-body">

                        <input type="hidden" name="voucherId" id="voucherId" value="${voucher.id}" >
                        <input type="hidden" name="embdId" id="voucherDtls_id" value="" >
                        <div class="col-xs-6">
                            <spring:message code="companyCode" text="Company Code"/>
                            <input type="text" name="companyCode" id="voucherDtls_companyCode" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="costCenter" text="Cost Center"/>
                            <input type="text" name="costCenter" id="voucherDtls_costCenter" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="coa" text="Coa"/>
                            <input type="text" name="coa" id="voucherDtls_coa" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="amountDr" text="Amount Dr"/>
                            <input type="text" name="amountDr" id="voucherDtls_amountDr" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="amountCr" text="Amount Cr"/>
                            <input type="text" name="amountCr" id="voucherDtls_amountCr" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="coaOpposite" text="Coa Opposite"/>
                            <input type="text" name="coaOpposite" id="voucherDtls_coaOpposite" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="emp" text="Emp"/>
                            <input type="text" name="emp" id="voucherDtls_emp" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="narration" text="Narration"/>
                            <input type="text" name="narration" id="voucherDtls_narration" class="form-control" value="" >
                        </div>

                        <div style="padding-left: 15px" class="form-group"></div>
                    </div>

                    <!--modal-footer-->
                    <div class="modal-footer" style="background-color: #4FC1E9">
                        <input type="submit" class="btn btn-primary" value="<spring:message code="create.page.submit.label" text="Save"/>"/>
                        <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>    
                    </div>

                </form:form>
            </div>
        </div>
    </div>
</div>
<!--========================================================================================================================================-->
<style>
    .modal {
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
        $("#voucherDtls_id").val($("td:eq(0)", this).text());
        $("#voucherDtls_companyCode").val($("td:eq(2)", this).text());
        $("#voucherDtls_costCenter").val($("td:eq(3)", this).text());
        $("#voucherDtls_coa").val($("td:eq(4)", this).text());
        $("#voucherDtls_amountDr").val($("td:eq(5)", this).text());
        $("#voucherDtls_amountCr").val($("td:eq(6)", this).text());
        $("#voucherDtls_coaOpposite").val($("td:eq(7)", this).text());
        $("#voucherDtls_emp").val($("td:eq(8)", this).text());
        $("#voucherDtls_narration").val($("td:eq(9)", this).text());

    });

    $(document).on("click", "#voucherDtls_create", function () {
        $("#voucherDtls_id").val("");
        $("#voucherDtls_companyCode").val("");
        $("#voucherDtls_costCenter").val("");
        $("#voucherDtls_coa").val("");
        $("#voucherDtls_amountDr").val("");
        $("#voucherDtls_amountCr").val("");
        $("#voucherDtls_coaOpposite").val("");
        $("#voucherDtls_emp").val("");
        $("#voucherDtls_narration").val("");

    });

    $(document).on("click", ".voucherDtls_del", function () {
        var contextPath = "<%=request.getContextPath()%>";
        var action = "/voucher/det/del/";
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: "GET",
            data: "",
            async: false,
            success: function (response) {
                $("#div_voucherDtls").load(location.href + " #div_voucherDtls>*", "");
                //                alert("Data deleted successfully!");
                setTimeout(function () {
                    alert("Data deleted successfully!");
                }, 200);
            },
            error: function (exception) {
                alert(
                        "Sorry, an error occurred! Please try again later\n" +
                        "(voucherDtls/Erase)"
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->