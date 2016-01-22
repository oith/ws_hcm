package oith.ws.ctrl.core;

import oith.ws.dom.core.Lookup;
import oith.ws.exception.LookupNotFoundException;
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.Valid;
import static oith.ws.ctrl.core._OithController.NOT_FOUND;
import oith.ws.dom.core.AllEnum;
import oith.ws.dom.core.Client;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/lookup")
public class LookupController extends _OithClientAuditController {

    public static final String MODEL_ATTIRUTE = "lookup";
    public static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    public static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    public static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    public static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    public static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    public static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private org.springframework.context.MessageSource messageSource;

    @Autowired
    private oith.ws.service.LookupService lookupService;

    private void allComboSetup(ModelMap model, Locale locale) {
        //Client client = null;
        //try {
        //    client = super.getLoggedClient();
        //} catch (NotLoggedInException e) {
        //}

        Map<Lookup.LookupKeyword, String> lookupKeywords = new EnumMap(Lookup.LookupKeyword.class);
        for (Lookup.LookupKeyword col : Lookup.LookupKeyword.values()) {
            lookupKeywords.put(col, messageSource.getMessage("label.lookup.lookupKeyword." + col.name(), null, locale));
        }
        model.addAttribute("lookupKeywords", lookupKeywords);

        //model.addAttribute("signs", Arrays.asList(TrnscFm.Sign.values()));
        //List emps = new LinkedList();
        //for (Emp col : empService.findAllByClient(client)) {
        //    emps.add(col);
        //}
        //model.addAttribute("emps", emps);
        //List accountHeadFms = new LinkedList();
        //for (AccountHeadFm col : accountHeadFmService.findAllByClient(client)) {
        //    accountHeadFms.add(col);
        //}
        //model.addAttribute("accountHeadFms", accountHeadFms);
        //model.addAttribute("accountHeadFmOpposites", accountHeadFms);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model, RedirectAttributes attributes, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute(MODEL_ATTIRUTE, new Lookup());
        allComboSetup(model, locale);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Lookup currObject, 
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

        Lookup currObjectLocal = lookupService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());

        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            Lookup currObjectLocal = lookupService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        } catch (LookupNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Lookup currObject,
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

        try {
            Lookup currObjectLocal = lookupService.findById(id, client);

            if (currObject.getVersion() != null && currObjectLocal.getVersion() != null && currObjectLocal.getVersion() > currObject.getVersion()) {
                bindingResult.addError(new ObjectError(bindingResult.getObjectName(), messageSource.getMessage("default.optimistic.locking.failure.edit", null, locale)));
                allComboSetup(model, locale);
                return EDIT_FORM_VIEW;
            }

            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (LookupNotFoundException ex) {
            return NOT_FOUND;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(LookupController.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            //lookup = lookupService.update(currObject);
            Lookup currObjectLocal = lookupService.update(currObject, "auditor,version,code,lookupKeyword,name,active,slNo,remarks");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (Exception e) {
            errorHandler(bindingResult, e);
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.GET)
    public String copy(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            Lookup currObjectLocal = lookupService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        } catch (LookupNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.POST)
    public String copied(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Lookup currObject,
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

        try {
            Lookup currObjectLocal = lookupService.findById(id, client);

            if (currObject.getVersion() != null && currObjectLocal.getVersion() != null && currObjectLocal.getVersion() > currObject.getVersion()) {
                bindingResult.addError(new ObjectError(bindingResult.getObjectName(), messageSource.getMessage("default.optimistic.locking.failure.copy", null, locale)));
                allComboSetup(model, locale);
                return EDIT_FORM_VIEW;
            }
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (LookupNotFoundException ex) {
            return NOT_FOUND;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(LookupController.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            Lookup currObjectLocal = new Lookup(client);
            MacUtils.copyProperties(currObjectLocal, currObject, "auditor,code,lookupKeyword,name,active,slNo,remarks");
            currObjectLocal = lookupService.create(currObjectLocal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_COPIED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (Exception e) {
            errorHandler(bindingResult, e);
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        }
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        String searchTerm = searchCriteria.getSearchTerm();
        List<Lookup> lookups;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            lookups = lookupService.search(searchCriteria, client);
        } else {
            lookups = lookupService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, lookups);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.GET)
    public String list(ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<Lookup> lookups = lookupService.findAllByClient(searchCriteria, client);

        model.addAttribute(MODEL_ATTRIBUTES, lookups);
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

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            Lookup currObjectLocal = lookupService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (LookupNotFoundException ex) {
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
            Lookup deleted = lookupService.delete(id, client);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (LookupNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
        return REDIRECT + "/" + LIST_VIEW;
    }
}
