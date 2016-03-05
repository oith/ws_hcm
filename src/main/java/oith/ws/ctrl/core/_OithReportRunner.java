package oith.ws.ctrl.core;

//import com.jaspersoft.mongodb.MongoDbConnection;
import com.jaspersoft.mongodb.connection.MongoDbConnection;
import java.io.FileOutputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.JRProperties;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.Report;
import oith.ws.exception.NotLoggedInException;
import oith.ws.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
//@RequestMapping(value = "/reportRunner")
public class _OithReportRunner extends _OithClientAuditController {

    @Autowired
    private ReportService reportService;

    private void allComboSetup(ModelMap model) {
//        Client client = null;
//        try {
//            client = super.getLoggedClient();
//        } catch (NotLoggedInException e) {
//        }

        //List signs = Arrays.asList(TrnscFm.Sign.values());
        //List emps = new LinkedList();
        //for (Emp col : empService.findAll()) {
        //    emps.add(col);
        //}
        //List accountHeadFms = new LinkedList();
        //for (AccountHeadFm col : accountHeadFmService.findAllByClient(client)) {
        //    accountHeadFms.add(col);
        //}
        //model.addAttribute("signs", signs);
        //model.addAttribute("emps", emps);
        //model.addAttribute("accountHeadFmOpposites", accountHeadFms);
        //model.addAttribute("accountHeadFms", accountHeadFms);
    }

    public static void main(String[] args) {
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

    @RequestMapping(value = "/oithReportRunner", method = RequestMethod.POST)
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

        return "oithReportRunner";
    }

    @RequestMapping(value = "/oithReportRunner", method = RequestMethod.GET)
    public String create(ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute("reportGroups", Arrays.asList(Report.ReportGroup.values()));
        model.addAttribute("reports", reportService.findAllByClient(client));
        //allComboSetup(model);
        return "oithReportRunner";
    }

//    @RequestMapping(value = "/create", method = RequestMethod.POST)
//    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {
//
//        try {
//            super.save(currObject, attributes);
//        } catch (NotLoggedInException e) {
//            return REDIRECT_TO_LOGIN;
//        }
//
//        if (bindingResult.hasErrors()) {
//            allComboSetup(model);
//            return ADD_FORM_VIEW;
//        }
//
//        Post currObjectLocal = postService.create(currObject);
//        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());
//
//        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
//    }
//
//    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
//    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {
//
//        Client client;
//        try {
//            client = super.getLoggedClient();
//        } catch (NotLoggedInException e) {
//            return REDIRECT_TO_LOGIN;
//        }
//
//        try {
//            Post currObjectLocal = postService.findById(id, client);
//            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
//            allComboSetup(model);
//            return EDIT_FORM_VIEW;
//        } catch (PostNotFoundException ex) {
//            return NOT_FOUND;
//        } catch (InAppropriateClientException ex) {
//            return REDIRECT_TO_LOGIN;
//        }
//    }
}
