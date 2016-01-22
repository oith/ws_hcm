package oith.ws.ctrl;

import oith.ws.ctrl.core._OithClientAuditController;
import oith.ws.exception.TrnscFmNotFoundException;
import oith.ws.service.TrnscFmService;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dom.hcm.def.os.op.Emp;
import oith.ws.dom.hcm.fm.AccountHeadFm;
import oith.ws.dom.hcm.fm.TrnscFm;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.NotLoggedInException;
import oith.ws.service.AccountHeadFmService;
import oith.ws.service.EmpService;
import oith.ws.util.StringToEmpConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/trnscFm")
public class TrnscFmController extends _OithClientAuditController {

    public static final String MODEL_ATTIRUTE = "trnscFm";
    public static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    public static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    public static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    public static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    public static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private TrnscFmService trnscFmService;
    @Autowired
    private AccountHeadFmService accountHeadFmService;
    @Autowired
    private EmpService empService;

    @InitBinder
    void registerConverters(WebDataBinder binder) {
        if (binder.getConversionService() instanceof GenericConversionService) {
            GenericConversionService conversionService = (GenericConversionService) binder.getConversionService();

            //conversionService.addConverter(new StringToAccountHeadFmConverter(accountHeadFmService));
            conversionService.addConverter(new StringToEmpConverter(empService));
        }
    }

//http://www.hotstar.com/tv/comedy-classes/1652/parde-ke-peeche/1000078428
    private void allComboSetup(ModelMap model) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

        List signs = Arrays.asList(TrnscFm.Sign.values());

        List emps = new LinkedList();
        for (Emp col : empService.findAll()) {
            emps.add(col);
        }

        List accountHeadFms = new LinkedList();
        for (AccountHeadFm col : accountHeadFmService.findAllByClient(client)) {
            accountHeadFms.add(col);
        }

        model.addAttribute("signs", signs);
        model.addAttribute("emps", emps);
        model.addAttribute("accountHeadFmOpposites", accountHeadFms);
        model.addAttribute("accountHeadFms", accountHeadFms);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        TrnscFm trnscFm = new TrnscFm(client);
        setUserParam(trnscFm, "create");
        model.addAttribute(MODEL_ATTIRUTE, trnscFm);
        allComboSetup(model);

        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid TrnscFm currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return ADD_FORM_VIEW;
        }

        TrnscFm trnscFm = trnscFmService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, trnscFm.getId());
        return "redirect:/" + SHOW_FORM_VIEW + "/" + trnscFm.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        TrnscFm trnscFm = trnscFmService.findById(id);

        if (trnscFm == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(INDEX);
        }
        allComboSetup(model);
        model.addAttribute(MODEL_ATTIRUTE, trnscFm);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid TrnscFm currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return EDIT_FORM_VIEW;
        }

        try {
            TrnscFm trnscFm = trnscFmService.update(currObject, "accountHeadFm,accountHeadFmOpposite,transDate,amount,emp,sign,code,narration");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, trnscFm.getId());
        } catch (TrnscFmNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<TrnscFm> trnscFms;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            trnscFms = trnscFmService.search(searchCriteria);
        } else {
            trnscFms = trnscFmService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, trnscFms);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.GET)
    public String list(ModelMap model) {
        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(5);

        List<TrnscFm> trnscFms = trnscFmService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, trnscFms);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/show/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        TrnscFm trnscFm = trnscFmService.findById(id);

        if (trnscFm == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(INDEX);
        }

        model.addAttribute(MODEL_ATTIRUTE, trnscFm);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            TrnscFm deleted = trnscFmService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (TrnscFmNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + LIST_VIEW;
    }

}
