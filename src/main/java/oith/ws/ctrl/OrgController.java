package oith.ws.ctrl;

import oith.ws.dom.core.OrgUnit;
import oith.ws.exception.OrgNotFoundException;
import oith.ws.service.OrgService;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dom.core.User;
import oith.ws.dom.hcm.pmis.Job;
import oith.ws.dto._SearchDTO;
import oith.ws.service.UserDetailsMac;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/org")
public class OrgController extends _OithAuditController {

    protected static final String MODEL_ATTIRUTE = "org";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private OrgService orgService;

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();
        User user = super.getUserService().findById(userId);

        model.addAttribute(MODEL_ATTIRUTE, new Job(user));
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid OrgUnit currObject, BindingResult bindingResult, RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            return ADD_FORM_VIEW;
        }

        OrgUnit org = orgService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, org.getId());
        return "redirect:/" + SHOW_FORM_VIEW + "/" + org.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        OrgUnit org = orgService.findById(id);

        if (org == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, org);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(@ModelAttribute(MODEL_ATTIRUTE) @Valid OrgUnit currObject,
            @PathVariable("id") String id,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            return EDIT_FORM_VIEW;
        }

        try {
            OrgUnit org = orgService.update(currObject);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, org.getId());
        } catch (OrgNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<OrgUnit> orgs;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            orgs = orgService.search(searchCriteria);
        } else {
            orgs = orgService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, orgs);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

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

        List<OrgUnit> orgs = orgService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, orgs);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/show/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        OrgUnit org = orgService.findById(id);

        if (org == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, org);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            OrgUnit deleted = orgService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (OrgNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + LIST_VIEW;
    }
}
