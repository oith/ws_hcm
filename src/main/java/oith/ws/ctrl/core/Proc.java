package oith.ws.ctrl.core;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.util.JSON;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import oith.ws.dom.core.AdmProcess;
import oith.ws.dom.core.AdmProcessDetail;
import oith.ws.dom.core.AdmReport;
import oith.ws.dom.core.AdmReportDetail;
import oith.ws.dom.core.AllEnum.WidgetType;
import oith.ws.dom.core.AllEnum.ZoneType;
import oith.ws.service.AdmProcessService;
import oith.ws.service.AdmReportService;
import oith.ws.service.MacUserDetail;
import org.bson.types.ObjectId;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.security.core.context.SecurityContextHolder;

public class Proc {

    private static final String SELECTED = "SELECTED";
    private final DB dbS;

    public Proc() {
        MongoClient mongo = new MongoClient("localhost", 27017);
        //mongo.setWriteConcern(WriteConcern.JOURNALED);
        dbS = mongo.getDB("demodb");
    }

    public List<Map> getListFromDB(final String json, final String client) {

        //"{'collection':'Lookup', 'query':{'name':'mkyong', 'age':30}, 'project':{'ID':'id', 'SHOW':'name'}}"
        DBObject dbObject = (DBObject) JSON.parse(json);

        DBObject query = (DBObject) dbObject.get("query");
        query.put("client", new BasicDBObject("$ref", "Client").append("$id", new ObjectId(client)));
//        query.put("client", new BasicDBObject("$ref", "Client").append("$id", new ObjectId("56e3b579261975783753b036")));

        String collection = (String) dbObject.get("collection");
        DBObject project = (DBObject) dbObject.get("project");

        List<Map> list = null;
        try {

            DBCursor jjkk = dbS.getCollection(collection).find(query);
            list = new ArrayList();
            while (jjkk.hasNext()) {

                DBObject colx = jjkk.next();

                Map mm = new HashMap();

                Object k = colx.get((String) project.get("ID"));
                mm.put("id", k);

                Object s = colx.get((String) project.get("SHOW"));
                mm.put("show", s);
                list.add(mm);
            }
            jjkk.close();

        } catch (Exception e) {
        }
        return list;
    }

    public String getSingleValFromDBx(final String coll) {

        String outCol = "";
        String key = "";
        String val = "";

        DBObject dopp = dbS.getCollection(coll).findOne(new BasicDBObject(key, val));

        if (dopp != null) {
            Object kkk = dopp.get(outCol);
            return kkk.toString();
        } else {
            return null;
        }
    }

    public Map<String, String> getReportPageMap(final String reportId, final AdmReportService admReportService) {

        Map<String, String> objMap = new HashMap();

        //String query = "SELECT  COALESCE(A.DEFAULT_VAL,P.DEFAULT_VAL), UPPER(TRIM (COALESCE(A.WIDGET_IDENTITY,P.PARAM_NAME))) FROM ADM_PROC_DTL A,  ADM_PARAM P WHERE ADM_PROC_MST_ID = " + processId + " AND A.ADM_PARAM_ID =P.ID AND ADM_PARAM_ID IS NOT NULL AND A.IS_ACTIVE = 1 AND ZONE_TYPE = '" + ZoneType.SEARCH.toString() + "'  ORDER BY SL_NO ";
        //String query = "SELECT DEFAULT_VAL, WIDGET_IDENTITY FROM CALL_VU_ADM_PROC_DTL WHERE ADM_PROC_MST_ID = " + processId + " AND IS_ACTIVE = 1 AND ZONE_TYPE = '" + ZoneType.SEARCH + "' ORDER BY SL_NO";
        AdmReport admReport = null;
        try {
            admReport = admReportService.findById(reportId);
        } catch (Exception e) {
            System.out.println("err 849: " + e);
        }

        if (admReport == null) {
            return objMap;
        }

        //ResultSet resultSet = statement.executeQuery("SELECT WIDGET_IDENTITY, WIDGET_TYPE  FROM CALL_VU_ADM_PROC_DTL WHERE ADM_PROC_MST_ID = " + processId + " AND IS_ACTIVE = 1 AND UPPER (TRIM (ZONE_TYPE))='PARAM_QU'  ORDER BY SL_NO");
        for (AdmReportDetail admProcDtl : admReport.getAdmReportDetails()) {

            String defaultValue = admProcDtl.getAdmParam().getDefaultVal();
            String widgetIdentity = admProcDtl.getAdmParam().getParamName();

            if (defaultValue != null && !(defaultValue = defaultValue.trim()).isEmpty()) {
                if (defaultValue.startsWith("{") && defaultValue.endsWith("}")) {
                    defaultValue = getSingleValFromDBx(defaultValue.trim());
                }
            }
            objMap.put(widgetIdentity, defaultValue);
        }

        decoReportPageMap(admReport, objMap);

        StringBuilder sb = new StringBuilder();
        for (AdmReport.ReportFormat bbb : admReport.getSupportFormats()) {
            sb.append("<option value='").append(bbb).append("'>").append(bbb).append("</option>");
        }
        objMap.put("reportFormat", sb.toString());
        objMap.put("reportName", admReport.getFileName());

        return objMap;
    }

