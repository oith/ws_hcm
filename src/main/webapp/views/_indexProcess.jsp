<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri='http://www.springframework.org/tags' prefix='spring'%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/functions' prefix='fn'%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt'%>
<%@ taglib uri='http://www.springframework.org/tags/form' prefix='form'%>

<tiles:insertDefinition name='defaultTemplate'/>

<tiles:putAttribute name='header'>
    <jsp:include page='/template/header.jsp'/>
</tiles:putAttribute>

<script type='text/javascript'>
    $(document).on('click', '#checkAll', function () {
        if ($(this).is(':checked')) {
            $('.checkBoxTouchAll').each(function () {
                $(this).prop('checked', true);
            });
        } else {
            $('.checkBoxTouchAll').each(function () {
                $(this).prop('checked', false);
            });
        }
    });
    function hideAjaxLoadingImageProc() {
        $('#LoadingImageSrch').hide();
        $('#LoadingImageLoadProcess').hide();
        $('#LoadingImageExecuteProcess').hide();
    }

    $('input.dte').live('focus', function () {
        var $this = $(this);
        if (!$this.data('datepicker'))
            $this.datepicker({dateFormat: 'dd/mm/yy'});
    });
    function getProcess() {

        hideAjaxLoadingImageProc();
        $('#LoadingImageLoadProcess').show();
        $('#buttonContent').empty();
        $('#errMsg').empty();
        $('#error').empty();
        $('#fixedParameter').empty();
        $('#fixedParameterHeader').empty();
        $('#outputMsg').empty();
        $('#qparams').empty();
        $('#searchButton').empty();
        $('#searchButtonContent').empty();
        $('#searchContent').empty();
        $('#searchParameterHeader').empty();
        $('#tableContent').empty();
        $('#totalRecordDiv').empty();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/_AdmProcess/getProcess',
            data: {
                module: $('#module').val()
            },
            async: false,
            success: function (data) {

                hideAjaxLoadingImageProc();
                $('#processId').empty();
                $('#processId').append(data);
            },
            error: function (err) {
                alert('err getProcess: ' + err);
                hideAjaxLoadingImageProc();
            }
        });
    }

    function getDynamicContent() {

        hideAjaxLoadingImageProc();
        $('#LoadingImageLoadProcess').show();
        $('#buttonContent').empty();
        $('#errMsg').empty();
        $('#error').empty();
        $('#fixedParameter').empty();
        $('#fixedParameterHeader').empty();
        $('#outputMsg').empty();
        $('#qparams').empty();
        $('#searchButton').empty();
        $('#searchButtonContent').empty();
        $('#searchContent').empty();
        $('#searchParameterHeader').empty();
        $('#tableContent').empty();
        $('#totalRecordDiv').empty();

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/_AdmProcess/getDynamicContent',
            data: {
                processId: $('#processId').val()
            },
            async: false,
            success: function (d) {

                hideAjaxLoadingImageProc();
                if (d.searchContent !== null) {
                    $('#searchParameterHeader').append("<div class='form-group'><h4><spring:message code='search.Parameter' text='Search Parameter'/></h4></div>");
                    $('#searchContent').append(d.searchContent.toString());
                    $('#searchButton').append("<button onclick='getDynamicTable()' class='btn btn-primary' title='Press to Search' type='button' name='search' id='search' ><i class = 'glyphicon glyphicon-search'></i><spring:message code='search.form.submit.label' text='Search'/></button>");
                }

                if (d.fixedParameter !== null) {
                    $('#fixedParameterHeader').append("<div class='form - group'><h4><spring:message code='fixed.Parameter' text='Fixed Parameter'/></h4></div>");
                    $('#fixedParameter').append(d.fixedParameter.toString());
                }

                $('#buttonContent').append(d.btner.toString());
                $('#qparams').append(d.qparams.toString());
            },
            error: function (err) {
                alert('No Process Is Configured: ' + err);
                hideAjaxLoadingImageProc();
            }
        });
    }

    function getDynamicTable() {
        hideAjaxLoadingImageProc();
        $('#LoadingImageSrch').show();
        var my_cars = {};
        $('#searchContent').find(':required').each(function () {
            if ($(this).val() === '') {
                $(this).focus();
                hideAjaxLoadingImageProc();
                return;
            }
        });
        $('#searchContent').find(':input').each(function () {
            my_cars[$(this).attr('id')] = $('#' + $(this).attr('id')).val();
        });
        var strKeyVal = JSON.stringify(my_cars);
        $('#tableContent').empty();
        $('#totalRecordDiv').empty();
        $('#outputMsg').empty();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/_AdmProcess/search',
            data: {
                strKeyVal: strKeyVal,
                processId: $('#processId').val()
            },
            success: function (d) {
                hideAjaxLoadingImageProc();
                $('#tableContent').append(d.DATA_TABLE.toString());
                $('#totalRecordDiv').append('<b>Total Records Found: ' + d.TOTAL_RECORD.toString() + '</b>');
                $('#tableContent').attr('class', 'fieldcontain');
                $('#totalRecordDiv').attr('class', 'fieldcontain');
                $('#search').prop('disabled', false);
            },
            error: function (err) {
                alert('No Process: ' + err);
                hideAjaxLoadingImageProc();
                $('#search').prop('disabled', false);
            }
        });
    }

    function executeProcess(btnId) {
        hideAjaxLoadingImageProc();
        $('#' + btnId).prop('disabled', true);
        var myParam = {};
        var isReturn = false;
        $('#errMsg').empty();
        if ($('.checkBoxTouchAll').length !== 0 && $('.checkBoxTouchAll:checked').length === 0) {
            alert('Select at least one.');
            $('#' + btnId).prop('disabled', false);
            return;
        }
        var r = confirm('Are you really want to execute the process');
        if (r === true) {
            x = 'You pressed OK!';
            $('#LoadingImageExecuteProcess').show();
        } else {
            return;
        }

        $('#fixedParameter').find(':required').each(function () {
            if ($(this).val() === '') {
                alert('Enter required field');
                hideAjaxLoadingImageProc();
                isReturn = true;
                return false;
            }
        });
        if (isReturn) {
            return;
        }

        $('#fixedParameter').find(':input').each(function () {
            myParam[$(this).attr('id')] = $('#' + $(this).attr('id')).val();
        });
        var porcTitleMApxLOC = {};
        porcTitleMApxLOC['PROC_BTN_ID'] = btnId;
        porcTitleMApxLOC['FIXED_PARAM_VAL'] = myParam;
        porcTitleMApxLOC['QU_PARAM_VAL'] = $('#qparams').text();
        var spltqparams = $('#qparams').text(); //'ID,OITH_ID,MAC_REMARKSX';

        var outSpltqparams = spltqparams.split(',');
        var arrKeyVal = {};
        var i = 1;
        $('.checkBoxTouchAll').each(function () {
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
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/_AdmProcess/executeProcess',
            data: {
                strKeyVal: strKeyVal,
                porcTitleMApx: porcTitleMApx,
                processId: $('#processId').val()
            },
            success: function (d) {

                hideAjaxLoadingImageProc();
                $('#outputMsg').empty();
                $('#outputMsg').append('Process executed on ' + new Date() + '<br/>');
                $('#' + btnId).prop('disabled', false);
                $('#outputMsg').append('No of Successful Process:  ' + d.countsPass.toString() + '<br/>');
                $('#outputMsg').append('No of Failed Process:  ' + d.countsFail.toString() + '<br/>');
                $('#outputMsg').append(d.procOutLink.toString());
                $('#errMsg').append(d.errMsg.toString());
                $('#outputMsg').attr('class', 'fieldcontain');
                $('#errMsg').attr('class', 'fieldcontain');
            },
            error: function (dd) {
                alert('error' + dd);
                hideAjaxLoadingImageProc();
                $('#' + btnId).prop('disabled', false);
            }
        });
    }
