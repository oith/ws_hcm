package oith.ws.ctrl;

import oith.ws.exception.OrgUnitNotFoundException;
import oith.ws.service.OrgUnitService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.validation.Valid;
import oith.ws.dom.core.User;
import oith.ws.dom.hcm.fm.AccountHeadFm;
import oith.ws.dom.hcm.pmis.OrgUnit;
import oith.ws.dto._SearchDTO;
import oith.ws.service.AccountHeadFmService;
import oith.ws.service.UserDetailsMac;
import oith.ws.service.UserService;
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
@RequestMapping(value = "/orgUnit")
public class OrgUnitController extends _OithAuditController {

    protected static final String MODEL_ATTIRUTE = "orgUnit";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private OrgUnitService orgUnitService;
    @Autowired
    private AccountHeadFmService accountHeadFmService;

    private Map<String, String> getAccountHeadFms() {

        Map<String, String> phones = new HashMap();

        for (AccountHeadFm col : accountHeadFmService.findAll()) {
            phones.put(col.getId(), col.getCode() + "-" + col.getTitle());
        }
//        phones.put("samsung", "SAMSUNG");
//        phones.put("nokia", "NOKIA");
//        phones.put("iphone", "IPHONE");
//        phones.put("bberry", "BLACKBERRY");
//        phones.put("htc", "HTC");

        return phones;
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();
        User user = userService.findById(userId);

        model.addAttribute(MODEL_ATTIRUTE, new OrgUnit(user));
        model.addAttribute("accountHeadFms", getAccountHeadFms());

        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid OrgUnit currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("accountHeadFms", getAccountHeadFms());
            return ADD_FORM_VIEW;
        }

        OrgUnit orgUnit = orgUnitService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, orgUnit.getId());
        return "redirect:/" + SHOW_FORM_VIEW + "/" + orgUnit.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        OrgUnit orgUnit = orgUnitService.findById(id);

        if (orgUnit == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute("accountHeadFms", getAccountHeadFms());
        model.addAttribute(MODEL_ATTIRUTE, orgUnit);

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
            OrgUnit orgUnit = orgUnitService.update(currObject);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, orgUnit.getId());
        } catch (OrgUnitNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<OrgUnit> orgUnits;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            orgUnits = orgUnitService.search(searchCriteria);
        } else {
            orgUnits = orgUnitService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, orgUnits);
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

        List<OrgUnit> orgUnits = orgUnitService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, orgUnits);
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

        OrgUnit orgUnit = orgUnitService.findById(id);

        if (orgUnit == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, orgUnit);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            OrgUnit deleted = orgUnitService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (OrgUnitNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + LIST_VIEW;
    }
}
