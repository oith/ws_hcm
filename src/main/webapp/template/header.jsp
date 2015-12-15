<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<head>
    <script>var contextPath = "<%=request.getContextPath()%>";</script>
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/images/favicon.ico"/>

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/jquery-ui.css"/> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/menu.css" media="screen"/> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/styles.css"/> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/oith.css"/> 

    <script src="<%=request.getContextPath()%>/resources/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/jquery-ui-1.10.2.js"></script> 
    <script src="<%=request.getContextPath()%>/resources/js/oith.js"></script>

    <script type="text/javascript">

                function showApplicantName() {
                var controller = "HrIrAplc";
                        var action = "getAplcTitle";
                        $.ajax({
                        type: "POST",
                                url: "{request.contextPath}" / "+controller +" / "+action,
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
                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication var="params" property="principal.logoPicFile"/>
                        <c:url var="macImage" value='/client/getPhoto/${params}' />
                        <img id="imagePreview" align="left" height="100px" width="300px" src="${macImage}" alt="${macImage}"/>
                    </sec:authorize>

                    <sec:authorize access="isAnonymous()">
                        <img id="imagePreview"  align="left" height="100px" width="300px" src="<%=request.getContextPath()%>/resources/images/oith_logo_left.png" alt="oith_logo_left"/>
                    </sec:authorize>
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
                            <a href="${pageContext.request.contextPath}/user/show"><sec:authentication property="principal.fullName" /></a>
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
                            <sec:authentication var="favorites" property="principal.favorites"/>
                            <sec:authentication var="params" property="principal.params"/>
                            <sec:authentication var="lang" property="principal.lang"/>

                            <%--
favorites ${favorites}<br>
params ${params}<br>
                            --%>

                            <select name="quickAccessx" id="quickAccessx" class="form-control">
                                <option value="${null}" >Get Quick Move</option>
                               
                                
                                <c:forEach items="${favorites}" var="sss" varStatus="loopStatus">
                                    <c:choose >
                                        <c:when test='${sss.menuType.toString().equals("ACTION")}'>
                                            <option value="<%=request.getContextPath()%>${sss.address}" >${sss.menuType} - ${sss.text}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${sss.address}" >${sss.menuType} - ${sss.text}</option>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>
                            </select>
                            <input name="quickAccessUrl" id="quickAccessUrl" class="form-control" type="text" size="3" maxlength="3"/>

                            <sec:authentication var="openInNewPageLoc" property="principal.openInNewPage"/>

                            <input type="checkbox" name="openInNewPage" id="openInNewPage" value="openInNewPage">&nbsp;&nbsp;Open in New Page</input>

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


            <script>

                        jQuery(document).ready(function(){
           

                $('#openInNewPage').prop('checked',${openInNewPageLoc});
//                $('#openInNewPage').prop('checked',${lang});
                });
                        $(document).on('change', '#quickAccessx', function () {

                var isNewWindow = $("#openInNewPage").prop('checked');
                        var quickAccessx = $('#quickAccessx').val();
                        if (isNewWindow == '' || isNewWindow == null) {
                isNewWindow = '_self';
                } else{
                isNewWindow = '_blank';
                }

                if (quickAccessx != null || quickAccessx != "") {
                var urlToGo = $(this).val();
                        window.open(urlToGo, isNewWindow);
                        $('#quickAccessx').prop('selectedIndex', 0);
//                        window.location.href = urlToGo.toString();
                }
                });
                        $('#quickAccessUrl').on('keydown', function(event) {
                if (event.which == 13){
                var isNewWindow = $('#openInNewPage').prop('checked');
                        if (isNewWindow == '' || isNewWindow == null) {
                isNewWindow = '_self';
                } else{
                isNewWindow = '_blank';
                }
                var urlCode = $(this).val();
                        if (urlCode.length == 3){
//                            window.open("http://www.google.com", '_blank');
                goToQuickAccessUrl(urlCode, isNewWindow);
                }
                }
                });
                        function goToQuickAccessUrl(urlCode, isNewWindow){

                        //window.open('http://www.google.com', isNewWindow);
                        //window.open(urlToGo, isNewWindow);

                        $.ajax({
                        url: contextPath + '/menu/' + urlCode,
                                type: "GET",
                                data: "",
                                async: false,
                                success: function (response) {
                                    
                                window.open(contextPath+response, isNewWindow);
                                        $('#quickAccessUrl').val('');
                                },
                                error: function (exception) {
                                alert('Sorry, An Internal Error Occurred...!\n(Error : header.jsp/goToQuickAccessUrl:ln=206)');
                                }
                        });
                        }

            </script>   