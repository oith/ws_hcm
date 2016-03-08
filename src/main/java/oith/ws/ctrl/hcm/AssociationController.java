package oith.ws.ctrl.hcm;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dom.hcm.def.os.Association;
import oith.ws.dom.hcm.def.os.HcmObject;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.AssociationNotFoundException;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUtils;
import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/association")
public class AssociationController extends oith.ws.ctrl.core._OithClientAuditController {

    protected static final String MODEL_ATTIRUTE = "association";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private org.springframework.context.MessageSource messageSource;

    @Autowired
    private oith.ws.service.AssociationService associationService;

    @Autowired
    private oith.ws.service.HcmObjectService hcmObjectService;

    public class ExoticTypeEditor extends PropertyEditorSupport {

        @Override
        public void setAsText(String text) {

            HcmObject type = null;
            try {
                type = hcmObjectService.findById(text);
            } catch (Exception e) {
                System.out.println("iiiiii ttttt 1208 " + e);
            }
            setValue(type);
        }
    }

    @InitBinder
    void registerConverters(WebDataBinder binder) {
        binder.registerCustomEditor(HcmObject.class, "company", new ExoticTypeEditor());
    }

    private void allComboSetup(ModelMap model, Locale locale) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

        List hcmObjectAlphas = new LinkedList();
        for (HcmObject col : hcmObjectService.findAllByClient(client)) {
            col.setId(col.getId());
            hcmObjectAlphas.add(col);
        }
        model.addAttribute("hcmObjectAlphas", hcmObjectAlphas);

        List hcmObjectBetas = new LinkedList();
        for (HcmObject col : hcmObjectService.findAllByClient(client)) {
            col.setId(col.getId());
            hcmObjectBetas.add(col);
        }
        model.addAttribute("hcmObjectBetas", hcmObjectBetas);

        //Map<AllEnum.Gender, String> genders = new EnumMap(AllEnum.Gender.class);
        //for (AllEnum.Gender col : AllEnum.Gender.values()) {
        //    genders.put(col, messageSource.getMessage("label.gender." + col.name(), null, locale));
        //}
        //model.addAttribute("genders", genders);
        //
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
    public String create(ModelMap model, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute(MODEL_ATTIRUTE, new Association(client));
        allComboSetup(model, locale);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Association currObject,
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

        Association currObjectLocal = associationService.create(currObject);
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
            Association currObjectLocal = associationService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        } catch (AssociationNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Association currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            Locale locale) {

        String ddfd = ReflectionToStringBuilder.toString(currObject);
        System.out.println("1226 ddfd" + ddfd);

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
            Association currObjectLocal = associationService.findById(id, client);
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (AssociationNotFoundException | UserNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            Association currObjectLocal = associationService.update(currObject, "auditor,relTypeAlpha,hcmObjectAlpha,relTypeBeta,hcmObjectBeta,interval");
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
            Association currObjectLocal = associationService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        } catch (AssociationNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.POST)
    public String copied(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Association currObject,
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

        Association currObjectReal;
        try {
            currObjectReal = associationService.findById(id, client);
        } catch (InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (AssociationNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            Association currObjectLocal = new Association(client);
            MacUtils.copyProperties(currObjectLocal, currObject, currObjectReal, "auditor,code,hcmObjectAlpha,hcmObjectBeta,relType,interval");
            currObjectLocal = associationService.create(currObjectLocal);
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
        List<Association> associations;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            associations = associationService.search(searchCriteria, client);
        } else {
            associations = associationService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, associations);
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

        List<Association> associations = associationService.findAllByClient(searchCriteria, client);

        model.addAttribute(MODEL_ATTRIBUTES, associations);
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
            Association currObjectLocal = associationService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (AssociationNotFoundException ex) {
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
            Association deleted = associationService.delete(id, client);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (AssociationNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
        return REDIRECT + "/" + LIST_VIEW;
    }
}
