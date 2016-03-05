<%@ page contentType='text/html;charset=UTF-8' language='java'%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form'%>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
</head>

<button id='divisions_create' type='button' class='btn btn-primary' data-toggle='modal' data-target='#divisions_modal'><spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='divisions' text='Divisions'/></button>

<c:if test='${not empty account.divisions}'>
    <div class='table-responsive'>
        <table class='table table-striped table-bordered table-hover table-condensed'>
            <thead>
                <tr>
                    <th></th>
                    <th></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items='${account.divisions}' var='divisions' varStatus='loopStatus'>
                    <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                        <td><c:out value='${loopStatus.index}'/></td>
                        <td><button id='${account.id}~${loopStatus.index}' type='button' class='btn btn-info' value='${account.id}~${loopStatus.index}' data-toggle='modal' data-target='#divisions_modal' class='btn btn-primary'><spring:message code='edit.link.label' text='Edit'/></button></td>

                        <td><button type='button' class='divisions_del btn btn-warning' value='divisions~${account.id}~${loopStatus.index}'><spring:message code='erase.button.label' text='Erase'/></button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class='container'>
    <!-- Modal -->
    <div class='modal fade' id='divisions_modal' role='dialog'>
        <div class='modal-dialog'>
            <div class='modal-content'>

                <form:form action='${pageContext.request.contextPath}/account/divisions/edit/${account.id}' commandName='divisions' method='POST' class='form-horizontal'>

                    <!--modal-header-->
                    <div class='modal-header' style='background-color: #5D9CEC'>
                        <div class='form-group'>
                            <h4 class='modal-title col-md-6' style='float: left'>
                                <spring:message code='divisions' text='Divisions'/>
                            </h4>
                            <button type='button' class='close col-md-6' data-dismiss='modal' style='float: right; text-align: right; color: red'>&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class='modal-body'>

                        <input type='hidden' name='accountId' id='accountId' value='${account.id}'>
                        <input type='hidden' name='embdId' id='divisions_id' value=''>

                        <div style='padding-left: 15px' class='form-group'></div>
                    </div>

                    <!--modal-footer-->
                    <div class='modal-footer' style='background-color: #4FC1E9'>
                        <input type='submit' class='btn btn-primary' value='<spring:message code='create.page.submit.label' text='Save'/>'/>
                        <button type='button' class='btn btn-warning' data-dismiss='modal'>Close</button>
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
<script type='text/javascript'>
    $(document).ready(function () {
        //$('.not_show').hide();
    });

    $(document).on('click', 'tr', function () {
        $('#divisions_id').val($('td:eq(0)', this).text());

    });

    $(document).on('click', '#divisions_create', function () {
        $('#divisions_id').val('');

    });

    $(document).on('click', '.divisions_del', function () {
        var contextPath = '<%=request.getContextPath()%>';
        var action = '/account/det/del/';
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: 'GET',
            data: '',
            async: false,
            success: function (response) {
                $('#div_divisions').load(location.href + ' #div_divisions>*', '');
                //alert('Data deleted successfully!');
                setTimeout(function () {
                    alert('Data deleted successfully!');
                }, 200);
            },
            error: function (exception) {
                alert(
                        'Sorry, an error occurred! Please try again later\n' +
                        '(divisions/Erase)'
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->