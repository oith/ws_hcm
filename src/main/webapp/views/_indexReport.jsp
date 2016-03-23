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

    function hideAjaxLoadingImageProc() {
        $('#LoadingImageSrch').hide();
        $('#LoadingImageLoadProcess').hide();
    }

    function getReport() {
        hideAjaxLoadingImageProc();
        $('#LoadingImageLoadProcess').show();
        $('#fixedParameterHeader').empty();
        $('#fixedParameter').empty();
        $('#reportFormat').empty();
        $('#genReport').empty();

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

    function getDynamicContent() {
        $('#error').empty();
        hideAjaxLoadingImageProc();
        $('#LoadingImageLoadProcess').show();
        $('#fixedParameterHeader').empty();
        $('#fixedParameter').empty();
        $('#reportFormat').empty();
        $('#genReport').empty();

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/_AdmReport/getDynamicContent',
            data: {
                reportId: $('#reportId').val()
            },
            async: false,
            success: function (d) {
                hideAjaxLoadingImageProc();

                $('#reportName').val(d.reportName.toString());
                $('#reportFormat').append(d.reportFormat.toString());
                $('#fixedParameterHeader').append('<h4><spring:message code='fixed.Parameter' text='Fixed Parameter'/></h4>');
                $('#fixedParameter').append(d.fixedParameter.toString());
                $('#genReport').append("<button class='btn btn-primary' type='submit'><i class='glyphicon glyphicon-book'></i><spring:message code='report' text='Report'/></button>");
            },
            error: function (err) {
                alert('No Report Is Configured: ' + err);
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

    <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
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

    <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
        <div class='form-group'>
            <label for='reportId'>
                <span><spring:message code='report' text='Report'/></span>
                <span class='required-indicator'>*</span>
            </label>
            <select name='reportId' 
                    id='reportId'  
                    required='required'
                    onchange='getDynamicContent()' 
                    class='form-control' >
                <option value='${null}' ><spring:message code='default.select.null' text='Select One'/></option>
                <c:forEach items='${reportMap}' var='sss' varStatus='loopStatus'>
                    <option value='${sss.id}' >${sss}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <form:form action='${pageContext.request.contextPath}/_AdmReport/indexReport' method='POST'>    

        <input type='hidden' name='reportName' id='reportName' value=''>

        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
            <div class='form-group'>
                <label for='reportFormat'>
                    <span><spring:message code='reportFormat' text='Report Format'/></span>
                    <span class='required-indicator'>*</span>
                </label>
                <select name='reportFormat' 
                        id='reportFormat'  
                        required='required'
                        class='form-control' >
                </select>
            </div>
        </div>

        <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
            <div class='form-group'>
                <div id="fixedParameterHeader"></div>
            </div>
        </div>

        <div id="fixedParameter"></div>

        <div id="genReport" class="col-xs-12 col-sm-12 col-md-12 col-lg-12"></div>
    </form:form>

    <div id='LoadingImageLoadProcess' style='display: none;'>
        <g:img dir='images/image_loading.gif'/>
    </div>

</tiles:putAttribute>  

<tiles:putAttribute name='footer'>
    <jsp:include page='/template/footer.jsp'/>
</tiles:putAttribute>  