<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri='http://www.springframework.org/tags' prefix='spring'%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/functions' prefix='fn'%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt'%>
<%--<%@ taglib uri='http://www.springframework.org/tags/form' prefix='form'%>--%>
<%@ taglib uri='http://www.springframework.org/security/tags' prefix='sec'%>


<div class="modal fade" id="modalLoginDialog" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header" style="padding:35px 50px;">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4><span class="glyphicon glyphicon-lock"></span>&nbsp;<spring:message code="login.title" text="Oith Demo Login"/></h4>
            </div>
            <div class="modal-body" style="padding:40px 50px;">
                <!--<form action="{loginUrl}" method="post">-->     
                <form action="" method="POST" role="form"> 
                    <!--<form action="{loginUrl}" method="POST" role="form">--> 

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
                    <div class="form-group">
                        <label for="username"><span class="glyphicon glyphicon-user"></span>&nbsp;<spring:message code="username" text="User ID"/></label>
                        <input id="username" name="username" class="form-control" type="text"   placeholder="Enter email"  required="required">
                    </div>
                    <div class="form-group">
                        <label for="password"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;<spring:message code="password" text="Password"/></label>
                        <input id="password" type="password" class="form-control" name="password" placeholder="Enter password" required="required">
                    </div>
                    <div class="checkbox">
                        <label><input type="checkbox" name='_spring_security_remember_me' value="">&nbsp;&nbsp;<spring:message code="remember.me.on.this.computer" text="Remember me on this computer."/></label>
                    </div>

                    <button type='submit' class='btn btn-primary btn-block'><span class="glyphicon glyphicon-log-in"></span>&nbsp;<spring:message code='login' text='Login'/></button>

                    <input type="hidden"                        
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>

                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span>&nbsp;<spring:message code='cancel' text='Cancel'/></button>
                <p>Forgot <a href="#">Password?</a></p>

                <p>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                        <i class="glyphicon glyphicon-eye-open"></i>
                        <spring:message code='needhelp' text="Need help?"/>
                    </a>
                </p>

                <!--                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary">Apple</button>
                                            <button type="button" class="btn btn-primary">Samsung</button>
                                            <button type="button" class="btn btn-primary">Sony</button>
                                        </div>-->
            </div>
        </div>
    </div>
</div> 
