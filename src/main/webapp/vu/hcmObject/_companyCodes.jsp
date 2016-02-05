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

<button id='companyCodes_create' type='button' class='btn btn-primary' data-toggle='modal' data-target='#companyCodes_modal'><spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='companyCodes' text='Company Codes'/></button>

<c:if test='${not empty hcmObject.companyCodes}'>
    <div class='table-responsive'>
        <table class='table table-striped table-bordered table-hover table-condensed'>
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code='code' text='Code'/></th>
                    <th><spring:message code='name' text='Name'/></th>
                    <th><spring:message code='company' text='Company'/></th>
                    <th><spring:message code='city' text='City'/></th>
                    <th><spring:message code='country' text='Country'/></th>
                    <th><spring:message code='language' text='Language'/></th>
                    <th><spring:message code='currency' text='Currency'/></th>
                    <th><spring:message code='auditor' text='Auditor'/></th>
                    <th><spring:message code='client' text='Client'/></th>
                    <th><spring:message code='id' text='Id'/></th>
                    <th><spring:message code='version' text='Version'/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items='${hcmObject.companyCodes}' var='companyCodes' varStatus='loopStatus'>
                    <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                        <td><c:out value='${loopStatus.index}'/></td>
                        <td><button id='${hcmObject.id}~${loopStatus.index}' type='button' class='btn btn-info' value='${hcmObject.id}~${loopStatus.index}' data-toggle='modal' data-target='#companyCodes_modal' class='btn btn-primary'><spring:message code='edit.link.label' text='Edit'/></button></td>
                        <td><c:out value='${companyCodes.code}'/></td>
                        <td><c:out value='${companyCodes.name}'/></td>
                        <td><c:out value='${companyCodes.company}'/></td>
                        <td><c:out value='${companyCodes.city}'/></td>
                        <td><c:out value='${companyCodes.country}'/></td>
                        <td><c:out value='${companyCodes.language}'/></td>
                        <td><c:out value='${companyCodes.currency}'/></td>
                        <td><c:out value='${companyCodes.auditor}'/></td>
                        <td><c:out value='${companyCodes.client}'/></td>
                        <td><c:out value='${companyCodes.id}'/></td>
                        <td><c:out value='${companyCodes.version}'/></td>

                        <td><button type='button' class='companyCodes_del btn btn-warning' value='companyCodes~${hcmObject.id}~${loopStatus.index}'><spring:message code='erase.button.label' text='Erase'/></button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class='container'>
    <!-- Modal -->
    <div class='modal fade' id='companyCodes_modal' role='dialog'>
        <div class='modal-dialog'>
            <div class='modal-content'>

                <form:form action='${pageContext.request.contextPath}/hcmObject/companyCodes/edit/${hcmObject.id}' commandName='companyCodes' method='POST' class='form-horizontal'>

                    <!--modal-header-->
                    <div class='modal-header' style='background-color: #5D9CEC'>
                        <div class='form-group'>
                            <h4 class='modal-title col-md-6' style='float: left'>
                                <spring:message code='companyCodes' text='Company Codes'/>
                            </h4>
                            <button type='button' class='close col-md-6' data-dismiss='modal' style='float: right; text-align: right; color: red'>&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class='modal-body'>

                        <input type='hidden' name='hcmObjectId' id='hcmObjectId' value='${hcmObject.id}'>
                        <input type='hidden' name='embdId' id='companyCodes_id' value=''>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='code' text='Code'/>
                                <input type='text' name='code' id='companyCodes_code' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='name' text='Name'/>
                                <input type='text' name='name' id='companyCodes_name' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='company' text='Company'/>
                                <input type='text' name='company' id='companyCodes_company' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='city' text='City'/>
                                <input type='text' name='city' id='companyCodes_city' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='country' text='Country'/>
                                <input type='text' name='country' id='companyCodes_country' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='language' text='Language'/>
                                <input type='text' name='language' id='companyCodes_language' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='currency' text='Currency'/>
                                <input type='text' name='currency' id='companyCodes_currency' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='auditor' text='Auditor'/>
                                <input type='text' name='auditor' id='companyCodes_auditor' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='client' text='Client'/>
                                <input type='text' name='client' id='companyCodes_client' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='id' text='Id'/>
                                <input type='text' name='id' id='companyCodes_id' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='version' text='Version'/>
                                <input type='text' name='version' id='companyCodes_version' class='form-control' value='' >
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
        $('#companyCodes_id').val($('td:eq(0)', this).text());
        $('#companyCodes_code').val($('td:eq(2)', this).text());
        $('#companyCodes_name').val($('td:eq(3)', this).text());
        $('#companyCodes_company').val($('td:eq(4)', this).text());
        $('#companyCodes_city').val($('td:eq(5)', this).text());
        $('#companyCodes_country').val($('td:eq(6)', this).text());
        $('#companyCodes_language').val($('td:eq(7)', this).text());
        $('#companyCodes_currency').val($('td:eq(8)', this).text());
        $('#companyCodes_auditor').val($('td:eq(9)', this).text());
        $('#companyCodes_client').val($('td:eq(10)', this).text());
        $('#companyCodes_id').val($('td:eq(11)', this).text());
        $('#companyCodes_version').val($('td:eq(12)', this).text());

    });

    $(document).on('click', '#companyCodes_create', function () {
        $('#companyCodes_id').val('');
        $('#companyCodes_code').val('');
        $('#companyCodes_name').val('');
        $('#companyCodes_company').val('');
        $('#companyCodes_city').val('');
        $('#companyCodes_country').val('');
        $('#companyCodes_language').val('');
        $('#companyCodes_currency').val('');
        $('#companyCodes_auditor').val('');
        $('#companyCodes_client').val('');
        $('#companyCodes_id').val('');
        $('#companyCodes_version').val('');

    });

    $(document).on('click', '.companyCodes_del', function () {
        var contextPath = '<%=request.getContextPath()%>';
        var action = '/hcmObject/det/del/';
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: 'GET',
            data: '',
            async: false,
            success: function (response) {
                $('#div_companyCodes').load(location.href + ' #div_companyCodes>*', '');
                //alert('Data deleted successfully!');
                setTimeout(function () {
                    alert('Data deleted successfully!');
                }, 200);
            },
            error: function (exception) {
                alert(
                        'Sorry, an error occurred! Please try again later\n' +
                        '(companyCodes/Erase)'
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->