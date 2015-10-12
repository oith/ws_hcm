Human Capital Management Workstation
====================================

This is a simple HCM Workstation to support Indian Subcontinent Organization. 


Summary
-------
The project is a Maven archetype for Spring MVC 4 web application.

Generated project characteristics
-------------------------
* Java based conf Spring MVC 4 web application for Servlet 3.0 environment
* Thymeleaf, Bootstrap
* MongoDB (Spring Data Mongo)
* Spring Security 3.2

Test on the browser
-------------------

	http://localhost:9090/oith_ws_hcm

Note: No additional services are required in order to start the application. Mongo DB configuration is in place but it is not used in the code.

Creating a new project in Eclipse
----------------------------------

* Import archetype URI by `Import ... > Projects from Git > Clone URI`
* Install the archetype in local repository with `mvn install`
* Go to `Preferences > Maven > Archetypes` and `Add Local Catalog`
* Select the catalog from file (`archetype-catalog.xml`) 
* Create new Maven project and select the archetype (remember so select `Include snapshot archetypes`)

If you have any troubles with installation in Eclipse, you may want to have a look at this issue: #74

