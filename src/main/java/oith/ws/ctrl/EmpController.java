package oith.ws.ctrl;

import oith.ws.util.StringToProfileConverter;
import oith.ws.exception.EmpNotFoundException;
import oith.ws.service.EmpService;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dom.core.User;
import oith.ws.dom.core.hrm.om.Emp;
import oith.ws.dto._SearchDTO;
import oith.ws.service.ProfileService;
import oith.ws.service.MacUserDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.security.core.context.SecurityContextHolder;
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
@RequestMapping(value = "/emp")
public class EmpController extends _OithAuditController {

    protected static final String MODEL_ATTIRUTE = "emp";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private EmpService empService;

    @Autowired
    private ProfileService profileService;

    @InitBinder
    void registerConverters(WebDataBinder binder) {
        if (binder.getConversionService() instanceof GenericConversionService) {
            GenericConversionService conversionService = (GenericConversionService) binder.getConversionService();

            conversionService.addConverter(new StringToProfileConverter(profileService));
        }
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model) {

        MacUserDetail authUser = (MacUserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();
        User user = super.getUserService().findById(userId);

        //make profile query and add
        model.addAttribute(MODEL_ATTIRUTE, new Emp(user, null));
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid Emp currObject, BindingResult bindingResult, RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            return ADD_FORM_VIEW;
        }

        Emp emp = empService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, emp.getId());
        return "redirect:/" + SHOW_FORM_VIEW + "/" + emp.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Emp emp = empService.findById(id);

        if (emp == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, emp);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Emp currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            return EDIT_FORM_VIEW;
        }

        try {
            Emp emp = empService.update(currObject);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, emp.getId());
        } catch (EmpNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<Emp> emps;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            emps = empService.search(searchCriteria);
        } else {
            emps = empService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, emps);
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

        List<Emp> emps = empService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, emps);
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

        Emp emp = empService.findById(id);

        if (emp == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, emp);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            Emp deleted = empService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (EmpNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + LIST_VIEW;
    }
}
