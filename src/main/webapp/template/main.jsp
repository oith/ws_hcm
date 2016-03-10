<html>
    <head>
        <link rel="stylesheet" href="/css/style.css" type="text/css"/>
    </head>

    <body>
        <tiles:insertDefinition name="defaultTemplate"/>

        <tiles:putAttribute name="header">
            <jsp:include page="/template/header.jsp"/>
        </tiles:putAttribute>

        <tiles:putAttribute name="menu">
            <%--<jsp:include page="/template/menu.jsp"/>--%>
        </tiles:putAttribute>

        <div class="body">
            <tiles:insertAttribute name="body"/>
        </div>

        <tiles:putAttribute name="footer">
            <jsp:include page="/template/footer.jsp"/>
        </tiles:putAttribute>    
    </body>
</html>