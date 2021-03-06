package oith.ws.ctrl.fin;

import java.util.ArrayList;
import java.util.EnumMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.validation.Valid;
import oith.ws.ctrl.core._OithClientAuditController;
import oith.ws.dom.core.Address;
import oith.ws.dom.core.AllEnum;
import oith.ws.dom.core.Client;
import oith.ws.dom.hcm.def.os.HcmObject;
import oith.ws.dom.hcm.def.os.HcmObjectType;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.HcmObjectNotFoundException;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/company")
public class CompanyController extends _OithClientAuditController {

    public static final String MODEL_ATTIRUTE = "company";
    public static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    public static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    public static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    public static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    public static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    public static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private org.springframework.context.MessageSource messageSource;

    @Autowired
    private oith.ws.service.HcmObjectService hcmObjectService;

    private void allComboSetup(ModelMap model, Locale locale) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

        Map<AllEnum.Country, String> countrys = new EnumMap(AllEnum.Country.class);
        for (AllEnum.Country col : AllEnum.Country.values()) {
            countrys.put(col, col.toString());
            //countrys.put(col, messageSource.getMessage("label.gender." + col.name(), null, locale));
        }
        model.addAttribute("countrys", countrys);

        Map<AllEnum.Language, String> languages = new EnumMap(AllEnum.Language.class);
        for (AllEnum.Language col : AllEnum.Language.values()) {
            languages.put(col, col.toString());
            //countrys.put(col, messageSource.getMessage("label.gender." + col.name(), null, locale));
        }
        model.addAttribute("languages", languages);

        Map<AllEnum.Currency, String> currencys = new EnumMap(AllEnum.Currency.class);
        for (AllEnum.Currency col : AllEnum.Currency.values()) {
            currencys.put(col, col.toString());
            //countrys.put(col, messageSource.getMessage("label.gender." + col.name(), null, locale));
        }
        model.addAttribute("currencys", currencys);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute(MODEL_ATTIRUTE, new HcmObject(client, HcmObject.AccountingUnitType.COMPANY));
        allComboSetup(model, locale);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid HcmObject currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            Locale locale) {

        try {
            super.save(currObject, attributes);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (UserNotFoundException ex) {
            return NOT_FOUND;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
            return ADD_FORM_VIEW;
        }

        HcmObject currObjectLocal = new HcmObject(currObject.getClient(), HcmObject.AccountingUnitType.COMPANY);

        currObject.setAddress(new Address("dsd", "fdsf", "dffds", "fsdff", "sdfds", AllEnum.Country.BGD));
        MacUtils.copyProperties(currObjectLocal, currObject, "auditor,code,name,nameSecondary,address,city,country,language,currency");

        currObjectLocal = hcmObjectService.create(currObjectLocal);

        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());
        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            HcmObject currObjectLocal = hcmObjectService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid HcmObject currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        }

        HcmObject currObjectReal;
        try {
            currObjectReal = hcmObjectService.findById(id, client);
            currObject.setAuditor(currObjectReal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (HcmObjectNotFoundException | UserNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            MacUtils.copyProperties(currObjectReal, currObject, "auditor,code,name,nameSecondary,address,city,country,language,currency");
            currObjectReal = hcmObjectService.update(currObjectReal);

            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObjectReal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectReal.getId();
        } catch (Exception e) {
            errorHandler(bindingResult, e);
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.GET)
    public String copy(@PathVariable("id") String id, ModelMap model, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            HcmObject currObjectLocal = hcmObjectService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.POST)
    public String copied(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid HcmObject currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        }

        HcmObject currObjectReal;
        try {
            currObjectReal = hcmObjectService.findById(id, client);
        } catch (InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            HcmObject currObjectLocal = new HcmObject(client, HcmObjectType.ACC_UNIT);
            MacUtils.copyProperties(currObjectLocal, currObject, currObjectReal, "auditor,code,name,accountingUnitType,nameSecondary,address,city,country,language,currency");
            currObjectLocal = hcmObjectService.create(currObjectLocal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_COPIED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (Exception e) {
            errorHandler(bindingResult, e);
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        }
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        String searchTerm = searchCriteria.getSearchTerm();
        List<HcmObject> companys;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            companys = hcmObjectService.search(searchCriteria, client, HcmObjectType.ACC_UNIT, HcmObject.AccountingUnitType.COMPANY);
        } else {
            companys = hcmObjectService.findAllByClient(searchCriteria, client, HcmObjectType.ACC_UNIT, HcmObject.AccountingUnitType.COMPANY);
        }
        model.addAttribute(MODEL_ATTRIBUTES, companys);
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

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<HcmObject> companys = hcmObjectService.findAllByClient(searchCriteria, client, HcmObjectType.ACC_UNIT, HcmObject.AccountingUnitType.COMPANY);

        model.addAttribute(MODEL_ATTRIBUTES, companys);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/show/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") String id, ModelMap model) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            HcmObject currObjectLocal = hcmObjectService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            HcmObject deleted = hcmObjectService.delete(id, client);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (HcmObjectNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
        return REDIRECT + "/" + LIST_VIEW;
    }

}
