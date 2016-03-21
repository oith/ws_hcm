<%@ page contentType='text/html;charset=UTF-8' language='java'%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form'%>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>

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
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items='${admReport.admReportDetails}' var='admReportDetails' varStatus='loopStatus'>
                    <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                        <td><c:out value='${admReportDetails.embdId}'/></td>
                        <td><button id='${admReport.id}~${admReportDetails.embdId}' type='button' class='btn btn-info' value='${admReport.id}~${admReportDetails.embdId}' data-toggle='modal' data-target='#admReportDetails_modal' class='btn btn-primary'><spring:message code='edit.link.label' text='Edit'/></button></td>
                        <td><c:out value='${admReportDetails.admParam.title}'/></td>
                        <td><c:out value='${admReportDetails.admParam.paramName}'/></td>
                        <td><c:out value='${admReportDetails.admParam.widgetType}'/></td>
                        <td><c:out value='${admReportDetails.admParam.isActive}'/></td>
                        <td><c:out value='${admReportDetails.admParam.isMandatory}'/></td>
                        <td><c:out value='${admReportDetails.admParam.slNo}'/></td>
                        <td><c:out value='${admReportDetails.admParam.cmd}'/></td>
                        <td><c:out value='${admReportDetails.admParam.defaultVal}'/></td>
                        <td><c:out value='${admReportDetails.admParam.helpText}'/></td>
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

                <form:form action='${pageContext.request.contextPath}/admReport/admReportDetails/edit/${admReport.id}' commandName='admReportDetail' method='POST' class='form-horizontal'>

                    <!--modal-header-->
                    <div class="modal-header" style="padding:10px 50px;">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4>
                            <i class="glyphicon glyphicon-copy"></i>
                            <spring:message code='admReportDetails' text='Adm Report Details'/>
                        </h4>
                    </div>



                    <!--modal-body-->
                    <div class='modal-body'>

                        <input type='hidden' name='embdId' id='admReportDetails_embdId' value=''>

                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='title' text='Title'/>
                            <input type='text' name='admParam.title' id='admReportDetails_admParam_title' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='paramName' text='Param Name'/>
                            <input type='text' name='admParam.paramName' id='admReportDetails_admParam_paramName' class='form-control' value='' >
                        </div>

                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='widgetType' text='Widget Type'/>
                            <select  class='form-control' name='admParam.widgetType' id='admReportDetails_admParam_widgetType' required='true' >
                                <c:forEach items='${widgetTypes}' var='sss' varStatus='loopStatus'>
                                    <option value=${sss}>${sss}</option>
                                </c:forEach>
                            </select>
                        </div>



                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <div class='checkbox'>
                                <label>
                                    <input id='admReportDetails_admParam_isActive' name='admParam.isActive' type='checkbox'  value='true'><spring:message code='isActive' text='is Active'/>
                                </label>
                            </div>
                        </div>

                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <div class='checkbox'>
                                <label>
                                    <input id='admReportDetails_admParam_isMandatory' name='admParam.isMandatory' type='checkbox'  value='true'><spring:message code='isMandatory' text='is Mandatory'/>
                                </label>
                            </div>
                        </div>


                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='slNo' text='Sl No'/>
                            <input type='text' name='admParam.slNo' id='admReportDetails_admParam_slNo' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='cmd' text='Cmd'/>
                            <input type='text' name='admParam.cmd' id='admReportDetails_admParam_cmd' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='defaultVal' text='Default Val'/>
                            <input type='text' name='admParam.defaultVal' id='admReportDetails_admParam_defaultVal' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='helpText' text='Help Text'/>
                            <input type='text' name='admParam.helpText' id='admReportDetails_admParam_helpText' class='form-control' value='' >
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

<script type='text/javascript'>
    $(document).ready(function () {
        //$('.not_show').hide();
    });

    $(document).on('click', 'tr', function () {
        $('#admReportDetails_embdId').val($('td:eq(0)', this).text());
        $('#admReportDetails_admParam_title').val($('td:eq(2)', this).text());
        $('#admReportDetails_admParam_paramName').val($('td:eq(3)', this).text());
        $('#admReportDetails_admParam_widgetType').val($('td:eq(4)', this).text());
        $('#admReportDetails_admParam_isActive').prop('checked', $('td:eq(5)', this).text() === 'true');//=  ;
        $('#admReportDetails_admParam_isMandatory').prop('checked', $('td:eq(6)', this).text() === 'true');
        $('#admReportDetails_admParam_slNo').val($('td:eq(7)', this).text());
        $('#admReportDetails_admParam_cmd').val($('td:eq(8)', this).text());
        $('#admReportDetails_admParam_defaultVal').val($('td:eq(9)', this).text());
        $('#admReportDetails_admParam_helpText').val($('td:eq(10)', this).text());
    });

    $(document).on('click', '#admReportDetails_create', function () {
        $('#admReportDetails_embdId').val('');
        $('#admReportDetails_admParam_title').val('');
        $('#admReportDetails_admParam_paramName').val('');
        $('#admReportDetails_admParam_widgetType').val('');
        $('#admReportDetails_admParam_isActive').val('');
        $('#admReportDetails_admParam_isMandatory').val('');
        $('#admReportDetails_admParam_slNo').val('');
        $('#admReportDetails_admParam_cmd').val('');
        $('#admReportDetails_admParam_defaultVal').val('');
        $('#admReportDetails_admParam_helpText').val('');
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