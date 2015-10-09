<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<spring:message code="profileJobDtls" text="Profile Job Details"/> | 
<button id="job_crt" type="button" data-toggle="modal" data-target="#myModalJob"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="ProfileJobDtl" text="Profile Job"/></button>

<c:if test="${not empty profile.profileJobDtls}">
    <div style=" padding-top: 10px; padding-bottom: 10px">
        <div id="div_ProfileJobDtls" style="margin: auto; overflow-x: scroll">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="style-table">
                <thead style="color: white; background-color: #967ADC; text-align: center; font-weight: bold">
                    <tr>
                        <td class="not_show">go to</td>
                        <td>Edit</td>
                        <td><spring:message code="org" text="Organization"/></td>
                        <td><spring:message code="fromDate" text="From Date"/></td>
                        <td><spring:message code="toDate" text="To Date"/></td>
                        <td><spring:message code="remarks" text="Remarks"/></td>
                        <td><spring:message code="slNo" text="Sl No"/></td>
                        <td><spring:message code="erese" text="Erase"/></td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${profile.profileJobDtls}" var="profileJobDtl"  varStatus="loopStatus">
                        <tr  class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                            <td class="not_show"><c:out value="${profileJobDtl.embdId}"/></td>
                            <td><button id="${profile.id}~${profileJobDtl.embdId}" type="button" value="${profile.id}~${profileJobDtl.embdId}" data-toggle="modal" data-target="#myModalJob"><spring:message code="edit.link.label" text="Edit"/></button></td>
                            <td><c:out value="${profileJobDtl.org}"/></td>
                            <td><fmt:formatDate value="${profileJobDtl.fromDate}" type="date" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${profileJobDtl.toDate}" type="date" pattern="dd/MM/yyyy"/></td>
                            <td><c:out value="${profileJobDtl.remarks}"/></td>
                            <td><c:out value="${profileJobDtl.slNo}"/></td>
                            <td><button class="job_dtl_del" type="button" class="btn btn-danger" value="ProfileJobDtls~${profile.id}~${profileJobDtl.embdId}">Erase</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</c:if>



<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="myModalJob" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">

                <!--modal-header-->                
                <div class="modal-header" style="background-color: #5D9CEC">    <!--UI Ref: https://bootstrapbay.com/blog/bootstrap-ui-kit/-->
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h6 class="modal-title">OITH Header</h6>
                </div>

                <!--modal-body-->
                <div class="modal-body">
                    <h2><spring:message code="ProfileJobDtl" text="Profile Job"/></h2>
                    <form action="${pageContext.request.contextPath}/profileJobDtl/edit" enctype="multipart/form-data" commandName="profileJobDtl" method="POST">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>Profile ID</label>
                                <input type="text" name="profileId" id="profileId" class="form-control" value="${profile.id}" >
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>ID</label>
                                <input type="text" name="embdId" id="job_id" class="form-control">
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <spring:message code="organization" text="Organization"/>
                                <input type="text" name="org" id="org" class="form-control">
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <spring:message code="fromDate" text="From Date"/>
                                <input type="date" name="fromDate" id="fromDate" class="form-control" value="" placeholder="DD/MM/YYYY">
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <spring:message code="toDate" text="To Date"/>
                                <input type="date" name="toDate" id="toDate" class="form-control" placeholder="DD/MM/YYYY">
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <spring:message code="remarks" text="Remarks"/>
                                <input type="text" name="remarks" id="job_remarks" class="form-control" value="" >
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <spring:message code="slNo" text="Sl No"/>
                                <input type="number" name="slNo" id="job_slNo" class="form-control" value="" >
                            </div>
                        </div>                                 

                        <div style="padding-left: 15px" class="form-group">
                            <input type="submit" class="btn btn-primary" value="<spring:message code="create.page.submit.label" text='Save'/>"/>
                        </div>
                    </form>
                </div>

                <!--modal-footer-->
                <div class="modal-footer" style="background-color: #4FC1E9">
                    <!--<button type="button" class="btn btn-default" data-dismiss="modal">Save</button>-->
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
</div>
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