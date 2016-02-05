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

<c:if test='${not empty hcmObject.divisions}'>
    <div class='table-responsive'>
        <table class='table table-striped table-bordered table-hover table-condensed'>
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                    <th><spring:message code='hcmObjectType' text='Hcm Object Type'/></th>
                    <th><spring:message code='code' text='Code'/></th>
                    <th><spring:message code='name' text='Name'/></th>
                    <th><spring:message code='nameSecondary' text='Name Secondary'/></th>
                    <th><spring:message code='interval' text='Interval'/></th>
                    <th><spring:message code='profile' text='Profile'/></th>
                    <th><spring:message code='doj' text='Doj'/></th>
                    <th><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></th>
                    <th><spring:message code='costCenter' text='Cost Center'/></th>
                    <th><spring:message code='orgUnitType' text='Org Unit Type'/></th>
                    <th><spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/></th>
                    <th><spring:message code='storageLocations' text='Storage Locations'/></th>
                    <th><spring:message code='purchasingOrg' text='Purchasing Org'/></th>
                    <th><spring:message code='salesOffice' text='Sales Office'/></th>
                    <th><spring:message code='companyCode' text='Company Code'/></th>
                    <th><spring:message code='currency' text='Currency'/></th>
                    <th><spring:message code='divisions' text='Divisions'/></th>
                    <th><spring:message code='salesOrg' text='Sales Org'/></th>
                    <th><spring:message code='responsibleEmp' text='Responsible Emp'/></th>
                    <th><spring:message code='companyCodes' text='Company Codes'/></th>
                    <th><spring:message code='coa' text='Coa'/></th>
                    <th><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></th>
                    <th><spring:message code='controllingArea' text='Controlling Area'/></th>
                    <th><spring:message code='description' text='Description'/></th>
                    <th><spring:message code='auditor' text='Auditor'/></th>
                    <th><spring:message code='client' text='Client'/></th>
                    <th><spring:message code='id' text='Id'/></th>
                    <th><spring:message code='version' text='Version'/></th>

                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items='${hcmObject.divisions}' var='divisions' varStatus='loopStatus'>
                    <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                        <td><c:out value='${loopStatus.index}'/></td>
                        <td><button id='${hcmObject.id}~${loopStatus.index}' type='button' class='btn btn-info' value='${hcmObject.id}~${loopStatus.index}' data-toggle='modal' data-target='#divisions_modal' class='btn btn-primary'><spring:message code='edit.link.label' text='Edit'/></button></td>
                        <td><c:out value='${divisions.hcmObjectType}'/></td>
                        <td><c:out value='${divisions.code}'/></td>
                        <td><c:out value='${divisions.name}'/></td>
                        <td><c:out value='${divisions.nameSecondary}'/></td>
                        <td><c:out value='${divisions.interval}'/></td>
                        <td><c:out value='${divisions.profile}'/></td>
                        <td><fmt:formatDate value='${divisions.doj}' type='date' pattern='dd/MM/yyyy'/></td>
                        <td><c:out value='${divisions.isHeadOfPosition}'/></td>
                        <td><c:out value='${divisions.costCenter}'/></td>
                        <td><c:out value='${divisions.orgUnitType}'/></td>
                        <td><c:out value='${divisions.orgUnitAccAssignment}'/></td>
                        <td><c:out value='${divisions.storageLocations}'/></td>
                        <td><c:out value='${divisions.purchasingOrg}'/></td>
                        <td><c:out value='${divisions.salesOffice}'/></td>
                        <td><c:out value='${divisions.companyCode}'/></td>
                        <td><c:out value='${divisions.currency}'/></td>
                        <td><c:out value='${divisions.divisions}'/></td>
                        <td><c:out value='${divisions.salesOrg}'/></td>
                        <td><c:out value='${divisions.responsibleEmp}'/></td>
                        <td><c:out value='${divisions.companyCodes}'/></td>
                        <td><c:out value='${divisions.coa}'/></td>
                        <td><c:out value='${divisions.fiscalYearVariant}'/></td>
                        <td><c:out value='${divisions.controllingArea}'/></td>
                        <td><c:out value='${divisions.description}'/></td>
                        <td><c:out value='${divisions.auditor}'/></td>
                        <td><c:out value='${divisions.client}'/></td>
                        <td><c:out value='${divisions.id}'/></td>
                        <td><c:out value='${divisions.version}'/></td>

                        <td><button type='button' class='divisions_del btn btn-warning' value='divisions~${hcmObject.id}~${loopStatus.index}'><spring:message code='erase.button.label' text='Erase'/></button></td>
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

                <form:form action='${pageContext.request.contextPath}/hcmObject/divisions/edit/${hcmObject.id}' commandName='divisions' method='POST' class='form-horizontal'>

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

                        <input type='hidden' name='hcmObjectId' id='hcmObjectId' value='${hcmObject.id}'>
                        <input type='hidden' name='embdId' id='divisions_id' value=''>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='hcmObjectType' text='Hcm Object Type'/>
                                <input type='text' name='hcmObjectType' id='divisions_hcmObjectType' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='code' text='Code'/>
                                <input type='text' name='code' id='divisions_code' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='name' text='Name'/>
                                <input type='text' name='name' id='divisions_name' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='nameSecondary' text='Name Secondary'/>
                                <input type='text' name='nameSecondary' id='divisions_nameSecondary' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='interval' text='Interval'/>
                                <input type='text' name='interval' id='divisions_interval' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='profile' text='Profile'/>
                                <input type='text' name='profile' id='divisions_profile' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='doj' text='Doj'/>
                                <input type='date' name='doj' id='divisions_doj' class='form-control datepicker' value='' maxlength='10'>
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='isHeadOfPosition' text='Is Head Of Position'/>
                                <input type='checkbox' name='isHeadOfPosition' id='divisions_isHeadOfPosition' class='checkbox' value=''>
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='costCenter' text='Cost Center'/>
                                <input type='text' name='costCenter' id='divisions_costCenter' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='orgUnitType' text='Org Unit Type'/>
                                <input type='text' name='orgUnitType' id='divisions_orgUnitType' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/>
                                <input type='text' name='orgUnitAccAssignment' id='divisions_orgUnitAccAssignment' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='storageLocations' text='Storage Locations'/>
                                <input type='text' name='storageLocations' id='divisions_storageLocations' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='purchasingOrg' text='Purchasing Org'/>
                                <input type='text' name='purchasingOrg' id='divisions_purchasingOrg' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='salesOffice' text='Sales Office'/>
                                <input type='text' name='salesOffice' id='divisions_salesOffice' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='companyCode' text='Company Code'/>
                                <input type='text' name='companyCode' id='divisions_companyCode' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='currency' text='Currency'/>
                                <input type='text' name='currency' id='divisions_currency' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='divisions' text='Divisions'/>
                                <input type='text' name='divisions' id='divisions_divisions' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='salesOrg' text='Sales Org'/>
                                <input type='text' name='salesOrg' id='divisions_salesOrg' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='responsibleEmp' text='Responsible Emp'/>
                                <input type='text' name='responsibleEmp' id='divisions_responsibleEmp' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='companyCodes' text='Company Codes'/>
                                <input type='text' name='companyCodes' id='divisions_companyCodes' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='coa' text='Coa'/>
                                <input type='text' name='coa' id='divisions_coa' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/>
                                <input type='text' name='fiscalYearVariant' id='divisions_fiscalYearVariant' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='controllingArea' text='Controlling Area'/>
                                <input type='text' name='controllingArea' id='divisions_controllingArea' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='description' text='Description'/>
                                <input type='text' name='description' id='divisions_description' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='auditor' text='Auditor'/>
                                <input type='text' name='auditor' id='divisions_auditor' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='client' text='Client'/>
                                <input type='text' name='client' id='divisions_client' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='id' text='Id'/>
                                <input type='text' name='id' id='divisions_id' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='version' text='Version'/>
                                <input type='text' name='version' id='divisions_version' class='form-control' value='' >
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
        $('#divisions_id').val($('td:eq(0)', this).text());
        $('#divisions_hcmObjectType').val($('td:eq(2)', this).text());
        $('#divisions_code').val($('td:eq(3)', this).text());
        $('#divisions_name').val($('td:eq(4)', this).text());
        $('#divisions_nameSecondary').val($('td:eq(5)', this).text());
        $('#divisions_interval').val($('td:eq(6)', this).text());
        $('#divisions_profile').val($('td:eq(7)', this).text());
        $('#divisions_doj').val($('td:eq(8)', this).text());
        $('#divisions_isHeadOfPosition').prop('checked', $('td:eq(9)', this).text());
        $('#divisions_costCenter').val($('td:eq(10)', this).text());
        $('#divisions_orgUnitType').val($('td:eq(11)', this).text());
        $('#divisions_orgUnitAccAssignment').val($('td:eq(12)', this).text());
        $('#divisions_storageLocations').val($('td:eq(13)', this).text());
        $('#divisions_purchasingOrg').val($('td:eq(14)', this).text());
        $('#divisions_salesOffice').val($('td:eq(15)', this).text());
        $('#divisions_companyCode').val($('td:eq(16)', this).text());
        $('#divisions_currency').val($('td:eq(17)', this).text());
        $('#divisions_divisions').val($('td:eq(18)', this).text());
        $('#divisions_salesOrg').val($('td:eq(19)', this).text());
        $('#divisions_responsibleEmp').val($('td:eq(20)', this).text());
        $('#divisions_companyCodes').val($('td:eq(21)', this).text());
        $('#divisions_coa').val($('td:eq(22)', this).text());
        $('#divisions_fiscalYearVariant').val($('td:eq(23)', this).text());
        $('#divisions_controllingArea').val($('td:eq(24)', this).text());
        $('#divisions_description').val($('td:eq(25)', this).text());
        $('#divisions_auditor').val($('td:eq(26)', this).text());
        $('#divisions_client').val($('td:eq(27)', this).text());
        $('#divisions_id').val($('td:eq(28)', this).text());
        $('#divisions_version').val($('td:eq(29)', this).text());

    });

    $(document).on('click', '#divisions_create', function () {
        $('#divisions_id').val('');
        $('#divisions_hcmObjectType').val('');
        $('#divisions_code').val('');
        $('#divisions_name').val('');
        $('#divisions_nameSecondary').val('');
        $('#divisions_interval').val('');
        $('#divisions_profile').val('');
        $('#divisions_doj').val('');
        $('#divisions_isHeadOfPosition').prop('checked', false);
        $('#divisions_costCenter').val('');
        $('#divisions_orgUnitType').val('');
        $('#divisions_orgUnitAccAssignment').val('');
        $('#divisions_storageLocations').val('');
        $('#divisions_purchasingOrg').val('');
        $('#divisions_salesOffice').val('');
        $('#divisions_companyCode').val('');
        $('#divisions_currency').val('');
        $('#divisions_divisions').val('');
        $('#divisions_salesOrg').val('');
        $('#divisions_responsibleEmp').val('');
        $('#divisions_companyCodes').val('');
        $('#divisions_coa').val('');
        $('#divisions_fiscalYearVariant').val('');
        $('#divisions_controllingArea').val('');
        $('#divisions_description').val('');
        $('#divisions_auditor').val('');
        $('#divisions_client').val('');
        $('#divisions_id').val('');
        $('#divisions_version').val('');

    });

    $(document).on('click', '.divisions_del', function () {
        var contextPath = '<%=request.getContextPath()%>';
        var action = '/hcmObject/det/del/';
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