<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<spring:message code="profileEduDtls" text="Profile Education Details"/> | 
<button id="edu_crt" type="button" data-toggle="modal" data-target="#myModalEdu"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="ProfileEduDtl" text="Profile Education"/></button>


<c:if test="${not empty profile.profileEduDtls}">
    <div id="div_ProfileEduDtls" style="margin: auto; overflow-x: scroll; padding-top: 10px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="style-table">
            <thead style="color: white; background-color: #4A89DC; text-align: center">
                <tr>
                    <td class="not_show">go to</td>
                    <td>Edit</td>
                    <td><spring:message code="edu" text="Education"/></td>
                    <td><spring:message code="passingYear" text="Passing Year"/></td>
                    <td><spring:message code="remarks" text="Remarks"/></td>
                    <td><spring:message code="slNo" text="Sl No"/></td>
                    <td><spring:message code="erese" text="Erase"/></td>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${profile.profileEduDtls}" var="profileEduDtl"  varStatus="loopStatus">

                    <tr  class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                        <td class="not_show"><c:out value="${profileEduDtl.embdId}"/></td>
                        <td><button id="${profile.id}~${profileEduDtl.embdId}" type="button" value="${profile.id}~${profileEduDtl.embdId}" data-toggle="modal" data-target="#myModalEdu"><spring:message code="edit.link.label" text="Edit"/></button></td>
                        <td><c:out value="${profileEduDtl.edu}"/></td>
                        <td><c:out value="${profileEduDtl.passingYear}"/></td>
                        <td><c:out value="${profileEduDtl.remarks}"/></td>
                        <td><c:out value="${profileEduDtl.slNo}"/></td>
                        <td><button class="edu_dtl_del" type="button" class="btn btn-danger" value="ProfileEduDtls~${profile.id}~${profileEduDtl.embdId}">Erase</button></td>
                    </tr>

                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="myModalEdu" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">

                <!--modal-header-->                
                <div class="modal-header" style="background-color: #5D9CEC">    <!--UI Ref: https://bootstrapbay.com/blog/bootstrap-ui-kit/-->
                    <div class="form-group">
                        <h4 class="modal-title col-md-6" style="float: left">OITH Header</h4>
                        <button type="button" class="close col-md-6" data-dismiss="modal" style="float: right; text-align: right; color: red">&times;</button>
                    </div>
                </div>

                <form:form action="${pageContext.request.contextPath}/profileEduDtl/edit" enctype="multipart/form-data" commandName="profileEduDtl" method="POST">

                    <!--modal-body-->
                    <div class="modal-body">
                        <!--<div class="container">-->
                        <h2><spring:message code="ProfileEduDtl" text="Profile Education"/></h2>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>Profile ID</label>
                                <input type="text" name="profileId" id="profileId" class="form-control" value="${profile.id}" >
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>ID</label>
                                <input type="text" name="embdId" id="edu_id" class="form-control" value="" >
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <spring:message code="edu" text="Education"/>
                                <input type="text" name="edu" id="edu" class="form-control" value="" >
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>Passing Year</label>
                                <input type="number" name="passingYear" id="passingYear" class="form-control" value="" >
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <spring:message code="remarks" text="Remarks"/>
                                <input type="text" name="remarks" id="edu_remarks" class="form-control" value="" >
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <div class="form-group">
                                <spring:message code="slNo" text="Sl No"/>
                                <input type="number" name="slNo" id="edu_slNo" class="form-control" value="" >
                            </div>
                        </div>
                    </div>   
                                
                    <div style="padding-left: 15px">                        
                        <input type="submit" class="btn btn-primary" value="<spring:message code="create.page.submit.label" text="Save"/>"/>
                    </div>

                </form:form>
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