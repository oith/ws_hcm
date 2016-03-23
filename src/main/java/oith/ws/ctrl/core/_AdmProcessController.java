package oith.ws.ctrl.core;

import com.mongodb.util.JSON;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import oith.ws.dom.core.AdmProcessDetail;
import oith.ws.dom.core.AdmProcess;
import oith.ws.dom.core.AllEnum;
import oith.ws.service.AdmProcessService;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/_AdmProcess")
class _AdmProcessController extends _OithClientAuditController {

    @Autowired
    private org.springframework.context.MessageSource messageSource;
    @Autowired
    private AdmProcessService admProcessService;

    private Proc procObj;

    @RequestMapping(value = {"/", "/indexProcess", ""}, method = RequestMethod.GET)
    public String indexProcess(ModelMap model, HttpServletRequest request) {

        List<AllEnum.Module> pgs = Arrays.asList(AllEnum.Module.values());// AdmProcess.executeQuery("SELECT m FROM AdmProcess m WHERE m.itemType='PG' AND m.isActive=true ORDER BY m.slNo, m.title");
        //List<AdmProcess> kkx = ;// AdmProcess.executeQuery("SELECT m FROM AdmProcess m WHERE m.itemType='P' AND m.isActive=true ORDER BY m.parentAdmPermissible.slNo, m.parentAdmPermissible.title, m.slNo, m.title");
        List<AdmProcess> kk = new ArrayList();

        for (AdmProcess bbb : admProcessService.findAll()) {
            AdmProcess bbbm = new AdmProcess();
            bbbm.setId(bbb.getId());
            bbbm.setTitle(bbb.getModule() + "-" + bbb.getTitle());
            kk.add(bbbm);
        }

        model.addAttribute("module", pgs);
        model.addAttribute("processMap", kk);
        return "_indexProcess";
    }

    @RequestMapping(value = "/getProcess", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
    public @ResponseBody
    ResponseEntity<String> getProcess(@RequestParam AllEnum.Module module, final Locale locale) {

        System.out.println("finding getCodableDTO: code: " + module);

        StringBuilder sb = new StringBuilder();
        String uuuu = messageSource.getMessage("default.select.null", null, locale);

        sb.append("<option value='/${null}'>").append(uuuu).append("</option>");

        if (module == null) {
            for (AdmProcess bbb : admProcessService.findAll()) {
                sb.append("<option value='").append(bbb.getId()).append("'>").append(bbb.getModule()).append('-').append(bbb).append("</option>");
            }
        } else {
            for (AdmProcess bbb : admProcessService.findAll()) {
                if (bbb.getModule() == module) {
                    sb.append("<option value='").append(bbb.getId()).append("'>").append(bbb).append("</option>");
                }
            }
        }
        //final HttpHeaders headers = new HttpHeaders();
        //headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<>(sb.toString(), HttpStatus.CREATED);
    }

    @RequestMapping(value = "/getDynamicContent", method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity<String> getDynamicContent(@RequestParam String processId) {

        System.out.println("finding getDynamicContent: code: " + processId);
        procObj = getProcObj();

        Map<String, String> allMap;

        if (procObj == null) {
            allMap = new HashMap();
            allMap.put("error", "Connection not found!!!");
        } else {
            allMap = procObj.getProcPageMap(processId, admProcessService);
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
    ResponseEntity<String> search(
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
            allMap = procObj.getProcPageMap(processId, admProcessService);
            String uuuu = allMap.get("searcherIds");

            Map user1 = null;
            try {
                ObjectMapper objectMapper = new ObjectMapper();
                user1 = objectMapper.readValue(uuuu, Map.class);
            } catch (Exception e) {
            }

            System.err.println("serchar 957 : " + user1 + " uuuu:" + uuuu);

            searcherIds = new HashMap<>(user1);
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

        tblMap = procObj.getTableOnly(processId, cc, admProcessService);

        // final HttpHeaders headers = new HttpHeaders();
        //headers.setContentType(MediaType.TEXT_HTML);
        // return new ResponseEntity<>(tblMap.toString(), headers, HttpStatus.CREATED);
        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return new ResponseEntity<>(objectMapper.writeValueAsString(tblMap), headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

    @RequestMapping(value = "/executeProcess", method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity<String> executeProcess(
            @RequestParam String strKeyVal,
            @RequestParam String porcTitleMApx,
            @RequestParam String processId) {

        System.out.println("uuuuuuuu 252pm chk strKeyVal:" + strKeyVal);
        System.out.println("uuuuuuuu 252pm chk porcTitleMApx:" + porcTitleMApx);
        System.out.println("uuuuuuuu 252pm chk processId:" + processId);

        String porcTitleNw = "";
        String errMsg = "";
        String errMsgShow = "";
        Map<String, String> outMsg = new HashMap();

        Map c = (Map) JSON.parse(strKeyVal);
        AdmProcess admProcMst = null;

        try {
            admProcMst = admProcessService.findById(processId);// AdmProcess.executeQuery("FROM AdmProcess a WHERE a.id=" + processId);
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
                QU_PARAMs_sl_by.addAll(Arrays.asList(QU_PARAMs.split(",")));
            } catch (Exception ee) {
            }
        }

        System.out.println("kkkkkkkkkkkkk FIXED_PARAMs:" + FIXED_PARAMs);

        for (AdmProcessDetail nnnx : admProcMst.getAdmProcessDetails()) {

            String nnncmd = nnnx.getAdmParam().getCmd();
            String nnnwidgetIdentity = nnnx.getAdmParam().getParamName();
            AllEnum.WidgetType nnnwidgetType = nnnx.getAdmParam().getWidgetType();

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

        long runById = -1L;//getCurrAdmUser().getId();

        String procLink = "<a href=" + " AdmProcess.findById(processId)" + "" + " target='_blank'>Process Output Link</a><br>";

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

        } else {

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
                    countsPass++;
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
        }

        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return new ResponseEntity<>(objectMapper.writeValueAsString(outMsg), headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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
