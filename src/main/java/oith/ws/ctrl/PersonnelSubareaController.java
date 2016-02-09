package oith.ws.ctrl;

import oith.ws.dom.hcm.def.es.PersonnelSubarea;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dom.hcm.def.es.PersonnelArea;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.PersonnelSubareaNotFoundException;
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
@RequestMapping(value = "/personnelSubarea")
public class PersonnelSubareaController extends oith.ws.ctrl.core._OithClientAuditController {

    protected static final String MODEL_ATTIRUTE = "personnelSubarea";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private org.springframework.context.MessageSource messageSource;

    @Autowired
    private oith.ws.service.PersonnelSubareaService personnelSubareaService;

    @Autowired
    private oith.ws.service.PersonnelAreaService personnelAreaService;

    private void allComboSetup(ModelMap model, Locale locale) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

        List personnelAreas = new LinkedList();
        for (PersonnelArea col : personnelAreaService.findAllByClient(client)) {
            personnelAreas.add(col);
        }
        model.addAttribute("personnelAreas", personnelAreas);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute(MODEL_ATTIRUTE, new PersonnelSubarea(client));
        allComboSetup(model, locale);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid PersonnelSubarea currObject,
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

        PersonnelSubarea currObjectLocal = personnelSubareaService.create(currObject);
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
            PersonnelSubarea currObjectLocal = personnelSubareaService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        } catch (PersonnelSubareaNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid PersonnelSubarea currObject,
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
            PersonnelSubarea currObjectLocal = personnelSubareaService.findById(id, client);
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (PersonnelSubareaNotFoundException | UserNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            //personnelSubarea = personnelSubareaService.update(currObject);
            PersonnelSubarea currObjectLocal = personnelSubareaService.update(currObject, "auditor,code,name,personnelArea");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
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
            PersonnelSubarea currObjectLocal = personnelSubareaService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        } catch (PersonnelSubareaNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.POST)
    public String copied(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid PersonnelSubarea currObject,
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

        PersonnelSubarea currObjectReal;
        try {
            currObjectReal = personnelSubareaService.findById(id, client);
        } catch (InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (PersonnelSubareaNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            PersonnelSubarea currObjectLocal = new PersonnelSubarea(client);
            MacUtils.copyProperties(currObjectLocal, currObject, currObjectReal, "auditor,code,name,personnelArea");
            currObjectLocal = personnelSubareaService.create(currObjectLocal);
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
        List<PersonnelSubarea> personnelSubareas;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            personnelSubareas = personnelSubareaService.search(searchCriteria, client);
        } else {
            personnelSubareas = personnelSubareaService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, personnelSubareas);
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

        List<PersonnelSubarea> personnelSubareas = personnelSubareaService.findAllByClient(searchCriteria, client);

        model.addAttribute(MODEL_ATTRIBUTES, personnelSubareas);
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
            PersonnelSubarea currObjectLocal = personnelSubareaService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (PersonnelSubareaNotFoundException ex) {
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
            PersonnelSubarea deleted = personnelSubareaService.delete(id, client);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (PersonnelSubareaNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
        return REDIRECT + "/" + LIST_VIEW;
    }

}
