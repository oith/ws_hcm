<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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

<title><spring:message code="project.title" text="OITH Home"/></title>

<tiles:insertDefinition name="defaultTemplate"/>

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp"/>
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp"/>--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <div class="col-xs-6">
        <div class="form-group">
            <spring:message code="reportGroups" text="Report Groups"/>
            <select name="reportGroups" id="reportGroups" class="form-control" >
                <option value="${null}" >--SELECT--</option>
                <c:forEach items="${reportGroups}" var="sss" varStatus="loopStatus">
                    <option value="${sss}" >${sss}</option>
                </c:forEach>
            </select>
        </div>
    </div>   

    <div class="col-xs-6">
        <div class="form-group">
            <spring:message code="reports" text="Report"/><span class="required-indicator needed">*</span>
            <select name="reports" id="reports" class="form-control" required="true" >
                <option value="${null}" >--SELECT--</option>
                <c:forEach items="${reports}" var="sss" varStatus="loopStatus">
                    <option value="${sss}" >${sss}</option>
                </c:forEach>
            </select>
        </div>
    </div>   
    <form:form action="${pageContext.request.contextPath}/oithReportRunner" commandName="lookup" method="POST">
        <%--<jsp:include page="_form.jsp" />--%>
        <div>
            <input class="btn btn-primary" type="submit" value="Report"/>
        </div>
    </form:form>
</tiles:putAttribute>

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp"/>
</tiles:putAttribute>

