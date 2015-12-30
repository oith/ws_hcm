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

<button id="params_create" type="button" class="btn btn-primary" data-toggle="modal" data-target="#params_modal"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="params" text="PARAMS"/></button>

<c:if test="${not empty user.params}">
    <div id="div_params" style="margin: auto; overflow-x: scroll; padding-top: 10px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
            <thead style="color: white; background-color: #4A89DC; text-align: center">
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code="controller" text="controller"/></th>
                    <th><spring:message code="action" text="action"/></th>
                    <th><spring:message code="property" text="property"/></th>
                    <th><spring:message code="value" text="value"/></th>
                    <th><spring:message code="valueType" text="valueType"/></th>
                    <th><spring:message code="className" text="className"/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${user.params}" var="params" varStatus="loopStatus">
                    <tr class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                        <td><c:out value="${loopStatus.index}"/></td>
                        <td><button id="${user.id}~${loopStatus.index}" type="button" class="btn btn-info" value="${user.id}~${loopStatus.index}" data-toggle="modal" data-target="#params_modal" class="btn btn-primary"><spring:message code="edit.link.label" text="Edit"/></button></td>
                        <td><c:out value="${params.controller}"/></td>
                        <td><c:out value="${params.action}"/></td>
                        <td><c:out value="${params.property}"/></td>
                        <td><c:out value="${params.value}"/></td>
                        <td><c:out value="${params.valueType}"/></td>
                        <td><c:out value="${params.className}"/></td>

                        <td><button type="button" class="params_del btn btn-warning" value="params~${user.id}~${loopStatus.index}">Erase</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="params_modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">

                <form:form action="${pageContext.request.contextPath}/user/params/edit" commandName="params" method="POST" class="form-horizontal">

                    <!--modal-header-->                
                    <div class="modal-header" style="background-color: #5D9CEC">
                        <div class="form-group">
                            <h4 class="modal-title col-md-6" style="float: left">
                                <spring:message code="params" text="PARAMS"/>
                            </h4>
                            <button type="button" class="close col-md-6" data-dismiss="modal" style="float: right; text-align: right; color: red">&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class="modal-body">

                        <input type="hidden" name="userId" id="userId" value="${user.id}" >
                        <input type="hidden" name="embdId" id="params_id" value="" >
                        <div class="col-xs-6">
                            <spring:message code="controller" text="controller"/>
                            <input type="text" name="controller" id="params_controller" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="action" text="action"/>
                            <input type="text" name="action" id="params_action" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="property" text="property"/>
                            <input type="text" name="property" id="params_property" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="value" text="value"/>
                            <input type="text" name="value" id="params_value" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="valueType" text="valueType"/>
                            <input type="text" name="valueType" id="params_valueType" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="className" text="className"/>
                            <input type="text" name="className" id="params_className" class="form-control" value="" >
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
        $("#params_id").val($("td:eq(0)", this).text());
        $("#params_controller").val($("td:eq(2)", this).text());
        $("#params_action").val($("td:eq(3)", this).text());
        $("#params_property").val($("td:eq(4)", this).text());
        $("#params_value").val($("td:eq(5)", this).text());
        $("#params_valueType").val($("td:eq(6)", this).text());
        $("#params_className").val($("td:eq(7)", this).text());

    });

    $(document).on("click", "#params_create", function () {
        $("#params_id").val("");
        $("#params_controller").val("");
        $("#params_action").val("");
        $("#params_property").val("");
        $("#params_value").val("");
        $("#params_valueType").val("");
        $("#params_className").val("");

    });

    $(document).on("click", ".params_del", function () {
        var contextPath = "<%=request.getContextPath()%>";
        var action = "/user/det/del/";
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: "GET",
            data: "",
            async: false,
            success: function (response) {
                $("#div_params").load(location.href + " #div_params>*", "");
                //                alert("Data deleted successfully!");
                setTimeout(function () {
                    alert("Data deleted successfully!");
                }, 200);
            },
            error: function (exception) {
                alert(
                        "Sorry, an error occurred! Please try again later\n" +
                        "(params/Erase)"
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->