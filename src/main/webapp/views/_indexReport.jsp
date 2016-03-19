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
    jQuery(document).ready(function () {
        $('#tblAdmProc').dataTable({
            //            paging:true,
            //            info:true,
            //            lengthChange:true
        });
    });

    function hideAjaxLoadingImageProc() {
        $('#LoadingImageSrch').hide();
        $('#LoadingImageLoadProcess').hide();
        $('#LoadingImageExecuteProcess').hide();
    }

    function getReport() {

        hideAjaxLoadingImageProc();
        $('#LoadingImageLoadProcess').show();
        //       $('#error').empty();
        $('#outputMsg').addClass('highlight');
        $('#searchContent').addClass('highlight');
        $('#searchButtonContent').addClass('highlight');
        $('#paramsContent').addClass('highlight');
        $('#buttonContent').addClass('highlight');
        $('#tableContent').addClass('highlight');
        $('#totalRecordDiv').addClass('highlight');
        $('#errMsg').addClass('highlight');
//        $('#outputMsg').empty();
//        $('#searchContent').empty();
//        $('#searchButtonContent').empty();
//        $('#paramsContent').empty();
//        $('#buttonContent').empty();
//        $('#tableContent').empty();
//        $('#totalRecordDiv').empty();
//        $('#errMsg').empty();
//        $('#qparams').empty();

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/_AdmReport/getReport',
            data: {
                module: $('#module').val()
            },
            async: false,
            success: function (data) {
                hideAjaxLoadingImageProc();
                $('#reportId').empty();
                $('#reportId').append(data);
            },
            error: function (err) {
                alert('err getProcess: ' + err);
                hideAjaxLoadingImageProc();
            }
        });
    }
</script>

<tiles:putAttribute name='menu'>
    <%--<jsp:include page='/template/menu.jsp'/>--%>
</tiles:putAttribute>

<tiles:putAttribute name='body'>

    <title><spring:message code='report' text='Report'/></title>
    <h1><spring:message code='report' text='Report'/></h1>

    <div>
        <div class='row'>

            <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
                <div class='form-group'>
                    <label for='module'>
                        <span><spring:message code='module' text='Module'/></span>
                    </label>
                    <select name='module' 
                            id='module'
                            onchange='getReport()' 
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
                    <label for='reportId'>
                        <span><spring:message code='report' text='Report'/></span>
                        <span class='required-indicator'>*</span>
                    </label>
                    <select name='reportId' 
                            id='reportId'  
                            required='required'

                            class='form-control' >
                        <option value='${null}' ><spring:message code='default.select.null' text='Select One'/></option>
                        <c:forEach items='${reportMap}' var='sss' varStatus='loopStatus'>
                            <option value='${sss.id}' >${sss}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <form:form action='${pageContext.request.contextPath}/_AdmReport/indexReport' method='POST'>
                <div>
                    <button class='btn btn-primary' type='submit'><spring:message code='report' text='Report'/></button>
                </div>
            </form:form>
            
            <div id='LoadingImageLoadProcess' style='display: none;'>
                <g:img dir='images/image_loading.gif'/>
            </div>
        </div>
    </div>


</tiles:putAttribute>  

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp'/>
</tiles:putAttribute>  