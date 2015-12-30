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

<button id="favorites_create" type="button" class="btn btn-primary" data-toggle="modal" data-target="#favorites_modal"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="favorites" text="FAVORITES"/></button>

<c:if test="${not empty user.favorites}">
    <div id="div_favorites" style="margin: auto; overflow-x: scroll; padding-top: 10px">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
            <thead style="color: white; background-color: #4A89DC; text-align: center">
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code="menuType" text="menuType"/></th>
                    <th><spring:message code="text" text="text"/></th>
                    <th><spring:message code="address" text="address"/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${user.favorites}" var="favorites" varStatus="loopStatus">
                    <tr class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                        <td><c:out value="${loopStatus.index}"/></td>
                        <td><button id="${user.id}~${loopStatus.index}" type="button" class="btn btn-info" value="${user.id}~${loopStatus.index}" data-toggle="modal" data-target="#favorites_modal" class="btn btn-primary"><spring:message code="edit.link.label" text="Edit"/></button></td>
                        <td><c:out value="${favorites.menuType}"/></td>
                        <td><c:out value="${favorites.text}"/></td>
                        <td><c:out value="${favorites.address}"/></td>

                        <td><button type="button" class="favorites_del btn btn-warning" value="favorites~${user.id}~${loopStatus.index}">Erase</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="favorites_modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">

                <form:form action="${pageContext.request.contextPath}/user/favorites/edit" commandName="favorites" method="POST" class="form-horizontal">

                    <!--modal-header-->                
                    <div class="modal-header" style="background-color: #5D9CEC">
                        <div class="form-group">
                            <h4 class="modal-title col-md-6" style="float: left">
                                <spring:message code="favorites" text="FAVORITES"/>
                            </h4>
                            <button type="button" class="close col-md-6" data-dismiss="modal" style="float: right; text-align: right; color: red">&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class="modal-body">

                        <input type="hidden" name="userId" id="userId" value="${user.id}" >
                        <input type="hidden" name="embdId" id="favorites_id" value="" >
                        <div class="col-xs-6">
                            <spring:message code="menuType" text="menuType"/>
                            <input type="text" name="menuType" id="favorites_menuType" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="text" text="text"/>
                            <input type="text" name="text" id="favorites_text" class="form-control" value="" >
                        </div>
                        <div class="col-xs-6">
                            <spring:message code="address" text="address"/>
                            <input type="text" name="address" id="favorites_address" class="form-control" value="" >
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
        $("#favorites_id").val($("td:eq(0)", this).text());
        $("#favorites_menuType").val($("td:eq(2)", this).text());
        $("#favorites_text").val($("td:eq(3)", this).text());
        $("#favorites_address").val($("td:eq(4)", this).text());

    });

    $(document).on("click", "#favorites_create", function () {
        $("#favorites_id").val("");
        $("#favorites_menuType").val("");
        $("#favorites_text").val("");
        $("#favorites_address").val("");

    });

    $(document).on("click", ".favorites_del", function () {
        var contextPath = "<%=request.getContextPath()%>";
        var action = "/user/det/del/";
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: "GET",
            data: "",
            async: false,
            success: function (response) {
                $("#div_favorites").load(location.href + " #div_favorites>*", "");
                //                alert("Data deleted successfully!");
                setTimeout(function () {
                    alert("Data deleted successfully!");
                }, 200);
            },
            error: function (exception) {
                alert(
                        "Sorry, an error occurred! Please try again later\n" +
                        "(favorites/Erase)"
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->