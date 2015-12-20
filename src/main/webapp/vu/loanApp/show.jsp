<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<tiles:insertDefinition name="defaultTemplate" />

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp" />
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp" />--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.show" text="Show"/></title>

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home"/></a> |
        <a href="${pageContext.request.contextPath}/loanApp/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="loanApp" text="LoanApp"/></a> |
        <a href="${pageContext.request.contextPath}/loanApp/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="loanApp" text="LoanApp"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list">

            <c:if test="${loanApp.emp!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="emp" text="EMP"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="emp">
                        <c:out value="${loanApp.emp}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.appDate!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="appDate" text="APPDATE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="appDate">
                        <c:out value="${loanApp.appDate}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.code!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="code" text="CODE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="code">
                        <c:out value="${loanApp.code}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.remarks!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="remarks" text="REMARKS"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="remarks">
                        <c:out value="${loanApp.remarks}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.approval!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="approval" text="APPROVAL"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="approval">
                        <c:out value="${loanApp.approval}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.appliedAmount!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="appliedAmount" text="APPLIEDAMOUNT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="appliedAmount">
                        <c:out value="${loanApp.appliedAmount}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.sanctionAmount!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="sanctionAmount" text="SANCTIONAMOUNT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="sanctionAmount">
                        <c:out value="${loanApp.sanctionAmount}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.installmentAmount!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="installmentAmount" text="INSTALLMENTAMOUNT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="installmentAmount">
                        <c:out value="${loanApp.installmentAmount}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.interestPct!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="interestPct" text="INTERESTPCT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="interestPct">
                        <c:out value="${loanApp.interestPct}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.remainingAmount!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="remainingAmount" text="REMAININGAMOUNT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="remainingAmount">
                        <c:out value="${loanApp.remainingAmount}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.lastInstallmentAmount!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="lastInstallmentAmount" text="LASTINSTALLMENTAMOUNT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="lastInstallmentAmount">
                        <c:out value="${loanApp.lastInstallmentAmount}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.lastInterestAmount!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="lastInterestAmount" text="LASTINTERESTAMOUNT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="lastInterestAmount">
                        <c:out value="${loanApp.lastInterestAmount}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.lastTouchPayrollPeriod!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="lastTouchPayrollPeriod" text="LASTTOUCHPAYROLLPERIOD"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="lastTouchPayrollPeriod">
                        <c:out value="${loanApp.lastTouchPayrollPeriod}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.sanctionDate!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="sanctionDate" text="SANCTIONDATE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="sanctionDate">
                        <c:out value="${loanApp.sanctionDate}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.loanType!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="loanType" text="LOANTYPE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="loanType">
                        <c:out value="${loanApp.loanType}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.loanStatus!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="loanStatus" text="LOANSTATUS"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="loanStatus">
                        <c:out value="${loanApp.loanStatus}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${loanApp.reasonForLoan!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="reasonForLoan" text="REASONFORLOAN"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="reasonForLoan">
                        <c:out value="${loanApp.reasonForLoan}"/>
                    </span>
                </li>
            </c:if>
          
            <c:set target="audit" property="audit" var="audit" value="${loanApp}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true" />
        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/loanApp/edit/<c:out value="${loanApp.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/loanApp/delete/<c:out value="${loanApp.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    