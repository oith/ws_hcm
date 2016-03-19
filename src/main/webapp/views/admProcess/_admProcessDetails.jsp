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
                    <th><spring:message code='admParam' text='Adm Param'/></th>
                    <th><spring:message code='zoneType' text='Zone Type'/></th>
                    <th><spring:message code='embdId' text='Embd Id'/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items='${admProcess.admProcessDetails}' var='admProcessDetails' varStatus='loopStatus'>
                    <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                        <td><c:out value='${admProcessDetails.embdId}'/></td>
                        <td><button id='${admProcess.id}~${admProcessDetails.embdId}' type='button' class='btn btn-info' value='${admProcess.id}~${admProcessDetails.embdId}' data-toggle='modal' data-target='#admProcessDetails_modal' class='btn btn-primary'><spring:message code='edit.link.label' text='Edit'/></button></td>
                        <td><c:out value='${admProcessDetails.admParam}'/></td>
                        <td><c:out value='${admProcessDetails.zoneType}'/></td>
                        <td><c:out value='${admProcessDetails.embdId}'/></td>

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
            <div class='modal-content'>

                <form:form action='${pageContext.request.contextPath}/admProcess/admProcessDetails/edit/${admProcess.id}' commandName='admProcessDetails' method='POST' class='form-horizontal'>

                    <!--modal-header-->
                    <div class='modal-header' style='background-color: #5D9CEC'>
                        <div class='form-group'>
                            <h4 class='modal-title col-md-6' style='float: left'>
                                <spring:message code='admProcessDetails' text='Adm Process Details'/>
                            </h4>
                            <button type='button' class='close col-md-6' data-dismiss='modal' style='float: right; text-align: right; color: red'>&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class='modal-body'>

                        <input type='hidden' name='admProcessId' id='admProcessId' value='${admProcess.id}'>
                        <input type='hidden' name='embdId' id='admProcessDetails_id' value=''>
                        <%--                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                                    <spring:message code='admParam' text='Adm Param'/>
                                                    <input type='text' name='admParam' id='admProcessDetails_admParam' class='form-control' value='' >
                                                </div>
                        title;
                        paramName;
                        widgetType;
                        --%>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='admParam' text='Adm Param'/>
                            <input type='text' name='admParam.title' id='admProcessDetails_admParam.title' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='admParam' text='Adm Param'/>
                            <input type='text' name='admParam.paramName' id='admProcessDetails_admParam.paramName' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='admParam' text='Adm Param'/>

                            <select  class='form-control' name='admParam.widgetType' id='admProcessDetails_admParam.widgetType' required='true' >
                                <c:forEach items='${widgetTypes}' var='sss' varStatus='loopStatus'>
                                    <option value='${sss}' >${sss}</option>
                                </c:forEach>
                            </select>


                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='zoneType' text='Zone Type'/>
                            <!--<input type='text' name='zoneType' id='admProcessDetails_zoneType' class='form-control' value='' >-->

                            <select  class='form-control' name='zoneType' id='admProcessDetails_zoneType' required='true' >

                                <c:forEach items='${zoneTypes}' var='sss' varStatus='loopStatus'>
                                    <option value=${sss} >${sss}</option>
                                </c:forEach>
                            </select>

                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                            <spring:message code='embdId' text='Embd Id'/>
                            <input type='text' name='embdId' id='admProcessDetails_embdId' class='form-control' value='' >
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
        $('#admProcessDetails_id').val($('td:eq(0)', this).text());
        $('#admProcessDetails_admParam').val($('td:eq(2)', this).text());
        $('#admProcessDetails_zoneType').val($('td:eq(3)', this).text());
        $('#admProcessDetails_embdId').val($('td:eq(4)', this).text());

    });

    $(document).on('click', '#admProcessDetails_create', function () {
        $('#admProcessDetails_id').val('');
        $('#admProcessDetails_admParam').val('');
        $('#admProcessDetails_zoneType').val('');
        $('#admProcessDetails_embdId').val('');

    });

    $(document).on('click', '.admProcessDetails_del', function () {
        var contextPath = '<%=request.getContextPath()%>';
        var action = '/admProcess/det/del/';
        var data = $(this).val();

        alert('Data deleted id: ' + data);

        $.ajax({
            url: contextPath + action + data,
            type: 'DELETE',
            data: '',
            async: false,
            success: function (response) {
                $('#div_admProcessDetails').load(location.href + ' #div_admProcessDetails>*', '');
                //alert('Data deleted successfully!');
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