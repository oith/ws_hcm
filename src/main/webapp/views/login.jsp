<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <style>
        .modal-header, h4, .close {
            background-color: #5cb85c;
            color:white !important;
            text-align: center;
            font-size: 30px;
        }
        .modal-footer {
            background-color: #f9f9f9;
        }
    </style>
</head>


<tiles:insertDefinition name="defaultTemplate"/>

<!--<tiles:putAttribute name="header">
    <jspinclude page="/template/header.jsp"/>
</tiles:putAttribute>-->

<tiles:putAttribute name="menu">
    <%--<jsp:include page="/template/menu.jsp"/>--%>
</tiles:putAttribute>

<script>
    $(document).ready(function () {
        $("#myBtn").click(function () {
            $("#myModal").modal();
        });
    });
</script>

<tiles:putAttribute name="body">

    <div class="container">

        <!-- Trigger the modal with a button -->
        <button type="button" class="btn btn-default btn-lg" id="myBtn">Login</button>

        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header" style="padding:35px 50px;">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4><span class="glyphicon glyphicon-lock"></span> Login</h4>
                    </div>
                    <div class="modal-body" style="padding:40px 50px;">
                        <form action="${loginUrl}" method="post" role="form"> 

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
                                <label for="username"><span class="glyphicon glyphicon-user"></span> Username</label>
                                <input type="text" class="form-control" id="username" placeholder="Enter email">
                            </div>
                            <div class="form-group">
                                <label for="password"><span class="glyphicon glyphicon-eye-open"></span> Password</label>
                                <input type="password" class="form-control" id="password" placeholder="Enter password">
                            </div>
                            <div class="checkbox">
                                <label><input type="checkbox" value="" checked>Remember me</label>
                            </div>
                            <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> Login</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
                        <p>Not a member? <a href="#">Sign Up</a></p>
                        <p>Forgot <a href="#">Password?</a></p>
                    </div>
                </div>
            </div>
        </div> 
    </div>

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




