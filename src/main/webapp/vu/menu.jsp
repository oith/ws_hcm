<%@ page contentType='text/html; charset=UTF-8' language='java'%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='sec' uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>

<!--<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/bootstrap/bootstrap-3.3.6/bootstrap.min.css'/>
<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/bootstrap/bootstrap-3.3.6/bootstrap-datetimepicker.min.css'/> 
<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/font/font-awesome-4.4.0/font-awesome.min.css'/>
<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/jquery/jquery-datatable-1.10.10/dataTables.bootstrap.min.css'/> 
<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/jquery/jquery-datatable-1.10.10/jquery.dataTables.min.css'/> 
<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/oith/oith-1.0.0.css'/> 
<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/oith/oith-styles-1.0.0.css'/> 
<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/utility/animate-3.5.0.css'/> 
<link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/themes/jquery-ui-1.11.4/Base/jquery-ui.css'/> 

<script src='<%=request.getContextPath()%>/resources/js/jquery/jquery-1.11.3/jquery-min.js'></script>
<script src='<%=request.getContextPath()%>/resources/js/bootstrap/bootstrap-3.3.6.js'></script>
<script src='<%=request.getContextPath()%>/resources/js/jquery/jquery-datatable-1.10.10/dataTables.bootstrap.js'></script>
<script src='<%=request.getContextPath()%>/resources/js/jquery/jquery-datatable-1.10.10/dataTables.jqueryui.js'></script>
<script src='<%=request.getContextPath()%>/resources/js/jquery/jquery-datatable-1.10.10/jquery.dataTables.js'></script>
<script src='<%=request.getContextPath()%>/resources/js/bootstrap/bootstrap-datepicker.js'></script>
<script src='<%=request.getContextPath()%>/resources/js/oith/oith-1.0.0.js'></script> 
<script src='<%=request.getContextPath()%>/resources/themes/jquery-ui-1.11.4/Base/jquery-ui.js'></script>
-->