    private void decoReportPageMap(final AdmReport statement, final Map<String, String> mapper) {

        String client = null;
        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (authUserObj instanceof MacUserDetail) {
            client = ((MacUserDetail) authUserObj).getClientId();
        }

        String fixedParameter = "";
        String fparams = "";

        for (AdmReportDetail resultSet : statement.getAdmReportDetails()) {

            Boolean isMandatory = resultSet.getAdmParam().getIsMandatory();
            String widgetLabel = resultSet.getAdmParam().getTitle();
            String helpText = resultSet.getAdmParam().getHelpText();
            String defaultValue = resultSet.getAdmParam().getDefaultVal();
            WidgetType widgetType = resultSet.getAdmParam().getWidgetType();
            String det_cmd = resultSet.getAdmParam().getCmd();
            String widgetIdentity = resultSet.getAdmParam().getParamName();
            String reqIndication = "";
            String req = "";
            String reqlab = "";

            if (widgetType == WidgetType.UUID
                    || widgetType == WidgetType.BUTTON
                    || widgetType == WidgetType.HIDE
                    || widgetType == WidgetType.INPUT) {
                continue;
            }

            Object strdef = "";
            if (defaultValue != null && !(defaultValue = defaultValue.trim()).isEmpty()) {
                if ((defaultValue.startsWith("{") && defaultValue.endsWith("}"))) {
                    strdef = getSingleValFromDBx(defaultValue);
                } else {
                    strdef = defaultValue;
                }
            }

            try {
                fparams += widgetIdentity + ",";
            } catch (Exception ec) {
            }

            if (isMandatory != null) {
                if (isMandatory) {
                    reqIndication = "*";
                    req = " required='required' ";
                }
            }

            if (widgetLabel != null) {
                reqlab = widgetLabel;
            }

            if (helpText == null) {
                helpText = reqlab;
            }

            String rrrrrr;
            if (reqIndication.equals("*")) {
                rrrrrr = "<span class='required-indicator'> " + reqlab + reqIndication + "</span>";
            } else {
                rrrrrr = reqlab;
            }

            fixedParameter += "<div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'><div class='form-group'>" + "<label for='" + reqlab + "'>" + rrrrrr + "</label>";

            if (widgetType == WidgetType.PASSWORD) {
                fixedParameter += "<input class='form-control' type='" + widgetType + "' name='" + widgetIdentity + "' id='" + widgetIdentity + "' value='" + strdef + "' " + req + "/>";
            } else if (widgetType == WidgetType.TEXT) {
                fixedParameter += "<input class='form-control' type='" + widgetType + "' name='" + widgetIdentity + "' id='" + widgetIdentity + "' value='" + strdef + "' " + req + "/>";
            } else if (widgetType == WidgetType.DATE) {
                fixedParameter += "<input class='form-control date' type='text' placeholder='DD/MM/YYYY' ";
                fixedParameter += " name='";
                fixedParameter += widgetIdentity;
                fixedParameter += "' id='";
                fixedParameter += widgetIdentity;
                fixedParameter += "' value='";
                fixedParameter += strdef;
                fixedParameter += "'/>";
            } else if (det_cmd != null) {

                if (widgetType == WidgetType.LIST) {

                    List<Map> optionList = getListFromDB(det_cmd, client);

                    System.out.println("optionList:" + optionList + "kkkkkkkkk:" + strdef);
                    String optSb = new String();
                    optSb += "<option value=''>Select</option>";

                    if (optionList != null) {
                        for (Map p : optionList) {
                            Object idx = p.get("id");
                            Object showx = p.get("show");

                            if ((strdef instanceof String && idx instanceof String && strdef.equals(idx))
                                    || (strdef instanceof String && idx instanceof Number && strdef.equals(idx + ""))
                                    || (strdef instanceof Number && idx instanceof String && idx.equals(strdef + ""))) {
                                optSb += "<option " + SELECTED + " value='" + idx + "'>" + showx + "</option>";
                            } else if (strdef instanceof Date && idx instanceof Date && strdef.equals(idx)) {
                                optSb += "<option " + SELECTED + " value='" + idx + "'>" + showx + "</option>";
                            } else if (strdef instanceof Number && idx instanceof Number && strdef.equals(idx)) {
                                optSb += "<option " + SELECTED + " value='" + idx + "'>" + showx + "</option>";
                            } else {
                                optSb += "<option value='" + idx + "'>" + showx + "</option>";
                            }
                        }
                    }

                    fixedParameter += "<Select class='form-control' name='" + widgetIdentity + "' id='" + widgetIdentity + "' " + req + ">" + optSb + "</select>";

                } else if (widgetType.equals(WidgetType.LIST_FIXED)) {
                    String optSb = new String();

                    optSb += "<option value='${null}'>Select One</option>";
                    String[] lstFixed = det_cmd.split(",");

                    for (String xxx : lstFixed) {

                        String kk = xxx;
                        String vv = xxx;

                        if (xxx.contains("~")) {
                            String[] tld = xxx.split("~");
                            kk = tld[0];
                            vv = tld[1];
                        }

                        if (strdef.equals(kk)) {
                            optSb += "<option " + SELECTED + " value='" + kk + "'>" + vv + "</option>";
                        } else {
                            optSb += "<option value='" + kk + "'>" + vv + "</option>";
                        }
                    }
                    fixedParameter += "<select class='form-control' name='" + widgetIdentity + "' id='" + widgetIdentity + "'>" + optSb + "</select>";
                }
            }
            fixedParameter += "</div></div>";
        }

        mapper.put("fixedParameter", fixedParameter);

        try {
            fparams = fparams.substring(0, fparams.length() - 1);
            mapper.put("fparams", fparams);
        } catch (Exception e) {
        }
    }

