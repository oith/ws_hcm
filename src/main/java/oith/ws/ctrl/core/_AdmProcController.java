package oith.ws.ctrl.core;

import com.mongodb.util.JSON;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import oith.ws.dom.core.AdmProcDtl;
import oith.ws.dom.core.AdmProcMst;
import oith.ws.dom.core.AllEnum;
import oith.ws.service.AdmProcMstService;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/_AdmProc")
class _AdmProcController {

    @Autowired
    AdmProcMstService admProcMstService;

    private String porcTitleNw;
    private Long runById = -1L;
    private Proc procObj;

    @RequestMapping(value = {"/indexProcess"}, method = RequestMethod.GET)
    public String index(ModelMap model, HttpServletRequest request) {

        List<AdmProcMst.ProcGroup> pgs = Arrays.asList(AdmProcMst.ProcGroup.values());// AdmProcMst.executeQuery("SELECT m FROM AdmProcMst m WHERE m.itemType='PG' AND m.isActive=true ORDER BY m.slNo, m.title");
        //List<AdmProcMst> kkx = ;// AdmProcMst.executeQuery("SELECT m FROM AdmProcMst m WHERE m.itemType='P' AND m.isActive=true ORDER BY m.parentAdmPermissible.slNo, m.parentAdmPermissible.title, m.slNo, m.title");
        List<AdmProcMst> kk = new ArrayList();

        for (AdmProcMst bbb : admProcMstService.findAll()) {
            AdmProcMst bbbm = new AdmProcMst();
            bbbm.setId(bbb.getId());
            bbbm.setTitle(bbb.getProcGroup() + "-" + bbb.getTitle());
            kk.add(bbbm);
        }

        model.addAttribute("processGroupMap", pgs);
        model.addAttribute("processMap", kk);
        return "indexProc";
    }

    @RequestMapping(value = "/getProcess/{processGroupId}", method = RequestMethod.GET)
    public @ResponseBody
    ResponseEntity<String> getProcess(@PathVariable("processGroupId") AdmProcMst.ProcGroup processGroupId) {

        System.out.println("finding getCodableDTO: code: " + processGroupId);

        StringBuilder sb = new StringBuilder();

        if (processGroupId == null) {
            for (AdmProcMst bbb : admProcMstService.findAll()) {
                sb.append("<option value='").append(bbb.getId()).append("'>").append(bbb.getProcGroup()).append('-').append(bbb).append("</option>");
            }
        } else {
            //List<AdmProcMst> mast = AAAAA;// AdmProcMst.executeQuery(selyaa + "AND m.parentAdmPermissible.id=" + processGroupId + " ORDER BY m.parentAdmPermissible.slNo, m.parentAdmPermissible.title, m.slNo, m.title");
            sb.append("<option value='/${null}'>Select One</option>");
            for (AdmProcMst bbb : admProcMstService.findAll()) {
                if (bbb.getProcGroup() == processGroupId) {
                    sb.append("<option value='").append(bbb.getId()).append("'>").append(bbb).append("</option>");
                }
            }
        }
        //final HttpHeaders headers = new HttpHeaders();
        //headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<>(sb.toString(), HttpStatus.CREATED);

    }

