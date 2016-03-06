<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <body>
        <h1>MAC say: HTTP Status 403 - Login is needed</h1>

        <c:choose>
            <c:when test="${empty username}">
                <h2>You have to login!</h2>
            </c:when>
            <c:otherwise>
                <h2>Username : ${username} <br/>
                    You have to login!</h2>
                </c:otherwise>
            </c:choose>

    </body>
</html>