    //////////////////
    ///////////////////
    /////////////////
    public Map<String, String> getProcPageMap(final String processId, final AdmProcessService admProcMstService) {

        Map<String, String> objMap = new HashMap();

        //String query = "SELECT  COALESCE(A.DEFAULT_VAL,P.DEFAULT_VAL), UPPER(TRIM (COALESCE(A.WIDGET_IDENTITY,P.PARAM_NAME))) FROM ADM_PROC_DTL A,  ADM_PARAM P WHERE ADM_PROC_MST_ID = " + processId + " AND A.ADM_PARAM_ID =P.ID AND ADM_PARAM_ID IS NOT NULL AND A.IS_ACTIVE = 1 AND ZONE_TYPE = '" + ZoneType.SEARCH.toString() + "'  ORDER BY SL_NO ";
        //String query = "SELECT DEFAULT_VAL, WIDGET_IDENTITY FROM CALL_VU_ADM_PROC_DTL WHERE ADM_PROC_MST_ID = " + processId + " AND IS_ACTIVE = 1 AND ZONE_TYPE = '" + ZoneType.SEARCH + "' ORDER BY SL_NO";
        AdmProcess admProcess = null;
        try {
            admProcess = admProcMstService.findById(processId);
        } catch (Exception e) {
            System.out.println("err 849: " + e);
        }

        if (admProcess == null) {
            return objMap;
        }

        //ResultSet resultSet = statement.executeQuery("SELECT WIDGET_IDENTITY, WIDGET_TYPE  FROM CALL_VU_ADM_PROC_DTL WHERE ADM_PROC_MST_ID = " + processId + " AND IS_ACTIVE = 1 AND UPPER (TRIM (ZONE_TYPE))='PARAM_QU'  ORDER BY SL_NO");
        for (AdmProcessDetail admProcDtl : admProcess.getAdmProcessDetails()) {

            if (admProcDtl.getZoneType() != ZoneType.SEARCH || !admProcDtl.getAdmParam().getIsActive()) {
                continue;
            }
            String defaultValue = admProcDtl.getAdmParam().getDefaultVal();
            String widgetIdentity = admProcDtl.getAdmParam().getParamName();

            if (defaultValue != null && !(defaultValue = defaultValue.trim()).isEmpty()) {
                if (defaultValue.startsWith("{") && defaultValue.endsWith("}")) {
                    defaultValue = getSingleValFromDBx(defaultValue.trim());
                }
            }
            objMap.put(widgetIdentity, defaultValue);
        }

        decoProcPageMap(admProcess, objMap);

        return objMap;
    }

