<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<tiles:insertDefinition name="defaultTemplate" />

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp" />
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp" />--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.index" text="Index"/></title>

    <script>window.jQuery || document.write('<script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"><\/script>')</script>

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home"/></a> |
        <a href="${pageContext.request.contextPath}/loanApp/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="loanApp" text="LoanApp"/></a>
    </div>

    <h1><spring:message code="list.page.title"/></h1>

    <form:form action="${pageContext.request.contextPath}/loanApp/index" commandName="searchCriteria" method="POST">

        <table>
            <tr>
                <td><form:label path="searchTerm"><spring:message code="label.searchTerm"/>:</form:label></td>
                <td><form:input path="searchTerm" class="form-control" type="text" id="txtSearch" size="20"/></td>
                <td><span class="label label-info"><spring:message code="foundRec" arguments="${searchCriteria.totalRecs}" htmlEscape="false" /></span></td>
                </tr>

                <tr>
                    <td><form:label path="pageSize"><spring:message code="label.pageSize"/>:</form:label></td>
                <td><form:select path="pageSize" class="form-control">
                        <form:option value="5" label="5" />
                        <form:option value="10" label="10" />
                        <form:option value="20" label="20" />
                        <form:option value="50" label="50" />
                        <form:option value="100" label="100" />
                        <form:option value="200" label="200" />
                        <form:option value="500" label="500" />
                        <form:option value="1000" label="1000" />
                        <%--   <form:options items="${pageSize}" />--%>
                    </form:select></td>
            </tr>
            <tr>
                <td><form:label path="page"><spring:message code="label.page"/>:</form:label></td>
                <td><form:select path="page" class="form-control">
                        <%--<form:option value="-1" label="...Select..." />--%>
                        <form:options items="${pages}" />
                    </form:select></td>
            </tr>
        </table>

        <div>
	    <button type="submit" class="btn btn-info">
	         <span class="glyphicon glyphicon-search"></span><spring:message code="search.form.submit.label"/>
	    </button>
        </div>
    </form:form>

    <c:if test="${loanApps.size()!=0}">

        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover table-condensed">

                <thead>
                    <tr>
                        <th></th>
                        <th><spring:message code="auditor" text="Auditor"/></th>
                        <th><spring:message code="emp" text="Emp"/></th>
                        <th><spring:message code="code" text="Code"/></th>
                        <th><spring:message code="appDate" text="App Date"/></th>
                        <th><spring:message code="remarks" text="Remarks"/></th>
                        <th><spring:message code="approval" text="Approval"/></th>
                        <th><spring:message code="appliedAmount" text="Applied Amount"/></th>
                        <th><spring:message code="sanctionAmount" text="Sanction Amount"/></th>
                        <th><spring:message code="installmentAmount" text="Installment Amount"/></th>
                        <th><spring:message code="interestPct" text="Interest Pct"/></th>
                        <th><spring:message code="remainingAmount" text="Remaining Amount"/></th>
                        <th><spring:message code="lastInstallmentAmount" text="Last Installment Amount"/></th>
                        <th><spring:message code="lastInterestAmount" text="Last Interest Amount"/></th>
                        <th><spring:message code="lastTouchPayrollPeriod" text="Last Touch Payroll Period"/></th>
                        <th><spring:message code="sanctionDate" text="Sanction Date"/></th>
                        <th><spring:message code="loanType" text="Loan Type"/></th>
                        <th><spring:message code="loanStatus" text="Loan Status"/></th>
                        <th><spring:message code="reasonForLoan" text="Reason For Loan"/></th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${loanApps}" var="loanApp"  varStatus="loopStatus">

                        <tr class="${loopStatus.index % 2 == 0 ? 'odd' : 'even'}">
                            <td><a href="${pageContext.request.contextPath}/loanApp/show/<c:out value="${loanApp.id}"/>"><spring:message code="show.link.label"/></a></td>
                                <td><c:out value="${loanApp.auditor}"/></td>
                                <td><c:out value="${loanApp.emp}"/></td>
                                <td><c:out value="${loanApp.code}"/></td>
                                <td><fmt:formatDate value="${loanApp.appDate}" type="date" pattern="dd/MM/yyyy"/></td>
                                <td><c:out value="${loanApp.remarks}"/></td>
                                <td><c:out value="${loanApp.approval}"/></td>
                                <td><c:out value="${loanApp.appliedAmount}"/></td>
                                <td><c:out value="${loanApp.sanctionAmount}"/></td>
                                <td><c:out value="${loanApp.installmentAmount}"/></td>
                                <td><c:out value="${loanApp.interestPct}"/></td>
                                <td><c:out value="${loanApp.remainingAmount}"/></td>
                                <td><c:out value="${loanApp.lastInstallmentAmount}"/></td>
                                <td><c:out value="${loanApp.lastInterestAmount}"/></td>
                                <td><c:out value="${loanApp.lastTouchPayrollPeriod}"/></td>
                                <td><fmt:formatDate value="${loanApp.sanctionDate}" type="date" pattern="dd/MM/yyyy"/></td>
                                <td><c:out value="${loanApp.loanType}"/></td>
                                <td><c:out value="${loanApp.loanStatus}"/></td>
                                <td><c:out value="${loanApp.reasonForLoan}"/></td>

                                <%--
                                <td><c:if test="${loanApp.active}"><spring:message code="default.boolean.true" text="YES"/></c:if><c:if test="${!loanApp.active}"><spring:message code="default.boolean.false" text="NO"/></c:if></td>
                                --%>

                            <td><a href="${pageContext.request.contextPath}/loanApp/edit/<c:out value="${loanApp.id}"/>"><spring:message code="edit.link.label"/></a></td>
                            <td><a href="${pageContext.request.contextPath}/loanApp/copy/<c:out value="${loanApp.id}"/>"><spring:message code="copy.link.label"/></a></td>
                            <td><a href="${pageContext.request.contextPath}/loanApp/delete/<c:out value="${loanApp.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <!--<div class="row-fluid">-->
        <!--    <div>
            <util:pagination thispage="${loanApps}"></util:pagination>
        </div>-->
    </c:if>
    <c:if test="${empty loanApps}">
        <p>
            <spring:message code="list.page.label.no.data.found" text="No data found"/>
        </p>
    </c:if>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    
