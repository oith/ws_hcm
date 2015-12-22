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

<button id="profileEduDtls_create" type="button" class="btn btn-primary" data-toggle="modal" data-target="#profileEduDtls_modal"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="profileEduDtls" text="PROFILEEDUDTLS"/></button>

<c:if test="${not empty profile.profileEduDtls}">
    <div id="div_profileEduDtls" style="margin: auto; overflow-x: scroll; padding-top: 10px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
            <thead style="color: white; background-color: #4A89DC; text-align: center">
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code="edu" text="edu"/></th>
                    <th><spring:message code="grade" text="grade"/></th>
                    <th><spring:message code="passingYear" text="passingYear"/></th>
                    <th><spring:message code="remarks" text="remarks"/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${profile.profileEduDtls}" var="profileEduDtls" varStatus="loopStatus">
                    <tr class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                        <td><c:out value="${profileEduDtls.embdId}"/></td>
                        <td><button id="${profile.id}~${profileEduDtls.embdId}" type="button" class="btn btn-info" value="${profile.id}~${profileEduDtls.embdId}" data-toggle="modal" data-target="#profileEduDtls_modal" class="btn btn-primary"><spring:message code="edit.link.label" text="Edit"/></button></td>
                        <td><c:out value="${profileEduDtls.edu}"/></td>
                        <td><c:out value="${profileEduDtls.grade}"/></td>
                        <td><c:out value="${profileEduDtls.passingYear}"/></td>
                        <td><c:out value="${profileEduDtls.remarks}"/></td>

                        <td><button type="button" class="profileEduDtls_del btn btn-warning" value="profileEduDtls~${profile.id}~${profileEduDtls.embdId}">Erase</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="profileEduDtls_modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">

                <form:form action="${pageContext.request.contextPath}/profile/profileEduDtls/edit" commandName="profileEduDtls" method="POST" class="form-horizontal">

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
                        <input type="hidden" name="embdId" id="profileEduDtls_id" value="" >
                        <div class="col-xs-6">
                            <spring:message code="edu" text="edu"/>
                            <input type="text" name="edu" id="profileEduDtls_edu" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="grade" text="grade"/>
                            <input type="text" name="grade" id="profileEduDtls_grade" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="passingYear" text="passingYear"/>
                            <input type="text" name="passingYear" id="profileEduDtls_passingYear" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="remarks" text="remarks"/>
                            <input type="text" name="remarks" id="profileEduDtls_remarks" class="form-control" value="" >
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
        $("#profileEduDtls_id").val($("td:eq(0)", this).text());
        $("#profileEduDtls_edu").val($("td:eq(2)", this).text());
        $("#profileEduDtls_grade").val($("td:eq(3)", this).text());
        $("#profileEduDtls_passingYear").val($("td:eq(4)", this).text());
        $("#profileEduDtls_remarks").val($("td:eq(5)", this).text());

    });

    $(document).on("click", "#profileEduDtls_create", function () {
        $("#profileEduDtls_id").val("");
        $("#profileEduDtls_edu").val("");
        $("#profileEduDtls_grade").val("");
        $("#profileEduDtls_passingYear").val("");
        $("#profileEduDtls_remarks").val("");

    });

    $(document).on("click", ".profileEduDtls_del", function () {
        var contextPath = "<%=request.getContextPath()%>";
        var action = "/profile/det/del/";
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: "GET",
            data: "",
            async: false,
            success: function (response) {
                $("#div_profileEduDtls").load(location.href + " #div_profileEduDtls>*", "");
                //                alert("Data deleted successfully!");
                setTimeout(function () {
                    alert("Data deleted successfully!");
                }, 200);
            },
            error: function (exception) {
                alert(
                        "Sorry, an error occurred! Please try again later\n" +
                        "(profileEduDtls/Erase)"
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->