    public void decoProcPageMap(final AdmProcess admProcess, final Map<String, String> mapper) {

        String client = null;
        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (authUserObj instanceof MacUserDetail) {
            client = ((MacUserDetail) authUserObj).getClientId();
        }

        Map<String, String> searcherIdsx = new HashMap();
        String searchContent = "";
        String fixedParameter = "";
        String btner = "";
        String qparams = "";
        String fparams = "";

        for (AdmProcessDetail resultSet : admProcess.getAdmProcessDetails()) {

            ZoneType zoneType = resultSet.getZoneType();
            Boolean isMandatory = resultSet.getAdmParam().getIsMandatory();

            String widgetLabel = resultSet.getAdmParam().getTitle();
            String helpText = resultSet.getAdmParam().getHelpText();
            String defaultValue = resultSet.getAdmParam().getDefaultVal();
            WidgetType widgetType = resultSet.getAdmParam().getWidgetType();
            String det_cmd = resultSet.getAdmParam().getCmd();
            String widgetIdentity = resultSet.getAdmParam().getParamName();
            String reqIndication = "";
            String req = "";
            String reqlab = "";
            Object strdef = "";

            if (defaultValue != null && !(defaultValue = defaultValue.trim()).isEmpty()) {

                if ((defaultValue.startsWith("{") && defaultValue.endsWith("}"))) {
                    strdef = getSingleValFromDBx(defaultValue);
                } else {
                    strdef = defaultValue;
                }
            }

            String disable = "";

            try {
                if (zoneType == ZoneType.PARAM_FIXED) {
                    fparams += widgetIdentity + ",";
                }
            } catch (Exception ec) {
            }
            try {
                if (zoneType == ZoneType.PARAM_QU) {
                    qparams += widgetIdentity + ",";
                }
            } catch (Exception ec) {
            }

            if (isMandatory != null) {
                if (isMandatory) {
                    reqIndication = "*";
                    req = " required='required' ";
                } else {
                    disable = " disabled='disabled' ";
                }
            }

            if (widgetLabel != null) {
                reqlab = widgetLabel;
            }

            if (helpText == null) {
                helpText = reqlab;
            }

            String rrrrrr;
            if (reqIndication.equals("*")) {
                rrrrrr = "<span class='required-indicator'> " + reqlab + reqIndication + "</span>";
            } else {
                rrrrrr = reqlab;
            }

            if (zoneType == ZoneType.SEARCH && widgetType != null) {
                searcherIdsx.put(widgetIdentity, widgetType.name());
                searchContent += "<div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'><div class='form-group'>" + "<label for='" + reqlab + "'>" + "<span'>" + reqlab + reqIndication + "</span></label>";
            } else if (zoneType == ZoneType.PARAM_FIXED && widgetType != WidgetType.UUID) {// && !(widgetType.equals(WidgetType.QU_PARAM_INVISIBLE.toString()) || widgetType.equals(WidgetType.QU_PARAM_VISIBLE.toString()))) {
                fixedParameter += "<div class='col-xs-12 col-sm-6 col-md-6 col-lg-6'><div class='form-group'>" + "<label for='" + reqlab + "'>" + rrrrrr + "</label>";
            } else if (zoneType == ZoneType.PROCESS_BTN) {
                btner += "<button type='button' class='btn btn-warning' name='" + widgetIdentity + "' id='" + widgetIdentity + "' title='" + helpText + "' " + disable + " onclick='executeProcess(this.id)'> " + widgetLabel + "</button>";
            }

            if (widgetType == WidgetType.PASSWORD) {
                if (zoneType == ZoneType.SEARCH) {
                    searchContent += "<input class='form-control' type='" + widgetType + "' name='" + widgetIdentity + "' id='" + widgetIdentity + "' value='" + strdef + "' " + req + "/>";
                } else if (zoneType == ZoneType.PARAM_FIXED || zoneType == ZoneType.PARAM_QU) {
                    fixedParameter += "<input class='form-control' type='" + widgetType + "' name='" + widgetIdentity + "' id='" + widgetIdentity + "' value='" + strdef + "' " + req + "/>";
                }
            } else if (widgetType == WidgetType.TEXT) {
                if (zoneType == ZoneType.SEARCH) {
                    searchContent += "<input class='form-control' type='" + widgetType + "' name='" + widgetIdentity + "' id='" + widgetIdentity + "' value='" + strdef + "' " + req + "/>";
                } else if (zoneType == ZoneType.PARAM_FIXED || zoneType == ZoneType.PARAM_QU) {
                    fixedParameter += "<input class='form-control' type='" + widgetType + "' name='" + widgetIdentity + "' id='" + widgetIdentity + "' value='" + strdef + "' " + req + "/>";
                }
            } else if (widgetType == WidgetType.DATE) {
                if (zoneType == ZoneType.SEARCH) {
                    searchContent += "<input class='form-control date' type='text' placeholder='DD/MM/YYYY' ";
                    searchContent += "name='";
                    searchContent += widgetIdentity;
                    searchContent += "' id='";
                    searchContent += widgetIdentity;
                    searchContent += "' value='";
                    searchContent += strdef;
                    searchContent += "'/>";
                } else if (zoneType == ZoneType.PARAM_FIXED || zoneType == ZoneType.PARAM_QU) {
                    fixedParameter += "<input class='form-control date' type='text' placeholder='DD/MM/YYYY' ";
                    fixedParameter += " name='";
                    fixedParameter += widgetIdentity;
                    fixedParameter += "' id='";
                    fixedParameter += widgetIdentity;
                    fixedParameter += "' value='";
                    fixedParameter += strdef;
                    fixedParameter += "'/>";
                }
            } else if (det_cmd != null) {
                if (widgetType == WidgetType.LIST) {
                    List<Map> optionList = getListFromDB(det_cmd, client);

                    System.out.println("optionList:" + optionList + "kkkkkkkkk:" + strdef);
                    String optSb = new String();
                    optSb += "<option value=''>Select</option>";

                    if (optionList != null) {
                        for (Map p : optionList) {
                            Object idx = p.get("id");
                            Object showx = p.get("show");

                            if ((strdef instanceof String && idx instanceof String && strdef.equals(idx))
                                    || (strdef instanceof String && idx instanceof Number && strdef.equals(idx + ""))
                                    || (strdef instanceof Number && idx instanceof String && idx.equals(strdef + ""))) {
                                optSb += "<option " + SELECTED + " value='" + idx + "'>" + showx + "</option>";
                            } else if (strdef instanceof Date && idx instanceof Date && strdef.equals(idx)) {
                                optSb += "<option " + SELECTED + " value='" + idx + "'>" + showx + "</option>";
                            } else if (strdef instanceof Number && idx instanceof Number && strdef.equals(idx)) {
                                optSb += "<option " + SELECTED + " value='" + idx + "'>" + showx + "</option>";
                            } else {
                                optSb += "<option value='" + idx + "'>" + showx + "</option>";
                            }
                        }
                    }
                    if (zoneType.equals(ZoneType.SEARCH)) {
                        searchContent += "<Select class='form-control' name='" + widgetIdentity + "' id='" + widgetIdentity + "' " + req + ">" + optSb + "</select>";
                    } else if (zoneType.equals(ZoneType.PARAM_FIXED) || zoneType.equals(ZoneType.PARAM_QU)) {
                        fixedParameter += "<Select class='form-control' name='" + widgetIdentity + "' id='" + widgetIdentity + "' " + req + ">" + optSb + "</select>";
                    }
                } else if (widgetType.equals(WidgetType.LIST_FIXED)) {
                    String optSb = new String();
                    optSb += "<option value='${null}'>Select One</option>";
                    String[] lstFixed = det_cmd.split(",");

                    for (String xxx : lstFixed) {
                        String kk = xxx;
                        String vv = xxx;

                        if (xxx.contains("~")) {
                            String[] tld = xxx.split("~");
                            kk = tld[0];
                            vv = tld[1];
                        }

                        if (strdef.equals(kk)) {
                            optSb += "<option " + SELECTED + " value='" + kk + "'>" + vv + "</option>";
                        } else {
                            optSb += "<option value='" + kk + "'>" + vv + "</option>";
                        }
                    }

                    if (zoneType.equals(ZoneType.SEARCH)) {
                        searchContent += "<select class='form-control' name='" + widgetIdentity + "' id='" + widgetIdentity + "'>" + optSb + "</select>";
                    } else if (zoneType.equals(ZoneType.PARAM_FIXED) || zoneType.equals(ZoneType.PARAM_QU)) {
                        fixedParameter += "<select class='form-control' name='" + widgetIdentity + "' id='" + widgetIdentity + "'>" + optSb + "</select>";
                    }
                }
            }

            if (zoneType.equals(ZoneType.SEARCH)) {
                searchContent += "</div></div>";
            } else if (!fixedParameter.isEmpty() && (zoneType.equals(ZoneType.PARAM_FIXED) || zoneType.equals(ZoneType.PARAM_QU))) {
                fixedParameter += "</div></div>";
            }
        }


        if (!searchContent.isEmpty()) {
     searchContent = "<label for='searchParameter'>\n"
                    + "<span><h4><spring:message code='searchParameter' text='Search Parameter'/></h4></span>\n"
                    + "</label>\n"
                    + searchContent;
        }

        ObjectMapper objectMapper = new ObjectMapper();
        String searcherIdsxSTR = "";
        try {
            searcherIdsxSTR = objectMapper.writeValueAsString(searcherIdsx);
        } catch (Exception e) {
            e.printStackTrace();
        }

        mapper.put("searcherIds", searcherIdsxSTR);
        mapper.put("searchContent", searchContent);
        mapper.put("fixedParameter", fixedParameter);
        mapper.put("btner", btner);
        
        try {
            qparams = qparams.substring(0, qparams.length() - 1);
            mapper.put("qparams", qparams);
        } catch (Exception e) {
        }

        try {
            fparams = fparams.substring(0, fparams.length() - 1);
            mapper.put("fparams", fparams);
        } catch (Exception e) {
        }
    }

