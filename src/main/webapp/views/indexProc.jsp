<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
    <head>

        <script>var contextPath = '<%=request.getContextPath()%>'</script>
        <link rel='shortcut icon' type='image/x-icon' href='<%=request.getContextPath()%>/resources/images/favicon.ico'/>

        <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/frameworks/bootstrap-3.3.6/css/bootstrap.min.css'/>
<!--            <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/bootstrap/bootstrap-3.3.6/bootstrap-datetimepicker.min.css'/> -->
        <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/frameworks/font-awesome-4.5.0/css/font-awesome.min.css'/>
        <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/jquery/jquery-datatable-1.10.10/dataTables.bootstrap.min.css'/> 
        <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/jquery/jquery-datatable-1.10.10/jquery.dataTables.min.css'/> 
        <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/oith/oith-1.0.0.css'/> 
        <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/oith/oith-styles-1.0.0.css'/> 
        <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/css/utility/animate-3.5.0.css'/> 
        <link rel='stylesheet' type='text/css' href='<%=request.getContextPath()%>/resources/themes/jquery-ui-1.11.4/Base/jquery-ui.css'/> 

        <script src='<%=request.getContextPath()%>/resources/js/jquery/jquery-1.11.3/jquery-min.js'></script>
        <script src='<%=request.getContextPath()%>/resources/frameworks/bootstrap-3.3.6/js/bootstrap.js'></script>
        <script src='<%=request.getContextPath()%>/resources/js/jquery/jquery-datatable-1.10.10/dataTables.bootstrap.js'></script>
        <script src='<%=request.getContextPath()%>/resources/js/jquery/jquery-datatable-1.10.10/dataTables.jqueryui.js'></script>
        <script src='<%=request.getContextPath()%>/resources/js/jquery/jquery-datatable-1.10.10/jquery.dataTables.js'></script>
        <!--<script src='<%=request.getContextPath()%>/resources/js/bootstrap/bootstrap-datepicker.js'></script>-->
        <script src='<%=request.getContextPath()%>/resources/js/oith/oith-1.0.0.js'></script> 
        <script src='<%=request.getContextPath()%>/resources/themes/jquery-ui-1.11.4/Base/jquery-ui.js'></script>

        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/images/favicon.ico"/>

        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/styles.css"/> 
        <!--<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/menu.css" media="screen"/>--> 
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/jquery-ui.css"/> 
        <!-- BOOTSTRAP CSS -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bootstrap.css"/>
        <!-- BOOTSTRAP JS -->
        <script src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
        <script src="<%=request.getContextPath()%>/resources/js/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/resources/js/jquery-ui-1.10.2.js"></script> 


        <meta name="layout" content="knit_layout">
        <title>Process</title>

    </head>

    <body>
        <div id="create" class="content scaffold-create" role="main">
            <div class="panel panel-info">

                <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
                <form controller="_AdmProc" id="oith" name="oith" action="executeProcess">

                    <fieldset class="fsStyle">

                        <legend class='legendStyle'><h4>Process</h4></legend>

                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label for="processGroupId">
                                    <span>Process Group</span>
                                </label>
                                <%-- <select name="processGroupId" 
                                    id="processGroupId" 
                                    from="${processGroupMap}"
                                    value="${processGroupId}"
                                    optionKey="id"
                                    noSelection="['${null}': 'Select One']"
                                    onchange="getProcess()" 
                                    class="form-control"/>--%>

                                <select name="processGroupId" 
                                        id="processGroupId"
                                        onchange="getProcess()" 
                                        class='form-control'>
                                    <option value="${null}" >Select One</option>
                                    <c:forEach items="${processGroupMap}" var="sss" varStatus="loopStatus">
                                        <option value="${sss}" >${sss}</option>
                                    </c:forEach>
                                </select>

                            </div>
                        </div>

                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label for="processId">
                                    <span>Process Name</span>
                                    <span class="required-indicator">*</span>
                                </label>

                                <select name="processId" 
                                        id="processId"  
                                        required="required"
                                        onchange="getDynamicContent()" 
                                        class='form-control' >
                                    <option value="${null}" >Select One</option>
                                    <c:forEach items="${processMap}" var="sss" varStatus="loopStatus">
                                        <option value="${sss.id}" >${sss}</option>
                                    </c:forEach>
                                </select>

                                <%--  
