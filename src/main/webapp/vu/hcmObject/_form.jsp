<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags' %>
<%@ taglib prefix='form' uri='http://www.springframework.org/tags/form' %>
<%--CSS--%>

<form:errors path='*' cssClass='errorblock' element='div' />

<div class='row'>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='hcmObjectType'><spring:message code='hcmObjectType' text='Hcm Object Type'/><span class='required-indicator needed'>*</span></form:label>
            <form:select path='hcmObjectType' class='form-control' name='hcmObjectType' id='hcmObjectType' required='true' >
                <form:options items='${hcmObjectTypes}' ></form:options>
            </form:select>
            <form:errors path='hcmObjectType' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='orgUnitType'><spring:message code='orgUnitType' text='Org Unit Type'/></form:label>
            <form:select path='orgUnitType' class='form-control' name='orgUnitType' id='orgUnitType' >
                <form:options items='${orgUnitTypes}' ></form:options>
            </form:select>
            <form:errors path='orgUnitType' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='adminUnitType'><spring:message code='adminUnitType' text='Admin Unit Type'/></form:label>
            <form:select path='adminUnitType' class='form-control' name='adminUnitType' id='adminUnitType' >
                <form:options items='${adminUnitTypes}' ></form:options>
            </form:select>
            <form:errors path='adminUnitType' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='accountingUnitType'><spring:message code='accountingUnitType' text='Accounting Unit Type'/></form:label>
            <form:select path='accountingUnitType' class='form-control' name='accountingUnitType' id='accountingUnitType' >
                <form:options items='${accountingUnitTypes}' ></form:options>
            </form:select>
            <form:errors path='accountingUnitType' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='address'><spring:message code='address' text='Address'/></form:label>
            <!--{hcmObject.addresss}-->
            <form:errors path='address' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='personnelArea'><spring:message code='personnelArea' text='Personnel Area'/></form:label>
            <form:select path='personnelArea' class='form-control' name='personnelArea' id='personnelArea' >
                <form:options items='${personnelAreas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='personnelArea' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='code'><spring:message code='code' text='Code'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='code' class='form-control' type='text' required='true' maxlength='10'/>
            <form:errors path='code' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='name'><spring:message code='name' text='Name'/><span class='required-indicator needed'>*</span></form:label>
            <form:input path='name' class='form-control' type='text' required='true' maxlength='50'/>
            <form:errors path='name' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='nameSecondary'><spring:message code='nameSecondary' text='Name Secondary'/></form:label>
            <form:input path='nameSecondary' class='form-control' type='text' maxlength='50'/>
            <form:errors path='nameSecondary' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='interval'><spring:message code='interval' text='Interval'/></form:label>
            <!--{hcmObject.intervals}-->
            <form:errors path='interval' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='company'><spring:message code='company' text='Company'/></form:label>
            <form:select path='company' class='form-control' name='company' id='company' >
                <form:options items='${companys}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='company' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='city'><spring:message code='city' text='City'/></form:label>
            <form:input path='city' class='form-control' type='text' maxlength='100'/>
            <form:errors path='city' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='country'><spring:message code='country' text='Country'/></form:label>
            <form:select path='country' class='form-control' name='country' id='country' >
                <form:options items='${countrys}' ></form:options>
            </form:select>
            <form:errors path='country' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='language'><spring:message code='language' text='Language'/></form:label>
            <form:select path='language' class='form-control' name='language' id='language' >
                <form:options items='${languages}' ></form:options>
            </form:select>
            <form:errors path='language' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='currency'><spring:message code='currency' text='Currency'/></form:label>
            <form:select path='currency' class='form-control' name='currency' id='currency' >
                <form:options items='${currencys}' ></form:options>
            </form:select>
            <form:errors path='currency' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='profile'><spring:message code='profile' text='Profile'/></form:label>
            <form:input path='profile.id' type='text'  size='6' maxlength='6'/>${profile.user.fullName}
            <form:errors path='profile' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='doj'><spring:message code='doj' text='Doj'/></form:label>
            <form:input path='doj' class='form-control datepicker' type='date' maxlength='10'/>
            <form:errors path='doj' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='isHeadOfPosition'><spring:message code='isHeadOfPosition' text='Is Head Of Position'/></form:label>
            <form:checkbox path='isHeadOfPosition'/>
            <form:errors path='isHeadOfPosition' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='costCenter'><spring:message code='costCenter' text='Cost Center'/></form:label>
            <form:select path='costCenter.id' class='form-control' name='costCenter' id='costCenter' >
                <form:options items='${costCenters}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='costCenter' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='fmArea'><spring:message code='fmArea' text='Fm Area'/></form:label>
            <form:select path='fmArea.id' class='form-control' name='fmArea' id='fmArea' >
                <form:options items='${fmAreas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='fmArea' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='creditControlArea'><spring:message code='creditControlArea' text='Credit Control Area'/></form:label>
            <form:select path='creditControlArea.id' class='form-control' name='creditControlArea' id='creditControlArea' >
                <form:options items='${creditControlAreas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='creditControlArea' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='responsibleEmployee'><spring:message code='responsibleEmployee' text='Responsible Employee'/></form:label>
            <form:select path='responsibleEmployee.id' class='form-control' name='responsibleEmployee' id='responsibleEmployee' >
                <form:options items='${responsibleEmployees}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='responsibleEmployee' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='creditLimit'><spring:message code='creditLimit' text='Credit Limit'/></form:label>
            <form:input path='creditLimit' class='form-control' type='number' min='0' max='10000000'/>
            <form:errors path='creditLimit' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='purchasingOrg'><spring:message code='purchasingOrg' text='Purchasing Org'/></form:label>
            <form:select path='purchasingOrg.id' class='form-control' name='purchasingOrg' id='purchasingOrg' >
                <form:options items='${purchasingOrgs}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='purchasingOrg' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='salesOffice'><spring:message code='salesOffice' text='Sales Office'/></form:label>
            <form:select path='salesOffice.id' class='form-control' name='salesOffice' id='salesOffice' >
                <form:options items='${salesOffices}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='salesOffice' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='companyCode'><spring:message code='companyCode' text='Company Code'/></form:label>
            <form:select path='companyCode.id' class='form-control' name='companyCode' id='companyCode' >
                <form:options items='${companyCodes}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='companyCode' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='salesOrg'><spring:message code='salesOrg' text='Sales Org'/></form:label>
            <form:select path='salesOrg.id' class='form-control' name='salesOrg' id='salesOrg' >
                <form:options items='${salesOrgs}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='salesOrg' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='plant'><spring:message code='plant' text='Plant'/></form:label>
            <form:select path='plant.id' class='form-control' name='plant' id='plant' >
                <form:options items='${plants}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='plant' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='responsibleEmp'><spring:message code='responsibleEmp' text='Responsible Emp'/></form:label>
            <form:select path='responsibleEmp.id' class='form-control' name='responsibleEmp' id='responsibleEmp' >
                <form:options items='${responsibleEmps}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='responsibleEmp' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='coa'><spring:message code='coa' text='Coa'/></form:label>
            <form:select path='coa.id' class='form-control' name='coa' id='coa' >
                <form:options items='${coas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='coa' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='fiscalYearVariant'><spring:message code='fiscalYearVariant' text='Fiscal Year Variant'/></form:label>
            <form:select path='fiscalYearVariant.id' class='form-control' name='fiscalYearVariant' id='fiscalYearVariant' >
                <form:options items='${fiscalYearVariants}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='fiscalYearVariant' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'>
        <div class='form-group'>
            <form:label path='controllingArea'><spring:message code='controllingArea' text='Controlling Area'/></form:label>
            <form:select path='controllingArea.id' class='form-control' name='controllingArea' id='controllingArea' >
                <form:options items='${controllingAreas}' itemValue='id'></form:options>
            </form:select>
            <form:errors path='controllingArea' cssClass='error' element='div'/>
        </div>
    </div>
    
    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
        <div class='form-group'>
            <form:label path='description'><spring:message code='description' text='Description'/></form:label>
            <form:textarea path='description' class='form-control' type='text' maxlength='500'/>
            <form:errors path='description' cssClass='error' element='div'/>
        </div>
    </div>
    
</div>

<%--JS--%>

<%--[report]--%>