</script>

<tiles:putAttribute name='menu'>
    <%--<jsp:include page='/template/menu.jsp'/>--%>
</tiles:putAttribute>

<tiles:putAttribute name='body'>

    <title><spring:message code='process' text='Process'/></title>
    <h1><spring:message code='process' text='Process'/></h1>


    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <label for='module'>
                <span><spring:message code='module' text='Module'/></span>
            </label>
            <select name='module' 
                    id='module'
                    onchange='getProcess()' 
                    class='form-control'>
                <option value='${null}'><spring:message code='default.select.null' text='Select One'/></option>
                <c:forEach items='${module}' var='sss' varStatus='loopStatus'>
                    <option value='${sss}' >${sss}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <label for='processId'>
                <span><spring:message code='process' text='Process'/></span>
                <span class='required-indicator'>*</span>
            </label>

            <select name='processId' 
                    id='processId'  
                    required='required'
                    onchange='getDynamicContent()' 
                    class='form-control'>
                <option value='${null}'><spring:message code='default.select.null' text='Select One'/></option>
                <c:forEach items='${processMap}' var='sss' varStatus='loopStatus'>
                    <option value='${sss.id}' >${sss}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div id='error'></div>

    <div id='searchParameterHeader' class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>    
    </div>

    <div id='searchContent'></div>

    <div id='searchButton' class="col-xs-12 col-sm-12 col-md-12 col-lg-12"></div>

    <div id="fixedParameterHeader" class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
    </div>

    <div id='fixedParameter'></div>

    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <form controller='_AdmProcess' id='oith' name='oith' action='executeProcess'>
            <div class='btn-group' id='buttonContent'></div>
        </form>
    </div>

    <div id='fparams' style='display: none' ></div>
    <div id='qparams' style='display: none' ></div>

    <div id='outputMsg' class='outputMsg'></div>

    <div id='tableContent'></div>
    <div id='totalRecordDiv'></div>
    <div id='errMsg'></div>

    <div id='LoadingImageLoadProcess' style='display: none;'>
        <g:img dir='images/image_loading.gif'/>
    </div>

</tiles:putAttribute>  

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp'/>
</tiles:putAttribute>  