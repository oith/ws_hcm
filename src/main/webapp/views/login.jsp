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

    <div>   
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
            <i class="glyphicon glyphicon-home"></i>
            <spring:message code="home" text='Home'/>
        </a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
            <i class="glyphicon glyphicon-eye-open"></i>
            <spring:message code='needhelp' text="Need help?"/>
        </a>
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
                    <tr>
                        <td>
                            <label for="username"><spring:message code="username" text="User ID"/></label>
                        </td>
                        <td>
                            <input id="username" class="form-control" type="text" name="username" required="required"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="password"><spring:message code="password" text="Password"/></label>
                        </td>
                        <td>
                            <input id="password" class="form-control" type="password" name="password" required="required"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><input type="checkbox" name='_spring_security_remember_me' value="">&nbsp;&nbsp;<spring:message code="remember.me.on.this.computer" text="Remember me on this computer."/></label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <button class='btn btn-primary' type='submit'><span class="glyphicon glyphicon-log-in"></span> <spring:message code='login' text='Login'/></button>
                        </td>
                    </tr>
                </table>

                <input type="hidden"                        
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
            </div>
           
        </form>

</tiles:putAttribute>  

<tiles:putAttribute name="footer">
    <jsp:include page="/template/footer.jsp"/>
</tiles:putAttribute>    




