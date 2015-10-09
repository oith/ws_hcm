package oith.ws.ctrl;

import oith.ws.dom.core.Lookup;
import oith.ws.exception.LookupNotFoundException;
import oith.ws.service.LookupService;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dto._SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import oith.ws.exception.UserNotFoundException;

@Controller
//@RequestMapping(value = "/")
//@RequestMapping(value = "/lookup")
//@SessionAttributes("lookup")
public class LookupController extends _OithAuditController {

    protected static final String MODEL_ATTIRUTE = "lookup";
    protected static final String MODEL_ATTRIBUTES = "lookups";
    protected static final String ADD_FORM_VIEW = "lookup/create";
    protected static final String EDIT_FORM_VIEW = "lookup/edit";
    protected static final String SHOW_FORM_VIEW = "lookup/show";
    protected static final String LIST_VIEW = "lookup/index";

    @Autowired
    private LookupService lookupService;

    protected void setLookupService(LookupService lookupService) {
        this.lookupService = lookupService;
    }

    @RequestMapping(value = "/lookup/create", method = RequestMethod.GET)
    public String showCreateForm(ModelMap model, RedirectAttributes attributes) {
        Lookup lookup = new Lookup();
        model.addAttribute(MODEL_ATTIRUTE, lookup);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/lookup/create", method = RequestMethod.POST)
    public String submitCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid Lookup currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        try {
            doAuditInsert(currObject);
        } catch (UserNotFoundException ex) {
            System.out.println("No user object found with id: " + ex);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return ADD_FORM_VIEW;
        }

        if (bindingResult.hasErrors()) {
            return ADD_FORM_VIEW;
        }

        Lookup lookup = lookupService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, lookup.getId());

        return "redirect:/" + SHOW_FORM_VIEW + "/" + lookup.getId();
        //return "redirect:/" + SHOW_FORM_VIEW + "/" +"55d6a25c27b6656d500fe22f";
    }

    @RequestMapping(value = "/lookup/edit/{id}", method = RequestMethod.GET)
    public String showEditForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Lookup lookup = lookupService.findById(id);

        if (lookup == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, lookup);
        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/lookup/edit", method = RequestMethod.POST)
    public String submitEditForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid Lookup currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            return EDIT_FORM_VIEW;
        }

        try {
            doAuditUpdate(currObject);
        } catch (UserNotFoundException ex) {
            System.out.println("No user object found with id: " + ex);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return ADD_FORM_VIEW;
        }

        try {

            //lookup = lookupService.update(currObject);
            Lookup lookup = lookupService.update(currObject, "code,name,active,slNo,remarks,lookupKeyword,updateDate,updateByUser");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, lookup.getId());
            return "redirect:/" + SHOW_FORM_VIEW + "/" + lookup.getId();
        } catch (LookupNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return EDIT_FORM_VIEW;
        }
    }

    @RequestMapping(value = {"/lookup", "/lookup/index"}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<Lookup> lookups;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            lookups = lookupService.search(searchCriteria);
        } else {
            lookups = lookupService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, lookups);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"/lookup", "/lookup/index"}, method = RequestMethod.GET)
    public String showList(ModelMap model) {
        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(5);

        List<Lookup> lookups = lookupService.findAll(searchCriteria);

        System.out.println("showList:" + lookups);

        model.addAttribute(MODEL_ATTRIBUTES, lookups);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/lookup/show/{id}", method = RequestMethod.GET)
    public String showForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Lookup lookup = lookupService.findById(id);

        System.out.println("showForm:" + lookup);

        if (lookup == null) {

            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, lookup);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/lookup/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            Lookup deleted = lookupService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (LookupNotFoundException e) {

            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + LIST_VIEW;
    }

}
