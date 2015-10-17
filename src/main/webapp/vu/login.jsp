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

    <div>   
        <a href="${pageContext.request.contextPath}/"><spring:message code="home" text="Home"/></a> |
    </div>
    <h1><spring:message code="login.title" text="Oith Demo Login"/></h1>
    <div>
        <title><spring:message code="login.title" text="Oith Demo Login"/></title>

        <form action="${loginUrl}" method="post">     
            <div>
                <c:if test="${param.error != null}">        
                    <p>
                        Invalid username and password.
                    </p>
                </c:if>
                <c:if test="${param.logout != null}">       
                    <p>
                        You have been logged out.
                    </p>
                </c:if>

                <table>
                    <tr><td><label for="username"><spring:message code="username" text="User ID"/></label></td><td><input id="username" type="text" name="username" /></td></tr>
                    <tr><td><label for="password"><spring:message code="password" text="Password"/></label></td><td><input id="password" type="password" name="password" /></td></tr>
                    <tr><td><input type='checkbox' name='_spring_security_remember_me'/><spring:message code="remember.me.on.this.computer" text="Remember me on this computer."/></td></tr>

                    <tr>
                        <td colspan="1" align="right">
                            <a href="${pageContext.request.contextPath}/index"><spring:message code="home" text="Home"/></a>

                        </td>
                        <td colspan="2" align="right"><input type="submit" value=<spring:message code="login" text="Login"/> /></td>
                    </tr>
                </table>


                <input type="hidden"                        
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
            </div>
        </form>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp" />
</tiles:putAttribute>    




