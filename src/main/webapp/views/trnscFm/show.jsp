<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<tiles:insertDefinition name="defaultTemplate"/>

<tiles:putAttribute name="header">
    <jsp:include page="/template/header.jsp"/>
</tiles:putAttribute>

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp"/>--%>
</tiles:putAttribute>

<tiles:putAttribute name="body">

    <title><spring:message code="project.title.show" text="Show"/></title>

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home"/></a> |
        <a href="${pageContext.request.contextPath}/trnscFm/index"><spring:message code="list.link.label"/>&NonBreakingSpace;<spring:message code="trnscFm" text="TrnscFm"/></a> |
        <a href="${pageContext.request.contextPath}/trnscFm/create"><spring:message code="create.link.label"/>&NonBreakingSpace;<spring:message code="trnscFm" text="TrnscFm"/></a>
    </div>

    <h1><spring:message code="show.page.title"/></h1>
    <div>
        <form:hidden path="id"/>
        <ol class="property-list">

            <c:if test="${trnscFm.code!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="code" text="CODE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="code">
                        <c:out value="${trnscFm.code}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.transDate!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="transDate" text="TRANSDATE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="transDate">
                        <c:out value="${trnscFm.transDate}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.accountHeadFm!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="accountHeadFm" text="ACCOUNTHEADFM"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="accountHeadFm">
                        <c:out value="${trnscFm.accountHeadFm}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.sign!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="sign" text="SIGN"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="sign">
                        <c:out value="${trnscFm.sign}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.amount!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="amount" text="AMOUNT"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="amount">
                        <c:out value="${trnscFm.amount}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.accountHeadFmOpposite!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="accountHeadFmOpposite" text="ACCOUNTHEADFMOPPOSITE"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="accountHeadFmOpposite">
                        <c:out value="${trnscFm.accountHeadFmOpposite}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.emp!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="emp" text="EMP"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="emp">
                        <c:out value="${trnscFm.emp}"/>
                    </span>
                </li>
            </c:if>

            <c:if test="${trnscFm.narration!=null}">
                <li class="fieldcontain first_item">
                    <span id="title" class="property-label">
                        <spring:message code="narration" text="NARRATION"/>: 
                    </span>
                    <span class="property-value" aria-labelledby="narration">
                        <c:out value="${trnscFm.narration}"/>
                    </span>
                </li>
            </c:if>

            <c:set target="audit" property="audit" var="audit" value="${trnscFm}" scope="request"/>
            <jsp:include page="../_auditShow.jsp" flush="true"/>
        </ol>

    </div>

    <a href="${pageContext.request.contextPath}/trnscFm/edit/<c:out value="${trnscFm.id}"/>"><spring:message code="edit.link.label"/></a> |
    <a href="${pageContext.request.contextPath}/trnscFm/delete/<c:out value="${trnscFm.id}"/>" onclick="return confirm('Are you sure to delete?');" ><spring:message code="delete.link.label"/></a>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp"/>
</tiles:putAttribute>    