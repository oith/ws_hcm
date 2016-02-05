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

<button id='storageLocations_create' type='button' class='btn btn-primary' data-toggle='modal' data-target='#storageLocations_modal'><spring:message code='create.link.label'/>&NonBreakingSpace;<spring:message code='storageLocations' text='Storage Locations'/></button>

<c:if test='${not empty hcmObject.storageLocations}'>
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
                <c:forEach items='${hcmObject.storageLocations}' var='storageLocations' varStatus='loopStatus'>
                    <tr class='${loopStatus.index % 2 == 0 ? 'odd' : 'even'}'>
                        <td><c:out value='${loopStatus.index}'/></td>
                        <td><button id='${hcmObject.id}~${loopStatus.index}' type='button' class='btn btn-info' value='${hcmObject.id}~${loopStatus.index}' data-toggle='modal' data-target='#storageLocations_modal' class='btn btn-primary'><spring:message code='edit.link.label' text='Edit'/></button></td>
                        <td><c:out value='${storageLocations.hcmObjectType}'/></td>
                        <td><c:out value='${storageLocations.code}'/></td>
                        <td><c:out value='${storageLocations.name}'/></td>
                        <td><c:out value='${storageLocations.nameSecondary}'/></td>
                        <td><c:out value='${storageLocations.interval}'/></td>
                        <td><c:out value='${storageLocations.profile}'/></td>
                        <td><fmt:formatDate value='${storageLocations.doj}' type='date' pattern='dd/MM/yyyy'/></td>
                        <td><c:out value='${storageLocations.isHeadOfPosition}'/></td>
                        <td><c:out value='${storageLocations.costCenter}'/></td>
                        <td><c:out value='${storageLocations.orgUnitType}'/></td>
                        <td><c:out value='${storageLocations.orgUnitAccAssignment}'/></td>
                        <td><c:out value='${storageLocations.storageLocations}'/></td>
                        <td><c:out value='${storageLocations.purchasingOrg}'/></td>
                        <td><c:out value='${storageLocations.salesOffice}'/></td>
                        <td><c:out value='${storageLocations.companyCode}'/></td>
                        <td><c:out value='${storageLocations.currency}'/></td>
                        <td><c:out value='${storageLocations.divisions}'/></td>
                        <td><c:out value='${storageLocations.salesOrg}'/></td>
                        <td><c:out value='${storageLocations.responsibleEmp}'/></td>
                        <td><c:out value='${storageLocations.companyCodes}'/></td>
                        <td><c:out value='${storageLocations.coa}'/></td>
                        <td><c:out value='${storageLocations.fiscalYearVariant}'/></td>
                        <td><c:out value='${storageLocations.controllingArea}'/></td>
                        <td><c:out value='${storageLocations.description}'/></td>
                        <td><c:out value='${storageLocations.auditor}'/></td>
                        <td><c:out value='${storageLocations.client}'/></td>
                        <td><c:out value='${storageLocations.id}'/></td>
                        <td><c:out value='${storageLocations.version}'/></td>

                        <td><button type='button' class='storageLocations_del btn btn-warning' value='storageLocations~${hcmObject.id}~${loopStatus.index}'><spring:message code='erase.button.label' text='Erase'/></button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<div class='container'>
    <!-- Modal -->
    <div class='modal fade' id='storageLocations_modal' role='dialog'>
        <div class='modal-dialog'>
            <div class='modal-content'>

                <form:form action='${pageContext.request.contextPath}/hcmObject/storageLocations/edit/${hcmObject.id}' commandName='storageLocations' method='POST' class='form-horizontal'>

                    <!--modal-header-->
                    <div class='modal-header' style='background-color: #5D9CEC'>
                        <div class='form-group'>
                            <h4 class='modal-title col-md-6' style='float: left'>
                                <spring:message code='storageLocations' text='Storage Locations'/>
                            </h4>
                            <button type='button' class='close col-md-6' data-dismiss='modal' style='float: right; text-align: right; color: red'>&times;</button>
                        </div>
                    </div>

                    <!--modal-body-->
                    <div class='modal-body'>

                        <input type='hidden' name='hcmObjectId' id='hcmObjectId' value='${hcmObject.id}'>
                        <input type='hidden' name='embdId' id='storageLocations_id' value=''>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='hcmObjectType' text='Hcm Object Type'/>
                                <input type='text' name='hcmObjectType' id='storageLocations_hcmObjectType' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='code' text='Code'/>
                                <input type='text' name='code' id='storageLocations_code' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='name' text='Name'/>
                                <input type='text' name='name' id='storageLocations_name' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='nameSecondary' text='Name Secondary'/>
                                <input type='text' name='nameSecondary' id='storageLocations_nameSecondary' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='interval' text='Interval'/>
                                <input type='text' name='interval' id='storageLocations_interval' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='profile' text='Profile'/>
                                <input type='text' name='profile' id='storageLocations_profile' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='doj' text='Doj'/>
                                <input type='date' name='doj' id='storageLocations_doj' class='form-control datepicker' value='' maxlength='10'>
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='isHeadOfPosition' text='Is Head Of Position'/>
                                <input type='checkbox' name='isHeadOfPosition' id='storageLocations_isHeadOfPosition' class='checkbox' value=''>
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='costCenter' text='Cost Center'/>
                                <input type='text' name='costCenter' id='storageLocations_costCenter' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='orgUnitType' text='Org Unit Type'/>
                                <input type='text' name='orgUnitType' id='storageLocations_orgUnitType' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='orgUnitAccAssignment' text='Org Unit Acc Assignment'/>
                                <input type='text' name='orgUnitAccAssignment' id='storageLocations_orgUnitAccAssignment' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='storageLocations' text='Storage Locations'/>
                                <input type='text' name='storageLocations' id='storageLocations_storageLocations' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='purchasingOrg' text='Purchasing Org'/>
                                <input type='text' name='purchasingOrg' id='storageLocations_purchasingOrg' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='salesOffice' text='Sales Office'/>
                                <input type='text' name='salesOffice' id='storageLocations_salesOffice' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='companyCode' text='Company Code'/>
                                <input type='text' name='companyCode' id='storageLocations_companyCode' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='currency' text='Currency'/>
                                <input type='text' name='currency' id='storageLocations_currency' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='divisions' text='Divisions'/>
                                <input type='text' name='divisions' id='storageLocations_divisions' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='salesOrg' text='Sales Org'/>
                                <input type='text' name='salesOrg' id='storageLocations_salesOrg' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='responsibleEmp' text='Responsible Emp'/>
                                <input type='text' name='responsibleEmp' id='storageLocations_responsibleEmp' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='companyCodes' text='Company Codes'/>
                                <input type='text' name='companyCodes' id='storageLocations_companyCodes' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='coa' text='Coa'/>
                                <input type='text' name='coa' id='storageLocations_coa' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/>
                                <input type='text' name='fiscalYearVariant' id='storageLocations_fiscalYearVariant' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='controllingArea' text='Controlling Area'/>
                                <input type='text' name='controllingArea' id='storageLocations_controllingArea' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='description' text='Description'/>
                                <input type='text' name='description' id='storageLocations_description' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='auditor' text='Auditor'/>
                                <input type='text' name='auditor' id='storageLocations_auditor' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='client' text='Client'/>
                                <input type='text' name='client' id='storageLocations_client' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='id' text='Id'/>
                                <input type='text' name='id' id='storageLocations_id' class='form-control' value='' >
                        </div>
                        <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                                <spring:message code='version' text='Version'/>
                                <input type='text' name='version' id='storageLocations_version' class='form-control' value='' >
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
        $('#storageLocations_id').val($('td:eq(0)', this).text());
        $('#storageLocations_hcmObjectType').val($('td:eq(2)', this).text());
        $('#storageLocations_code').val($('td:eq(3)', this).text());
        $('#storageLocations_name').val($('td:eq(4)', this).text());
        $('#storageLocations_nameSecondary').val($('td:eq(5)', this).text());
        $('#storageLocations_interval').val($('td:eq(6)', this).text());
        $('#storageLocations_profile').val($('td:eq(7)', this).text());
        $('#storageLocations_doj').val($('td:eq(8)', this).text());
        $('#storageLocations_isHeadOfPosition').prop('checked', $('td:eq(9)', this).text());
        $('#storageLocations_costCenter').val($('td:eq(10)', this).text());
        $('#storageLocations_orgUnitType').val($('td:eq(11)', this).text());
        $('#storageLocations_orgUnitAccAssignment').val($('td:eq(12)', this).text());
        $('#storageLocations_storageLocations').val($('td:eq(13)', this).text());
        $('#storageLocations_purchasingOrg').val($('td:eq(14)', this).text());
        $('#storageLocations_salesOffice').val($('td:eq(15)', this).text());
        $('#storageLocations_companyCode').val($('td:eq(16)', this).text());
        $('#storageLocations_currency').val($('td:eq(17)', this).text());
        $('#storageLocations_divisions').val($('td:eq(18)', this).text());
        $('#storageLocations_salesOrg').val($('td:eq(19)', this).text());
        $('#storageLocations_responsibleEmp').val($('td:eq(20)', this).text());
        $('#storageLocations_companyCodes').val($('td:eq(21)', this).text());
        $('#storageLocations_coa').val($('td:eq(22)', this).text());
        $('#storageLocations_fiscalYearVariant').val($('td:eq(23)', this).text());
        $('#storageLocations_controllingArea').val($('td:eq(24)', this).text());
        $('#storageLocations_description').val($('td:eq(25)', this).text());
        $('#storageLocations_auditor').val($('td:eq(26)', this).text());
        $('#storageLocations_client').val($('td:eq(27)', this).text());
        $('#storageLocations_id').val($('td:eq(28)', this).text());
        $('#storageLocations_version').val($('td:eq(29)', this).text());

    });

    $(document).on('click', '#storageLocations_create', function () {
        $('#storageLocations_id').val('');
        $('#storageLocations_hcmObjectType').val('');
        $('#storageLocations_code').val('');
        $('#storageLocations_name').val('');
        $('#storageLocations_nameSecondary').val('');
        $('#storageLocations_interval').val('');
        $('#storageLocations_profile').val('');
        $('#storageLocations_doj').val('');
        $('#storageLocations_isHeadOfPosition').prop('checked', false);
        $('#storageLocations_costCenter').val('');
        $('#storageLocations_orgUnitType').val('');
        $('#storageLocations_orgUnitAccAssignment').val('');
        $('#storageLocations_storageLocations').val('');
        $('#storageLocations_purchasingOrg').val('');
        $('#storageLocations_salesOffice').val('');
        $('#storageLocations_companyCode').val('');
        $('#storageLocations_currency').val('');
        $('#storageLocations_divisions').val('');
        $('#storageLocations_salesOrg').val('');
        $('#storageLocations_responsibleEmp').val('');
        $('#storageLocations_companyCodes').val('');
        $('#storageLocations_coa').val('');
        $('#storageLocations_fiscalYearVariant').val('');
        $('#storageLocations_controllingArea').val('');
        $('#storageLocations_description').val('');
        $('#storageLocations_auditor').val('');
        $('#storageLocations_client').val('');
        $('#storageLocations_id').val('');
        $('#storageLocations_version').val('');

    });

    $(document).on('click', '.storageLocations_del', function () {
        var contextPath = '<%=request.getContextPath()%>';
        var action = '/hcmObject/det/del/';
        var data = $(this).val();

        $.ajax({
            url: contextPath + action + data,
            type: 'GET',
            data: '',
            async: false,
            success: function (response) {
                $('#div_storageLocations').load(location.href + ' #div_storageLocations>*', '');
                //alert('Data deleted successfully!');
                setTimeout(function () {
                    alert('Data deleted successfully!');
                }, 200);
            },
            error: function (exception) {
                alert(
                        'Sorry, an error occurred! Please try again later\n' +
                        '(storageLocations/Erase)'
                        );
            }
        });
    });
</script>
<!--========================================================================================================================================-->