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

<button id='admReportDetails_create' type='button' class='btn btn-primary' data-toggle='modal' data-target='#admReportDetails_modal'><spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='admReportDetails' text='Adm Report Details'/></button>

<c:if test='${not empty admReport.admReportDetails}'>
    <div class='table-responsive'>
        <table class='table table-striped table-bordered table-hover table-condensed'>
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code='title' text='Title'/></th>
                    <th><spring:message code='paramName' text='Param Name'/></th>
                    <th><spring:message code='paramType' text='Param Type'/></th>
                    <th><spring:message code='isActive' text='Is Active'/></th>
                    <th><spring:message code='isMandatory' text='Is Mandatory'/></th>
                    <th><spring:message code='slNo' text='Sl No'/></th>
                    <th><spring:message code='cmd' text='Cmd'/></th>
                    <th><spring:message code='defaultVal' text='Default Val'/></th>
                    <th><spring:message code='helpText' text='Help Text'/></th>
                    <th><spring:message code='embdId' text='Embd Id'/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items='${admReport.admReportDetails}' var='admReportDetails' varStatus='loopStatus'>
                    <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                        <td><c:out value='${admReportDetails.embdId}'/></td>
                        <td><button id='${admReport.id}~${admReportDetails.embdId}' type='button' class='btn btn-info' value='${admReport.id}~${admReportDetails.embdId}' data-toggle='modal' data-target='#admReportDetails_modal' class='btn btn-primary'><spring:message code='edit.link.label' text='Edit'/></button></td>
                        <td><c:out value='${admReportDetails.title}'/></td>
                        <td><c:out value='${admReportDetails.paramName}'/></td>
                        <td><c:out value='${admReportDetails.paramType}'/></td>
                        <td><c:out value='${admReportDetails.isActive}'/></td>
                        <td><c:out value='${admReportDetails.isMandatory}'/></td>
                        <td><c:out value='${admReportDetails.slNo}'/></td>
                        <td><c:out value='${admReportDetails.cmd}'/></td>
                        <td><c:out value='${admReportDetails.defaultVal}'/></td>
                        <td><c:out value='${admReportDetails.helpText}'/></td>
                        <td><c:out value='${admReportDetails.embdId}'/></td>

                        <td><button type='button' class='admReportDetails_del btn btn-warning' value='admReportDetails~${admReport.id}~${admReportDetails.embdId}'><spring:message code='erase.button.label' text='Erase'/></button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class='container'>
    <!-- Modal -->
    <div class='modal fade' id='admReportDetails_modal' role='dialog'>
        <div class='modal-dialog'>
            <div class='modal-content'>

                <form:form action='${pageContext.request.contextPath}/admReport/admReportDetails/edit/${admReport.id}' commandName='admReportDetails' method='POST' class='form-horizontal'>

                    <!--modal-header-->
                    <div class='modal-header' style='background-color: #5D9CEC'>
                        <div class='form-group'>
                            <h4 class='modal-title col-md-6' style='float: left'>
                                <spring:message code='admReportDetails' text='Adm Report Details'/>
                            </h4>
                            <button type='button' class='close col-md-6' data-dismiss='modal' style='float: right; text-align: right; color: red'>&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class='modal-body'>

                        <input type='hidden' name='admReportId' id='admReportId' value='${admReport.id}'>
                        <input type='hidden' name='embdId' id='admReportDetails_id' value=''>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='title' text='Title'/>
                                <input type='text' name='title' id='admReportDetails_title' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='paramName' text='Param Name'/>
                                <input type='text' name='paramName' id='admReportDetails_paramName' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='paramType' text='Param Type'/>
                                <input type='text' name='paramType' id='admReportDetails_paramType' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='isActive' text='Is Active'/>
                                <input type='checkbox' name='isActive' id='admReportDetails_isActive' class='checkbox' value=''>
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='isMandatory' text='Is Mandatory'/>
                                <input type='checkbox' name='isMandatory' id='admReportDetails_isMandatory' class='checkbox' value=''>
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='slNo' text='Sl No'/>
                                <input type='text' name='slNo' id='admReportDetails_slNo' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='cmd' text='Cmd'/>
                                <input type='text' name='cmd' id='admReportDetails_cmd' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='defaultVal' text='Default Val'/>
                                <input type='text' name='defaultVal' id='admReportDetails_defaultVal' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='helpText' text='Help Text'/>
                                <input type='text' name='helpText' id='admReportDetails_helpText' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='embdId' text='Embd Id'/>
                                <input type='text' name='embdId' id='admReportDetails_embdId' class='form-control' value='' >
                        </div>

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
        $('#admReportDetails_id').val($('td:eq(0)', this).text());
        $('#admReportDetails_title').val($('td:eq(2)', this).text());
        $('#admReportDetails_paramName').val($('td:eq(3)', this).text());
        $('#admReportDetails_paramType').val($('td:eq(4)', this).text());
        $('#admReportDetails_isActive').prop('checked', $('td:eq(5)', this).text());
        $('#admReportDetails_isMandatory').prop('checked', $('td:eq(6)', this).text());
        $('#admReportDetails_slNo').val($('td:eq(7)', this).text());
        $('#admReportDetails_cmd').val($('td:eq(8)', this).text());
        $('#admReportDetails_defaultVal').val($('td:eq(9)', this).text());
        $('#admReportDetails_helpText').val($('td:eq(10)', this).text());
        $('#admReportDetails_embdId').val($('td:eq(11)', this).text());

    });

    $(document).on('click', '#admReportDetails_create', function () {
        $('#admReportDetails_id').val('');
        $('#admReportDetails_title').val('');
        $('#admReportDetails_paramName').val('');
        $('#admReportDetails_paramType').val('');
        $('#admReportDetails_isActive').prop('checked', false);
        $('#admReportDetails_isMandatory').prop('checked', false);
        $('#admReportDetails_slNo').val('');
        $('#admReportDetails_cmd').val('');
        $('#admReportDetails_defaultVal').val('');
        $('#admReportDetails_helpText').val('');
        $('#admReportDetails_embdId').val('');

    });

    $(document).on('click', '.admReportDetails_del', function () {
        var contextPath = '<%=request.getContextPath()%>';
        var action = '/admReport/det/del/';
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: 'GET',
            data: '',
            async: false,
            success: function (response) {
                $('#div_admReportDetails').load(location.href + ' #div_admReportDetails>*', '');
                //alert('Data deleted successfully!');
                setTimeout(function () {
                    alert('Data deleted successfully!');
                }, 200);
            },
            error: function (exception) {
                alert(
                        'Sorry, an error occurred! Please try again later\n' +
                        '(admReportDetails/Erase)'
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->