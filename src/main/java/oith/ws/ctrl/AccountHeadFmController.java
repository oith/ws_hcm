package oith.ws.ctrl;

import oith.ws.exception.AccountHeadFmNotFoundException;
import oith.ws.service.AccountHeadFmService;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dom.hcm.fm.AccountHeadFm;
import oith.ws.dto._SearchDTO;
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
@RequestMapping(value = "/accountHeadFm")
public class AccountHeadFmController extends _OithAuditController {

    protected static final String MODEL_ATTIRUTE = "accountHeadFm";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private AccountHeadFmService accountHeadFmService;

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model) {
        model.addAttribute(MODEL_ATTIRUTE, new AccountHeadFm());
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid AccountHeadFm currObject,
            BindingResult bindingResult,
            RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            return ADD_FORM_VIEW;
        }

        try {
            super.doAuditInsert(currObject);
        } catch (Exception e) {
        }

        AccountHeadFm accountHeadFm = accountHeadFmService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, accountHeadFm.getId());
        return "redirect:/" + SHOW_FORM_VIEW + "/" + accountHeadFm.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        AccountHeadFm accountHeadFm = accountHeadFmService.findById(id);

        if (accountHeadFm == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, accountHeadFm);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(@PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid AccountHeadFm currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            return EDIT_FORM_VIEW;
        }

        try {
            super.doAuditUpdate(currObject);
        } catch (Exception e) {
        }
        try {
            AccountHeadFm accountHeadFm = accountHeadFmService.update(currObject, "active,empRequired,slNo,accNo,code,description,title,updateByUser,updateDate");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, accountHeadFm.getId());
        } catch (AccountHeadFmNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<AccountHeadFm> accountHeadFms;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            accountHeadFms = accountHeadFmService.search(searchCriteria);
        } else {
            accountHeadFms = accountHeadFmService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, accountHeadFms);
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

        List<AccountHeadFm> accountHeadFms = accountHeadFmService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, accountHeadFms);
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

        AccountHeadFm accountHeadFm = accountHeadFmService.findById(id);

        if (accountHeadFm == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, accountHeadFm);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            AccountHeadFm deleted = accountHeadFmService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (AccountHeadFmNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + LIST_VIEW;
    }
}
