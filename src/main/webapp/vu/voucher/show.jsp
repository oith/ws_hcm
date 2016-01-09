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
        <a href="${pageContext.request.contextPath}/voucher/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="voucher" text="Voucher"/></a> |
        <a href="${pageContext.request.contextPath}/voucher/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="voucher" text="Voucher"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list">

            <c:if test="${voucher.code!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="code" text="Code"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="code">
                        <c:out value="${voucher.code}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.appDate!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="appDate" text="App Date"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="appDate">
                        <c:out value="${voucher.appDate}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.remarks!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="remarks" text="Remarks"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="remarks">
                        <c:out value="${voucher.remarks}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.transDate!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="transDate" text="Trans Date"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="transDate">
                        <c:out value="${voucher.transDate}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.currency!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="currency" text="Currency"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="currency">
                        <c:out value="${voucher.currency}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.periodAcc!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="periodAcc" text="Period Acc"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="periodAcc">
                        <c:out value="${voucher.periodAcc}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.companyCode!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="companyCode" text="Company Code"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="companyCode">
                        <c:out value="${voucher.companyCode}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.chequeInfo!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="chequeInfo" text="Cheque Info"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="chequeInfo">
                        <c:out value="${voucher.chequeInfo}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.narration!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="narration" text="Narration"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="narration">
                        <c:out value="${voucher.narration}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${voucher.isDeleted!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="isDeleted" text="Is Deleted"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="isDeleted">
                        <c:out value="${voucher.isDeleted}"/>
                    </span>
                </li>
            </c:if>

            <c:set target="audit" property="audit" var="audit" value="${voucher}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true" />
        </ol>
        <div><jsp:include page="_voucherDtls.jsp"/></div>

    </div>

    <a href="${pageContext.request.contextPath}/voucher/edit/<c:out value="${voucher.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/voucher/delete/<c:out value="${voucher.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    