package oith.ws.ctrl.core;

//import com.jaspersoft.mongodb.MongoDbConnection;
import com.jaspersoft.mongodb.connection.MongoDbConnection;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.JRProperties;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.AdmReport;
import oith.ws.dom.core.AllEnum;
import oith.ws.exception.NotLoggedInException;
import oith.ws.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
    private ReportService reportService;

    @RequestMapping(value = "/indexReport", method = RequestMethod.GET)
    public String indexReport(ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        List<AllEnum.Module> pgs = Arrays.asList(AllEnum.Module.values());// AdmProcMst.executeQuery("SELECT m FROM AdmProcMst m WHERE m.itemType='PG' AND m.isActive=true ORDER BY m.slNo, m.title");
        //List<AdmProcMst> kkx = ;// AdmProcMst.executeQuery("SELECT m FROM AdmProcMst m WHERE m.itemType='P' AND m.isActive=true ORDER BY m.parentAdmPermissible.slNo, m.parentAdmPermissible.title, m.slNo, m.title");
        List<AdmReport> kk = new ArrayList();

        for (AdmReport bbb : reportService.findAllByClient(client)) {
            AdmReport bbbm = new AdmReport();
            bbbm.setId(bbb.getId());
            bbbm.setTitle(bbb.getModule()+ "-" + bbb.getTitle());
            kk.add(bbbm);
        }

        model.addAttribute("module", pgs);
        model.addAttribute("reportMap", kk);
        return "_indexReport";
    }

    @RequestMapping(value = "/getReport", method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity<String> getReport(@RequestParam AllEnum.Module module) {

        System.out.println("finding getCodableDTO: code: " + module);
        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return null;
        }
        
        StringBuilder sb = new StringBuilder();

        if (module == null) {
            for (AdmReport bbb : reportService.findAllByClient(client)) {
                sb.append("<option value='").append(bbb.getId()).append("'>").append(bbb.getModule()).append('-').append(bbb).append("</option>");
            }
        } else {
            //List<AdmProcMst> mast = AAAAA;// AdmProcMst.executeQuery(selyaa + "AND m.parentAdmPermissible.id=" + processGroupId + " ORDER BY m.parentAdmPermissible.slNo, m.parentAdmPermissible.title, m.slNo, m.title");
            sb.append("<option value='/${null}'>Select One</option>");
            for (AdmReport bbb : reportService.findAllByClient(client)) {
                if (bbb.getModule()== module) {
                    sb.append("<option value='").append(bbb.getId()).append("'>").append(bbb).append("</option>");
                }
            }
        }
        //final HttpHeaders headers = new HttpHeaders();
        //headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<>(sb.toString(), HttpStatus.CREATED);
    }

    @RequestMapping(value = "/execReport", method = RequestMethod.POST)
    public String dddd(ModelMap model, HttpServletResponse response) {

        try {
            response.reset();
            //MongoClient hhh = new MongoClient("mongodb://localhost:27017/db");

            //JasperCompileManager.compileReportToFile("D:\\_OITH_OUTPUT\\oith_ws_web\\trunk\\src\\main\\webapp\\reports\\oith.jrxml", "D:\\_OITH_OUTPUT\\oith_ws_web\\trunk\\src\\main\\webapp\\reports\\oith.jasper");
            Map<String, Object> parameters = new HashMap<>();

            MongoDbConnection connection = new MongoDbConnection("mongodb://localhost:27017/demodb", null, null);

            JRProperties.setProperty("net.sf.jasperreports.query.executer.factory.MongoDbQuery", "com.jaspersoft.mongodb.query.MongoDbQueryExecuterFactory");

            JasperPrint jasperPrint = JasperFillManager.fillReport("D:\\_OITH_OUTPUT\\oith_ws_web\\trunk\\src\\main\\webapp\\reports\\oith.jasper", parameters, connection);

            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "inline; filename=" + "ioioi" + ".pdf");

            JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

            response.getOutputStream().flush();
            //allComboSetup(model);

        } catch (Exception e) {
            System.out.println("errr 678:" + e);
        }

        return "_indexReport";
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
}
