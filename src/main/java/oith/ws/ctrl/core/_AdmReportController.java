package oith.ws.ctrl.core;

import com.jaspersoft.mongodb.connection.MongoDbConnection;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.JRProperties;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.AdmReport;
import oith.ws.dom.core.AllEnum;
import oith.ws.exception.NotLoggedInException;
import oith.ws.service.AdmReportService;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/_AdmReport")
public class _AdmReportController extends _OithClientAuditController {

    @Autowired
    private org.springframework.context.MessageSource messageSource;
    @Autowired
    private AdmReportService admReportService;

    private Proc procObj;

    @RequestMapping(value = {"/", "/indexReport", ""}, method = RequestMethod.GET)
    public String indexReport(ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        List<AllEnum.Module> pgs = Arrays.asList(AllEnum.Module.values());
        List<AdmReport> kk = new ArrayList();

        for (AdmReport bbb : admReportService.findAllByClient(client)) {
            AdmReport bbbm = new AdmReport();
            bbbm.setId(bbb.getId());
            bbbm.setTitle(bbb.getModule() + "-" + bbb.getTitle());
            kk.add(bbbm);
        }

        model.addAttribute("module", pgs);
        model.addAttribute("reportMap", kk);
        return "_indexReport";
    }

    @RequestMapping(value = {"/", "/indexReport", ""}, method = RequestMethod.POST)
    public String dddd(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        Map<String, Object> parameters = new HashMap<>();

        parameters.put("P_CLIENT_ID", client.getId());

        Enumeration<String> ghhh = request.getParameterNames();
        while (ghhh.hasMoreElements()) {
            String key = ghhh.nextElement();
            String val = request.getParameter(key);
            parameters.put(key, val);
        }

        System.out.println("parameters 1141: " + parameters);

        try {
            response.reset();

            MongoDbConnection connection = new MongoDbConnection("mongodb://localhost:27017/demodb", null, null);

            JRProperties.setProperty("net.sf.jasperreports.query.executer.factory.MongoDbQuery", "com.jaspersoft.mongodb.query.MongoDbQueryExecuterFactory");

            String hjjd = request.getContextPath();
            String hjjdx = request.getPathInfo();
            String hjjdxd = request.getServletPath();
            String hjj = request.getServletContext().getRealPath("/");
            System.out.println("1205 report getContextPath: " + hjjd + " getPathInfo: " + hjjdx + " getServletPath:" + hjjdxd + " realPath: " + hjj);

            String pp = "";

            boolean jjj = hjj.contains("/");
            if (jjj) {
                pp = "/";
            }
            jjj = hjj.contains("\\");
            if (jjj) {
                pp = "\\";
            }

            if (hjj.endsWith("/") || hjj.endsWith("\\")) {
                hjj = hjj + "reports" + pp;
            } else {
                hjj = hjj + pp + "reports" + pp;
            }

            System.out.println("452 reportpath: " + hjj + "");

            String reportName = request.getParameter("reportName");// "oith";

            if (request.getParameter("reportFormat").equals("XLS")) {
                parameters.put("IS_IGNORE_PAGINATION", Boolean.TRUE);
                //  reportDef = new JasperReportDef(name: admReportMaster.fileName, parameters: parameters, fileFormat: JasperExportFormat.XLS_FORMAT)
            } else {
                //  println("MAC pdf: ")
            }

            JasperPrint jasperPrint = JasperFillManager.fillReport(hjj + reportName + ".jasper", parameters, connection);
//            JasperPrint jasperPrint = JasperFillManager.fillReport("D:\\_OITH_OUTPUT\\oith_ws_web\\trunk\\src\\main\\webapp\\reports\\oith.jasper", parameters, connection);

            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "inline; filename=" + reportName + ".pdf");

            JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

            response.getOutputStream().flush();
            //allComboSetup(model);

        } catch (JRException | IOException e) {
            System.out.println("errr 678:" + e);
        }

        return "_indexReport";
    }

    @RequestMapping(value = "/getReport", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
    public @ResponseBody
    ResponseEntity<String> getReport(@RequestParam AllEnum.Module module, final Locale locale) {

        System.out.println("finding getCodableDTO: code: " + module);
        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return null;
        }

        StringBuilder sb = new StringBuilder();

        String uuuu = messageSource.getMessage("default.select.null", null, locale);

        sb.append("<option value='/${null}'>").append(uuuu).append("</option>");

        if (module == null) {
            for (AdmReport bbb : admReportService.findAllByClient(client)) {
                sb.append("<option value='").append(bbb.getId()).append("'>").append(bbb.getModule()).append('-').append(bbb).append("</option>");
            }
        } else {
            for (AdmReport bbb : admReportService.findAllByClient(client)) {
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
    ResponseEntity<String> getDynamicContent(@RequestParam String reportId) {

        System.out.println("finding getDynamicContent: code: " + reportId);
        procObj = getProcObj();

        Map<String, String> allMap;

        if (procObj == null) {
            allMap = new HashMap();
            allMap.put("error", "Connection not found!!!");
        } else {
            allMap = procObj.getReportPageMap(reportId, admReportService);

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

    public static void mainx(String[] args) {
        try (FileOutputStream arrayOutputStream = new FileOutputStream("D://qwe.pdf")) {

            Map<String, Object> parameters = new HashMap<>();

            JRProperties.setProperty("net.sf.jasperreports.query.executer.factory.MongoDbQuery", "com.jaspersoft.mongodb.query.MongoDbQueryExecuterFactory");

            MongoDbConnection connection = new MongoDbConnection("mongodb://localhost:27017/demodb", null, null);

            System.out.println("oooooooooo" + connection);
            JasperPrint jasperPrint = JasperFillManager.fillReport("D:\\_OITH_OUTPUT\\oith_ws_web\\trunk\\src\\main\\webapp\\reports\\oith.jasper", parameters, connection);
            System.out.println("kkkkkkwwwwwwwwwwwwwwww: " + jasperPrint.toString());
            JasperExportManager.exportReportToPdfStream(jasperPrint, arrayOutputStream);

        } catch (Exception e) {
            System.out.println("errrr:" + e);
        }
        System.out.println("done");

    }

    Proc getProcObj() {

        if (procObj == null) {
            procObj = new Proc();
        }
        return procObj;
    }
}
