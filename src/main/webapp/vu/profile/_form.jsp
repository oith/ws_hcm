<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link type="text/css" href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet"/>
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.js"></script> 

<script type="text/javascript">
    $(document).ready(function () {
        $("#datepicker_marriageDate").datepicker({dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: '1950:2050'});
    });
</script>

<form:errors path="*" cssClass="errorblock" element="div"/>
<%--<form:hidden path="id"/>--%>

<!--<div class="container">-->   
<fieldset>
<!--    <legend>oiiiithhhh</legend>-->

    <div class="row">     
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="title"><spring:message code="title" text="title"/><span class="required-indicator needed">*</span></form:label>
                <form:select path="title" class="form-control" name="title" id="title" required="true" >
                    <form:options items="${titles}" ></form:options>
                </form:select>
                <form:errors path="title" cssClass="error" element="div"/>
            </div>
        </div>   

        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="firstName"><spring:message code="firstName" text="firstName"/><span class="required-indicator needed">*</span></form:label>
                <form:input path="firstName" class="form-control" type="text" required="true" maxlength="30"/>
                <form:errors path="firstName" cssClass="error" element="div"/>
            </div>
        </div>   
    </div>
    <div class="row">     
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="middleName"><spring:message code="middleName" text="middleName"/></form:label>
                <form:input path="middleName" class="form-control" type="text" maxlength="100"/>
                <form:errors path="middleName" cssClass="error" element="div"/>
            </div>
        </div>   

        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="lastName"><spring:message code="lastName" text="lastName"/></form:label>
                <form:input path="lastName" class="form-control" type="text" maxlength="100"/>
                <form:errors path="lastName" cssClass="error" element="div"/>
            </div>
        </div>   
    </div>
    <div class="row">     
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="nickName"><spring:message code="nickName" text="nickName"/><span class="required-indicator needed">*</span></form:label>
                <form:input path="nickName" class="form-control" type="text" required="true" maxlength="30"/>
                <form:errors path="nickName" cssClass="error" element="div"/>
            </div>
        </div>   

        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="nid"><spring:message code="nid" text="nid"/></form:label>
                <form:input path="nid" class="form-control" type="text" maxlength="20"/>
                <form:errors path="nid" cssClass="error" element="div"/>
            </div>
        </div>   
    </div>

    <div class="row">                   
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="profilePicFile"><spring:message code="profilePicFile" text="profile Pic File"/></form:label>
                <c:url var="macImage" value="/profile/getPhoto/${profile.profilePicFile}"/>
                <img id="imagePreview" height="110px" width="90px" src="${macImage}" alt="${macImage}"/>
                <form:hidden path="profilePicFile"/>
                <input id="profilePicFileOBJ" name="profilePicFileOBJ" type="file" accept="image/*"/>
                <form:errors path="profilePicFile" cssClass="error" element="div"/>
            </div>
        </div>  
    </div>  
    <div class="row">     
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="chestSize"><spring:message code="chestSize" text="chestSize"/></form:label>
                <form:input path="chestSize" class="form-control" type="number"/>
                <form:errors path="chestSize" cssClass="error" element="div"/>
            </div>
        </div>   

        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="height"><spring:message code="height" text="height"/></form:label>
                <form:input path="height" class="form-control" type="number"/>
                <form:errors path="height" cssClass="error" element="div"/>
            </div>
        </div>   
    </div>
    <div class="row">     
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="weight"><spring:message code="weight" text="weight"/></form:label>
                <form:input path="weight" class="form-control" type="number"/>
                <form:errors path="weight" cssClass="error" element="div"/>
            </div>
        </div>   

        <%--<%= ${bloodGroups}[0].toString()=%>--%>
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="bloodGroup"><spring:message code="bloodGroup" text="bloodGroup"/></form:label>
                <form:select path="bloodGroup" class="form-control" name="bloodGroup" id="bloodGroup" >
                    <form:options items="${bloodGroups}" itemLabel="title"></form:options>
                </form:select>
                <form:errors path="bloodGroup" cssClass="error" element="div"/>
            </div>
        </div>   
    </div>
    <div class="row">     
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="maritalSts"><spring:message code="maritalSts" text="maritalSts"/></form:label>
                <form:select path="maritalSts" class="form-control" name="maritalSts" id="maritalSts" >
                    <form:options items="${maritalStss}" ></form:options>
                </form:select>
                <form:errors path="maritalSts" cssClass="error" element="div"/>
            </div>
        </div>   

        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="religion"><spring:message code="religion" text="religion"/></form:label>
                <form:select path="religion" class="form-control" name="religion" id="religion" >
                    <form:options items="${religions}" ></form:options>
                </form:select>
                <form:errors path="religion" cssClass="error" element="div"/>
            </div>
        </div>   
    </div>
    <div class="row">     
        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="marriageDate"><spring:message code="marriageDate" text="marriageDate"/></form:label>
                <form:input path="marriageDate" class="form-control" type="date" id="datepicker_marriageDate" placeholder="DD/MM/YYYY" maxlength="10"/>
                <form:errors path="marriageDate" cssClass="error" element="div"/>
            </div>
        </div>   

        <div class="col-xs-6">
            <div class="form-group">
                <form:label path="noOfChild"><spring:message code="noOfChild" text="noOfChild"/></form:label>
                <form:input path="noOfChild" class="form-control" type="number" min="0" max="100"/>
                <form:errors path="noOfChild" cssClass="error" element="div"/>
            </div>
        </div>   
    </div>

</fieldset> 
<!--</div>-->