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

<button id="profileJobDtls_create" type="button" class="btn btn-primary" data-toggle="modal" data-target="#profileJobDtls_modal"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="profileJobDtls" text="PROFILEJOBDTLS"/></button>

<c:if test="${not empty profile.profileJobDtls}">
    <div id="div_profileJobDtls" style="margin: auto; overflow-x: scroll; padding-top: 10px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
            <thead style="color: white; background-color: #4A89DC; text-align: center">
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code="org" text="org"/></th>
                    <th><spring:message code="startDate" text="startDate"/></th>
                    <th><spring:message code="endDate" text="endDate"/></th>
                    <th><spring:message code="remarks" text="remarks"/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${profile.profileJobDtls}" var="profileJobDtls" varStatus="loopStatus">
                    <tr class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                        <td><c:out value="${profileJobDtls.embdId}"/></td>
                        <td><button id="${profile.id}~${profileJobDtls.embdId}" type="button" class="btn btn-info" value="${profile.id}~${profileJobDtls.embdId}" data-toggle="modal" data-target="#profileJobDtls_modal" class="btn btn-primary"><spring:message code="edit.link.label" text="Edit"/></button></td>
                        <td><c:out value="${profileJobDtls.org}"/></td>
                        <td><c:out value="${profileJobDtls.startDate}"/></td>
                        <td><c:out value="${profileJobDtls.endDate}"/></td>
                        <td><c:out value="${profileJobDtls.remarks}"/></td>

                        <td><button type="button" class="profileJobDtls_del btn btn-warning" value="profileJobDtls~${profile.id}~${profileJobDtls.embdId}">Erase</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="profileJobDtls_modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">

                <form:form action="${pageContext.request.contextPath}/profile/profileJobDtls/edit" commandName="profileJobDtls" method="POST" class="form-horizontal">

                    <!--modal-header-->                
                    <div class="modal-header" style="background-color: #5D9CEC">
                        <div class="form-group">
                            <h4 class="modal-title col-md-6" style="float: left">
                                <spring:message code="ProfileEduDtl" text="Profile Education"/>
                            </h4>
                            <button type="button" class="close col-md-6" data-dismiss="modal" style="float: right; text-align: right; color: red">&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class="modal-body">

                        <input type="hidden" name="profileId" id="profileId" value="${profile.id}" >
                        <input type="hidden" name="embdId" id="profileJobDtls_id" value="" >
                        <div class="col-xs-6">
                            <spring:message code="org" text="org"/>
                            <input type="text" name="org" id="profileJobDtls_org" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="startDate" text="startDate"/>
                            <input type="text" name="startDate" id="profileJobDtls_startDate" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="endDate" text="endDate"/>
                            <input type="text" name="endDate" id="profileJobDtls_endDate" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="remarks" text="remarks"/>
                            <input type="text" name="remarks" id="profileJobDtls_remarks" class="form-control" value="" >
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
        $("#profileJobDtls_id").val($("td:eq(0)", this).text());
        $("#profileJobDtls_org").val($("td:eq(2)", this).text());
        $("#profileJobDtls_startDate").val($("td:eq(3)", this).text());
        $("#profileJobDtls_endDate").val($("td:eq(4)", this).text());
        $("#profileJobDtls_remarks").val($("td:eq(5)", this).text());

    });

    $(document).on("click", "#profileJobDtls_create", function () {
        $("#profileJobDtls_id").val("");
        $("#profileJobDtls_org").val("");
        $("#profileJobDtls_startDate").val("");
        $("#profileJobDtls_endDate").val("");
        $("#profileJobDtls_remarks").val("");

    });

    $(document).on("click", ".profileJobDtls_del", function () {
        var contextPath = "<%=request.getContextPath()%>";
        var action = "/profile/det/del/";
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: "GET",
            data: "",
            async: false,
            success: function (response) {
                $("#div_profileJobDtls").load(location.href + " #div_profileJobDtls>*", "");
                //                alert("Data deleted successfully!");
                setTimeout(function () {
                    alert("Data deleted successfully!");
                }, 200);
            },
            error: function (exception) {
                alert(
                        "Sorry, an error occurred! Please try again later\n" +
                        "(profileJobDtls/Erase)"
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->