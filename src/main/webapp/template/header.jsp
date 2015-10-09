<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/images/favicon.ico"/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/styles.css"/> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/menu.css" media="screen"/> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/jquery-ui.css"/> 
<!-- BOOTSTRAP CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bootstrap.css"/>
<!-- BOOTSTRAP JS -->
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery-ui-1.10.2.js"></script> 

<head>
    <script type="text/javascript">
                jQuery(document).ready(function () {
        //initMenu();
        //showUserName();
        //showApplicantName();
        });
                function showApplicantName() {
                var controller = "HrIrAplc";
                        var action = "getAplcTitle";
                        $.ajax({
                        type: "POST",
                                url: "{request.contextPath} " / "+controller +" / "+action,
                                dataType: 'JSON',
                                success: function (d) {
                                //                    document.getElementById('showApplicantTitle').innerHTML=d.message
                                document.getElementById('showUserTitle').innerHTML = d.message
                                },
                                error: function (err) {
                                alert("Sorry for Inconvenience, Please Login Again");
                                        //                        window.location.href = 'createLink(controller:'HrIrAplc', action:'logout')}'
                                }
                        });
                }
    </script>

</head>   
<body>   

    <div id="wrapper">
        <div id="wrapper-container">

            <div id="header">

                <!--<div class="top-header">-->
                <div>
                    <img alt="oith_logo_left" align="left" src="<%=request.getContextPath()%>/resources/images/oith_logo_left.png"/>
                    <!--<img alt="oith_logo_right" align="right" style="border:5px double black;" src="<%=request.getContextPath()%>/images/oith_logo_right.png"/>-->
                </div>
                <div id="flags" style="float: right">
                    <a href="?lang=">
                        <img alt="en" title="English" src="<%=request.getContextPath()%>/resources/images/flags/united-kingdom_14x11.png"/>
                    </a>
                    <a href="?lang=bn_BD">
                        <img alt="bn" title="Bangladesh" src="<%=request.getContextPath()%>/resources/images/flags/bangladesh_14x11.png"/>
                    </a>
                    <a href="?lang=it">
                        <img alt="it" title="Italy" src="<%=request.getContextPath()%>/resources/images/flags/italy_14x11.png"/>
                    </a>
                    <a href="?lang=hi_IN">
                        <img alt="hi" title="India" src="<%=request.getContextPath()%>/resources/images/flags/india_14x11.png"/>
                    </a>
                </div>

                <br>

                <div id="user-info-holder" style="float: right">

                    <sec:authorize access="isAuthenticated()">

                        <div>
                            <spring:message code="welcome.label" text="Welcome"/>
                            <a href="${pageContext.request.contextPath}/user/show"><sec:authentication property="principal.displayName" /></a>
                        </div>

                        <div>
                            <sec:authentication var="profileId" property="principal.profileId"/>
                            <c:if test="${profileId==null}">
                                <a href="${pageContext.request.contextPath}/profile/create"><spring:message code="create.profile" text="Create profile"/></a>
                            </c:if>

                            <c:if test="${profileId!=null}">
                                <a href="${pageContext.request.contextPath}/profile/show"><spring:message code="show.profile" text="Show profile"/></a>
                            </c:if>
                        </div>

                        <div>
                            <a href="${pageContext.request.contextPath}/logout" onclick="return confirm('Are you sure to logout?');" ><spring:message code="logout" text="Logout"/></a>
                        </div>
                    </sec:authorize>

                    <sec:authorize access="isAnonymous()">

                        <div>
                            <a href="${pageContext.request.contextPath}/user/create"><spring:message code="make.new.user" text="Make new user"/></a>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/login"><spring:message code="login" text="Log In"/></a>
                        </div>

                    </sec:authorize>
                </div>

            </div>     