    public Map<String, String> getTableOnly(final String processId, final Map<String, Object> objMap, final AdmProcessService admProcessService) { //, String currSprId, String empId, String deptId) {

        Map<String, String> tblMap = new HashMap();
        String tableHead = new String();
        String tableRow = new String();
        String query = null;//getSingleValFromDB("SELECT CMD FROM ADM_PROC_MST WHERE ID = " + processId) + "";

        List<String> invisColParm = new ArrayList();
        List<String> inputColParm = new ArrayList();
        List<String> colParma = new ArrayList();

        try {
            AdmProcess statement = admProcessService.findById(processId);
            query = statement.getCmd();

            //ResultSet resultSet = statement.executeQuery("SELECT WIDGET_IDENTITY, WIDGET_TYPE  FROM CALL_VU_ADM_PROC_DTL WHERE ADM_PROC_MST_ID = " + processId + " AND IS_ACTIVE = 1 AND UPPER (TRIM (ZONE_TYPE))='PARAM_QU'  ORDER BY SL_NO");
            for (AdmProcessDetail resultSet : statement.getAdmProcessDetails()) {

                if (resultSet.getZoneType() == ZoneType.PARAM_QU) {
                    continue;
                }
                // String cmd = resultSet.getString("CMD");
                String widgetIdentity = resultSet.getAdmParam().getParamName();
                WidgetType widgetType = resultSet.getAdmParam().getWidgetType();

                colParma.add(widgetIdentity);

                if (widgetType.equals(WidgetType.HIDE)) {
                    invisColParm.add(widgetIdentity);
                } else if (widgetType.equals(WidgetType.INPUT)) {
                    inputColParm.add(widgetIdentity);
                }
            }
            //resultSet.close();
            //statement.close();
        } catch (Exception e) {
            System.out.println("MacDynamo Err 0149:" + invisColParm);
        }

        String hjhjhjh = query;
        for (String jkjk : objMap.keySet()) {

            Object vvv = objMap.get(jkjk);
            String orpn = "null";
            if (vvv != null) {

                if (vvv instanceof String) {
                    if (vvv.toString().trim().length() == 0) {
                        orpn = "null";
                    } else {
                        orpn = "'" + vvv + "'";
                    }
                } else if (vvv instanceof Date) {
                    // System.out.println("rrrrrrrrrrrrrrrr vvv"+((Date) vvv));
                    SimpleDateFormat klkl = new SimpleDateFormat("dd/MM/yyyy");
                    orpn = "TO_DATE('" + klkl.format((Date) vvv) + "','DDMMYYYY')";
                } else if (vvv instanceof Number) {
                    orpn = vvv + "";
                }
            }
            hjhjhjh = hjhjhjh.replaceAll(":" + jkjk, orpn);

        }
        //hjhjhjh = hjhjhjh.replaceAll(":P_CURR_USER_ID", userId.toString());

        DBCursor jjkk = dbS.getCollection(query).find();

//            tableHead += "<th><input type=\"checkbox\" id=\"checkAll\" name=\"checkAll\"  value=\"" + "" + "\"/></th>";
        tableHead += "<th>Select All<br> <input type='checkbox' id='checkAll'/> </th>";    //TODO:Changed by : SAIF.

        SortedSet<String> colAll = new TreeSet<>();

        //wrong way to get all col ned resulate
        while (jjkk.hasNext()) {
            DBObject colx = jjkk.next();
            colAll.addAll(colx.keySet());
        }

        for (String colx : colAll) {
            if (invisColParm.contains(colx)) {
                continue;
            }
            String tableHeadx = colx;

            tableHeadx = getInitCap(tableHeadx);
            tableHead += "<th>" + tableHeadx + "</th>";
        }

        int j = 1;
        jjkk = dbS.getCollection(query).find();
        while (jjkk.hasNext()) {

            DBObject colx = jjkk.next();

//                tableRow += "<tr>";
//                tableRow += "<td><input type=\"checkbox\" name=\"row." + j + "\" class=\"case\" value=\"row." + j + "\"/></td>";
//                tableRow += " <input type = \"hidden\" name=\"rowid." + j + "\" value=\"aaa\" />";
            tableRow
                    += "<tr>"
                    + "   <td class='center'>"
                    + "       <input type='checkbox' name='row." + j + "' class='checkBoxTouchAll' value='row." + j + "'/>"
                    + //                                "       <input type='hidden' name='rowid." + j + "' class='checkBoxTouchAll' value='aaa'/>" +
                    "   </td>";
            for (String colname : colAll) {

                String isHedn = "";
                String hdnOrtxt = "text";
                if (invisColParm.contains(colname)) {
                    isHedn = "style='display:none'";
                    hdnOrtxt = "hidden";
                }

                String ident = "";
                String valx = null;
                if (colParma.contains(colname)) {
                    ident = "id='" + colname + j + "'";
                    valx = " value='" + colx.get(colname) + "'";
                }

                if (inputColParm.contains(colname)) {
//                        tableRow += "<td " + isHedn + ">" + "<input " + ident + " type='" + hdnOrtxt + "'></input></td>";
                    tableRow += "<td " + isHedn + ">" + "<input " + ident + valx + " type='" + hdnOrtxt + "'></input></td>";
                } else if (valx != null) {
                    tableRow += "<td style=' display:none'>" + "<input " + ident + valx + " type='hidden'></input></td>";
                } else if (colname.toUpperCase().equals("URL")) {
//                                 tableRow += "<td " + isHedn + " " + ident +" >" + resultSet.getObject(colname) + "</td>";
                    String dd = "/" + colx.get(colname);
//                                String urlLink = "<a href='${request.contextPath}" + dd + "' target='_blank'>" + resultSet.getObject(colname) + "</a>";
                    String urlLink = "<a href='${request.contextPath}" + dd + "' target='_blank'>" + "Show Details" + "</a>";
                    tableRow += "<td " + isHedn + " " + ident + " >" + urlLink + "</td>";
                } else {
                    Object tdValue = colx.get(colname);
                    if (tdValue == null) {
                        tdValue = "";
                    }
                    tableRow += "<td " + isHedn + " " + ident + " >" + tdValue + "</td>";
                } //                        tableRow += "<td " + isHedn + ">" + "<input " + ident + " type='" + hdnOrtxt + "' value='" + resultSet.getObject(colname) + "'></input></td>";
            }
            tableRow += "</tr>";

            j++;
        }

        String dataTable = "<table id='example' class='dataListTable table-bordered table-striped table-hover' style='width:100%'> " + tableHead + tableRow + "</table>";

        tblMap.put("TOTAL_RECORD", Integer.toString(j - 1));
        tblMap.put("DATA_TABLE", dataTable);

        System.out.println("ttttttttttt1111:" + tblMap);
        return tblMap;
    }

    public String getInitCap(final String dfg) {
        String sss = "";
        String strUpper = dfg.toUpperCase();
        if (strUpper.contains("DOB") || strUpper.contains("DOJ")) {
            return strUpper;
        }

        if (dfg.contains("_")) {
            String hhhh[] = dfg.split("_");

            for (String jjj : hhhh) {
                jjj = jjj.trim();
                sss += getInitCapWhile(jjj) + " ";
            }
        } else {
            return getInitCapWhile(dfg);
        }

        sss = sss.trim();
        return sss;
    }

    public String getInitCapWhile(final String dfg) {
        if (dfg.length() >= 2) {
            return Character.toUpperCase(dfg.charAt(0)) + dfg.substring(1).toLowerCase();
        }
        return dfg;
    }
}