<select name="processId" 
                                           id="processId" 
                                           from="${processMap}"
                                           value="${processId}"
                                           optionKey="id"
                                           noSelection="['': 'Select One']" 
                                           required="required"
                                           onchange="getDynamicContent()" 
                                           class="form-control"/>--%>



                            </div>
                        </div>

                    </fieldset>

                    <div id="error" class="col-xs-12"></div>

                    <div id="searchContent"></div>

                    <div id="searchButtonContent"></div>

                    <div id="paramsContent"></div>

                    <div id="buttonContent"></div>

                    <div id="fparams" style="display: none" class="fieldcontain"></div>

                    <div id="qparams" style="display: none" class="fieldcontain"></div>

                    <div id="outputMsg" class="outputMsg"></div>

                    <div id="tableContent"></div>

                    <div id="totalRecordDiv"></div>

                    <div id="errMsg"></div>

                </form>

                <div id="LoadingImageLoadProcess" style="display: none;">
                    <g:img dir="images/image_loading.gif"/>
                </div>

            </div>
        </div>
    </div>

    <script type="text/javascript">
        jQuery(document).ready(function () {
            $("#tblAdmProc").dataTable({
                //            paging:true,
                //            info:true,
                //            lengthChange:true
            });
        });

        $(document).on('click', '#checkAll', function () {
            if ($(this).is(':checked')) {
                $('.chkAplc').each(function () {
                    $(this).prop('checked', true);
                });
            } else {
                $('.chkAplc').each(function () {
                    $(this).prop('checked', false);
                });
            }
        });
    </script>

    <script type="text/javascript">

        //       $(document).ready(function () {
        //            $('#searchContent').hide();
        //             $('#searchContent').hide();
        //             $('#searchButtonContent').hide();
        //             $('#paramsContent').hide();
        //             $('#buttonContent').hide();
        //             $('#tableContent').hide();
        //        })

        function hideAjaxLoadingImageProc() {
            $("#LoadingImageSrch").hide();
            $("#LoadingImageLoadProcess").hide();
            $("#LoadingImageExecuteProcess").hide();
        }

        $("input.dte").live('focus', function () {
            var $this = $(this);
            if (!$this.data('datepicker'))
                $this.datepicker({dateFormat: 'dd/mm/yy'});
        });


        function getProcess() {

            hideAjaxLoadingImageProc();
            $("#LoadingImageLoadProcess").show();
            $('#error').empty();
            $('#outputMsg').addClass("highlight");
            $('#searchContent').addClass("highlight");
            $('#searchButtonContent').addClass("highlight");
            $('#paramsContent').addClass("highlight");
            $('#buttonContent').addClass("highlight");
            $('#tableContent').addClass("highlight");
            $('#totalRecordDiv').addClass("highlight");
            $('#errMsg').addClass("highlight");
            $('#outputMsg').empty();
            $('#searchContent').empty();
            $('#searchButtonContent').empty();
            $('#paramsContent').empty();
            $('#buttonContent').empty();
            $('#tableContent').empty();
            $('#totalRecordDiv').empty();
            $('#errMsg').empty();
            $('#qparams').empty();

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/_AdmProc/getProcess/" + $("#processGroupId").val(),
                async: false,
                success: function (data) {
                    hideAjaxLoadingImageProc();
                    $("#processId").empty();
                    $("#processId").append(data);
                },
                error: function (err) {
                    alert("err getProcess: " + err);
                    hideAjaxLoadingImageProc();
                }
            });

        }

        function getDynamicContent() {
            $('#error').empty();
            hideAjaxLoadingImageProc();
            $("#LoadingImageLoadProcess").show();

            $('#outputMsg').addClass("highlight");
            $('#searchContent').addClass("highlight");
            $('#searchButtonContent').addClass("highlight");
            $('#paramsContent').addClass("highlight");
            $('#buttonContent').addClass("highlight");
            $('#tableContent').addClass("highlight");
            $('#totalRecordDiv').addClass("highlight");
            $('#errMsg').addClass("highlight");


            $('#outputMsg').empty();
            $('#searchContent').empty();
            $('#searchButtonContent').empty();
            $('#paramsContent').empty();
            $('#buttonContent').empty();
            $('#tableContent').empty();
            $('#totalRecordDiv').empty();
            $('#errMsg').empty();
            $('#qparams').empty();

            $.ajax({
                type: "GET",
                dataType: 'JSON',
                url: "${pageContext.request.contextPath}/_AdmProc/getDynamicContent/" + $('#processId').val(),
                success: function (d) {
                    //alert(d);
                    hideAjaxLoadingImageProc();
                    $('#searchContent').append(d.searcher.toString());
                    $('#searchContent').addClass("form");

                    $('#searchButtonContent').append(d.searcher_btner.toString());
                    $('#searchButtonContent').addClass("buttons");

                    $('#paramsContent').append(d.paramer.toString());
                    $('#paramsContent').addClass("fieldcontain");

                    $('#buttonContent').append(d.btner.toString());
                    $('#buttonContent').addClass("btn-group btn-group-justified");

                    $('#qparams').append(d.qparams.toString());
                },
                error: function (err) {
                    alert("No Process Is Configured: " + err);
                    hideAjaxLoadingImageProc();
                }
            });
        }

        function getDynamicTable() {
            hideAjaxLoadingImageProc();
            $("#LoadingImageSrch").show();
            var my_cars = {};
            var isReturn = false;

            $('#search').prop('disabled', true);

            $("#searchContent").find('.required').each(function () {

                if (($('#' + $(this).attr("id")).val()) == "") {
                    alert('Enter required field');
                    hideAjaxLoadingImageProc();
                    isReturn = true;
                    return false;
                }
            });

            if (isReturn) {
                return;
            }
            $("#searchContent").find(':input').each(function () {
                my_cars[$(this).attr("id")] = $('#' + $(this).attr("id")).val();
            });

            var strKeyVal = JSON.stringify(my_cars)
            $('#tableContent').empty();
            $('#totalRecordDiv').empty();
            $('#outputMsg').empty();

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/_AdmProc/search",
                data: {
                    strKeyVal: strKeyVal, processId: $('#processId').val()
                },
                success: function (d) {
                    hideAjaxLoadingImageProc();
                    $('#tableContent').append(d.DATA_TABLE.toString());
                    $('#totalRecordDiv').append("<b>Total Records Found: " + d.TOTAL_RECORD.toString() + "</b>");
                    $('#tableContent').attr('class', 'fieldcontain');
                    $('#totalRecordDiv').attr('class', 'fieldcontain');

                    $('#search').prop('disabled', false);
                },
                error: function (err) {
                    alert("No Process: " + err);
                    hideAjaxLoadingImageProc();
                    $('#search').prop('disabled', false);
                }
            });

        }


        //when press the make new Emp.

        function executeProcess(aa) {
            hideAjaxLoadingImageProc();
            $('#PRC2').prop('disabled', true);
            var myParam = {}
            var isReturn = false;
            $('#errMsg').empty();

            if ($(".chkAplc").length != 0 && $(".chkAplc:checked").length == 0) {
                alert("Select at least one.");
                $('#PRC2').prop('disabled', false);
                return;
            }
            var r = confirm("Are you really want to execute the process");
            if (r == true) {
                x = "You pressed OK!";
                $("#LoadingImageExecuteProcess").show();
            } else {
                return;
            }

            $("#paramsContent").find('.required').each(function () {
                if (($('#' + $(this).attr("id")).val()) == "") {
                    alert('Enter required field');
                    hideAjaxLoadingImageProc();
                    isReturn = true;
                    return false;
                }
            });

            if (isReturn) {
                return;
            }

            $("#paramsContent").find(':input').each(function () {
                myParam[$(this).attr("id")] = $('#' + $(this).attr("id")).val();
            });


            var porcTitleMApxLOC = {};

            porcTitleMApxLOC['PROC_BTN_ID'] = aa
            porcTitleMApxLOC['FIXED_PARAM_VAL'] = myParam
            porcTitleMApxLOC['QU_PARAM_VAL'] = $('#qparams').text();

            var spltqparams = $('#qparams').text();//"ID,OITH_ID,MAC_REMARKSX";

            var outSpltqparams = spltqparams.split(',');
            var arrKeyVal = {};

            var i = 1;
            $('.chkAplc').each(function () {
                if (this.checked) {
                    var smy_cars = {};
                    for (var j = 0; j < outSpltqparams.length; j++) {
                        smy_cars[outSpltqparams[j]] = $('#' + outSpltqparams[j] + '' + i).val();
                    }
                    arrKeyVal[i] = smy_cars;
                }
                i++;
            });

            var strKeyVal = JSON.stringify(arrKeyVal);
            var porcTitleMApx = JSON.stringify(porcTitleMApxLOC);

            $("#buttonContent").find('.save').each(function () {
                $('#' + $(this).attr("id")).prop('disabled', true);
            });

            $.ajax({
                type: "POST",
                url: "${request.contextPath}/_AdmProc/executeProcess",
                data: {
                    strKeyVal: strKeyVal, porcTitleMApx: porcTitleMApx, processId: $('#processId').val()
                },
                success: function (d) {
                    hideAjaxLoadingImageProc();
                    $('#outputMsg').empty();
                    $('#outputMsg').append("Process executed on " + new Date() + "<br/>");
                    $('#outputMsg').append("No of Successful Process:  " + d.countsPass.toString() + "<br/>");
                    $('#outputMsg').append("No of Failed Process:  " + d.countsFail.toString() + "<br/>");
                    $('#outputMsg').append(d.procOutLink.toString());
                    $('#errMsg').append(d.errMsg.toString());

                    $('#outputMsg').attr('class', 'fieldcontain');
                    $('#errMsg').attr('class', 'fieldcontain');

                    $("#buttonContent").find('.save').each(function () {
                        $('#' + $(this).attr("id")).prop('disabled', false);
                    });
                    completProcess()
                    $('#PRC2').prop('disabled', false);
                },
                error: function (dd) {

                    alert("error" + dd);
                    hideAjaxLoadingImageProc();
                    $('#PRC2').prop('disabled', falses);
                }
            });
        }


        // Message effect
        function completProcess() {
            $("#outputMsg").effect('slide', null, 100, callback);
            function callback() {
                setTimeout(function () {
                    $("#outputMsg").removeAttr("style").hide().fadeIn("slow");
                }, 1000);
            }
            ;
        }
        ;
    </script>
</body>
</html>