<html>
    <body>

        <sec:authorize access='isAuthenticated()'>
            <div class='bs-example header'>
                <nav role='navigation' class='navbar navbar-default navbar-static-top'>
                    <div id='navBar' class='collapse navbar-collapse'>
                        <ul class='nav navbar-nav'>
                            <li class='active'><a
                                    href='${request.contextPath}/dashboard'><spring:message code='home.label' text= 'Home'/></a>
                            </li>
                            <li class='dropdown' id='administration'>
                                <a class='dropdown-toggle' href='#'
                                   data-toggle='dropdown'><spring:message code='administration.label' text= 'Administration'/><b
                                        class='caret'></b>
                                </a>
                                <ul role='menu' class='dropdown-menu'>

                                    <sec:authorize  url='/AdmOgrMst'>
                                        <li><a href='${pageContext.request.contextPath}/admOrgMst/index'
                                               id='admOrgMst'><spring:message code='admOrgMst.label' text= 'Organization'/></a>
                                        </li>
                                    </sec:authorize> 
                                    <sec:authorize url='/AdmLoc'>
                                        <li><a href='${pageContext.request.contextPath}/AdmLoc/index'
                                               id='admLoc'><spring:message code='admLoc.label' text= 'Location'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/AdmStructOrg'>
                                        <li><a href='${pageContext.request.contextPath}/admStructOrg/index'
                                               id='admStructOrg'><spring:message code='admStructOrg.label' text= 'Organization Structure'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/AdmStructDpt'>
                                        <li><a href='${pageContext.request.contextPath}/AdmStructDpt/index'
                                               id='admStructDpt'><spring:message code='admStructDpt.label' text= 'Department Structure'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmStructDiv'>
                                        <li><a href='${pageContext.request.contextPath}/admStructDiv/index'
                                               id='admStructDiv'><spring:message code='admStructDiv.label' text= 'Division Structure'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmBand'>
                                        <li><a href='${pageContext.request.contextPath}/admBand/index'
                                               id='admBand'><spring:message code='admBand.label' text= 'Band'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmJob'>
                                        <li><a href='${pageContext.request.contextPath}/AdmJob/index'
                                               id='admJob'><spring:message code='admJob.label' text= 'Job'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmDesgNgt'>
                                        <li><a href='${pageContext.request.contextPath}/admDesgNgt/index'
                                               id='admDesgNgt'><spring:message code='admDesgNgt.label' text= 'Designation(Non Gazetted)'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmDesgGt'>
                                        <li><a href='${pageContext.request.contextPath}/admDesgGt/index'
                                               id='admDesgGt'><spring:message code='admDesgGt.label' text= 'Designetion(Gazetted)'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/AccCostCenter'>
                                        <li><a href='${pageContext.request.contextPath}/accCostCenter/list'
                                               id='accCostCenter'><spring:message code='accCostCenter.label' text= 'Cost Center'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/AdmPosition'>
                                        <li><a href='${pageContext.request.contextPath}/admPosition/index'
                                               id='admPosition'><spring:message code='admPosition.label' text= 'Position'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/AllCodeDef'>
                                        <li><a href='${pageContext.request.contextPath}/allCodeDef/list'
                                               id='allCodeDef'><spring:message code='allCodeDef.label' text= 'All Code Definition'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AllLoc'>
                                        <li><a href='${pageContext.request.contextPath}/allLoc/list'
                                               id='allLoc'><spring:message code='allLoc.label' text= 'All Location'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/Alkp'>
                                        <li><a href='${pageContext.request.contextPath}/alkp/list'
                                               id='alkp'><spring:message code='alkp.label' text= 'All Lookup'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/hrCrLeaveConf'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrLeaveConf/list'
                                               id='hrCrLeaveConf'><spring:message code='hrCrLeaveConf.label' text= 'Leave Configuration'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrTlLeaveOpening'>
                                        <li><a href='${pageContext.request.contextPath}/hrTlLeaveOpening/list'
                                               id='hrTlLeaveOpening'><spring:message code='hrTlLeaveOpening.label' text= 'Opening Balance (Leave)'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmRls'>
                                        <li><a href='${pageContext.request.contextPath}/admRls/list'
                                               id='admRls'><spring:message code='admRls.label' text= 'RLS Setup'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmRole'>
                                        <li><a href='${pageContext.request.contextPath}/admRole/index'
                                               id='admRole'><spring:message code='admRole.label' text= 'Role'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmUser'>
                                        <li><a href='${pageContext.request.contextPath}/admUser/index'
                                               id='admUser'><spring:message code='admUser.label' text= 'User'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmList'>
                                        <li><a href='${pageContext.request.contextPath}/admList/list'
                                               id='admList'><spring:message code='admList.label' text= 'List/Comma Separated Value'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmProp'>
                                        <li><a href='${pageContext.request.contextPath}/admProp/index'
                                               id='admProp'><spring:message code='admProp.label' text= 'Admin Properties'/></a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>

                            <li class='dropdown' id='coreHCM'>
                                <a href='#' data-toggle='dropdown'
                                   class='dropdown-toggle'><spring:message code='coreHCM.label' text= 'Core HCM'/><b
                                        class='caret'></b></a>
                                <ul role='menu' class='dropdown-menu'>
                                    <sec:authorize url='/HrCrEmp'>
                                        <li><a href='${pageContext.request.contextPath}/HrCrEmp/list'
                                               id='HrCrEmp'><spring:message code='HrCrEmp.label' text= 'Employee Master'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrAssignment'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrAssignment/list'
                                               id='hrCrAssignment'><spring:message code='hrCrAssignment.label' text= 'Assignment'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrEmpOwn'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrEmpOwn/list'
                                               id='hrms_177_06'>Employee Entitlement</a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrEmpLicense'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrEmpLicense/list'
                                               id='hrCrEmpLicense'><spring:message code='hrCrEmpLicense.label' text= 'License'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrPrmtnDmtn'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrPrmtnDmtn/list'
                                               id='hrCrPrmtnDmtn'><spring:message code='hrCrPrmtnDmtn.label' text= 'Increment/Decrement/Promotion/Demotion/Transfer'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrRejoin'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrRejoin/list'
                                               id='hrCrRejoin'><spring:message code='hrCrRejoin.label' text= 'Rejoin/Rehire'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrTlOnTourTrnsc'>
                                        <li><a href='${pageContext.request.contextPath}/hrTlOnTourTrnsc/list'
                                               id='hrTlOnTourTrnsc'><spring:message code='onTourEntry.label' text= 'On Tour Entry'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/_HrTlLeaveTrnsc'>
                                        <li><a href='${pageContext.request.contextPath}/_HrTlLeaveTrnsc/list'
                                               id='_HrTlLeaveTrnsc'><spring:message code='_HrTlLeaveTrnsc.label' text= 'Leave Application'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrFire'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrFire/list'
                                               id='hrCrFire'><spring:message code='hrCrFire.label' text= 'Fire/Terminate'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrResign'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrResign/list'
                                               id='hrCrResign'><spring:message code='hrCrResign.label' text= 'Resign'/></a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>

                            <li class='dropdown' id='payroll'><a href='#' data-toggle='dropdown'
                                                                 class='dropdown-toggle'><spring:message code='payroll.label' text= 'Payroll'/><b
                                        class='caret'></b></a>
                                <ul role='menu' class='dropdown-menu'>

                                    <sec:authorize url='/hrPrlElement'>
                                        <li><a href='${pageContext.request.contextPath}/hrPrlElement/list'
                                               id='hrPrlElement'><spring:message code='hrPrlElement.label' text= 'Payroll Element'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrPrlEmpRsrvd'>
                                        <li><a href='${pageContext.request.contextPath}/hrPrlEmpRsrvd/list'
                                               id='procOutPrlHold'><spring:message code='hrPrlEmpRsrvd.label' text= 'Payroll Hold'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrPrlMst'>
                                        <li><a href='${pageContext.request.contextPath}/hrPrlMst/list'
                                               id='hrPrlMst'><spring:message code='hrPrlMst.label' text= 'Payroll Information'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/hrPrlAdjustment'>
                                        <li><a href='${pageContext.request.contextPath}/hrPrlAdjustment/list'
                                               id='hrPrlAdjustment'><spring:message code='hrPrlAdjustment.label' text= 'Adjustment Pay/Deduct'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrPrlGrpMst'>
                                        <li><a href='${pageContext.request.contextPath}/hrPrlGrpMst/list'
                                               id='hrPrlGrpMst'><spring:message code='hrPrlGrpMst.label' text= 'Pay Group'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrPrlGrdMst'>
                                        <li><a href='${pageContext.request.contextPath}/hrPrlGrdMst/list'
                                               id='hrPrlGrdMst'><spring:message code='hrPrlGrdMst.label' text= 'Labor Code/Time Scale'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrPrlBonus'>
                                        <li><a href='${pageContext.request.contextPath}/hrPrlBonus/list'
                                               id='hrPrlBonus'><spring:message code='hrPrlBonus.label' text= 'Bonus'/></a>
                                        </li>
                                    </sec:authorize>

                                </ul>
                            </li>
                            <li class='dropdown' id='accounts'>
                                <a href='#' data-toggle='dropdown' class='dropdown-toggle'><spring:message code='accounts.label' text= 'Accounts'/><b
                                        class='caret'></b></a>

                                <ul role='menu' class='dropdown-menu'>

                                    <sec:authorize url='/hrCrLoanMst'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrLoanMst/list'
                                               id='hrCrLoanMst'><spring:message code='hrCrLoanMst.label' text= 'Loan Information'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/AccTaxMst'>
                                        <li><a href='${pageContext.request.contextPath}/accTaxMst/list'
                                               id='accTaxMst'><spring:message code='accTaxMst.label' text= 'Tax Information'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AccBank'>
                                        <li><a href='${pageContext.request.contextPath}/accBank/list'
                                               id='accBank'><spring:message code='accBank.label' text= 'Bank'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/accBankAccount'>
                                        <li><a href='${pageContext.request.contextPath}/accBankAccount/list'
                                               id='accBankAccount'><spring:message code='accBankAccount.label' text= 'Bank Account'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrEmpAccnt'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrEmpAccnt/list'
                                               id='hrCrEmpAccnt'><spring:message code='hrCrEmpAccnt.label' text= 'Employee Bank Account'/></a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>


                            <li class='dropdown' id='timeAndLabor'>
                                <a href='#' data-toggle='dropdown'
                                   class='dropdown-toggle'><spring:message code='timeAndLabor.label' text= 'Time and Labor'/><b
                                        class='caret'></b>
                                </a>
                                <ul role='menu' class='dropdown-menu'>
                                    <sec:authorize url='/procOutTlCalMst'>
                                        <li><a href='${pageContext.request.contextPath}/procOutTlCalMst/list'
                                               id='procOutTlCalMst'><spring:message code='procOutTlCalMst.label' text= 'Calendar'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrTlCalHoliday'>
                                        <li><a href='${pageContext.request.contextPath}/hrTlCalHoliday/list'
                                               id='hrTlCalHoliday'><spring:message code='hrTlCalHoliday.label' text= 'General Holiday'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrTlShift'>
                                        <li><a href='${pageContext.request.contextPath}/hrTlShift/index'
                                               id='hrTlShift'><spring:message code='hrTlShift.label' text= 'Shift Information'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrTlRoster'>
                                        <li><a href='${pageContext.request.contextPath}/hrTlRoster/list'
                                               id='hrTlRoster'><spring:message code='hrTlRoster.label' text= 'Roster Setup'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrTlPeriod'>
                                        <li><a href='${pageContext.request.contextPath}/hrTlPeriod/index'
                                               id='hrTlPeriod'><spring:message code='hrTlPeriod.label' text= 'Period'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/ProcOutAttnPrd'>
                                        <li><a href='${pageContext.request.contextPath}/procOutAttnPrd/index'
                                               id='procOutAttnPrd'><spring:message code='procOutAttnPrd.label' text= 'Summary Attendance'/></a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>

                            <li class='dropdown' id='foodService'><a href='#' data-toggle='dropdown'
                                                                     class='dropdown-toggle'><spring:message code='foodService.label' text= 'Food Service'/><b class='caret'></b>
                                </a>
                                <ul role='menu' class='dropdown-menu'>

                                    <sec:authorize url=''>
                                        <li><a href='${pageContext.request.contextPath}/hrCrFoodEmpLk/list'
                                               id='hrCrFoodEmpLk'><spring:message code='hrCrFoodEmpLk.label' text= 'Food Requisition'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrFoodEmpLk'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrFoodEmpLk/list'
                                               id='hrCrFoodEmpLk'><spring:message code='hrCrFoodEmpLk.label' text= 'Employee Food Link'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrFoodCost'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrFoodCost/list'
                                               id='hrCrFoodCost'><spring:message code='hrCrFoodCost.label' text= 'Food Cost'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrCrFoodMess'>
                                        <li><a href='${pageContext.request.contextPath}/hrCrFoodMess/list'
                                               id='hrCrFoodMess'><spring:message code='hrCrFoodMess.label' text= 'Food Mess Information'/></a>
                                        </li>
                                    </sec:authorize>

                                </ul>
                            </li>

                            <li class='dropdown' id='performanceService'><a href='#' data-toggle='dropdown'
                                                                            class='dropdown-toggle'><spring:message code='performanceService.label' text= 'Performance Service'/><b
                                        class='caret'></b></a>
                                <ul role='menu' class='dropdown-menu'>
                                    <sec:authorize url='/hrEvalBrdMst'>
                                        <li><a href='${pageContext.request.contextPath}/hrEvalBrdMst/list'
                                               id='hrEvalBrdMst'><spring:message code='hrEvalBrdMst.label' text= 'Evaluation Board'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrEvalPeriod'>
                                        <li><a href='${pageContext.request.contextPath}/hrEvalPeriod/list'
                                               id='hrEvalPeriod'><spring:message code='hrEvalPeriod.label' text= 'Evaluation Period'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/_HrEvaluation'>
                                        <li><a href='${pageContext.request.contextPath}/c/list'
                                               id='hrEvalPeriod'><spring:message code='_HrEvaluation.label' text= 'Performance Evaluation'/></a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>

                            <li class='dropdown' id='eRecruitmentAdministration'>
                                <a href='#' data-toggle='dropdown'
                                   class='dropdown-toggle'><spring:message code='eRecruitmentAdministration.label' text= 'E-Recruitment Administration'/><b
                                        class='caret'></b></a>
                                <ul role='menu' class='dropdown-menu'>
                                    <sec:authorize url='/hrIrAplc'>
                                        <li><a href='${pageContext.request.contextPath}/hrIrAplc/list'
                                               id='hrIrAplc'><spring:message code='hrIrAplc.label' text= 'Applicant'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrIrJoinApp'>
                                        <li><a href='${pageContext.request.contextPath}/hrIrJoinApp/list'
                                               id='hrIrJoinApp'><spring:message code='hrIrJoinApp.label' text= 'Join Application'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrIrIntvw'>
                                        <li><a href='${pageContext.request.contextPath}/hrIrInterview/list'
                                               id='hrIrInterview'><spring:message code='hrIrInterview.label' text= 'Interview Board'/></a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize url='/hrIrInterviewer'>
                                        <li><a href='${pageContext.request.contextPath}/hrIrInterviewer/list'
                                               id='hrIrInterviewer'><spring:message code='hrIrInterviewer.label' text= 'Interviewer'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/_IrTopSheetEntry'>
                                        <li><a href='${pageContext.request.contextPath}/_IrTopSheetEntry/list'
                                               id='_IrTopSheetEntry'><spring:message code='_IrTopSheetEntry.label' text= 'Top Sheet'/></a>
                                        </li>
                                    </sec:authorize>

                                </ul>
                            </li>

                            <li class='dropdown' id='fundManagement'>
                                <a href='#' data-toggle='dropdown' class='dropdown-toggle'>
                                    <spring:message code='fundManagement.label' text= 'Fund management'/>
                                    <b class='caret'></b>
                                </a>
                                <ul role='menu' class='dropdown-menu'>
                                    <sec:authorize url='/hrFmEntry'>
                                        <li><a href='${pageContext.request.contextPath}/hrFmEntry/list'
                                               id='hrms_204_20'>Entry</a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/hrFmAcc'>
                                        <li><a href='${pageContext.request.contextPath}/hrFmAcc/list'
                                               id='hrms_204_192'>Account</a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>



                            <li class='dropdown' id='approval'>
                                <a href='#' data-toggle='dropdown' class='dropdown-toggle'>
                                    <spring:message code='approval.label' text= 'Approval'/>
                                    <b class='caret'></b>
                                </a>
                                <ul role='menu' class='dropdown-menu'>
                                    <sec:authorize url='/AdmAprvlGrpMst'>
                                        <li><a href='${pageContext.request.contextPath}/AdmAprvlGrpMst/list'
                                               id='hrms_199_0'>Approval Group Information</a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/AdmAprvlHrchyMst'>
                                        <li><a href='${pageContext.request.contextPath}/AdmAprvlHrchyMst/list'
                                               id='hrms_199_01'>Approval Hierarchy Information</a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/ProcOutAprvlQueMst'>
                                        <li><a href='${pageContext.request.contextPath}/ProcOutAprvlQueMst/list'
                                               id='hrms_199_02'>Approval Queue Master</a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/_AprvlSts'>
                                        <li><a href='${pageContext.request.contextPath}/_AprvlSts/list'
                                               id='hrms_199_03'>Approval Status</a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>



                            <li class='dropdown' id='selfService'>
                                <a href='#' data-toggle='dropdown'
                                   class='dropdown-toggle'><spring:message code='selfService.label' text= 'Self Service'/><b class='caret'></b>
                                </a>
                                <ul role='menu' class='dropdown-menu'>

                                    <sec:authorize url='/_AuthenticatorHr'>
                                        <li>
                                            <a href='${pageContext.request.contextPath}/_AuthenticatorHr/list' id='hrms_13_5'>Change Password</a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/_AdmProc'>
                                        <li>
                                            <a href='${pageContext.request.contextPath}/_AdmProc/list' id='hrms_13_30'>Process</a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/_AdmDynRpt'>
                                        <li>
                                            <a href='${pageContext.request.contextPath}/_AdmDynRpt/list' id='hrms_13_40'>Report (Dynamic/HTML)</a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/_AdmRpt'>
                                        <li>
                                            <a href='${pageContext.request.contextPath}/_AdmRpt/list' id='hrms_13_45'>Report (PDF)</a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>

                        </ul>

                        <ul class='nav navbar-nav navbar-right'>
                            <li class='dropdown'>
                                <a href='#' data-toggle='dropdown' id='personalInformation'
                                   class='dropdown-toggle'><spring:message code='personalInformation.label' text= 'Personal Info.'/><b
                                        class='caret'></b></a>

                                <ul role='menu' class='dropdown-menu'>
                                    <sec:authorize url='/Notification'>
                                        <li>
                                            <a href='${pageContext.request.contextPath}/Notification/index'
                                               id='notification'><label
                                                    style='padding-right: 60px'><spring:message code='notification.label' text= 'Notification'/></label><span
                                                    class='badge btn-primary' id='badge'>10</span></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/Profile'>
                                        <li><a href='${pageContext.request.contextPath}/Profile/index'
                                               id='profile'><spring:message code='profile.label' text= 'Profile'/></a></li>
                                        </sec:authorize>
                                        <sec:authorize url='/Settings'>
                                        <li>
                                            <a href='${pageContext.request.contextPath}/settings/index'
                                               id='settings'><spring:message code='settings.label' text= 'Settings'/></a>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize url='/_AuthenticatorHr'>
                                        <li>
                                            <a href='${pageContext.request.contextPath}/_AuthenticatorHr/list'
                                               id='changePassword'><spring:message code='changePassword.label' text= 'Change Password'/></a>
                                        </li>
                                    </sec:authorize>
                                    <li>
                                        <a href='${pageContext.request.contextPath}/logout/index'
                                           id='logout'><spring:message code='logout.label' text= 'Logout'/></a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </sec:authorize>


        <script>
            document.onscroll = function () {
                if ($(window).scrollTop() >= headerHeight + 75) {
                    $('.navbar').removeClass('navbar-static-top').addClass('navbar-fixed-top');
                } else {
                    $('.navbar').removeClass('navbar-fixed-top').addClass('navbar-static-top');
                }
            };
        </script>

    </body>
</html>
