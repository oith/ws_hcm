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
        <%--<form:hidden path="id"/>--%>
        <dl class="dl-horizontal">

            <c:if test="${loanApp.emp!=null}">
                <dt><spring:message code="emp" text="Emp"/></dt>
                <dd>
                    <c:if test="${loanApp.emp.profile!=null}">
                    <dt><spring:message code="profile" text="Profile"/></dt>
                    <dd>
                        <c:out value="${loanApp.emp.profile}"/>
                    </dd>
                </c:if>
                <c:if test="${loanApp.emp.doj!=null}">
                    <dt><spring:message code="doj" text="Doj"/></dt>
                    <dd>
                        <fmt:formatDate value="${loanApp.emp.doj}" type="date" pattern="dd/MM/yyyy"/>
                    </dd>
                </c:if>
                <c:if test="${loanApp.emp.doe!=null}">
                    <dt><spring:message code="doe" text="Doe"/></dt>
                    <dd>
                        <fmt:formatDate value="${loanApp.emp.doe}" type="date" pattern="dd/MM/yyyy"/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:if test="${loanApp.code!=null}">
                <dt><spring:message code="code" text="Code"/></dt>
                <dd>
                    <c:out value="${loanApp.code}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.appDate!=null}">
                <dt><spring:message code="appDate" text="App Date"/></dt>
                <dd>
                    <fmt:formatDate value="${loanApp.appDate}" type="date" pattern="dd/MM/yyyy"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.remarks!=null}">
                <dt><spring:message code="remarks" text="Remarks"/></dt>
                <dd>
                    <c:out value="${loanApp.remarks}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.approval!=null}">
                <dt><spring:message code="approval" text="Approval"/></dt>
                <dd>
                    <c:if test="${loanApp.approval.submitDate!=null}">
                    <dt><spring:message code="submitDate" text="Submit Date"/></dt>
                    <dd>
                        <fmt:formatDate value="${loanApp.approval.submitDate}" type="date" pattern="dd/MM/yyyy"/>
                    </dd>
                </c:if>
                <c:if test="${loanApp.approval.originatedBy!=null}">
                    <dt><spring:message code="originatedBy" text="Originated By"/></dt>
                    <dd>
                        <c:out value="${loanApp.approval.originatedBy}"/>
                    </dd>
                </c:if>
                <c:if test="${loanApp.approval.approvedBy!=null}">
                    <dt><spring:message code="approvedBy" text="Approved By"/></dt>
                    <dd>
                        <c:out value="${loanApp.approval.approvedBy}"/>
                    </dd>
                </c:if>
                <c:if test="${loanApp.approval.checkedBy!=null}">
                    <dt><spring:message code="checkedBy" text="Checked By"/></dt>
                    <dd>
                        <c:out value="${loanApp.approval.checkedBy}"/>
                    </dd>
                </c:if>
                <c:if test="${loanApp.approval.recommendBy!=null}">
                    <dt><spring:message code="recommendBy" text="Recommend By"/></dt>
                    <dd>
                        <c:out value="${loanApp.approval.recommendBy}"/>
                    </dd>
                </c:if>
                <c:if test="${loanApp.approval.notifiedTo!=null}">
                    <dt><spring:message code="notifiedTo" text="Notified To"/></dt>
                    <dd>
                        <c:out value="${loanApp.approval.notifiedTo}"/>
                    </dd>
                </c:if>
                <c:if test="${loanApp.approval.submittedBy!=null}">
                    <dt><spring:message code="submittedBy" text="Submitted By"/></dt>
                    <dd>
                        <c:out value="${loanApp.approval.submittedBy}"/>
                    </dd>
                </c:if>

                </dd>
            </c:if>

            <c:if test="${loanApp.appliedAmount!=null}">
                <dt><spring:message code="appliedAmount" text="Applied Amount"/></dt>
                <dd>
                    <c:out value="${loanApp.appliedAmount}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.sanctionAmount!=null}">
                <dt><spring:message code="sanctionAmount" text="Sanction Amount"/></dt>
                <dd>
                    <c:out value="${loanApp.sanctionAmount}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.installmentAmount!=null}">
                <dt><spring:message code="installmentAmount" text="Installment Amount"/></dt>
                <dd>
                    <c:out value="${loanApp.installmentAmount}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.interestPct!=null}">
                <dt><spring:message code="interestPct" text="Interest Pct"/></dt>
                <dd>
                    <c:out value="${loanApp.interestPct}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.remainingAmount!=null}">
                <dt><spring:message code="remainingAmount" text="Remaining Amount"/></dt>
                <dd>
                    <c:out value="${loanApp.remainingAmount}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.lastInstallmentAmount!=null}">
                <dt><spring:message code="lastInstallmentAmount" text="Last Installment Amount"/></dt>
                <dd>
                    <c:out value="${loanApp.lastInstallmentAmount}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.lastInterestAmount!=null}">
                <dt><spring:message code="lastInterestAmount" text="Last Interest Amount"/></dt>
                <dd>
                    <c:out value="${loanApp.lastInterestAmount}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.lastTouchPayrollPeriod!=null}">
                <dt><spring:message code="lastTouchPayrollPeriod" text="Last Touch Payroll Period"/></dt>
                <dd>

                </dd>
            </c:if>

            <c:if test="${loanApp.sanctionDate!=null}">
                <dt><spring:message code="sanctionDate" text="Sanction Date"/></dt>
                <dd>
                    <fmt:formatDate value="${loanApp.sanctionDate}" type="date" pattern="dd/MM/yyyy"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.loanType!=null}">
                <dt><spring:message code="loanType" text="Loan Type"/></dt>
                <dd>
                    <c:out value="${loanApp.loanType}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.loanStatus!=null}">
                <dt><spring:message code="loanStatus" text="Loan Status"/></dt>
                <dd>
                    <c:out value="${loanApp.loanStatus}"/>
                </dd>
            </c:if>

            <c:if test="${loanApp.reasonForLoan!=null}">
                <dt><spring:message code="reasonForLoan" text="Reason For Loan"/></dt>
                <dd>
                    <c:out value="${loanApp.reasonForLoan}"/>
                </dd>
            </c:if>

            <c:set target="audit" property="audit" var="audit" value="${loanApp}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true" />
        </dl>

    </div>

    <a href="${pageContext.request.contextPath}/loanApp/edit/<c:out value="${loanApp.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/loanApp/delete/<c:out value="${loanApp.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    