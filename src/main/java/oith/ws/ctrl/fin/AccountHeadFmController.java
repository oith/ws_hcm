package oith.ws.ctrl.fin;

import oith.ws.ctrl.core._OithClientAuditController;
import oith.ws.dom.hcm.fm.AccountHeadFm;
import oith.ws.exception.AccountHeadFmNotFoundException;
import oith.ws.service.AccountHeadFmService;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
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
public class AccountHeadFmController extends _OithClientAuditController {

    public static final String MODEL_ATTIRUTE = "accountHeadFm";
    public static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    public static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    public static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    public static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    public static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private AccountHeadFmService accountHeadFmService;

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        //   model.addAttribute("accountHeadFmKeywords", AccountHeadFm.AccountHeadFmKeyword.values());
        model.addAttribute(MODEL_ATTIRUTE, new AccountHeadFm(client));
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid AccountHeadFm currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        try {
            super.save(currObject, attributes);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(AccountHeadFmController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (bindingResult.hasErrors()) {
            //    model.addAttribute("accountHeadFmKeywords", AccountHeadFm.AccountHeadFmKeyword.values());
            return ADD_FORM_VIEW;
        }

        AccountHeadFm currObjectLocal = accountHeadFmService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());

        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            AccountHeadFm currObjectLocal = accountHeadFmService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return EDIT_FORM_VIEW;
        } catch (AccountHeadFmNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid AccountHeadFm currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            //         model.addAttribute("accountHeadFmKeywords", AccountHeadFm.AccountHeadFmKeyword.values());
            return EDIT_FORM_VIEW;
        }

        try {
            AccountHeadFm currObjectLocal = accountHeadFmService.findById(id, client);
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (AccountHeadFmNotFoundException ex) {
            return NOT_FOUND;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(AccountHeadFmController.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            //accountHeadFm = accountHeadFmService.update(currObject);
            AccountHeadFm currObjectLocal = accountHeadFmService.update(currObject, "accountNo,active,code,description,empRequired,slNo,title,auditor");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (AccountHeadFmNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return EDIT_FORM_VIEW;
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
        List<AccountHeadFm> accountHeadFms;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            accountHeadFms = accountHeadFmService.search(searchCriteria, client);
        } else {
            accountHeadFms = accountHeadFmService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, accountHeadFms);
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

        List<AccountHeadFm> accountHeadFms = accountHeadFmService.findAllByClient(searchCriteria, client);

        model.addAttribute(MODEL_ATTRIBUTES, accountHeadFms);
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
            AccountHeadFm currObjectLocal = accountHeadFmService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (AccountHeadFmNotFoundException ex) {
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
            AccountHeadFm deleted = accountHeadFmService.delete(id, client);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (AccountHeadFmNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
        return REDIRECT + "/" + LIST_VIEW;
    }

}
