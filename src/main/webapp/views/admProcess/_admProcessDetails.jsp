<%@ page contentType='text/html;charset=UTF-8' language='java'%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form'%>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>

<button id='admProcessDetails_create' type='button' class='btn btn-primary' data-toggle='modal' data-target='#admProcessDetails_modal'><spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='admProcessDetails' text='Adm Process Details'/></button>

<c:if test='${not empty admProcess.admProcessDetails}'>
    <div class='table-responsive'>
        <table class='table table-striped table-bordered table-hover table-condensed'>
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code='title' text='Title'/></th>
                    <th><spring:message code='paramName' text='ParamName'/></th>
                    <th><spring:message code='widgetType' text='Widget Type'/></th>
                    <th><spring:message code='isActive' text='Is Active'/></th>
                    <th><spring:message code='isMandatory' text='Is Mandatory'/></th>
                    <th><spring:message code='slNo' text='Sl No'/></th>
                    <th><spring:message code='cmd' text='Cmd'/></th>
                    <th><spring:message code='defaultVal' text='Default Val'/></th>
                    <th><spring:message code='helpText' text='Help Text'/></th>
                    <th><spring:message code='zoneType' text='Zone Type'/></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items='${admProcess.admProcessDetails}' var='admProcessDetails' varStatus='loopStatus'>
                    <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                        <td><c:out value='${admProcessDetails.embdId}'/></td>
                        <td><button id='${admProcess.id}~${admProcessDetails.embdId}' type='button' class='btn btn-info' value='${admProcess.id}~${admProcessDetails.embdId}' data-toggle='modal' data-target='#admProcessDetails_modal' class='btn btn-primary'><spring:message code='edit.link.label' text='Edit'/></button></td>
                        <td><c:out value='${admProcessDetails.admParam.title}'/></td>
                        <td><c:out value='${admProcessDetails.admParam.paramName}'/></td>
                        <td><c:out value='${admProcessDetails.admParam.widgetType}'/></td>
                        <td><c:out value='${admProcessDetails.admParam.isActive}'/></td>
                        <td><c:out value='${admProcessDetails.admParam.isMandatory}'/></td>
                        <td><c:out value='${admProcessDetails.admParam.slNo}'/></td>
                        <td><c:out value='${admProcessDetails.admParam.cmd}'/></td>
                        <td><c:out value='${admProcessDetails.admParam.defaultVal}'/></td>
                        <td><c:out value='${admProcessDetails.admParam.helpText}'/></td>
                        <td><c:out value='${admProcessDetails.zoneType}'/></td>
                        <td><button type='button' class='admProcessDetails_del btn btn-warning' value='admProcessDetails~${admProcess.id}~${admProcessDetails.embdId}'><spring:message code='erase.button.label' text='Erase'/></button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class='container'>
    <!-- Modal -->
    <div class='modal fade' id='admProcessDetails_modal' role='dialog'>
        <div class='modal-dialog'>
            <div class="modal-content">

                <form:form action='${pageContext.request.contextPath}/admProcess/admProcessDetails/edit/${admProcess.id}' commandName='admProcessDetail' method='POST' class='form-horizontal'>

                    <!--modal-header-->
                    <!--<div class='modal-header' style='background-color: #5D9CEC'>-->
                    <div class="modal-header" style="padding:10px 50px;">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4>
                            <i class="glyphicon glyphicon-copy"></i>
                            <spring:message code='admProcessDetails' text='Adm Process Details'/>
                        </h4>
                    </div>

                    <!--modal-body-->
                    <div class='modal-body'>

                        <input type='text' name='embdId' id='admProcessDetails_embdId' value=''>

                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='title' text='Title'/>
                            <input type='text' name='admParam.title' id='admProcessDetails_admParam_title' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='paramName' text='Param Name'/>
                            <input type='text' name='admParam.paramName' id='admProcessDetails_admParam_paramName' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='widgetType' text='Widget Type'/>
                            <select  class='form-control' name='admParam.widgetType' id='admProcessDetails_admParam_widgetType' required='true' >
                                <c:forEach items='${widgetTypes}' var='sss' varStatus='loopStatus'>
                                    <option value=${sss}>${sss}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <div class='checkbox'>
                                <label>
                                    <input id='admProcessDetails_admParam_isActive' name='admParam.isActive' type='checkbox'  value='true'><spring:message code='isActive' text='is Active'/>
                                </label>
                            </div>
                        </div>

                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <div class='checkbox'>
                                <label>
                                    <input id='admProcessDetails_admParam_isMandatory' name='admParam.isMandatory' type='checkbox'  value='true'><spring:message code='isMandatory' text='is Mandatory'/>
                                </label>
                            </div>
                        </div>

                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'><spring:message code='slNo' text='slNo'/><input type='text' name='admParam.slNo' id='admProcessDetails_admParam_slNo' class='form-control' value='' ></div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'><spring:message code='cmd' text='cmd'/><input type='text' name='admParam.cmd' id='admProcessDetails_admParam_cmd' class='form-control' value='' ></div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'><spring:message code='defaultVal' text='defaultVal'/><input type='text' name='admParam.defaultVal' id='admProcessDetails_admParam_defaultVal' class='form-control' value='' ></div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'><spring:message code='helpText' text='helpText'/><input type='text' name='admParam.helpText' id='admProcessDetails_admParam_helpText' class='form-control' value='' ></div>

                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='zoneType' text='Zone Type'/>
                            <select  class='form-control' name='zoneType' id='admProcessDetails_zoneType' required='true' >
                                <c:forEach items='${zoneTypes}' var='sss' varStatus='loopStatus'>
                                    <option value=${sss}>${sss}</option>
                                </c:forEach>
                            </select>
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
        $('#admProcessDetails_embdId').val($('td:eq(0)', this).text());
        $('#admProcessDetails_admParam_title').val($('td:eq(2)', this).text());
        $('#admProcessDetails_admParam_paramName').val($('td:eq(3)', this).text());
        $('#admProcessDetails_admParam_widgetType').val($('td:eq(4)', this).text());
        $('#admProcessDetails_admParam_isActive').prop('checked', $('td:eq(5)', this).text() === 'true');//=  ;
        $('#admProcessDetails_admParam_isMandatory').prop('checked', $('td:eq(6)', this).text() === 'true');
        $('#admProcessDetails_admParam_slNo').val($('td:eq(7)', this).text());
        $('#admProcessDetails_admParam_cmd').val($('td:eq(8)', this).text());
        $('#admProcessDetails_admParam_defaultVal').val($('td:eq(9)', this).text());
        $('#admProcessDetails_admParam_helpText').val($('td:eq(10)', this).text());
        $('#admProcessDetails_zoneType').val($('td:eq(11)', this).text());
    });

    $(document).on('click', '#admProcessDetails_create', function () {
        $('#admProcessDetails_embdId').val('');
        $('#admProcessDetails_admParam_title').val('');
        $('#admProcessDetails_admParam_paramName').val('');
        $('#admProcessDetails_admParam_widgetType').val('');
        $('#admProcessDetails_admParam_isActive').val('');
        $('#admProcessDetails_admParam_isMandatory').val('');
        $('#admProcessDetails_admParam_slNo').val('');
        $('#admProcessDetails_admParam_cmd').val('');
        $('#admProcessDetails_admParam_defaultVal').val('');
        $('#admProcessDetails_admParam_helpText').val('');
        $('#admProcessDetails_zoneType').val('');
    });

    $(document).on('click', '.admProcessDetails_del', function () {
        var contextPath = '<%=request.getContextPath()%>';
        var action = '/admProcess/det/del/';
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: 'DELETE',
            data: '',
            async: false,
            success: function (response) {
                $('#div_admProcessDetails').load(location.href + ' #div_admProcessDetails>*', '');
                setTimeout(function () {
                    alert('Data deleted successfully!');
                }, 200);
            },
            error: function (exception) {
                alert(
                        'Sorry, an error occurred! Please try again later\n' +
                        '(admProcessDetails/Erase)'
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->