    @RequestMapping(value = "/getDynamicContent/{processId}", method = RequestMethod.GET)//produces = MediaType.APPLICATION_JSON_VALUE
    public @ResponseBody
    ResponseEntity<String> getDynamicContent(@PathVariable("processId") String processId) {

        System.out.println("finding getDynamicContent: code: " + processId);
        procObj = getProcObj();

        Map<String, String> allMap =null;

        if (procObj == null) {
             allMap = new HashMap();
            allMap.put("error", "Connection not found!!!");
        } else {
            allMap = procObj.getProcPageMap(processId, admProcMstService);

//            allMap.put("btner", "abc tj btner kfds");
//            allMap.put("paramer", "abc tj paramer kfds");
//            allMap.put("qparams", "abc tj qparams kfds");
//            allMap.put("searcher", "<div class=\"fieldcontain\" title=\"Enter Employee ID(s)\">\n"
//                    + "<label for=\"Employee ID(s)\">\n"
//                    + "<input id=\"P_EMP_CODES\" type=\"TEXT\" value=\"\" name=\"P_EMP_CODES\">\n"
//                    + "</div>");
//            allMap.put("searcher_btner", "<fieldset class=\"buttons\">\n"
//                    + "<button id=\"search\" class=\"save\" name=\"search\" type=\"button\" title=\"Press to Search\" onclick=\"getDynamicTable()\">Search</button>\n"
//                    + "</fieldset>");
        }

        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return new ResponseEntity<>(objectMapper.writeValueAsString(allMap), headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity<String> search( // @PathVariable("strKeyVal") String strKeyVal,
            // @PathVariable("processId") String processId
            @RequestParam String strKeyVal,
            @RequestParam String processId
    ) {

        System.out.println("finding search 789: code: " + processId);

        procObj = getProcObj();
        Map<String, String> allMap = new HashMap();
        Map<String, String> searcherIds = null;

        if (procObj == null) {
            allMap.put("error", "Connection not found!!!");
        } else {

//Query query = new Query();
//query.addCriteria(Criteria.where("name").is("Markus"));
//
//mongoTemplate.getCollection("");
//mongoOperations.findAll();
            allMap = procObj.getProcPageMap(processId, admProcMstService);
            String uuuu = allMap.get("searcherIds");

            Map user1 = null;
            try {
                ObjectMapper objectMapper = new ObjectMapper();
                user1 = objectMapper.readValue(uuuu, Map.class);
            } catch (Exception e) {
            }

            System.err.println("serchar 957 : " + user1 + " uuuu:" + uuuu);

            // objectMapper.
            searcherIds = new HashMap<>(user1);
//            searcherIds = (Map<String, String>) allMap.get("searcherIds");
        }

        Map<String, String> tblMap;
        Map c = (Map) JSON.parse(strKeyVal);
        Map<String, Object> cc = new HashMap(c);

        for (String kss : searcherIds.keySet()) {
            Object kv = searcherIds.get(kss);
            if (kv.equals("DATE")) {

                SimpleDateFormat klkl = new SimpleDateFormat("dd/MM/yyyy");
                Object vvv;
                try {
                    vvv = klkl.parse((String) cc.get(kss));
                } catch (Exception eee) {
                    vvv = null;
                }
                cc.put(kss, vvv);
            }
        }

        tblMap = procObj.getTableOnly(processId, cc, admProcMstService);

        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.TEXT_HTML);

        return new ResponseEntity<>(tblMap.toString(), headers, HttpStatus.CREATED);
    }

    @RequestMapping(value = {"/executeProcess/{strKeyVal}", "/executeProcess/{porcTitleMApx}", "/executeProcess/{processId}"}, method = RequestMethod.GET)
    public @ResponseBody
    ResponseEntity<String> executeProcess(
            @PathVariable("strKeyVal") String strKeyVal,
            @PathVariable("porcTitleMApx") String porcTitleMApx,
            @PathVariable("processId") String processId) {

        String errMsg = "";
        String errMsgShow = "";
        Map<String, String> outMsg = new HashMap();

        Map c = (Map) JSON.parse(strKeyVal);
        AdmProcMst admProcMst = null;

        try {
            admProcMst = admProcMstService.findById(processId);// AdmProcMst.executeQuery("FROM AdmProcMst a WHERE a.id=" + processId);
        } catch (Exception e) {
        }

        Map cothers = (Map) JSON.parse(porcTitleMApx);

        Map FIXED_PARAMs = (Map) cothers.get("FIXED_PARAM_VAL");

        System.out.println("kkkkkkkkkkkkk cothers:" + cothers);
        String QU_PARAMs = (String) cothers.get("QU_PARAM_VAL");
        String PROC_BTN_ID = (String) cothers.get("PROC_BTN_ID");

        List FIXED_PARAMs_sl_by = new ArrayList();
        String FIXED_PARAMs_sl_bySCRPT = "";
        List QU_PARAMs_sl_by = new ArrayList();

        if (!QU_PARAMs.equals("")) {
            try {
                for (Object jjj : QU_PARAMs.split(",")) {
                    QU_PARAMs_sl_by.add(jjj);
                }
            } catch (Exception ee) {
            }
        }

        System.out.println("kkkkkkkkkkkkk FIXED_PARAMs:" + FIXED_PARAMs);

        for (AdmProcDtl nnnx : admProcMst.getAdmProcDtls()) {

            String nnncmd = nnnx.getCmd();
            String nnnwidgetIdentity = nnnx.getWidgetIdentity();
            AllEnum.WidgetType nnnwidgetType = nnnx.getWidgetType();

            if (nnnx.getAdmParam() != null) {
                if (nnncmd == null || nnncmd.equalsIgnoreCase("SUPER")) {
                    nnncmd = nnnx.getAdmParam().getCmd();
                }
                if (nnnwidgetIdentity == null || nnnwidgetIdentity.equalsIgnoreCase("SUPER")) {
                    nnnwidgetIdentity = nnnx.getAdmParam().getParamName();
                }
                if (nnnwidgetType == null || nnnwidgetType == AllEnum.WidgetType.SUPER) {
                    nnnwidgetType = nnnx.getAdmParam().getParamType();
                }
            }

            if (nnnwidgetIdentity.equalsIgnoreCase(PROC_BTN_ID)) {
                porcTitleNw = nnncmd;
            }

            if (nnnx.getZoneType() == AllEnum.ZoneType.PARAM_FIXED) {

                System.out.println("kkkkkkkkkkkkk nnnwidgetIdentity:" + nnnwidgetIdentity + " nnnwidgetType: " + nnnwidgetType);
                if (66 == 66) {

                    try {
                        Object jjj = FIXED_PARAMs.get(nnnwidgetIdentity);
                        FIXED_PARAMs_sl_by.add(jjj);
                        if (jjj.toString().isEmpty()) {
                            FIXED_PARAMs_sl_bySCRPT += "null,";
                        } else {
                            FIXED_PARAMs_sl_bySCRPT += "'" + jjj + "',";
                        }
                    } catch (Exception ee) {
                        System.out.println("kkkkkkkkkkkkk" + ee);
                    }
                }
            }
        }

        System.out.println("jjjjj FIXED_PARAMs_sl_bySCRPT: " + FIXED_PARAMs_sl_bySCRPT);

        int countsPass = 0;
        int countsFail = 0;

        runById = -1L;//getCurrAdmUser().getId();

        String procLink = "<a href=" + " AdmProcMst.findById(processId)" + "" + " target='_blank'>Process Output Link</a><br>";

        if (admProcMst.getCmd() == null || admProcMst.getCmd().trim().isEmpty()) {

            if (11 == 11) {

                List lstObj = new ArrayList();

                lstObj.add(runById);

                lstObj.addAll(FIXED_PARAMs_sl_by);

                //lstObj.add(Sql.out(Sql.INTEGER.type));
                //lstObj.add(Sql.VARCHAR);
                try {

                    //	Thread th=new Thread(new Runnable(){
                    //	public void run(){
                    System.out.println("ibx-423 NO CMD MODE porcTitle: " + porcTitleNw + " param: " + lstObj);
//                    sql.call("{call " + porcTitleNw + "}",
//                            lstObj,
//                    {result1, result2 ->
//                        if (result1.toString().toInteger() == 1) {
//                            countsPass++
//                        }
//                    })
                    //	}
                    //	});
                    //th.start()

                } catch (Exception ex) {
                    countsFail++;

                    errMsgShow = errMsgShow + strErrOk(ex.toString()) + "<br>";
                    errMsg = errMsg + ex + "<br>";
                }

            }
            outMsg.put("errMsg", errMsgShow + "<br><br> Must be off: " + "<br>" + errMsg);

            outMsg.put("countsPass", countsPass + "");
            outMsg.put("countsFail", countsFail + "");
            outMsg.put("procOutLink", procLink);

            //render(outMsg as JSON);
            final HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.TEXT_HTML);
            return new ResponseEntity<>(outMsg.toString(), headers, HttpStatus.CREATED);
        } else {

            //Sql sql = new Sql(dataSource);
            for (Object obj : c.keySet()) {

                Map inrMapQu = (Map) c.get(obj);

                List lstObj = new ArrayList();

                lstObj.add(runById);
                lstObj.addAll(FIXED_PARAMs_sl_by);

                for (Object jkk : QU_PARAMs_sl_by) {
                    lstObj.add(inrMapQu.get(jkk));
                }

                //lstObj.add(Sql.out(Sql.INTEGER.type));
                //lstObj.add(Sql.VARCHAR);
                try {

                    //	Thread th=new Thread(new Runnable(){
                    //	public void run(){
                    System.out.println("ibx-423 porcTitle: " + porcTitleNw + " param: " + lstObj);
//                    sql.call("{call " + porcTitleNw + "}",
//                            lstObj,
//                    {result1, result2 ->
//                        if (result1.toString().toInteger() == 1) {
//                            countsPass++;
//                        }
//                    })
                    //	}
                    //	});
                    //th.start()

                } catch (Exception ex) {
                    countsFail++;

                    errMsgShow = errMsgShow + strErrOk(ex.toString()) + "<br>";
                    errMsg = errMsg + ex + "<br>";
                }
            }

            outMsg.put("errMsg", errMsgShow + "<br><br>Must be off: " + "<br>" + errMsg);

            outMsg.put("countsPass", countsPass + "");
            outMsg.put("countsFail", countsFail + "");
            outMsg.put("procOutLink", procLink);

            //  render(outMsg as JSON);
            final HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.TEXT_HTML);
            return new ResponseEntity<>(outMsg.toString(), headers, HttpStatus.CREATED);
        }
    }

    String strErrOk(String hhh) {
        try {
            int innx = hhh.indexOf(":", hhh.indexOf("ORA-"));
            int innb = hhh.indexOf("ORA-", innx);
            String sss = hhh.substring(innx + 2, innb - 1);
            return sss;
        } catch (Exception ee) {
            return "mac: ERR: " + ee + ": " + hhh;
        }
    }

    Proc getProcObj() {
        if (procObj == null) {
            procObj = new Proc();
        }
        return procObj;
    }
}
